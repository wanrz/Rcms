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
	$("#projectForm input").attr("disabled",true);
	var count = '${count}';
	if(count == 1){
		$("div[id*='old_input']").hide();
	}else{
		$("#new_input input").each(function(i,val){
			var oldId="#old_"+$(this).attr("id");
			if($(this).val()!=$(oldId).val()){
				var lable = "#lable_"+$(this).attr("id");
				$(lable).css("color","red");
			}
		});
	}
});

function back(){
	window.history.go(-1);
}
$(document).ready(function(){
	//限制字符个数
	$("#dirName").each(function(){
	var maxwidth=9;
		if($(this).val().length>maxwidth){		
			$(this).val($(this).val().substring(0,maxwidth));
			$(this).val($(this).val()+"...");
		}
	});
});
$(document).ready(function(){
	//限制字符个数
	$("#old_dirName").each(function(){
	var maxwidth=8;
		if($(this).val().length>maxwidth){		
			$(this).val($(this).val().substring(0,maxwidth));
			$(this).val($(this).val()+"...");
		}
	});
});
</script>
</head>
<javascript></javascript>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/change/project.do"/>
<c:set var="m_active_code" value="ToolBarCProjManage"/>
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
    
    <div class="row">
        <div class="col-md-12">
            <div class="box-header with-border">
              <h3 class="box-title">变更对比</h3>
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
		            <form action="" id="projectForm" class="form-horizontal">
			            <div class="col-sm-11" >
							</div>
							<div class="form-group" id="new_input">
					             <label class="col-sm-2 control-label" for="projName" id="lable_projName">项目名称&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projName" name="projName" value="${project.projName }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="projShName" id="lable_projShName">英文名称&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projShName" name="projShName"  value="${project.projShName }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="projCode" id="lable_projCode">项目编码&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projCode" name="projCode"  value="${project.projCode }"/>
					             </div>
							</div>
							<div class="form-group" id="old_input">
					             <label class="col-sm-2 control-label" for="old_projName">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_projName" name="old_projName" value="${oldProject.projName }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_projShName">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_projShName" name="old_projShName"  value="${oldProject.projShName }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_projCode">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_projCode" name="old_projCode"  value="${oldProject.projCode }"/>
					             </div>
							</div>
							
							<div class="form-group" id="new_input">
								 <label class="col-sm-2 control-label" for="applyDate" id="lable_applyDate">申请日期&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="applyDate" name="applyDate" value="<fmt:formatDate value='${project.applyDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="dirName" id="lable_dirName">申请部门&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control overflowH" title="${project.dirName}" id="dirName" name="dirName" value="${project.dirName }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="budgetSource" id="lable_budgetSource">预算出处&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="budgetSource" name="budgetSource"  value="${project.budgetSource }"/>
					             </div>
							</div>
							<div class="form-group" id="old_input">
								 <label class="col-sm-2 control-label" for="old_applyDate">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_applyDate" name="old_applyDate" value="<fmt:formatDate value='${oldProject.applyDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="old_dirName">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control overflowH" title="${oldProject.dirName}" id="old_dirName" name="old_dirName" value="${oldProject.dirName }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_budgetSource">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_budgetSource" name="old_budgetSource"  value="${oldProject.budgetSource }"/>
					             </div>
							</div>
							
							<div class="form-group" id="new_input">
								 <label class="col-sm-2 control-label" for="projType" id="lable_projType">项目类型&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projType" name="projType" value="${project.projType}"/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="projLevel" id="lable_projLevel">项目级别&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projLevel" name="projLevel" value="${project.levelName}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="status" id="lable_status">项目状态&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="status" name="status" value="${project.status }"/>
					             </div>
							</div>
							<div class="form-group" id="old_input">
								 <label class="col-sm-2 control-label" for="old_projType">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_projType" name="old_projType" value="${oldProject.projType}"/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="old_projLevel">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_projLevel" name="old_projLevel" value="${oldProject.levelName }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_status">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_status" name="old_status" value="${oldProject.status }"/>
					             </div>
							</div>
							
							<div class="form-group" id="new_input">
								 <label class="col-sm-2 control-label" for="remark" id="lable_remark">项目规模(人数)&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="remark" name="remark" value="${project.remark}"/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="urgentLevel" id="lable_urgentLevel">项目紧急程度&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="urgentLevel" name="urgentLevel" value="${project.urgentName }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="workload" id="lable_workload">工作量估算(人月)&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="workload" name="workload"  value="${project.workload }"/>
					             </div>
							</div>
							<div class="form-group" id="old_input">
								 <label class="col-sm-2 control-label" for="old_remark">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_remark" name="old_remark" value="${oldProject.remark}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_urgentLevel">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_urgentLevel" name="old_urgentLevel" value="${oldProject.urgentName }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_workload">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_workload" name="old_workload"  value="${oldProject.workload }"/>
					             </div>
							</div>
							<div class="form-group" id="new_input">
								 <label class="col-sm-2 control-label" for="expCost" id="lable_expCost">成本估算(万)&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expCost" name="expCost" value="${project.expCost }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="projectExp" id="lable_projectExp">项目目标&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projectExp" name="projectExp" value="${project.projectExp }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="deliveryDesc" id="lable_deliveryDesc">交付物&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="deliveryDesc" name="deliveryDesc"  value="${project.deliveryDesc }"/>
					             </div>
							</div>
							<div class="form-group" id="old_input">
								 <label class="col-sm-2 control-label" for="old_expCost">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_expCost" name="old_expCost" value="${oldProject.expCost }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_projectExp">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_projectExp" name="old_projectExp" value="${oldProject.projectExp }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_deliveryDesc">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_deliveryDesc" name="old_deliveryDesc"  value="${oldProject.deliveryDesc }"/>
					             </div>
							</div>
							<div class="form-group" id="new_input">
								 <label class="col-sm-2 control-label" for="feasibilityReport" id="lable_feasibilityReport">可行性验证情况&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="feasibilityReport" name="feasibilityReport" value="${project.feasibilityReport }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="includeTech" id="lable_includeTech">采用技术&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="includeTech" name="includeTech" value="${project.includeTech }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="riskDesc" id="lable_riskDesc">主要风险描述&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="riskDesc" name="riskDesc"  value="${project.riskDesc }"/>
					             </div>
							</div>
							<div class="form-group" id="old_input">
								 <label class="col-sm-2 control-label" for="old_feasibilityReport">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_feasibilityReport" name="old_feasibilityReport" value="${oldProject.feasibilityReport }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_includeTech">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_includeTech" name="old_includeTech" value="${oldProject.includeTech }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_riskDesc">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_riskDesc" name="old_riskDesc"  value="${oldProject.riskDesc }"/>
					             </div>
							</div>
							<div class="form-group" id="new_input">
								 <label class="col-sm-2 control-label" for="expStartDate" id="lable_expStartDate">项目计划开始时间&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expStartDate" name="expStartDate" value="<fmt:formatDate value='${project.expStartDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
					             <label class="col-sm-2 control-label" for="expEndDate" id="lable_expEndDate">项目计划结束时间&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expEndDate" name="expEndDate" value="<fmt:formatDate value='${project.expEndDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
					             <label class="col-sm-2 control-label" for="expSaleAmount" id="lable_expSaleAmount">预计销售金额&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expSaleAmount" name="expSaleAmount"  value="${project.expSaleAmount }"/>
					             </div>
							</div>
							<div class="form-group" id="old_input">
								 <label class="col-sm-2 control-label" for="old_expStartDate">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_expStartDate" name="old_expStartDate" value="<fmt:formatDate value='${oldProject.expStartDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_expEndDate">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_expEndDate" name="old_expEndDate" value="<fmt:formatDate value='${oldProject.expEndDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_expSaleAmount ">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_expSaleAmount" name="old_expSaleAmount"  value="${oldProject.expSaleAmount }"/>
					             </div>
							</div>
							<div class="form-group" id="new_input">
								 <label class="col-sm-2 control-label" for="relStartDate" id="lable_relStartDate">项目实际开始时间&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="relStartDate" name="relStartDate" value="<fmt:formatDate value='${project.relStartDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
					             <label class="col-sm-2 control-label" for="relEndDate" id="lable_relEndDate">项目实际结束时间&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="relEndDate" name="relEndDate" value="<fmt:formatDate value='${project.relEndDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
					             <label class="col-sm-2 control-label" for="pmName" id="lable_pmName">项目经理&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="pmName" name="pmName"  value="${project.pmName }"/>
					             </div>
							</div>
							<div class="form-group" id="old_input">
								 <label class="col-sm-2 control-label" for="old_relStartDate">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_relStartDate" name="old_relStartDate" value="<fmt:formatDate value='${oldProject.relStartDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_relEndDate">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_relEndDate" name="old_relEndDate" value="<fmt:formatDate value='${oldProject.relEndDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_pmName ">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_pmName" name="old_pmName"  value="${oldProject.pmName }"/>
					             </div>
							</div>
							<div class="form-group" id="new_input">
					             <label class="col-sm-2 control-label" for="clientNames" id="lable_clientNames">客户名称&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="clientNames" name="clientNames" value="${project.clientNames }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="projDesc" id="lable_projDesc">项目描述&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projDesc" name="projDesc"  value="${project.projDesc }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="busName" id="lable_busName">商务负责人&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="busName" name="busName"  value="${project.busName }"/>
					             </div>
							</div>
							<div class="form-group" id="old_input">
					             <label class="col-sm-2 control-label" for="old_clientNames">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_clientNames" name="old_clientNames" value="${oldProject.clientNames }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_projDesc ">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_projDesc" name="old_projDesc"  value="${oldProject.projDesc }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="old_busName ">&nbsp;</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="old_busName" name="old_busName"  value="${oldProject.busName }"/>
					             </div>
							</div>
						</div>
					</form>
				</div>
				<div class="row">&nbsp;</div>
         </div>
        </div>
        	<div class="row">
	           <div class="col-md-12" align="center">
					<button type="button" class="btn btn-danger btn-sm" onclick="back()">返回</button>
	            </div>
	        </div>
    </section>
    <!-- /.content -->
  </div>
<%@include file="../../../webfooter.jsp" %>
</div>
<%@include file="../../../common/deptModel.jsp" %>
</body>
</html>