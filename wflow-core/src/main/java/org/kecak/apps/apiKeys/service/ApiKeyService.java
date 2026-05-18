package org.kecak.apps.apiKeys.service;

import org.joget.workflow.model.service.WorkflowUserManager;
import org.json.JSONException;
import org.json.JSONObject;
import org.kecak.apps.apiKeys.dao.ApiKeyDao;
import org.kecak.apps.apiKeys.exception.ApiKeyServiceException;
import org.kecak.apps.apiKeys.model.ApiKey;
import org.kecak.apps.app.service.AuthTokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ApiKeyService {
    @Autowired
    private ApiKeyDao apiKeyDao;

    @Autowired
    private WorkflowUserManager workflowUserManager;

    @Autowired
    private AuthTokenService authTokenService;

    public void create(ApiKey apiKey) {
        assert apiKey != null : "apiKey is null";
        assert apiKey.getId() == null : "apiKey ID has to be null";
        assert apiKey.getRemark() != null : "apiKey Remark is null";
        assert apiKey.getApiKey() != null : "apiKey APIKey is null";
        assert apiKey.getImpersonates() != null : "apiKey Impersonates is null";

        final Date now = new Date();
        final String currUsername = workflowUserManager.getCurrentUsername();

        Map<String, Object> claims = new HashMap<>() {{
            put(ApiKeyService.class.getName(), true);
        }};

        String generatedKey = authTokenService.generateToken(apiKey.getImpersonates(), claims, apiKey.getValidUntil());
        apiKey.setApiKey(generatedKey);

        apiKey.setDateCreated(now);
        apiKey.setDateModified(now);
        apiKey.setCreatedBy(currUsername);
        apiKey.setModifiedBy(currUsername);

        apiKeyDao.save(apiKey);
    }

    public void edit(String id, String remark, Boolean active) throws ApiKeyServiceException {
        assert id != null && !id.isEmpty() : "API Key ID must not be null or empty";

        final Date now = new Date();
        final String currUsername = workflowUserManager.getCurrentUsername();
        final Optional<ApiKey> oldDataOpt = apiKeyDao.load(id);
        if (oldDataOpt.isPresent()) {
            final ApiKey oldData = oldDataOpt.get();
            oldData.setDateModified(now);
            oldData.setModifiedBy(currUsername);

            if(remark != null) oldData.setRemark(remark);
            if(active != null) oldData.setActive(active);

            apiKeyDao.save(oldData);
        } else {
            throw new ApiKeyServiceException("Invalid API Key ID: " + id);
        }
    }

    public boolean validateToken(String token) {
        Long count = apiKeyDao.count("WHERE apiKey = ? AND active = ?", new Object[]{ token, true });
        return count != null && count > 0;
    }

    public JSONObject toJson(ApiKey apiKey) throws JSONException {
        final JSONObject data = new JSONObject();
        data.put("id", apiKey.getId());
        data.put("apiKey", apiKey.getApiKey());
        data.put("impersonates", apiKey.getImpersonates());
        data.put("remark", apiKey.getRemark());
        data.put("active", apiKey.getActive());
        data.put("dateCreated", apiKey.getDateCreated());
        data.put("createdBy", apiKey.getCreatedBy());
        data.put("validUntil", apiKey.getValidUntil());
        return data;
    }
}
