package com.yangxiansheng.crm.workbench.mapper;

import com.yangxiansheng.crm.workbench.bean.Customer;
import com.yangxiansheng.crm.workbench.bean.SaveCustomer;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.mapper
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/18 0018 下午 21:15
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public interface CustomerMapper extends Mapper<Customer> {
    //查询所有客户信息
    List<Map<String, String>> saveAllCustomer(SaveCustomer saveCustomer);

}
