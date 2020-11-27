package com.yangxiansheng.crm.settings.service.impl;

import com.yangxiansheng.crm.base.bean.DictionaryType;
import com.yangxiansheng.crm.base.bean.DictionaryValue;
import com.yangxiansheng.crm.settings.mapper.DictionaryTypeMapper;
import com.yangxiansheng.crm.settings.mapper.DictionaryValueMapper;
import com.yangxiansheng.crm.settings.service.DictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.List;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.settings.service.impl
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/20 0020 下午 16:49
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Service("dictionaryService")
public class DictionaryServiceImpl implements DictionaryService {
    @Autowired
    private DictionaryTypeMapper dictionaryTypeMapper;
    @Autowired
    private DictionaryValueMapper dictionaryValueMapper;

    //查询字典所有的信息
    @Override
    public List<DictionaryType> saveAllDictionaryType() {
        List<DictionaryType> dictionaryTypes = dictionaryTypeMapper.selectAll();

        for (DictionaryType dictionaryType : dictionaryTypes) {
            Example example = new Example(DictionaryValue.class);
            //按orderNo进行升序排序
            example.setOrderByClause("orderNo");
            example.createCriteria().andEqualTo("typeCode", dictionaryType.getCode());
            List<DictionaryValue> dictionaryValues = dictionaryValueMapper.selectByExample(example);
            dictionaryType.setDictionaryValues(dictionaryValues);
        }
        return dictionaryTypes;
    }

}
