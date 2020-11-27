<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">

    <link href="/crm/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <link href="/crm/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>
    <script type="text/javascript" src="/crm/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="/crm/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
    <script type="text/javascript"
            src="/crm/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="/crm/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>


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
            //参数1:事件,参数2:被代理的元素的选择器,参数3:事件触发的函数
            $('#parent').on('mouseover', '.remarkDiv', function () {
                $(this).children("div").children("div").show();
            });

            $('#parent').on('mouseout', '.remarkDiv', function () {
                $(this).children("div").children("div").hide();
            });
            $('#parent').on('mouseover', '.myHref', function () {
                $(this).children("span").css("color", "red");
            });
            $('#parent').on('mouseout', '.myHref', function () {
                $(this).children("span").css("color", "#E6E6E6");
            });
            /* $(".remarkDiv").mouseover(function () {
                 $(this).children("div").children("div").show();
             });

             $(".remarkDiv").mouseout(function () {
                 $(this).children("div").children("div").hide();
             });

             $(".myHref").mouseover(function () {
                 $(this).children("span").css("color", "red");
             });

             $(".myHref").mouseout(function () {
                 $(this).children("span").css("color", "#E6E6E6");
             });*/
        });

    </script>

</head>
<body>
<!-- 关联市场活动的模态窗口 -->
<div class="modal fade" id="bundModal" role="dialog">
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
                                   id="activityName" placeholder="请输入市场活动名称，支持模糊查询">
                            <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>
                    </form>
                </div>
                <table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
                    <thead>
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
                <button type="button" onclick="saveClueActivity()" class="btn btn-primary">关联</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改线索的模态窗口 -->
<div class="modal fade" id="editClueModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改线索</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="updateClueForm" role="form">
                    <input type="hidden" name="id" value="${clue.id}"/>
                    <div class="form-group">
                        <label for="edit-clueOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="owner" id="edit-clueOwner">
                            </select>
                        </div>
                        <label for="edit-company" class="col-sm-2 control-label">公司<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="company" id="edit-company"
                                   value="${clue.company}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-call" class="col-sm-2 control-label">称呼</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="appellation" id="edit-call">
                            </select>
                        </div>
                        <label for="edit-surname" class="col-sm-2 control-label">姓名<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-surname" name="fullname"
                                   value="${clue.fullname}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-job" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-job" name="job" value="${clue.job}">
                        </div>
                        <label for="edit-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-email" name="email" value="${clue.email}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-phone" name="phone" value="${clue.phone}">
                        </div>
                        <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-website"
                                   name="website" value="${clue.website}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-mphone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-mphone" name="mphone"
                                   value="${clue.mphone}">
                        </div>
                        <label for="edit-status" class="col-sm-2 control-label">线索状态</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="state" id="edit-status">
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-source" class="col-sm-2 control-label">线索来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="source" id="edit-source">
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe"
                                      name="description">${clue.description}</textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" name="contactSummary"
                                          id="edit-contactSummary">${clue.contactSummary}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" readonly id="edit-nextContactTime"
                                       name="nextContactTime" value="${clue.nextContactTime}">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" id="edit-address"
                                          name="address">${clue.address}</textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="updateclue()">更新</button>
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
        <h3>${clue.fullname}
            <small>${clue.company}</small>
        </h3>
    </div>
    <div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
        <a type="button" class="btn btn-default" href="/crm/workbench/clue/toConvert?id=${clue.id}&company=${clue.company}&owner=${clue.owner}&appellation=${clue.appellation}&fullname=${clue.fullname}"><span
                class="glyphicon glyphicon-retweet"></span> 转换
        </a>
        <button type="button" class="btn btn-default" onclick="toeditClueModal()"><span
                class="glyphicon glyphicon-edit"></span> 编辑
        </button>
        <button type="button" onclick="isdeleteClue()" class="btn btn-danger"><span
                class="glyphicon glyphicon-minus"></span> 删除
        </button>
    </div>
</div>

<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clue.fullname}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clue.owner}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">公司</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clue.company}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">职位</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clue.job}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">邮箱</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clue.email}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">公司座机</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clue.phone}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">公司网站</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clue.website}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">手机</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clue.mphone}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">线索状态</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clue.state}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">线索来源</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${clue.source}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${clue.createBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${clue.createTime}</small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 60px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${clue.editBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${clue.editTime}</small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 70px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${clue.description}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 80px;">
        <div style="width: 300px; color: gray;">联系纪要</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${clue.contactSummary}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 90px;">
        <div style="width: 300px; color: gray;">下次联系时间</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${clue.nextContactTime}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px; "></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 100px;">
        <div style="width: 300px; color: gray;">详细地址</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${clue.address}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div id="parent" style="position: relative; top: 40px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>

    <!-- 备注1 -->
    <c:forEach items="${clue.clueRemarks}" var="clueRemark">
        <div class="remarkDiv" id="remarkDiv${clueRemark.id}" style="height: 60px;">
            <img title="${clue.owner}" src="/crm/image/user-thumbnail.png" style="width: 30px; height:30px;">
            <div style="position: relative; top: -40px; left: 40px;">
                <h5 id="noteContent${clueRemark.id}">${clueRemark.noteContent}</h5>
                <font color="gray">线索</font> <font color="gray">-</font> <b>${clue.fullname}-${clue.company}</b>
                <small style="color: gray;"> ${clue.createTime} 由${clue.createBy}</small>
                <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                    <a class="myHref" href="javascript:void(0);"><span
                            onclick="updateClueRemark('${clueRemark.id}',$('#noteContent${clueRemark.id}').text())"
                            class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="myHref" href="javascript:void(0);">
                        <span class="glyphicon glyphicon-remove" onclick="deleteClueRemark('${clueRemark.id}')"
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
                <button type="button" onclick="addClueRemark($('#remark').val())" class="btn btn-primary">保存</button>
            </p>
        </form>
    </div>
</div>

<!-- 修改线索备注的模态窗口 -->
<div class="modal fade" id="editClueRemarkModal" role="dialog">
    <%-- 备注的id --%>

    <div class="modal-dialog" role="document" style="width: 40%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">修改备注</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="updateRemarkModalFrom" role="form">
                    <input type="hidden" id="remarkId">
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
                        onclick="updateClueRemarkBtn($('#remarkId').val(),$('#noteContent').val())">更新
                </button>
            </div>
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
            <table class="table table-hover" style="width: 900px;">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td>名称</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                    <td>所有者</td>
                    <td></td>
                </tr>
                </thead>
                <tbody id="father">
                <c:forEach items="${clue.activities}" var="activity">
                    <tr id="tr${activity.id}">
                        <td>${activity.name}</td>
                        <td>${activity.startDate}</td>
                        <td>${activity.endDate}</td>
                        <td>${activity.owner}</td>
                        <td><a href="javascript:void(0);" style="text-decoration: none;"
                               onclick="deleteClueActivityRelation('${activity.id}','${clue.id}')"><span
                                class="glyphicon glyphicon-remove"></span>解除关联</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

        <div>
            <a href="javascript:void(0);" onclick="addClueActivity()"
               style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>关联市场活动</a>
        </div>
    </div>
</div>


<div style="height: 200px;"></div>
</body>
</html>
<script>
    //设置时间
    $('#edit-nextContactTime').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });

    //点击修改按钮异步查询信息
    function toeditClueModal() {
        //异步查询所有者信息
        $.ajax({
            url: '/crm/settings/saveAllUser',
            dataType: 'json',
            type: 'post',
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    $('#edit-clueOwner').append("<option value='" + data[i].id + "'>" + data[i].name + "</option>")
                }
                $('#edit-clueOwner option').each(function () {
                    if ($(this).text() == "${clue.owner}") {
                        $(this).prop("selected", true);
                    }
                })
            }
        });

        //异步查询字典的信息
        $.ajax({
            url: '/crm/base/saveAllDictionary',
            dataType: 'json',
            type: 'post',
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    //设置称呼
                    if (data[i].code == "appellation") {
                        for (var j = 0; j < data[i].dictionaryValues.length; j++) {
                            $('#edit-call').append("<option value='" + data[i].dictionaryValues[j].value + "'>" + data[i].dictionaryValues[j].text + "</option>")
                        }
                    }
                    $('#edit-call option').each(function () {
                        if ($(this).val() == "${clue.appellation}") {
                            $(this).prop("selected", true);
                        }
                    })
                    //设置线索来源
                    if (data[i].code == "source") {
                        for (var j = 0; j < data[i].dictionaryValues.length; j++) {
                            $('#edit-source').append("<option value='" + data[i].dictionaryValues[j].value + "'>" + data[i].dictionaryValues[j].text + "</option>")
                        }
                    }
                    ;
                    $('#edit-source option').each(function () {
                        if ($(this).val() == "${clue.source}") {
                            $(this).prop("selected", true);
                        }
                    });
                    //设置线索状态
                    if (data[i].code == "clueState") {
                        for (var j = 0; j < data[i].dictionaryValues.length; j++) {
                            $('#edit-status').append("<option value='" + data[i].dictionaryValues[j].value + "'>" + data[i].dictionaryValues[j].text + "</option>")
                        }
                    }
                    ;
                    $('#edit-status option').each(function () {
                        if ($(this).val() == "${clue.state}") {
                            $(this).prop("selected", true);
                        }
                    })
                }
            }
        });
        //显示模态窗
        $('#editClueModal').modal('show');
    }

    //点击编辑模态窗中的保存按钮触发事件
    function updateclue() {

        //公司名称，姓名不能为空，且公司名称不能重复
        //id="updateClueForm"  id="edit-company" id="edit-surname"
        if ($('#edit-company').val() == '') {
            alert("公司名称不能为空");
        } else if ($('#edit-surname').val() == '') {
            alert("姓名不能为空");
        } else {
            var flag = false;
            if ($('#edit-company').val() == "${clue.company}") {
                //公司名称和原先一样
                flag = true;
            } else {
                //公司名称发生改变，异步校验
                $.ajax({
                    url: '/crm/workbench/clue/saveCompany',
                    data: {'company': $('#edit-company').val()},
                    dataType: 'json',
                    type: 'post',
                    success: function (data) {
                        if (data.success()) {
                            //没有重复的公司名称
                            flag = true;
                        } else {
                            //修改后的公司名称已存在
                            flag = false;
                            alert(data.mess);
                        }
                    }
                });
            }
            if (flag) {
                //进行更新线索
                //将表单序列化
                var serialize = $('#updateClueForm').serialize();
                $.ajax({
                    url: '/crm/workbench/clue/updateClue?' + serialize,
                    dataType: 'json',
                    type: 'post',
                    success: function (data) {
                        alert(data.mess);
                        if (data.success) {
                            //成功，关闭模态窗，刷新页面
                            $('#editClueModal').modal('hide');
                            location.href = "/crm/workbench/clue/todetail?id=${clue.id}";
                        }
                    }
                });
            }
        }
    }

    //点击删除按钮触发事件
    function isdeleteClue() {
        var flag = confirm("您确定要删除这条线索么？");
        if (flag) {
            $.ajax({
                url: '/crm/workbench/clue/deleteClueById',
                data: {'id': "${clue.id}"},
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    alert(data.mess);
                    if (data.success) {
                        //跳转主页面
                        location.href = "/crm/toView/clue/index";
                    }
                }
            })
        }
    }

    //编辑备注显示模态窗事件
    function updateClueRemark(id, noteContent) {
        $('#remarkId').val(id);
        $('#noteContent').val(noteContent);
        $('#editClueRemarkModal').modal('show');
    };

    //点击更新备注事件
    function updateClueRemarkBtn(id, noteContent) {
        //异步更改
        $.ajax({
            url: '/crm/workbench/clue/updateClueRemark',
            data: {
                'id': id,
                'noteContent': noteContent
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.mess);
                if (data.success) {
                    //关闭模态窗
                    $('#editClueRemarkModal').modal('hide');
                    //js修改备注
                    $('#noteContent' + ($('#remarkId').val())).text(noteContent);
                }
            }
        })
    }

    //点击删除备注事件
    function deleteClueRemark(id) {
        var flag = confirm("确定要删除这条备注么？");
        if (flag) {
            $.ajax({
                url: '/crm/workbench/clue/deleteClueRemark',
                data: {'id': id},
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    alert(data.mess);
                    if (data.success) {
                        //删除成功,界面js取消该备注
                        $('#remarkDiv' + id).remove();
                    }
                }
            });
        }
    }

    //添加备注事件
    function addClueRemark(noteContent) {
        $.ajax({
            url: '/crm/workbench/clue/addClueRemark',
            data: {
                'clueId': '${clue.id}',
                'noteContent': noteContent
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                $('#remarkDiv').before(" <div class=\"remarkDiv\" id='remarkDiv" + data.id + "' style=\"height: 60px;\">\n" +
                    "            <img title=\"${clue.owner}\" src=\"/crm/image/user-thumbnail.png\" style=\"width: 30px; height:30px;\">\n" +
                    "            <div style=\"position: relative; top: -40px; left: 40px;\">\n" +
                    "                <h5 id='noteContent" + data.id + "'>" + data.noteContent + "</h5>\n" +
                    "                <font color=\"gray\">线索</font> <font color=\"gray\">-</font> <b>${clue.fullname}-${clue.company}</b>\n" +
                    "                <small style=\"color: gray;\"> ${clue.createTime} 由${clue.createBy}</small>\n" +
                    "                <div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
                    "                    <a class=\"myHref\" href=\"javascript:void(0);\"><span\n" +
                    "                            onclick=\"updateClueRemark('" + data.id + "',$('#noteContent" + data.id + "').text())\"\n" +
                    "                            class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
                    "                    &nbsp;&nbsp;&nbsp;&nbsp;\n" +
                    "                    <a class=\"myHref\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\"\n" +
                    "                                                                       onclick=\"deleteClueRemark('" + data.id + "')\"\n" +
                    "                                                                       style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
                    "                </div>\n" +
                    "            </div>\n" +
                    "        </div>")
                $('#remark').val("");
            }
        })
    }

    //解除线索与市场活动的关联
    function deleteClueActivityRelation(activityId, clueId) {
        var flag = confirm("确定要解除关联么？");
        if (flag) {
            $.ajax({
                url: '/crm/workbench/clue/deleteClueActivityRelation',
                data: {
                    'activityId': activityId,
                    'clueId': clueId
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    alert(data.mess);
                    if (data.success) {
                        $('#tr' + activityId).remove();
                    }
                }
            });
        }
    }

    //添加线索市场活动关联
    function addClueActivity() {
        //异步查询所有市场活动，支持模糊查询，避开当前已关联的活动
        $('#activityName').val("");
        $.ajax({
            url: '/crm/workbench/clue/saveActivity',
            data: {
                'id': '${clue.id}',
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
                $('#bundModal').modal('show');
            }
        })
    }

    //点击关联事件
    function saveClueActivity() {
        //获取选中的活动id
        var ids = [];
        $('.son').each(function () {
            if ($(this).prop("checked")) {
                ids.push($(this).val());
            }
        })
        //异步添加关联
        $.ajax({
            url: '/crm/workbench/clue/saveClueActivity',
            data: {
                'id': '${clue.id}',
                'ids': ids.join()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.mess);
                $('#bundModal').modal('hide');
                //刷新界面
                $('#father').empty();
                //异步查询所有与线索关联的活动
                $.ajax({
                    url: '/crm/workbench/clue/saveActivities',
                    data: {
                        'id': '${clue.id}'
                    },
                    dataType: 'json',
                    type: 'post',
                    success: function (data) {
                        for (var i = 0; i < data.length; i++) {
                            $('#father').append(" <tr id=\"tr" + data[i].id + "\">\n" +
                                "                        <td>" + data[i].name + "</td>\n" +
                                "                        <td>" + data[i].startDate + "</td>\n" +
                                "                        <td>" + data[i].endDate + "</td>\n" +
                                "                        <td>" + data[i].owner + "</td>\n" +
                                "                        <td><a href=\"javascript:void(0);\" style=\"text-decoration: none;\"\n" +
                                "                               onclick=\"deleteClueActivityRelation('" + data[i].id + "','${clue.id}')\"><span\n" +
                                "                                class=\"glyphicon glyphicon-remove\"></span>解除关联</a></td>\n" +
                                "                    </tr>")
                        }
                    }
                })
            }
        });
    }

    //模糊查询未关联的市场活动
    $('#activityName').keypress(function (event) {
        //按下回车键发送异步请求
        if (event.keyCode == 13) {//13是回车键的值
            //异步查询所有市场活动，支持模糊查询，避开当前已关联的活动
            $.ajax({
                url: '/crm/workbench/clue/saveActivity',
                data: {
                    'id': '${clue.id}',
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
                }
            })
        }
        return false;//按下回车不跳转界面
    })
</script>