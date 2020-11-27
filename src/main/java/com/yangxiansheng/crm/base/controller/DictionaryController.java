package com.yangxiansheng.crm.base.controller;

import com.yangxiansheng.crm.base.bean.DictionaryType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.base.controller
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/21 0021 下午 12:05
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@RestController//该注解作用该类中所有方法的返回值都是对象，可以不用在方法上写@ResponstBody
public class DictionaryController {
    //获取所有的数据字典信息
    @RequestMapping("/base/saveAllDictionary")
    public List<DictionaryType> saveAllDictionary(HttpSession session){
        ServletContext servletContext = session.getServletContext();
        List<DictionaryType> dictionaryTypes = (List<DictionaryType>) servletContext.getAttribute("dictionaryTypes");
        return dictionaryTypes;
    }
}
