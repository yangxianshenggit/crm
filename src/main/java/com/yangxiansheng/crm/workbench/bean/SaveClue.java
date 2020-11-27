package com.yangxiansheng.crm.workbench.bean;

import org.springframework.stereotype.Component;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.bean
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/21 0021 下午 19:47
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Component
public class SaveClue {
    private String fullname;
    private String owner;
    private String company;
    private String phone;
    private String mphone;
    private String state;
    private String source;

    @Override
    public String
    toString() {
        return "SaveClue{" +
                "fullname='" + fullname + '\'' +
                ", owner='" + owner + '\'' +
                ", company='" + company + '\'' +
                ", phone='" + phone + '\'' +
                ", mphone='" + mphone + '\'' +
                ", state='" + state + '\'' +
                ", source='" + source + '\'' +
                '}';
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getCompany() {
        return company;
    }

    public void setCompany(String company) {
        this.company = company;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getMphone() {
        return mphone;
    }

    public void setMphone(String mphone) {
        this.mphone = mphone;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }
}
