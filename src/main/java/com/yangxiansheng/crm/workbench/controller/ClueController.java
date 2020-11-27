package com.yangxiansheng.crm.workbench.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yangxiansheng.crm.base.bean.DictionaryType;
import com.yangxiansheng.crm.base.bean.Message;
import com.yangxiansheng.crm.base.bean.PaginationVo;
import com.yangxiansheng.crm.base.canstants.CrmConstansts;
import com.yangxiansheng.crm.base.exception.CrmException;
import com.yangxiansheng.crm.settings.bean.User;
import com.yangxiansheng.crm.workbench.bean.*;
import com.yangxiansheng.crm.workbench.service.ClueService;
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
 * @CreateDate: 2020/11/21 0021 下午 19:42
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Controller
public class ClueController {
    @Autowired
    private Message mess;
    @Autowired
    private ClueService clueService;
    //线索转换客户
    @RequestMapping("/workbench/clue/clueConvertTran")
    @ResponseBody
    public Message addclueConvertTran(HttpSession session,@RequestParam("clueId") String clueId,Tran tran){
        try{
            User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
            clueService.addclueConvertTran(clueId,tran,user);
            mess.setSuccess(true);
            mess.setMess("线索转换客户成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }
    //查询当前线索已存在的活动，并支持活动名称模糊查询
    @RequestMapping("/workbench/clue/saveHasActivity")
    @ResponseBody
    public List<Activity> saveHasActivity(@RequestParam("id") String id,
                                          @RequestParam(defaultValue = "") String name){
        List<Activity> activities = clueService.saveBindActivitys(id, name);
        return activities;
    }
    //跳转到转换界面
    @RequestMapping("/workbench/clue/toConvert")
    public String toConvert(Clue clue,Model model,HttpSession session,@RequestParam(defaultValue = "") String acitvityName){
        //从字典中查询交易阶段
        List<DictionaryType> dictionaryTypes = (List<DictionaryType>) session.getServletContext().getAttribute("dictionaryTypes");
        for (DictionaryType dictionaryType : dictionaryTypes) {
            if (dictionaryType.getCode().equals("stage")){
                model.addAttribute("stages",dictionaryType.getDictionaryValues());
            }
        }
        //查询关联的活动
        List<Activity> activities = clueService.saveBindActivitys(clue.getId(), acitvityName);
        model.addAttribute("activities",activities);
        model.addAttribute("clue",clue);
        return "/clue/convert";
    }
    //查询所有与线索关联的活动
    @RequestMapping("/workbench/clue/saveActivities")
    @ResponseBody
    public List<Activity> saveActivities(@RequestParam("id") String id){
        List<Activity>  list=clueService.saveActivitys(id);
        return list;
    }
    //添加关联活动
    @RequestMapping("/workbench/clue/saveClueActivity")
    @ResponseBody
    public Message saveClueActivity(@RequestParam("id") String clueId,
                                    @RequestParam("ids") String ids){
        try {
            clueService.saveClueActivity(clueId,ids);
            mess.setSuccess(true);
            mess.setMess("添加线索活动关联成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }
    //查询所有活动，除已关联的，模糊查询
    @RequestMapping("/workbench/clue/saveActivity")
    @ResponseBody
    public List<Activity> saveActivity(@RequestParam("id") String id,
                                       @RequestParam(value = "name",defaultValue = "") String name) {
        List<Activity> activities = clueService.saveActivity(id, name);
        return activities;
    }

    //接触线索与市场活动的关联
    @RequestMapping("/workbench/clue/deleteClueActivityRelation")
    @ResponseBody
    public Message deleteClueActivityRelation(ClueActivityRelation clueActivityRelation) {
        try {
            clueService.deleteClueActivityRelation(clueActivityRelation);
            mess.setSuccess(true);
            mess.setMess("删除线索活动关联成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //添加备注
    @RequestMapping("/workbench/clue/addClueRemark")
    @ResponseBody
    public ClueRemark addClueRemark(HttpSession session, ClueRemark clueRemark) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        clueRemark.setCreateBy(user.getName());
        clueRemark = clueService.addClueRemark(clueRemark);
        return clueRemark;
    }

    //删除备注
    @RequestMapping("/workbench/clue/deleteClueRemark")
    @ResponseBody
    public Message deleteClueRemark(@RequestParam("id") String id) {
        try {
            clueService.deleteClueRemark(id);
            mess.setSuccess(true);
            mess.setMess("删除备注成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //更新线索备注
    @RequestMapping("/workbench/clue/updateClueRemark")
    @ResponseBody
    public Message updateClueRemark(ClueRemark clueRemark, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        clueRemark.setEditBy(user.getName());
        try {
            clueService.updateClueRemark(clueRemark);
            mess.setSuccess(true);
            mess.setMess("更新线索备注成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //跳转详情页
    @RequestMapping("/workbench/clue/todetail")
    public String todetail(@RequestParam("id") String id, Model model) {
        Clue clue = clueService.todetail(id);
        model.addAttribute("clue", clue);
        return "/clue/detail";
    }

    //分页，查询所有信息，根据条件查询
    @RequestMapping("/workbench/clue/saveAllClue")
    public @ResponseBody
    PaginationVo saveAllClue(@RequestParam(defaultValue = "1", name = "pageNo") int pageNo,
                             @RequestParam(defaultValue = "2", name = "pageSizes") int pageSizes,
                             SaveClue saveClue) {
        PageHelper.startPage(pageNo, pageSizes);
        List<Map<String, String>> list = clueService.saveAllClue(saveClue);
        PageInfo<Map<String, String>> pageInfo = new PageInfo<>(list);
        PaginationVo<Map<String, String>> cluePaginationVo = new PaginationVo<>(pageInfo);
        return cluePaginationVo;
    }

    //异步查询公司名称
    @RequestMapping("/workbench/clue/saveCompany")
    public @ResponseBody
    Message saveCompany(@RequestParam("company") String company) {
        try {
            clueService.saveCompany(company);
            mess.setSuccess(true);
            mess.setMess("公司名称可用");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //添加线索
    @RequestMapping("/workbench/clue/addClue")
    @ResponseBody
    public Message addClue(Clue clue, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        clue.setCreateBy(user.getName());
        try {
            clueService.addClue(clue);
            mess.setSuccess(true);
            mess.setMess("添加线索成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //查询修改线索所需的信息
    @RequestMapping("/workbench/clue/saveClueById")
    @ResponseBody
    public Clue saveClueById(@RequestParam("id") String id) {
        Clue clue = clueService.saveClueById(id);
        return clue;
    }

    //删除线索
    @RequestMapping("/workbench/clue/deleteClueById")
    @ResponseBody
    public Message deleteClueById(@RequestParam("id") String id) {
        try {
            clueService.deleteClueById(id);
            mess.setSuccess(true);
            mess.setMess("删除线索成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //更新线索
    @RequestMapping("/workbench/clue/updateClue")
    @ResponseBody
    public Message updateClue(Clue clue, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        clue.setEditBy(user.getName());
        try {
            clueService.updateClue(clue);
            mess.setSuccess(true);
            mess.setMess("更新线索成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }
}
