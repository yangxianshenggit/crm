package com.yangxiansheng.crm.workbench.service;

import com.yangxiansheng.crm.workbench.bean.Activity;
import com.yangxiansheng.crm.workbench.bean.Contacts;
import com.yangxiansheng.crm.workbench.bean.ContactsRemark;
import com.yangxiansheng.crm.workbench.bean.SaveContacts;

import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.service
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/24 0024 下午 19:04
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public interface ContactsService {
    //模糊查询，查询全部联系人信息,分页
    List<Map<String,String>> saveAllContacts(SaveContacts saveContacts);
    //添加联系人
    void addContacts(Contacts contacts,String company);
    //根据主键查询联系人信息
    Contacts seveContactsById(String id);
    //更新联系人信息
    void updateContacts(Contacts contacts,String company);
    //根据主键删除联系人
    void deleteContactsById(String id);
    //跳转详情页
    Contacts toDetail(String id);
    //添加备注
    ContactsRemark addContactsRemark(ContactsRemark contactsRemark);
    //修改备注
    void updateContactsRemark(ContactsRemark contactsRemark);
    //删除备注
    void deleteContactsRemark(String id);
    //解除关联活动
    void deleteContactsActivity(String id);
    //异步查询除已关联的所有活动
    List<Activity> saveActivity(String id, String activityName);
    //添加关联活动
    void addContactsActivity(String id, String ids);
    //异步查询已关联的所有活动
    List<Activity> saveActivities(String id);
    //查找所有联系人，姓名模糊查询
    List<Contacts> saveContacts(String contactsName);
}
