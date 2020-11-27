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

        //默认情况下取消和保存按钮是隐藏的
        var cancelAndSaveBtnDefault = true;

        $(function () {
            $("#remark").focus(function () {
                if (cancelAndSaveBtnDefault) {
                    //设置remarkDiv的高度为130px
                    $("#remarkDiv").css("height", "130px");
                    //显示
                    $("#cancelAndSaveBtn").show("2000");
                    cancelAndSaveBtnDefault = false;
                }
            });

            $("#cancelBtn").click(function () {
                //显示
                $("#cancelAndSaveBtn").hide();
                //设置remarkDiv的高度为130px
                $("#remarkDiv").css("height", "90px");
                cancelAndSaveBtnDefault = true;
            });
            $('#parent').on('mouseover', '.remarkDiv', function () {
                $(this).children("div").children("div").show();
            });
            /*$(".remarkDiv").mouseover(function () {
                $(this).children("div").children("div").show();
            });*/
            $('#parent').on('mouseout', '.remarkDiv', function () {
                $(this).children("div").children("div").hide();
            });
            /* $(".remarkDiv").mouseout(function () {
                 $(this).children("div").children("div").hide();
             });*/
            $('#parent').on('mouseover', '.myHref', function () {
                (this).children("span").css("color", "red");
            });
            /* $(".myHref").mouseover(function () {
                 $(this).children("span").css("color", "red");
             });*/
            $('#parent').on('mouseout', '.myHref', function () {
                $(this).children("span").css("color", "#E6E6E6");
            });
            /* $(".myHref").mouseout(function () {
                 $(this).children("span").css("color", "#E6E6E6");
             });*/
        });

    </script>

</head>
<body>
<!-- 解除联系人和市场活动关联的模态窗口 -->
<div class="modal fade" id="unbundActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 30%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">解除关联</h4>
                <input id="deleteActivity" type="hidden"/>
            </div>
            <div class="modal-body">
                <p>您确定要解除该关联关系吗？</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button"  onclick="deleteContactsActivity($('#deleteActivity').val())" class="btn btn-danger" data-dismiss="modal">解除</button>
            </div>
        </div>
    </div>
</div>

<!-- 联系人和市场活动关联的模态窗口 -->
<div class="modal fade" id="bundActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 80%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">关联市场活动</h4>
            </div>
            <div class="modal-body">
                <div class="btn-group" style="position: relative; top: 18%; left: 8px;">
                    <form class="form-inline" role="form">
                        <div class="form-group has-feedback">
                            <input type="text" class="form-control" style="width: 300px;"
                              id="activityName"   placeholder="请输入市场活动名称，支持模糊查询">
                            <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>
                    </form>
                </div>
                <table id="activityTable2" class="table table-hover"
                       style="width: 900px; position: relative;top: 10px;">
                    <thead >
                    <tr style="color: #B3B3B3;">
                        <td><input type="checkbox"/></td>
                        <td>名称</td>
                        <td>开始日期</td>
                        <td>结束日期</td>
                        <td>所有者</td>
                        <td></td>
                    </tr>
                    </thead>
                    <tbody id="activitys">
                    </tbody>
                </table>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" onclick="addContactsActivity()">关联</button>
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
                <h4 class="modal-title" id="myModalLabel">修改联系人</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="updateContactsForm" role="form">

                    <div class="form-group">
                        <label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="owner" id="edit-contactsOwner">
                            </select>
                        </div>
                        <label for="edit-clueSource" class="col-sm-2 control-label">来源</label>
                        <div class="col-sm-10" style="width: 300px;">
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
                        <label for="edit-surname" class="col-sm-2 control-label">姓名<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-surname" value="${contacts.fullname}"
                                   name="fullname"/>
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
                            <input type="text" class="form-control" name="job" id="edit-job" value="${contacts.job}">
                        </div>
                        <label for="edit-mphone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-mphone" name="mphone"
                                   value="${contacts.mphone}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-email" name="email"
                                   value="${contacts.email}">
                        </div>
                        <label for="edit-birth" class="col-sm-2 control-label">生日</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" readonly class="form-control" name="birth" value="${contacts.birth}"
                                   id="edit-birth"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="customerName" value="${contacts.customerId}"
                                   id="edit-customerName" placeholder="支持自动补全，输入客户不存在则新建"/>
                            <input type="hidden" name="customerId"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" name="description"
                                      id="edit-describe">${contacts.description}</textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" name="contactSummary"
                                          id="create-contactSummary">${contacts.contactSummary}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" readonly id="create-nextContactTime"
                                       name="nextContactTime" value="${contacts.nextContactTime}"/>
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="edit-address1" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" name="address"
                                          id="edit-address1">${contacts.address}</textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="updateContactsBtn()">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
    <a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"
                                                                         style="font-size: 20px; color: #DDDDDD"></span></a>
</div>

<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <div class="page-header">
        <h3>${contacts.fullname}${contacts.appellation}
            <small> - ${contacts.customerId}</small>
        </h3>
    </div>
    <div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
        <button type="button" class="btn btn-default" onclick="updateContactsModal()"><span
                class="glyphicon glyphicon-edit"></span> 编辑
        </button>
        <button type="button" onclick="deleteContactsBtn()" class="btn btn-danger"><span
                class="glyphicon glyphicon-minus"></span> 删除
        </button>
    </div>
</div>

<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${contacts.owner}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">来源</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${contacts.source}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">客户名称</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${contacts.customerId}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">姓名</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;">
            <b>${contacts.fullname}${contacts.appellation}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">邮箱</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${contacts.email}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">手机</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${contacts.mphone}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">职位</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${contacts.job}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">生日</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${contacts.birth}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${contacts.createBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${contacts.createTime}</small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${contacts.editBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${contacts.editTime}</small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 60px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${contacts.description}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 60px;">
        <div style="width: 300px; color: gray;">联系纪要</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${contacts.contactSummary}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 80px;">
        <div style="width: 300px; color: gray;">下次联系时间</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${contacts.nextContactTime}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 90px;">
        <div style="width: 300px; color: gray;">详细地址</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${contacts.address}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>
<!-- 备注 -->
<div id="parent" style="position: relative; top: 20px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>

    <!-- 备注 -->
    <c:forEach items="${contacts.contactsRemarks}" var="contactsRemark">
        <div class="remarkDiv" id="div${contactsRemark.id}" style="height: 60px;">
            <img title="zhangsan" src="/crm/image/user-thumbnail.png" style="width: 30px; height:30px;">
            <div style="position: relative; top: -40px; left: 40px;">
                <h5 id="noteContent${contactsRemark.id}">${contactsRemark.noteContent}</h5>
                <font color="gray">联系人</font> <font color="gray">-</font> <b>${contacts.fullname}${contacts.appellation}-${contacts.customerId}</b>
                <small style="color: gray;"> ${contactsRemark.createTime} 由${contactsRemark.createBy}</small>
                <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                    <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit"
                                                                       onclick="updateContactsRemark('${contactsRemark.id}',$('#noteContent'+'${contactsRemark.id}').text())"
                                                                       style="font-size: 20px; color: #E6E6E6;"></span></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove"
                                                                       onclick="deleteContactsRemark('${contactsRemark.id}')"
                                                                       style="font-size: 20px; color: #E6E6E6;"></span></a>
                </div>
            </div>
        </div>
    </c:forEach>

    <div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
        <form role="form" style="position: relative;top: 10px; left: 10px;">
            <textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"
                      placeholder="添加备注..."></textarea>
            <p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
                <button id="cancelBtn" type="button" class="btn btn-default">取消</button>
                <button type="button" onclick="addContactsRemark($('#remark').val())" class="btn btn-primary">保存
                </button>
            </p>
        </form>
    </div>
</div>

<!-- 交易 -->
<div>
    <div style="position: relative; top: 20px; left: 40px;">
        <div class="page-header">
            <h4>交易</h4>
        </div>
        <div style="position: relative;top: 0px;">
            <table id="activityTable3" class="table table-hover" style="width: 900px;">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td>名称</td>
                    <td>金额</td>
                    <td>阶段</td>
                    <td>可能性</td>
                    <td>预计成交日期</td>
                    <td>类型</td>
                    <td></td>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${contacts.trans}" var="tran">
                    <tr id="tr${tran.id}">
                        <td><a href="../transaction/detail.html"
                               style="text-decoration: none;">${contacts.customerId}-${tran.name}</a></td>
                        <td>${tran.money}</td>
                        <td>${tran.stage}</td>
                        <td>
                                ${stage2PossibilityMap.get(tran.stage)}
                        </td>
                        <td>${tran.expectedDate}</td>
                        <td>${tran.type}</td>
                        <td><a href="javascript:void(0);" onclick="deleteTranbtn('${tran.id}')"
                               style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div>
            <a href="/crm/toView/transaction/save" style="text-decoration: none;"><span
                    class="glyphicon glyphicon-plus"></span>新建交易</a>
        </div>
    </div>
</div>

<!-- 市场活动 -->
<div>
    <div style="position: relative; top: 60px; left: 40px;">
        <div class="page-header">
            <h4>市场活动</h4>
        </div>
        <div style="position: relative;top: 0px;">
            <table id="activityTable" class="table table-hover" style="width: 900px;">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td>名称</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                    <td>所有者</td>
                    <td></td>
                </tr>
                </thead>
                <tbody id="activities">
                <c:forEach items="${contacts.activities}" var="activity">
                    <tr id="tr${activity.id}">
                        <td><a href="../activity/detail.html" style="text-decoration: none;">${activity.name}</a></td>
                        <td>${activity.startDate}</td>
                        <td>${activity.editTime}</td>
                        <td>${activity.owner}</td>
                        <td><a href="javascript:void(0);"   onclick="openUnbundActivityModal('${activity.id}')"
                               style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div>
            <a href="javascript:void(0);" onclick="openBundActivityModal()"
               style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>关联市场活动</a>
        </div>
    </div>
</div>


<div style="height: 200px;"></div>
<!-- 修改联系人备注的模态窗口 -->
<div class="modal fade" id="editRemarkModal" role="dialog">
    <%-- 备注的id --%>
    <input type="hidden" id="remarkId">
    <div class="modal-dialog" role="document" style="width: 40%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">修改备注</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">内容</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="noteContent"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary"
                        onclick="updateContactsRemarkBtn($('#remarkId').val(),$('#noteContent').val())">更新
                </button>
            </div>
        </div>
    </div>
</div>
</body>
</html>
<script>
    //生日设置日期插件
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
    //下次联系时间设置日期
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
    //修改联系人     客户名称的自动补全功能
    $('#edit-customerName').typeahead({
        source: function (customerName, process) {
            $.post(
                "/crm/workbench/customer/queryCustomerName",
                {"customerName": $('#edit-customerName').val()},
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

    //点击编辑按钮触发事件
    function updateContactsModal() {
        //异步查询所有者
        //异步查询所有者信息
        $('#edit-contactsOwner').empty();
        $.ajax({
            url: '/crm/workbench/saveOwner',
            type: 'post',
            dataType: 'json',
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    $('#edit-contactsOwner').append("<option value=" + data[i].id + " >" + data[i].name + "</option>")
                }
                $('#edit-contactsOwner option').each(function () {
                    if ($(this).text() == '${contacts.owner}') {
                        $(this).prop("selected", true);
                    }
                })
            }
        });
        //异步查询客户名称对应的id
        $.ajax({
            url: '/crm/workbench/customer/saveCustomerName',
            data: {
                'company': '${contacts.customerId}'
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                $('#edit-customerName').next().val(data.mess);
            }
        });
        //设置来源
        $('#edit-clueSource option').each(function () {
            if ($(this).val() == '${contacts.source}') {
                $(this).prop("selected", true);
            }
        });
        //设置称呼
        $('#edit-call option').each(function () {
            if ($(this).val() == '${contacts.appellation}') {
                $(this).prop("selected", true);
            }
        });
        $('#editContactsModal').modal('show');
    };

    //点击更新按钮触发修改联系人事件
    function updateContactsBtn() {
        //表单序列化
        var serialize = $('#updateContactsForm').serialize();
        //异步提交表单，修改联系人信息
        $.ajax({
            url: '/crm/workbench/contacts/updateContacts?' + serialize,
            data: {
                'company': $('#edit-customerName').val(),
                'id': '${contacts.id}'
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.mess);
                if (data.success) {
                    //修改成功，关闭模态窗
                    $('#editContactsModal').modal('hide');
                    //刷新界面
                    location.href = "/crm/workbench/contacts/toDetail?id=${contacts.id}"
                }
            }
        });
    };

    //点击删除按钮触发删除联系人事件
    function deleteContactsBtn() {
        var flag = confirm("您确定要删除这位联系人么？");
        if (flag) {
            $.ajax({
                url: '/crm/workbench/contacts/deleteContactsById',
                data: {'id': '${contacts.id}'},
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    alert(data.mess);
                    if (data.success) {
                        //跳转主界面
                        location.href = "/crm/toView/contacts/index"
                    }
                }
            });
        }
    };

    //添加备注
    function addContactsRemark(remark) {
        if (remark == '' || remark == undefined) {
            alert("备注不能为空");
        } else {
            //异步添加备注
            $.ajax({
                url: '/crm/workbench/contacts/addContactsRemark',
                data: {
                    'noteContent': remark,
                    'contactsId': '${contacts.id}'
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    alert("添加成功");
                    //拼接备注
                    $('#remarkDiv').before("<div class=\"remarkDiv\" id=\"div" + data.id + "\" style=\"height: 60px;\">\n" +
                        "            <img title=\"${contacts.createBy}\" src=\"/crm/image/user-thumbnail.png\" style=\"width: 30px; height:30px;\">\n" +
                        "            <div style=\"position: relative; top: -40px; left: 40px;\">\n" +
                        "                <h5 id=\"noteContent" + data.id + "\">" + data.noteContent + "</h5>\n" +
                        "                <font color=\"gray\">联系人</font> <font color=\"gray\">-</font> <b>${contacts.fullname}${contacts.appellation}-${contacts.customerId}</b>\n" +
                        "                <small style=\"color: gray;\"> " + data.createTime + " 由" + data.createBy + "</small>\n" +
                        "                <div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
                        "                    <a class=\"myHref\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\"\n" +
                        "                                                                       onclick=\"updateContactsRemark(" + data.id + ",$('#noteContent" + data.id + "').val())\"\n" +
                        "                                                                       style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
                        "                    &nbsp;&nbsp;&nbsp;&nbsp;\n" +
                        "                    <a class=\"myHref\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\"\n" +
                        "                                                                       onclick=\"deleteContactsRemark(" + data.id + ")\"\n" +
                        "                                                                       style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
                        "                </div>\n" +
                        "            </div>\n" +
                        "        </div>")
                    //将textarea框中的内容清空
                    $('#remark').val("");
                }
            });
        }
    };

    //修改备注
    function updateContactsRemark(id, noteContent) {
        alert(id)
        alert(noteContent)
        //将值设置到模态窗中
        $('#remarkId').val(id);
        $('#noteContent').val(noteContent);
        //显示模态窗
        $('#editRemarkModal').modal('show');
    };

    //点击更新按钮触发事件
    function updateContactsRemarkBtn(id, noteContent) {
        if (noteContent == '') {
            alert("备注不能为空");
            return;
        }
        $.ajax({
            url: '/crm/workbench/contacts/updateContactsRemark',
            data: {
                'id': id,
                'noteContent': noteContent
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.mess);
                if (data.success) {
                    $('#noteContent' + id).text(noteContent);
                    $('#editRemarkModal').modal('hide');
                }
            }
        });
    };

    //点击删除备注按钮触发事件
    function deleteContactsRemark(id) {
        var flag = confirm("您确定删除这条备注么？");
        if (flag) {
            $.ajax({
                url: '/crm/workbench/contacts/deteleContactsRemark',
                data: {
                    'id': id,
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    alert(data.mess);
                    if (data.success) {
                        //将对应的备注dom元素删除
                        $('#div' + id).remove();
                    }
                }
            });
        }
    };

    //删除交易
    function deleteTranbtn(id) {
        var flag = confirm("您确定删除这桩交易么？");
        if (flag) {
            $.ajax({
                url: '/crm/workbench/tran/deleteTranById',
                data: {
                    'id': id,
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    alert(data.mess);
                    if (data.success) {
                        //将对应的备注dom元素删除
                        $('#tr'+id).remove();
                    }
                }
            });
        }
    }
    //点击解除关联触发事件
    function openUnbundActivityModal(id) {
        $('#deleteActivity').val(id);
        $('#unbundActivityModal').modal('show');
    }
    //点击解除触发事件
    function deleteContactsActivity(id) {
        $.ajax({
            url: '/crm/workbench/contacts/deleteContactsActivity',
            data: {
                'id': id,
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.mess);
                if (data.success) {
                    //将对应的备注dom元素删除
                    $('#tr'+id).remove();
                }
            }
        });
    }
    //点击关联市场活动异步查询
    function openBundActivityModal() {
        //异步查询所有市场活动，支持模糊查询，避开当前已关联的活动
        $('#activityName').val("");
        $.ajax({
            url: '/crm/workbench/contacts/saveActivity',
            data: {
                'id': '${contacts.id}',
                'name': $('#activityName').val()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                $('#activitys').empty();
                for (var i = 0; i < data.length; i++) {
                    $('#activitys').append("<tr>\n" +
                        "                        <td><input type=\"checkbox\" class='son' value='" + data[i].id + "'/></td>\n" +
                        "                        <td>" + data[i].name + "</td>\n" +
                        "                        <td>" + data[i].startDate + "</td>\n" +
                        "                        <td>" + data[i].endDate + "</td>\n" +
                        "                        <td>" + data[i].owner + "</td>\n" +
                        "                    </tr>\n" +
                        "                    ")
                }
                //打开模态窗
                $('#bundActivityModal').modal('show');
            }
        })
    };
    //点击关联事件
    function addContactsActivity() {
        //获取选中的活动id
        var ids = [];
        $('.son').each(function () {
            if ($(this).prop("checked")) {
                ids.push($(this).val());
            }
        })
        //异步添加关联
        $.ajax({
            url: '/crm/workbench/contacts/addContactsActivity',
            data: {
                'id': '${contacts.id}',
                'ids': ids.join()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.mess);
                $('#bundActivityModal').modal('hide');
                //刷新界面
                $('#activities').empty();
                //异步查询所有与线索关联的活动
                $.ajax({
                    url: '/crm/workbench/contacts/saveActivities',
                    data: {
                        'id': '${contacts.id}'
                    },
                    dataType: 'json',
                    type: 'post',
                    success: function (data) {
                        for (var i = 0; i < data.length; i++) {
                            $('#activities').append(" <tr id=\"tr" + data[i].id + "\">\n" +
                                "                        <td>" + data[i].name + "</td>\n" +
                                "                        <td>" + data[i].startDate + "</td>\n" +
                                "                        <td>" + data[i].endDate + "</td>\n" +
                                "                        <td>" + data[i].owner + "</td>\n" +
                                "                        <td><a href=\"javascript:void(0);\"   onclick=\"openUnbundActivityModal('"+data[i].id+"')\"\n" +
                                "                               style=\"text-decoration: none;\"><span class=\"glyphicon glyphicon-remove\"></span>解除关联</a>\n" +
                                "                        </td>\n" +
                                "                    </tr>")
                        }
                    }
                })
            }
        });
    }
</script>