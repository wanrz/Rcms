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
var trs;
var dataList;
var workInfo = {};
$(function () {
	tableOnload();
})
function tableOnload(){
		var dataHeader = [
					{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
					{"dataField":"whatday","label":"星期","align":"center","valign":"middle","width":"65px"},
					{"dataField":"theDay","label":"任务日期","align":"center","valign":"middle","width":"9%"},
					{"dataField":"expStratDate","label":"任务开始日期","align":"center","valign":"middle","width":"9%"},
					{"dataField":"projName","label":"项目名称","align":"center","valign":"middle"},
					{"dataField":"taskName","label":"任务名称","align":"center","valign":"middle"},
					{"dataField":"workTime","label":"正常工时","align":"center","valign":"middle","filter":"setWorkTime","width":"6%"},
					{"dataField":"overWorkTime","label":"加班工时","align":"center","valign":"middle","filter":"setOverWorkTime","width":"6%"},
					{"dataField":"overWorkReason","label":"加班缘由","align":"center","valign":"middle","filter":"setOverWorkReason","width":"17%"},
					{"dataField":"percentage","label":"任务百分比","align":"center","valign":"middle","filter":"setPercentage","width":"9%"},
					{"dataField":"workDesc","label":"任务描述","align":"center","valign":"middle","filter":"setWorkDesc"},
					{"dataField":"","label":"操作","align":"center","valign":"middle","filter":"setOperator"}
		];
		window.setOperator = function(obj,setWorkDesc){
			var attend_btn = $("<button type='button' class='btn btn-primary btn-sm' >保存</button>");
			attend_btn.click(function(){
				updateWorkLog(this);
			});
			setWorkDesc.append(attend_btn);
		};
		window.setWorkTime = function(obj,taskName){
			taskName.append($(commonAppend(obj,"workTime")));
		};
		window.setOverWorkTime = function(obj,workTime){
			workTime.append($(commonAppend(obj,"overWorkTime")));
		};
		window.setOverWorkReason = function(obj,overWorkTime){
			overWorkTime.append($(commonAppend(obj,"overWorkReason")));
		};
		window.setPercentage = function(obj,overWorkReason){
			var div = "<div class='beforeHover'>" + commonAppend(obj,"percentage") + "</div>";
			overWorkReason.append(div);
		};
		window.setWorkDesc = function(obj,percentage){
			var idHead = dateToMillis(obj.theDay) + obj.taskCode;
			var inputApp = $(commonAppend(obj,"workDesc"));
			var inputHid = inputHidAppend(idHead,"pkWorkLog",obj.pkWorkLog);
			inputHid += inputHidAppend(idHead,"pkTask",obj.pkTask);
			inputHid += inputHidAppend(idHead,"isVerfied",obj.isVerfied);
			inputHid += inputHidAppend(idHead,"taskCode",obj.taskCode);
			percentage.append(inputApp);
			percentage.append(inputHid);
		};
		$("#myTable").createTable({
			dataHeader:dataHeader,//数组，每列的属性（必须）
			caption:"",//表格标题内容（非必须）
			root:"workLogList",//返回数据的key（必须）
			url:"<%=request.getContextPath()%>/admin/workLog/queryWorkLog.ajax",//请求数据地址（必须）
			drag:true,//表格是否可以拖动换行
			limit:500,//表格显示行数，默认为10
			pagination:false,//是否进行分页，默认true
			loadDataCallBack:resetTable,
			param:function(){
				var obj = new Object();
				obj.dateId = $("#dateId").val();
				return obj;
			},//请求参数，返回json对象（非必须）
			success:function(data){	
				
			},
			error:function(){
			}
		});
		$("#myTable").loadData();
	}
	function commonAppend(obj,name) {
		var input = "<input class='col-sm-12 form-control' ";
		input += (name == "workTime" && (obj.whatday == "星期六" || obj.whatday == "星期日")) ? " disabled='disabled' " : "";
		input += (name == "workTime" || name == "overWorkTime" || name == "percentage") ? " style='text-align:center' " : "";
		input += " name='" + name + "' ";
		input += (obj[name] == null || (name == "overWorkTime" && (obj[name] == "0")) || (name == "workTime" && (obj.whatday == "星期六" || obj.whatday == "星期日"))) ? " value=''>" : " value='" + obj[name] + "'>";
		input += (name == "percentage") ? '<span style="position:absolute;margin-top:5px;">%</span>' : "";
		return input;
	}
	function inputHidAppend(id,name,value) {
		return "<input type='hidden' id='" + id + name + "' name='" + name + "' value='" + value + "'>";
	}
	function addWorkLog(){
		var workLogList = new Array();
		var obj = new Object();
		var percentFlag = 0;
		for (var i = 0; i < dataList.length; i++) {
			if (writeFill(trs[i])) continue;
			var readonly = $(trs[i]).find("[name='percentage']").attr("readonly");
			var disabled = $(trs[i]).find("[name='percentage']").attr("disabled");
			if (readonly == "readonly" || disabled == "disabled" ) continue;
			if (dateToMillis(dataList[i].theDay) <= $("#currentDay").val()){
				obj = oneRowData(trs[i],false);
				if (obj == "" || obj == null) return;
			}
			if (obj.percentage == 100) percentFlag = 1;
			workLogList.push(obj);
		}
		if (textWarning(workLogList.length == 0,"提交的日志不能为空")) return;
		$("#subminWorkLogJson").val(JSON.stringify(workLogList));
		if ( percentFlag == 1) {
			$("#workLogHundredPrecent").modal('show');
			return;
		}
 		submitWorkLogPrecent();
	}
	function updateWorkLog(obj) {
		var prevtr = $(obj).parents("tr");
		if (textWarning(writeFill(prevtr),"没有要提交的数据")) return;
		var object = oneRowData(prevtr,true);
		if (object == "" || object == null) return;
		var workLogList = new Array();
		workLogList.push(object);
		$("#subminWorkLogJson").val(JSON.stringify(workLogList));
		if ( object.percentage == 100) {
			$("#workLogHundredPrecent").modal('show');
			return;
		}
		submitWorkLogPrecent();
	}
	function dataMatch(k,obj,boole) {
		if (textWarning(boole && writeFill(trs[k]),"数据为空无法保存")) return false;
		var workTimeReg = new RegExp("^[0-8]$");
		var overWorkTimeReg = new RegExp("^[0-4]$");
		var PercentageReg = new RegExp("^(?:0|[1-9][0-9]?|100)$");
		var kTheDay = dataList[k].theDay;
		var kTaskName = dataList[k].taskName;
		if (textWarning(obj.workTime == null,"【" + kTaskName + "】" + kTheDay + "日的正常工时不能为空")) return false;
		if (textWarning(!workTimeReg.test(obj.workTime),"【" + kTaskName + "】" + kTheDay + "日的正常工时只能为不大于8的非负整数")) return false;
		if (textWarning(!overWorkTimeReg.test(obj.overWorkTime),"【" + kTaskName + "】" + kTheDay + "日的加班工时只能为不大于4的非负整数")) return false;
		var dayworktime = obj.workTime;
		var dayoverWorkTime = obj.overWorkTime;
		for (var i = 0,len = dataList.length; i < len; i++) {
			if(i == k) continue;
			if (kTheDay == dataList[i].theDay) {
				if (writeFill(trs[i])) continue;
				var iworktime = boole ? dataList[i].workTime : $(trs[i]).find("[name='workTime']").val();
				iworktime = (iworktime == null || iworktime == "") ? 0 : iworktime;
				var ioverWorkTime = boole ? dataList[i].overWorkTime : $(trs[i]).find("[name='overWorkTime']").val();
				ioverWorkTime = (ioverWorkTime == null || ioverWorkTime == "") ? 0 : ioverWorkTime;
				dayworktime =parseInt(dayworktime) + parseInt(iworktime);
				dayoverWorkTime = parseInt(dayoverWorkTime) + parseInt(ioverWorkTime);
			}
			if (textWarning(dayworktime > 8,kTheDay + "日的正常工时总和不能大于8小时")) return false;
			if (textWarning(dayoverWorkTime > 4,kTheDay + "日的加班工时总和不能大于4小时")) return false;
		}
	    if(obj.overWorkTime != 0){
	    	if (textWarning(obj.overWorkReason.length > 65,"加班缘由长度不能超过65个字符")) return false;
	    	if (textWarning(obj.overWorkReason == null || obj.overWorkReason == "","有加班时长时加班缘由不能为空")) return false;
	    }
		if (textWarning(!PercentageReg.test(obj.percentage),"任务百分比只能是0到100正整数")) return false;
		if (textWarning(obj.workDesc == "" || obj.workDesc == null,"请输入任务描述")) return false;
		if (textWarning(obj.workDesc.length > 666,"验证工作描述长度不能超过666位 ")) return false;
		return true;
	}
	function oneRowData(currentTr,boole) {//boole = true 保存按钮 ；boole = false 提交按钮
		var obj = new Object();
		var i = $(currentTr).prevAll().length;
		obj.workTime = (dataList[i].whatday == "星期六" || dataList[i].whatday == "星期日") ? 0 : $(currentTr).find("[name='workTime']").val();
		var overWorkTime = $(currentTr).find("[name='overWorkTime']").val();
		obj.overWorkTime = overWorkTime == "" || overWorkTime == null ? "0" : overWorkTime;
		obj.overWorkReason = $(currentTr).find("[name='overWorkReason']").val();
		obj.percentage = $(currentTr).find("[name='percentage']").val();
		obj.workDesc = $(currentTr).find("[name='workDesc']").val();
		obj.taskCode = $(currentTr).find("[name='taskCode']").val();
		obj.pkWorkLog = dataList[i].pkWorkLog;
		obj.pkTask = dataList[i].pkTask;
		obj.logDate = dataList[i].theDay;
		obj.isVerfied = "0";
		if (!dataMatch(i,obj,boole)) return;
		if (!compareDayPre(i,obj,boole)) return;
		if (!compareWeekPre(i,obj,boole)) return;
		return obj;
	}
	function compareDayPre(k,obj,boole) {
		var percentage = obj.percentage;
		for (var i = 0,len = dataList.length; i < len; i++) {
			if (dataList[k].taskCode == dataList[i].taskCode) {
				if (writeFill(trs[i]) || i == k) continue;
				var otherPresent = boole ? dataList[i].percentage : $(trs[i]).find("[name='percentage']").val();
				var warning = boole ? "日的实际任务" : "日的任务";
				if (i < k && parseInt(percentage) < parseInt(otherPresent)) {
					window.top.warning("【" + dataList[k].taskName + "】" + dataList[k].theDay + "日的任务百分比不能小于" + dataList[i].theDay + warning + "百分比【" + otherPresent + "%】");
					return false;
				}else if(i > k && parseInt(percentage) > parseInt(otherPresent)){
					window.top.warning("【" + dataList[k].taskName + "】" + dataList[k].theDay + "日的任务百分比不能大于" + dataList[i].theDay + warning + "百分比【" + otherPresent + "%】");
					return false;
				}	
			}
		}
		return true;
	}
	function compareWeekPre(k,obj,boole) {
		var percentage = obj.percentage;
		var minPercentage = workInfo[obj.taskCode + "minPercentage"];
		if (minPercentage != null && parseInt(percentage) > parseInt(minPercentage)) {
			window.top.warning("此周【" + dataList[k].taskName + "】" + obj.logDate + "日的任务百分比不能大于" + workInfo[obj.taskCode + "minLogDate"] + "日的任务百分比【" + minPercentage + "%】");
			return false;
		}
		var maxPercentage = workInfo[obj.taskCode + "maxPercentage"];
		if (maxPercentage != null && parseInt(percentage) < parseInt(maxPercentage)) {
			var text = $("#dateId").val() < 1 ? "此周【" : "此月【";
			window.top.warning(text + dataList[k].taskName + "】" + obj.logDate + "日的任务百分比不能大于" + workInfo[obj.taskCode + "maxLogDate"] + "日的任务百分比【" + maxPercentage + "%】");
			return false;
		}
		return true;
	}
	function resetTable(){
		dataList = $("#myTable").getDataProvider();
		trs = $("#myTable").find("tbody").find("tr");
		if ($("#dateId").val() == "1") {
			var url="<%=request.getContextPath()%>/admin/workLog/selectMonthWorkInfo.ajax";
		}else{
			var url="<%=request.getContextPath()%>/admin/workLog/selectWeekWorkInfo.ajax";
		}
		$.ajax({
			type:"post",
			url:url, 
			data:{dateId:$("#dateId").val()},
 			success:function(data){
 				workInfo = data.RSP_BODY.Data.workInfo;
 				$("#selectWorkInfo").empty();
 				for(var i = 0 ; i < dataList.length ; i++){
 					if (dateToMillis(dataList[i].theDay) < $("#monday").val() && dataList[i].percentage != null && dataList[i].percentage != "") {
 						$(trs[i]).find("input").attr("readonly",true);
 						$(trs[i]).find("button").attr("disabled",true);
 					}else if(dateToMillis(dataList[i].theDay) > $("#currentDay").val()){
 						$(trs[i]).find("input").attr("disabled",true);
 						$(trs[i]).find("button").attr("disabled",true);
 					}
 					var percentage = workInfo[dataList[i].taskCode + "percentage"];
 					var status = workInfo[dataList[i].taskCode + "status"];
 					if (percentage == 100 || status == "5" || status == "2") {
 						$(trs[i]).find("input").attr("readonly",true);
 						$(trs[i]).find("button").attr("disabled",true);
 					}
 				}
			}
		});
		$("#inputModification").val("0");
		btnDisplay();
		doubleClickDiv();
		divBubbing();
	}
	function updateDateId(dateId){
		var id = $("#dateId").val();
		var dId = parseInt(dateId) + parseInt(id);
		if(textWarning(dId > 0,"无法查看未来一周的日志")) return;
		$("#dateId").val(dId);
		dateIdChange();
	}
	function currentDateID(dateId){
		$("#dateId").val(parseInt(dateId));
		dateIdChange();
		var boole = dateId == "0" ? false : true;
		$("#lastWeek").attr("disabled",boole);
		$("#nextWeek").attr("disabled",boole);
	}
	function submitWorkLogPrecent() {
		$("#workLogHundredPrecent").modal('hide');
		var workLogList = $("#subminWorkLogJson").val();
		$.ajax({
			type:"post",
			url:"<%=request.getContextPath()%>/admin/workLog/workLogAdd.ajax", 
 			data:{workLogList:workLogList},
 			success:function(){
 				window.top.warning("提交成功");
 				$("#myTable").loadData();
			}
		});
	}
	function exportWorkLog(){
		var workLog=$("#myTable").getSelectItems();
		if(workLog.length == 0){
			window.top.warning("请选择一条导出数据");
			return;
		}
		var pkWorkLogList = [];
		$.each(workLog,function(i,val){
			var obj={};
			obj = val.pkWorkLog;
			pkWorkLogList.push(obj);
		});
		var fileName = "工作日志详情";
		var fileType = "xlsx";
		$("#workLogForm").attr("action","<%=request.getContextPath()%>/admin/workLog/exportWorkLog.download?pkWorkLogList="+pkWorkLogList+"&fileType="+fileType+"&fileName="+fileName);
		$("#workLogForm").submit();
	}
	function divBubbing() {
		//任务描述
		var inputs=$("#myTable").find("tbody").find("[name='workDesc']");
		for (var i = 0,len = inputs.length; i < len; i++) {
			$(inputs[i]).bind("mouseenter",function(){
				var workLogDescVal = $(this).val();
				if (workLogDescVal.length > 0) {
					var div = "<div class = 'divbubbing' >"+workLogDescVal+"</div>";
					$("section").append(div);
					var divtop = parseInt($(this).offset().top) - 5 - parseInt($(".divbubbing").outerHeight()); 
					$(".divbubbing").offset({top:divtop,left:($(this).offset().left + 1)});
				}
			});
			$(inputs[i]).bind("mouseleave",function(){
				$(".divbubbing").remove();
			});
			$(inputs[i]).bind("click",function(){
				$("#workLogDescIndex").val($(this).parents("tr").prevAll().length);
				$("#workLogDescTxta").val($(this).val());
				if ($(this).attr("readonly") != "readonly") {
					$("#workLogDescribeModal").modal('show');
				}
			});
		}
		//加班缘由
		var inputss=$("#myTable").find("tbody").find("[name='overWorkReason']");
		for (var i = 0,len = inputss.length; i < len; i++) {
			$(inputss[i]).bind("mouseenter",function(){
				var overWorkReason = $(this).val();
				if (overWorkReason.length > 0) {
					var div = "<div class = 'divbubbing' >"+overWorkReason+"</div>";
					$("section").append(div);
					var divtop = parseInt($(this).offset().top) - 5 - parseInt($(".divbubbing").outerHeight()); 
					$(".divbubbing").offset({top:divtop,left:($(this).offset().left + 1)});
				}
			});
			$(inputss[i]).bind("mouseleave",function(){
				$(".divbubbing").remove();
			});
		}
	}
	function textToWorkLogDesc() {
		var inputs=$("#myTable").find("tbody").find("[name='workDesc']");
		var index = $("#workLogDescIndex").val();
		$(inputs[index]).val($("#workLogDescTxta").val());
		$("#workLogDescribeModal").modal('hide');
	}
	$(function () {
		$("#workLogDescribeModal").on('shown.bs.modal',function(){
			$("#workLogDescTxta")[0].focus();
		});
	})
	function dateIdChange() {
		btnDisplayNone();
		doubleClickDiv();
		$("#myTable").loadData();
	}
	function reset(){
		$("#myTable").loadData();
	}
	function modification(btn) {
		var taskCode = $(btn).find("[name='taskCode']").val();
		if (textWarning(workInfo[taskCode + "percentage"] == 100,"该任务已完成，无法修改")) return;
		if (textWarning(workInfo[taskCode + "status"] == "5","该任务已强制完成，无法修改")) return;
		var readonly = $(btn).find("[name='percentage']").attr("readonly");
		if (!readonly) return;
		$(btn).find("input").attr("readonly",false);
		$(btn).find("button").attr("disabled",false);
	}
	function btnDisplayNone() {
		$("#submitBtn").css("display","none");
		$("#resetBtn").css("display","none");
	}
	function btnDisplay() {
		$("#submitBtn").css("display","inline");
		$("#resetBtn").css("display","inline");
	}
	function doubleClickDiv() {
		$(".dataGrid_tbody").find("tr").each(function(){
			$(this).bind("dblclick",function(){
				modification(this);
			})
		})
	}
	//填写数据是否为空
	function writeFill(trsI) {
		var workTime = $(trsI).find("[name='workTime']").val();
		var percentage = $(trsI).find("[name='percentage']").val();
		var workDesc = $(trsI).find("[name='workDesc']").val();
		var workTimeBoolean = (workTime == "" || workTime == null || workTime == "0") ? true : false;
		var perBoolean = (percentage == "" || percentage == null) ? true : false;
		var workDescBoolean = (workDesc == "" || workDesc == null) ? true : false;
		return (workTimeBoolean && perBoolean && workDescBoolean);
	}
	function textWarning(boole,warn) {
		if (boole) {
			window.top.warning(warn);
			return true;
		}
		return false;
	}
	function dateToMillis(date) {
		return new Date(date).getTime();
	}
</script>
<style type="text/css">
	.divcss{
		height: 372px;
		overflow-y:auto;
	}
	#myBootDataGridmyTable td{
 		vertical-align: middle;
 		white-space: inherit;
	}
	.content-wrapper section{
		padding-bottom: 0px;
	}
	#submitBtn,#resetBtn{
		display: none;
	}
	.divbubbing{
		position: absolute;
		color:#FFF;
		background-color: rgb(98, 158, 199);
		border-radius: 5px;
		margin: 6px 12px;
		padding: 6px;
		width: 162px;
	}
	.worklogdrsc{
		margin: 20px;
		padding: 12px;
	}
</style>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/workLog/workManage.do"/>
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
            	<h3 class="box-title">日志填写</h3>
            	<div id="selectWorkInfo"></div>
            	<div id="selectNonCurrent"></div>
            	<input id="monday" value="${monday}" hidden="hidden">
	            <input id="currentDay" value="${currentDay}" hidden="hidden">
	            <input id="dateId" value="0" hidden="hidden">
	            <input id="inputModification" value="0" hidden="hidden">
	            <input id="subminWorkLogJson" value="0" hidden="hidden">
	            <div class="box-tools pull-right">
            	</div>
            </div>
            <div class="box box-info">
            </div>
            <div class="box-body">
	            <div class="row">
		            <form action="" id="workLogForm" class="form-horizontal" method="post">
		            	<input id="today" hidden>
					</form>
				</div>
				<div class="row">
	              	<div style="padding-left: 16px">
						<button type="button" class="btn btn-success btn-sm" onclick="exportWorkLog()">
						  <span class="glyphicon glyphicon-export" aria-hidden="true"><span class="my-operation">导出</span></span>
						</button>
						<button type="button" class="btn btn-success btn-sm" onclick="updateDateId('-7')" id="lastWeek">
						  <span class="glyphicon glyphicon-export" aria-hidden="true"><span class="my-operation">上一周</span></span>
						</button>
						<button type="button" class="btn btn-success btn-sm" onclick="updateDateId('7')" id="nextWeek">
						  <span class="glyphicon glyphicon-export" aria-hidden="true"><span class="my-operation">下一周</span></span>
						</button>
						<button type="button" class="btn btn-success btn-sm" onclick="currentDateID('0')">
						  <span class="glyphicon glyphicon-export" aria-hidden="true"><span class="my-operation">本周</span></span>
						</button>
						<button type="button" class="btn btn-success btn-sm" onclick="currentDateID('1')">
						  <span class="glyphicon glyphicon-export" aria-hidden="true"><span class="my-operation">本月</span></span>
						</button> 
	              	</div>
                </div>
	             <div class="row">
	            	<div class="col-md-12">
	            		<div id="myTable"></div>
	            	</div>
	            	<div align="center">
						<button type="button" class="btn btn-success btn-sm" onclick="addWorkLog()" id="submitBtn">
						  <span class="glyphicon glyphicon-export" aria-hidden="true"><span class="my-operation">提交</span></span>
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="reset()" id="resetBtn">
						  <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"><span class="my-operation">重置</span></span>
						</button>
	              	</div>
	            </div>
            </div>
         </div>
        </div>
      </div>
      <div class="modal fade" id="workLogDescribeModal" tabindex="-1" role="dialog" 
		data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content worklogdrsc">
	            <div style="margin-bottom: 12px" align="center">任务描述</div>
					<textarea class="form-control"  rows="4" id="workLogDescTxta"></textarea>
					<input type="hidden" id="workLogDescIndex">
	            <div class="modal-footer" style="padding: 12px 0px 0px 12px;">
	            	<button type="button" class="btn btn-primary " style="height: 28px;line-height: 10px" onclick="textToWorkLogDesc()">确认</button>
	            	<button type="button" class="btn btn-default " style="height: 28px;line-height: 10px" data-dismiss="modal">取消</button>
	            </div>
	        </div>
	    </div>
	</div>
	<div class="modal fade" id="workLogHundredPrecent" tabindex="-1" role="dialog" 
		data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
	 <div class="warning-dialog" style="width: 100%;height:0%;">
		<div class="modal-content warning-content" >
			<div class="warning-header" style="text-align: center;">
				<p style="align:center">提示信息</p>
			</div>
			<div class="warning-body" style="overflow:auto">
					<p id="warning" style="text-align:center;">任务百分比为100%时，提交之后此任务将不能修改</p>
			</div>
			<div class="modal-footer" style="padding: 10px;">
	            	<button type="button" class="btn btn-primary " style="height: 28px;line-height: 10px" onclick="submitWorkLogPrecent()">确认</button>
	            	<button type="button" class="btn btn-default " style="height: 28px;line-height: 10px" data-dismiss="modal">取消</button>
	        </div>
	         <div class="row"></div>
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