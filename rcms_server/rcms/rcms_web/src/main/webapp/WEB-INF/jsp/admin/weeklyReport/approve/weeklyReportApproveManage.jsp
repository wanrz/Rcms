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
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<script type="text/javascript">
$(function(){
	rptWeeklyListUnapproved();
	$("#unapproved").click();
});
function rptWeeklyListUnapproved() {
	initDeptTree();
	var dataHeader = [
					{"dataField":"index","label":"序号","align":"center","valign":"middle","width":"10%"},
					{"dataField":"projCode","label":"项目编号","align":"center","valign":"middle"},
					{"dataField":"projName","label":"项目名称","align":"center","valign":"middle"},
					{"dataField":"weekReportTime","label":"周报日期","align":"center","valign":"middle","filter":"setRptweeklyTime"},
					{"dataField":"createUserName","label":"填写人员","align":"center","valign":"middle"},
					{"dataField":"createTime","label":"填写时间","align":"center","valign":"middle"},
					{"dataField":"","label":"操作","align":"center","valign":"middle","filter":"setOperator"},
					];
	window.setRptweeklyTime = function(obj,index){
		index.append($("<div>【"+obj.weekBeginDate+"】<br>【"+obj.weekEndDate+"】</div>"));
	};
	window.setOperator = function(obj,createTime){
		var attend_btn = $("<button type='button' class='btn btn-primary btn-sm'>审批</button>");
		attend_btn.click(function(){
				$("#projectRptWeeklyBo").val(JSON.stringify(obj));
				$("#rptWeeklyApproveForm").attr("action","<%=request.getContextPath()%>/admin/weeklyReport/weeklyReportApproveFill.do");
				$("#rptWeeklyApproveForm").submit();
		});
		createTime.append(attend_btn);
	};
	$("#rptWeeklyList").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"rptWeeklyListUnapproved",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/weeklyReport/weeklyReportUnapprovedList.ajax",//请求数据地址（必须）
		drag:true,//表格是否可以拖动换行
		limit:10,//表格显示行数，默认为10
		pagination:true,//是否进行分页，默认true
		param:function(){
			var obj = new Object();
			obj.projName = $("#projName").val();
			obj.projCode = $("#projCode").val(); 
			obj.deptId = $("#deptId").val();
			obj.status = $("#status").val();
			if($("#checkDirName").prop("checked")){
				var deptName=$("#checkDeptName").val();
				$("#checkDirName").val(deptName);
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
	$("#selectedTab").val("0");
	$("#rptWeeklyList").loadData();
}
function weeklyReportListGistProject() {
	initDeptTree();
	var dataHeader = [
					{"dataField":"","label":"序号","align":"center","valign":"middle","width":"10%"},
					{"dataField":"projCode","label":"项目编码","align":"center","valign":"middle"},
					{"dataField":"projName","label":"项目名称","align":"center","valign":"middle"},
					{"dataField":"expStartDate","label":"项目计划开始时间","align":"center","valign":"middle"},
					{"dataField":"expEndDate","label":"项目计划结束时间","align":"center","valign":"middle"},
					{"dataField":"","label":"项目周报","align":"center","valign":"middle","filter":"setOperator"},
					];
	window.setOperator = function(obj,pmName){
		var attend_btn = $("<button type='button' class='btn btn-primary btn-sm'>项目周报</button>");
		attend_btn.click(function(){
               $("#pkProjFrom").val(obj.pkProj);
			   $("#projectRptWeeklyApproveForm").attr("action","<%=request.getContextPath()%>/admin/weeklyReport/weeklyReportListApproved.do");
			   $("#projectRptWeeklyApproveForm").submit();
		});
		pmName.append(attend_btn);
	};
	$("#weeklyReportList").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"projectListByApprovalTime",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/weeklyReport/projectListByApprovalTime.ajax",//请求数据地址（必须）
		drag:true,//表格是否可以拖动换行
		limit:10,//表格显示行数，默认为10
		pagination:true,//是否进行分页，默认true
		param:function(){
			var obj = new Object();
			obj.projName = $("#projName").val();
			obj.projCode = $("#projCode").val(); 
			obj.deptId = $("#deptId").val();
			obj.status = $("#status").val();
			if($("#checkDirName").prop("checked")){
				var deptName=$("#checkDeptName").val();
				$("#checkDirName").val(deptName);
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
	$("#selectedTab").val("1");
	$("#weeklyReportList").loadData();
}
function chooseDept(){
	$("#deptModel").modal('show');
}
function queryUser(){
	$("#pagemyTable").val("1");
	if ($("#selectedTab").val() == "0") {
		$("#rptWeeklyList").loadData();
	}else{
		$("#weeklyReportList").loadData();
	}
}
function reset(){
	$("#userForm")[0].reset();
}

/*****部门树初始化****/
function initDeptTree(){	
	var treeRootUrl = "<%=request.getContextPath()%>/admin/change/dirTree.ajax";
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
</script>
<style type="text/css">
	#myBootDataGridmyTable td{
 		vertical-align: middle; 
	}
	.divManager{
/* 		margin-left: 2px; */
	}
	.unapproved,.approvedRpt{
		bottom: 0;
		padding: 6px 12px!important;
		margin-top: 10px;
		background:#fff;
		color:#444!important;
	}
	.activeA{
		background:#367fa9!important;
		color:#fff!important;
	}
	.unapproved:hover,.approvedRpt:hover{
 		color:#444!important;  
	}
	#myBootDataGridrptWeeklyList td,#myBootDataGridweeklyReportList td{
		vertical-align: middle; 
	}
</style>
</head>
<javascript></javascript>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/weeklyReport/weeklyReportApprove.do"/>
<c:set var="m_active_code" value="ToolBarProjManage"/>
<div class="wrapper">
  <%@include file="../../../webhead.jsp" %>
  <%@include file="../../../webleft.jsp" %>
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
              <h3 class="box-title">周报审批</h3>
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
					            	<label class="col-sm-2 control-label" for="deptName">部门名称&nbsp;&nbsp;:</label>
					            	<div class="col-sm-3">
				             			<input type="text" class="form-control rcms-cut" id="deptName" name="deptName" readOnly="readOnly" value="${authDirBo.dirName }" />
					             		<input  id="deptSeq"  name="deptSeq" hidden="hidden" value="${authDirBo.seq}">
					            	</div>
					            	<div class="col-sm-1">	
						             	<input type="checkbox" id="checkDirName2" class="leftp" name="checkDirName2" style="">&nbsp;&nbsp;全部
						                 <input  id="deptSeq2" name="deptSeq2" value="" hidden="hidden">
						            </div>
					        	</c:if>
					        	<c:if test="${dataId2==null}">
									<label class="col-sm-2 control-label" for="deptName">部门名称&nbsp;&nbsp;:</label>
					            	<div class="col-sm-3">
				             			<input type="text" class="form-control rcms-cut" id="deptName" name="deptName" onclick="chooseDept()" value=""/>
					             		<input type="text"  id="deptId" name="deptId" hidden="hidden"/>
					            	</div>
					            	<div class="col-sm-1">	
					            		<div class="checkbox">
						            		<input type="checkbox"  id="checkDirName" name="checkDirName" value="" >&nbsp;&nbsp;全部 
						                	<input type="hidden" id="checkDeptName" name="checkDeptName" value="">				         
						            	</div>
					            	</div>
				           		</c:if>
				            	<label class="col-sm-2 control-label" for="status">项目状态&nbsp;&nbsp;:</label>
				            	<div class="col-sm-3">
			             			<select class="form-control" name="status" id="status">
				             			<option value="20">全部</option>
				             			<option value="15">未结项</option>
					             		<option value="02">立项审批</option>
					             		<option value="03">开发进行</option>
					             		<option value="04">销售进行</option>
					             		<option value="05">方案评审</option>
					             		<option value="06">结项</option>
				             		</select>
				            	</div>
				        	</div>
						</div>
						<div class="searchBox" >
							<div style="padding-top: 10px;vertical-align: middle;" class="container-fluid" >
								<label class="col-sm-2 control-label" for="projName">项目名称&nbsp;&nbsp;:</label>
					            <div class="col-sm-3">
				             		<input type="text" class="form-control" id="projName" name="projName" />
					            </div>
					            
					            <div class="col-sm-1"></div>
					            
					            <label class="col-sm-2 control-label" for="projCode">项目编码&nbsp;&nbsp;:</label>
					            <div class="col-sm-3">
				             		<input type="text" class="form-control" id="projCode" name="projCode"  />
					            </div>
					        </div>
						</div>
					</form>
				</div>
				<div class="row">&nbsp;</div>
				<div class="row">
	              	<div class="col-md-12" align="center">
	              		<button type="button" class="btn btn-success btn-sm" onclick="queryUser()">
						  <span class="glyphicon glyphicon-search" aria-hidden="true"><span class="my-operation">查询</span></span>
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="reset()">
						  <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"><span class="my-operation">重置</span></span>
						</button>
	              	</div>
                </div>
                <div class="row divManager">
                	<input type="hidden" id="selectedTab">
                	<ul class="nav nav-tabs ">
					    <li ><a class="list-group-item-info unapproved" href="#rptWeeklyList" data-toggle="tab" id="unapproved" onclick="rptWeeklyListUnapproved()">待审批</a></li>
					    <li ><a class="list-group-item-info approvedRpt" href="#weeklyReportList" data-toggle="tab" id="approvedRpt" onclick="weeklyReportListGistProject()">项&nbsp;&nbsp;&nbsp;目</a></li>
					</ul> 
				</div>
	            <div class="row">
	            	<div class="tab-content">
	            		<div class="tab-pane fade in active" id="rptWeeklyList"></div>
	            		<div class="tab-pane fade" id="weeklyReportList"></div>
	            	</div>
	            </div>
	            <div>
		            <form action="" method="post" id="rptWeeklyApproveForm">
		           	 	<input type="hidden" id="projectRptWeeklyBo" name="projectRptWeeklyBo" value="">
		            </form>
	            </div>
	            <div>
		            <form action="" method="post" id="projectRptWeeklyApproveForm">
		           	 	<input type="hidden" id="pkProjFrom" name="pkProj" value="">
		            </form>
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
<script>
	$(".unapproved").click(function(){
		$(this).addClass("activeA")
		$(".approvedRpt").removeClass("activeA")
	})
	$(".approvedRpt").click(function(){
		$(this).addClass("activeA");
		$(".unapproved").removeClass("activeA")
	})
</script>
</html>