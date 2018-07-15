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
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<script type="text/javascript">
var taskObj;
function operate(obj) {
	taskObj={};
	if(obj.taskKey=="approve"){
		taskObj=obj;
		$("#approve").modal('show');
	}else if(obj.taskKey=="projAdjust"){
		taskObj=obj;
		$("#adjust").modal('show');
	}
}

function pass(flag) {
	var url="";
	var message="";
	if(flag){
		url="<%=request.getContextPath()%>/admin/taskDemo/pass.ajax";
		message="审批通过";
	}else{
		url="<%=request.getContextPath()%>/admin/taskDemo/unpass.ajax";
		message="审批拒绝";
	}
	$.ajax({
		type:"post",
		url:url,
		data:{
			pkProj:taskObj.pkProj,
			taskId:taskObj.taskId,
			key:"pass",
			value:flag
		},
		success:function(data){
			$("#myTable").loadData();
			window.top.warning(message);
			$("#approve").modal('hide');
		},
		error:function(data){
			$("#approve").modal('hide');
		}
	});
}

function adjust(flag) {
	var url="";
	var message="";
	if(flag){
		url="<%=request.getContextPath()%>/admin/taskDemo/adjust.ajax";
		message="项目变更成功";
	}else{
		url="<%=request.getContextPath()%>/admin/taskDemo/unadjust.ajax";
		message="拒绝项目变更，流程结束";
	}
	$.ajax({
		type:"post",
		url:url,
		data:{
			pkProj:taskObj.pkProj,
			taskId:taskObj.taskId,
			key:"adjust",
			value:flag
		},
		success:function(data){
			$("#myTable").loadData();
			window.top.warning(message);
			$("#adjust").modal('hide');
		},
		error:function(data){
			$("#adjust").modal('hide');
		}
	});
}

function trace(obj) {
	$("#traceImg").attr("src","<%=request.getContextPath()%>/admin/taskDemo/trace.ajax?processInstanceId="+obj.processInstanceId);
	$("#trace").modal('show'); 
}
$(function(){
	
	var dataHeader = [
				{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
				{"dataField":"processInstanceName","label":"流程名称","align":"center","valign":"middle"},
				{"dataField":"taskName","label":"申请节点","align":"center","valign":"middle"},
				{"dataField":"taskId","label":"申请节点id","align":"center","valign":"middle"},
				{"dataField":"pkProj","label":"项目id","align":"center","valign":"middle"},
				{"dataField":"","label":"办理","align":"center","valign":"middle","filter":"setOperator"},
				{"dataField":"","label":"流程跟踪","align":"center","valign":"middle","filter":"setTrace"}
			
	];
	window.setOperator = function(obj,td){
		var task=JSON.stringify(obj);
		//alert(JSON.stringify(obj));
		var pass = "<input type='button' class='btn btn-success' onclick='operate("+task+")'  value='办理'/>";
	
		td.append(pass);
	}
	window.setTrace = function(obj,td){
		var task=JSON.stringify(obj);
		//alert(JSON.stringify(obj));
		var trace = "<input type='button' class='btn btn-success' onclick='trace("+task+")'  value='跟踪'/>";
		td.append(trace);
	}
	$("#myTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"projList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/taskDemo/taskToDo.ajax",//请求数据地址（必须）
		drag:true,//表格是否可以拖动换行
		limit:10,//表格显示行数，默认为10
		pagination:true,//是否进行分页，默认true
		param:function(){
			var obj = new Object();
			return obj;
			
		},//请求参数，返回json对象（非必须）
		success:function(data){			
		},
		error:function(){
		}
	});
	$("#myTable").loadData();
});


</script>
</head>
<javascript></javascript>
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">
  <%@include file="../../webhead.jsp" %>
  <%@include file="../../webleft.jsp" %>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
       &nbsp;
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section>

    <!-- Main content 在这里引入主要内容-->
    <section class="content"> 
    	 <div class="row">
           	<div class="col-md-12">
           		<div id="myTable"></div>
           	</div>
           </div>
    </section>
    
    <!-- 审批 模态框 -->
	<div class="modal fade" id="approve" tabindex="-1" role="dialog" 
		data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" >提示</h4>
	            </div>
	            <div class="modal-body" style="text-align: center;"><h3>是否审批通过</h3></div>
	          	<div class="row" align="center">审批意见： <textarea class=""></textarea></div>  
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary"  onclick="javascript:pass(true);return false;">通过</button>
	                <button type="button" class="btn btn-default" onclick="javascript:pass(false);return false;">拒绝</button>
	            </div>
	        </div>
	    </div>
	</div>
	
	 <!-- 调整 模态框 -->
	<div class="modal fade" id="adjust" tabindex="-1"  role="dialog" 
		data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog" >
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" >调整</h4>
	            </div>
	            	<div class="modal-body" style="text-align: center;"><h3>项目更改</h3></div>
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary"  onclick="javascript:adjust(true);return false;">调整并提交进行审批</button>
	                <button type="button" class="btn btn-default" onclick="javascript:adjust(false);return false;">不调整并结束流程</button>
	            </div>
	        </div>
	    </div>
	</div>
    <!-- 跟踪图 模态框 -->
	<div class="modal fade" id="trace" tabindex="-1"  role="dialog" 
		data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog" >
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" >任务追踪</h4>
	            </div>
	            	<div class="modal-body" style="text-align: center;"><img id="traceImg" alt="" src=""  /> </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	            </div>
	        </div>
	    </div>
	</div>
    <!-- /.content -->
  </div>
<%@include file="../../webfooter.jsp" %>
</div>
<%@include file="../../common/deptModel.jsp" %>
</body>

</html>