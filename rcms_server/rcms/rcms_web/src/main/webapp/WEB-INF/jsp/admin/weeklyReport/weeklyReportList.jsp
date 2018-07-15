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
$(function(){
	var dataHeader = [
					{"dataField":"index","label":"序号","align":"center","valign":"middle","width":"10%"},
					{"dataField":"weekReportTime","label":"周报日期","align":"center","valign":"middle","filter":"setRptweeklyTime"},
					{"dataField":"createUserName","label":"填写人员","align":"center","valign":"middle"},
					{"dataField":"createTime","label":"填写时间","align":"center","valign":"middle"},
					{"dataField":"status","label":"周报状态","align":"center","valign":"middle","filter":"setStatus"},
					{"dataField":"approvalUserName","label":"审批人员","align":"center","valign":"middle"},
					{"dataField":"approvalTime","label":"审批时间","align":"center","valign":"middle"},
					{"dataField":"","label":"操作","align":"center","valign":"middle","filter":"setOperator"},
					];
	window.setRptweeklyTime = function(obj,index){
		index.append($("<div>【"+obj.weekBeginDate+"】<br>【"+obj.weekEndDate+"】</div>"));
	};
	window.setStatus = function(obj,createTime){
		var list = ["未提交","待审批","审批通过","审批驳回"];
		createTime.append($("<div>"+list[parseInt(obj.status)]+"</div>"));
	};
	window.setOperator = function(obj,approvalOpinions){
		var attend_btn = $("<button type='button' class='btn btn-primary btn-sm'>详情</button>");
		attend_btn.click(function(){
	                $("#rptWeeklyBo").val(JSON.stringify(obj))
					$("#pkProjectTime").attr("action","<%=request.getContextPath()%>/admin/weeklyReport/weeklyReportUpdate.do");
					$("#pkProjectTime").submit();
			});
		approvalOpinions.append(attend_btn);
		};
	$("#myTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"rptWeeklyList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/weeklyReport/weeklyReportListGistProject.ajax",//请求数据地址（必须）
		drag:true,//表格是否可以拖动换行
		limit:10,//表格显示行数，默认为10
		pagination:true,//是否进行分页，默认true
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
});
function weekReportAdd() {
	$("#pkProjectTime").attr("action","<%=request.getContextPath()%>/admin/weeklyReport/weeklyReportAdd.do");
	$("#pkProjectTime").submit();
}
function back(){
	window.history.go(-1);
}
</script>
<style type="text/css">
	#myBootDataGridmyTable td{
 		vertical-align: middle; 
	}
	.dataShowDiv{
		width: 150px;
		height:40px;
		overflow: hidden;
		text-align: left;
		line-height: 20px;
	}
	.divbubbing{
		position: absolute;
		color:#FFF;
		background-color: rgb(98, 158, 199);
		border-radius: 5px;
		margin: 6px 12px;
		padding: 6px;
		width: 240px;
	}
</style>
</head>
<javascript></javascript>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/weeklyReport/weeklyReportFill.do"/>
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
              <h3 class="box-title">周报列表</h3>
              <form action="" method="post" id="pkProjectTime">
	              <input type="hidden" id="pkProj" name="pkProj" value="${pkProj}">
			      <input type="hidden" id="expStartDate" name="expStartDate" value="${expStartDate}">
			      <input type="hidden" id="rptWeeklyBo" name="rptWeeklyBo" value="">
		      </form>
              <!-- <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <div class="btn-group">
                </div>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div> -->
            </div>
            <div class="box box-info"></div>
            <div class="box-body">
                <div class="row">
					<div style="padding-left: 16px">
		              		<button type="button" class="btn btn-success btn-sm" 
		              			<c:if test="${flag == '结项'}">style="display: none;"</c:if> onclick="weekReportAdd()">
							  <span class="glyphicon glyphicon-plus" aria-hidden="true"><span class="my-operation">填写周报</span></span>
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
         	</div>
        </div>
       
      </div>
      
    </section>
    <!-- /.content -->
  </div>
<%@include file="../../webfooter.jsp" %>
</div>
</body>

</html>