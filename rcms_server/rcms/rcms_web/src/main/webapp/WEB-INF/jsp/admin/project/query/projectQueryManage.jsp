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
	initDeptTree();
	var dataHeader = [
	  				{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
					{"dataField":"","label":"序号","align":"center","valign":"middle"},
					{"dataField":"projName","label":"项目名称","align":"center","valign":"middle","width":"10%"},
					{"dataField":"projCode","label":"项目编码","align":"center","valign":"middle","width":"5%"},
					{"dataField":"dirName","label":"申请部门","align":"center","valign":"middle","width":"15%"},
					{"dataField":"applyDate","label":"申请日期","align":"center","valign":"middle","width":"10%"},
					{"dataField":"status","label":"项目状态","align":"center","valign":"middle","width":"8%"},
					{"dataField":"clientNames","label":"客户名称","align":"center","valign":"middle","width":"10%"},
					{"dataField":"pmName","label":"项目经理","align":"center","valign":"middle","width":"10%"},
					{"dataField":"modifyUserName","label":"结项人","align":"center","valign":"middle"},
					{"dataField":"updateTime","label":"结项时间","align":"center","valign":"middle"}
			
	];
	$("#myTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"projectList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/projectQuery/projectQuery.ajax",//请求数据地址（必须）
		drag:true,//表格是否可以拖动换行
		limit:10,//表格显示行数，默认为10
		pagination:true,//是否进行分页，默认true
		loadDataCallBack:chooseAllItems,
		param:function(){
			var obj = new Object();
			obj.projName = $("#projName").val();
			obj.projCode = $("#projCode").val(); 
			obj.deptId = $("#deptId").val();
			obj.status = $("#status").val();
			if($("#checkDirName").prop("checked")){
				var aa=$("#checkDeptName").val();
				$("#checkDirName").val(aa);
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
	$("#myTable").loadData();
});
function chooseDept(){
	$("#deptModel").modal('show');
}
function queryUser(){
	$("#pagemyTable").val("1");
	$("#myTable").loadData();
}
function reset(){
	$("#userForm")[0].reset();
}

function projectDetails(){
	var proj=$("#myTable").getSelectItems();
	if(proj.length != 1){
		window.top.warning("只能选择一条项目查看详情");
		return;
	}
	$("#pkProj").val(proj[0].pkProj);
	$("#queryForm").attr("action","<%=request.getContextPath()%>/admin/projectQuery/projectDetails.do")
	$("#queryForm").submit();
}

/*****部门树初始化****/
function initDeptTree(){	
	var treeRootUrl = "<%=request.getContextPath()%>/admin/projectQuery/dirTree.ajax";
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
function chooseAllItems() {
	$(".dataGrid_thead").find("input[type='checkbox']").attr("hidden","hidden");
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
<c:set var="m_active" value="/admin/projectQuery/project.do"/>
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
    
  <ul id="updateTree" class="ztree" style="width:230px;overflow:auto;"></ul>
    
    <div class="row">
        <div class="col-md-12">
            <div class="box-header with-border">
              <h3 class="box-title">项目查询</h3>
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
				             			<option value="">全部</option>
					             		<option value="01">未立项</option>
					             		<option value="02">立项审批</option>
					             		<option value="03">开发进行</option>
					             		<option value="04">销售进行</option>
					             		<option value="05">方案评审</option>
					             		<option value="00" selected="selected">未结项</option>
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
                <div class="row">&nbsp;</div>
				<div class="row">
	              	<div style="padding-left: 16px">
						<button type="button" class="btn btn-primary btn-sm" onclick="projectDetails()">
						  <span class="glyphicon glyphicon-search" aria-hidden="true"><span class="my-operation">项目详情</span></span>
						</button>
	              	</div>
                </div>
	             <div class="row">
	            	<div class="col-md-12">
	            		<div id="myTable"></div>
	            	</div>
	            </div>
	            <div>
	            <form action="" method="post" id="queryForm">
	           	 	<input type="hidden" id="pkProj" name="pkProj" value="">
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

</html>