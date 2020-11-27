package com.yangxiansheng.crm.workbench.mapper;

import com.yangxiansheng.crm.workbench.bean.SaveTran;
import com.yangxiansheng.crm.workbench.bean.Tran;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.mapper
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/23 0023 下午 20:30
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public interface TranMapper extends Mapper<Tran> {
    //查询所有交易信息，支持模糊查询，分页
    List<Map<String, String>> saveAllTran(SaveTran saveTran);
}
