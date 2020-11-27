<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false" %>
<html>
<head>
    <meta charset="UTF-8">

    <link href="/crm/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
    <script type="text/javascript" src="/crm/jquery/jquery-1.11.1-min.js"></script>
    <script type="text/javascript" src="/crm/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>


    <link href="/crm/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css"
          rel="stylesheet"/>
    <script type="text/javascript"
            src="/crm/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
    <script type="text/javascript"
            src="/crm/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>

    <script type="text/javascript">
        $(function () {
            $("#isCreateTransaction").click(function () {
                if (this.checked) {
                    $("#create-transaction2").show(200);
                } else {
                    $("#create-transaction2").hide(200);
                }
            });
        });
    </script>

</head>
<body>

<!-- 搜索市场活动的模态窗口 -->
<div class="modal fade" id="searchActivityModal" role="dialog">
    <div class="modal-dialog" role="document" style="width: 90%;">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal">
                    <span aria-hidden="true">×</span>
                </button>
                <h4 class="modal-title">搜索市场活动</h4>
            </div>
            <div class="modal-body">
                <div class="btn-group" style="position: relative; top: 18%; left: 8px;">
                    <form class="form-inline" role="form">
                        <div class="form-group has-feedback">
                            <input type="text" class="form-control" id="activityName" style="width: 300px;"
                                   placeholder="请输入市场活动名称，支持模糊查询">
                            <span class="glyphicon glyphicon-search form-control-feedback"></span>
                        </div>
                    </form>
                </div>
                <table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
                    <thead>
                    <tr style="color: #B3B3B3;">
                        <td></td>
                        <td>名称</td>
                        <td>开始日期</td>
                        <td>结束日期</td>
                        <td>所有者</td>
                        <td></td>
                    </tr>
                    </thead>
                    <tbody id="activities">
                    <c:forEach items="${activities}" var="activity">
                        <tr>
                            <td><input type="radio" onclick="clickBind('${activity.id}','${activity.name}')" name="Id"/>
                            </td>
                            <td>${activity.name}</td>
                            <td>${activity.startDate}</td>
                            <td>${activity.endDate}</td>
                            <td>${activity.owner}</td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div id="title" class="page-header" style="position: relative; left: 20px;">
    <h4>转换线索
        <small>${clue.fullname}${clue.appellation}-${clue.company}</small>
    </h4>
</div>
<div id="create-customer" style="position: relative; left: 40px; height: 35px;">
    新建客户：${clue.company}
</div>
<div id="create-contact" style="position: relative; left: 40px; height: 35px;">
    新建联系人：${clue.fullname}${clue.appellation}
</div>
<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
    <input type="checkbox" id="isCreateTransaction"/>
    为客户创建交易
</div>
<div id="create-transaction2"
     style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;">

    <form id="tranFrom">
        <div class="form-group" style="width: 400px; position: relative; left: 20px;">
            <label for="amountOfMoney">金额</label>
            <input type="text" class="form-control" name="money" id="amountOfMoney">
        </div>
        <div class="form-group" style="width: 400px;position: relative; left: 20px;">
            <label for="tradeName">交易名称</label>
            <input type="text" class="form-control" name="name" id="tradeName" value="${clue.company}-">
        </div>
        <div class="form-group" style="width: 400px;position: relative; left: 20px;">
            <label for="expectedClosingDate">预计成交日期</label>
            <input type="text" class="form-control" name="expectedDate" readonly id="expectedClosingDate">
        </div>
        <div class="form-group" style="width: 400px;position: relative; left: 20px;">
            <label for="stage">阶段</label>
            <select id="stage" name="stage" class="form-control">
                <option></option>
                <c:forEach items="${stages}" var="stage">
                    <option value="${stage.value}">${stage.text}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group" style="width: 400px;position: relative; left: 20px;">
            <label for="activity">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal"
                                                      data-target="#searchActivityModal" style="text-decoration: none;"><span
                    class="glyphicon glyphicon-search"></span></a></label>
            <input type="text" class="form-control" id="activity" placeholder="点击上面搜索" readonly/>
            <input type="hidden" name="activityId"/>
        </div>
    </form>

</div>

<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
    记录的所有者：<br>
    <b>${clue.owner}</b>
</div>
<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
    <input class="btn btn-primary" onclick="convert()" type="button" value="转换">
    &nbsp;&nbsp;&nbsp;&nbsp;
    <input class="btn btn-default" type="button" value="取消">
</div>
</body>
</html>
<script>
    //日期设置
    $('#expectedClosingDate').datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: "bottom-left"
    });

    //挡在市场活动模态窗选择好活动后关闭模态窗，将值设置到input中
    function clickBind(id, name) {
        var flag = confirm("您确定选择" + name + "活动为市场活动源么？");
        if (flag) {
            //关闭模态窗
            $('#searchActivityModal').modal('hide');
            $('#activityName').val("");
            //将值设置到input中
            $('#activity').val(name);
            $('#activity').next().val(id);
        }
    }

    //模糊查询市场活动
    $('#activityName').keypress(function (event) {//
        if (event.keyCode == 13) {
            $.ajax({
                url: '/crm/workbench/clue/saveHasActivity',
                data: {
                    'id': '${clue.id}',
                    'name': $('#activityName').val()
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    $('#activities').empty();
                    for (var i = 0; i < data.length; i++) {
                        $('#activities').append("<tr>\n" +
                            "\t\t\t\t\t\t\t\t<td><input type=\"radio\" onclick=\"clickBind('" + data[i].id + "','" + data[i].name + "')\"  name=\"Id\"/></td>\n" +
                            "\t\t\t\t\t\t\t\t<td>" + data[i].name + "</td>\n" +
                            "\t\t\t\t\t\t\t\t<td>" + data[i].startDate + "</td>\n" +
                            "\t\t\t\t\t\t\t\t<td>" + data[i].endDate + "</td>\n" +
                            "\t\t\t\t\t\t\t\t<td>" + data[i].owner + "</td>\n" +
                            "\t\t\t\t\t\t\t</tr>")
                    }
                }
            });
        }
        return false;
    });

    //点击转换按钮触发事件
    function convert() {
        //判断是否创建交易
        if ($('#isCreateTransaction').prop("checked")) {

            //创建交易,form表单中的值不能为空
            if ($('#amountOfMoney').val() == undefined ) {
                alert("交易金额不能为空");
                return;
            }else if($('#amountOfMoney').val() ==""){
                alert("交易金额不能为空");
                return;
            }
            if ($('#tradeName').val() == "${clue.company}-"  ) {
                alert("交易名称不能为空");
                return;
            }else if ($('#tradeName').val() == "") {
                alert("交易名称不能为空");
                return;
            }
            if ( $('#expectedClosingDate').val() == undefined) {
                alert("预计成交日期不能为空");
                return;
            }else if ( $('#expectedClosingDate').val() == "") {
                alert("预计成交日期不能为空");
                return;
            }else {
                //进行日期比较，时间不能必当前时间早
                var reg = new RegExp( '/','g');
                var time = new Date().toLocaleDateString().replace(reg,"-");
                if (time>$('#expectedClosingDate').val()) {
                    alert("预计成交日期不合法");
                    return;
                }
            }
            if ($('#stage').val() == "") {
                alert("交易阶段不能为空");
                return;
            }else if ($('#stage').val() == undefined){
                alert("交易阶段不能为空");
                return;
            }
            if ($('#activity').val() == "" ) {
                alert("市场活动源不能为空");
                return;
            }else if ($('#activity').val() == undefined) {
                alert("市场活动源不能为空");
                return;
            }
            //将表单信息序列化
            var serialize = $('#tranFrom').serialize();

            //发起请求，创建客户
            $.ajax({
                url:'/crm/workbench/clue/clueConvertTran?'+serialize,
                data:{
                    'clueId':'${clue.id}'
                },
                dataType:'json',
                type:'post',
                success:function (data) {
                    alert(data.mess);
                    if (data.success){
                        location.href="/crm/toView/customer/index";
                    }
                }
            });
        }else {
            //发起请求，创建客户
            $.ajax({
                url:'/crm/workbench/clue/clueConvertTran',
                data:{
                    'clueId':'${clue.id}'
                },
                dataType:'json',
                type:'post',
                success:function (data) {
                    alert(data.mess);
                    if (data.success){
                        location.href="/crm/toView/customer/index";
                    }
                }
            });
        }


    }
</script>