<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

</head>
<body>

<!-- 查找市场活动 -->
<div class="modal fade" id="findMarketActivity" role="dialog">
    <div class="modal-dialog" role="document" style="width: 80%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">查找市场活动</h4>
                <button onclick="addActivity()">添加</button>
            </div>
            <div class="modal-body">
                <div class="btn-group" style="position: relative; top: 18%; left: 8px;">
                    <form class="form-inline" role="form">
                        <div class="form-group has-feedback">
                            <input type="text" class="form-control" style="width: 300px;"
                                   id="activityName" placeholder="请输入市场活动名称，支持模糊查询">
                            <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>
                    </form>
                </div>
                <table id="activityTable4" class="table table-hover"
                       style="width: 900px; position: relative;top: 10px;">
                    <thead>
                    <tr style="color: #B3B3B3;">
                        <td></td>
                        <td>名称</td>
                        <td>开始日期</td>
                        <td>结束日期</td>
                        <td>所有者</td>
                    </tr>
                    </thead>
                    <tbody id="activities">

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<!-- 查找联系人 -->
<div class="modal fade" id="findContacts" role="dialog">
    <div class="modal-dialog" role="document" style="width: 80%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">查找联系人</h4>
                <button onclick="addContact()">添加</button>
            </div>
            <div class="modal-body">
                <div class="btn-group" style="position: relative; top: 18%; left: 8px;">
                    <form class="form-inline" role="form">
                        <div class="form-group has-feedback">
                            <input id="contactsName" type="text" class="form-control" style="width: 300px;"
                                   placeholder="请输入联系人名称，支持模糊查询">
                            <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>
                    </form>
                </div>
                <table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
                    <thead>
                    <tr style="color: #B3B3B3;">
                        <td></td>
                        <td>名称</td>
                        <td>邮箱</td>
                        <td>手机</td>
                    </tr>
                    </thead>
                    <tbody id="contacts">
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<%------------------------------------------------------------------------------------%>
<div style="position:  relative; left: 30px;">
    <h3>更新交易</h3>
    <div style="position: relative; top: -40px; left: 70%;">
        <button type="button" onclick="updateTran()" class="btn btn-primary">更新</button>
        <button type="button" href="/crm/toView/transaction/index" class="btn btn-default">取消</button>
    </div>
    <hr style="position: relative; top: -40px;">
</div>
<form class="form-horizontal" id="updateTranForm" role="form" style="position: relative; top: -30px;">
    <div class="form-group">
        <label for="edit-transactionOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <select class="form-control" name="owner" id="edit-transactionOwner">
            </select>
        </div>
        <label for="edit-amountOfMoney" class="col-sm-2 control-label">金额</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" name="money" value="${tran.money}" id="edit-amountOfMoney"/>
        </div>
    </div>

    <div class="form-group">
        <label for="edit-transactionName" class="col-sm-2 control-label">名称<span
                style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" name="name" id="edit-transactionName" value="${tran.name}">
        </div>
        <label for="edit-expectedClosingDate" class="col-sm-2 control-label">预计成交日期<span
                style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" name="expectedDate" id="edit-expectedClosingDate" readonly
                   value="${tran.expectedDate}">
        </div>
    </div>

    <div class="form-group">
        <label for="edit-accountName" class="col-sm-2 control-label">客户名称<span
                style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" class="form-control" onblur="saveCustomerName()" id="edit-accountName"
                   value="${tran.customerId}" name="customerName" placeholder="支持自动补全，输入客户不存在则新建"/>
            <input type="hidden" name="customerId" id="customerId"/>
        </div>
        <label for="edit-transactionStage" class="col-sm-2 control-label">阶段<span
                style="font-size: 15px; color: red;">*</span></label>
        <div class="col-sm-10" style="width: 300px;">
            <select class="form-control" name="stage" id="edit-transactionStage">
                <c:forEach items="${dictionaryTypes}" var="dictionaryType">
                    <c:if test="${dictionaryType.code =='stage'}">
                        <c:forEach items="${dictionaryType.dictionaryValues}" var="dictionaryValue">
                            <option value="${dictionaryValue.value}">${dictionaryValue.text}</option>
                        </c:forEach>
                    </c:if>
                </c:forEach>
            </select>
        </div>
    </div>

    <div class="form-group">
        <label for="edit-transactionType" class="col-sm-2 control-label">类型</label>
        <div class="col-sm-10" style="width: 300px;">
            <select class="form-control" name="type" id="edit-transactionType">
                <c:forEach items="${dictionaryTypes}" var="dictionaryType">
                    <c:if test="${dictionaryType.code =='transactionType'}">
                        <c:forEach items="${dictionaryType.dictionaryValues}" var="dictionaryValue">
                            <option value="${dictionaryValue.value}">${dictionaryValue.text}</option>
                        </c:forEach>
                    </c:if>
                </c:forEach>
            </select>
        </div>
        <label for="edit-possibility" class="col-sm-2 control-label">可能性</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" readonly class="form-control" id="edit-possibility"
                   value="${ stage2PossibilityMap.get(tran.stage)}">
        </div>
    </div>

    <div class="form-group">
        <label for="edit-clueSource" class="col-sm-2 control-label">来源</label>
        <div class="col-sm-10" style="width: 300px;">
            <select class="form-control" name="source" id="edit-clueSource">
                <c:forEach items="${dictionaryTypes}" var="dictionaryType">
                    <c:if test="${dictionaryType.code =='source'}">
                        <c:forEach items="${dictionaryType.dictionaryValues}" var="dictionaryValue">
                            <option value="${dictionaryValue.value}">${dictionaryValue.text}</option>
                        </c:forEach>
                    </c:if>
                </c:forEach>
            </select>
        </div>
        <label for="edit-activitySrc" class="col-sm-2 control-label">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);"
                                                                                         onclick="saveAllActivity()"><span
                class="glyphicon glyphicon-search"></span></a></label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" readonly class="form-control" id="edit-activitySrc"/>
            <input type="hidden" name="activityId" value="${tran.activityId}" id="activityId"/>
        </div>
    </div>

    <div class="form-group">
        <label for="edit-contactsName" class="col-sm-2 control-label">联系人名称&nbsp;&nbsp;<a href="javascript:void(0);"
                                                                                          onclick="saveContacts()"><span
                class="glyphicon glyphicon-search"></span></a></label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" readonly class="form-control" value="${tran.contactsId}" id="edit-contactsName"/>
            <input type="hidden" name="contactsId"/>
        </div>
    </div>

    <div class="form-group">
        <label for="create-describe" class="col-sm-2 control-label">描述</label>
        <div class="col-sm-10" style="width: 70%;">
            <textarea class="form-control" name="description" rows="3"
                      id="create-describe">${tran.description}</textarea>
        </div>
    </div>

    <div class="form-group">
        <label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
        <div class="col-sm-10" style="width: 70%;">
            <textarea class="form-control" name="contactSummary" rows="3"
                      id="create-contactSummary">${tran.contactSummary}</textarea>
        </div>
    </div>

    <div class="form-group">
        <label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
        <div class="col-sm-10" style="width: 300px;">
            <input type="text" readonly name="nextContactTime" class="form-control" id="create-nextContactTime"
                   value="${tran.nextContactTime}"/>
        </div>
    </div>

</form>
</body>
</html>
<script>
    //预计成交日期
    $('#edit-expectedClosingDate').datetimepicker({
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
    //根据客户名称，异步查询客户id
    $.ajax({
        url: '/crm/workbench/customer/saveCustomerName',
        data: {
            'company': '${tran.customerId}'
        },
        type: 'post',
        dataType: 'json',
        success: function (data) {
            $('#customerId').val(data.mess);

        }
    });

    $('#edit-accountName').typeahead({
        source: function (customerName, process) {
            $.post(
                "/crm/workbench/customer/queryCustomerName",
                {"customerName": $('#edit-accountName').val()},
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
    //当客户名称input失去焦点时异步查询对应id
    $('#edit-accountName').blur(function () {
        $.ajax({
            url: '/crm/workbench/customer/saveCustomerName',
            data: {
                'company': $(this).val()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                $('#customerId').val(data.mess);
            }
        });
    });

    initEdit();

    //初始化界面方法
    function initEdit() {
        //异步查询所有者信息
        $.ajax({
            url: '/crm/workbench/saveOwner',
            type: 'post',
            dataType: 'json',
            success: function (data) {
                $('#edit-transactionOwner').empty();
                for (var i = 0; i < data.length; i++) {
                    $('#edit-transactionOwner').append("<option value=" + data[i].id + " >" + data[i].name + "</option>")
                }
                //循环异步的所有者，当等于owner时将当前的option的seleted属性挑选出来
                $('#edit-transactionOwner option').each(function () {
                    if ('${tran.owner}' == $(this).val()) {
                        $(this).prop("selected", true);
                    }
                })
            }
        });
        //阶段
        $('#edit-transactionStage option').each(function () {

            //alert($(this).val().substr(2, $(this).val().length - 2));
            if ($(this).val() == '${tran.stage}') {
                $(this).prop("selected", true);
            }
        });
        //类型
        $('#edit-transactionType option').each(function () {
            if ($(this).val() == '${tran.type}') {
                $(this).prop("selected", true);
            }
        });
        //来源
        $('#edit-clueSource option').each(function () {
            if ($(this).val() == '${tran.source}') {
                $(this).prop("selected", true);
            }
        });
        //根据活动id查询活动名称
        $.ajax({
            url: '/crm/workbench/selectActivityById',
            data: {'ids': '${tran.activityId}'},
            dataType: 'json',
            type: 'post',
            success: function (data) {
                $('#edit-activitySrc').val(data[0].name);
            }
        });
        //根据联系人姓名查询联系人id
        $.ajax({
            url: '/crm/workbench/contacts/saveContacts',
            data: {
                'contactsName': '${tran.contactsId}'
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                $('#edit-contactsName').next().val(data[0].id);
            }
        });
    }

    //查询活动源
    function saveAllActivity() {
        $.ajax({
            url: '/crm/workbench/activity/saveActivity',
            data: {
                'activityName': $('#activityName').val()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                $('#activities').empty();
                for (var i = 0; i < data.length; i++) {
                    $('#activities').append("<tr >\n" +
                        "                        <td><input type=\"radio\" name='activityName' class='son' value='" + data[i].id + "'/></td>\n" +
                        "                        <td>" + data[i].name + "</td>\n" +
                        "                        <td>" + data[i].startDate + "</td>\n" +
                        "                        <td>" + data[i].endDate + "</td>\n" +
                        "                        <td>" + data[i].owner + "</td>\n" +
                        "                    </tr>")
                }
                $('#findMarketActivity').modal('show');
            }
        });
    };
    $('#activityName').keypress(function (event) {
        if (event.keyCode == 13) {
            $.ajax({
                url: '/crm/workbench/activity/saveActivity',
                data: {
                    'activityName': $('#activityName').val()
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    $('#activities').empty();
                    for (var i = 0; i < data.length; i++) {
                        $('#activities').append("<tr >\n" +
                            "                        <td><input type=\"radio\" class='son' value='" + data[i].id + "' /></td>\n" +
                            "                        <td>" + data[i].name + "</td>\n" +
                            "                        <td>" + data[i].startDate + "</td>\n" +
                            "                        <td>" + data[i].endDate + "</td>\n" +
                            "                        <td>" + data[i].owner + "</td>\n" +
                            "                    </tr>")
                    }
                }
            });
        }
        return false;
    });

    //添加市场活动源
    function addActivity() {
        var id = $('.son:checked').val();
        var name = $('.son:checked').parent().next().text();
        //将值设置到对应的input中
        $('#edit-activitySrc').val(name);
        $('#edit-activitySrc').next().val(id);
        $('#findMarketActivity').modal('hide');
    };

    //查询联系人edit-contactsName
    function saveContacts() {
        $.ajax({
            url: '/crm/workbench/contacts/saveContacts',
            data: {
                'contactsName': $('#contactsName').val()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                $('#contacts').empty();
                for (var i = 0; i < data.length; i++) {
                    $('#contacts').append("<tr>\n" +
                        "    <td><input type=\"radio\" class=\"activity\" value='" + data[i].id + "'/></td>\n" +
                        "    <td>" + data[i].fullname + "</td>\n" +
                        "    <td>" + data[i].website + "</td>\n" +
                        "    <td>" + data[i].mphone + "</td>\n" +
                        "</tr>");
                }
            }
        });
        $('#findContacts').modal('show');
    };
    //模糊查询联系人
    $('#contactsName').keypress(function (event) {
        if (event.keyCode == 13) {
            $.ajax({
                url: '/crm/workbench/contacts/saveContacts',
                data: {
                    'contactsName': $('#contactsName').val()
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    $('#contacts').empty();
                    for (var i = 0; i < data.length; i++) {
                        $('#contacts').append("<tr>\n" +
                            "    <td><input type=\"radio\" class=\"activity\" value='" + data[i].id + "'/></td>\n" +
                            "    <td>" + data[i].fullname + "</td>\n" +
                            "    <td>" + data[i].website + "</td>\n" +
                            "    <td>" + data[i].mphone + "</td>\n" +
                            "</tr>");
                    }
                }
            });
        }
        return false;
    });

    //点击确定按钮触发事件，添加联系人
    function addContact() {
        var id = $('.activity:checked').val();
        var name = $('.activity:checked').parent().next().text();
        $('#edit-contactsName').val(name);
        $('#edit-contactsName').next().val(id);
        $('#findContacts').modal('hide');
    };
    //可能性设置
    $('#edit-transactionStage').change(function () {
        $.ajax({
            url: '/crm/workbench/tran/toStage2PossibilityMap',
            dataType: 'json',
            data: {
                'type': $('#edit-transactionStage').val()
            },
            type: 'post',
            success: function (data) {
                $('#edit-possibility').val(data.mess);
            }
        });
    });
    //点击更新按钮
    function updateTran() {
        //表单序列化
        var serialize = $('#updateTranForm').serialize();
        $.ajax({
            url:'/crm/workbench/tran/updateTran?'+serialize+'&id=${tran.id}',
            dataType:'json',
            type:'post',
            success:function (data) {
                alert(data.mess);
                if (data.success){
                    location.href="/crm/toView/transaction/index";
                }
            }
        });
    }
</script>