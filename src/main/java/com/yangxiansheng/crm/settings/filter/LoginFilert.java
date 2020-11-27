package com.yangxiansheng.crm.settings.filter;

import com.yangxiansheng.crm.base.canstants.CrmConstansts;
import com.yangxiansheng.crm.settings.bean.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.settings.filter
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/27 0027 下午 16:58
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public class LoginFilert implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        StringBuffer requestURL = request.getRequestURL();
        if (requestURL.toString().contains("login")){
            return true;
        }
        User user = (User) request.getSession().getAttribute(CrmConstansts.LOGIN_USER);
        if (user!=null){
            return true;
        }
        response.sendRedirect("/crm/login.jsp");
        return false;
    }
}
