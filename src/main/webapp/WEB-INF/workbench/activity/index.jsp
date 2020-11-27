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

</head>
<body>

<!-- 创建市场活动的模态窗口 -->
<div class="modal fade" id="createActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 85%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
            </div>
            <div class="modal-body">

                <form id="createActivityForm" class="form-horizontal" role="form">

                    <div class="form-group">
                        <label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="create-marketActivityOwner" name="owner">

                            </select>
                        </div>
                        <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-marketActivityName" name="name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" readonly class="form-control" id="create-startTime" name="startDate">
                        </div>
                        <label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" readonly class="form-control" id="create-endTime" name="endDate">
                        </div>
                    </div>
                    <div class="form-group">

                        <label for="create-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="create-cost" name="cost">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="create-describe" name="description"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <span style="color: darkred" id="create-error"></span>
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="create-insert" <%--data-dismiss="modal"--%>>保存
                </button>
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
                <h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
            </div>
            <div class="modal-body">

                <form class="form-horizontal" role="form">
                    <input type="hidden" name="id" id="edit-Id"/>
                    <div class="form-group">
                        <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="owner" id="edit-marketActivityOwner">
                            </select>
                        </div>
                        <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-marketActivityName" name="name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-startTime" name="startDate">
                        </div>
                        <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-endTime" name="endDate">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-cost" name="cost">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" id="edit-describe" name="description"></textarea>
                        </div>
                    </div>

                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="updateActivity" class="btn btn-primary">更新</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>市场活动列表</h3>
        </div>
    </div>
</div>
<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input class="form-control" name="name" id="name" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" name="owner" id="owner" type="text">
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">开始日期</div>
                        <input class="form-control" readonly type="text" name="startDate" id="startTime"/>
                    </div>
                </div>
                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">结束日期</div>
                        <input class="form-control" readonly type="text" name="endDate" id="endTime">
                    </div>
                </div>

                <button type="button" onclick="queryActivity(1, 2)" class="btn btn-default">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button id="createActivity" type="button" class="btn btn-primary" data-toggle="modal"
                        data-target="#createActivityModal">
                    <span class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button type="button" class="btn btn-default"
                        onclick="updateActivity()" <%--data-toggle="modal" data-target="#editActivityModal"--%>>
                    <span class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" id="deleteActivity" class="btn btn-danger"><span
                        class="glyphicon glyphicon-minus"></span> 删除
                </button>
            </div>

        </div>
        <div style="position: relative;top: 10px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input id="parent" type="checkbox"/></td>
                    <td>名称</td>
                    <td>所有者</td>
                    <td>开始日期</td>
                    <td>结束日期</td>
                </tr>
                </thead>
                <tbody id="queryActivity">

                </tbody>
            </table>
        </div>

        <div style="height: 50px; position: relative;top: 30px;">

            <div id="activityPage"></div>
        </div>
    </div>

</div>

</div>
</body>
</html>
<script>


    //点击删除按钮事件
    $('#deleteActivity').click(function () {
        var sons = [];
        var names = [];
        var flag = false;
        $('.son:checked').each(function () {
            sons.push($(this).val())
        })
        $('.name:checked').each(function () {
            names.push($(this).val())
        });
        if (sons.length == 0) {
            alert("请选择您要删除的活动！")
        } else {
            //异步查询选中的活动名称
            $.ajax({
                url: '/crm/workbench/selectActivityById',
                data: {'ids': sons.join()},
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        names.push(data[i].name);
                    }
                    if (confirm("您确定删除" + names + "活动信息么？")) {
                        $.ajax({
                            url: '/crm/workbench/deleteActivityById',
                            data: {'ids': sons.join()},
                            type: 'post',
                            dataType: 'json',
                            success: function (data) {
                                alert(data.mess);
                                if (data.success == false) {
                                    //删除失败
                                } else {
                                    //删除成功
                                    queryActivity(1, 2);
                                }
                            }
                        })
                    }
                }
            })
        }
    });
    //点击更新按钮触发事件
    $('#updateActivity').click(function () {
        $.ajax({
            url: '/crm/workbench/updateActivity',
            data: {
                'id': $('#edit-Id').val(),
                'owner': $('#edit-marketActivityOwner').val(),
                'name': $('#edit-marketActivityName').val(),
                'startDate': $('#edit-startTime').val(),
                'endDate': $('#edit-endTime').val(),
                'cost': $('#edit-cost').val(),
                'description': $('#edit-describe').val(),
            },
            type: 'post',
            dataType: 'json',
            success: function (data) {
                alert(data.mess);
                if (data.success == false) {
                    //更新失败
                } else {
                    //更新成功关闭模态窗
                    $('#editActivityModal').modal('hide');
                    //刷新页面
                    queryActivity(1, 2);
                }
            }
        })
    });

    //修改按钮触发事件
    function updateActivity() {
        var fids = [];
        var owner = "";
        $('.son').each(function () {
            if ($(this).prop('checked')) {
                fids.push($(this).val());
            }
        });
        if (fids.length == 0) {
            alert("请选择您要修改的活动信息!");
        } else if (fids.length > 1) {
            alert("每次最多修改一场活动信息!");
        } else if (fids.length == 1) {
            $.ajax({
                url: '/crm/workbench/selectActivityById',
                data: {'ids': fids.join()},
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    /* name="owner" id="edit-marketActivityOwner" id="edit-marketActivityName" name="name"
                     id="edit-startTime" name="startDate" id="edit-endTime" name="endDate"id="edit-cost" name="cost"
                       id="edit-describe" name="description"*/
                    for (var i = 0; i < data.length; i++) {
                        $('#edit-Id').val(data[i].id);
                        owner = data[i].owner;
                        $('#edit-marketActivityName').val(data[i].name);
                        $('#edit-startTime').val(data[i].startDate);
                        $('#edit-endTime').val(data[i].endDate);
                        $('#edit-cost').val(data[i].cost);
                        $('#edit-describe').val(data[i].description);
                    }
                }
            });
            //异步查询所有者信息
            $.ajax({
                url: '/crm/workbench/saveOwner',
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    for (var i = 0; i < data.length; i++) {
                        $('#edit-marketActivityOwner').append("<option value=" + data[i].id + " >" + data[i].name + "</option>")
                    }
                    //循环异步的所有者，当等于owner时将当前的option的seleted属性挑选出来
                    $('#edit-marketActivityOwner option').each(function () {
                        if (owner == $(this).val()) {
                            $(this).prop("selected", true);
                        }
                    })

                }
            });
            $('#editActivityModal').modal('show');
        }
    };
    //引入创建市场活动模态窗时间插件
    $('#create-startTime').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });
    $('#create-endTime').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });
    //创建市场活动活动名称不能为空
    $('#create-insert').click(function () {
        if ($('#create-marketActivityName').val() == "") {
            $('#createActivityModal').modal('show');
            $('#create-error').html("活动名称不能为空")
        } else {
            //异步提交表单
            $.ajax({
                url: '/crm/workbench/createInsert',
                data: {
                    'owner': $('#create-marketActivityOwner').val(),
                    'name': $('#create-marketActivityName').val(),
                    'startDate': $('#create-startTime').val(),
                    'endDate': $('#create-endTime').val(),
                    'cost': $('#create-cost').val(),
                    'description': $('#create-describe').val()
                },
                type: 'post',
                dataType: 'json',
                success: function (data) {
                    alert(data.mess);
                    if (data.type == false) {
                        //添加失败
                    } else {
                        //添加成功
                        //模态窗的modal属性可以控制显示还是隐藏：show显示，hide隐藏
                        $('#createActivityModal').modal('hide');
                        //刷新界面
                        queryActivity(1, 2);
                        //清空上次创建活动模态窗户中的信息
                        $('#createActivityForm')[0].reset();
                    }

                }
            })
        }
    });
    //单继创建市场活动按钮触发异步查询所有者信息
    $('#createActivity').click(function () {
        $.ajax({
            url: '/crm/workbench/saveOwner',
            type: 'post',
            dataType: 'json',
            success: function (data) {
                $('#create-marketActivityOwner').empty();
                for (var i = 0; i < data.length; i++) {
                    $('#create-marketActivityOwner').append("<option value=" + data[i].id + " >" + data[i].name + "</option>")
                }
            }
        });
    });
    //时间插件
    $('#startTime').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });
    $('#endTime').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });


    //当前页面被访问时之际进行查询所有数据
    queryActivity(1, 2);

    //访问当前页面，异步查询所有数据并显示出来
    function queryActivity(pageNo, pageSize) {
        $.ajax({
            url: '/crm/workbench/queryAllActivity',
            data: {
                'page': pageNo,
                'pageSize': pageSize,
                'name': $('#name').val(),
                'owner': $('#owner').val(),
                'startDate': $('#startTime').val(),
                'endDate': $('#endTime').val()
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                //清空上次数据
                $('#queryActivity').html("");
                for (var i = 0; i < data.dataList.length; i++) {
                    //将所有数据动态拼接出来
                    $('#queryActivity').append("<tr class=\"active\">\n" +
                        "<td><input type=\"checkbox\" class=\"son\" value= '" + data.dataList[i].id + "'/></td>\n" +
                        "<td><a style=\"text-decoration: none; cursor: pointer;\"\n" +
                        "href='/crm/workbench/saveActivity?id="+data.dataList[i].id +"'>" + data.dataList[i].name + "</a></td>\n" +
                        "<td>" + data.dataList[i].uname + "</td>\n" +
                        "<td>" + data.dataList[i].startDate + "</td>\n" +
                        "<td>" + data.dataList[i].endDate + "</td>\n" +
                        "</tr>"
                    )
                }
                /*采用bootstrap分页插件*/
                $("#activityPage").bs_pagination({
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
                        queryActivity(obj.currentPage, obj.rowsPerPage);
                    }
                });
            }
        });
    };
    //全选按钮触发事件
    $('#parent').click(function () {
        var sons = $('.son');
        //先判断当前按钮是否勾中
        for (var i = 0; i < sons.length; i++) {
            //将selectAll是否勾中的状态赋值给son
            sons[i].checked = this.checked;
        }
    })

</script>