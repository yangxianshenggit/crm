package com.yangxiansheng.crm.base.exception;

import com.yangxiansheng.crm.base.canstants.CrmExceptionEnum;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.base.exception
 * @Description: 因为系统中需要给客户端返回各种信息，用户登录、市场活动、交易，
 * 为了可扩展性和低耦合性以及可维护性，采取自定义异常解决
 * @Author: 杨先生
 * @CreateDate: 2020/11/16 0016 下午 20:27
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public class CrmException extends RuntimeException {
    private CrmExceptionEnum exceptionEnum;

    public CrmException(CrmExceptionEnum exceptionEnum) {
        super(exceptionEnum.getMess());//将异常信息放在堆栈信息中
        this.exceptionEnum = exceptionEnum;
    }

    public CrmExceptionEnum getExceptionEnum() {
        return exceptionEnum;
    }

    public void setExceptionEnum(CrmExceptionEnum exceptionEnum) {
        this.exceptionEnum = exceptionEnum;
    }
}
