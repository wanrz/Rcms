<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../common/head.jsp" %>
<%@include file="../../common/tree.jsp" %>
<%@include file="../../common/import.jsp"%>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>RCMS</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<script type="text/javascript">
$(function(){
	initDeptTree();
})
/*****部门树初始化****/
function initDeptTree(){
	var treeRootUrl = "<%=request.getContextPath()%>/admin/user/dirTree.ajax";
	$.beTree({
		treeId:"deptTree",
		treeRootUrl:treeRootUrl,
		onClick:queryDept
	});
}
/* 树点击后执行的方法 */
function queryDept(treeNode){
	//alert(treeNode.name+treeNode.dataId+treeNode.parentId);
	$("#dirName").val(treeNode.name);
	$("#dirId").val(treeNode.dataId);
	
	$("#deptModel").modal('hide');
	$("#checkDeptName").val(treeNode.dirSeq);
	
}
$(function(){
	var dataHeader = [
				{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
				{"dataField":"","label":"序号","align":"center","valign":"middle"},
				{"dataField":"userName","label":"人员姓名","align":"center","valign":"middle"},
				{"dataField":"loginCode","label":"登录名","align":"center","valign":"middle"},
				{"dataField":"userCode","label":"工号","align":"center","valign":"middle"},
				{"dataField":"dirName","label":"部门","align":"center","valign":"middle"},
				{"dataField":"userStatus","label":"状态","align":"center","valign":"middle"}
	];
	
	
	$("#myTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"userList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/user/userList.ajax",//请求数据地址（必须）
		drag:true,//表格是否可以拖动换行
		limit:10,//表格显示行数，默认为10
		pagination:true,//是否进行分页，默认true
		loadDataCallBack:chooseAllItems,
		param:function(){
			var obj = new Object();
			obj.dirId = $("#dirId").val();
			obj.userName = $("#userName").val();
			obj.loginCode = $("#loginCode").val();
			obj.userStatus = $("#userStatus").val();
			obj.dirName=$("#dirName").val();
			if($("#checkDirName").prop("checked")){
				var aa=$("#checkDeptName").val();
				$("#checkDirName").val(aa);
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
			}	
			
			obj.checkDirName = $("#checkDirName").val();
			return obj;
			
		},//请求参数，返回json对象（非必须）
		success:function(data){			
		},
		error:function(){
		}
	});
	queryUser();
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
function addUser(){
	window.location.href="<%=request.getContextPath()%>/admin/user/userAdd.do"
}
function updateUser(){
	var users=$("#myTable").getSelectItems();
	if(users.length==1){
		$("#hiddenUserId").val(users[0].userId);
		$("#hiddenForm").attr("action","<%=request.getContextPath()%>/admin/user/userUpdate.do").submit();
	}else{
		window.top.warning("请选择一条数据");
		return;
	}

}
/* 人员归档 */
function archiveUser(status){
	var users=$("#myTable").getSelectItems();
	if(users.length==0){
		window.top.warning("请选择一条数据");
		return;
	}
	var userId=[];
	$.each(users,function(i,user){
		userId.push(user.userId);
	});
	$.ajax({
		type:"post",
		url:"<%=request.getContextPath()%>/admin/user/userArchive.ajax?userId="+userId,
		data:{"userStatus":status},
		success:function(data){
			window.top.warning("归档成功！");
			queryUser();
		},error:function(msg){
		}
	});
}
	/*人员删除*/
function deleteUser() {
	var users=$("#myTable").getSelectItems();
	if(users.length!=1){
		window.top.warning("请选择一条数据");
		return;
	}
	$.ajax({
		type:"post",
		url:"<%=request.getContextPath()%>/admin/user/userDelete.ajax",
		data:{"userId":users[0].userId},
		success:function(data){
			window.top.warning("删除成功");
			queryUser();
		},error:function(msg){
		}
	});
}
function recoveryUser(status){
	var users=$("#myTable").getSelectItems();
	if(users.length==0){
		window.top.warning("请选择一条数据");
		return;
	}
	var userId=[];
	$.each(users,function(i,user){
		userId.push(user.userId);
	});
	$.ajax({
		type:"post",
		url:"<%=request.getContextPath()%>/admin/user/userRecovery.ajax?userId="+userId,
		data:{"userStatus":status},
		success:function(data){
			window.top.warning("恢复成功！");
			queryUser();
		},error:function(msg){
		}
	});
}

function importUser(){
	window.location.href="<%=request.getContextPath()%>/admin/user/userImport.do"
}

function userDetails(){
	var users=$("#myTable").getSelectItems();
	if(users.length==1){
		$("#hiddenUserId").val(users[0].userId);
		$("#hiddenForm").attr("action","<%=request.getContextPath()%>/admin/user/userDescribe.do").submit();
	}else{
		window.top.warning("请选择一条数据");
		return;
	}
}
function chooseAllItems() {
	$(".dataGrid_thead").find("input[type='checkbox']").attr("hidden","hidden");
}
</script>
</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/user/userManage.do"/>
<c:set var="m_active_code" value="ToolBarBaseInfo"/>
<div class="wrapper">
  <%@include file="../../webhead.jsp" %>
  <%@include file="../../webleft.jsp" %>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
<!--     <section class="content-header"> -->
<!--       <h1> -->
<!--        &nbsp; -->
<!--       </h1> -->
<!--       <ol class="breadcrumb"> -->
<!--         <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li> -->
<!--         <li class="active">Dashboard</li> -->
<!--       </ol> -->
<!--     </section> -->

    <!-- Main content 在这里引入主要内容-->
    <section class="content"> 
    
  <ul id="updateTree" class="ztree" style="width:230px;overflow:auto;"></ul>
    
    <div class="row">
        <div class="col-md-12">
            <div class="box-header with-border">
              <h3 class="box-title">人员管理</h3>
              <div class="box-tools pull-right">
              </div>
           </div>
            <div class="box box-info">
            </div>
            <div class="box-body">
	            <div class="row">
		            <form action="" id="userForm" class="form-horizontal">
							<div class="searchBox" >
								<div style="padding-top: 10px;vertical-align: middle;" class="container-fluid" >
								<label class="col-sm-2 control-label" for="loginCode">登录名&nbsp;&nbsp;:</label>
					             <div class="col-sm-3">
					             	<input type="text" class="form-control" id="loginCode" name="loginCode"  />
					             </div>
					             <div class="col-sm-1"></div>
					             <label class="col-sm-2 control-label" for="userName">人员姓名&nbsp;&nbsp;:</label>
					             <div class="col-sm-3">
					             	<input type="text" class="form-control" id="userName" name="userName" />
					             </div>
					         </div>
						</div>
						<div class="searchBox" >
								<div class="container-fluid" style="padding-top: 10px;vertical-align: middle;">
					             <c:if test="${dataId2!=null}">
					              	<label class="col-sm-2 control-label" for="dirName">部门名称&nbsp;&nbsp;:</label>
					             	<div class="col-sm-3">
					             		<input type="text" class="form-control" id="dirName" readOnly="readOnly" name="dirName" value="${authDirBo.dirName }"/>
					             		<input  id="deptSeq"  name="deptSeq" hidden="hidden" value="${authDirBo.seq}">
					             	</div>
					             	<div class="col-sm-1">	
					               		<div class="checkbox">				         
					                    	<input type="checkbox" id="checkDirName2" class="leftp" name="checkDirName2" style="">全部
					                		<input  id="deptSeq2" name="deptSeq2" value="" hidden="hidden">
					            		</div>
					            	</div>
					            </c:if>
					            <c:if test="${dataId2==null}">
					            	<label class="col-sm-2 control-label" for="dirName">部门名称&nbsp;&nbsp;:</label>
					             	<div class="col-sm-3">
					             		<input type="text" class="form-control" id="dirName" name="dirName" onclick="chooseDept()" />
					             	</div>
					            	<div class="col-sm-1">	
					               		<div class="checkbox">				         
					                    	<input type="checkbox"  id="checkDirName" name="checkDirName" value="" >全部
					                		<input type="hidden" id="checkDeptName" name="checkDeptName" value="">
					            		</div>
					            	</div>
					            </c:if>
					             <label class="col-sm-2 control-label" for="userStatus">人员状态&nbsp;&nbsp;:</label>
					             <div class="col-sm-3">
					             	<select class="form-control" name="userStatus" id="userStatus">
					             		<option value="">全部</option>
					             		<option value="1">有效</option>
					             		<option value="0">无效</option>
					             	</select>
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
	              		<button type="button" class="btn btn-success btn-sm" onclick="addUser()">
						  <span class="glyphicon glyphicon-plus" aria-hidden="true"><span class="my-operation">新增</span></span>
						</button>
						<button type="button" class="btn btn-primary btn-sm" onclick="updateUser()">
						  <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">修改</span></span>
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="deleteUser()">
						  <span class="glyphicon glyphicon-trash" aria-hidden="true"><span class="my-operation">删除</span></span>
						</button>
						<button type="button" class="btn btn-info btn-sm" onclick="userDetails()">
						  <span class="glyphicon glyphicon-search" aria-hidden="true"><span class="my-operation">详情查看</span></span>
						</button>
						<button type="button" class="btn btn-danger btn-sm"  onclick="archiveUser('0')">
						  <span class="glyphicon glyphicon-trash" aria-hidden="true"><span class="my-operation">归档</span></span>
						</button>
						<button type="button" class="btn btn-primary btn-sm"  onclick="recoveryUser('1')">
						  <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">恢复</span></span>
						</button>
						<button type="button" class="btn btn-primary btn-sm" onclick="importUser()">
						  <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">导入</span></span>
						</button>
	              	</div>
                </div>
	             <div class="row">
	            	<div class="col-md-12">
	            		<div id="myTable"></div>
	            		<form id="hiddenForm" method="post">
	            			<input  hidden="hidden" id="hiddenUserId" name="userId" />
	            		</form>
	            	</div>
	            </div>
            </div>
        </div>
       
      </div>
     
      
      <div class="box-body">
              
              <!-- /.row -->
            </div>
      
    </section>
    <!-- /.content -->
  </div>
<%@include file="../../webfooter.jsp" %>
</div>
<%@include file="../../common/deptModel.jsp" %>
</body>
<!-- 人员详情查看模态框开始 -->
	<div class="modal fade" id="detailModel" z-index="1011" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	
		<div class="modal-dialog" style="width:90% !important;">
			<div class="modal-content">
				<div class="modal-header">
					<p style="text-align:center">人员信息详情</p>
				</div>
				<div class="modal-body">
					<div id="userDetailTable" ></div>
						<input name="" hidden="hidden" id="userId">
					
				</div>
			</div><!-- /.modal-content -->
		</div><!-- /.modal -->
	</div>
	<!-- 模态框结束 --> 
</html>