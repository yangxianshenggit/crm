package com.yangxiansheng.crm.workbench.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yangxiansheng.crm.base.bean.Message;
import com.yangxiansheng.crm.base.bean.PaginationVo;
import com.yangxiansheng.crm.base.canstants.CrmConstansts;
import com.yangxiansheng.crm.base.exception.CrmException;
import com.yangxiansheng.crm.settings.bean.User;
import com.yangxiansheng.crm.workbench.bean.SaveTran;
import com.yangxiansheng.crm.workbench.bean.Tran;
import com.yangxiansheng.crm.workbench.bean.TranRemark;
import com.yangxiansheng.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import javax.xml.ws.spi.http.HttpExchange;
import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.controller
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/24 0024 下午 12:27
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Controller
public class TranController {
    @Autowired
    private TranService tranService;
    @Autowired
    private Message mess;

    //删除备注
    @RequestMapping("/workbench/tran/deleteTranRemark")
    @ResponseBody
    public Message deleteTranRemark(String id) {
        try {
            tranService.deleteTranRemark(id);
            mess.setSuccess(true);
            mess.setMess("删除备注成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //修改备注
    @RequestMapping("/workbench/tran/updateTranRemark")
    @ResponseBody
    public Message updateTranRemark(TranRemark tranRemark, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        tranRemark.setEditBy(user.getName());
        try {
            tranService.updateTranRemark(tranRemark);
            mess.setSuccess(true);
            mess.setMess("修改备注成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //添加备注
    @RequestMapping("/workbench/tran/addTranRemark")
    @ResponseBody
    public TranRemark addTranRemark(TranRemark tranRemark, HttpSession session) {

        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        tranRemark.setCreateBy(user.getName());
        tranRemark = tranService.addTranRemark(tranRemark);
        return tranRemark;
    }

    //修改交易阶段
    @RequestMapping("/workbench/tran/updateTranStage")
    @ResponseBody
    public Tran updateTranStage(Tran tran, HttpSession session) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        tran.setEditBy(user.getName());
        Map<String, String> map = (Map<String, String>) session.getServletContext().getAttribute("stage2PossibilityMap");
        tran = tranService.updateTranStage(tran, map);
        return tran;
    }

    //查询可能性
    @RequestMapping("/workbench/tran/toStage2PossibilityMap")
    @ResponseBody
    public Message toStage2PossibilityMap(String type, HttpSession session) {
        Map<String, String> map = (Map<String, String>) session.getServletContext().getAttribute("stage2PossibilityMap");
        String sql = map.get(type);
        mess.setMess(sql);
        return mess;
    }

    //查询所有交易信息，支持模糊查询，分页
    @RequestMapping("/workbench/tran/saveAllTran")
    @ResponseBody
    public PaginationVo saveAllTran(@RequestParam(defaultValue = "1", required = false) int page,
                                    @RequestParam(defaultValue = "2", required = false) int pageSize,
                                    SaveTran saveTran) {
        PageHelper.startPage(page, pageSize);
        List<Map<String, String>> list = tranService.saveAllTran(saveTran);
        PageInfo<Map<String, String>> pageInfo = new PageInfo<>(list);
        PaginationVo<Map<String, String>> mapPaginationVo = new PaginationVo<>(pageInfo);
        return mapPaginationVo;
    }

    //删除单个交易
    @RequestMapping("/workbench/tran/deleteTranById")
    @ResponseBody
    public Message deleteTranById(String id) {
        try {
            tranService.deleteTranById(id);
            mess.setSuccess(true);
            mess.setMess("删除交易成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //添加交易
    @RequestMapping("/workbench/tran/addTran")
    @ResponseBody
    public Message addTran(Tran tran, HttpSession session, String customerName, Model model) {
        User user = (User) session.getAttribute(CrmConstansts.LOGIN_USER);
        tran.setCreateBy(user.getName());
        try {
            tranService.addTran(tran, customerName);
            mess.setSuccess(true);
            mess.setMess("交易创建成功");
        } catch (CrmException e) {
            mess.setSuccess(false);
            mess.setMess(e.getMessage());
        }
        return mess;
    }

    //跳转详情页
    @RequestMapping("/workbench/tran/toDetail")
    public String toDetail(String id, Model model) {
        Tran tran = tranService.toDetail(id);
        model.addAttribute("tran", tran);
        return "/transaction/detail";
    }
}
