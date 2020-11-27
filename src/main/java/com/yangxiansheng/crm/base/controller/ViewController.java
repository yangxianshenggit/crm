package com.yangxiansheng.crm.base.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.io.File;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.base.controller
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/16 0016 下午 21:19
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Controller
public class ViewController {
    @RequestMapping({"/toView/{moduleName}/{viewName}",
            "/toView/{moduleName}/{moduleNextName}/{viewName}",
            "/toView/{moduleName}/{moduleNextName}/{moduleNextNextName}/{viewName}",
            "/toView/{viewName}"})
    public String toView(@PathVariable(required=false,value = "moduleName")String moduleName ,
                         @PathVariable(required = false,value = "moduleNextName")String moduleNextName,
                         @PathVariable(required = false,value = "moduleNextNextName")String moduleNextNextName,
                         @PathVariable("viewName")String viewName){
        if (moduleName==null){
            return viewName;
        }
        if (moduleName.equals("settings")){
            if(moduleNextName==null){
                return ".."+File.separator+moduleName+File.separator+viewName;
            }
            if (moduleNextNextName==null){
                return ".."+File.separator+moduleName+File.separator+moduleNextName+File.separator+viewName;
            }
            return ".."+File.separator+moduleName+File.separator+moduleNextName+File.separator+moduleNextNextName+File.separator+viewName;
        }else {
            return moduleName+ File.separator + viewName;
        }
    }
}
