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
	
	$("#taskForm").bootstrapValidator({
    	message: 'This value is not valid',
    	fields: {
    		taskName: {
                validators: {
                    notEmpty: {
                        message: '任务名称不能为空'
                    },
                    stringLength: {
                           max: 16,
                           message: '任务名称长度不能超过16位'
                       }
                }
            },

            taskCode: {
                validators: {
                    notEmpty: {
                        message: '任务编码不能为空'
                    },
                    stringLength: {
                           max: 20,
                           message: '任务编码不能大于20位'
                       },
                       regexp: {
                           regexp: /^[a-zA-Z0-9_]{0,}$/,
                           message: '项目编码只能是字母，数字和下划线'
                       }
                }
            },


            pkProj: {
                validators: {
                    notEmpty: {
                        message: '所属项目不能为空'
                    }
                }
            },
            taskType: {
                validators: {
                    notEmpty: {
                        message: '任务类型不能为空'
                    }
               }
            },
           
            workload: {
                validators: {
                	notEmpty: {
                        message: '工作量不能为空'
                    },
                    regexp: {
                 	   regexp: /^([1-9][0-9]{0,3}|0)([.][0-9]{1})?$/,
                        message: '工作量估算只有一位小数'
                    },
                    callback:{
	                   	 message: '工作量不能大于最大工作量',
	                   	 callback:function(value, validator) {
	                   		var workload = $("#workload").val();
	                		var maxWorkLoad = $("#maxWorkLoadInput").val();
	                		if (parseInt(workload) > parseInt(maxWorkLoad)) {
	                			return false;
	                		}
	                		return true;
	                   	 }
	                }
                }
            },
            expStartDate: {
                validators: {
                    notEmpty: {
                        message: '任务计划开始日期不能为空'
                    },
                    callback:{
                   	 message: '任务计划开始日期需小于任务计划结束日期！！',
                   	 callback:function(value, validator) {
	                    	var startTime = $("#expStartDate").val();
	                    	var endTime = $("#expEndDate").val();
	                    	return ('' != endTime && '' != startTime && endTime < startTime) ? false : true;
                   	 }
                   }
                }
            },
            expEndDate: {
                validators: {
                    notEmpty: {
                        message: '任务计划结束日期不能为空'
                    },
                    callback:{
                   	 message: '任务计划开始日期需小于任务计划结束日期！！',
                   	 callback:function(value, validator) {
	                    	var startTime = $("#expStartDate").val();
	                    	var endTime = $("#expEndDate").val();
	                    	return ('' != endTime && '' != startTime && endTime < startTime) ? false : true;
                   	 }
                   }
                }
            }
        
    	}
	})
}) 

function add() {
	$('#taskForm').data('bootstrapValidator').resetForm();
	$('#taskForm').data('bootstrapValidator').validate();  
    if(!$('#taskForm').data('bootstrapValidator').isValid()){  
        return ;  
    }
    if (!startDateCompare()) return;
	$("#btnSave").attr("disabled",true);
	$.ajax({
		type:"post",
		url:"<%=request.getContextPath()%>/admin/task/taskAdd.ajax",
		data:$('#taskForm').serialize(),
		success:function(data){
			$("#btnSave").attr("disabled",false);
			window.location.href="<%=request.getContextPath()%>/admin/task/taskManage.do";
		},error:function(data){
			$("#btnSave").attr("disabled",false);
		}
	});
}
function back(){
	window.history.go(-1);
}
function maxWorkLoadChange() {
	var endDate = $("#taskForm [name='expEndDate']").val();
	var startDate = $("#taskForm [name='expStartDate']").val();
	startDateCompare();
	if (Boolean(endDate) && Boolean(startDate)){
		if (dataDiff(startDate,endDate) < 0) return;
		var maxWorkLoad = parseInt(dataDiff(startDate,endDate)*3)+3;
		$("#maxWorkLoad").text("计划的自然天数*3即【"+maxWorkLoad+"】");
		$("#maxWorkLoadInput").val(maxWorkLoad);
	}
}
function startDateCompare() {
	var startDateSelect = $("#pkProj").find("option:selected").attr("startDate");
	if (startDateSelect == "" || startDateSelect == null ) return true;
	var date = new Date(dateFormat(startDateSelect,false));
	var startDate = $("#taskForm [name='expStartDate']").val();
	var stDate = new Date(dateFormat(startDate,false));
	var projectStartDateFormat = dateFormat(date,true);
	if (date.getTime() > stDate.getTime()) {
		$("#projectStartThenPlanStart").text("计划开始日期不能小于项目开始日期【"+projectStartDateFormat+"】");
		$("#expStartDate").css("border-color","#dd4b39");
		return false;
	}
	$("#projectStartThenPlanStart").text("");
	$("#expStartDate").css("border-color","#d2d6de");
	return true;
}
function dataDiff(sDate,eDate) {
	var sDateNew = new Date(dateFormat(sDate,false));
	var eDateNew = new Date(dateFormat(eDate,false));
	return parseInt((eDateNew.getTime() - sDateNew.getTime())/(1000*60*60*24)); 
}
function dateFormat(date,boole) {
	if(("" + date).split("-") > 1) date = date.replace(new RegExp(/-/gm) ,"/");
	var time = new Date(date);
	var year = time.getFullYear();//年
	var month = time.getMonth()+1; //月   
	var day = time.getDate();//日
	year += (year < 2000) ? 1900 : 0;
	if (month < 10) month = "0" + month;
	if (day < 10) day = "0" + day;
	var flag = boole ? "-" : "/";
	return year + flag + month + flag + day;
}
$(function(){
	maxWorkLoadChange();
})
</script>
<link rel="stylesheet" type="text/css" href="css/rcms.css">
</head>

<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/task/taskManage.do"/>
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
              <h3 class="box-title">新增任务</h3>
              
              <div class="box-tools pull-right">
                
              </div>
            </div>
            <div class="box box-info">
            </div>
            <div class="box-body">
	            <div class="row">
		            <form action="" id="taskForm" class="form-horizontal">
			            <div class="col-sm-11" >
							</div>
							<div class="form-group">
					             <label class="col-sm-3 control-label" for="taskCode">任务编号&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="taskCode" name="taskCode" value="${taskCodeSeq }" readonly="readonly"/>
					             </div>
					             <label class="col-sm-2 control-label" for="taskName">任务名称<span id="star">&nbsp;&nbsp;*</span>&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="taskName" name="taskName"  />
					             </div>
					             
							</div>
							<div class="form-group" >
								 <label class="col-sm-3 control-label" for="pkProj">所属项目<span id="star">&nbsp;&nbsp;*</span>&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	 <select class="form-control" name="pkProj" id="pkProj">
					             	 	<option value="">请选择所属项目</option>
	                                 	<c:forEach var="project" items="${projectList}">
	                                    	<option value="${project.pkProj}" startDate="${project.expStartDate}">${project.projName}</option>
	                                    </c:forEach>
	                                 </select>
					             </div>
					             <label class="col-sm-2 control-label" for="taskType">任务类型&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	 <select class="form-control" name="taskType" id="taskType">
	                                 	<option value="2">计划内</option>
	                                 	<option value="1">计划外</option>
	                                 </select>
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-3 control-label" for="expStartDate">计划开始日期<span id="star">&nbsp;&nbsp;*</span>&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expStartDate" name="expStartDate" onblur="maxWorkLoadChange()"
					             	onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});"/>
					             	<span id="projectStartThenPlanStart" style="color: #dd4b39;font-size: 12px"></span>
					             </div>
								
					             <label class="col-sm-2 control-label" for="expEndDate">计划结束日期<span id="star">&nbsp;&nbsp;*</span>&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expEndDate" name="expEndDate"  onblur="maxWorkLoadChange()"
					             	onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" />
					             </div>
							</div>
							
							
							<div class="form-group" >
					             <label class="col-sm-3 control-label" for="workload">工作量（天）<span id="star">&nbsp;&nbsp;*</span>&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="workload" name="workload" />
					             </div>
					             <label class="col-sm-2 control-label" for="workload">最大工作量&nbsp;&nbsp;=</label>
					             <label class="col-sm-3 " id="maxWorkLoad" style="line-height: 35px" for="workload">计划的自然天数*3</label>
					             <input type="hidden" id="maxWorkLoadInput" >
							</div>
						</form>
					</div>
				</div>
				<div class="row">
	              		<div class="col-md-12" align="center">
	              		<button type="button" class="btn btn-success btn-sm" onclick="add()" id="btnSave">保存
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="back()">返回
						</button>
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
<%@include file="../../common/deptModel.jsp" %>
</body>
</html>