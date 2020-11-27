package com.yangxiansheng.crm.workbench.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yangxiansheng.crm.base.bean.Message;
import com.yangxiansheng.crm.base.bean.PaginationVo;
import com.yangxiansheng.crm.base.canstants.CrmConstansts;
import com.yangxiansheng.crm.base.exception.CrmException;
import com.yangxiansheng.crm.settings.bean.User;
import com.yangxiansheng.crm.workbench.bean.Customer;
import com.yangxiansheng.crm.workbench.bean.CustomerRemark;
import com.yangxiansheng.crm.workbench.bean.SaveCustomer;
import com.yangxiansheng.crm.workbench.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.controller
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/18 0018 下午 21:13
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Controller
public class CustomerController {
    @Autowired
    private CustomerService customerService;
    @Autowired
    private Message mess;
    //根据客户姓名异步查询客户id
    @RequestMapping("/workbench/customer/saveCustomerName")
    @ResponseBody
    public Message saveCustomerName(String company){
        String customerId=customerService.saveCustomerName(company);
        mess.setMess(customerId);
        return mess;

    }
    //异步查询所有的客户姓名
    @RequestMapping("/workbench/customer/queryCustomerName")
    @ResponseBody
    public List<String> queryCustomerName(String customerName) {
        return customerService.queryCustomerName(customerName);
    }

    //添加备注
    @RequestMapping("/workbench/addCustomerRemark")
    public @ResponseBody
    CustomerRemark addCustomerRemark(CustomerRemark customerRemark, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        customerRemark.setCreateBy(user.getName());
        try {
            customerRemark = customerService.addCustomerRemark(customerRemark);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customerRemark;
    }

    //根据主键删除备注
    @RequestMapping("/workbench/deleteCustomerRemark")
    public @ResponseBody
    Message deleteCustomerRemark(String id) {
        try {
            customerService.deleteCustomerRemark(id);
            mess.setSuccess(true);
            mess.setMess("备注删除成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //修改备注
    @RequestMapping("/workbench/updateCustomerRemark")
    public @ResponseBody
    Message updateCustomerRemark(CustomerRemark customerRemark, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        customerRemark.setEditBy(user.getName());
        try {
            customerService.updateCustomerRemark(customerRemark);
            mess.setSuccess(true);
            mess.setMess("修改备注成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //根据主键查询详情信息
    @RequestMapping("/workbench/saveCustomerRemark")
    public String saveCustomerRemark(@RequestParam("id") String id, HttpServletRequest request) {
        Customer customer = customerService.saveCustomerRemark(id);
        request.setAttribute("customer", customer);
        return "/customer/detail";
    }

    //根据主键进行删除
    @RequestMapping("/workbench/delete_customer")
    public String delete_customer(@RequestParam("id") String id) {
        try {
            customerService.delete_customer(id);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/customer/index";
    }

    //更具主键进行更新
    @RequestMapping("/workbench/updateCustomerById")
    @ResponseBody
    public Message updateCustomerById(Customer customer, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        customer.setEditBy(user.getName());
        try {
            customerService.updateCustomerById(customer);
            mess.setSuccess(true);
            mess.setMess("更新客户信息成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //根据主键查询客户信息
    @RequestMapping("/workbench/saveCustomerById")
    @ResponseBody
    public Customer saveCustomerById(@RequestParam("id") String id) {
        Customer customer = customerService.saveCustomerById(id);
        return customer;
    }

    @RequestMapping("/workbench/create_customer")
    @ResponseBody
    public Message add_customer(Customer customer, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        //加入创建者
        customer.setCreateBy(user.getName());
        try {
            customerService.add_customer(customer);
            mess.setSuccess(true);
            mess.setMess("用户添加成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //查询所有客户信息
    @RequestMapping("/workbench/saveAllCustomer")
    public @ResponseBody
    PaginationVo saveAllCustomer(@RequestParam(defaultValue = "1", required = false) int page,
                                 @RequestParam(defaultValue = "2", required = false) int pageSize,
                                 SaveCustomer saveCustomer) {
        PageHelper.startPage(page, pageSize);
        List<Map<String, String>> list = customerService.saveAllCustomer(saveCustomer);
        PageInfo<Map<String, String>> pageInfo = new PageInfo<>(list);
        PaginationVo paginationVo = new PaginationVo(pageInfo);
        return paginationVo;
    }
}
