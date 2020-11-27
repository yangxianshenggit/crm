package com.yangxiansheng.crm.workbench.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yangxiansheng.crm.base.bean.Message;
import com.yangxiansheng.crm.base.bean.PaginationVo;
import com.yangxiansheng.crm.base.canstants.CrmConstansts;
import com.yangxiansheng.crm.base.exception.CrmException;
import com.yangxiansheng.crm.settings.bean.User;
import com.yangxiansheng.crm.workbench.bean.Activity;
import com.yangxiansheng.crm.workbench.bean.Contacts;
import com.yangxiansheng.crm.workbench.bean.ContactsRemark;
import com.yangxiansheng.crm.workbench.bean.SaveContacts;
import com.yangxiansheng.crm.workbench.service.ContactsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.controller
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/24 0024 下午 19:03
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Controller
public class ContactsController {

    @Autowired
    private ContactsService contactsService;
    @Autowired
    private Message mess;
    //异步查询所有关联的活动
    @RequestMapping("/workbench/contacts/saveActivities")
    @ResponseBody
    public List<Activity> saveActivities(String id){
        List<Activity>list=contactsService.saveActivities(id);
        return list;
    }
    //添加关联活动
    @RequestMapping("/workbench/contacts/addContactsActivity")
    @ResponseBody
    public Message addContactsActivity(String id,String  ids){
        try {
            contactsService.addContactsActivity(id,ids);
            mess.setSuccess(true);
            mess.setMess("添加关联活动成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }
    //异步查询除已关联的所有活动
    @RequestMapping("/workbench/contacts/saveActivity")
    @ResponseBody
    public List<Activity> saveActivity(String id,String  activityName){
        List<Activity> list=contactsService.saveActivity(id,activityName);
        return list;
    }
    //解除关联活动
    @RequestMapping("/workbench/contacts/deleteContactsActivity")
    @ResponseBody
    public Message deleteContactsActivity(String id){
        try {
            contactsService.deleteContactsActivity(id);
            mess.setSuccess(true);
            mess.setMess("解除关联活动成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }
    //删除备注
    @RequestMapping("/workbench/contacts/deteleContactsRemark")
    @ResponseBody
    public Message deleteContactsRemark(String id){
        try {
            contactsService.deleteContactsRemark(id);
            mess.setSuccess(true);
            mess.setMess("删除备注成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }
    //修改备注
    @RequestMapping("/workbench/contacts/updateContactsRemark")
    @ResponseBody
    public Message updateContactsRemark(ContactsRemark contactsRemark, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        contactsRemark.setEditBy(user.getName());
        try {
            contactsService.updateContactsRemark(contactsRemark);
            mess.setSuccess(true);
            mess.setMess("修改备注成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //添加备注
    @RequestMapping("/workbench/contacts/addContactsRemark")
    @ResponseBody
    public ContactsRemark addContactsRemark(ContactsRemark contactsRemark, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        contactsRemark.setCreateBy(user.getName());
        ContactsRemark contactsRemark1 = contactsService.addContactsRemark(contactsRemark);
        return contactsRemark;
    }

    //跳转详情页
    @RequestMapping("/workbench/contacts/toDetail")
    public String toDetail(String id, Model model) {
        Contacts contacts = contactsService.toDetail(id);
        model.addAttribute("contacts", contacts);
        return "/contacts/detail";
    }
    //查找所有联系人，姓名模糊查询
    @RequestMapping("/workbench/contacts/saveContacts")
    @ResponseBody
    public List<Contacts> saveContacts(String contactsName){
        List<Contacts> list=contactsService.saveContacts(contactsName);
        return list;
    }
    //根据主键删除联系人
    @RequestMapping("/workbench/contacts/deleteContactsById")
    @ResponseBody
    public Message deleteContactsById(String id) {
        try {
            contactsService.deleteContactsById(id);
            mess.setSuccess(true);
            mess.setMess("联系人删除成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //更新联系人信息
    @RequestMapping("/workbench/contacts/updateContacts")
    @ResponseBody
    public Message updateContacts(Contacts contacts, String company, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        contacts.setEditBy(user.getName());
        try {
            contactsService.updateContacts(contacts, company);
            mess.setSuccess(true);
            mess.setMess("更新联系人信息成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //模糊查询，查询全部联系人信息,分页
    @RequestMapping("/workbench/contacts/saveAllContacts")
    @ResponseBody
    public PaginationVo saveAllContacts(@RequestParam(defaultValue = "1") int pageNo,
                                        @RequestParam(defaultValue = "2") int pageSizes,
                                        SaveContacts saveContacts) {
        PageHelper.startPage(pageNo, pageSizes);
        List<Map<String, String>> list = contactsService.saveAllContacts(saveContacts);
        PageInfo<Map<String, String>> pageInfo = new PageInfo<>(list);
        PaginationVo<Map<String, String>> paginationVo = new PaginationVo<>(pageInfo);
        return paginationVo;
    }

    //添加联系人
    @RequestMapping("/workbench/contacts/addContacts")
    @ResponseBody
    public Message addContacts(Contacts contacts, String company, HttpSession session) {
        try {
            User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
            contacts.setCreateBy(user.getName());
            contactsService.addContacts(contacts, company);
            mess.setSuccess(true);
            mess.setMess("添加联系人成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //根据主键查询联系人信息
    @RequestMapping("/workbench/contacts/seveContactsById")
    @ResponseBody
    public Contacts seveContactsById(String id) {
        Contacts contacts = contactsService.seveContactsById(id);
        return contacts;
    }


}

