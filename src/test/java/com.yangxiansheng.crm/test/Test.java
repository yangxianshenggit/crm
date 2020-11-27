package com.yangxiansheng.crm.test;

import com.yangxiansheng.crm.base.util.MD5Util;
import com.yangxiansheng.crm.base.util.UUIDUtil;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.test
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/16 0016 下午 19:43
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public class Test {

    //测试UUID
    @org.junit.Test
    public void test01(){
        //生成32位的字符串
        String s = UUID.randomUUID().toString().replaceAll("-", "");
        System.out.println(s);
        String uuid = UUIDUtil.getUUID();
        System.out.println(uuid);
    }
    //测试时间比较
    @org.junit.Test
    public void test02(){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String format = simpleDateFormat.format(new Date());
        System.out.println(format);//2020-01-16 07:49:22
        //进行时间比较
        String time="2013-10-02 07:49:22";
        //经测试得出compareTo方法比较时间，当time大于系统时间返回负数，当time小于系统时间返回正数
        System.out.println(format.compareTo(time));
    }
    //MD5加密测试
    @org.junit.Test
    public void test03(){
        String admin = MD5Util.getMD5("admin");
        System.out.println(admin);
    }
}
