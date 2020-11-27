package com.yangxiansheng.crm.base.bean;

import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.annotation.PostConstruct;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.servlet.ServletContext;
import java.util.List;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.settings.bean
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/20 0020 下午 16:45
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Table(name = "tbl_dic_value")
@NameStyle(Style.normal)
public class DictionaryValue {
    @Id
    private String id;
    private String value;
    private String text;
    private String orderNo;
    private String typeCode;

    @Override
    public String toString() {
        return "DictionaryValue{" +
                "id='" + id + '\'' +
                ", value='" + value + '\'' +
                ", text='" + text + '\'' +
                ", orderNo='" + orderNo + '\'' +
                ", typeCode='" + typeCode + '\'' +
                '}';
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }
}
