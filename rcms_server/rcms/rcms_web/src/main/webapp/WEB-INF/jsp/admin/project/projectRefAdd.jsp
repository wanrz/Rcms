<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../common/head.jsp" %>
<%@include file="../../common/tree.jsp" %>
<%@include file="../../common/import.jsp" %>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>RCMS</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<script type="text/javascript">
/**/
 function projectSave(){
	 var data=$("#myTable").getDataProvider();
	 var regulator = 0;
	 for (var i = 0,len = data.length; i < len; i++) {
		if (data[i].chargeProj == "是" )regulator += 1;
	}
	 var dataSelected = $("#myTable1").getSelectItems();
	 for (var i = 0,len = dataSelected.length; i < len; i++) {
		var comporate = $("#"+dataSelected[i].userId+"-chargeProj").val();
		if (comporate == "2") regulator += 1;
	}
	 if (regulator > 1) {
		 window.top.warning("项目管理者只能有一位");
		 return;
	}
	 var task = [];
	 $.each(dataSelected,function(i,user){
		 var obj={};
		 obj.userId=user.userId;
		 var selectId="#"+user.userId+"-chargeProj";
 		 obj.chargeProj=$(selectId).val();
 		 obj.pkProj=$("#pkProj").val();
		 task.push(obj);
	 });
	 
	 $.ajax({
			type:"post",
			url:"<%=request.getContextPath()%>/admin/project/projectUserSave.ajax",
			data:{taskList:JSON.stringify(task)},
			dataType:"json",
			success:function(data){
				$("#myModal").modal('hide');
				queryAll();
			}
		});
	
	 
}

$(function(){
	queryAll();
});

function queryAll(){
	var dataHeader = [
	  				{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
	  				{"dataField":"","label":"序号","align":"center","valign":"middle"},
	  				{"dataField":"userName","label":"人员姓名","align":"center","valign":"middle"},
	  				{"dataField":"dirName","label":"部门","align":"center","valign":"middle"},
	  				{"dataField":"chargeProj","label":"是否项目管理","align":"center","valign":"middle","filter":"setOperator"},
	  	];
	  	window.setOperator = function(obj,dirName){
	  		var attend_btn = "<select class='form-control' id='"+obj.userId+"-comporate' value='chargeProj' style='width:30%;margin:0 auto;'><option value='1'>否</option><option value='2'>是</option></select>";
	  		dirName.append(attend_btn);
	  	};
	  	$("#myTable").createTable({
	  		dataHeader:dataHeader,//数组，每列的属性（必须）
	  		caption:"",//表格标题内容（非必须）
	  		root:"projectUser",//返回数据的key（必须）
	  		url:"<%=request.getContextPath()%>/admin/project/projectUserQuery.ajax",//请求数据地址（必须）
	  		drag:true,//表格是否可以拖动换行
	  		limit:10,//表格显示行数，默认为10
	  		pagination:true,//是否进行分页，默认true
	  		loadDataCallBack:appendColor,
	  		param:function(){
	  			var obj = new Object();
	  			obj.pkProj = $("#pkProj").val();
	  			return obj;
	  			
	  		},//请求参数，返回json对象（非必须）
	  		success:function(data){			
	  		},
	  		error:function(){
	  		}
	  	});
	  	$("#myTable").loadData();
}

function appendColor() {
	var data=$("#myTable").getDataProvider();
	var trs=$("#myTable").find("tbody").find("tr");
	for (var i = 0; i < data.length; i++) {
		var id = "#"+data[i].userId+"-comporate";
		if (data[i].chargeProj == "是") {
			$(trs[i]).css("background-color","#ddd");
			$(id).find("option:contains('是')").attr("selected",true);
		}
		$(id).bind("change",{"id":id},function(){
			var comporate = $(this).val();
			var trIndex = $(this).parents("tr").prevAll().length;
			comporateOperation(id,trIndex,comporate);
		})
	}
	checkboxChangeInit();
}
function comporateOperation(id,k,comporate) {
	var datas=$("#myTable").getDataProvider();
	$.ajax({
		type:"post",
		url:"<%=request.getContextPath()%>/admin/project/queryProjectRefCharge.ajax",
		data:{"userId":datas[k].userId,"chargeProj":comporate,"pkProj":$("#pkProj").val()},
		success:function(data){
			$("#myTable").loadData();
			return;
		},
		error:function(){
			$("#myTable").loadData();
		}
	});
// 	if(charge>0){
// 		window.top.warning("只能有一位管理者1");
// 		return;
// 	}
	
// 	var data=$("#myTable").getDataProvider();
// 	var trs=$("#myTable").find("tbody").find("tr");
// 	var comporateNum = 0;
// 	for (var i = 0,len = data.length; i < len; i++) {
// 		if (data[i].chargeProj == "是") comporateNum += 1;
// 	}
// 	if (comporateNum > 0 && comporate == "2"){
// 		window.top.warning("只能有一位管理者");
// 		$("#myTable").loadData();
// 		return;
// 	}
// 	$.ajax({
// 		type:"post",
<%-- 		url:"<%=request.getContextPath()%>/admin/project/updateProjectRefUser.ajax", --%>
// 		data:{"userId":data[k].userId,"chargeProj":comporate,"pkProj":$("#pkProj").val()},
// 		success:function(){
// 			$("#myTable").loadData();
// 		}
// 	});
	
}
function userAdd(){
	reset();
	$("#pagemyTable1").val(1);
	var dataHeader1 = [
		  				{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
		  				{"dataField":"","label":"序号","align":"center","valign":"middle"},
		  				{"dataField":"userName","label":"人员姓名","align":"center","valign":"middle"},
		  				{"dataField":"dirName","label":"部门","align":"center","valign":"middle"},
		  				{"dataField":"chargeProj","label":"是否项目管理","align":"center","valign":"middle","filter":"setOperator"},
		  				
		  	];
		   window.setOperator = function(obj,dirName){
			 
			var attend_btn = "<select id='"+obj.userId+"-chargeProj' class='form-control' value='chargeProj' style='width:60%'><option value='1'>否</option><option value='2'>是</option></select>";
			
			dirName.append(attend_btn);
		};
		
		  	$("#myTable1").createTable({
		  		dataHeader:dataHeader1,//数组，每列的属性（必须）
		  		caption:"",//表格标题内容（非必须）
		  		root:"userList",//返回数据的key（必须）
		  		url:"<%=request.getContextPath()%>/admin/project/projectUserList.ajax",//请求数据地址（必须）
		  		drag:true,//表格是否可以拖动换行
		  		limit:5,//表格显示行数，默认为10
		  		pagination:true,//是否进行分页，默认true
		  		param:function(){
		  			var obj = new Object();
		  			obj.pkProj=$("#pkProj").val();
		  			obj.userName=$("#userName").val();
					obj.deptName=$("#deptName").val();
		  			return obj;
		  			
		  		},//请求参数，返回json对象（非必须）
		  		success:function(data){			
		  		},
		  		error:function(){
		  		}
		  	});
		  	$("#myTable1").loadData();
	
}

function deleteUser(){
	var user=$("#myTable").getSelectItems();
	if(user.length == 0){
		window.top.warning("请选择要删除的人员");
		return;
	}
	$("#deleteRefModal").modal('show');
}

function deleteThis(){
	var deleteUser=$("#myTable").getSelectItems();
	var userIdList = new Array();
	for(var i=0;i<deleteUser.length;i++){
		userIdList[i] = deleteUser[i].userId;
	}
	var pkProj=$("#pkProj").val();
	$.ajax({
		type:"post",
		url:"<%=request.getContextPath()%>/admin/project/projectDeleteUser.ajax",
		data:{userList:JSON.stringify(userIdList),pkProj:pkProj},
		success:function(){
			window.top.warning("删除成功");
			$("#myTable").loadData();
			$("#deleteRefModal").modal('hide');
		}
	});
}



function query(){
	var userName=$("#userName").val();
	var deptName=$("#deptName").val();
	$("#pagemyTable1").val("1");
	$("#myTable1").loadData();
}
function reset(){
	$("#userName").val('');
	$("#deptName").val('');
}
$(function(){
	$("#myModal").on('hide.bs.modal', function () {
		$("#pagemyTable1").val("1");
	}); 
})
function checkboxChangeInit() {
	var data=$("#myTable").getDataProvider();
	for (var i = 0,len = data.length; i < len ; i++) {
		if (data[i].chargeProj == "是") {
			$("#"+data[i].userId+"-comporate").find("option:contains('是')").attr("selected",true);
		}
	}
}
</script>
<style>
.mlabel{
	text-align:center;
	padding-top: 7px;
}
#addUserContent{
	position: fixed;
	width: 650px; 
	background-color: white;
	top: 50%;  
	left: 50%;
	-webkit-transform: translate(-50%, -50%);
    transform: translate(-50%, -50%);
}
#myBootDataGridmyTable td{
 		vertical-align: middle;
 		white-space: inherit;
	}
</style>
</head>
<javascript></javascript>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/project/projectRecource.do"/>
<c:set var="m_active_code" value="ToolBarProjManage"/>
<div class="wrapper">
  <%@include file="../../webhead.jsp" %>
  <%@include file="../../webleft.jsp" %>
  <!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			
			<!-- Main content 在这里引入主要内容-->
			<section class="content">

				<ul id="updateTree" class="ztree"
					style="width: 230px; overflow: auto;"></ul>

				<div class="row">
					<div class="col-md-12">
					<div class="box-header with-border">
								<h3 class="box-title">${projNames }&nbsp;&nbsp;资源列表</h3>
								<div class="box-tools pull-right"></div>
							</div>
						<div class="box box-info">
							<div class="box-body">
								<div class="row">
									<form action="" id="userForm" class="form-horizontal">
										<div class="searchBox">
											<div style="padding-top: 10px; vertical-align: middle;"
												class="container-fluid">
												<div class="col-sm-2">
													<input type="hidden"  id="pkProj"name="pkProj" value="${pkProj }" />
													<input type="hidden"  id="pmid"name="pmid" value="${pmid}" />
												</div>
											</div>

										</div>
									</form>
								</div>
								<div class="row">&nbsp;</div>
								<div class="row">
									<div style="padding-left: 16px">
										<button type="button" class="btn btn-success btn-sm"
											data-toggle="modal" data-target="#myModal"
											onclick="userAdd()">
											<span class="glyphicon glyphicon-plus" aria-hidden="true"><span
												class="my-operation">新增</span></span>
										</button>
										<button type="button" class="btn btn-danger btn-sm"
											onclick="deleteUser()">
											<span class="glyphicon glyphicon-trash" aria-hidden="true"><span
												class="my-operation">删除</span></span>
										</button>
										<button type="button" class="btn btn-danger btn-sm"
											onclick="history.go(-1)">
											<span class="glyphicon glyphicon-share-alt"
												aria-hidden="true"><span class="my-operation">返回</span></span>
										</button>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div id="myTable"></div>
									</div>
								</div>
								<div>
									<form action=" " method="post" id="queryForm"></form>
								</div>
							</div>
						</div>
					</div>

				</div>
				<!-- 模态框开始 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div>
						<div id="addUserContent">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<div>
									<label>人员列表</label>
								</div>
							</div>
							<div class="row">&nbsp;</div>
							<div class="row">
								<div class="col-md-12" align="center">
									<label class="col-sm-2 control-label mlabel" for="userName">人员名称&nbsp;&nbsp;:</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="userName"
											name="userName" />
									</div>
									<label class="col-sm-2 control-label mlabel" for="deptName">部门名称&nbsp;&nbsp;:</label>
									<div class="col-sm-4">
										<input type="text" class="form-control" id="deptName"
											name="deptName" />
									</div>
								</div>
							</div>
							<div class="row">&nbsp;</div>
							<div align="center">
								<button type="button" class="btn btn-success btn-sm"
									onclick="query()">
									<span class="glyphicon glyphicon-search" aria-hidden="true"><span
										class="my-operation">查询</span></span>
								</button>
								<button type="button" class="btn btn-danger btn-sm"
									onclick="reset()">
									<span class="glyphicon glyphicon-remove-sign"
										aria-hidden="true"><span class="my-operation">重置</span></span>
								</button>
							</div>
							<div class="row">
								<div class="modal-body">
									<form class="form-horizontal" id="projectForm" method="post">
										<div class="form-group">

											<div class="col-sm-12">
												<div id="myTable1"></div>
											</div>
										</div>

									</form>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">关闭</button>
									<button type="button" class="btn btn-primary"
										onclick="projectSave()" id="projectAddBtn" value=" ">
										保存</button>
								</div>
							</div>
							<!-- /.modal-content -->
						</div>
						<!-- /.modal -->
					</div>
				</div>
				<!-- 模态框结束 -->

				<div class="modal fade" id="deleteRefModal" tabindex="-1"
					role="dialog" data-backdrop="static" data-keyboard="false"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title">提示</h4>
							</div>
							<div class="modal-body" align="center">是否确定删除已选人员</div>
							<input type="hidden" id="Status" name="Status" value="">
							<div class="modal-footer">
								<button type="button" class="btn btn-primary"
									onclick="deleteThis()">确认</button>
								<button type="button" class="btn btn-default"
									data-dismiss="modal">取消</button>
							</div>
						</div>
					</div>
				</div>

			</section>
			<!-- /.content -->
		</div>
		<%@include file="../../webfooter.jsp" %>
</div>
<%@include file="../../common/deptModel.jsp" %>
</body>

</html>