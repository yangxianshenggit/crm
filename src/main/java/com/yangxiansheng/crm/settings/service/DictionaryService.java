package com.yangxiansheng.crm.settings.service;

import com.yangxiansheng.crm.base.bean.DictionaryType;
import com.yangxiansheng.crm.base.bean.DictionaryValue;

import java.util.List;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.service
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/20 0020 下午 16:49
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public interface DictionaryService {
    //查询字典所有的信息
    List<DictionaryType> saveAllDictionaryType();

}
