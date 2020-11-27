package com.yangxiansheng.crm.workbench.service.impl;

import com.yangxiansheng.crm.base.canstants.CrmExceptionEnum;
import com.yangxiansheng.crm.base.exception.CrmException;
import com.yangxiansheng.crm.base.util.DateTimeUtil;
import com.yangxiansheng.crm.base.util.UUIDUtil;
import com.yangxiansheng.crm.settings.bean.User;
import com.yangxiansheng.crm.settings.mapper.UserMapper;
import com.yangxiansheng.crm.workbench.bean.Activity;
import com.yangxiansheng.crm.workbench.bean.ActivityRemark;
import com.yangxiansheng.crm.workbench.bean.SaveActivity;
import com.yangxiansheng.crm.workbench.mapper.ActivityMapper;
import com.yangxiansheng.crm.workbench.mapper.ActivityRemarkMapper;
import com.yangxiansheng.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import static com.yangxiansheng.crm.base.canstants.CrmExceptionEnum.ACTIVITY_INSERT_FAIL;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.service.impl
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/17 0017 下午 16:18
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Service("activityService")
public class ActivityServiceImpl implements ActivityService {
    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private ActivityRemarkMapper activityRemarkMapper;
    @Autowired
    private UserMapper userMapper;

    //查询所有的市场活动
    @Override
    public List<Map<String, String>> queryAllActivity(SaveActivity saveActivity) {
        return activityMapper.queryAllActivity(saveActivity);
    }

    //新建市场活动
    @Override
    public void addcreateInsert(Activity activity) {
        activity.setId(UUIDUtil.getUUID());
        activity.setCreateTime(DateTimeUtil.getSysTime());
        activity.setEditTime(DateTimeUtil.getSysTime());
        /**
         *  tkmapper中的insertSelective方法：
         *      单表插入数据，为空的字段不插入，返回影响的记录数
         */
        int i = activityMapper.insertSelective(activity);
        if (i == 0) {
            //插入失败
            throw new CrmException(CrmExceptionEnum.ACTIVITY_INSERT_FAIL);
        }
    }

    //根据主键查询活动信息
    @Override
    public Activity selectActivityById(String id) {
        return activityMapper.selectByPrimaryKey(id);
    }

    //根据主键更新活动信息
    @Override
    public void updateActivity(Activity activity) {
        activity.setEditTime(DateTimeUtil.getSysTime());
        int num = activityMapper.updateByPrimaryKeySelective(activity);
        if (num == 0) {
            //更新失败
            throw new CrmException(CrmExceptionEnum.ACTIVITY_UPDATE_FAIL);
        }
    }

    //根据主键进行删除
    @Override
    public void deleteActivityById(String ids) {
        String[] split = ids.split(",");
        for (String id : split) {
            //删除活动
            int i = activityMapper.deleteByPrimaryKey(id);
            //删除活动的备注
            Example example = new Example(ActivityRemark.class);
            Example.Criteria criteria = example.createCriteria();
            criteria.andEqualTo("activityId",id);
            int i1 = activityRemarkMapper.selectCountByExample(example);
            if (i1>0){
                //有备注，进行删除
                i1=activityRemarkMapper.deleteByExample(example);
                if (i1 == 0) {
                    throw new CrmException(CrmExceptionEnum.ACTIVITY_DELETE_FAIL);
                }
            }
            if (i == 0) {
                throw new CrmException(CrmExceptionEnum.ACTIVITY_DELETE_FAIL);
            }
        }


    }

    //详情页信息查询
    @Override
    public Activity saveActivity(String id) {
        //通过id查询活动信息
        Activity activity = activityMapper.selectByPrimaryKey(id);
        //通过activity的owner查询用户信息
        User user = userMapper.selectByPrimaryKey(activity.getOwner());
        //将activity中的owner属性设置为用户姓名
        activity.setOwner(user.getName());
        //activity的id是ActivityRemark的外键，根据activity的id进行查询所有的备注信息
        Example example = new Example(ActivityRemark.class);//example例子的意思
        Example.Criteria criteria = example.createCriteria();//criteria条件
        //拼接查询条件
        criteria.andEqualTo("activityId", activity.getId());
        List<ActivityRemark> activityRemarks = activityRemarkMapper.selectByExample(example);
        activity.setActivityRemark(activityRemarks);
        return activity;
    }

    //更新备注
    @Override
    public void updateRemark(ActivityRemark activityRemark) {
        //设置更新时间
        activityRemark.setEditTime(DateTimeUtil.getSysTime());
        //设置更新状态
        activityRemark.setEditFlag("1");
        //单表通过主键修改操作
        int i = activityRemarkMapper.updateByPrimaryKeySelective(activityRemark);
        if (i == 0) {
            throw new CrmException(CrmExceptionEnum.ACTIVITY_REMARK_UPDATE_FAIL);
        }
    }

    //删除备注
    @Override
    public void deleteRemark(String id) {
        int i = activityRemarkMapper.deleteByPrimaryKey(id);
        if (i == 0) {
            throw new CrmException(CrmExceptionEnum.ACTIVITY_REMARK_DELETE_FAIL);
        }
    }

    //添加备注
    @Override
    public void addRemark(ActivityRemark activityRemark) {
        //设置创建时间
        activityRemark.setCreateTime(DateTimeUtil.getSysTime());
        //设置未修改状态
        activityRemark.setEditFlag("0");
        //设置主键
        activityRemark.setId(UUIDUtil.getUUID());
        int i = activityRemarkMapper.insertSelective(activityRemark);
        if (i == 0) {
            throw new CrmException(CrmExceptionEnum.ACTIVITY_REMARK_INSERT_FAIL);
        }
    }

    //修改市场活动信息
    @Override
    public void update_Activity(Activity activity) {
        //设置修改时间
        activity.setEditTime(DateTimeUtil.getSysTime());
        int i = activityMapper.updateByPrimaryKeySelective(activity);
        if (i == 0) {
            throw new CrmException(CrmExceptionEnum.ACTIVITY_UPDATE_FAIL);
        }
    }

    //更具主键删除市场活动信息及其所有备注
    @Override
    public void delete_Activity(String id) {
        //根据主键删除活动信息
        int i = activityMapper.deleteByPrimaryKey(id);
        //根据外键删除所有备注
        Example example = new Example(ActivityRemark.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andEqualTo("activityId", id);
        //先查询该活动是否有记录
        int i2 = activityRemarkMapper.selectCountByExample(example);
        if (i2 > 0) {
            //如果该活动有备注，删除备注
            int i1 = activityRemarkMapper.deleteByExample(example);
            if (i == 0 || i1 == 0) {
                throw new CrmException(CrmExceptionEnum.ACTIVITY_DELETE_FAIL);
            }
        } else {
            //没备注
            if (i == 0) {
                throw new CrmException(CrmExceptionEnum.ACTIVITY_DELETE_FAIL);
            }
        }
    }
    //查询所有活动，可根据活动名称进行模糊查询
    @Override
    public List<Activity> saveActivities(String activityName) {
        List<Activity> list=new ArrayList<>();
        if (activityName!=null&&activityName!=""){
            Example example = new Example(Activity.class);
            example.createCriteria().andLike("name","%"+activityName+"%");
            list = activityMapper.selectByExample(example);
        }else {
            list = activityMapper.selectAll();
        }
        for (Activity activity : list) {
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());
        }
        return list;
    }
}
