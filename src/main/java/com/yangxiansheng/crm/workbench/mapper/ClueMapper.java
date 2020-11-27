package com.yangxiansheng.crm.workbench.mapper;

import com.yangxiansheng.crm.workbench.bean.Clue;
import com.yangxiansheng.crm.workbench.bean.SaveClue;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.workbench.mapper
 * @Description: java类作用描述
 * @Author: 杨先生
 * @CreateDate: 2020/11/21 0021 下午 19:44
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public interface ClueMapper extends Mapper<Clue> {
    //查询所有信息
    List<Map<String,String>> saveAllClue(SaveClue saveClue);
}
