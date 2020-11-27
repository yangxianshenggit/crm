package com.yangxiansheng.crm.workbench.service.impl;

import com.yangxiansheng.crm.base.bean.Message;
import com.yangxiansheng.crm.base.canstants.CrmExceptionEnum;
import com.yangxiansheng.crm.base.exception.CrmException;
import com.yangxiansheng.crm.base.util.DateTimeUtil;
import com.yangxiansheng.crm.base.util.UUIDUtil;
import com.yangxiansheng.crm.settings.bean.User;
import com.yangxiansheng.crm.settings.mapper.UserMapper;
import com.yangxiansheng.crm.workbench.bean.*;
import com.yangxiansheng.crm.workbench.mapper.*;
import com.yangxiansheng.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.service.impl
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/24 0024 下午 12:28
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Service("tranService")
public class TranServiceImpl implements TranService {
    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private CustomerRemarkMapper customerRemarkMapper;
    @Autowired
    private TranHistoryMapper tranHistoryMapper;
    @Autowired
    private TranMapper tranMapper;
    @Autowired
    private TranRemarkMapper tranRemarkMapper;
    @Autowired
    private ContactsMapper contactsMapper;
    @Autowired
    private ContactsRemarkMapper contactsRemarkMapper;
    @Autowired
    private ContactsActivityRelationMapper contactsActivityRelationMapper;

    //删除单个交易
    @Override
    public void deleteTranById(String id) {
        //删除交易
        int count = tranMapper.deleteByPrimaryKey(id);
        if (count == 0) {
            throw new CrmException(CrmExceptionEnum.TRAN_DELETE_FAIL);
        }
        //查询交易下的备注,有则进行删除
        Example example = new Example(TranRemark.class);
        example.createCriteria().andEqualTo("tranId", id);
        count = tranRemarkMapper.selectCountByExample(example);
        if (count > 0) {
            //有备注，删除
            count = tranRemarkMapper.deleteByExample(example);
            if (count == 0) {
                throw new CrmException(CrmExceptionEnum.TRAN_DELETE_FAIL);
            }
        }
        //删除交易历史
        example = new Example(TranHistory.class);
        example.createCriteria().andEqualTo("tranId", id);
        count = tranHistoryMapper.selectCountByExample(example);
        if (count > 0) {
            //有历史，删除
            count = tranHistoryMapper.deleteByExample(example);
            if (count == 0) {
                throw new CrmException(CrmExceptionEnum.TRAN_DELETE_FAIL);
            }
        }
    }

    //查询所有交易信息，支持模糊查询，分页
    @Override
    public List<Map<String, String>> saveAllTran(SaveTran saveTran) {
        return tranMapper.saveAllTran(saveTran);
    }

    //添加交易
    @Override
    public void addTran(Tran tran, String customerName) {
        //设置属性
        tran.setId(UUIDUtil.getUUID());
        tran.setCreateTime(DateTimeUtil.getSysTime());
        //判断客户是否存在
        if (tran.getCustomerId().equals("1")) {
            //客户不存在，进行创建
            Customer customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setOwner(tran.getOwner());
            customer.setContactSummary(tran.getContactSummary());
            customer.setCreateBy(tran.getCreateBy());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setNextContactTime(tran.getNextContactTime());
            customer.setDescription(tran.getDescription());
            customer.setName(customerName);
            int count = customerMapper.insertSelective(customer);
            if (count == 0) {
                throw new CrmException(CrmExceptionEnum.CUSTOMER_ADD_FAIL);
            }
            tran.setCustomerId(customer.getId());
        }
        //创建交易
        int count = tranMapper.insertSelective(tran);
        if (count == 0) {
            throw new CrmException(CrmExceptionEnum.TRAN_ADD_FAIL);
        }
        //创建交易历史纪录
        TranHistory tranHistory = new TranHistory();
        tranHistory.setId(UUIDUtil.getUUID());
        tranHistory.setCreateBy(tran.getCreateBy());
        tranHistory.setStage(tran.getStage());
        tranHistory.setTranId(tran.getId());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());
        count = tranHistoryMapper.insertSelective(tranHistory);
        if (count == 0) {
            throw new CrmException(CrmExceptionEnum.TRAN_ADD_FAIL);
        }
    }

    //跳转详情页
    @Override
    public Tran toDetail(String id) {
        //根据主键查询相关交易信息
        Tran tran = tranMapper.selectByPrimaryKey(id);
        //设置客户名称
        Customer customer = customerMapper.selectByPrimaryKey(tran.getCustomerId());
        tran.setCustomerId(customer.getName());
        //设置联系人名称
        Contacts contacts = contactsMapper.selectByPrimaryKey(tran.getContactsId());
        tran.setContactsId(contacts.getFullname());
        //设置活动名称
        Activity activity = activityMapper.selectByPrimaryKey(tran.getActivityId());
        tran.setActivityId(activity.getName());
        //设置所有者姓名
        User user = userMapper.selectByPrimaryKey(tran.getOwner());
        tran.setOwner(user.getName());

        //查询交易下的所有备注
        Example example = new Example(TranRemark.class);
        example.createCriteria().andEqualTo("tranId", id);
        List<TranRemark> tranRemarks = tranRemarkMapper.selectByExample(example);
        tran.setTranRemarks(tranRemarks);

        //查询交易的所有历史纪录
        example = new Example(TranHistory.class);
        example.createCriteria().andEqualTo("tranId", id);
        List<TranHistory> tranHistories = tranHistoryMapper.selectByExample(example);
        tran.setTranHistories(tranHistories);

        return tran;
    }

    //修改交易阶段,阶段，可能性，修改者，修改时间,交易历史,
    @Override
    public Tran updateTranStage(Tran tran, Map<String, String> map) {
        tran.setEditTime(DateTimeUtil.getSysTime());
        //修改交易信息
        tranMapper.updateByPrimaryKeySelective(tran);
        //查询tran所有信息
        tran = tranMapper.selectByPrimaryKey(tran.getId());
        //创建交易历史
        TranHistory tranHistory = new TranHistory();
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setTranId(tran.getId());
        tranHistory.setStage(tran.getStage());
        tranHistory.setCreateBy(tran.getEditBy());
        tranHistory.setId(UUIDUtil.getUUID());
        tranHistoryMapper.insertSelective(tranHistory);
        List<TranHistory> list = new ArrayList<>();
        list.add(tranHistory);
        tran.setTranHistories(list);
        //取出可能性
        String stage = map.get(tran.getStage());
        tran.setStage(stage);
        return tran;
    }

    //添加备注
    @Override
    public TranRemark addTranRemark(TranRemark tranRemark) {
        tranRemark.setCreateTime(DateTimeUtil.getSysTime());
        tranRemark.setEditFlag("0");
        tranRemark.setId(UUIDUtil.getUUID());
        tranRemarkMapper.insertSelective(tranRemark);
        return tranRemark;
    }

    //修改备注
    @Override
    public void updateTranRemark(TranRemark tranRemark) {
        tranRemark.setEditFlag("1");
        tranRemark.setEditTime(DateTimeUtil.getSysTime());
        int count = tranRemarkMapper.updateByPrimaryKeySelective(tranRemark);
        if (count == 0) {
            throw new CrmException(CrmExceptionEnum.TRAN_REMARK_ADD_FAIL);
        }
    }

    //删除备注
    @Override
    public void deleteTranRemark(String id) {
        int cont = tranRemarkMapper.deleteByPrimaryKey(id);
        if (cont == 0) {
            throw new CrmException(CrmExceptionEnum.TRAN_REMARK_DELETE_FAIL);
        }
    }

    //跳转修改交易信息界面
    @Override
    public Tran toTranEdit(String id) {
        //通过主键查询交易信息
        Tran tran = tranMapper.selectByPrimaryKey(id);
        //设置客户名称
        Customer customer = customerMapper.selectByPrimaryKey(tran.getCustomerId());
        tran.setCustomerId(customer.getName());
        //设置联系人名称
        Contacts contacts = contactsMapper.selectByPrimaryKey(tran.getContactsId());
        tran.setContactsId(contacts.getFullname());
        return tran;
    }

    //修改交易信息
    @Override
    public void updateTran(Tran tran, String customerName) {
        tran.setEditTime(DateTimeUtil.getSysTime());
        if (tran.getCustomerId().equals("1")) {
            //客户不存在，进行创建
            Customer customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setOwner(tran.getOwner());
            customer.setContactSummary(tran.getContactSummary());
            customer.setCreateBy(tran.getCreateBy());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setNextContactTime(tran.getNextContactTime());
            customer.setDescription(tran.getDescription());
            customer.setName(customerName);
            int count = customerMapper.insertSelective(customer);
            if (count == 0) {
                throw new CrmException(CrmExceptionEnum.CUSTOMER_ADD_FAIL);
            }
            tran.setCustomerId(customer.getId());
        }
        //修改交易信息
        int count = tranMapper.updateByPrimaryKeySelective(tran);
        if (count == 0) {
            throw new CrmException(CrmExceptionEnum.TRAN_UPDATE_FAIL);
        }
    }
}
