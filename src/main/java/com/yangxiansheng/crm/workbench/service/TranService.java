package com.yangxiansheng.crm.workbench.service;

import com.yangxiansheng.crm.base.bean.Message;
import com.yangxiansheng.crm.workbench.bean.SaveTran;
import com.yangxiansheng.crm.workbench.bean.Tran;
import com.yangxiansheng.crm.workbench.bean.TranRemark;

import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.service
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/24 0024 下午 12:27
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public interface TranService {
    //删除单个交易
    void deleteTranById(String id);

    //查询所有交易信息，支持模糊查询，分页
    List<Map<String, String>> saveAllTran(SaveTran saveTran);

    //添加交易
    void addTran(Tran tran, String customerName);

    //跳转详情页
    Tran toDetail(String id);

    //修改交易阶段
    Tran updateTranStage(Tran tran, Map<String, String> map);

    //添加备注
    TranRemark addTranRemark(TranRemark tranRemark);

    //修改备注
    void updateTranRemark(TranRemark tranRemark);

    //删除备注
    void deleteTranRemark(String id);
    //跳转修改交易信息界面
    Tran  toTranEdit(String id);
    //修改交易信息
    void updateTran(Tran tran, String customerName);
}
