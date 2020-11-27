package com.yangxiansheng.crm.workbench.service;

import com.yangxiansheng.crm.workbench.bean.Activity;
import com.yangxiansheng.crm.workbench.bean.ActivityRemark;
import com.yangxiansheng.crm.workbench.bean.SaveActivity;

import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.service
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/17 0017 下午 16:18
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public interface ActivityService {
    //查询所有的市场活动
    List<Map<String, String>> queryAllActivity(SaveActivity saveActivity);
    //新建市场活动
    void addcreateInsert(Activity activity);
    //根据主键查询活动信息
    Activity selectActivityById(String id);
    //根据主键更新活动信息
    void updateActivity(Activity activity);
    //根据主键进行删除
    void deleteActivityById(String ids);
    //详情页信息查询
    Activity saveActivity(String id);
    //更新备注
    void updateRemark(ActivityRemark activityRemark);
    //删除备注
    void deleteRemark(String id);
    //添加备注
    void addRemark(ActivityRemark activityRemark);
    //修改市场活动信息
    void update_Activity(Activity activity);
    //更具主键删除市场活动信息及其所有备注
    void delete_Activity(String id);
    //查询所有活动，可根据活动名称进行模糊查询
    List<Activity> saveActivities(String activityName);
}
