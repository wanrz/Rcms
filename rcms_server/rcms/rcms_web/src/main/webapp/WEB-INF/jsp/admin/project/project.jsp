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
	
	initDeptTree();
	$('#myModal').on('hide.bs.modal', function () {
		$("#projectForm")[0].reset();
	})
})
/*****部门树初始化****/
function initDeptTree(){	
	var treeRootUrl = "<%=request.getContextPath()%>/admin/project/dirTree.ajax";
	$.beTree({
		treeId:"deptTree",
		treeRootUrl:treeRootUrl,
		onClick:queryDept
	});
}

/**/
 function projectAdd(){
	var a = $("#projectType").val();
	var b = a.split(",");
	var typeCode=b[1];
	var projectName=b[0];
	$("#typeCode").val(typeCode);
	$("#projectName").val(projectName);
 	$("#projectForm").attr("action","<%=request.getContextPath()%>/admin/project/projectAdd.do"); 
 	$("#projectForm").submit();
}
/* 树点击后执行的方法 */
function queryDept(treeNode){
	//alert(treeNode.name+treeNode.dataId+treeNode.parentId);
	$("#deptName").val(treeNode.name);
	$("#deptId").val(treeNode.dataId);
	$("#deptModel").modal('hide');
	$("#checkDeptName").val(treeNode.dirSeq);
}
$(function(){
	
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
		url:"<%=request.getContextPath()%>/admin/project/projectQuery.ajax",//请求数据地址（必须）
		drag:true,//表格是否可以拖动换行
		limit:10,//表格显示行数，默认为10
		pagination:true,//是否进行分页，默认true
		param:function(){
			var obj = new Object();
			obj.projName = $("#projName").val();
			obj.projCode = $("#projCode").val(); 
			obj.deptId = $("#deptId").val();
			obj.status = $("#status").val();
			obj.deptName = $("#deptName").val();
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

function query(){
	$("#pagemyTable").val("1");
	$("#myTable").loadData();
}
function reset(){
	$("#userForm")[0].reset();
}
function addUser(){
	window.location.href="<%=request.getContextPath()%>/admin/project/projectAdd.do"
}

function projectDelete(){
	var pkProjList=$("#myTable").getSelectItems();
	
	if(pkProjList.length == 0){
		window.top.warning("请选择要删除的项目");
		return;
	}
	$("#deleteModal").modal('show');
}

function deleteThis(){
	var projList=$("#myTable").getSelectItems();
	var pkProjList = new Array();
	for(var i=0;i<projList.length;i++){
		pkProjList[i] = projList[i].pkProj;
	}
	
	$.ajax({
		type:"post",
		url:"<%=request.getContextPath()%>/admin/project/deleteProj.ajax",
		data:{pkProjList:JSON.stringify(pkProjList)},
		success:function(){
			window.top.warning("删除成功");
			$("#myTable").loadData();
			$("#deleteModal").modal('hide');
		},
		error:function(){
			$("#deleteModal").modal('hide');
		}
	});
}
function projectUpdate(){
	var user=$("#myTable").getSelectItems();
	if(user.length == 0 || user.length >1){
		window.top.warning("请选择一条需要修改的记录");
		return;
	}
	if(user[0].status != "未立项"){
		window.top.warning("只能修改未立项的项目");
		return;
	}
	var pkProj=$("#myTable").getSelectItems()[0].pkProj;
	$("#pkProj").val(pkProj);
	document.getElementById("queryForm").submit();
<%-- 	window.location.href="<%=request.getContextPath()%>/admin/addproject/projectUpdate.do" --%>
	
}

function projectDetails(){
	var projects=$("#myTable").getSelectItems();
	if(projects.length==1){
		$("#hiddenPkProj").val(projects[0].pkProj);
		$("#hiddenForm").attr("action","<%=request.getContextPath()%>/admin/project/projectDetails.do").submit();
	}else{
		window.top.warning("请选择一条数据");
		return;
	}
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
<c:set var="m_active" value="/admin/project/project.do"/>
<c:set var="m_active_code" value="ToolBarCProjManage"/>
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
              <h3 class="box-title">立项登记</h3>
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
            	<form action="" id="userForm" class="form-horizontal">
					<div class="searchBox" >
						<div class="container-fluid" style="padding-top: 10px;vertical-align: middle;">
							<c:if test="${dataId2!=null}">
					             <label class="col-sm-2 control-label" for="dirName">部门名称&nbsp;&nbsp;:</label>
					             <div class="col-sm-3">
					             	<input type="text" class="form-control" id="dirName_dataId2" readOnly="readOnly" name="dirName_dataId2" value="${authDirBo.dirName }"/>
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
			             			<input type="text" class="form-control rcms-cut" id="deptName" name="deptName" value="" onClick="chooseDept()"/>
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
            	<button type="button" class="btn btn-success btn-sm" onclick="query()">
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
	              		<button type="button" class="btn btn-success btn-sm" data-toggle="modal" data-target="#myModal">
						  <span class="glyphicon glyphicon-plus" aria-hidden="true"><span class="my-operation">新增</span></span>
						</button>
						<button type="button" class="btn btn-primary btn-sm" onclick="projectUpdate()">
						  <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">修改</span></span>
						</button>
						<button type="button" class="btn btn-primary btn-sm" onclick="projectDetails()">
						  <span class="glyphicon glyphicon-search" aria-hidden="true"><span class="my-operation">详情</span></span>
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="projectDelete()">
						  <span class="glyphicon glyphicon-trash" aria-hidden="true"><span class="my-operation">删除</span></span>
						</button>
	              	</div>
                </div>
	             <div class="row">
	            	<div class="col-md-12">
	            		<div id="myTable"></div>
	            		<form id="hiddenForm" method="post">
	            			<input  hidden="hidden" id="hiddenPkProj" name="pkProj" />
	            		</form>
	            	</div>
	            </div>
	            <div>
	            	<form action="<%=request.getContextPath()%>/admin/project/projectUpdate.do" method="post" id="queryForm">
	            	<input type="hidden" id="pkProj" name="pkProj" value="">
	            </form>
	            </div>
            </div>
        </div>
       
      </div>
      <!-- 模态框开始 -->
      <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	       <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
			    
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<div><label>请选择项目类型！</label></div>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="projectForm" method="post">
                     <div class="form-group">
                          <label for="inputEmail3" class="col-sm-3 control-label">项目类型&nbsp;&nbsp;:</label>
                            <div class="col-sm-6">
                                  
                                    <select class="form-control" name="projectType" id="projectType">
	                                 	<c:forEach var="project" items="${projectTypeList}">
	                                    	<option value="${project.typeName},${project.typeCode}">${project.typeName}</option>
	                                    </c:forEach>
	                                 </select>
                             </div>
                     </div>
                     <input type="hidden" name="projectName" id="projectName" value="">
                     <input type="hidden" name="typeCode" id="typeCode" value="">
                 </form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="button" class="btn btn-primary" onclick="projectAdd()" id="projectAddBtn" value=" ">
					保存
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
     <!-- 模态框结束 --> 
     <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" 
		data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" >提示</h4>
	            </div>
	            <div class="modal-body" align="center">是否确定删除已选项目</div>
	            <input type="hidden" id="Status" name="Status" value="">
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary" onclick="deleteThis()">确认</button>
	            	<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
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