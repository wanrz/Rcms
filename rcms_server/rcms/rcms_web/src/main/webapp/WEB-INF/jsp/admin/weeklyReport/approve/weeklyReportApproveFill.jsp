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
	var CTX = '<%= request.getContextPath()%>';
</script>
<!-- 富文本编辑器 -->
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/plugins/editor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/plugins/editor/ueditor.all.min.js"></script>
<script type="text/javascript">
//消息提醒
$(function() {
	$("#weekBeginDate").val(dateFormat("${rptWeeklyBo.weekBeginDate}"));
	$("#weekEndDate").val(dateFormat("${rptWeeklyBo.weekEndDate}"));
	approveFlag();
})
function dateFormat(date) {
	var time = new Date(date);
	var year = time.getFullYear();//年
	var month = time.getMonth()+1; //月   
	var day = time.getDate();//日
	year += (year < 2000)? 1900 : 0;
	if (month < 10) month = "0" + month;
	if (day < 10) day = "0" + day;
	return year + "-" + month + "-" + day;
}
function weekReportApproveSubmit() {
	var status = $("#rptWeeklyStatus input:radio:checked").val();
	var approve = $.trim(approvalOpinionEditor.getContent());
	if (status == "3" && (approve == null || approve == "") ) {
		window.top.warning("拒绝时请填写拒绝原因");
		return;
	}
	$("#approvalOpinionFrom").val(approvalOpinionEditor.getContent());
	$("#status").val(status);
	weekReportAjax();
}
function weekReportAjax() {
	$.ajax({
		type:"post",
		url:"<%=request.getContextPath()%>/admin/weeklyReport/insertRptWeeklyApprove.ajax",
		data:$("#weekReportApproveForm").serialize(),
		success:function(data){
			back();
		},error:function(data){
		}
	});
}
function back(){
	window.history.go(-1);
}
function approveFlag() {
	var status = $("#rptWeeklyStatus input:radio:checked").val();
	if (status == "2"){
		$(".keynote").hide();
	}else{
		$(".keynote").show();
	}
}
</script>
<style type="text/css">
	#myBootDataGridmyTable td{
 		vertical-align: middle; 
	}
	.rptWeeklyBoDiv{
		background-color: rgb(238, 238, 238);
		width: 730px;
		border: 1px solid #d2d6de;
		border-radius: 5px;
 		padding: 8px 12px; 
 		margin-top: 8px; 
		min-height: 36px;
	}
	#approvalOpinionTextarea{
		margin-top: 8px;
	}
	#rptWeeklyStatus{
		margin-top: -8px;
	}
	.rptWeeklyBoDiv p{
		margin: auto;
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
            <div class="box box-info"></div>
            <div class="box-body">
                <div class="row">
					<form action="" id="updateWeekReportForm" class="form-horizontal">
						<div class="form-group" >
								 <label class="col-sm-2 control-label" for="proRptId">周报周期</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" readonly="readonly" id="weekBeginDate" name="weekBeginDate"/>
					             </div>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" readonly="readonly" id="weekEndDate" name="weekEndDate"/>
					             </div>
						</div>
						<div class="form-group top" >
							 <label class="col-sm-2 control-label" for="milePost">里程碑</label>
				             <div class="col-sm-8">
								<div class="rptWeeklyBoDiv">${rptWeeklyBo.milePost }</div>
				             </div>
						</div>
						<!-- list -->
						<div class="form-group top" >
							 <label class="col-sm-2 control-label" for="curRpt">本周事项汇报</label>
				             <div class="col-sm-8">
				             	<div class="rptWeeklyBoDiv">${rptWeeklyBo.curRpt }</div>
				             </div>
						</div>
						<div class="form-group top" >
							 <label class="col-sm-2 control-label" for="curRisk">当前重要风险</label>
				             <div class="col-sm-8">
				             	<div class="rptWeeklyBoDiv">${rptWeeklyBo.curRisk }</div>
				             </div>
						</div>
						<div class="form-group top">
							 <label class="col-sm-2 control-label" for="nextRpt">下周重要事项</label>
				             <div class="col-md-6" >
								<div class="rptWeeklyBoDiv">${rptWeeklyBo.nextRpt }</div>
							 </div>
						</div>
						<div class="form-group">
							 <label class="col-sm-2 control-label" for="approve" id="approve">审批<span id="star">&nbsp;&nbsp;*</span></label>
				             <div class="col-md-6 radio-inline" id="rptWeeklyStatus" onclick="approveFlag()">
								<label class="radio-inline">
								  <input type="radio" name="approve" id="pass" value="2" checked="checked"> 通过
								</label>
								<label class="radio-inline">
								  <input type="radio" name="approve" id="refuse" value="3"> 拒绝
								</label>
							 </div>
						</div>
						<div class="form-group">
							 <label class="col-sm-2 control-label" for="approvalOpinion">审批意见<span id="star" class="keynote">&nbsp;&nbsp;*</span></label>
				             <div class="col-md-6" >
								<div id="approvalOpinionTextarea"></div>
							 </div>
						</div>
						</div>
						<div class="row">&nbsp;</div>
						<div class="form-group">
							 <label class="col-sm-4 control-label"></label>
				             <div class="col-sm-4" align="center">
				             	<button type="button" class="btn btn-success btn-sm" id="save" onclick="weekReportApproveSubmit()">保存</button>
				             	<button type="button" class="btn btn-danger btn-sm" onclick="back()">取消</button>
				             </div>
						</div>
					</form>
				</div>
	            <div class="row">
	            	<div class="col-md-12">
	            		<form action="" id="weekReportApproveForm">
	            			<input type="text"  id="proRptId" name="proRptId" hidden="hidden" value="${rptWeeklyBo.proRptId}"/>
					        <input type="text"  id="status" name="status" hidden="hidden" />
					        <input type="text"  id="approvalOpinionFrom" name="approvalOpinions" hidden="hidden" />
	            		</form>
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
</body>
<script type="text/javascript">
var approvalOpinionEditor = ueEditor("approvalOpinionTextarea");
function ueEditor(elementId) {
	var editor = UE.getEditor(elementId,{
		toolbars:[[ 'fontfamily','fontsize','paragraph',  '|',
		            'bold', 'italic', 'underline', 'strikethrough', 'forecolor','backcolor', '|',
		            'indent','justifyleft', 'justifyright','justifycenter', 'justifyjustify', 'insertorderedlist', 'insertunorderedlist', '|',
		            'removeformat','formatmatch','undo', 'redo','|',
		            'rowspacingtop', 'rowspacingbottom', 'lineheight','autotypeset','touppercase','tolowercase',]],
		autoClearinitialContent:true,
		wordCount:false,
		elementPathEnabled:false,
		initialFrameHeight:150,
		initialFrameWidth:730,
		retainOnlyLabelPasted:true,
		zIndex : 500 //显示的层级
	});
	return editor;
}
</script>
</html>