<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../common/head.jsp" %>
<%@include file="../../common/import.jsp" %>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>RCMS</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<script type="text/javascript">
	$(function(){
		var queryStatus = '${queryStatus}';
		if(queryStatus == "已完成"){
			$("#addBtn").hide();
			$("#deleteBtn").hide();
		}
		var dataHeader = [
					{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
					{"dataField":"","label":"序号","align":"center","valign":"middle"},
					{"dataField":"dirName","label":"部门","align":"center","valign":"middle"},
					{"dataField":"userName","label":"姓名","align":"center","valign":"middle"},
					{"dataField":"expStartDate","label":"计划开始日期","align":"center","valign":"middle"},
					{"dataField":"expEndDate","label":"计划完成日期","align":"center","valign":"middle"},
					{"dataField":"requireWorkload","label":"要求人天","align":"center","valign":"middle"}
				
		];
		
		$("#myTable").createTable({
			dataHeader:dataHeader,//数组，每列的属性（必须）
			caption:"",//表格标题内容（非必须）
			root:"userRefList",//返回数据的key（必须）
			url:"<%=request.getContextPath()%>/admin/task/queryUserRef.ajax",//请求数据地址（必须）
			drag:true,//表格是否可以拖动换行
			limit:10,//表格显示行数，默认为10
			pagination:true,//是否进行分页，默认true
			
			param:function(){
				var obj = new Object();
				obj.pkTask = $("#pkTask").val();
				return obj;
				
			},//请求参数，返回json对象（非必须）
			success:function(data){			
			},
			error:function(){
			}
		});
		$("#myTable").loadData();
	});
	$(function(){
		var dataHeader = [
					{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
					{"dataField":"","label":"序号","align":"center","valign":"middle"},
					{"dataField":"dirName","label":"部门","align":"center","valign":"middle"},
					{"dataField":"userName","label":"姓名","align":"center","valign":"middle"},
					{"dataField":"","label":"工作量","align":"center","valign":"middle","filter":"setOperator"}
				
		];
		
		window.setOperator = function(obj,userName){
			var attend_btn = $("<input style='width:100px;' id='"+obj.userId+"_require' class='form-control' />");
			userName.append(attend_btn);
		};
		
		$("#taskUserTable").createTable({
			dataHeader:dataHeader,//数组，每列的属性（必须）
			caption:"",//表格标题内容（非必须）
			root:"userInfoList",//返回数据的key（必须）
			url:"<%=request.getContextPath()%>/admin/task/queryUserInfo.ajax",//请求数据地址（必须）
			drag:true,//表格是否可以拖动换行
			limit:5,//表格显示行数，默认为10
			pagination:true,//是否进行分页，默认true
			param:function(){
				var obj = new Object();
				obj.pkTask = $("#pkTask").val();
				obj.pkProj = $("#pkProj").val();
				obj.userName=$("#userName").val();
				obj.deptName=$("#deptName").val();
				return obj;
				
			},//请求参数，返回json对象（非必须）
			success:function(data){		
				
			},
			error:function(){
				
			}
		});
	});
	
 	function query(){
 		var userName=$("#userName").val();
 		var deptName=$("#deptName").val();
 		$("#pagetaskUserTable").val("1");
 		$("#taskUserTable").loadData();
 	}
 	function reset(){
 		$("#userName").val('');
		$("#deptName").val('');
 	}
	
	function deleteUser(){
		var task=$("#myTable").getSelectItems();
		if(task.length == 0){
			window.top.warning("请选择要删除的人员");
			return;
		}
		$("#deleteModal").modal('show');
	}
	
	function deleteUserRef(){
		var task=$("#myTable").getSelectItems();
		var userIdList = new Array();
		for(var i=0;i<task.length;i++){
			userIdList[i] = task[i].userId;
		}
		
		$.ajax({
			type:"post",
			url:"<%=request.getContextPath()%>/admin/task/deleteUser.ajax",
			data:{userIdList:JSON.stringify(userIdList),pkTask:$("#pkTask").val()},
			success:function(){
				window.top.warning("删除成功");
				$("#myTable").loadData();
				$("#deleteModal").modal('hide');
			}
		});
	}
	
	function addUser(){
		var data=$("#myTable").getDataProvider();
		var userNum = data.length;
		if (userNum > 2) {
			window.top.warning("任务人员已分3人，无需再分配");
			return;
		}
		$("#remainAllocateUser").text(3-userNum);
		var aa = 0;
		var workload = $("#workload").val();
		for(var a = 0;a<data.length;a++){
			aa = aa + parseInt(data[a].requireWorkload);
		}
		if(aa == workload){
			window.top.warning("任务天数已分配完，无需再分配");
			return;
		}
		var b = workload -aa;
		$("#remainAllocateDay").text(b);
		$("#addUserModal").modal('show');
		reset();
		query();
		$("#taskUserTable").loadData();
	}
	
	function subminUser(){
		var workload = $("#remainAllocateDay").text();
		var user=$("#taskUserTable").getSelectItems();
		if(user.length < 1){
			window.top.warning("请选择要添加的人员");
			return;
		}
		var userRemain = $("#remainAllocateUser").text();
		if (user.length > userRemain){
			window.top.warning("选择人数不能大于剩余分配人数【" + userRemain + "】");
			return;
		}
		var day = 0;
		var userIdList=[];
		
		for(i=0;i<user.length;i++){
			
			var require = $("#"+user[i].userId+"_require").val();
			if(require==""){
				window.top.warning("请填写工作量");
				return;
			}
			if(require<=0){
				window.top.warning("工作量必须大于0");
				return;
			}
			var reg = /^\d+(?=\.{0,1}\d+$|$)/
		    if(!reg.test(require)){
			       window.top.warning("工作量必须是数字"); 
			       return  ; 
			  }
		     var regs= /^[0-9]\d*(\.\d{1,1})?$/ 
		    	 if(!regs.test(require)){
				       window.top.warning("工作量最多只能保留一位小数"); 
				       return  ; 
				  }
			
			day = day + parseFloat(require);
			var obj={};
			obj.userId = user[i].userId;
			obj.pkTask = $("#pkTask").val();
			obj.requireWorkload = require;
			userIdList.push(obj);
		}
		

		if(day > workload){
			window.top.warning("总工作量不能超过剩余分配工作量【"+workload+"】");
			return;
		}
		$.ajax({
			type:"post",
			url:"<%=request.getContextPath()%>/admin/task/addUser.ajax",
			data:{userIdList:JSON.stringify(userIdList)},
			success:function(){
				window.top.warning("添加成功");
				$("#addUserModal").modal('hide');
				$("#myTable").loadData();
			}
		});
	}
	
	function back(){
		window.history.go(-1);
	}
</script>

<style type="text/css">
.mlabel{
	text-align:center;
	padding-top: 7px;
}
#myBootDataGridtaskUserTable td{
	height:35px;
	line-height: 35px;
}
#taskUserTable{
	margin: 0px;
	padding: 0px;
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
</style>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/task/taskManage.do"/>
<c:set var="m_active_code" value="ToolBarProjManage"/>
<div class="wrapper">
  <%@include file="../../webhead.jsp" %>
  <%@include file="../../webleft.jsp" %>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Main content 在这里引入主要内容-->
    <section class="content"> 
    
    <div class="row">
        <div class="col-md-12">
          <div >
            <div class="box-header with-border">
              <h3 class="box-title">任务：${projName }&nbsp;已分配人员（<font style="color: red;font-size: 14px;">最多分配3人</font>）</h3>
              <div class="box-tools pull-right"></div>
            </div>
            <div class="box box-info"></div>
            <input type="hidden" id="workload" name="workload" value="${workload}">
            <div class="box-body">
                <div class="row">
		            <form action="" id="taskForm" class="form-horizontal">
		            	<input type="hidden" id="pkTask" name="pkTask" value="${pkTask }">
		            	<input type="hidden" id="pkProj" name="pkProj" value="${pkProj }">
						<div class="searchBox" >
<!-- 							<div class="form-group"> -->
<!-- 								<label class="col-sm-2 control-label" for="taskName">任务名称：</label> -->
<!-- 					            <div class="col-sm-2"> -->
<!-- 					            	<input type="text" class="form-control" id="taskName" name="taskName" /> -->
<!-- 					            </div> -->
<!-- 					            <label class="col-sm-2 control-label" for="taskCode">任务编码:</label> -->
<!-- 					            <div class="col-sm-2"> -->
<!-- 					            	<input type="text" class="form-control" id="taskCode" name="taskCode"  /> -->
<!-- 					            </div> -->
<!-- 					            <label class="col-sm-2 control-label" for="userName">参与人:</label> -->
<!-- 					            <div class="col-sm-2"> -->
<!-- 					            	<input type="text" class="form-control" id="userName" name="userName"  /> -->
<!-- 					            </div> -->
<!-- 							</div> -->
<!-- 					        <div class="searchBtnGroup" align="center"> -->
<!-- 								<button type="button" class="btn btn-success btn-sm" onclick="queryTest()"> -->
<!-- 								  <span class="glyphicon glyphicon-search" aria-hidden="true"><span class="my-operation">查询</span></span> -->
<!-- 								</button> -->
<!-- 								<button type="button" class="btn btn-danger btn-sm" onclick="reset()"> -->
<!-- 								  <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"><span class="my-operation">重置</span></span> -->
<!-- 								</button> -->
<!-- 							</div>       -->
					    </div>
					</form>
				</div>
				<div class="row">&nbsp;</div>
				<div class="row">
	              	<div style="padding-left: 16px">
	              		<button type="button" class="btn btn-success btn-sm" onclick="addUser()" id="addBtn">
						  <span class="glyphicon glyphicon-plus" aria-hidden="true"><span class="my-operation">添加人员</span></span>
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="deleteUser()" id="deleteBtn">
						  <span class="glyphicon glyphicon-trash" aria-hidden="true"><span class="my-operation">删除人员</span></span>
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="back()">
						  <span class="glyphicon glyphicon-share-alt" aria-hidden="true"><span class="my-operation">返回</span></span>
						</button>
	              	</div>
                </div>
	            <div class="row">
	            	<div class="col-md-12">
	            		<div id="myTable"></div>
	            	</div>
	            </div>
	            <div>
	            </div>
            </div>
         </div>
        </div>
      </div>
      <!-- 模态框开始 -->
      <div class="modal fade" id="addUserModal" tabindex="-1" role="dialog" 
		data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div>
	        <div id="addUserContent">
            	<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">&times;</button>
					<div>
						<label>添加人员</label>
					</div>
				</div>
	            <div class="row">&nbsp;</div>
				<div class="row">
					<div class="col-md-12" align="center">
	          			<label class="col-sm-2 control-label mlabel" for="userName">人员名称:</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="userName" name="userName" />
						</div>
						<label class="col-sm-2 control-label mlabel" for="deptName">部门名称:</label>
						<div class="col-sm-4">
							<input type="text" class="form-control" id="deptName" name="deptName" />
						</div>
					</div>
            	</div>
            	<div class="row">&nbsp;</div>
          		<div align="center">
            		<button type="button" class="btn btn-success btn-sm" onclick="query()">
						<span class="glyphicon glyphicon-search" aria-hidden="true"><span class="my-operation">查询</span></span>
					</button>
					<button type="button" class="btn btn-danger btn-sm" onclick="reset()">
				  		<span class="glyphicon glyphicon-remove-sign" aria-hidden="true"><span class="my-operation">重置</span></span>
					</button>
           		</div>
           		<div class="row">&nbsp;</div>
	            <div id="taskUserTable"></div>
	            <div class="modal-body" align="center" id="taskUserTable"></div>
	            <div class="modal-footer">
	            	<label class="col-sm-4 control-label mlabel" style="text-align: left;">剩余分配工作量:<span id="remainAllocateDay"></span>天</label>
	            	<label class="col-sm-4 control-label mlabel" style="text-align: left;">剩余分配人数:<span id="remainAllocateUser"></span>人</label>
	            	<button type="button" class="btn btn-primary" onclick="subminUser()">确认</button>
	            	<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	            </div>
	        </div>
	    </div>
	</div>
	<!-- 模态框结束 -->
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" 
		data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" >提示</h4>
	            </div>
	            <div class="modal-body" align="center">是否确定删除已选人员</div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary" onclick="deleteUserRef()">确认</button>
	            	<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
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