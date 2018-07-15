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
});
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


$(function(){
	/* 初始化树 */
	initDeptTree();
	var dataHeader = [
	  				
	  				{"dataField":"","label":"序号","align":"center","valign":"middle"},
	  				{"dataField":"projCode","label":"项目编号","align":"center","valign":"middle"},
	  				{"dataField":"projName","label":"项目名称","align":"center","valign":"middle"},
	  				{"dataField":"planEndDate","label":"计划完成日期","align":"center","valign":"middle","filter":"setPlanDate"},
	  				{"dataField":"pmName","label":"项目经理","align":"center","valign":"middle"},
	  				{"dataField":"deptName","label":"部门","align":"center","valign":"middle"},
	  				{"dataField":"personCount","label":"参与人数","align":"center","valign":"middle"},
	  				{"dataField":"status","label":"项目状态","align":"center","valign":"middle"},
	  				{"dataField":"persent","label":"完成进度百分比","align":"center","valign":"middle","filter":"setOperator"}
	  				
	  			
	  	];
	  	
	window.setPlanDate=function(obj,planEndDate){
		planEndDate.html(obj.expStartDate + "&nbsp;至&nbsp;" +obj.expEndDate); 
	};
	  	
	window.setOperator = function(obj,persent){
		var attend_btn = $("<p>"+obj.persent+"%"+"</p><button type='button' class='btn btn-primary btn-sm' title=''>查看任务详情</button>");
		attend_btn.click(function(){
			$("#pkProj").val(obj.pkProj);
			$("#projNames").val(obj.projName);
		 	$("#queryForm").attr("action","<%=request.getContextPath()%>/admin/project/progressMonitor.do"); 
		 	$("#queryForm").submit();
			
		});
		persent.append(attend_btn);
	};
	  	$("#myTable").createTable({
	  		dataHeader:dataHeader,//数组，每列的属性（必须）
	  		caption:"",//表格标题内容（非必须）
	  		root:"projList",//返回数据的key（必须）
	  		url:"<%=request.getContextPath()%>/admin/project/queryProjMonitor.ajax",//请求数据地址（必须）
	  		drag:true,//表格是否可以拖动换行
	  		limit:10,//表格显示行数，默认为10
	  		pagination:true,//是否进行分页，默认true
	  		param:function(){
	  			var obj = new Object();
	  			obj.projName = $("#projName").val();
	  			obj.projCode = $("#projCode").val(); 
	  			obj.status = $("#status").val();
	  			obj.pmId = $("#pmId").val();
	  			obj.deptId = $("#deptId").val();
	  			obj.deptName = $("#deptName").val();
	  			obj.planEndDate = $("#planEndDate").val();
	  			if($("#checkDirName").prop("checked")){
					var aa=$("#checkDeptName").val();
					$("#checkDirName").val(aa);
					obj.checkDirName = $("#checkDirName").val();
				}else{
					$("#checkDirName").val("");
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
		/* 任务详细信息列表 */
	
});

function chooseDept(){
	$("#deptModel").modal('show');
}
	
	
function queryTest(){
	$("#pagemyTable").val("1");
	$("#myTable").loadData();
}
function reset(){
	$("#taskForm")[0].reset();
}	
/* 导出任务或任务详情 */
/*  flag为true时导出简单信息，flag为false时导出详细信息*/
function exportTask(flag){
	var tasks=$("#myTable").getSelectItems();
	if(tasks.length==0){
		warning("请至少选择一条数据");
		return;
	}
	var taskId=[];
	$.each(tasks,function(i,task){
		taskId.push(task.pkTask);
		}
	)
	$("#hiddenExport").attr("href","<%=request.getContextPath()%>/admin/project/exportTask.download?taskId="+taskId+"&flag="+flag);
	$("#hiddenExport2").click();
}

</script>

<style>
.checkbox{
	position: absolute;
    top: -2px;
    left: 78%;
}
#myBootDataGridmyTable td{
 		vertical-align: middle; 
	}
</style>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/project/projMonitor.do"/>
<c:set var="m_active_code" value="ToolBarProjManage"/>
<div class="wrapper">
  <%@include file="../../../webhead.jsp" %>
  <%@include file="../../../webleft.jsp" %>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Main content 在这里引入主要内容-->
    <section class="content"> 
    
    <div class="row">
        <div class="col-md-12">
          <div >
            <div class="box-header with-border">
              <h3 class="box-title">项目进度监控</h3>
              
              <div class="box-tools pull-right">
                
              </div>
            </div>
            <div class="box box-info">
            </div>
            <div class="box-body">
	            <div class="row">
		            <form action="" id="taskForm" class="form-horizontal" method="post">
		            	<input type="hidden" id="pkTask" name="pkTask" value="">
							<div class="searchBox" >
								<div style="padding-top: 10px;vertical-align: middle;" class="container-fluid" >
									<label class="col-sm-2 control-label" for="projName">项目名称&nbsp;&nbsp;:</label>
						            <div class="col-sm-2">
						            	<input type="text" class="form-control" id="projName" name="projName" />
						            </div>
						            <label class="col-sm-2 control-label" for="projCode">项目编码&nbsp;&nbsp;:</label>
						            <div class="col-sm-2">
						            	<input type="text" class="form-control" id="projCode" name="projCode"  />
						            </div>
						         <label class="col-sm-2 control-label" for="pmId ">项目经理&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<select class="form-control" name="pmId" id="pmId">
					             	<option value="">全部</option>
	                                 	<c:forEach var="pm" items="${pmList}">
	                                    	<option value="${pm.userId}" >${pm.userName}</option>
	                                    </c:forEach>
	                                 </select>
					             </div>
								</div>
						       	<div style="padding-top: 10px;vertical-align: middle;" class="container-fluid" >
						             <label class="col-sm-2 control-label" for="status">项目状态&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<select class="form-control" name="status" id="status">
					             	    <option value=""  >全部</option>
		 		             		    <option value="01"  >未立项</option>
					             		<option value="02" >立项审批</option>
					             		<option value="03" selected="selected">开发进行</option>
					             		<option value="04" >销售进行</option>
					             		<option value="05" >方案评审</option>
					             		<option value="06" >结项</option>
					             	</select>
					             </div>
						             <label class="col-sm-2 control-label" for="planEndDate">完成日期&nbsp;&nbsp;:</label>
						             <div class="col-sm-2">
						             	<input class="form-control" id="planEndDate" mType="input" name="planEndDate" 
											onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});">
						             </div>
						            <c:if test="${dataId2!=null}">
						             <label class="col-sm-2 control-label" for="deptName">部门&nbsp;&nbsp;:</label>
						             <div class="col-sm-2" style="position: relative;">
						             		<input class="form-control" id="deptName"  name="deptName" title="${authDirBo.dirName}" value="${authDirBo.dirName}" readOnly="readOnly" style="width:65%;">
						             		<input  id="deptSeq"  name="deptSeq" hidden="hidden" value="${authDirBo.seq}">
						             	<div class="checkbox">
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
						             	<div class="checkbox">
						             		<input type="checkbox" id="checkDirName" class="leftp" name="checkDirName" value="" style="">全部
					                    	<input type="hidden" id="checkDeptName" name="checkDeptName" value="">
					                    </div>
						             </div>
						             </c:if>
						        </div>
					        </div>
					        <div class="row">&nbsp;</div>
					        <div class="row"  align="center">
								<button type="button" class="btn btn-success btn-sm" onclick="queryTest()">
								  <span class="glyphicon glyphicon-search" aria-hidden="true"><span class="my-operation">查询</span></span>
								</button>
								<button type="button" class="btn btn-danger btn-sm" onclick="reset()">
								  <span class="glyphicon glyphicon-remove-sign" aria-hidden="true"><span class="my-operation">重置</span></span>
								</button>
							</div>      
					</form>
				</div>
				
	             <div class="row">
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
      

	<form  id ="queryForm" action="" method="post">
	<input type="hidden" id="pkProj" name="pkProj" >
	<input type="hidden" id="projNames" name="projNames" >
	</form>
   
    </section>
    <!-- /.content -->
  </div>
<%@include file="../../../webfooter.jsp" %>
</div>
<%@include file="../../../common/deptModel.jsp" %>
 
</body>
<!-- 任务详情模态框开始 -->
	<div class="modal fade" id="detailModel" z-index="1011" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	
		<div class="modal-dialog" style="width:90% !important;">
			<div class="modal-content">
				<div class="modal-header">
					<p style="text-align:center">项目进度详情</p>
				</div>
				<div class="modal-body">
					<div id="taskDetailTable"  />
					<input name="" hidden="hidden" id="hiddenPkTask">
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
	<!-- 模态框结束 --> 
</html>