package com.yangxiansheng.crm.base.bean;

import com.github.pagehelper.PageInfo;
import com.yangxiansheng.crm.base.canstants.CrmConstansts;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;

import static javafx.scene.input.KeyCode.T;

/**
 * @ProjectName: crm
 * @Package: com.yangxiansheng.crm.base.bean
 * @Description: 用于分页的实体类
 * @Author: 杨先生
 * @CreateDate: 2020/11/17 0017 下午 20:40
 * @Version: 1.0
 * <p>
 * Copyright: Copyright (c) 2020
 */
public class PaginationVo<T> {
    private int pageNo;// 页码
    private int pageSizes;// 每页显示的记录条数
    private int Pages;// 总页数
    private int totals;// 总记录条数
    private int maxPerPage = CrmConstansts.MAXROWSPERPAGE;//没也最多显示几条数据
    private int PageLinks = CrmConstansts.PAGELINKS;// 显示几个卡片
    private List<T> dataList;//每页的实际的数据
    private PageInfo<T> pageInfo;

    //根据前台客户的选择决定PaginationVo的属性进行分页
    public PaginationVo(PageInfo<T> pageInfo) {
        this.pageNo = pageInfo.getPageNum();
        this.pageSizes = pageInfo.getPageSize();
        this.totals = (int) pageInfo.getTotal();// 总记录条数
        this.Pages = totals % pageSizes == 0 ? totals / pageSizes : totals / pageSizes + 1;// 总页数
        this.dataList = pageInfo.getList();//每页的实际的数据
        this.pageInfo = pageInfo;

    }

    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }

    public int getPageSizes() {
        return pageSizes;
    }

    public void setPageSizes(int pageSizes) {
        this.pageSizes = pageSizes;
    }

    public int getPages() {
        return Pages;
    }

    public void setPages(int pages) {
        Pages = pages;
    }

    public int getTotals() {
        return totals;
    }

    public void setTotals(int totals) {
        this.totals = totals;
    }

    public int getMaxPerPage() {
        return maxPerPage;
    }

    public void setMaxPerPage(int maxPerPage) {
        this.maxPerPage = maxPerPage;
    }

    public int getPageLinks() {
        return PageLinks;
    }

    public void setPageLinks(int pageLinks) {
        PageLinks = pageLinks;
    }

    public List<T> getDataList() {
        return dataList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }

    public PageInfo<T> getPageInfo() {
        return pageInfo;
    }

    public void setPageInfo(PageInfo<T> pageInfo) {
        this.pageInfo = pageInfo;
    }
}
