package com.yangxiansheng.crm.workbench.mapper;

import com.yangxiansheng.crm.workbench.bean.Contacts;
import com.yangxiansheng.crm.workbench.bean.SaveContacts;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.mapper
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/23 0023 下午 21:10
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public interface ContactsMapper extends Mapper<Contacts> {
    //模糊查询，查询全部联系人信息,分页
    List<Map<String,String>> saveAllContacts(SaveContacts saveContacts);
}
