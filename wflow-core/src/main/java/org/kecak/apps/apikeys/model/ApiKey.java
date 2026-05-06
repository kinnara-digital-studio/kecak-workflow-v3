package org.kecak.apps.apikeys.model;

import java.io.Serializable;
import java.util.Date;

public class ApiKey implements Serializable {
    private String id;
    private Date dateCreated;
    private String createdBy;
    private String key;
    private String impersonates;
    private String remark;
    private Boolean active;
    private Date validUntil;

    public String getId() {
        return id;
    }

    public String getKey() {
        return key;
    }

    public String getRemark() {
        return remark;
    }

    public Date getDateCreated() {
        return dateCreated;
    }

    public boolean getActive() {
        return active != null && active;
    }

    public Date getValidUntil() {
        return validUntil;
    }

    public String getImpersonates() {
        return impersonates;
    }

    public String getCreatedBy() {
        return createdBy;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    public void setCreatedBy(String createdBy) {
        this.createdBy = createdBy;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public void setImpersonates(String impersonates) {
        this.impersonates = impersonates;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public void setValidUntil(Date validUntil) {
        this.validUntil = validUntil;
    }
}
