package com.yangxiansheng.crm.workbench.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yangxiansheng.crm.base.bean.Message;
import com.yangxiansheng.crm.base.bean.PaginationVo;
import com.yangxiansheng.crm.base.canstants.CrmConstansts;
import com.yangxiansheng.crm.base.canstants.CrmExceptionEnum;
import com.yangxiansheng.crm.base.exception.CrmException;
import com.yangxiansheng.crm.settings.bean.User;
import com.yangxiansheng.crm.settings.service.UserService;
import com.yangxiansheng.crm.workbench.bean.Activity;
import com.yangxiansheng.crm.workbench.bean.ActivityRemark;
import com.yangxiansheng.crm.workbench.bean.SaveActivity;
import com.yangxiansheng.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.controller
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/17 0017 下午 16:17
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Controller
public class ActivityController {
    @Autowired
    private ActivityService activityService;
    @Autowired
    private UserService userService;
    @Autowired
    private Message mess;
    //删除活动信息
    @RequestMapping("/workbench/delete_Activity")
    public @ResponseBody Message delete_Activity(@RequestParam("id") String id){
        try{
            activityService.delete_Activity(id);
            mess.setSuccess(true);
            mess.setMess("删除市场活动信息成功！！！");
        }catch (CrmException e){
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }
    //修改市场活动信息
    @RequestMapping("/workbench/update_Activity")
    public @ResponseBody Message update_Activity(Activity activity,HttpSession session){
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        activity.setEditBy(user.getName());
        try{
            activityService.update_Activity(activity);
            mess.setSuccess(true);
            mess.setMess("修改市场活动信息成功！！！");
        }catch (CrmException e){
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;

    }
    //添加备注详情页
    @RequestMapping("/workbench/addRemark")
    public @ResponseBody Message addRemark(ActivityRemark activityRemark,HttpSession session){
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        activityRemark.setCreateBy(user.getName());
        try{
            activityService.addRemark(activityRemark);
            mess.setSuccess(true);
            mess.setMess("添加备注成功！！！");
        }catch (CrmException e){
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;

    }
    //根据主键删除备注
    @RequestMapping("/workbench/deleteRemark")
    public @ResponseBody Message deleteRemark(@RequestParam("id") String id){
        try{
            activityService.deleteRemark(id);
            mess.setSuccess(true);
            mess.setMess("删除备注成功！！！");
        }catch (CrmException e){
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }
    //修改备注
    @RequestMapping("/workbench/updateRemark")
    public @ResponseBody Message updateRemark(ActivityRemark activityRemark,HttpSession session){
        //设置修改备注的人
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        activityRemark.setEditBy(user.getName());
        try{
            activityService.updateRemark(activityRemark);
            mess.setSuccess(true);
            mess.setMess("更新备注成功！！！");
        }catch (CrmException e){
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }
    //详情页信息查询
    @RequestMapping("/workbench/saveActivity")
    public String  saveActivity(@RequestParam("id") String id, HttpServletRequest request){
        //更具主键查询所有信息
        Activity activity=  activityService.saveActivity(id);
        request.setAttribute("activity",activity);
        return "/activity/detail";
    }
    //根据主键进行删除
    @RequestMapping("/workbench/deleteActivityById")
    public @ResponseBody
    Message deleteActivityById(String ids) {
        try {
            //通过主键进行删除
            activityService.deleteActivityById(ids);
            //删除成功
            mess.setSuccess(true);
            mess.setMess("删除成功");
        } catch (CrmException e) {
            //删除失败
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //更新数据
    @RequestMapping("/workbench/updateActivity")
    public @ResponseBody
    Message updateActivity(Activity activity, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        activity.setEditBy(user.getName());
        try {
            activityService.updateActivity(activity);
            mess.setSuccess(true);
            mess.setMess(activity.getName() + "活动更新成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(activity.getName() + e.getMessage());
        }
        return mess;
    }

    //根据主键查询活动信息
    @RequestMapping("/workbench/selectActivityById")
    public @ResponseBody
    List<Activity> selectActivityById(String ids) {
        List<Activity> list = new ArrayList<>();
        String[] split = ids.split(",");
        for (String id : split) {
            Activity activity = activityService.selectActivityById(id);
            list.add(activity);
        }
        return list;
    }

    //查询所有的市场活动
    @RequestMapping("/workbench/queryAllActivity")
    @ResponseBody
    public PaginationVo queryActivity(@RequestParam(defaultValue = "1", required = false) int page,
                                      @RequestParam(defaultValue = "2", required = false) int pageSize,
                                      SaveActivity saveActivity) {
        PageHelper.startPage(page, pageSize);
        List<Map<String, String>> list = activityService.queryAllActivity(saveActivity);
        PageInfo<Map<String, String>> pageInfo = new PageInfo<>(list);
        PaginationVo<Map<String, String>> mapPaginationVo = new PaginationVo<>(pageInfo);
        return mapPaginationVo;
    }

    //创建市场活动按钮异步查询所有者
    @RequestMapping("/workbench/saveOwner")
    public @ResponseBody
    List<User> saveOwner() {
        List<User> list = userService.saveOwner();
        return list;
    }
    //查询所有活动市场
    @RequestMapping("/workbench/activity/saveActivity")
    @ResponseBody
    public List<Activity> saveActivities(@RequestParam(required = false) String activityName){
        List<Activity> list= activityService.saveActivities(activityName);
        return list;
    }
    //创建市场活动按钮异步提交表单
    @RequestMapping("/workbench/createInsert")
    public @ResponseBody
    Message createInsert(Activity activity, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        activity.setCreateBy(user.getName());
        activity.setEditBy(user.getName());
        try {
            //创建市场活动
            activityService.addcreateInsert(activity);
            //创建成功
            mess.setSuccess(true);
            mess.setMess(activity.getName() + "活动创建成功");
        } catch (CrmException e) {
            //创建失败
            mess.setSuccess(false);
            mess.setMess(activity.getName() + e.getMessage());
        }
        return mess;
    }
}
