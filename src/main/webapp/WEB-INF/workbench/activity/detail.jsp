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

            $(".remarkDiv").mouseover(function () {
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
            });
        });

    </script>

</head>
<body>
<!-- 修改市场活动备注的模态窗口 -->
<div class="modal fade" id="editRemarkModal" role="dialog">
    <%-- 备注的id --%>
    <input type="hidden" id="remarkId">
    <div class="modal-dialog" role="document" style="width: 40%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">修改备注</h4>
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
                <button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 修改市场活动的模态窗口 -->
<div class="modal fade" id="editActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">
                    <input type="hidden" id="activityid" value="${activity.id}"/>
                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-marketActivityOwner">
                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-marketActivityName"
                                   value="${activity.name}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-startTime" readonly
                                   value="${activity.startDate}">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" readonly id="edit-endTime"
                                   value="${activity.endDate}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost" value="${activity.cost}">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3"
                                      id="edit-describe">${activity.description}</textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="updateActivity">更新</button>
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
        <h3>市场活动-${activity.name}
            <small>${activity.startDate} ~ ${activity.endDate}</small>
        </h3>
    </div>
    <div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
        <button type="button" class="btn btn-default" onclick="update_Activity('${activity.owner}')"><span
                class="glyphicon glyphicon-edit"></span> 编辑
        </button>
        <button type="button" onclick="delete_Activity('${activity.id}')" class="btn btn-danger"><span
                class="glyphicon glyphicon-minus"></span> 删除
        </button>
    </div>
</div>

<!-- 详细信息 -->
<div style="position: relative; top: -70px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.owner}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activity.name}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>

    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">开始日期</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.startDate}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${activity.endDate}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">成本</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${activity.cost}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${activity.createBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${activity.createTime}</small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${activity.editBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${activity.editTime}</small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${activity.description}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div style="position: relative; top: 30px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>

    <!-- 备注 -->
    <c:forEach items="${activity.activityRemark}" var="activityRemark">
        <div class="remarkDiv" id="${activityRemark.id}" style="height: 60px;">
            <img title="zhangsan" src="/crm/image/user-thumbnail.png" style="width: 30px; height:30px;">
            <div style="position: relative; top: -40px; left: 40px;">
                <h5 id="noteContent${activityRemark.id}">${activityRemark.noteContent}</h5>
                <font color="gray">市场活动</font> <font color="gray">-</font> <b>${activity.name}</b>
                <small style="color: gray;"> ${activityRemark.createTime} 由${activityRemark.createBy}创建</small>
                <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                    <a class="myHref" href="javascript:void(0);"><span
                            onclick="updateActivityRemark('${activityRemark.id}',$('#noteContent${activityRemark.id}').text())"
                            class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove"
                                                                       onclick="deleteActivityRemark('${activityRemark.id}')"
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
                <span style="color: darkred" id="addError"></span>
                <button id="cancelBtn" type="button" class="btn btn-default">取消</button>
                <button type="button" onclick="addActivityRemark('${activity.id}',$('#remark').val())"
                        class="btn btn-primary">保存
                </button>
            </p>
        </form>
    </div>
</div>
<div style="height: 200px;"></div>
</body>
</html>
<script>
    //点击修改备注按钮触发的事件
    function updateActivityRemark(id, noteContent) {
        //将数据插入模态窗中remarkId,noteContent
        $('#remarkId').val(id);
        $('#noteContent').val(noteContent);
       /* $('#noteContent').val($('#' + 'noteContent' + ($('#remarkId').val())).val());*/


    //显示修改备注模态窗
    $('#editRemarkModal').modal('show');
    }

    //updateRemarkBtn
    //点击更新备注按钮触发的事件
    $('#updateRemarkBtn').click(function () {
        $.ajax({
            url: '/crm/workbench/updateRemark',
            data: {
                'id': $('#remarkId').val(),
                'noteContent': $('#noteContent').val()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.mess);
                if (data.success) {
                    //更新成功，关闭模态窗，修改对应的消息内容
                    $('#editRemarkModal').modal('hide');
                    $('#' + 'noteContent' + ($('#remarkId').val())).text($('#noteContent').val());
                } else {
                    //更新失败
                }

            }
        })
    });

    //点击删除备注按钮触发事件
    function deleteActivityRemark(id) {
        $.ajax({
            url: '/crm/workbench/deleteRemark',
            data: {
                'id': id,
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.mess);
                if (data.success) {
                    //删除成功，删除对应的备注
                    $('#' + id).remove();
                } else {
                    //删除失败
                }
            }
        })
    };

    //添加备注事件
    function addActivityRemark(activityId, noteContent) {
        if (noteContent == '') {
            //添加内容为空
            $('#addError').html("备注内容不能为空！");
        } else {
            $.ajax({
                url: '/crm/workbench/addRemark',
                data: {
                    'activityId': activityId,
                    'noteContent': noteContent
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    alert(data.mess);
                    if (data.success) {
                        //添加成功，刷新界面
                        location.href = "/crm/workbench/saveActivity?id=${activity.id}";
                    } else {
                        //删除失败
                    }
                }
            })
        }
    }

    $('#edit-startTime').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });
    $('#edit-endTime').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });

    //编辑市场活动按钮触发事件
    function update_Activity(uname) {
        //清空上次查询所有者信息
        $('#edit-marketActivityOwner').empty();
        //查询所有用户
        $.ajax({
            url: '/crm/workbench/saveOwner',
            dataType: 'json',
            type: 'post',
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    $('#edit-marketActivityOwner').append(
                        "<option value='" + data[i].id + "'>" + data[i].name + "</option>"
                    )
                }
                //遍历所有的用户信息
                $('#edit-marketActivityOwner option').each(function () {
                    if ($(this).text() == uname) {
                        $(this).prop("selected", true);
                    }
                })
            }
        });
        $('#editActivityModal').modal('show');
    };
    //updateActivity edit-describe  edit-cost activityid edit-marketActivityOwner
    // edit-marketActivityName edit-startTime edit-endTime
    //edit-startTime edit-endTimeedit-startTimeedit-endTime


    //点击市场活动更新按钮触发事件
    $('#updateActivity').click(function () {
        $.ajax({
            url: '/crm/workbench/update_Activity',
            data: {
                'description': $('#edit-describe').val(),
                'cost': $('#edit-cost').val(),
                'id': $('#activityid').val(),
                'owner': $('#edit-marketActivityOwner').val(),
                'name': $('#edit-marketActivityName').val(),
                'startDate': $('#edit-startTime').val(),
                'endDate': $('#edit-endTime').val()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.mess);
                if (data.success) {
                    //更新成功，关闭模态窗,修改信息
                    $('#editActivityModal').modal('hide');
                    location.href = "/crm/workbench/saveActivity?id=${activity.id}";
                } else {
                    //更新失败
                }
            }
        });
    });

    //删除市场活动按钮
    function delete_Activity(id) {
        //删除活动及其备注
        $.ajax({
            url: '/crm/workbench/delete_Activity',
            data: {'id': id},
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert(data.mess);
                if (data.success) {
                    //删除成功,跳转界面
                    location.href = "/crm/toView/activity/index";
                } else {
                    //删除失败
                }
            }
        });
    }
</script>