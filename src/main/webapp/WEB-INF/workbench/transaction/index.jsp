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

<script type="text/javascript">

	$(function(){
		
		
		
	});
	
</script>
</head>
<body>

	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>交易列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" id="saveTranForm" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" name="owner" type="text" />
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" name="name" type="text"/>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input class="form-control" name="customerId" type="text">
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">阶段</div>
					  <select name="stage" class="form-control">
					  	<option></option>
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
				    <div class="input-group">
				      <div class="input-group-addon">类型</div>
					  <select name="type" class="form-control">
					  	<option></option>
						  <c:forEach items="${dictionaryTypes}" var="dictionaryType">
							  <c:if test="${dictionaryType.code =='transactionType'}">
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
				      <div class="input-group-addon">来源</div>
				      <select name="source" class="form-control" id="create-clueSource">
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
				      <div class="input-group-addon">联系人名称</div>
				      <input class="form-control" name="contactsId" type="text"/>
				    </div>
				  </div>
				  
				  <button type="button" onclick="saveAllTran(1,2)"  class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" onclick="window.location.href='save.html';"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" onclick="window.location.href='edit.html';"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" /></td>
							<td>名称</td>
							<td>客户名称</td>
							<td>阶段</td>
							<td>类型</td>
							<td>所有者</td>
							<td>来源</td>
							<td>联系人名称</td>
						</tr>
					</thead>
					<tbody id="queryTran">
					</tbody>
				</table>
			</div>
			
			<div id="tranPage" style="height: 50px; position: relative;top: 20px;">
			</div>
			
		</div>
		
	</div>
</body>
</html>
<script>

	saveAllTran(1,2);
	//查询所有数据，支持模糊查询
	function saveAllTran(pageNo,pageSize) {
		var serialize = $('#saveTranForm').serialize();
		$.ajax({
			url: '/crm/workbench/tran/saveAllTran?'+serialize,
			data: {
				'page': pageNo,
				'pageSize': pageSize
			},
			dataType: 'json',
			type: 'post',
			success: function (data) {
				//清空上次数据
				$('#queryTran').empty();
				for (var i = 0; i < data.dataList.length; i++) {
					//将所有数据动态拼接出来
					$('#queryTran').append("" +
							"<tr id='tr"+data.dataList[i].id+"'>\n" +
							"\t\t\t\t\t\t\t<td><input type=\"checkbox\" class='son' value='"+data.dataList[i].id+"' /></td>\n" +
							"\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" href='/crm/workbench/tran/toDetail?id="+data.dataList[i].id+"'>"+data.dataList[i].sname+"-"+data.dataList[i].name+"</a></td>\n" +
							"\t\t\t\t\t\t\t<td>"+data.dataList[i].sname+"</td>\n" +
							"\t\t\t\t\t\t\t<td>"+data.dataList[i].stage+"</td>\n" +
							"\t\t\t\t\t\t\t<td>"+data.dataList[i].type+"</td>\n" +
							"\t\t\t\t\t\t\t<td>"+data.dataList[i].uname+"</td>\n" +
							"\t\t\t\t\t\t\t<td>"+data.dataList[i].source+"</td>\n" +
							"\t\t\t\t\t\t\t<td>"+data.dataList[i].fullname+"</td>\n" +
							"\t\t\t\t\t\t</tr>")
				}
				/*采用bootstrap分页插件*/
				$("#tranPage").bs_pagination({
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
						saveAllTran(obj.currentPage, obj.rowsPerPage);
					}
				});
			}
		});
	}
</script>