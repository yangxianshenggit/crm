package com.yangxiansheng.crm.base.bean;

import org.springframework.stereotype.Component;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.base.bean
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/18 0018 上午 9:46
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
//返回前台消息
@Component
public class Message {
    private boolean success;
    private Object mess;

    @Override
    public String toString() {
        return "Message{" +
                "success=" + success +
                ", mess=" + mess +
                '}';
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public Object getMess() {
        return mess;
    }

    public void setMess(Object mess) {
        this.mess = mess;
    }
}
