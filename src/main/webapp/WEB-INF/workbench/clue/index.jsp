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

    <script type="text/javascript">

        $(function () {


        });

    </script>
</head>
<body>

<!-- 创建线索的模态窗口 -->
<div class="modal fade" id="createClueModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">创建线索</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="createClueForm" role="form">

                    <div class="form-group">
                        <label for="create-clueOwner" class="col-sm-2 control-label">所有者<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="owner" id="create-clueOwner">
                            </select>
                        </div>
                        <label for="create-company" class="col-sm-2 control-label">公司<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="company" id="create-company">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-call" class="col-sm-2 control-label">称呼</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="appellation" id="create-call">
                            </select>
                        </div>
                        <label for="create-surname" class="col-sm-2 control-label">姓名<span
                                style="font-size: 15px; color: red;">*</span></label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="fullname" id="create-surname">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-job" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="job" class="form-control" id="create-job">
                        </div>
                        <label for="create-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="email" class="form-control" id="create-email">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" name="phone" id="create-phone">
                        </div>
                        <label for="create-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="website" class="form-control" id="create-website">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-mphone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" name="mphone" class="form-control" id="create-mphone">
                        </div>
                        <label for="create-status" class="col-sm-2 control-label">线索状态</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="state" id="create-status">
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="create-source" class="col-sm-2 control-label">线索来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" name="source" id="create-source">
                            </select>
                        </div>
                    </div>


                    <div class="form-group">
                        <label for="create-describe" class="col-sm-2 control-label">线索描述</label>
                        <div class="col-sm-10" style="width: 81%;">
                            <textarea class="form-control" rows="3" name="description" id="create-describe"></textarea>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                    <div style="position: relative;top: 15px;">
                        <div class="form-group">
                            <label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" name="contactSummary" rows="3"
                                          id="create-contactSummary"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" readonly class="form-control" name="nextContactTime"
                                       id="create-nextContactTime">
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="create-address" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" name="address" id="create-address"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" onclick="create_clue()" class="btn btn-primary">保存</button>
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
                <h4 class="modal-title">修改线索</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" id="updateClueForm" role="form">
                    <input type="hidden" id="clueId" name="id"/>
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
                            <input type="text" class="form-control" name="company" id="edit-company"/>
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
                            <input type="text" class="form-control" id="edit-surname" name="fullname">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-job" class="col-sm-2 control-label">职位</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-job" name="job">
                        </div>
                        <label for="edit-email" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-email" name="email"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-phone" name="phone"/>
                        </div>
                        <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-website"
                                   name="website"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-mphone" class="col-sm-2 control-label">手机</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="edit-mphone" name="mphone"/>
                        </div>
                        <label for="edit-status" class="col-sm-2 control-label">线索状态</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-status" name="state">

                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="edit-source" class="col-sm-2 control-label">线索来源</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <select class="form-control" id="edit-source" name="source">
                            </select>
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
                            <label for="edit-contactSummary" class="col-sm-2 control-label">联系纪要</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" name="contactSummary"
                                          id="edit-contactSummary"></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="edit-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" readonly class="form-control" id="edit-nextContactTime"
                                       name="nextContactTime"/>
                            </div>
                        </div>
                    </div>

                    <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                    <div style="position: relative;top: 20px;">
                        <div class="form-group">
                            <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="1" name="address" id="edit-address"></textarea>
                            </div>
                        </div>
                    </div>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" id="update" class="btn btn-primary">更新</button>
            </div>
        </div>
    </div>
</div>


<div>
    <div style="position: relative; left: 10px; top: -10px;">
        <div class="page-header">
            <h3>线索列表</h3>
        </div>
    </div>
</div>

<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">

    <div style="width: 100%; position: absolute;top: 5px; left: 10px;">

        <div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form id="saveCodeForm" class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">名称</div>
                        <input class="form-control" name="fullname" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">公司</div>
                        <input class="form-control" name="company" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">公司座机</div>
                        <input class="form-control" name="phone" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">线索来源</div>
                        <select id="sources" name="source" class="form-control">
                        </select>
                    </div>
                </div>

                <br>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">所有者</div>
                        <input class="form-control" name="owner" type="text">
                    </div>
                </div>


                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">手机</div>
                        <input class="form-control" name="mphone" type="text">
                    </div>
                </div>

                <div class="form-group">
                    <div class="input-group">
                        <div class="input-group-addon">线索状态</div>
                        <select id="states" name="state" class="form-control">

                        </select>
                    </div>
                </div>

                <button type="button" onclick="saveClue(1,2)" class="btn btn-default">查询</button>

            </form>
        </div>
        <div class="btn-toolbar" role="toolbar"
             style="background-color: #F7F7F7; height: 50px; position: relative;top: 40px;">
            <div class="btn-group" style="position: relative; top: 18%;">
                <button type="button" class="btn btn-primary" onclick="createClue()"><span
                        class="glyphicon glyphicon-plus"></span> 创建
                </button>
                <button type="button" class="btn btn-default" onclick="updateClue()"><span
                        class="glyphicon glyphicon-pencil"></span> 修改
                </button>
                <button type="button" onclick="deleteClue()" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
            </div>


        </div>
        <div style="position: relative;top: 50px;">
            <table class="table table-hover">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td><input type="checkbox" id="parent"/></td>
                    <td>名称</td>
                    <td>公司</td>
                    <td>公司座机</td>
                    <td>手机</td>
                    <td>线索来源</td>
                    <td>所有者</td>
                    <td>线索状态</td>
                </tr>
                </thead>
                <tbody id="allClue">

                </tbody>
            </table>
        </div>

        <div style="height: 50px; position: relative;top: 60px;">
            <div id="cluePage"></div>
        </div>
    </div>

</div>
</body>
</html>
<script>

    saveClue(1, 2);

    //查询数据加分页
    function saveClue(pageNo, pageSizes) {
        //表单信息序列化
        var codeForm = $('#saveCodeForm').serialize();
        //清空上次内容
        $('#allClue').empty();
        $.ajax({
            url: '/crm/workbench/clue/saveAllClue?pageNo=' + pageNo + '&pageSizes=' + pageSizes + '&' + codeForm,
            dataType: 'json',
            type: 'post',
            success: function (data) {
                var list = data.dataList;
                for (var i = 0; i < list.length; i++) {
                    //查询所有线索所据插入其中
                    $('#allClue').append("<tr>\n" +
                        "\t\t\t\t\t\t\t<td><input type='checkbox' class='son' value='" + list[i].id + "' /></td>\n" +
                        "\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" href='/crm/workbench/clue/todetail?id="+list[i].id+"' >" + list[i].fullname + "</a></td>\n" +
                        "\t\t\t\t\t\t\t<td>" + list[i].company + "</td>\n" +
                        "\t\t\t\t\t\t\t<td>" + list[i].phone + "</td>\n" +
                        "\t\t\t\t\t\t\t<td>" + list[i].mphone + "</td>\n" +
                        "\t\t\t\t\t\t\t<td>" + list[i].source + "</td>\n" +
                        "\t\t\t\t\t\t\t<td>" + list[i].name + "</td>\n" +
                        "\t\t\t\t\t\t\t<td>" + list[i].state + "</td>\n" +
                        "\t\t\t\t\t\t</tr>")
                }
                /*采用bootstrap分页插件*/
                $("#cluePage").bs_pagination({
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
                        saveClue(obj.currentPage, obj.rowsPerPage);
                    }
                });
            }
        });
        //异步查询字典的信息
        $.ajax({
            url: '/crm/base/saveAllDictionary',
            dataType: 'json',
            type: 'post',
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    //设置线索来源
                    if (data[i].code == "source") {
                        $('#sources').append("<option></option>")
                        for (var j = 0; j < data[i].dictionaryValues.length; j++) {
                            $('#sources').append("<option value='" + data[i].dictionaryValues[j].value + "'>" + data[i].dictionaryValues[j].text + "</option>")
                        }
                    }
                    //设置线索状态
                    if (data[i].code == "clueState") {
                        $('#states').append("<option></option>")
                        for (var j = 0; j < data[i].dictionaryValues.length; j++) {
                            $('#states').append("<option value='" + data[i].dictionaryValues[j].value + "'>" + data[i].dictionaryValues[j].text + "</option>")
                        }
                    }

                }
            }
        });
    };
    //点击创建按钮
    //createClueModal createClue
    function createClue() {
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
                            $('#create-call').append("<option value='" + data[i].dictionaryValues[j].value + "'>" + data[i].dictionaryValues[j].text + "</option>")
                        }
                    }
                    //设置线索来源
                    if (data[i].code == "source") {
                        for (var j = 0; j < data[i].dictionaryValues.length; j++) {
                            $('#create-source').append("<option value='" + data[i].dictionaryValues[j].value + "'>" + data[i].dictionaryValues[j].text + "</option>")
                        }
                    }
                    //设置线索状态
                    if (data[i].code == "clueState") {
                        for (var j = 0; j < data[i].dictionaryValues.length; j++) {
                            $('#create-status').append("<option value='" + data[i].dictionaryValues[j].value + "'>" + data[i].dictionaryValues[j].text + "</option>")
                        }
                    }
                }
            }
        });
        //时间插件
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
        //异步查询所有者
        $.ajax({
            url: '/crm/settings/saveAllUser',
            dataType: 'json',
            type: 'post',
            success: function (data) {
                for (var i = 0; i < data.length; i++) {
                    $('#create-clueOwner').append("<option value='" + data[i].id + "'>" + data[i].name + "</option>")
                }
            }
        });
        $('#createClueModal').modal('show');
    };

    //点击创建线索模态窗中的保存按钮事件
    function create_clue() {
        //公司名称不能为空//姓名必须填写create-surname create-company
        if ($('#create-company').val() == '') {
            alert("公司名称不能为空");
        } else if ($('#create--surname').val() == '') {
            alert("姓名不能为空")
        } else {
            $.ajax({
                url: '/crm/workbench/clue/saveCompany',
                data: {'company': $('#create-company').val()},
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    if (data.success) {
                        //成功，进行创建线索
                        //序列化表单信息
                        var serialize = $('#createClueForm').serialize();
                        $.ajax({
                            url: '/crm/workbench/clue/addClue?' + serialize,
                            dataType: 'json',
                            type: 'post',
                            success: function (data) {
                                alert(data.mess);
                                if (data.success) {
                                    //关闭模态窗，将其中数据清空，刷新界面
                                    $('#createClueModal').modal('hide');
                                    $('#createClueForm').get(0).reset();
                                    saveClue(1, 2);
                                }
                            }
                        });
                    } else {
                        alert(data.mess);
                    }
                }
            });
        }
    };
    //修改线索
    var company = "";
    //点击修改按钮触发事件
    function updateClue() {
        var fids = [];
        var owner = "";
        var appellation = "";
        var state = "";
        var source = "";

        $('.son').each(function () {
            if ($(this).prop('checked')) {
                fids.push($(this).val());
            }
        });
        if (fids.length == 0) {
            alert("请选择您要修改的线索");
        } else if (fids.length > 1) {
            alert("每次最多修改一个线索");
        } else {
            //根据主键异步查询线索信息
            $.ajax({
                url: '/crm/workbench/clue/saveClueById?id=' + fids.join(),
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    $('#clueId').val(data.id);
                    owner = data.owner;
                    $('#edit-company').val(data.company);
                    company = data.company;
                    appellation = data.appellation;
                    $('#edit-surname').val(data.fullname);
                    $('#edit-job').val(data.job);
                    $('#edit-email').val(data.email);
                    $('#edit-phone').val(data.phone);
                    $('#edit-website').val(data.website);
                    $('#edit-mphone').val(data.mphone);
                    state = data.state;
                    source = data.source;
                    $('#edit-describe').val(data.description);
                    $('#edit-contactSummary').val(data.contactSummary);
                    $('#edit-nextContactTime').val(data.nextContactTime);
                    $('#edit-address').val(data.address);
                }
            });
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
                        if ($(this).val() == owner) {
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
                            if ($(this).val() == appellation) {
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
                            if ($(this).val() == source) {
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
                            if ($(this).val() == state) {
                                $(this).prop("selected", true);
                            }
                        })
                    }
                }
            });
            //显示模态窗
            $('#editClueModal').modal('show');
        }
    }

    //设置修改时间
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


    //点击更新按钮触发事件
    $('#update').click(function () {
        //姓名、公司不能为空，且公司名称不能重复
        if ($('#edit-company').val() == '') {
            alert("公司名称不能为空");
        } else if ($('#edit-surname').val() == '') {
            alert("姓名不能为空");
        } else {
            var flag = false;
            if ($('#edit-company').val() == company) {
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
                    url:'/crm/workbench/clue/updateClue?'+serialize,
                    dataType:'json',
                    type:'post',
                    success:function (data) {
                        alert(data.mess);
                        if (data.success){
                            //成功，关闭模态窗，刷新页面
                            $('#editClueModal').modal('hide');
                            $('#updateClueForm').get(0).reset();
                            saveClue(1, 2);
                        }
                    }
                });
            }
        }
    });

    //删除线索
    function deleteClue(){
        if ($('.son:checked').length==0){
            alert("请选择您要删除的线索")
        } else if ($('.son:checked').length>1){
            alert("每次只能删除一条线索")
        } else {
            var b = confirm("您确定要删除这条线索么？");
            if (b){
                $.ajax({
                    url:'/crm/workbench/clue/deleteClueById',
                    data:{'id':$('.son:checked').val()},
                    dataType:'json',
                    type:'post',
                    success:function (data) {
                        alert(data.mess);
                        if (data.success){
                            //刷新界面
                            saveClue(1,2);
                        }
                    }
                })
            }
        }
    }
</script>