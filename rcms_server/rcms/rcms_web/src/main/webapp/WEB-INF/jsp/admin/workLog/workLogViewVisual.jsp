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
  <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/AdminLTE/plugins/select2/select2.min.css">
  <script type="text/javascript" src="<%=request.getContextPath()%>/AdminLTE/plugins/select2/select2.min.js"></script>
<script type="text/javascript">
	var workLogViewList = null;
	var currentDate = null;
	$(function() {
		WorkLogViewVisualByWeek();
	})
	function btnControl() {
		var dates = $(".dateInYear");
		var sDate = parseInt($(dates[0]).val());
		var eDate = parseInt($(dates[6]).val());
		var sDateDay = new Date(sDate);
		var minMonth = sDateDay.getMonth() + 1;
		var minYear = sDateDay.getFullYear();
		minYear += (minYear < 2000) ? 1900 : 0;
		var eDateDay = new Date(eDate)
		var maxMonth = eDateDay.getMonth() + 1;
		var maxYear = eDateDay.getFullYear();
		maxYear += (maxYear < 2000) ? 1900 : 0;
		var year = minYear == maxYear ? ("" + minYear) : (minYear + "-" + "");
		var month = minMonth == maxMonth ? ("" + minMonth) : (minMonth + "-" + maxMonth);
		$("#workLogTitle").text(year + "年" + month + "月");
		nextBtnControl();
	}
	function WorkLogViewVisualByWeek(){
		var dateId = ($("#dateId").val()=="" || $("#dateId").val() == null) ? 0 : $("#dateId").val();
		$.ajax({
			type:"post",
			url:"<%=request.getContextPath()%>/admin/workLog/WorkLogViewVisualByWeek.ajax", 
			data:{"pkProj":'${pkProj}',"userId":'${userId}',"dateId":dateId},
 			success:function(data){
 				workLogViewList = data.RSP_BODY.Data.workLogViewList;
 				currentDate = data.RSP_BODY.Data.currentTime;
 				weekHeadInit(workLogViewList);
			}
		});
	}
	function weekHeadInit(workLogViewList) {
		var dateId = $("#dateId").val();
		dateId = (dateId == "" || dateId == null) ? 0 : dateId;
		var workLog = workLogViewList;
		var nowDate = new Date(dateFromat(currentDate));
		var date = new Date(nowDate.getTime() + (dateId * 1000 * 60 * 60 * 24));
		var week = ["一","二","三","四","五","六","日"]
		var weekth = date.getDay();
		weekth = weekth != 0 ? (weekth - 1) : 6; 
		var monday = new Date(date.getTime() - (weekth * 1000 * 60 * 60 * 24));
		var div = "<table border='0' cellspacing='0' cellpadding='0'><tr>";
		for (var i = 0, len = week.length; i < len; i++) {
			var weekDate = new Date(monday.getTime() + (i* 1000 * 60 * 60 * 24));
			var wDate = weekDate.getDate();
			div += "<td class='headTd'>周"+week[i]+"("+wDate+")";
			div +="<input type='hidden' class='dateInYear' value='"+weekDate.getTime()+"' >"+"</td>"
		}
		div += "</tr><tr>";
		for (var i = 0; i < week.length; i++) {
			var divShowDate = new Date(date.getTime() - ((weekth - i) * 1000 * 60 * 60 * 24))
			var showDate = divShowDate.getTime();
			div += "<td class='bodyTd' id='back"+showDate+"'>";
			div += "<div class='bodyDataShow' id='data"+showDate+"'></div>";
			div += "</div></td>"
		}
		div += "</tr></table>";
		$("#workLogShow").html(div);
		workLogDataShow(workLogViewList);
	}
	function dateFromat(date) {
		if ((""+date).split("-").length>1) return date.replace(new RegExp(/-/gm) ,"/");
		return date;
	}
	function workLogDataShow(workLogViewList) {
		var dates = $(".dateInYear");
		var workLog = workLogViewList;
		for (var i = 0; i < 7; i++) {
			var odd = 0;
			var table = "";
			var dateFlag = parseInt($(dates[i]).val());
			for (var j = 0,len = workLog.length; j < len; j++) {
				var IDate = new Date(dateFromat(workLog[j].logDate));
				if (dateFlag == IDate.getTime()) {
					var back = (odd % 2 == 0) ? "odd" : "even";
					table = odd == 0 ? "<table style = 'width:150px;'>" : table;
					table += "<tr flag='onSelected' index='"+j+"' class='"+back+"'><td class='divTd'>";
					table += workLog[j].taskName + "(" + workLog[j].percentage + "%)</td></tr>";
					$("#back" + dateFlag).css("background-color","white");
					odd ++;
				}
			}
			table +=  odd != 0 ? "":"</table>";
			$("#data" + dateFlag).html(table);
		}
		eachbind();
		btnControl();
	}
	function eachbind() {
		$("div [flag='onSelected']").each(function(){
			$(this).bind("mouseenter",function(){
				var echoText = $(this).html();
				var echoSplit = echoText.split("<br>");
				$(".divbubbing").show();
				var k = parseInt($(this).attr("index"));
				var twoArray = [["projName","项目名称"],["taskName","任务名称"],["workTime","正常工时"],["overWorkTime","加班工时"],["overWorkReason","加班原因"],["percentage","任务百分比"],["logDate","日志日期"],["workDesc","任务描述"]];
				var text = dataShowDivbubbing(k,twoArray);
				$(".divbubbing").html(text);
				var width = parseInt($(".divbubbing").outerWidth());
				var height = parseInt($(".divbubbing").outerHeight());
				var divtop = parseInt($(this).offset().top) - parseInt($(".divbubbing").outerHeight()) + 5;
				var width = parseInt($(".divbubbing").outerWidth())/2;
				var divleft = parseInt($(this).offset().left) - width + (parseInt($(this).outerWidth())/2);
				var divParent = $(".divbubbing").parent().closest("section");
				var leftPar = parseInt($(divParent).offset().left);
				var widthPar = parseInt($(divParent).outerWidth());
				divleft = (divleft < leftPar) ? (leftPar + 15) : divleft;
				divleft = (divleft + width*2 > leftPar + widthPar) ? (leftPar + widthPar -15 - width*2) : divleft;
				$(".divbubbing").offset({top:divtop,left:divleft});
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
	function dataShowDivbubbing(k,twoArray) {
		var elementArray = twoArray;
		var workLog = workLogViewList;
		var div = "<div>";
		for (var i = 0; i < elementArray.length; i++) {
			var element = elementArray[i][0];
			var elementVal = (workLog[k][element]=="" || workLog[k][element]==null)? "" : workLog[k][element];
			div += "<div>"+ elementArray[i][1] + ":" + elementVal + "</div>";
		}
		div += "</div>";
		return div;
	}
	function lastWeekLog() {
		$("#dateId").val(parseInt($("#dateId").val()) - 7);
		WorkLogViewVisualByWeek();
	}
	function nextWeekLog() {
		$("#dateId").val(parseInt($("#dateId").val()) + 7);
		WorkLogViewVisualByWeek();
	}
	function nextBtnControl() {
		if($("#dateId").val() == "0"){
			$("#nextWeekLog").attr("disabled",true);
		}else{
			$("#nextWeekLog").attr("disabled",false);
		}
	}
	function back(){
		window.history.go(-1);
	}
</script>
<style type="text/css">
	.headTd,.bodyTd,.bodyDataShow,.odd,.even{
		width: 150px;
	}
	.headTd{
		height: 23px;
		text-align: center;
		border: 1px solid rgb(210, 214, 222);
		background-color: white;
	}
	.bodyTd{
		border: 1px solid rgb(210, 214, 222);
		background-color: #ffcccc;
		vertical-align:top;
	}
	.bodyDataShow{
		text-align: left;
		min-height: 120px;
	}
	.divTd{
		padding: 4px 8px;
	}
	.odd,.even{
		height: 55px;
		padding: 5px;
		background-color: rgb(249, 249, 249);
	}
	.odd{
		background-color:rgb(226, 230, 235);
	}
	.divbubbing{
		position: absolute;
		color:#FFF;
		background-color: rgb(98, 158, 199);
		border-radius: 5px;
		margin:4px 8px;
		padding: 10px;
		max-height: 160px;
		width:300px;
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
            </div>
            <div class="box box-info"></div>
            <div class="box-body">
               <div class="row">
               	   <div class="col-md-12" align="left">
	              		<button type="button" class="btn btn-primary btn-sm" onclick="lastWeekLog()" id="lastWeekLog">
						  <span class="glyphicon glyphicon-export" aria-hidden="true"><span class="my-operation">上一周</span></span>
						</button>
						<button type="button" class="btn btn-primary btn-sm" onclick="nextWeekLog()" id="nextWeekLog">
						  <span class="glyphicon glyphicon-link" aria-hidden="true"><span class="my-operation">下一周</span></span>
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="back()">返回</button>
	               </div>
	               <div class="col-md-12" align="center">
	            		<h3 id="workLogTitle"></h3>
	           	   </div>
	           	   <div class="col-md-12" align="center">
	            		<div id="workLogShow"></div>
	           	   </div>
               </div>
         </div>
        </div>
       
      </div>
      <div class="divbubbing"></div>
      <div>
      	<form action="WorkLogViewVisualFrom" method="post">
      		<input type="hidden" id="pkProj" name="pkProj" value="${pkProj}">
      		<input type="hidden" id="userId" name="userId" value="${userId}">
      		<input type="hidden" id="dateId" name="dateId" value="0">
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