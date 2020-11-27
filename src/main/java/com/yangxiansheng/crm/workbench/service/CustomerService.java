package com.yangxiansheng.crm.workbench.service;

import com.yangxiansheng.crm.workbench.bean.Customer;
import com.yangxiansheng.crm.workbench.bean.CustomerRemark;
import com.yangxiansheng.crm.workbench.bean.SaveCustomer;

import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.service
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/18 0018 下午 21:14
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public interface CustomerService {
    //查询所有客户信息
    List<Map<String, String>> saveAllCustomer(SaveCustomer saveCustomer);

    //新建客户
    void add_customer(Customer customer);

    //根据主键查询客户
    Customer saveCustomerById(String id);

    //根据主键进行更新
    void updateCustomerById(Customer customer);

    //根据主键进行删除
    void delete_customer(String id);

    //根据主键进行查询客户及其备注的信息
    Customer saveCustomerRemark(String id);

    //根据主键修改备注
    void updateCustomerRemark(CustomerRemark customerRemark);

    //根据主键删除备注
    void deleteCustomerRemark(String id);
    //添加备注
    CustomerRemark addCustomerRemark(CustomerRemark customerRemark);
    //异步查询所有的客户姓名
    List<String> queryCustomerName(String customerName);
    //根据客户姓名异步查询客户id
    String saveCustomerName(String company);
}
