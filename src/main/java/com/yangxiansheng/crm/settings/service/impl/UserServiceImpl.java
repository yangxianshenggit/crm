package com.yangxiansheng.crm.settings.service.impl;

import com.yangxiansheng.crm.base.canstants.CrmExceptionEnum;
import com.yangxiansheng.crm.base.exception.CrmException;
import com.yangxiansheng.crm.base.util.DateTimeUtil;
import com.yangxiansheng.crm.base.util.MD5Util;
import com.yangxiansheng.crm.settings.bean.User;
import com.yangxiansheng.crm.settings.mapper.UserMapper;
import com.yangxiansheng.crm.settings.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.settings.service.impl
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/16 0016 下午 18:48
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Service("userService")
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    //用户登录
    @Override
    public User userLogin(User user) {
        //获取用户登录的ip地址
        String ip = user.getAllowIps();
        System.out.println(ip);
        //将ip设为null，避免参与查询,成为查询条件
        user.setAllowIps(null);
        //数据库不是明文存储密码，进行md5加盐加密
        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));
        //单表查询，运用tkmapper
        user = userMapper.selectOne(user);
        //user==null用户名或密码不正确
        if (user == null) {
            //为降低耦合度，提高程序可维护性，采取自定义异常
            throw new CrmException(CrmExceptionEnum.LOGIN_ACCOUNT_ERROR);
        }
        //失效时间：失效时间为空的时候表示永不失效,失效时间大于当前系统时间则未失效
        //String类中compareTo方法比较时间，当用户的失效时间大于系统时间返回负数，当失效时间小于系统时间返回正数
        if (DateTimeUtil.getSysTime().compareTo(user.getExpireTime()) > 0) {
            //比较结果为正数，用户的失效时间小于当前系统时间，该账号已失效
            throw new CrmException(CrmExceptionEnum.LOGIN_ACCOUNT_EXPIRE);
        }
        //看用户是否被锁定，锁定状态为空时表示永久启用，为0时表示锁定，为1时表示启用。
        if ("0".equals(user.getLockState())) {
            //user.getLockState()为"0",说明用户被锁定
            throw new CrmException(CrmExceptionEnum.LOGIN_ACCOUNT_FORBID);
        }
        //允许访问的IP为空时表示IP地址永不受限，允许访问的IP可以是一个，也可以是多个，当多个IP地址的时候，采用半角逗号分隔。
        if (user.getAllowIps() != null) {
            //String类中的contains方法可以看当前字符串中是否包含指定字符串
            if (!user.getAllowIps().contains(ip)) {
                //不包含，用户IP地址受限
                throw new CrmException(CrmExceptionEnum.LOGIN_ACCOUNT_IP);
            }
        }
        //用户登录成功
        return user;
    }
    //查询所有用户姓名和编号
    @Override
    public List<User> saveOwner() {
        return userMapper.selectAll();
    }
}
