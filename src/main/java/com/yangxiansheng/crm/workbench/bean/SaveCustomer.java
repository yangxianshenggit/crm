package com.yangxiansheng.crm.workbench.bean;

import org.springframework.stereotype.Component;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.bean
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/19 0019 下午 21:31
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Component
public class SaveCustomer {
    private String name;
    private String owner;
    private String phone;
    private String website;

    @Override
    public String toString() {
        return "SaveCustomer{" +
                "name='" + name + '\'' +
                ", owner='" + owner + '\'' +
                ", phone='" + phone + '\'' +
                ", website='" + website + '\'' +
                '}';
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }
}
