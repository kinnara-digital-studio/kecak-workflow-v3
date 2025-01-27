package org.joget.commons.util;

import org.joget.commons.spring.model.AbstractSpringDao;
import org.joget.commons.spring.model.Setting;
import java.io.Serializable;
import java.util.Collection;
import org.hibernate.StaleStateException;

public class SetupDao extends AbstractSpringDao {

    public static final String ENTITY_NAME = "Setting";

    public Long count(String condition, Object[] params) {
        return super.count(ENTITY_NAME, condition, params);
    }

    public void delete(Object obj) {
        super.delete(ENTITY_NAME, obj);
    }

    public Object load(String id) {
        return super.find(ENTITY_NAME, id);
    }

    public Collection<Setting> find(String condition, Object[] params, String sort, Boolean desc, Integer start, Integer rows) {
        return (Collection<Setting>) super.find(ENTITY_NAME, condition, params, sort, desc, start, rows);
    }

    public Serializable save(Object obj) {
        return super.save(ENTITY_NAME, obj);
    }

    public void saveOrUpdate(Object obj) {
        try {
            super.saveOrUpdate(ENTITY_NAME, obj);
        } catch (StaleStateException e) {
            //ignore exception when trying to update a setting which deleted by another cluster node 
            if (!e.getMessage().equals("Batch update returned unexpected row count from update [0]; actual row count: 0; expected: 1")) {
                throw e;
            }
        }
    }
}
