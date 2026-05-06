package org.kecak.apps.apikeys.dao;

import org.joget.commons.spring.model.AbstractSpringDao;
import org.kecak.apps.apikeys.model.ApiKey;
import org.springframework.transaction.annotation.Transactional;

import java.util.Collection;
import java.util.Optional;

@Transactionalchoices
public class ApiKeyDao extends AbstractSpringDao<ApiKey> {
    public static final String ENTITY_NAME = "ApiKey";

    public void save(ApiKey apiKey) {
        super.saveOrUpdate(ENTITY_NAME, apiKey);
    }

    public Long count(String condition, Object[] params) {
        return super.count(ENTITY_NAME, condition, params);
    }

    public Collection<ApiKey> find(String condition, Object[] params, String sort, Boolean desc, Integer start, Integer rows) {
        return super.find(ENTITY_NAME, condition, params, sort, desc, start, rows);
    }

    public Optional<ApiKey> load(String id) {
        Collection<ApiKey> list = find("WHERE id = ?", new Object[]{ id }, null, null, null, 1);
        return Optional.ofNullable(list)
                .stream()
                .flatMap(Collection::stream)
                .findFirst();
    }

    public void delete(ApiKey apiKey) {
        super.delete(ENTITY_NAME, apiKey);
    }
}
