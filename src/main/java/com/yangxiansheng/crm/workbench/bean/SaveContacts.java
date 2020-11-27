package com.yangxiansheng.crm.workbench.bean;

import org.springframework.stereotype.Component;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.bean
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/24 0024 下午 19:43
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Component
public class SaveContacts {

    private String owner;
    private String contactsName;
    private String company;
    private String source;
    private String birth;

    @Override
    public String toString() {
        return "SaveContacts{" +
                "owner='" + owner + '\'' +
                ", contactsName='" + contactsName + '\'' +
                ", company='" + company + '\'' +
                ", source='" + source + '\'' +
                ", birth='" + birth + '\'' +
                '}';
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getContactsName() {
        return contactsName;
    }

    public void setContactsName(String contactsName) {
        this.contactsName = contactsName;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }
}
