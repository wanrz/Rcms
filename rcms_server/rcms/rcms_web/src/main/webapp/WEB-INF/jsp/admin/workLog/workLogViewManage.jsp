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
<%--   <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/AdminLTE/plugins/select2/select2.min.css">
  <script type="text/javascript" src="<%=request.getContextPath()%>/AdminLTE/plugins/select2/select2.min.js"></script> --%>
<script type="text/javascript">
function elementIsEmpty(eleId,boole,warning) {
	var eleVal = $("#"+eleId).val();
	eleVal = eleVal.trim() == ""? null : eleVal.trim();
	if (eleVal == null) {
		if(boole){
			window.top.warning(warning);
			return true;
		}
		return true;
	}
	return false;
}
function errWarning(boole,warning) {
	if (boole) {
		window.top.warning(warning);
		return true;
	}
	return false;
}
function querWorkLog() {
	$("#myTable").loadData();
}
$(function (){
	initDeptTree();
	var dataHeader = [
					{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
					{"dataField":"logDate","label":"日志日期","align":"center","valign":"middle","width":"9%"},
					{"dataField":"userName","label":"人员姓名","align":"center","valign":"middle","width":"7%"},
					{"dataField":"projName","label":"项目名称","align":"center","valign":"middle","width":"10%"},
					{"dataField":"taskName","label":"任务名称","align":"center","valign":"middle","width":"10%"},
					{"dataField":"workTime","label":"正常工时","align":"center","valign":"middle","width":"7%"},
					{"dataField":"overWorkTime","label":"加班工时","align":"center","valign":"middle","width":"7%"},
					{"dataField":"overWorkReason","label":"加班缘由","align":"center","valign":"middle","filter":"setOverWorkReason","width":"15%"},
					{"dataField":"percentage","label":"任务百分比","align":"center","valign":"middle","width":"9%"},
					{"dataField":"workDesc","label":"任务描述","align":"center","filter":"setWorkDesc","valign":"middle"},
					{"dataField":"","label":"操作","align":"center","valign":"middle","filter":"setOperator"}
					];
	window.setOverWorkReason = function(obj,overWorkTime){
		overWorkTime.append($("<div class='tdDivShow' >"+obj.overWorkReason+"</div>"));
	};
	window.setWorkDesc = function(obj,percentage){
		percentage.append($("<div class='tdDivShow' >"+obj.workDesc+"</div>"));
	};
	window.setOperator = function(obj,workDesc){
		workDesc.append($("<button class='btn btn-primary btn-sm' onclick='workLogViewVisual("+obj.pkProj+","+obj.userId+")'>日报可视化</button>"));
	};
	$("#myTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"workLogViewList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/workLog/queryWorkLogViewList.ajax",//请求数据地址（必须）
		drag:true,//表格是否可以拖动换行
		limit:10,//表格显示行数，默认为10
		pagination:true,//是否进行分页，默认true
		loadDataCallBack:eachbind,
		param:function(){
			var obj = new Object();
			obj.projName = $("#projName").val();
			obj.userName = $("#userName").val(); 
			obj.deptId = $("#deptId").val();
			obj.beginDate = $("#beginDate").val();
			obj.endDate = $("#endDate").val();
			if($("#checkDirName").prop("checked")){
				var aa=$("#checkDeptName").val();
				$("#checkDirName").val(aa);
				obj.checkDirName = $("#checkDirName").val();
			}else{
				$("#checkDirName").val("");
				obj.checkDirName = $("#checkDirName").val();
			}
  			//数据权限仅为本部门的即为02的
  			if($("#checkDirName2").prop("checked")){
				var deptSeq=$("#deptSeq").val();
				$("#deptSeq2").val(deptSeq);
				obj.checkDirName2 = $("#deptSeq2").val();
			}else{
				$("#deptSeq2").val("");
				obj.checkDirName2 = $("#deptSeq2").val();
			}	
			return obj;
		},//请求参数，返回json对象（非必须）
		success:function(data){			
		},
		error:function(){
		}
	});
	$("#myTable").loadData();
})
function eachbind() {
	$(".tdDivShow").each(function(){
		$(this).bind("mouseenter",function(){
			var echoText = $(this).html();
			var echoSplit = echoText.split("<br>");
			if (echoText.length > 26 || echoSplit.length > 2) {
				$(".divbubbing").show();
				$(".divbubbing").html(echoText);
				var width = parseInt($(".divbubbing").outerWidth());
				var height = parseInt($(".divbubbing").outerHeight());
				var divtop = parseInt($(this).offset().top) - parseInt($(".divbubbing").outerHeight()); 
				var divleft = parseInt($(this).offset().left) - parseInt($(".divbubbing").outerWidth())/4;
				$(".divbubbing").offset({top:divtop,left:divleft});
			}
		});
		$(this).bind("mouseleave",function(){
			$(".divbubbing").hide();
		})
	});
	$(".divbubbing").bind("mouseenter",function(){
		$(".divbubbing").show();
	});
	$(".divbubbing").bind("mouseleave",function(){
		$(".divbubbing").hide();
	});
}
function exportWorkLogView(){
	var workLog=$("#myTable").getSelectItems();
	if(errWarning(workLog.length == 0,"请选择要导出的日志")) return;
	var pkWorkLogList = [];
	$.each(workLog,function(i,val){
		pkWorkLogList.push(new Object(val.pkWorkLog));
	});
	var fileName = "工作日志详情";
	var fileType = "xlsx";
	$("#workLogForm").attr("action","<%=request.getContextPath()%>/admin/workLog/exportWorkLogView.download?pkWorkLogList="+pkWorkLogList+"&fileType="+fileType+"&fileName="+fileName);
	$("#workLogForm").submit();
}
function workLogViewVisual(pkProj,userId){
	$("#pkProjVisFrom").val(pkProj);
	$("#userIdVisFrom").val(userId);
	$("#workLogViewVisualByProjUser").attr("action","<%=request.getContextPath()%>/admin/workLog/workLogViewVisual.do");
	$("#workLogViewVisualByProjUser").submit();
}
function reset(){
	$("#userForm")[0].reset();
}
$(function(){
	//在部门输入框上增加悬停事件
	$("#deptName").hover(function(){
		var dirName=$("#deptName").val();
		if(!dirName){
			return;
		}
		$("#deptName").attr("title",dirName);
	});
});
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
	$("#deptName").val(treeNode.name);
	$("#deptId").val(treeNode.dataId);
	$("#deptModel").modal('hide');
	$("#checkDeptName").val(treeNode.dirSeq);
}
function chooseDept(){
	$("#deptModel").modal('show');
}
</script>
<style type="text/css">
	#myBootDataGridmyTable td{
 		vertical-align: middle;
 		white-space: inherit;
	}
	.selectstyle{
		padding: 4px ;
	}
	.tdDivShow{
/* 		height: 40px; */
		max-width: 200px;
		overflow: hidden;
	}
	.divbubbing{
		position: absolute;
		color:#FFF;
		background-color: rgb(98, 158, 199);
		border-radius: 5px;
		margin: 6px 12px;
		padding: 10px;
		max-height: 160px;
		max-width:300px;
		overflow: hidden;
		overflow-y:auto; 
		display: none;
	}
</style>
</head>
<javascript></javascript>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/workLog/workLogViewManage.do"/>
<c:set var="m_active_code" value="ToolBarProjManage"/>
<div class="wrapper">
  <%@include file="../../webhead.jsp" %>
  <%@include file="../../webleft.jsp" %>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <!-- <section class="content-header">
      <h1>
       &nbsp;
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section> -->

    <!-- Main content 在这里引入主要内容-->
    <section class="content"> 
    
  <ul id="updateTree" class="ztree" style="width:230px;overflow:auto;"></ul>
    
    <div class="row">
        <div class="col-md-12">
            <div class="box-header with-border">
              <h3 class="box-title">日志查看</h3>
              <!-- <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <div class="btn-group">
                </div>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div> -->
            </div>
          <div class="box box-info">
          </div>
            <div class="box-body">
	            <div class="row">
		            <form action="" id="userForm" class="form-horizontal">
						<div class="searchBox" >
							<div class="container-fluid" style="padding-top: 10px;vertical-align: middle;">
				            	<c:if test="${dataId2!=null}">
					             <label class="col-sm-2 control-label" for="deptName">部门&nbsp;&nbsp;:</label>
					             <div class="col-sm-2" style="position: relative;">
					             		<input class="form-control" id="deptName"  name="deptName" title="${authDirBo.dirName}" value="${authDirBo.dirName}" readOnly="readOnly">
					             		<input  id="deptSeq"  name="deptSeq" hidden="hidden" value="${authDirBo.seq}">
					             </div>
					              <div class="col-sm-1">	
					             	<input type="checkbox" id="checkDirName2" class="leftp" name="checkDirName2" style="">&nbsp;&nbsp;全部
					                <input  id="deptSeq2" name="deptSeq2" value="" hidden="hidden">
					             </div>
					             </c:if>
					             <c:if test="${dataId2==null}">
					             <label class="col-sm-2 control-label" for="deptName">部门&nbsp;&nbsp;:</label>
					             <div class="col-sm-2" style="position: relative;">
					             		<input class="form-control" id="deptName"  name="deptName" title="${authDirBo.dirName}" onClick="chooseDept()">
					             		<input  id="deptId"  name="deptId" hidden="hidden">
					             </div>
					             <div class="col-sm-1">	
				            		<div class="checkbox">
					            		<input type="checkbox"  id="checkDirName" name="checkDirName" value="" >&nbsp;&nbsp;全部 
					                	<input type="hidden" id="checkDeptName" name="checkDeptName" value="">				         
					            	</div>
				            	</div>
					             </c:if>
					             <label class="col-sm-2 control-label" for="projName">项目名称&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					            	<input type="text" id="projName" class="form-control" >
					             </div>
					             <label class="col-sm-1 control-label" for="userName">姓名&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					            	<input type="text" id="userName" class="form-control" >
					             </div>
				        	</div>
						</div>
						<div class="searchBox" >
							<div style="padding-top: 10px;vertical-align: middle;" class="container-fluid" >
								<label class="col-sm-2 control-label" for="beginDate">开始结束日期&nbsp;&nbsp;:</label>
					            <div class="col-sm-2">
					             	<input type="text" class="form-control" id="beginDate" name="beginDate" onblur="judgeAndChangeStartTime()"
					             	onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" />
					            </div>
					            <div class="col-sm-2">
					             	<input type="text" class="form-control" id="endDate" name="endDate" onblur="judgeAndChangeStartTime()"
					             	onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" />
					            </div>
					        </div>
						</div>
					</form>
				</div>
				<div class="row">&nbsp;</div>
				<div class="row">
	              	<div class="col-md-12" align="center">
	              		<button type="button" class="btn btn-success btn-sm" onclick="querWorkLog()">
						  <span class="glyphicon glyphicon-search" aria-hidden="true"><span class="my-operation">查询</span></span>
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="reset()">
						  <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"><span class="my-operation">重置</span></span>
						</button>
	              	</div>
                </div>
                <div class="row">
                	<div class="col-md-12" align="right">
	              		<button type="button" class="btn btn-primary btn-sm" onclick="exportWorkLogView()" id="exportWorkLogView">
						  <span class="glyphicon glyphicon-export" aria-hidden="true"><span class="my-operation">导出</span></span>
						</button>
	              	</div>
                </div>
	            <div class="row">
	            	<div class="col-md-12">
	            		<div id="myTable"></div>
	            	</div>
	            </div>
         </div>
        </div>
       
      </div>
      <div class="divbubbing"></div>
      <div>
      	<form action="" id="workLogForm" method="post"></form>
      	<form action="" id="workLogViewVisualByProjUser" method="post">
      		<input type="hidden" id="pkProjVisFrom" name="pkProj" >
      		<input type="hidden" id="userIdVisFrom" name="userId" >
      	</form>
      </div>
    </section>
    <!-- /.content -->
  </div>
<%@include file="../../webfooter.jsp" %>
</div>
<%@include file="../../common/deptModel.jsp" %>
</body>

</html>