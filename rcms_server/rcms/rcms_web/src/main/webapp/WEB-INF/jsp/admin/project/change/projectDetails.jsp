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
	$("#projectForm input").attr("readonly",true);
	var dataHeader = [
				{"dataField":"","label":"序号","align":"center","valign":"middle"},
				{"dataField":"projName","label":"项目名称","align":"center","valign":"middle"},
				{"dataField":"projCode","label":"项目编码","align":"center","valign":"middle"},
				{"dataField":"updateTime","label":"变更时间","align":"center","valign":"middle"},
				{"dataField":"modifyUserName","label":"变更操作人","align":"center","valign":"middle"},
				{"dataField":"","label":"操作","align":"center","valign":"middle","filter":"setOperator"},
			
	];
	window.setOperator = function(obj,createUserId){
		var attend_btn = $("<button type='button' class='btn btn-primary btn-sm'>详情对比</button>");
		attend_btn.click(function(){
			$("#version").val(obj.version);
			$("#projectForm").attr("action","<%=request.getContextPath()%>/admin/change/contrast.do");
			$("#projectForm").submit();
		});
		createUserId.append(attend_btn);
	};
	$("#myTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"projectList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/change/projectDetails.ajax",//请求数据地址（必须）
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
</script>
<style type="text/css">
	#myBootDataGridmyTable td{
 		vertical-align: middle; 
	}
</style>
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
   <!--  <section class="content-header">
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
              <h3 class="box-title">最新信息</h3>
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
							<div class="form-group">
					             <label class="col-sm-2 control-label" for="projName">项目名称&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projName" name="projName" value="${project.projName }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="projShName">项目英文名称&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projShName" name="projShName"  value="${project.projShName }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="projCode">项目编码&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projCode" name="projCode"  value="${project.projCode }"/>
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="applyDate">申请日期&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="applyDate" name="applyDate" value="<fmt:formatDate value='${project.applyDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="dirName">申请部门&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control overflowH" title="${project.dirName}" id="dirName" name="dirName" value="${project.dirName }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="budgetSource">预算出处&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="budgetSource" name="budgetSource"  value="${project.budgetSource }"/>
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="projType">项目类型&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projType" name="projType" value="${project.projType }"/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="projLevel">项目级别&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<c:if test="${project.projLevel eq '1'}"><input type="text" class="form-control" id="projLevel" name="projLevel" value="小型项目"/></c:if>
					             	<c:if test="${project.projLevel eq '2'}"><input type="text" class="form-control" id="projLevel" name="projLevel" value="中型项目"/></c:if>
					             	<c:if test="${project.projLevel eq '3'}"><input type="text" class="form-control" id="projLevel" name="projLevel" value="大型项目"/></c:if>
					             	<c:if test="${project.projLevel eq '4'}"><input type="text" class="form-control" id="projLevel" name="projLevel" value="特大型项目"/></c:if>
					             </div>
					             <label class="col-sm-2 control-label" for="status">项目状态&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="status" name="status" value="${project.status }"/>
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="remark">项目规模(人数)&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="remark" name="remark" value="${project.remark }"/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="urgentLevel">项目紧急程度&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<c:if test="${project.urgentLevel eq '1'}"><input type="text" class="form-control" id="urgentLevel" name="urgentLevel" value="一般"/></c:if>
					             	<c:if test="${project.urgentLevel eq '2'}"><input type="text" class="form-control" id="urgentLevel" name="urgentLevel" value="紧急"/></c:if>
					             	<c:if test="${project.urgentLevel eq '3'}"><input type="text" class="form-control" id="urgentLevel" name="urgentLevel" value="持续"/></c:if>							
					             </div>
					             <label class="col-sm-2 control-label" for="workload">工作量估算(人月)&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="workload" name="workload"  value="${project.workload }"/>
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="expCost">成本估算(万)&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expCost" name="expCost" value="${project.expCost }"/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="projectExp">项目目标&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projectExp" name="projectExp" value="${project.projectExp }" onmouseover="this.title=this.value"/>
					             </div>
					             <label class="col-sm-2 control-label" for="deliveryDesc">交付物&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="deliveryDesc" name="deliveryDesc"  value="${project.deliveryDesc }" onmouseover="this.title=this.value"/>
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="feasibilityReport">可行性验证情况&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="feasibilityReport" name="feasibilityReport" value="${project.feasibilityReport }" onmouseover="this.title=this.value"/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="includeTech">采用技术&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="includeTech" name="includeTech" value="${project.includeTech }" onmouseover="this.title=this.value"/>
					             </div>
					             <label class="col-sm-2 control-label" for="riskDesc">主要风险描述&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="riskDesc" name="riskDesc"  value="${project.riskDesc }" onmouseover="this.title=this.value"/>
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="expStartDate">项目计划开始时间&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expStartDate" name="expStartDate" value="<fmt:formatDate value='${project.expStartDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="expEndDate">项目计划结束时间&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expEndDate" name="expEndDate" value="<fmt:formatDate value='${project.expEndDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
					             <label class="col-sm-2 control-label" for="expSaleAmount ">预计销售金额&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expSaleAmount" name="expSaleAmount"  value="${project.expSaleAmount }"/>
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="relStartDate">项目实际开始时间&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="relStartDate" name="relStartDate" value="<fmt:formatDate value='${project.relStartDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="relEndDate">项目实际结束时间&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="relEndDate" name="relEndDate" value="<fmt:formatDate value='${project.relEndDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	/>
					             </div>
					             <label class="col-sm-2 control-label" for="pmName ">项目经理&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="pmName" name="pmName"  value="${project.pmName }"/>
					             </div>
							</div>
							<div class="form-group" >
					             <label class="col-sm-2 control-label" for="clientNames">客户名称&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="clientNames" name="clientNames" value="${project.clientNames }" onmouseover="this.title=this.value"/>
					             </div>
					             <label class="col-sm-2 control-label" for="projDesc ">项目描述&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projDesc" name="projDesc"  value="${project.projDesc }" onmouseover="this.title=this.value"/>
					             </div>
					             <label class="col-sm-2 control-label" for="pmName ">商务负责人&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="pmName" name="pmName"  value="${project.busName }"/>
					             </div>
					             <div>
						             <input type="hidden" class="form-control" id="pkProj" name="pkProj"  value="${project.pkProj }" />
						             <input type="hidden" class="form-control" id="version" name="version"  />
					             </div>
							</div>
							</form>
						</div>
					
				</div>
				<div class="row">&nbsp;</div>
         </div>
        </div>
        	<div class="row">
	            <div class="col-md-12">
	            	<div id="myTable"></div>
	            </div>
	            <div class="col-md-12">&nbsp;</div>
	            <div class="col-md-12" align="center">
	              	<div class="col-md-12" align="center">
						<button type="button" class="btn btn-danger btn-sm" onclick="back()">返回
						</button>
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
</html>