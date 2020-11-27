package com.yangxiansheng.crm.workbench.service;

import com.yangxiansheng.crm.settings.bean.User;
import com.yangxiansheng.crm.workbench.bean.*;

import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.service
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/21 0021 下午 19:42
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public interface ClueService {
    //分页，查询所有信息，根据条件查询
    List<Map<String, String>> saveAllClue(SaveClue saveClue);

    //异步查询公司名称
    void saveCompany(String company);

    //添加线索
    void addClue(Clue clue);

    //根据主键查询信息
    Clue saveClueById(String id);

    //更新线索
    void updateClue(Clue clue);
    //根据主键删除线索
    void deleteClueById(String id);
    //跳转详情页
    Clue todetail(String id);
    //更新线索备注
    void updateClueRemark(ClueRemark clueRemark);
    //删除备注
    void deleteClueRemark(String id);
    //添加备注
    ClueRemark  addClueRemark(ClueRemark clueRemark);
    //删除线索活动关联成功
    void deleteClueActivityRelation(ClueActivityRelation clueActivityRelation);
    //查询所有活动，除已关联的，模糊查询
    List<Activity> saveActivity(String id, String name);
    //添加关联活动
    void saveClueActivity(String clueId, String ids);
    //查询所有与线索关联的活动
    List<Activity> saveActivitys(String id);
    //查询所有与线索绑定的市场活动，owner是所有者名字
    List<Activity> saveBindActivitys(String id,String acitvityName);
    //线索转换客户
    void addclueConvertTran(String clueId, Tran tran, User user);
}
