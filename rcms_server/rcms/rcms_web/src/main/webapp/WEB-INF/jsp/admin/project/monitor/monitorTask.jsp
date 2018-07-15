<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../../common/head.jsp" %>
<%@include file="../../../common/tree.jsp" %>
<%@include file="../../../common/import.jsp" %>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>RCMS</title>
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<script type="text/javascript">

/*****部门树初始化****/
function initDeptTree(){
	var treeRootUrl = "<%=request.getContextPath()%>/admin/project/monitor/dirTree.ajax";
	$.beTree({
		treeId:"deptTree",
		treeRootUrl:treeRootUrl,
		onClick:queryDept
	});
}
/* 树点击后执行的方法 */
function queryDept(treeNode){
	//alert(treeNode.name+treeNode.dataId+treeNode.parentId);
	$("#dirName").val(treeNode.name);
	$("#dirId").val(treeNode.dataId);
	$("#deptModel").modal('hide');
}
function chooseDept(){
	$("#deptModel").modal('show');
}


$(function(){
	/* 初始化树 */
	initDeptTree();
	/* 任务列表 */
	var dataHeader = [
				{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
				{"dataField":"","label":"序号","align":"center","valign":"middle"},
				{"dataField":"taskCode","label":"任务编码","align":"center","valign":"middle"},
				{"dataField":"taskName","label":"任务名称","align":"center","valign":"middle"},
				{"dataField":"taskTime","label":"计划时间","align":"center","valign":"middle","filter":"setTeskTime"},
				{"dataField":"relEndDate","label":"实际完成时间","align":"center","valign":"middle","filter":"setRelEndDate"},
				{"dataField":"workload","label":"工作量","align":"center","valign":"middle"},
				{"dataField":"status","label":"任务状态","align":"center","valign":"middle"},
				{"dataField":"userCount","label":"参与人数","align":"center","valign":"middle"},
				{"dataField":"","label":"完成进度","align":"center","valign":"middle","filter":"setOperator"}
	];
	
	
	window.setOperator = function(obj,percentage){
		var attend_btn = $("<p>"+obj.percentage+"%"+"</p><button type='button' class='btn btn-primary btn-sm' title=''>查看详情</button>");
		attend_btn.click(function(){
				taskProgressDetail(obj.pkTask);
		});
		percentage.append(attend_btn);
	};
	window.percentage = function(obj,percentage){
		var attend_btns = $("<p>"+obj.percentage+"%</p>");
		percentage.append(attend_btns);
	};
	
	window.setTeskTime=function(obj,taskTime){
		taskTime.html(obj.expStartDate + "&nbsp;至&nbsp;" +obj.expEndDate); 
	};
	window.setRelEndDate=function(obj,relEndDate){
		if(obj.relEndDate==null||obj.relEndDate==''){
			relEndDate.html("--")
		}else{
			relEndDate.html(obj.relEndDate)
		}
	};
	/* 任务基本面信息列表 */
	$("#myTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"taskList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/project/queryProgress.ajax",//请求数据地址（必须）
		drag:true,//表格是否可以拖动换行
		limit:10,//表格显示行数，默认为10
		pagination:true,//是否进行分页，默认true
		param:function(){
			var obj = new Object();
			obj.taskName = $("#taskName").val();
			obj.taskCode = $("#taskCode").val();
			obj.status = $("#status").val();
			obj.relEndDate = $("#relEndDate").val();
			obj.userName = $("#userName").val();
			obj.pkProj = $("#pkProj").val();
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
/* 导出任务或任务详情 */
/*  flag为true时导出简单信息，flag为false时导出详细信息*/
function exportTask(flag){
	var tasks=$("#myTable").getSelectItems();
	if(tasks.length==0){
		warning("请至少选择一条数据");
		return;
	}
	var taskId=[];
	$.each(tasks,function(i,task){
		taskId.push(task.pkTask);
		}
	)
	$("#hiddenExport").attr("href","<%=request.getContextPath()%>/admin/project/exportTask.download?taskId="+taskId+"&flag="+flag);
	$("#hiddenExport2").click();
}
/* 查看任务进度详情 */
function taskProgressDetail(pkTask){
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
	
	$("#hiddenPkTask").val(pkTask);
	$("#taskDetailTable").loadData();
	$("#detailModel").modal('show');
}
</script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/project/projMonitor.do"/>
<c:set var="m_active_code" value="ToolBarProjManage"/>
<div class="wrapper">
  <%@include file="../../../webhead.jsp" %>
  <%@include file="../../../webleft.jsp" %>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Main content 在这里引入主要内容-->
    <section class="content"> 
    
    <div class="row">
        <div class="col-md-12">
          <div >
            <div class="box-header with-border">
              <h3 class="box-title">${projNames }  &nbsp;&nbsp;进度监控</h3>
              
              <div class="box-tools pull-right">
                
              </div>
            </div>
            <div class="box box-info">
            </div>
            <div class="box-body">
	            <div class="row">
		            <form action="" id="taskForm" class="form-horizontal" method="post">
		            	<input type="hidden" id="pkTask" name="pkTask" value="">
		            	<input type="hidden" id="projName" name="projName" value="">
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
						            <label class="col-sm-2 control-label" for="status">任务状态&nbsp;&nbsp;:</label>
						             <div class="col-sm-2">
						             	<select class="form-control" id="status" name="status">
						             		<option value="">请选择状态</option>
						             		<c:forEach var="projectStatus" items="${projectStatus}">
						             			<option value="${projectStatus.code}">${projectStatus.type}</option>
						             		</c:forEach>
						             	</select>
						             </div>
								</div>
						       	<div style="padding-top: 10px;vertical-align: middle;" class="container-fluid" >
						             
						             <label class="col-sm-2 control-label" for="relEndDate">实际完成日期&nbsp;&nbsp;:</label>
						             <div class="col-sm-2">
						             	<input class="form-control" id="relEndDate" mType="input" name="relEndDate" 
											onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});">
						             </div>
						             
						             <div class="col-sm-2">
						             	
						             	<input  id="pkProj"  name="pkProj" value="${pkProj }" hidden="hidden">
						             </div>
						        </div>
					        </div>
					        <div class="row">&nbsp;</div>
					        <div class="row"  align="center">
								<button type="button" class="btn btn-success btn-sm" onclick="queryTest()">
								  <span class="glyphicon glyphicon-search" aria-hidden="true"><span class="my-operation">查询</span></span>
								</button>
								<button type="button" class="btn btn-danger btn-sm" onclick="reset()">
								  <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"><span class="my-operation">重置</span></span>
								</button>
							</div>      
					</form>
				</div>
				<div class="row">
	              	<div style="padding-left: 16px">
	              		<a id="hiddenExport"><div id="hiddenExport2"></div> </a> 
	              		<button type="button" class="btn btn-success btn-sm" onclick="exportTask(true)">
						  <span class="glyphicon glyphicon-export" aria-hidden="true"><span class="my-operation">导出</span></span>
						</button>
						<button type="button" class="btn btn-success btn-sm" onclick="exportTask(false)">
						  <span class="glyphicon glyphicon-export" aria-hidden="true"><span class="my-operation">导出明细</span></span>
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="history.go(-1)">
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
      

	
   
    </section>
    <!-- /.content -->
  </div>
<%@include file="../../../webfooter.jsp" %>
</div>
<%@include file="../../../common/deptModel.jsp" %>
 
</body>
<!-- 任务详情模态框开始 -->
	<div class="modal fade" id="detailModel" z-index="1011" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	
		<div class="modal-dialog" style="width:90% !important;">
			<div class="modal-content">
				<div class="modal-header">
					<p style="text-align:center">任务进度详情</p>
				</div>
				<div class="modal-body">
					<div id="taskDetailTable"  />
					<input name="" hidden="hidden" id="hiddenPkTask">
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
	<!-- 模态框结束 --> 
</html>