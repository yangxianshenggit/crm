package com.yangxiansheng.crm.settings.service;

import com.yangxiansheng.crm.settings.bean.User;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.settings.service
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/16 0016 下午 18:47
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public interface UserService {
    //用户登录
    User userLogin(User user);
    //查询所有用户姓名和编号
    List<User> saveOwner();

}
