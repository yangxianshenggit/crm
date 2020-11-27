package com.yangxiansheng.crm.settings.controller;

import com.yangxiansheng.crm.base.canstants.CrmConstansts;
import com.yangxiansheng.crm.settings.bean.User;
import com.yangxiansheng.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.settings.controller
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/16 0016 下午 18:47
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Controller
public class UserController {
    @Autowired
    private UserService userService;

    //用户登录
    @RequestMapping("/settings/userLogin")
    public String userLogin(HttpSession session, HttpServletRequest request, User user){
        //获取用户的IP地址
        String ip = request.getRemoteAddr();
        user.setAllowIps(ip);
        try{
            //用户登录
            user=userService.userLogin(user);
            //没报异常执行到这一行
            session.setAttribute(CrmConstansts.LOGIN_USER,user);
        }catch (Exception e){
            //登录失败，各种异常
            String mess = e.getMessage();
            request.setAttribute("mess",mess);
            //转发到登录页面
            return "../../login";
        }
        return "index";
    }
    //查询所有用户信息
    @RequestMapping("/settings/saveAllUser")
    @ResponseBody
    public List<User> saveAllUser(){
        List<User>list=userService.saveOwner();
        return list;
    }
}
