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
	var CTX = '<%= request.getContextPath()%>';
</script>

<!-- 富文本编辑器 -->
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/plugins/editor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="<%=request.getContextPath()%>/plugins/editor/ueditor.all.min.js"></script>
   
<script type="text/javascript">
var currentDate = null;
$(function(){
	$.ajax({
		url:"<%=request.getContextPath()%>/common/databaseCurrentTime.ajax", 
			success:function(data){
				currentDate = data.RSP_BODY.Data.currentTime;
			}
	});
});
$(function () {
	timeOpinion();
});
function timeOpinion() {
	if (!timeComparison()) return false;
	if (!weekReportExist()) return false;
	if (!unMoreNextMonday()) return false;
	return true;
}
function judgeAndChangeStartTime() {
	weekReportTimeFormat();
	if (!timeOpinion()) return false;
	return true;
}
//格式化周报开始日期和结束日期
function weekReportTimeFormat() {
	var weekBeginDate = $("#weekBeginDate").val();
	var date = new Date(weekBeginDate);
	var week = date.getDay();
	week = week != 0 ? (week - 1) : 6; 
	var monday = new Date(date.getTime() - (week * 1000 * 60 * 60 * 24));//周一
	var sunday = new Date(monday.getTime() + (6 * 1000 * 60 * 60 * 24));//周末
	if (!isNaN(parseInt(dateFormat(monday,true)))) {
		$("#weekBeginDate").val(dateFormat(monday,true));
		$("#weekEndDate").val(dateFormat(sunday,true));
	}
}
//周报开始日期不能小于项目计划开始日期
function timeComparison() {
	var weekBeginDate = $("#weekEndDate").val();
	var wbDate = new Date(weekBeginDate.replace(new RegExp(/-/gm) ,"/"));
	var expStartDate = $("#expStartDate").val();
	if (Boolean(expStartDate)){
		var stDate = new Date(expStartDate.replace(new RegExp(/-/gm) ,"/"));
		if (wbDate.getTime() < stDate.getTime()){
			$("#weekReportWarning").text("周报结束日期不能小于项目开始日期【"+expStartDate+"】");
			$("#weekBeginDate").css("border-color","#dd4b39");
			return false;
		}
	}
	$("#weekReportEndWarning").text("");
	$("#weekBeginDate").css("border-color","#d2d6de");
	return true;
}
//已经填写过得周不需要填写周报
function weekReportExist() {
	var weekBeginDate = $("#weekBeginDate").val();
	var wbDate = new Date(weekBeginDate.replace(new RegExp(/-/gm) ,"/"));
	var startTimes = $(".startTimeId");
	var flag = false;
	for (var i = 0,len = startTimes.length; i < len; i++) {
		var startTime = new Date($(startTimes[i]).val());
		var stDateTime = parseInt(new Date(dateFormat(startTime,false)).getTime());
		var endDateTime = parseInt(stDateTime) + (7*1000*60*60*24);
		var wbDateTime = wbDate.getTime();
		if (stDateTime <= wbDateTime && wbDateTime < endDateTime) {
			flag = true;
		}
	}
	if (flag) {
		$("#weekReportWarning").html("周报已经存在不需要填写");
		$("#weekBeginDate").css("border-color","#dd4b39");
		return false;
	}else{
		$("#weekReportWarning").text("");
		$("#weekBeginDate").css("border-color","#d2d6de");
		return true;
	}
}

//周报开始日期不能大于下周一
function unMoreNextMonday() {
	var weekBeginDate = $("#weekBeginDate").val();
	var date = new Date(weekBeginDate);
	var nowDate = new Date(dateFormat(currentDate,false));
	var nowWeek = nowDate.getDay();
	nowWeek = nowWeek != 0 ? (nowWeek - 1) : 6; 
	var nextMonday = new Date(nowDate.getTime() + ((7-nowWeek)*(1000 * 60 * 60 * 24)));
	var nowMonday = new Date(nowDate.getTime() - (nowWeek*(1000 * 60 * 60 * 24)));
	
	//周报填写日期所在周周一
	var rptWeek = date.getDay();
	var rptMonday = rptWeek != 0 ? (rptWeek - 1) : 6; 
	var rptMondayDate = new Date(date.getTime() - (rptMonday*(1000 * 60 * 60 * 24)));
	
	if (nextMonday.getTime() <= date.getTime()){
		$("#weekReportWarning").text("周报开始日期不能大于本周末");
		$("#weekBeginDate").css("border-color","#dd4b39");
		return false;
	}
	
	if (nowMonday <= rptMondayDate && nowWeek < 4) {
		$("#weekReportWarning").text("本周周五之前无法填写本周周报");
		$("#weekBeginDate").css("border-color","#dd4b39");
		return false;
	}
	$("#weekReportWarning").text("");
	$("#weekBeginDate").css("border-color","#d2d6de");
	return true;
}
// 时间格式化
function dateFormat(date,boole) {
	var time = new Date(date);
	var year = time.getFullYear();//年
	var month = time.getMonth()+1; //月   
	var day = time.getDate();//日
	year += (year < 2000)? 1900 : 0;
	if (month < 10) month = "0" + month;
	if (day < 10) day = "0" + day;
	if (boole) {
		return year + "-" + month + "-" + day;
	}else{
		return year + "/" + month + "/" + day;
	}
}
//日期不能为空
function timeIsEmpty() {
	var weekBeginDate = $("#weekBeginDate").val();
	if (!IsEmpty("weekBeginDate","周报日期")) return false;
	weekReportTimeFormat();
	if (!timeOpinion()) return false;
	return true;
}
function updateWeekReport() {
	if (!timeIsEmpty()) return false;
	if (!IsEmpty($("#weekBeginDate").val(),"日期")) return false;
	if (!IsEmpty(milePostEditor.getContent(),"里程碑")) return false;
	if (!IsEmpty(curRptEditor.getContent(),"本周事项汇报")) return false;
	if (!IsEmpty(nextRptEditor.getContent(),"下周重要事项")) return false;
	return true;
}
function IsEmpty(tmp,warn) {
	var empty = $.trim(tmp);
	if (empty == "" || empty == null) {
		window.top.warning("【" + warn + "】不能为空");
		return false;
	}
	return true;
}
function weekReportSave() {
	$("#status").val("0");
	var url = "<%=request.getContextPath()%>/admin/weeklyReport/insertWeeklyReportSave.ajax";
	weekReportAjax(url);
}
function weekReportSubmit() {
	$("#status").val("1");
	var url = "<%=request.getContextPath()%>/admin/weeklyReport/insertWeeklyReportSubmit.ajax";
	weekReportAjax(url);
}
function weekReportAjax(url) {
	if (updateWeekReport()) {
        $("#weekBeginDateForm").val($("#weekBeginDate").val());
        $("#weekEndDateForm").val($("#weekEndDate").val());
        $("#milePostForm").val(milePostEditor.getContent());
        $("#curRptForm").val(curRptEditor.getContent());
        $("#nextRptForm").val(nextRptEditor.getContent());
        $("#curRiskForm").val(curRiskEditor.getContent());
		$.ajax({
			type:"post",
			url:url,
			data:$("#weekReportForm").serialize(),
			success:function(data){
				back();
			},error:function(data){
			}
		});
	}
}
function back(){
	window.history.go(-1);
}
</script>
<style type="text/css">
	#myBootDataGridmyTable td{
 		vertical-align: middle; 
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
              <h3 class="box-title">填写周报</h3>
              <div >
              	<input type="hidden" id="expStartDate" value="${expStartDate}">
              	<c:forEach var="time" items = "${startTimeList}">
              		<input type="hidden" class = "startTimeId" value="${time.weekBeginDate}">
              	</c:forEach> 
              </div>
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
					<form action="" class="form-horizontal">
						<div class="form-group" >
								 <label class="col-sm-2 control-label" for="pkProj">周报周期<span>&nbsp;&nbsp;&nbsp;</span></label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="weekBeginDate" name="weekBeginDate" onblur="judgeAndChangeStartTime()"
					             	onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" />
					             	<div id="weekReportWarning" style="color: #dd4b39;font-size: 12px"></div>
					             </div>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="weekEndDate" name="weekEndDate" readonly="readonly"/>
					             </div>
						</div>
						<div class="form-group " >
							 <label class="col-sm-2 control-label" for="milePost">里程碑<span id="star">&nbsp;&nbsp;*</span></label>
				             <div class="col-sm-8 ">
				             	<div id="milePostTextarea"></div>
				             </div>
						</div>
						<!-- list -->
						<div class="form-group " >
							 <label class="col-sm-2 control-label" for="curRpt">本周事项汇报<span id="star">&nbsp;&nbsp;*</span></label>
				             <div class="col-sm-8">
				             	<div id="curRptTextarea"></div>
				             </div>
						</div>
						<div class="form-group " >
							 <label class="col-sm-2 control-label" for="curRisk">当前重要风险<span>&nbsp;&nbsp;&nbsp;</span></label>
				             <div class="col-sm-8">
				             	<div id="curRiskTextarea"></div>
				             </div>
						</div>
						<div class="form-group">
							 <label class="col-sm-2 control-label" for="nextRpt">下周重要事项<span id="star">&nbsp;&nbsp;*</span></label>
				             <div class="col-md-6" >
								<div id="nextRptTextarea"></div>
							 </div>
						</div>
						<div class="row">&nbsp;</div>
						<div class="form-group" >
							 <label class="col-sm-4 control-label"></label>
				             <div class="col-sm-4" align="center">
				             	<button type="button" class="btn btn-primary btn-sm" onclick="weekReportSave()">暂存</button>
				             	<button type="button" class="btn btn-success btn-sm" onclick="weekReportSubmit()">保存并提交</button>
				             	<button type="button" class="btn btn-danger btn-sm" onclick="back()">取消</button>
				             </div>
						</div>
					</form>
				</div>
	            <div class="row">
	            	<div class="col-md-12">
	            		<form action="" id="weekReportForm">
	            			<input type="text"  id="pkProj" name="pkProj" hidden="hidden" value="${pkProj}"/>
					        <input type="text"  id="status" name="status" hidden="hidden" />
					        <input type="text"  id="weekBeginDateForm" name="weekBeginDate" hidden="hidden" />
					        <input type="text"  id="weekEndDateForm" name="weekEndDate" hidden="hidden" />
					        <input type="text"  id="milePostForm" name="milePost" hidden="hidden" />
					        <input type="text"  id="curRptForm" name="curRpt" hidden="hidden" />
					        <input type="text"  id="nextRptForm" name="nextRpt" hidden="hidden" />
					        <input type="text"  id="curRiskForm" name="curRisk" hidden="hidden" />
	            		</form>
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
<script type="text/javascript">
var milePostEditor = ueEditor("milePostTextarea");
var curRptEditor = ueEditor("curRptTextarea");
var curRiskEditor = ueEditor("curRiskTextarea");
var nextRptEditor = ueEditor("nextRptTextarea");
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