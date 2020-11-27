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

    <style type="text/css">
        .mystage {
            font-size: 20px;
            vertical-align: middle;
            cursor: pointer;
        }

        .closingDate {
            font-size: 15px;
            cursor: pointer;
            vertical-align: middle;
        }
    </style>

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
            $('#parent').on("mouseover", ".remarkDiv", function () {
                $(this).children("div").children("div").show();
            });
            /* $(".remarkDiv").mouseover(function () {
                 $(this).children("div").children("div").show();
             });*/
            $('#parent').on("mouseout", ".remarkDiv", function () {
                $(this).children("div").children("div").hide();
            });
            /* $(".remarkDiv").mouseout(function () {
                 $(this).children("div").children("div").hide();
             });*/
            $('#parent').on("mouseover", ".myHref", function () {
                $(this).children("span").css("color", "red");
            });
            /* $(".myHref").mouseover(function () {
                 $(this).children("span").css("color", "red");
             });*/
            $('#parent').on("mouseout", ".myHref", function () {
                $(this).children("span").css("color", "#E6E6E6");
            });
            /*$(".myHref").mouseout(function () {
                $(this).children("span").css("color", "#E6E6E6");
            });*/


            //阶段提示框
            $(".mystage").popover({
                trigger: 'manual',
                placement: 'bottom',
                html: 'true',
                animation: false
            }).on("mouseenter", function () {
                var _this = this;
                $(this).popover("show");
                $(this).siblings(".popover").on("mouseleave", function () {
                    $(_this).popover('hide');
                });
            }).on("mouseleave", function () {
                var _this = this;
                setTimeout(function () {
                    if (!$(".popover:hover").length) {
                        $(_this).popover("hide")
                    }
                }, 100);
            });
        });


    </script>

</head>
<body>

<!-- 返回按钮 -->
<div style="position: relative; top: 35px; left: 10px;">
    <a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"
                                                                         style="font-size: 20px; color: #DDDDDD"></span></a>
</div>

<!-- 大标题 -->
<div style="position: relative; left: 40px; top: -30px;">
    <div class="page-header">
        <h3>${tran.customerId}-${tran.name}
            <small>￥${tran.money}</small>
        </h3>
    </div>
    <div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
        <a type="button" class="btn btn-default" href='/crm/workbench/tran/toTranEdit?id=${tran.id}'><span
                class="glyphicon glyphicon-edit"></span> 编辑
        </a>
        <button type="button" onclick="deleteTranButton()" class="btn btn-danger"><span
                class="glyphicon glyphicon-minus"></span> 删除
        </button>
    </div>
</div>

<!-- 阶段状态 -->
<div id="divspan" style="position: relative; left: 40px; top: -50px;">
    阶段&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <span class="glyphicon glyphicon-ok-circle mystage" onclick="toStage($(this).attr('data-content'),$(this))"
          data-toggle="popover"
          data-placement="bottom"
          id="1" data-content="资质审查" style="color: #90F790;"></span>
    -----------
    <span class="glyphicon glyphicon-ok-circle mystage" onclick="toStage($(this).attr('data-content'),$(this))"
          data-toggle="popover" data-placement="bottom"
          id="2" data-content="需求分析" style="color: #90F790;"></span>
    -----------
    <span class="glyphicon glyphicon-ok-circle mystage" onclick="toStage($(this).attr('data-content'),$(this))"
          data-toggle="popover" data-placement="bottom"
          id="3" data-content="价值建议" style="color: #90F790;"></span>
    -----------
    <span class="glyphicon glyphicon-ok-circle mystage" onclick="toStage($(this).attr('data-content'),$(this))"
          data-toggle="popover" data-placement="bottom"
          id="4" data-content="确定决策者" style="color: #90F790;"></span>
    -----------
    <span class="glyphicon glyphicon-map-marker mystage" onclick="toStage($(this).attr('data-content'),$(this))"
          data-toggle="popover" data-placement="bottom"
          id="5" data-content="提案/报价" style="color: #90F790;"></span>
    -----------
    <span class="glyphicon glyphicon-record mystage" onclick="toStage($(this).attr('data-content'),$(this))"
          data-toggle="popover" data-placement="bottom"
          id="6" data-content="谈判/复审"></span>
    -----------
    <span class="glyphicon glyphicon-record mystage" onclick="toStage($(this).attr('data-content'),$(this))"
          data-toggle="popover" data-placement="bottom"
          id="7" data-content="成交"></span>
    -----------
    <span class="glyphicon glyphicon-remove mystage" onclick="toStage($(this).attr('data-content'),$(this))"
          data-toggle="popover" data-placement="bottom"
          id="8" data-content="丢失的线索"></span>
    -----------
    <span class="glyphicon glyphicon-remove mystage" onclick="toStage($(this).attr('data-content'),$(this))"
          data-toggle="popover" data-placement="bottom"
          id="9" data-content="因竞争丢失关闭"></span>
    -----------
    <b id="time">
        <c:if test="${empty tran.editTime}">
            ${tran.createTime}
        </c:if>
        <c:if test="${not empty tran.editTime}">
            ${tran.editTime}
        </c:if>
    </b>
</div>

<!-- 详细信息 -->
<div style="position: relative; top: 0px;">
    <div style="position: relative; left: 40px; height: 30px;">
        <div style="width: 300px; color: gray;">所有者</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.owner}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">金额</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${tran.money}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 10px;">
        <div style="width: 300px; color: gray;">名称</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.name}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">预计成交日期</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${tran.expectedDate}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 20px;">
        <div style="width: 300px; color: gray;">客户名称</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.customerId}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">阶段</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="stage">${tran.stage}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 30px;">
        <div style="width: 300px; color: gray;">类型</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.type}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">可能性</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;">
            <b id="possibility">${stage2PossibilityMap.get(tran.stage)}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 40px;">
        <div style="width: 300px; color: gray;">来源</div>
        <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b>${tran.source}</b></div>
        <div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">市场活动源</div>
        <div style="width: 300px;position: relative; left: 650px; top: -60px;"><b>${tran.activityId}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 50px;">
        <div style="width: 300px; color: gray;">联系人名称</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${tran.customerId}</b></div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 60px;">
        <div style="width: 300px; color: gray;">创建者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${tran.createBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;">${tran.createTime}</small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 70px;">
        <div style="width: 300px; color: gray;">修改者</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b
                id="editBy">${tran.editBy}&nbsp;&nbsp;</b>
            <small style="font-size: 10px; color: gray;" id="editTime">${tran.editTime}</small>
        </div>
        <div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 80px;">
        <div style="width: 300px; color: gray;">描述</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${tran.description}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 90px;">
        <div style="width: 300px; color: gray;">联系纪要</div>
        <div style="width: 630px;position: relative; left: 200px; top: -20px;">
            <b>
                ${tran.contactSummary}
            </b>
        </div>
        <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
    <div style="position: relative; left: 40px; height: 30px; top: 100px;">
        <div style="width: 300px; color: gray;">下次联系时间</div>
        <div style="width: 500px;position: relative; left: 200px; top: -20px;"><b>${tran.nextContactTime}</b></div>
        <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
    </div>
</div>

<!-- 备注 -->
<div id="parent" style="position: relative; top: 100px; left: 40px;">
    <div class="page-header">
        <h4>备注</h4>
    </div>
    <c:forEach items="${tran.tranRemarks}" var="tranRemark">
        <!-- 备注 -->
        <div class="remarkDiv" id="div${tranRemark.id}" style="height: 60px;">
            <img title="${tranRemark.createBy}" src="/crm/image/user-thumbnail.png" style="width: 30px; height:30px;">
            <div style="position: relative; top: -40px; left: 40px;">
                <h5 id="noteContent${tranRemark.id}">${tranRemark.noteContent}</h5>
                <font color="gray">交易</font> <font color="gray">-</font> <b>${tran.customerId}-${tran.name}</b>
                <small style="color: gray;"> ${tranRemark.createTime} 由${tranRemark.createBy}</small>
                <div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
                    <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit"
                                                                       onclick="updateTranRemark('${tranRemark.id}',$('#noteContent${tranRemark.id}').text())"
                                                                       style="font-size: 20px; color: #E6E6E6;"></span></a>
                    &nbsp;&nbsp;&nbsp;&nbsp;
                    <a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove"
                                                                       onclick="deleteTranRemark('${tranRemark.id}')"
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
                <button type="button" onclick="addTranRemark($('#remark').val())" class="btn btn-primary">保存</button>
            </p>
        </form>
    </div>
</div>

<!-- 阶段历史 -->
<div>
    <div style="position: relative; top: 100px; left: 40px;">
        <div class="page-header">
            <h4>阶段历史</h4>
        </div>
        <div style="position: relative;top: 0px;">
            <table id="activityTable" class="table table-hover" style="width: 900px;">
                <thead>
                <tr style="color: #B3B3B3;">
                    <td>阶段</td>
                    <td>金额</td>
                    <td>可能性</td>
                    <td>预计成交日期</td>
                    <td>创建时间</td>
                    <td>创建人</td>
                </tr>
                </thead>
                <tbody id="tranHistories">
                <c:forEach items="${tran.tranHistories}" var="tranHistory">
                    <tr id="tr${tranHistory.id}">
                        <td>${tranHistory.stage}</td>
                        <td>${tranHistory.money}</td>
                        <td>${stage2PossibilityMap.get(tranHistory.stage)}</td>
                        <td>${tranHistory.expectedDate}</td>
                        <td>${tranHistory.createTime}</td>
                        <td>${tranHistory.createBy}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>

    </div>
</div>

<div style="height: 200px;"></div>
<!-- 修改交易备注的模态窗口 -->
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
                        <label class="col-sm-2 control-label">内容</label>
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
</body>
</html>
<script>
    stageInit();

    function stageInit() {
        var s = '${tran.stage}'.substr(1, 1);
        if (s < 8) {
            //锚点
            $('#' + s).prop("class", "glyphicon glyphicon-map-marker mystage");
            $('#' + s).prop("style", "color: #90F790");
            $('#divspan span').each(function () {
                if ($(this).prop("id") < $('#' + s).prop("id")) {
                    //绿圈
                    $(this).prop("class", "glyphicon glyphicon-ok-circle mystage");
                    $(this).prop("style", "color: #90F790");
                }
                if ($(this).prop("id") > $('#' + s).prop("id") && $(this).prop("id") < 8) {
                    //黑圈
                    $(this).prop("class", "glyphicon glyphicon-record mystage");
                    $(this).prop("style", "color: black");
                }
                if ($(this).prop("id") == 8) {
                    //黑×
                    $(this).prop("class", "glyphicon glyphicon-remove mystage");
                    $(this).prop("style", "color: black");
                }
                if ($(this).prop("id") == 9) {
                    //黑×
                    $(this).prop("class", "glyphicon glyphicon-remove mystage");
                    $(this).prop("style", "color: black");
                }
            })
        } else if (s == 8) {
            //红叉
            $('#' + s).prop("class", "glyphicon glyphicon-remove mystage");
            $('#' + s).prop("style", "color: red");
            $('#divspan span').each(function () {
                if ($(this).prop("id") < $('#' + s).prop("id")) {
                    //黑圈
                    $(this).prop("class", "glyphicon glyphicon-record mystage");
                    $(this).prop("style", "color: black");
                }
                if ($(this).prop("id") == 9) {
                    //黑×
                    $(this).prop("class", "glyphicon glyphicon-remove mystage");
                    $(this).prop("style", "color: black");
                }
            })

        } else if (s == 9) {
            //红叉
            $this.prop("class", "glyphicon glyphicon-remove mystage");
            $this.prop("style", "color: red");
            $('#divspan span').each(function () {
                if ($(this).prop("id") == 8) {
                    //黑×
                    $(this).prop("class", "glyphicon glyphicon-remove mystage");
                    $(this).prop("style", "");
                }
                if ($(this).prop("id") < 8) {
                    //黑圈
                    $(this).prop("class", "glyphicon glyphicon-record mystage");
                    $(this).prop("style", "");
                }
            })
        }
    }

    function toStage(stage, $this) {
        stage = "0" + $this.prop("id") + stage;
        if ($this.prop("id") < 8) {
            //锚点
            $this.prop("class", "glyphicon glyphicon-map-marker mystage");
            $this.prop("style", "color: #90F790");
            $('#divspan span').each(function () {
                if ($(this).prop("id") < $this.prop("id")) {
                    //绿圈
                    $(this).prop("class", "glyphicon glyphicon-ok-circle mystage");
                    $(this).prop("style", "color: #90F790");
                }
                if ($(this).prop("id") > $this.prop("id") && $(this).prop("id") < 8) {
                    //黑圈
                    $(this).prop("class", "glyphicon glyphicon-record mystage");
                    $(this).prop("style", "color: black");
                }
                if ($(this).prop("id") == 8) {
                    //黑×
                    $(this).prop("class", "glyphicon glyphicon-remove mystage");
                    $(this).prop("style", "color: black");
                }
                if ($(this).prop("id") == 9) {
                    //黑×
                    $(this).prop("class", "glyphicon glyphicon-remove mystage");
                    $(this).prop("style", "color: black");
                }
            })

        } else if ($this.prop("id") == 8) {
            //红叉
            $this.prop("class", "glyphicon glyphicon-remove mystage");
            $this.prop("style", "color: red");
            $('#divspan span').each(function () {
                if ($(this).prop("id") < $this.prop("id")) {
                    //黑圈
                    $(this).prop("class", "glyphicon glyphicon-record mystage");
                    $(this).prop("style", "color: black");
                }
                if ($(this).prop("id") == 9) {
                    //黑×
                    $(this).prop("class", "glyphicon glyphicon-remove mystage");
                    $(this).prop("style", "color: black");
                }
            })

        } else if ($this.prop("id") == 9) {
            //红叉
            $this.prop("class", "glyphicon glyphicon-remove mystage");
            $this.prop("style", "color: red");
            $('#divspan span').each(function () {
                if ($(this).prop("id") == 8) {
                    //黑×
                    $(this).prop("class", "glyphicon glyphicon-remove mystage");
                    $(this).prop("style", "");
                }
                if ($(this).prop("id") < 8) {
                    //黑圈
                    $(this).prop("class", "glyphicon glyphicon-record mystage");
                    $(this).prop("style", "");
                }
            })
        }
        //异步改变界面信息
        $.ajax({
            url: '/crm/workbench/tran/updateTranStage',
            data: {
                'id': '${tran.id}',
                'stage': stage
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                //修改交易:阶段，可能性，修改者，修改时间,交易历史,
                //可能性
                $('#possibility').text(data.stage);

                //阶段
                $('#stage').text(stage);
                //修改者
                $('#editBy').text(data.editBy);
                //修改时间
                $('#editTime').text(data.editTime);
                $('#time').text(data.editTime);
                //交易历史
                for (var i = 0; i < data.tranHistories.length; i++) {
                    $('#tranHistories').append("<tr id=\"tr" + data.tranHistories[i].id + "\">\n" +
                        "                        <td>" + data.tranHistories[i].stage + "</td>\n" +
                        "                        <td>" + data.tranHistories[i].money + "</td>\n" +
                        "                        <td>" + stage + "</td>\n" +
                        "                        <td>" + data.tranHistories[i].expectedDate + "</td>\n" +
                        "                        <td>" + data.tranHistories[i].createTime + "</td>\n" +
                        "                        <td>" + data.tranHistories[i].createBy + "</td>\n" +
                        "                    </tr>")
                }
            }
        });
    };

    //添加备注
    function addTranRemark(noteContent) {
        $.ajax({
            url: '/crm/workbench/tran/addTranRemark',
            data: {
                'noteContent': noteContent,
                'tranId': '${tran.id}'
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                alert("添加备注成功");
                //页面添加dom元素
                $('#remarkDiv').before("<div id='div" + data.id + "' class=\"remarkDiv\" style=\"height: 60px;\">\n" +
                    "            <img title='" + data.createBy + "' src=\"/crm/image/user-thumbnail.png\" style=\"width: 30px; height:30px;\">\n" +
                    "            <div style=\"position: relative; top: -40px; left: 40px;\">\n" +
                    "                <h5 id=\"noteContent" + data.noteContent + "\">" + data.noteContent + "</h5>\n" +
                    "                <font color=\"gray\">交易</font> <font color=\"gray\">-</font> <b>${tran.customerId}-${tran.name}</b>\n" +
                    "                <small style=\"color: gray;\">" + data.createTime + " 由" + data.createBy + "</small>\n" +
                    "                <div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
                    "                    <a class=\"myHref\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\"\n" +
                    "                                                                       onclick=\"updateTranRemark('" + data.id + "',$('#noteContent" + data.id + "').val())\"\n" +
                    "                                                                       style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
                    "                    &nbsp;&nbsp;&nbsp;&nbsp;\n" +
                    "                    <a class=\"myHref\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\"\n" +
                    "                                                                       onclick=\"deleteTranRemark('" + data.id + "')\"\n" +
                    "                                                                       style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
                    "                </div>\n" +
                    "            </div>\n" +
                    "        </div>")
                //将输入框中的内容置空
                $('#remark').val("");
            }
        });
    };

    //修改备注
    function updateTranRemark(id, noteContent) {
        //将信息置入模态窗
        $('#remarkId').val(id);
        $('#noteContent').val(noteContent);
        //显示模态窗
        $('#editRemarkModal').modal('show');

    }

    //点击更新按钮,更新备注
    $('#updateRemarkBtn').click(function () {
        alert($('#noteContent').val());
        $.ajax({
            url: '/crm/workbench/tran/updateTranRemark',
            data: {
                'id': $('#remarkId').val(),
                'noteContent': $('#noteContent').val(),
                'tranId': '${tran.id}'
            },
            dataType: 'json',
            type: 'post',
            success: function (data) {
                if (data.success) {
                    //关闭模态窗
                    $('#editRemarkModal').modal('hide');
                    //修改界面元素
                    $('#noteContent' + $('#remarkId').val()).text($('#noteContent').val());
                }
            }
        });
    });

    //删除备注
    function deleteTranRemark(id) {
        var flag = confirm("您确定要删除该备注么？");
        if (flag) {
            $.ajax({
                url: '/crm/workbench/tran/deleteTranRemark',
                data: {
                    'id': id
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    alert(data.mess);
                    if (data.success) {
                        //修改界面元素
                        $('#div' + id).remove();
                    }
                }
            });
        }
    }

    //删除交易
    function deleteTranButton() {
        var flag = confirm("您确定删除当前交易么？");
        if (flag) {
            $.ajax({
                url: '/crm/workbench/tran/deleteTranById',
                data: {
                    'id': '${tran.id}'
                },
                dataType: 'json',
                type: 'post',
                success: function (data) {
                    alert(data.mess);
                    if (data.success) {
                        //跳转界面
                        location.href = "/crm/toView/transaction/index"
                    }
                }
            });
        }
    }
</script>