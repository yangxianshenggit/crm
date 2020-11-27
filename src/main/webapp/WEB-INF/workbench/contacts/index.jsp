<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">

    <link href="/crm/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="/crm/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>
    <link rel="stylesheet" href="/crm/jquery/bs_pagination/jquery.bs_pagination.min.css" type="text/css"/>
    <script type="text/javascript" src="/crm/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="/crm/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="/crm/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="/crm/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
    <script type="text/javascript"
            src="/crm/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
    <script type="text/javascript"
            src="/crm/jquery/bs_pagination/en.js"></script>
    <script type="text/javascript"
            src="/crm/jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>

    <script type="text/javascript">

        $(function () {

            //定制字段
            $("#definedColumns > li").click(function (e) {
                //防止下拉菜单消失
                e.stopPropagation();
            });

        });

    </script>
</head>
<body>


<!-- 创建联系人的模态窗口 -->
<div class="modal fade" id="createContactsModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabelx">创建联系人</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="createContactsForm" role="form">

                    <div class="form-group">
                        <label for="create-contactsOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="owner" id="create-contactsOwner">

                            </select>
                        </div>
                        <label for="create-clueSource" class="col-sm-2 control-label">来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="source" id="create-clueSource">
                                <option></option>
                                <c:forEach items="${dictionaryTypes}" var="dictionaryType">
                                    <c:if test="${dictionaryType.code =='source'}">
                                        <c:forEach items="${dictionaryType.dictionaryValues}" var="dictionaryValue">
                                            <option value="${dictionaryValue.value}">${dictionaryValue.text}</option>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-surname" class="col-sm-2 control-label">姓名<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="fullname" id="create-surname"/>
                        </div>
                        <label for="create-call" class="col-sm-2 control-label">称呼</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="appellation" id="create-call">
                                <option></option>
                                <c:forEach items="${dictionaryTypes}" var="dictionaryType">
                                    <c:if test="${dictionaryType.code =='appellation'}">
                                        <c:forEach items="${dictionaryType.dictionaryValues}" var="dictionaryValue">
                                            <option value="${dictionaryValue.value}">${dictionaryValue.text}</option>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>

                    </div>

                    <div class="form-group">
                        <label for="create-job" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="job" id="create-job">
                        </div>
                        <label for="create-mphone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="mphone" id="create-mphone">
                        </div>
                    </div>

                    <div class="form-group" style="position: relative;">
                        <label for="create-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="email" id="create-email">
                        </div>
                        <label for="create-birth" class="col-sm-2 control-label">生日</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="birth" readonly class="form-control" id="create-birth">
                        </div>
                    </div>

                    <div class="form-group" style="position: relative;">
                        <label for="create-customerName" class="col-sm-2 control-label">客户名称</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-customerName"
                                   placeholder="支持自动补全，输入客户不存在则新建"/><input type="hidden" name="customerId"/>
                        </div>
                    </div>

                    <div class="form-group" style="position: relative;">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" name="description" id="create-describe"></textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" name="contactSummary"
                                          id="create-contactSummary1"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-nextContactTime1" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" name="nextContactTime" readonly class="form-control"
                                       id="create-nextContactTime1">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="edit-address1" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" name="address" rows="1" id="edit-address1"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="addContacts()">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改联系人的模态窗口 -->
<div class="modal fade" id="editContactsModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">修改联系人</h4>
            </div>
            <div class="modal-body">
                <form id="updateContactsForm" class="form-horizontal" role="form">
                    <input type="hidden" name="id" id="contactsId"/>
                    <div class="form-group">
                        <label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="owner" id="edit-contactsOwner">
                            </select>
                        </div>
                        <label for="edit-clueSource1" class="col-sm-2 control-label">来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" neme="source" id="edit-clueSource1">
                                <option></option>
                                <c:forEach items="${dictionaryTypes}" var="dictionaryType">
                                    <c:if test="${dictionaryType.code =='source'}">
                                        <c:forEach items="${dictionaryType.dictionaryValues}" var="dictionaryValue">
                                            <option value="${dictionaryValue.value}">${dictionaryValue.text}</option>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-surname" class="col-sm-2 control-label">姓名<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="fullname" id="edit-surname"/>
                        </div>
                        <label for="edit-call" class="col-sm-2 control-label">称呼</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="appellation" id="edit-call">
                                <option></option>
                                <c:forEach items="${dictionaryTypes}" var="dictionaryType">
                                    <c:if test="${dictionaryType.code =='appellation'}">
                                        <c:forEach items="${dictionaryType.dictionaryValues}" var="dictionaryValue">
                                            <option value="${dictionaryValue.value}">${dictionaryValue.text}</option>
                                        </c:forEach>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-job" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="job" id="edit-job"/>
                        </div>
                        <label for="edit-mphone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-mphone" name="mphone"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="email" id="edit-email"/>
                        </div>
                        <label for="edit-birth" class="col-sm-2 control-label">生日</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="birth" readonly id="edit-birth"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" <%--name="company"--%> class="form-control" id="edit-customerName"
                                   placeholder="支持自动补全，输入客户不存在则新建"/>
                            <input type="hidden" name="customerId" id="customerId"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" name="description" id="edit-describe"></textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" name="contactSummary"
                                          id="create-contactSummary"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="create-nextContactTime"
                                       name="nextContactTime" readonly/>
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="edit-address2" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" name="address" id="edit-address2"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="updateContacts()">更新</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>联系人列表</h3>
        </div>
    </div>
</div>

<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">

    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" id="contactsForm" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" name="owner" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">姓名</div>
                        <input class="form-control" name="contactsName" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">客户名称</div>
                        <input class="form-control" name="company" type="text">
                    </div>
                </div>

                <br>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">来源</div>
                        <select class="form-control" name="source" id="edit-clueSource">
                            <option></option>
                            <c:forEach items="${dictionaryTypes}" var="dictionaryType">
                                <c:if test="${dictionaryType.code =='source'}">
                                    <c:forEach items="${dictionaryType.dictionaryValues}" var="dictionaryValue">
                                        <option value="${dictionaryValue.value}">${dictionaryValue.text}</option>
                                    </c:forEach>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">生日</div>
                        <input class="form-control" readonly name="birth" id="saveBirth" type="text">
                    </div>
                </div>
                <button type="button" onclick="saveAllContacts(1,2)" class="btn btn-default">查询</button>
            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" onclick="insertContacts()">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button type="button" class="btn btn-default" onclick="updateShow()"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" class="btn btn-danger" onclick="deleteContacts()"><span
                        class="glyphicon glyphicon-minus"></span> 删除
                </button>
            </div>


        </div>
        <div style="position: relative;top: 20px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="parent"/></td>
                    <td>姓名</td>
                    <td>客户名称</td>
                    <td>所有者</td>
                    <td>来源</td>
                    <td>生日</td>
                </tr>
                </thead>
                <tbody id="contacts">
                </tbody>
            </table>
        </div>

        <div id="contactsPage" style="height: 50px; position: relative;top: 10px;">
        </div>
    </div>

</div>
</body>
</html>
<script>

    //查询生日设置日期插件
    $('#saveBirth').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });
    //创建联系人生日选框
    $('#create-birth').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });
    $('#create-nextContactTime1').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });
    $('#edit-birth').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });
    $('#create-nextContactTime').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });

    //模糊查询，查询所有联系人
    function saveAllContacts(pageNo, pageSizes) {
        //表单序列化
        var contactsForm = $('#contactsForm').serialize();
        $.ajax({
            url: '/crm/workbench/contacts/saveAllContacts?' + contactsForm,
            data: {
                'pageNo': pageNo,
                'pageSizes': pageSizes
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                //清空上次查询的内容
                $('#contacts').empty();
                var list = data.dataList;
                for (var i = 0; i < list.length; i++) {
                    $('#contacts').append("<tr class=\"active\" >\n" +
                        "    <td><input type=\"checkbox\" class='son' value='" + list[i].id + "'/></td>\n" +
                        "        <td><a style=\"text-decoration: none; cursor: pointer;\"\n" +
                        "    href='/crm/workbench/contacts/toDetail?id="+list[i].id +"'>" + list[i].fullname + "</a></td>\n" +
                        "    <td>" + list[i].sname + "</td>\n" +
                        "    <td>" + list[i].uname + "</td>\n" +
                        "    <td>" + list[i].source + "</td>\n" +
                        "    <td>" + list[i].birth + "</td>\n" +
                        "    </tr>");
                }
                /*采用bootstrap分页插件*/
                $("#contactsPage").bs_pagination({
                    currentPage: data.pageNo, // 页码
                    rowsPerPage: data.pageSizes, // 每页显示的记录条数
                    maxRowsPerPage: data.maxPerPage, // 每页最多显示的记录条数
                    totalPages: data.Pages, // 总页数
                    totalRows: data.totals, // 总记录条数
                    visiblePageLinks: data.PageLinks, // 显示几个卡片
                    showGoToPage: true,
                    showRowsPerPage: true,
                    showRowsInfo: true,
                    showRowsDefaultInfo: true,
                    onChangePage: function (event, obj) {
                        saveAllContacts(obj.currentPage, obj.rowsPerPage);
                    }
                });
            }
        });
    };

    //点击新建联系人按钮
    function insertContacts() {
        //异步查询所有者信息
        $.ajax({
            url: '/crm/workbench/saveOwner',
            type: 'post',
            dataType: 'json',
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    $('#create-contactsOwner').append("<option value=" + data[i].id + " >" + data[i].name + "</option>")
                }
                /* //循环异步的所有者，当等于owner时将当前的option的seleted属性挑选出来
                 $('#edit-marketActivityOwner option').each(function () {
                     if (owner == $(this).val()) {
                         $(this).prop("selected", true);
                     }
                 })*/
                //显示模态窗
                $('#createContactsModal').modal('show');
            }
        });
    };
    //新建联系人     自动补全功能
    $('#create-customerName').typeahead({
        source: function (customerName, process) {
            $.post(
                "/crm/workbench/customer/queryCustomerName",
                {"customerName": customerName},
                function (data) {
                    //alert(data);
                    process(data);
                },
                "json"
            );
        },
        //输入内容后延迟多长时间弹出提示内容
        delay: 1000
    });
    //当客户名称input失去焦点时异步查询
    $('#create-customerName').blur(function () {
        $.ajax({
            url: '/crm/workbench/customer/saveCustomerName',
            data: {
                'company': $(this).val()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                $('#create-customerName').next().val(data.mess);
            }
        });
    });

    //点击保存联系人按钮
    function addContacts() {
        //姓名不能为空
        if ($('#create-surname').val() == undefined && $('#create-surname').val() == "") {
            alert("姓名不能为空");
            return;
        } else {
            //表单序列化
            var serialize = $('#createContactsForm').serialize();
            //异步提交表单
            $.ajax({
                url: '/crm/workbench/contacts/addContacts?' + serialize,
                data: {
                    'company': $('#create-customerName').val()
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    alert(data.mess);
                    if (data.success) {
                        $('#createContactsModal').modal('hide');
                        //刷新界面
                        saveAllContacts(1, 2);
                    }
                }
            });
        }
    };

    //修改联系人
    function updateShow() {
        //异步查询所选联系人的信息
        if ($('.son:checked').length == 0) {
            alert("请选择您要修改的联系人")
        } else if ($('.son:checked').length > 1) {
            alert("每次只能修改一位联系人信息")
        } else {
            $('#edit-contactsOwner').empty();
            //异步查询所有者信息
            $.ajax({
                url: '/crm/workbench/saveOwner',
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        $('#edit-contactsOwner').append("<option value=" + data[i].id + " >" + data[i].name + "</option>")
                    }
                }
            });
            var contactsId = $('.son:checked').val();
            $.ajax({
                url: '/crm/workbench/contacts/seveContactsById',
                data: {
                    'id': contactsId
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    $('#contactsId').val(data.id);
                    $('#edit-contactsOwner option').each(function () {
                        if ($(this).val() == data.owner) {
                            $(this).prop("selected", true);
                        }
                    });
                    $('#edit-clueSource1 option').each(function () {
                        if ($(this).text() == data.source) {
                            $(this).prop("selected", true);
                        }
                    });
                    $('#edit-surname').val(data.fullname);
                    $('#edit-call option').each(function () {
                        if ($(this).val() == data.appellation) {
                            $(this).prop("selected", true);
                        }
                    });
                    $('#edit-job').val(data.job);
                    $('#edit-mphone').val(data.mphone);
                    $('#edit-email').val(data.email);
                    $('#edit-birth').val(data.birth);
                    $('#edit-customerName').val(data.customerId);
                    //异步查询对应的客户id
                    $.ajax({
                        url: '/crm/workbench/customer/saveCustomerName',
                        data: {
                            'company': data.customerId
                        },
                        dataType: 'json',
                        type: 'post',
                        success: function (data) {
                            $('#customerId').val(data.mess);
                        }
                    });
                    $('#edit-describe').val(data.description);
                    $('#create-contactSummary').val(data.contactSummary);
                    $('#create-nextContactTime').val(data.nextContactTime);
                    $('#edit-address2').val(data.address);
                    $('#editContactsModal').modal('show');
                }
            });
        }
    };
    //新建联系人     自动补全功能
    $('#edit-customerName').typeahead({
        source: function (customerName, process) {
            $.post(
                "/crm/workbench/customer/queryCustomerName",
                {"customerName": customerName},
                function (data) {
                    //alert(data);
                    process(data);
                },
                "json"
            );
        },
        //输入内容后延迟多长时间弹出提示内容
        delay: 1000
    });
    //当客户名称input失去焦点时异步查询
    $('#edit-customerName').blur(function () {
        $.ajax({
            url: '/crm/workbench/customer/saveCustomerName',
            data: {
                'company': $(this).val()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                $('#edit-customerName').next().val(data.mess);
            }
        });
    });

    //点击更新按钮触发事件
    function updateContacts() {
        //表单序列化
        var serialize = $('#updateContactsForm').serialize();
        $.ajax({
            url: '/crm/workbench/contacts/updateContacts?' + serialize,
            data: {'company': $('#edit-customerName').val()},
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.mess);
                if (data.success) {
                    //修改成功，关闭模态窗
                    $('#editContactsModal').modal('hide');
                    //刷新界面
                    saveAllContacts(1, 2);
                }
            }
        });
    }

    //点击删除按钮
    function deleteContacts() {
        if ($('.son:checked').length == 0) {
            alert("请选择您要删除的联系人")
        } else if ($('.son:checked').length > 1) {
            alert("一次只能删除一为联系人")
        } else {
            var flag = confirm("您确定要删除这位联系人么？");
            if (flag) {
                $.ajax({
                    url:'/crm/workbench/contacts/deleteContactsById',
                    data:{'id':$('.son:checked').val()},
                    dataType:'json',
                    type:'post',
                    success:function (data) {
                        alert(data.mess);
                        if (data.success){
                            saveAllContacts(1,2);
                        }
                    }
                });
            }
        }
    }
    saveAllContacts(1, 2);
</script>

