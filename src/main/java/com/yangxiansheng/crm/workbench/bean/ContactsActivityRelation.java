package com.yangxiansheng.crm.workbench.bean;

import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.bean
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/23 0023 下午 21:08
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Table(name = "tbl_contacts_activity_relation")
@NameStyle(Style.normal)
public class ContactsActivityRelation {
    @Id
    private String id;
    private String contactsId;
    private String activityId;

    @Override
    public String toString() {
        return "ContactsActivityRelation{" +
                "id='" + id + '\'' +
                ", contactsId='" + contactsId + '\'' +
                ", activityId='" + activityId + '\'' +
                '}';
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getContactsId() {
        return contactsId;
    }

    public void setContactsId(String contactsId) {
        this.contactsId = contactsId;
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId;
    }
}
