package com.yangxiansheng.crm.workbench.service.impl;

import com.yangxiansheng.crm.base.canstants.CrmExceptionEnum;
import com.yangxiansheng.crm.base.exception.CrmException;
import com.yangxiansheng.crm.base.util.DateTimeUtil;
import com.yangxiansheng.crm.base.util.UUIDUtil;
import com.yangxiansheng.crm.settings.bean.User;
import com.yangxiansheng.crm.settings.mapper.UserMapper;
import com.yangxiansheng.crm.workbench.bean.*;
import com.yangxiansheng.crm.workbench.mapper.*;
import com.yangxiansheng.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.*;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.service.impl
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/21 0021 下午 19:43
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Service("clueService")
public class ClueServiceImpl implements ClueService {
    @Autowired
    private ClueMapper clueMapper;
    @Autowired
    private ClueRemaekMapper clueRemaekMapper;
    @Autowired
    private ClueActivityRelationMapper clueActivityRelationMapper;
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

    //跳转详情页
    @Override
    public Clue todetail(String id) {
        //根据主键查询线索信息
        Clue clue = clueMapper.selectByPrimaryKey(id);
        //查询所有者
        User user = userMapper.selectByPrimaryKey(clue.getOwner());
        clue.setOwner(user.getName());
        //查询线索的备注
        Example example = new Example(ClueRemark.class);
        example.createCriteria().andEqualTo("clueId", id);
        List<ClueRemark> clueRemarks = clueRemaekMapper.selectByExample(example);
        clue.setClueRemarks(clueRemarks);
        //查询线索关联的市场活动
        Example example1 = new Example(ClueActivityRelation.class);
        example1.createCriteria().andEqualTo("clueId", id);
        List<ClueActivityRelation> clueActivityRelations = clueActivityRelationMapper.selectByExample(example1);
        List<Activity> list = new ArrayList<>();
        for (ClueActivityRelation clueActivityRelation : clueActivityRelations) {
            //查询相关市场活动
            Activity activity = activityMapper.selectByPrimaryKey(clueActivityRelation.getActivityId());
            user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());
            list.add(activity);
        }
        clue.setActivities(list);
        return clue;
    }

    //分页，查询所有信息，根据条件查询
    @Override
    public List<Map<String, String>> saveAllClue(SaveClue saveClue) {
        //查询所有信息
        return clueMapper.saveAllClue(saveClue);

    }

    //异步查询公司名称
    @Override
    public void saveCompany(String company) {
        Example example = new Example(Clue.class);
        example.createCriteria().andEqualTo("company", company);
        int i = clueMapper.selectCountByExample(example);
        if (i > 0) {
            throw new CrmException(CrmExceptionEnum.CLUE_COMPANY_ADD_FAIL);
        }
    }

    //根据主键查询信息
    @Override
    public Clue saveClueById(String id) {
        Clue clue = clueMapper.selectByPrimaryKey(id);
        return clue;
    }

    //更新线索
    @Override
    public void updateClue(Clue clue) {
        clue.setEditTime(DateTimeUtil.getSysTime());
        int i = clueMapper.updateByPrimaryKeySelective(clue);
        if (i == 0) {
            throw new CrmException(CrmExceptionEnum.CLUE_UPDATE_FAIL);
        }
    }

    //根据主键删除线索
    @Override
    public void deleteClueById(String id) {
        //删除线索
        int i = clueMapper.deleteByPrimaryKey(id);
        if (i == 0) {
            throw new CrmException(CrmExceptionEnum.CLUE_DELETE_FAIL);
        }
        //删除备注
        Example example1 = new Example(ClueRemark.class);
        example1.createCriteria().andEqualTo("clueId", id);
        List<ClueRemark> clueRemarks = clueRemaekMapper.selectByExample(example1);
        int i1 = 0;
        if (clueRemarks.size() > 0) {
            i1 = clueRemaekMapper.deleteByExample(example1);
        }
        if (i1 != clueRemarks.size()) {
            throw new CrmException(CrmExceptionEnum.CLUE_DELETE_FAIL);
        }
        //删除关联的活动
        Example example = new Example(ClueActivityRelation.class);
        example.createCriteria().andEqualTo("clueId", id);
        int i2 = clueActivityRelationMapper.selectCountByExample(example);
        if (i2 > 0) {
            //删除
            int i3 = clueActivityRelationMapper.deleteByExample(example);
            if (i3 == 0) {
                throw new CrmException(CrmExceptionEnum.CLUE_DELETE_FAIL);
            }
        }
    }

    //添加线索
    @Override
    public void addClue(Clue clue) {
        clue.setCreateTime(DateTimeUtil.getSysTime());
        clue.setId(UUIDUtil.getUUID());
        int i = clueMapper.insertSelective(clue);
        if (i == 0) {
            //插入线索失败
            throw new CrmException(CrmExceptionEnum.CLUE_ADD_FAIL);
        }
    }

    //更新线索备注
    @Override
    public void updateClueRemark(ClueRemark clueRemark) {
        clueRemark.setEditFlag("1");
        clueRemark.setEditTime(DateTimeUtil.getSysTime());
        int i = clueRemaekMapper.updateByPrimaryKeySelective(clueRemark);
        if (i == 0) {
            throw new CrmException(CrmExceptionEnum.CLUE_REMARK_UPDATE_FAIL);
        }
    }

    //删除备注
    @Override
    public void deleteClueRemark(String id) {
        int i = clueRemaekMapper.deleteByPrimaryKey(id);
        if (i == 0) {
            throw new CrmException(CrmExceptionEnum.CLUE_REMARK_DELETE_FAIL);
        }
    }

    //添加备注
    @Override
    public ClueRemark addClueRemark(ClueRemark clueRemark) {
        clueRemark.setEditFlag("0");
        clueRemark.setCreateTime(DateTimeUtil.getSysTime());
        clueRemark.setId(UUIDUtil.getUUID());
        int i = clueRemaekMapper.insertSelective(clueRemark);
        if (i == 0) {
            throw new CrmException(CrmExceptionEnum.CLUE_REMARK_ADD_FAIL);
        }
        return clueRemark;
    }

    //删除线索活动关联成功
    @Override
    public void deleteClueActivityRelation(ClueActivityRelation clueActivityRelation) {
        Example example = new Example(ClueActivityRelation.class);
        example.createCriteria().andEqualTo("activityId", clueActivityRelation.getActivityId()).andEqualTo("clueId", clueActivityRelation.getClueId());
        int i = clueActivityRelationMapper.deleteByExample(example);
        if (i == 0) {
            throw new CrmException(CrmExceptionEnum.CLUE_ACTIVITY_DELETE_FAIL);
        }
    }

    //查询所有活动，除已关联的，模糊查询
    @Override
    public List<Activity> saveActivity(String id, String name) {
        //查询所有与当前线索关联的活动
        Example example = new Example(ClueActivityRelation.class);
        example.createCriteria().andEqualTo("clueId", id);
        List<ClueActivityRelation> clueActivityRelations = clueActivityRelationMapper.selectByExample(example);
        //将关联活动中的活动id放入一个字符串集合中
        List<String> ids = new ArrayList<>();
        for (ClueActivityRelation clueActivityRelation : clueActivityRelations) {
            ids.add(clueActivityRelation.getActivityId());
        }
        //模糊查询除已关联的，所有活动
        example = new Example(Activity.class);
        List<Activity> activities = null;
        if (ids.size() > 0) {
            if (name != null && name != "") {
                example.createCriteria().andLike("name", "%" + name + "%").andNotIn("id", ids);
            } else {
                example.createCriteria().andNotIn("id", ids);
            }
            activities = activityMapper.selectByExample(example);
        } else {
            activities = activityMapper.selectAll();
        }

        //将活动的owner换成所有者的名字
        for (Activity activity : activities) {
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());
        }
        return activities;
    }

    //添加关联活动
    @Override
    public void saveClueActivity(String clueId, String ids) {
        String[] idss = ids.split(",");
        for (String id : idss) {
            ClueActivityRelation clueActivityRelation = new ClueActivityRelation();
            clueActivityRelation.setActivityId(id);
            clueActivityRelation.setClueId(clueId);
            clueActivityRelation.setId(UUIDUtil.getUUID());
            int insert = clueActivityRelationMapper.insert(clueActivityRelation);
            if (insert == 0) {
                throw new CrmException(CrmExceptionEnum.CLUE_ACTIVITY_ADD_FAIL);
            }
        }
    }

    //查询所有与线索关联的活动
    @Override
    public List<Activity> saveActivitys(String id) {
        //查询所有与当前线索关联的活动
        Example example = new Example(ClueActivityRelation.class);
        example.createCriteria().andEqualTo("clueId", id);
        List<ClueActivityRelation> clueActivityRelations = clueActivityRelationMapper.selectByExample(example);
        List<String> ids = new ArrayList<>();
        for (ClueActivityRelation clueActivityRelation : clueActivityRelations) {
            ids.add(clueActivityRelation.getActivityId());
        }
        example = new Example(Activity.class);
        example.createCriteria().andIn("id", ids);
        List<Activity> activities = activityMapper.selectByExample(example);
        for (Activity activity : activities) {
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());
        }
        return activities;
    }

    //查询当前线索已绑定的活动，并支持活动名称模糊查询
    @Override
    public List<Activity> saveBindActivitys(String id, String acitvityName) {
        //查询所有与当前线索关联的活动
        Example example = new Example(ClueActivityRelation.class);
        example.createCriteria().andEqualTo("clueId", id);
        List<ClueActivityRelation> clueActivityRelations = clueActivityRelationMapper.selectByExample(example);
        if (clueActivityRelations.size() > 0) {
            List<String> ids = new ArrayList<>();
            for (ClueActivityRelation clueActivityRelation : clueActivityRelations) {
                ids.add(clueActivityRelation.getActivityId());
            }
            example = new Example(Activity.class);
            if (acitvityName != "" && acitvityName != null) {
                example.createCriteria().andIn("id", ids).andLike("name", "%" + acitvityName + "%");
            } else {
                example.createCriteria().andIn("id", ids);
            }
            List<Activity> activities = activityMapper.selectByExample(example);
            for (Activity activity : activities) {
                User user = userMapper.selectByPrimaryKey(activity.getOwner());
                activity.setOwner(user.getName());
            }
            return activities;
        }
        return null;
    }

    //线索转换客户
    @Override
    public void addclueConvertTran(String clueId, Tran tran, User user) {
        boolean flag = true;
        //查询线索信息
        Clue clue = clueMapper.selectByPrimaryKey(clueId);
        /*
        将线索信息置入客户表
        1.查看当前客户中是否含有该客户,如果有不创建客户，没有则创建客户
         */
        Example example = new Example(Customer.class);
        example.createCriteria().andEqualTo("name", clue.getCompany());
        List<Customer> customers = customerMapper.selectByExample(example);
        Customer customer = null;
        if (customers.size() == 0) {
            //新建客户
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setOwner(user.getId());
            customer.setName(clue.getCompany());
            customer.setWebsite(clue.getWebsite());
            customer.setPhone(clue.getPhone());
            customer.setCreateBy(user.getName());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setContactSummary(clue.getContactSummary());
            customer.setNextContactTime(clue.getNextContactTime());
            customer.setDescription(clue.getDescription());
            customer.setAddress(clue.getAddress());
            int count = customerMapper.insertSelective(customer);
            if (count == 0) {
                flag = false;
            }
        } else {
            customer = customers.get(0);
        }
        //将线索中联系人信息取出来保存在联系人表中
        Contacts contacts = new Contacts();
        contacts.setId(UUIDUtil.getUUID());
        contacts.setOwner(user.getId());
        contacts.setSource(clue.getSource());
        contacts.setCustomerId(customer.getId());
        contacts.setFullname(clue.getFullname());
        contacts.setAppellation(clue.getAppellation());
        contacts.setEmail(clue.getEmail());
        contacts.setMphone(clue.getMphone());
        contacts.setJob(clue.getJob());
        contacts.setCreateBy(user.getName());
        contacts.setCreateTime(DateTimeUtil.getSysTime());
        contacts.setDescription(clue.getDescription());
        contacts.setNextContactTime(clue.getNextContactTime());
        contacts.setAddress(clue.getAddress());
        int count = contactsMapper.insertSelective(contacts);
        if (count == 0) {
            flag = false;
        }
        //线索中的备注信息取出来保存在客户备注和联系人备注中
        example = new Example(ClueRemark.class);
        example.createCriteria().andEqualTo("clueId", clue.getId());
        List<ClueRemark> clueRemarks = clueRemaekMapper.selectByExample(example);
        for (ClueRemark clueRemark : clueRemarks) {
            //客户备注
            CustomerRemark customerRemark = new CustomerRemark();
            customerRemark.setId(UUIDUtil.getUUID());
            customerRemark.setCreateTime(DateTimeUtil.getSysTime());
            customerRemark.setEditFlag("0");
            customerRemark.setCreateBy(user.getName());
            customerRemark.setCustomerId(customer.getId());
            customerRemark.setNoteContent(clueRemark.getNoteContent());
            count = customerRemarkMapper.insertSelective(customerRemark);
            if (count == 0) {
                flag = false;
            }
            //联系人备注
            ContactsRemark contactsRemark = new ContactsRemark();
            contactsRemark.setContactsId(contacts.getId());
            contactsRemark.setCreateBy(user.getName());
            contactsRemark.setCreateTime(DateTimeUtil.getSysTime());
            contactsRemark.setId(UUIDUtil.getUUID());
            contactsRemark.setEditFlag("0");
            contactsRemark.setNoteContent(clueRemark.getNoteContent());
            count = contactsRemarkMapper.insertSelective(contactsRemark);
            if (count == 0) {
                flag = false;
            }
        }
        //将"线索和市场活动的关系"转换到"联系人和市场活动的关系中"
        example = new Example(ClueActivityRelation.class);
        example.createCriteria().andEqualTo("clueId", clue.getId());
        List<ClueActivityRelation> clueActivityRelations = clueActivityRelationMapper.selectByExample(example);
        for (ClueActivityRelation clueActivityRelation : clueActivityRelations) {
            ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
            contactsActivityRelation.setId(UUIDUtil.getUUID());
            contactsActivityRelation.setActivityId(clueActivityRelation.getActivityId());
            contactsActivityRelation.setContactsId(contacts.getId());
            count = contactsActivityRelationMapper.insertSelective(contactsActivityRelation);
            if (count == 0) {
                flag = false;
            }
        }
        //如果转换过程中发生了交易，创建一条新的交易，交易信息不全，
        // 后面可以通过修改交易来完善交易信息
        if (tran.getName() != null) {
            /*tran已存在money,name,expectedDate,stage,activityId*/
            tran.setId(UUIDUtil.getUUID());
            tran.setOwner(user.getId());
            tran.setCustomerId(customer.getId());
            tran.setSource(clue.getSource());
            tran.setContactsId(contacts.getId());
            tran.setCreateBy(user.getName());
            tran.setCreateTime(DateTimeUtil.getSysTime());
            tran.setDescription(clue.getDescription());
            tran.setContactSummary(clue.getContactSummary());
            tran.setNextContactTime(clue.getNextContactTime());
            count = tranMapper.insertSelective(tran);
            if (count == 0) {
                flag = false;
            }
            //创建该条交易对应的交易历史以及备注
            TranHistory tranHistory = new TranHistory();
            tranHistory.setId(UUIDUtil.getUUID());
            tranHistory.setCreateBy(user.getName());
            tranHistory.setCreateTime(DateTimeUtil.getSysTime());
            tranHistory.setExpectedDate(tran.getExpectedDate());
            tranHistory.setMoney(tran.getMoney());
            tranHistory.setStage(tran.getStage());
            tranHistory.setTranId(tran.getId());
            count = tranHistoryMapper.insertSelective(tranHistory);
            if (count == 0) {
                flag = false;
            }
        }
        //删除线索的备注信息
        example = new Example(ClueRemark.class);
        example.createCriteria().andEqualTo("clueId", clue.getId());
        count = clueRemaekMapper.selectCountByExample(example);
        if (count > 0) {
            count = clueRemaekMapper.deleteByExample(example);
            if (count == 0) {
                flag = false;
            }
        }
        //删除线索和市场活动的关联关系
        example = new Example(ClueActivityRelation.class);
        example.createCriteria().andEqualTo("clueId", clue.getId());
        count = clueActivityRelationMapper.selectCountByExample(example);
        if (count > 0) {
            count = clueActivityRelationMapper.deleteByExample(example);
            if (count == 0) {
                flag = false;
            }
        }
        //删除线索
        count = clueMapper.delete(clue);
        if (count == 0) {
            flag = false;
        }
        if (!flag) {
            throw new CrmException(CrmExceptionEnum.CLUE_CONVERT_CUSTOMER_FAIL);
        }
    }


}
