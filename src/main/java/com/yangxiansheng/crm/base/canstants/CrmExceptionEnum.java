package com.yangxiansheng.crm.base.canstants;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.base.canstants
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/16 0016 下午 20:30
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public enum CrmExceptionEnum {
    LOGIN_ACCOUNT_ERROR("001","用户名或密码错误"),
    LOGIN_ACCOUNT_EXPIRE("001","账户已失效"),
    LOGIN_ACCOUNT_FORBID("001","账户被禁用"),
    LOGIN_ACCOUNT_IP("001","异地登录"),
    ACTIVITY_INSERT_FAIL("002","活动创建失败"),
    ACTIVITY_UPDATE_FAIL("002","活动更新失败"),
    ACTIVITY_DELETE_FAIL("002","活动删除失败"),
    ACTIVITY_REMARK_UPDATE_FAIL("002","备注更新失败"),
    ACTIVITY_REMARK_DELETE_FAIL("002","备注删除失败"),
    ACTIVITY_REMARK_INSERT_FAIL("002","添加备注失败"),
    CUSTOMER_CREATE_FAIL("003","添加客户失败"),
    CUSTOMER_UPDATE_FAIL("003","修改客户信息失败"),
    CUSTOMER_REMARK_UPDATE_FAIL("003","修改客户备注失败"),
    CUSTOMER_REMARK_DELETE_FAIL("003","删除客户备注失败"),
    CUSTOMER_REMARK_ADD_FAIL("003","添加客户备注失败"),
    CUSTOMER_ADD_FAIL("003","创建客户失败"),
    CLUE_COMPANY_ADD_FAIL("004","该公司名称已存在"),
    CLUE_ADD_FAIL("004","添加线索失败"),
    CLUE_UPDATE_FAIL("004","更新线索失败"),
    CLUE_DELETE_FAIL("004","更新线索失败"),
    CLUE_REMARK_UPDATE_FAIL("004","更新线索备注失败"),
    CLUE_REMARK_DELETE_FAIL("004","删除线索备注失败"),
    CLUE_REMARK_ADD_FAIL("004","添加线索备注失败"),
    CLUE_ACTIVITY_DELETE_FAIL("004","删除线索活动关联失败"),
    CLUE_ACTIVITY_ADD_FAIL("004","添加线索活动关联失败"),
    CLUE_CONVERT_CUSTOMER_FAIL("004","线索转换客户失败"),
    TRAN_DELETE_FAIL("005","删除交易失败"),
    CONTACTS_ADD_FAIL("006","创建联系人失败"),
    CONTACTS_UPDATE_FAIL("006","修改联系人信息失败"),
    CONTACTS_DELETE_FAIL("006","删除联系人失败"),
    CONTACTS_REMARK_UPDATE_FAIL("006","修改联系人备注失败"),
    CONTACTS_REMARK_DELETE_FAIL("006","删除联系人备注失败"),
    CONTACTS_ACTIVITY_UNBIND_FAIL("006","解除关联活动失败"),
    CONTACTS_ACTIVITY_ADD_FAIL("006","添加关联活动失败"),
    TRAN_ADD_FAIL("007","创建交易失败"),
    TRAN_REMARK_ADD_FAIL("007","创建交易备注失败"),
    TRAN_REMARK_DELETE_FAIL("007","删除交易备注失败"),
    TRAN_UPDATE_FAIL("007","修改交易信息失败");
    private String code;//业务状态码 001：用户登录  002：交易模块
    private String mess;//消息

    CrmExceptionEnum(String code, String mess) {
        this.code = code;
        this.mess = mess;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getMess() {
        return mess;
    }

    public void setMess(String mess) {
        this.mess = mess;
    }}

