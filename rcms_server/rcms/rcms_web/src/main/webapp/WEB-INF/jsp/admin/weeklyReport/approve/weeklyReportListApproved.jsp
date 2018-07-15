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
	var dataHeader = [
					{"dataField":"index","label":"序号","align":"center","valign":"middle","width":"5%"},
					{"dataField":"weekReportTime","label":"周报日期","align":"center","valign":"middle","filter":"setRptweeklyTime"},
					{"dataField":"createUserName","label":"填写人员","align":"center","valign":"middle","width":"7%"},
					{"dataField":"createTime","label":"填写时间","align":"center","valign":"middle"},
					{"dataField":"milePost","label":"里程碑记录","align":"center","valign":"middle","filter":"setMilePost"},
					{"dataField":"curRpt","label":"本周重要事项","align":"center","valign":"middle","filter":"setCurRpt"},
					{"dataField":"nextRpt","label":"下周重要事项","align":"center","valign":"middle","filter":"setNextRpt"},
					{"dataField":"curRisk","label":"当前风险","align":"center","valign":"middle","filter":"setCurRisk"},
					{"dataField":"approvalUserName","label":"审批人","align":"center","valign":"middle","width":"7%"},
					{"dataField":"approvalTime","label":"审批时间","align":"center","valign":"middle"},
					];
	window.setRptweeklyTime = function(obj,index){
		index.append($("<div>【"+obj.weekBeginDate+"】<br>【"+obj.weekEndDate+"】</div>"));
	};
	window.setMilePost = function(obj,createTime){
		createTime.append($("<div class='divEcho'>"+obj.milePost+"</div>"));
	};
	window.setCurRpt = function(obj,milePost){
		milePost.append($("<div class='divEcho'>"+obj.curRpt+"</div>"));
	};
	window.setNextRpt = function(obj,curRpt){
		curRpt.append($("<div class='divEcho'>"+obj.nextRpt+"</div>"));
	};
	window.setCurRisk = function(obj,nextRpt){
		nextRpt.append($("<div class='divEcho'>"+obj.curRisk+"</div>"));
	};
	$("#myTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"rptWeeklyList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/weeklyReport/weeklyReportListApprovedByPkProj.ajax",//请求数据地址（必须）
		drag:true,//表格是否可以拖动换行
		limit:10,//表格显示行数，默认为10
		pagination:true,//是否进行分页，默认true
		loadDataCallBack:eachbind,
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
function eachbind() {
	$(".divEcho").each(function(){
		$(this).bind("mouseenter",function(){
			var echoText = $(this).html();
			var echoSplit = echoText.split("<br>");
			if (echoText.length > 18 || echoSplit.length > 2) {
				$(".divbubbing").show();
				$(".divbubbing").html(echoText);
				var width = parseInt($(".divbubbing").outerWidth());
				var height = parseInt($(".divbubbing").outerHeight());
				var divtop = parseInt($(this).offset().top) - parseInt($(".divbubbing").outerHeight() - 5); 
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
</script>
<style type="text/css">
	#myBootDataGridmyTable td{
 		vertical-align: middle; 
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
	.divEcho{
		width: 120px;
		height: 46px;
		padding: 6px;
		overflow: hidden;
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
              <h3 class="box-title">项目周报</h3>
              <form action="" method="post" id="pkProjectTime">
	              <input type="hidden" id="pkProj" name="pkProj" value="${pkProj}">
			      <input type="hidden" id="expStartDate" name="expStartDate" value="${expStartDate}">
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
		            <form action="" method="post" id="rptWeeklyUpdateForm">
		           	 	<input type="hidden" id="proRptId" name="proRptId" value="">
		           	 	<input type="hidden" id="pkProj" name="pkProj" value="${pkProj}">
		           	 	<input type="hidden" id="weekBeginDate" name="weekBeginDate" value="">
		           	 	<input type="hidden" id="weekEndDate" name="weekEndDate" value="">
		           	 	<input type="hidden" id="milePost" name="milePost" value="">
		           	 	<input type="hidden" id="curRpt" name="curRpt" value="">
		           	 	<input type="hidden" id="curRisk" name="curRisk" value="">
		           	 	<input type="hidden" id="nextRpt" name="nextRpt" value="">
		           	 	<input type="hidden" id="status" name="status" value="">
		           	 	<input type="hidden" id="approvalOpinions" name="approvalOpinions" value="">
		            </form>
	            </div>
         	</div>
        </div>
       
      </div>
      <div id="showCompletionContent">
      	<div class="divbubbing"></div>
      </div>
    </section>
    <!-- /.content -->
  </div>
<%@include file="../../../webfooter.jsp" %>
</div>
</body>

</html>