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
  <meta content="width=device-wi.dth, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<script type="text/javascript">
	$(function(){
		var dataHeader = [
					{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
					{"dataField":"","label":"序号","align":"center","valign":"middle"},
					{"dataField":"projName","label":"项目名称","align":"center","valign":"middle"},
					{"dataField":"taskCode","label":"任务编码","align":"center","valign":"middle"},
					{"dataField":"taskName","label":"任务名称","align":"center","valign":"middle"},
					{"dataField":"taskTime","label":"计划时间","align":"center","valign":"middle","filter":"setTeskTime"},
					{"dataField":"workload","label":"工作量","align":"center","valign":"middle"},
					{"dataField":"status","label":"任务状态","align":"center","valign":"middle"},
					{"dataField":"userCount","label":"参与人数","align":"center","valign":"middle"},
					{"dataField":"","label":"操作","align":"center","valign":"middle","filter":"setOperator"}
				
		];
		
		window.setOperator = function(obj,userName){
			var attend_btn = $("<button type='button' class='btn btn-primary btn-sm'>分配人员</button>");
			attend_btn.click(function(){
				var warning = obj.status == "已封存" ? "已封存" : "已完成";
				if (trueOrFalse(obj.status == "已封存" || obj.status == "已完成","【"+warning+"】的任务无法进行人员分配")) return;
				$("#queryStatus").val(obj.status);
				$("#pkProj").val(obj.pkProj);
				$("#workload").val(obj.workload);
				$("#pkTask").val(obj.pkTask);
				$("#projName").val(obj.projName);
				$("#taskForm").attr("action","<%=request.getContextPath()%>/admin/task/addUser.do");
				$("#taskForm").submit();
			});
			userName.append(attend_btn);
		};
		
		window.setTeskTime=function(obj,taskTime){
			taskTime.html(obj.expStartDate + "&nbsp;至&nbsp;" +obj.expEndDate); 
		};
		
		$("#myTable").createTable({
			dataHeader:dataHeader,//数组，每列的属性（必须）
			caption:"",//表格标题内容（非必须）
			root:"taskList",//返回数据的key（必须）
			url:"<%=request.getContextPath()%>/admin/task/queryTask.ajax",//请求数据地址（必须）
			drag:true,//表格是否可以拖动换行
			limit:10,//表格显示行数，默认为10
			pagination:true,//是否进行分页，默认true
			param:function(){
				var obj = new Object();
				obj.pkTask=$("#pkTask").val();
				obj.taskName = $("#taskName").val();
				obj.taskCode = $("#taskCode").val();
				obj.userName = $("#userName").val();
				obj.status = $("#status").val();
				obj.projName=$("#projectName").val();
				obj.expEndDate = $("#expEndDate").val();
				return obj;
				
			},//请求参数，返回json对象（非必须）
			success:function(data){			
			},
			error:function(){
			}
		});
		$("#myTable").loadData();
	});
	
	
	function queryTest(){
		$("#pagemyTable").val("1");
		$("#myTable").loadData();
	}
	function reset(){
		$("#taskForm")[0].reset();
	}

	function addTask(){
		$("#taskForm").attr("action","<%=request.getContextPath()%>/admin/task/addTask.do");
		$("#taskForm").submit();
	}
	
	function updateTask(){
		var task=$("#myTable").getSelectItems();
		if (uniqueComplete(task,"修改")) return;
		if (trueOrFalse(task[0].status == "已封存","已封存的任务不能修改")) return;
		if (trueOrFalse(task[0].percentage != null && task[0].percentage !=0,"该任务已经进行中,无法修改")) return;
		$("#pkTask").val(task[0].pkTask);
		$("#taskForm").attr("action","<%=request.getContextPath()%>/admin/task/updateTask.do");
		$("#taskForm").submit();
	}
	function updateStatus(status) {
		var task=$("#myTable").getSelectItems();
		var warn = status == "3" ? "封存":"解封";
		if (uniqueComplete(task,warn)) return;
		if (trueOrFalse(status == "3" && task[0].status == "已封存","该任务已封存,不需要封存")) return;
		if (trueOrFalse(status == "3" && task[0].status != "已封存" && task[0].status != "未开始","只有【未开始】的任务才能封存")) return;
		if (trueOrFalse(status == "1" && task[0].status != "已封存","该任务没有封存，不需要解封")) return;
		var sta = status == "3" ? "3" : "0";
		$("#alertWarn").html("是否确定"+warn+"任务");
		$("#StatusOk").val(sta);
		$("#statusModal").modal('show');
	}
	function forceComplete(){
		var task=$("#myTable").getSelectItems();
		if (uniqueComplete(task,"强制完成")) return;
		if (trueOrFalse(task[0].status == "已封存","该任务已封存,不能强制完成")) return;
		$("#alertWarn").html("是否确定强制完成该任务");
		$("#StatusOk").val("5");
		$("#statusModal").modal('show');
	}
	function uniqueComplete(task,warn) {
		if (trueOrFalse(task.length == 0,"请选择一条任务进行"+warn)) return true;
		if (trueOrFalse(task.length > 1,"只能选择一条任务进行"+warn)) return true;
		if (trueOrFalse(task[0].status == "已完成","该任务已完成,无法"+warn)) return true;
		if (trueOrFalse(task[0].status == "已强制完成","该任务已强制完成,无法"+warn)) return true;
		return false;
	}
	function statusType(){
		var task = $("#myTable").getSelectItems();
		var remind = ["解封","","","封存","","强制完成"];
		var urlTail = ["devanningTask.ajax","","","binningTask.ajax","","forcibleExecutionTask.ajax"]
		var url = "<%=request.getContextPath()%>/admin/task/" + urlTail[parseInt($('#StatusOk').val())]
		$.ajax({
			type:"post",
			url:url,
			data:{pkTask:task[0].pkTask,status:$("#StatusOk").val()},
			success:function(){
				window.top.warning("任务已"+remind[parseInt($("#StatusOk").val())]);
				$("#myTable").loadData();
				$("#statusModal").modal('hide');
			}
		});
	}
	function trueOrFalse(boole,warning) {
		if(boole){
			window.top.warning(warning);
			return true;
		}
		return false;
	}
	function deleteTask(){
		var task=$("#myTable").getSelectItems();
		if (trueOrFalse(task.length == 0,"请选择要删除的任务")) return;
		var pkTaskList = new Array();
		for(var i=0;i<task.length;i++){
			if (task[i].status == "已完成" || task[i].percentage != 0) {
				continue;
			}
			pkTaskList.push(task[i].pkTask);
		}
		if (pkTaskList.length == 0){
			$("#refreshmyTable").click();
			window.top.warning("已完成或已填写日志的任务，不能被删除");
			return;
		}
		$("#selectedPkProjList").val(JSON.stringify(pkTaskList));
		$("#deleteModal").modal('show');
	}
	
	function deleteThis(){
		$.ajax({
			type:"post",
			url:"<%=request.getContextPath()%>/admin/task/deleteTask.ajax",
			data:{pkTaskList:$("#selectedPkProjList").val()},
			success:function(){
				window.top.warning("删除成功");
				$("#myTable").loadData();
				$("#deleteModal").modal('hide');
			}
		});
	}
	
	function importTask(){
		$("#taskForm").attr("action","<%=request.getContextPath()%>/admin/task/improtTask.do");
		$("#taskForm").submit();
	}
	//
	function taskDetails(){
		var task=$("#myTable").getSelectItems();
		if (trueOrFalse(task.length != 1,"只能选择一条任务进行查看")) return;
		$("#pkTask").val(task[0].pkTask);
		taskProgressDetail($("#pkTask").val());
	}
	
	/* 查看任务进度详情 */
	function taskProgressDetail(pkTask){
		$("#hiddenPkTask").val(pkTask);
		/* 任务详情列表 */
		var detailDataHeader = [
							{"dataField":"","label":"序号","align":"center","valign":"middle"},
							{"dataField":"projName","label":"项目名称","align":"center","valign":"middle"},
							{"dataField":"pmName","label":"项目经理","align":"center","valign":"middle"},
							{"dataField":"taskCode","label":"任务编码","align":"center","valign":"middle"},
							{"dataField":"taskName","label":"任务名称","align":"center","valign":"middle"},
							{"dataField":"taskTime","label":"计划时间","align":"center","valign":"middle","filter":"setTeskTime"},
							{"dataField":"relEndDate","label":"实际完成时间","align":"center","valign":"middle","filter":"setRelEndDate"},
							{"dataField":"requireWorkload","label":"工作量","align":"center","valign":"middle"},
							{"dataField":"status","label":"任务状态","align":"center","valign":"middle"},
							{"dataField":"userName","label":"参与人员","align":"center","valign":"middle"},
 							{"dataField":"percentage","label":"完成进度","align":"center","valign":"middle","filter":"percentage"}
				];
		window.setTeskTime=function(obj,taskTime){
			taskTime.html(obj.expStartDate + "&nbsp;至&nbsp;" +obj.expEndDate); 
		};
		
		window.setRelEndDate=function(obj,relEndDate){
			relEndDate.html(obj.relEndDate); 
		};
		
		window.percentage=function(obj,percentage){
			percentage.html(obj.percentage+"%"); 
		};
		/* 任务详细信息列表 */
		$("#taskDetailTable").createTable({
			dataHeader:detailDataHeader,//数组，每列的属性（必须）
			caption:"",//表格标题内容（非必须）
			root:"taskDetailList",//返回数据的key（必须）
			url:"<%=request.getContextPath()%>/admin/project/queryProgressDetail.ajax",//请求数据地址（必须）
			drag:true,//表格是否可以拖动换行
			limit:10,//表格显示行数，默认为10
			pagination:true,//是否进行分页，默认true
			param:function(){
				var obj = new Object();
				obj.pkTask=$("#hiddenPkTask").val();
				return obj;
				
			},//请求参数，返回json对象（非必须）
			success:function(data){			
			},
			error:function(){
			}
		});
		
		$("#taskDetailTable").loadData();
		$("#detailModel").modal('show');
	}
	
</script>
<style type="text/css">
#myBootDataGridmyTable td{
 		vertical-align: middle; 
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
              <h3 class="box-title">任务分配</h3>
              
              <div class="box-tools pull-right">
                
              </div>
            </div>
            <div class="box box-info">
            </div>
            <div class="box-body">
	            <div class="row">
		            <form action="" id="taskForm" class="form-horizontal" method="post">
		            	<input type="hidden" id="pkTask" name="pkTask" value="">
		            	<input type="hidden" id="queryStatus" name="queryStatus" value="">
		            	<input type="hidden" id="projName" name="projName" value="">
		            	<input type="hidden" id="workload" name="workload">
		            	<input type="hidden" id="pkProj" name="pkProj">
						<div class="searchBox" >
							<div style="padding-top: 10px;vertical-align: middle;" class="container-fluid" >
								<label class="col-sm-2 control-label" for="taskName">任务名称&nbsp;&nbsp;:</label>
					            <div class="col-sm-2">
					            	<input type="text" class="form-control" id="taskName" name="taskName" />
					            </div>
					            <label class="col-sm-2 control-label" for="taskCode">任务编码&nbsp;&nbsp;:</label>
					            <div class="col-sm-2">
					            	<input type="text" class="form-control" id="taskCode" name="taskCode"  />
					            </div>
					            <label class="col-sm-2 control-label" for="userName">参与人&nbsp;&nbsp;:</label>
					            <div class="col-sm-2">
					            	<input type="text" class="form-control" id="userName" name="userName"  />
					            </div>
							</div>
					       	<div style="padding-top: 10px;vertical-align: middle;" class="container-fluid" >
					             <label class="col-sm-2 control-label" for="status">任务状态&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<select class="form-control" id="status" name="status">
					             		<option value="">全部</option>
					             		<c:forEach items="${taskStatus }" var="status">
					             			<option value="${status.code }">${status.type }</option>
					             		</c:forEach>
					             	</select>
					             </div>
					             <label class="col-sm-2 control-label" for="expEndDate">计划完成日期&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input class="form-control" id="expEndDate" mType="input" name="expEndDate" 
										onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});">
					             </div>
					             <label class="col-sm-2 control-label" for="userName">项目名称&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					            	<input type="text" class="form-control" id="projectName" name="projectName"  />
					             </div>
					        </div>
   
					    </div>
					</form>
					<input type="hidden" id="selectedPkProjList" >
				</div>
				<div class="row">&nbsp;</div>
				<div class="searchBtnGroup" align="center">
					<button type="button" class="btn btn-success btn-sm" onclick="queryTest()">
						<span class="glyphicon glyphicon-search" aria-hidden="true"><span class="my-operation">查询</span></span>
					</button>
					<button type="button" class="btn btn-danger btn-sm" onclick="reset()">
						<span class="glyphicon glyphicon-remove-sign" aria-hidden="true"><span class="my-operation">重置</span></span>
					</button>
				</div>   
				<div class="row">&nbsp;</div>
				<div class="row">
	              	<div style="padding-left: 16px">
	              		<button type="button" class="btn btn-success btn-sm" onclick="addTask()">
						  <span class="glyphicon glyphicon-plus" aria-hidden="true"><span class="my-operation">新增</span></span>
						</button>
						<button type="button" class="btn btn-primary btn-sm" onclick="updateTask()">
						  <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">修改</span></span>
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="deleteTask()">
						  <span class="glyphicon glyphicon-trash" aria-hidden="true"><span class="my-operation">删除</span></span>
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="forceComplete()">
						  <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">强制完成</span></span>
						</button>
						<button type="button" class="btn btn-info btn-sm" onclick="taskDetails()">
						  <span class="glyphicon glyphicon-search" aria-hidden="true"><span class="my-operation">任务详情</span></span>
						</button>
						<button type="button" class="btn btn-primary btn-sm" onclick="updateStatus('3')">
						  <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">封存</span></span>
						</button>
						<button type="button" class="btn btn-primary btn-sm" onclick="updateStatus('1')">
						  <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">解封</span></span>
						</button>
						<button type="button" class="btn btn-primary btn-sm" onclick="importTask()">
						  <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">导入</span></span>
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
      
     <div class="modal fade" id="statusModal" tabindex="-1" role="dialog" 
		data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" >提示</h4>
	            </div>
	            <div class="modal-body" align="center" id="alertWarn">是否确定封存任务</div>
	            <input type="hidden" id="Status" name="Status" value="">
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary" onclick="statusType()">确认</button>
	            	<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	            </div>
	        </div>
	    </div>
	</div>
	
    <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" 
		data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" >提示</h4>
	            </div>
	            <div class="modal-body" align="center">是否确定删除任务</div>
	            <input type="hidden" id="StatusOk" name="StatusOk" value="">
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary" onclick="deleteThis()">确认</button>
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
<!-- 任务详情模态框开始 -->
	<div class="modal fade" id="detailModel" z-index="1011" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	
		<div class="modal-dialog" style="width:90% !important;">
			<div class="modal-content">
				<div class="modal-header">
					<p style="text-align:center">任务进度详情</p>
				</div>
				<div class="modal-body">
					<div id="taskDetailTable" ></div>
						<input name="" hidden="hidden" id="hiddenPkTask">
					
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
	<!-- 模态框结束 --> 


</html>