package com.yangxiansheng.crm.workbench.service.impl;

import com.yangxiansheng.crm.base.canstants.CrmExceptionEnum;
import com.yangxiansheng.crm.base.exception.CrmException;
import com.yangxiansheng.crm.base.util.DateTimeUtil;
import com.yangxiansheng.crm.base.util.UUIDUtil;
import com.yangxiansheng.crm.settings.bean.User;
import com.yangxiansheng.crm.settings.mapper.UserMapper;
import com.yangxiansheng.crm.workbench.bean.*;
import com.yangxiansheng.crm.workbench.mapper.*;
import com.yangxiansheng.crm.workbench.service.ContactsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.service.impl
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/24 0024 下午 19:04
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
@Service("contactsService")
public class ContactsServiceImpl implements ContactsService {

    @Autowired
    private ContactsMapper contactsMapper;
    @Autowired
    private ContactsRemarkMapper contactsRemarkMapper;
    @Autowired
    private ContactsActivityRelationMapper contactsActivityRelationMapper;
    @Autowired
    private CustomerMapper customerMapper;
    @Autowired
    private TranMapper tranMapper;
    @Autowired
    private ActivityMapper activityMapper;
    @Autowired
    private UserMapper userMapper;

    //跳转详情页
    @Override
    public Contacts toDetail(String id) {
        //根据主键查询联系人信息
        Contacts contacts = contactsMapper.selectByPrimaryKey(id);
        //添加的客户姓名
        Customer customer = customerMapper.selectByPrimaryKey(contacts.getCustomerId());
        if (customer != null) {
            contacts.setCustomerId(customer.getName());
        }
        //添加所有者姓名
        User user = userMapper.selectByPrimaryKey(contacts.getOwner());
        contacts.setOwner(user.getName());
        //查询联系人的备注
        Example example = new Example(ContactsRemark.class);
        example.createCriteria().andEqualTo("contactsId", id);
        List<ContactsRemark> contactsRemarks = contactsRemarkMapper.selectByExample(example);
        contacts.setContactsRemarks(contactsRemarks);
        //查询联系人相关的交易
        example = new Example(Tran.class);
        example.createCriteria().andEqualTo("contactsId", id);
        List<Tran> trans = tranMapper.selectByExample(example);
        contacts.setTrans(trans);
        //查询联系人相关的活动
        example = new Example(ContactsActivityRelation.class);
        example.createCriteria().andEqualTo("contactsId", id);
        List<ContactsActivityRelation> contactsActivityRelations = contactsActivityRelationMapper.selectByExample(example);
        List<Activity> activities = new ArrayList<>();
        for (ContactsActivityRelation contactsActivityRelation : contactsActivityRelations) {
            Activity activity = activityMapper.selectByPrimaryKey(contactsActivityRelation.getActivityId());
            user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());
            activities.add(activity);
        }
        contacts.setActivities(activities);
        return contacts;
    }

    //模糊查询，查询全部联系人信息,分页
    @Override
    public List<Map<String, String>> saveAllContacts(SaveContacts saveContacts) {
        return contactsMapper.saveAllContacts(saveContacts);
    }

    //添加联系人
    @Override
    public void addContacts(Contacts contacts, String company) {
        contacts.setId(UUIDUtil.getUUID());
        contacts.setCreateTime(DateTimeUtil.getSysTime());
        //判断联系人所属的客户是否存在
        if (contacts.getCustomerId().equals("1")) {
            //不存在，先创建客户
            Customer customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setName(company);
            customer.setAddress(contacts.getAddress());
            customer.setDescription(contacts.getDescription());
            customer.setNextContactTime(contacts.getNextContactTime());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setCreateBy(contacts.getCreateBy());
            customer.setOwner(contacts.getOwner());
            customer.setContactSummary(contacts.getContactSummary());
            int count = customerMapper.insertSelective(customer);
            if (count == 0) {
                throw new CrmException(CrmExceptionEnum.CONTACTS_ADD_FAIL);
            }
            count = contactsMapper.insertSelective(contacts);
            if (count == 0) {
                throw new CrmException(CrmExceptionEnum.CONTACTS_ADD_FAIL);
            }
        } else {
            //客户存在，创建联系人
            int count = contactsMapper.insertSelective(contacts);
            if (count == 0) {
                throw new CrmException(CrmExceptionEnum.CONTACTS_ADD_FAIL);
            }
        }
    }

    //根据主键查询联系人信息
    @Override
    public Contacts seveContactsById(String id) {
        Contacts contacts = contactsMapper.selectByPrimaryKey(id);
        Customer customer = customerMapper.selectByPrimaryKey(contacts.getCustomerId());
        contacts.setCustomerId(customer.getName());
        return contacts;
    }

    //根据主键删除联系人
    @Override
    public void deleteContactsById(String id) {
        int count = contactsMapper.deleteByPrimaryKey(id);
        if (count == 0) {
            throw new CrmException(CrmExceptionEnum.CONTACTS_DELETE_FAIL);
        }
        //查询联系人是否有备注
        Example example = new Example(ContactsRemark.class);
        example.createCriteria().andEqualTo("contactsId", id);
        count = contactsRemarkMapper.selectCountByExample(example);
        if (count > 0) {
            //有备注，进行删除
            count = contactsRemarkMapper.deleteByExample(example);
            if (count == 0) {
                throw new CrmException(CrmExceptionEnum.CONTACTS_DELETE_FAIL);
            }
        }
        //查看联系人是否与活动有关连
        example = new Example(ContactsActivityRelation.class);
        example.createCriteria().andEqualTo("contactsId", id);
        count = contactsActivityRelationMapper.selectCountByExample(example);
        if (count > 0) {
            //有活动关联，进行删除
            count = contactsActivityRelationMapper.deleteByExample(example);
            if (count == 0) {
                throw new CrmException(CrmExceptionEnum.CONTACTS_DELETE_FAIL);
            }
        }
    }

    //更新联系人信息
    @Override
    public void updateContacts(Contacts contacts, String company) {
        contacts.setEditTime(DateTimeUtil.getSysTime());
        //判断联系人所属的客户是否存在
        if (contacts.getCustomerId().equals("1")) {
            //不存在，先创建客户
            Customer customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setName(company);
            customer.setAddress(contacts.getAddress());
            customer.setDescription(contacts.getDescription());
            customer.setNextContactTime(contacts.getNextContactTime());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setCreateBy(contacts.getCreateBy());
            customer.setOwner(contacts.getOwner());
            customer.setContactSummary(contacts.getContactSummary());
            int count = customerMapper.insertSelective(customer);
            if (count == 0) {
                throw new CrmException(CrmExceptionEnum.CONTACTS_UPDATE_FAIL);
            }
        }
        //根据主键修改联系人信息
        int count = contactsMapper.updateByPrimaryKeySelective(contacts);
        if (count == 0) {
            throw new CrmException(CrmExceptionEnum.CONTACTS_UPDATE_FAIL);
        }
    }

    //添加备注
    @Override
    public ContactsRemark addContactsRemark(ContactsRemark contactsRemark) {
        contactsRemark.setEditFlag("0");
        contactsRemark.setId(UUIDUtil.getUUID());
        contactsRemark.setCreateTime(DateTimeUtil.getSysTime());
        contactsRemarkMapper.insertSelective(contactsRemark);
        return contactsRemark;
    }

    //修改备注
    @Override
    public void updateContactsRemark(ContactsRemark contactsRemark) {
        contactsRemark.setEditTime(DateTimeUtil.getSysTime());
        int count = contactsRemarkMapper.updateByPrimaryKeySelective(contactsRemark);
        if (count == 0) {
            throw new CrmException(CrmExceptionEnum.CONTACTS_REMARK_UPDATE_FAIL);
        }
    }

    //删除备注
    @Override
    public void deleteContactsRemark(String id) {
        int count = contactsRemarkMapper.deleteByPrimaryKey(id);
        if (count == 0) {
            throw new CrmException(CrmExceptionEnum.CONTACTS_REMARK_DELETE_FAIL);
        }
    }

    //解除关联活动
    @Override
    public void deleteContactsActivity(String id) {
        Example example = new Example(ContactsActivityRelation.class);
        example.createCriteria().andEqualTo("activityId", id);
        int count = contactsActivityRelationMapper.deleteByExample(example);
        if (count == 0) {
            throw new CrmException(CrmExceptionEnum.CONTACTS_ACTIVITY_UNBIND_FAIL);
        }
    }

    //异步查询除已关联的所有活动
    @Override
    public List<Activity> saveActivity(String id, String activityName) {
        //查询所有已关联的活动
        Example example = new Example(ContactsActivityRelation.class);
        example.createCriteria().andEqualTo("contactsId", id);
        List<ContactsActivityRelation> contactsActivityRelations = contactsActivityRelationMapper.selectByExample(example);
        List<String> list = new ArrayList<>();
        for (ContactsActivityRelation contactsActivityRelation : contactsActivityRelations) {
            list.add(contactsActivityRelation.getActivityId());
        }
        example = new Example(Activity.class);
        if (activityName != "" && activityName != null) {
            example.createCriteria().andLike("name", "%" + activityName + "%").andNotIn("id", list);
        } else {
            example.createCriteria().andNotIn("id", list);
        }
        List<Activity> activities = activityMapper.selectByExample(example);
        return activities;
    }


    //添加关联活动
    @Override
    public void addContactsActivity(String id, String ids) {
        String[] split = ids.split(",");
        for (String sql : split) {
            ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
            contactsActivityRelation.setId(UUIDUtil.getUUID());
            contactsActivityRelation.setActivityId(sql);
            contactsActivityRelation.setContactsId(id);
            int insert = contactsActivityRelationMapper.insert(contactsActivityRelation);
            if (insert == 0) {
                throw new CrmException(CrmExceptionEnum.CONTACTS_ACTIVITY_ADD_FAIL);
            }
        }
    }

    //异步查询已关联的所有活动
    @Override
    public List<Activity> saveActivities(String id) {
        Example example = new Example(ContactsActivityRelation.class);
        example.createCriteria().andEqualTo("contactsId", id);
        List<ContactsActivityRelation> contactsActivityRelations = contactsActivityRelationMapper.selectByExample(example);
        List<String> list = new ArrayList<>();
        for (ContactsActivityRelation contactsActivityRelation : contactsActivityRelations) {
            list.add(contactsActivityRelation.getActivityId());
        }
        example = new Example(Activity.class);
        example.createCriteria().andIn("id", list);
        List<Activity> activities = activityMapper.selectByExample(example);
        for (Activity activity : activities) {
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());
        }
        return activities;
    }

    //查找所有联系人，姓名模糊查询
    @Override
    public List<Contacts> saveContacts(String contactsName) {
        List<Contacts> list = null;
        if (contactsName != null && contactsName != "") {
            Example example = new Example(Contacts.class);
            example.createCriteria().andLike("fullname", "%" + contactsName + "%");
            list = contactsMapper.selectByExample(example);
        }else {
            list=contactsMapper.selectAll();
        }
        return list;
    }
}
