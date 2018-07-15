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
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<script type="text/javascript">
$(function(){
	//在部门输入框上增加悬停事件
	$("#deptName").hover(function(){
		var dirName=$("#deptName").val();
		if(!dirName){
			return;
		}
		$("#deptName").attr("title",dirName);
	});
		b();
		setTimeout(a, 100);
		queryLastWeek();
		
})
/*****部门树初始化****/
function initDeptTree(){
	var treeRootUrl = "<%=request.getContextPath()%>/admin/project/monitor/dirTree.ajax";
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
function chooseDept(){
	$("#deptModel").modal('show');
}
	
	function b(){
		initDeptTree();
		var dataHeader = [
					{"dataField":"yearMonth","label":"月份","align":"center","valign":"middle"},
					{"dataField":"projCode","label":"项目编号","align":"center","valign":"middle"},
					{"dataField":"projName","label":"项目名称","align":"center","valign":"middle"},
					{"dataField":"userName","label":"人员名称","align":"center","valign":"middle"},
					{"dataField":"workTime","label":"正常工时","align":"center","valign":"middle"},
					{"dataField":"overWorkTime","label":"加班工时","align":"center","valign":"middle"},
					{"dataField":"count","label":"合计","align":"center","valign":"middle"}
		];
		
		$("#myTable").createTable({
			dataHeader:dataHeader,//数组，每列的属性（必须）
			caption:"",//表格标题内容（非必须）
			root:"workLoadList",//返回数据的key（必须）
			url:"<%=request.getContextPath()%>/admin/workLoad/workLoadQuery.ajax",//请求数据地址（必须）
			drag:true,//表格是否可以拖动换行
			limit:10,//表格显示行数，默认为10
			pagination:true,//是否进行分页，默认true
			param:function(){
				var obj = new Object();
				obj.projName = $("#projName").val();
				obj.projCode = $("#projCode").val();
				obj.projStatus=$("#projStatus").val();
				obj.deptId = $("#deptId").val();
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
		
	}
function queryByCondition(){
	$("#pagemyTable").val("1");
	$("#myTable").loadData();
}

function exportWorkAccount(){
	//var fileName = "工作量统计信息";
	//var fileType = "xlsx";
	$("#workAccountForm").attr("action","<%=request.getContextPath()%>/admin/workLoad/exportWorkAccount.download");
	$("#workAccountForm").submit();
}

function resets(){
	$("#workLogForm")[0].reset();
}
</script>

</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/workLoad/workLoadAccount.do"/>
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
              <h3 class="box-title">工作量统计</h3>
              
              <div class="box-tools pull-right">
                
              </div>
            </div>
           <div class="box box-info">
              </div>
            <div class="box-body">
	             <div class="row">
		            <form action="" id="workAccountForm" class="form-horizontal" method="post">
		            	
					</form>
				</div>
	            <div class="row">
		            <form action="" id="workLogForm" class="form-horizontal" method="post">
						<div class="searchBox" >
							<div class="form-group">
								<label class="col-sm-2 control-label" for="projName">项目名称&nbsp;&nbsp;:</label>
					            <div class="col-sm-2">
					            	<input type="text" class="form-control" id="projName" name="projName" />
					            </div>
					            <label class="col-sm-2 control-label" for="projCode">项目编码&nbsp;&nbsp;:</label>
					            <div class="col-sm-2">
					            	<input type="text" class="form-control" id="projCode" name="projCode"  />
					            </div>
					             <label class="col-sm-2 control-label" for="status">项目状态&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<select class="form-control" name="projStatus" id="projStatus">
					             	    <option value=""  >全部</option>
		 		             		    <option value="01"  >未立项</option>
					             		<option value="02" >立项审批</option>
					             		<option value="03" >开发进行</option>
					             		<option value="04" >销售进行</option>
					             		<option value="05" >方案评审</option>
					             		<option value="06" >结项</option>
					             	</select>
					             </div>
					    </div>
					    <div class="form-group">
					         <c:if test="${dataId2!=null}">
						             <label class="col-sm-2 control-label" for="deptName">部门&nbsp;&nbsp;:</label>
						             <div class="col-sm-2" style="position: relative;">
						             		<input class="form-control" id="deptName"  name="deptName" title="${authDirBo.dirName}" value="${authDirBo.dirName}" readOnly="readOnly" style="width:65%;">
						             		<input  id="deptSeq"  name="deptSeq" hidden="hidden" value="${authDirBo.seq}">
						             	<div class="checkbox" style="position: absolute;top: 0px;right: 8px;">
						             		<input type="checkbox" id="checkDirName2" class="leftp" name="checkDirName2" style="">全部
					                    	<input  id="deptSeq2" name="deptSeq2" value="" hidden="hidden">
					                    </div>
						             </div>
						             </c:if>
						             <c:if test="${dataId2==null}">
						             <label class="col-sm-2 control-label" for="deptName">部门&nbsp;&nbsp;:</label>
						             <div class="col-sm-2" style="position: relative;">
						             		<input class="form-control" id="deptName"  name="deptName" title="${authDirBo.dirName}" onClick="chooseDept()" style="width:65%;">
						             		<input  id="deptId"  name="deptId" hidden="hidden">
						             	<div class="checkbox" style="position: absolute;top: 0px;right: 8px;">
						             		<input type="checkbox" id="checkDirName" class="leftp" name="checkDirName" value="" style="">全部
					                    	<input type="hidden" id="checkDeptName" name="checkDeptName" value="">
					                    </div>
						             </div>
						             </c:if>
					    </div>
					    </div>
					</form>
				</div>
				<div class="row">
	              	<div class="col-md-12" align="center">
	              		<button type="button" class="btn btn-success btn-sm" onclick="queryByCondition()">
						  <span class="glyphicon glyphicon-search" aria-hidden="true"><span class="my-operation">查询</span></span>
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="resets()">
								  <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"><span class="my-operation">重置</span></span>
						</button>
	              	</div>
                </div>
				<div class="row">&nbsp;</div>
	             <div class="row">
	             	<div style="padding-left: 16px">
						<button type="button" class="btn btn-success btn-sm" onclick="exportWorkAccount()">
						  <span class="glyphicon glyphicon-export" aria-hidden="true"><span class="my-operation">导出</span></span>
						</button>
	              	</div>
	            	<div class="col-md-12">
	            		<div id="myTable"></div>
	            	</div>
	            </div>
	            <div>
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
