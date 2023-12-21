package org.kecak.apps.app.service;

import io.jsonwebtoken.*;
import io.jsonwebtoken.impl.DefaultClock;
import org.joget.commons.util.SetupManager;
import org.joget.directory.model.User;
import org.joget.workflow.model.service.WorkflowUserManager;

import javax.annotation.Nonnull;
import javax.annotation.Nullable;
import java.io.Serializable;
import java.util.*;
import java.util.function.Function;

public class AuthTokenService implements Serializable {
    transient
    private static final long serialVersionUID = -3301605591108950415L;
    private Clock clock = DefaultClock.INSTANCE;


    private SetupManager setupManager;

    private final static String DEFAULT_SECRET = "It's not secure to use default key";
    private static final String ISSUER = "org.kecak";

    @Nonnull private final String secret;

    private final Long expiration = 600L;
    private final Long expirationRefreshToken = 300L;

    public AuthTokenService(SetupManager setupManager) {
        this.setupManager = setupManager;

        String masterPassword = setupManager.getSettingValue(SetupManager.MASTER_LOGIN_PASSWORD);
        secret = Optional.ofNullable(masterPassword).filter(s -> !s.isEmpty()).orElse(DEFAULT_SECRET);
    }

    public String getUsernameFromToken(String token) throws ExpiredJwtException {
        return getClaimFromToken(token, Claims::getSubject);
    }

    public Date getIssuedAtDateFromToken(String token) throws ExpiredJwtException {
        return getClaimFromToken(token, Claims::getIssuedAt);
    }

    @Nullable
    public Date getExpirationDateFromToken(String token) throws ExpiredJwtException {
        return getClaimFromToken(token, Claims::getExpiration);
    }

    @Nullable
    public Object getClaimDataFromToken(String token, final String key) throws ExpiredJwtException {
        return getClaimFromToken(token, c -> c.get(key));
    }

    @Nullable
    public <T> T getClaimDataFromToken(String token, final String key, final Class<T> aClass) throws ExpiredJwtException {
        return getClaimFromToken(token, c -> c.get(key, aClass));
    }

    protected <T> T getClaimFromToken(String token, Function<Claims, T> claimsResolver) throws ExpiredJwtException {
        final Claims claims = getClaims(token);
        return claimsResolver.apply(claims);
    }

    /**
     * Get All Claims as map
     * @param token
     * @return map
     * @throws ExpiredJwtException
     */
    public Claims getClaims(String token) throws ExpiredJwtException {
        return Jwts.parser()
                .setSigningKey(getSecret())
                .parseClaimsJws(token)
                .getBody();
    }

    private Boolean isTokenExpired(String token) throws ExpiredJwtException {
        @Nullable Date expiration = getExpirationDateFromToken(token);
        return Optional.ofNullable(expiration)
                .map(d -> d.before(clock.now()))
                .orElse(false);
    }

    private Boolean isCreatedBeforeLastPasswordReset(Date created, Date lastPasswordReset) {
        return (lastPasswordReset != null && created.before(lastPasswordReset));
    }

    private Boolean ignoreTokenExpiration(String token) {
        // here you specify tokens, for that the expiration is ignored
        return false;
    }

    public String generateToken(String username) {
        return generateToken(username, null);
    }

    public String generateToken(String username, Map<String, Object> claims) {
        return doGenerateToken(Optional.ofNullable(claims).orElseGet(HashMap::new), Optional.ofNullable(username).orElse(WorkflowUserManager.ROLE_ANONYMOUS));
    }

    public String generateToken(String username, Map<String, Object> claims, int expiresInMinutes) {
        return doGenerateToken(Optional.ofNullable(claims).orElseGet(HashMap::new), Optional.ofNullable(username).orElse(WorkflowUserManager.ROLE_ANONYMOUS), expiresInMinutes);
    }

    protected String doGenerateToken(@Nonnull Map<String, Object> claims, @Nonnull String subject) {
        final Date createdDate = clock.now();
        return Jwts.builder()
                .setClaims(claims)
                .setId(UUID.randomUUID().toString())
                .setSubject(subject)
                .setIssuer(ISSUER)
                .setIssuedAt(createdDate)
                .signWith(SignatureAlgorithm.HS512, getSecret())
                .compact();
    }

    protected String doGenerateToken(@Nonnull Map<String, Object> claims, @Nonnull String subject, int expiresInMinutes) {
        final Date createdDate = clock.now();
        final Date expirationDate = calculateExpirationDate(createdDate, expiresInMinutes);
        return Jwts.builder()
                .setClaims(claims)
                .setId(UUID.randomUUID().toString())
                .setSubject(subject)
                .setIssuer(ISSUER)
                .setIssuedAt(createdDate)
                .setExpiration(expirationDate)
                .signWith(SignatureAlgorithm.HS512, getSecret())
                .compact();
    }

    public String generateRefreshToken(String tokenOldId, String subject) {
        final Date createdDate = clock.now();
        final Date expirationDate = calculateExpDateRefToken(createdDate);
        Map<String, Object> claims = new HashMap<>();
        claims.put("old_id", tokenOldId);
        return doGenerateToken(claims, subject);
    }

    public Boolean canTokenBeRefreshed(String token, Date lastPasswordReset) throws ExpiredJwtException {
        final Date created = getIssuedAtDateFromToken(token);
        return !isCreatedBeforeLastPasswordReset(created, lastPasswordReset)
                && (!isTokenExpired(token) || ignoreTokenExpiration(token));
    }

    public String refreshToken(String token, String refToken) throws Exception {
        final Date createdDate = clock.now();
        final Date expirationDate = calculateExpirationDate(createdDate);
        try {
            getClaims(token);
            throw new Exception("Claims not expired");
        } catch(ExpiredJwtException e) {
            final Claims claims = e.getClaims();
            Claims refClaims = getClaims(refToken);
            if(claims.getId().equals(refClaims.get("old_id"))) {
                claims.setIssuedAt(createdDate);
                claims.setExpiration(expirationDate);
                return doGenerateToken(claims, claims.getSubject());
            } else {
                throw new Exception("Invalid token/refresh token");
            }
        }
    }

    public Boolean validateToken(String token, User user) throws ExpiredJwtException {
        final String username = getUsernameFromToken(token);
        final Date created = getIssuedAtDateFromToken(token);

        //final Date expiration = getExpirationDateFromToken(token);
        return (user != null && username.equals(user.getUsername()) && !isTokenExpired(token));
    }

    @Nonnull
    protected Date calculateExpDateRefToken(Date createdDate) {
        return new Date(createdDate.getTime() + expirationRefreshToken * 1000);
    }

    protected Date calculateExpirationDate(Date createdDate) {
        return calculateExpirationDate(createdDate, 60);
    }

    @Nonnull
    protected Date calculateExpirationDate(Date createdDate, int minutes) {
        Calendar calendar = Calendar.getInstance();
        calendar.setTime(createdDate);
        calendar.add(Calendar.MINUTE, minutes);
        return calendar.getTime();
    }

    @Nonnull
    public String getSecret() {
        return secret;
    }

    public void setSetupManager(SetupManager setupManager) {
        this.setupManager = setupManager;
    }
}