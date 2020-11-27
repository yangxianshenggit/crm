package com.yangxiansheng.crm.base.cache;

import com.yangxiansheng.crm.base.bean.DictionaryType;
import com.yangxiansheng.crm.settings.service.DictionaryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import java.util.*;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.base.cache
 * @Description: 内存类，将经常用轻易不更改的数据放入servletcontext对象中，随时用随时调
 * @Author: 杨先生
 * @CreateDate: 2020/11/21 0021 上午 11:58
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Component
public class Cache {
    @Autowired
    private DictionaryService dictionaryService;
    @Autowired
    private ServletContext servletContext;

    @PostConstruct
    public void start() {
        List<DictionaryType> dictionaryTypes = dictionaryService.saveAllDictionaryType();
        servletContext.setAttribute("dictionaryTypes", dictionaryTypes);
        //读取Stage2Possibility.properties    包名.属性文件(扩展名不能要)
        ResourceBundle bundle =
                ResourceBundle.getBundle("mybatis.Stage2Possibility");
        //获取所有的key
        Enumeration<String> keys = bundle.getKeys();
        //把所有阶段和可能性的数据放在map中
        Map<String,String>map=new HashMap<>();
        while (keys.hasMoreElements()){
            String key = keys.nextElement();//取出本次循环的数据
            String value = bundle.getString(key);
            map.put(key,value);
        }
        //将map放到servletContext中
        servletContext.setAttribute("stage2PossibilityMap",map);
    }
}
