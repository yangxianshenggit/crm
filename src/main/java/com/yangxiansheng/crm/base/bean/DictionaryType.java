package com.yangxiansheng.crm.base.bean;

import com.yangxiansheng.crm.settings.service.DictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
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
@Table(name = "tbl_dic_type")
@NameStyle(Style.normal)
public class DictionaryType {
    @Id
    private String code;
    private String name;
    private String description;
    private List<DictionaryValue> dictionaryValues;

    @Override
    public String toString() {
        return "DictionaryType{" +
                "code='" + code + '\'' +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", dictionaryValues=" + dictionaryValues +
                '}';
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<DictionaryValue> getDictionaryValues() {
        return dictionaryValues;
    }

    public void setDictionaryValues(List<DictionaryValue> dictionaryValues) {
        this.dictionaryValues = dictionaryValues;
    }
}
