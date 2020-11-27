package com.yangxiansheng.crm.workbench.mapper;

import com.yangxiansheng.crm.workbench.bean.Activity;
import com.yangxiansheng.crm.workbench.bean.SaveActivity;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.mapper
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/17 0017 下午 16:19
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public interface ActivityMapper extends Mapper<Activity> {
    //查询所有的市场活动
    List<Map<String, String>> queryAllActivity(SaveActivity saveActivity);
}
