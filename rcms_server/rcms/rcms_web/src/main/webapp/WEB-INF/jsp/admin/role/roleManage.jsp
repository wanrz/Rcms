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
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<script type="text/javascript">
$(function(){
	var dataHeader = [
				{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
				{"dataField":"","label":"序号","align":"center","valign":"middle"},
				{"dataField":"roleName","label":"角色名称","align":"center","valign":"middle","width":"15%"},
				{"dataField":"roleDesc","label":"角色描述","align":"center","valign":"middle"}
	];
	$("#myTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"roleBolist",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/role/roleList.ajax",//请求数据地址（必须）
		drag:true,//表格是否可以拖动换行
		limit:10,//表格显示行数，默认为10
		pagination:false,//是否进行分页，默认true
		loadDataCallBack:chooseAllItems,
		param:function(){
// 			var obj = new Object();
// 			obj.pkCatalog = $("#auth_dataId_boom").val();
// 			obj.skillName = $("#skillName").val();
// 			obj.skillCode = $("#skillCode").val(); 
// 			obj.auth_dataId_boom = $("#auth_dataId_boom").val();
// 			obj.auth_dataType_boom = $("#auth_dataType_boom").val();
// 			return obj;
			
		},//请求参数，返回json对象（非必须）
		success:function(data){	
			alert(data);
		},
		error:function(){
		}
	});
	$("#myTable").loadData();
});	
</script>
<script type="text/javascript">
/* 创建角色 */
function toAdd(){
	window.location.href="<%=request.getContextPath()%>/admin/role/roleAdd.do"
}
/* 人员角色列表 */
function toUserRole(){
	window.location.href="<%=request.getContextPath()%>/admin/role/toUserRole.do"
}
function toUpdate(){
	var roles=$("#myTable").getSelectItems();
	if(roles.length==1){
		$("#hiddenRoleId").val(roles[0].roleId);
		$("#hiddenForm").attr("action","<%=request.getContextPath()%>/admin/role/roleUpdate.do").submit();
	}else{
		window.top.warning("请选择一条数据");
		return;
	}
}
function toDelete(){
	var roles=$("#myTable").getSelectItems();
	if(roles.length!=1){
		window.top.warning("请选择一条数据");
		return;
	}
	$("#deleteModal").modal('show');

}

function deleteThis(){
	var roles=$("#myTable").getSelectItems();
	$.ajax({
		dataType: "json",
	 	data: {roleId:roles[0].roleId},
    	url:"<%=request.getContextPath()%>/admin/role/roleDelete.ajax",
        success:function(data){
        	window.top.warning("删除成功");
        	$("#deleteModal").modal('hide');
        	$("#myTable").loadData();
        },
        error:function(){
        	$("#deleteModal").modal('hide');
        }
    });
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

<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/role/roleManage.do"/>
<c:set var="m_active_code" value="ToolBarBaseInfo"/>
<div class="wrapper">
  <%@include file="../../webhead.jsp" %>
  <%@include file="../../webleft.jsp" %>
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
              <h3 class="box-title">角色管理</h3>
              <form action="" id="hiddenForm" method="post">
              	<input hidden="hidden" id="hiddenRoleId"  name="roleId" value=""/>
              </form>

              <!-- <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div> -->
            </div>
          <div class="box box-info">
          </div>
            <div class="box-body">
              <div class="row">
              	<div class="col-md-12">
	              	<button type="button" class="btn btn-success btn-sm" onclick="toAdd()">
					  <span class="glyphicon glyphicon-plus " aria-hidden="true"><span class="my-operation">新增</span></span>
					</button>
					<button type="button" class="btn btn-primary btn-sm" onclick="toUpdate()">
					  <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">修改</span></span>
					</button>
					<button type="button" class="btn btn-danger btn-sm"	onclick="toDelete()">
					  <span class="glyphicon glyphicon-trash" aria-hidden="true"><span class="my-operation">删除</span></span>
					</button>
<!-- 					<button type="button" class="btn btn-primary btn-sm" onclick="toUserRole()"> -->
<!-- 					  <span class="glyphicon glyphicon-th-list" aria-hidden="true"><span class="my-operation">人员列表</span></span> -->
<!-- 					</button> -->
              		<div id="myTable"></div>
              	</div>
              </div>
              <!-- /.row -->
            </div>
            <!-- ./box-body -->
            
            <!-- /.box-footer -->
          <!-- /.box -->
        </div>
        <!-- /.col -->
      </div>
    </section>
    <!-- /.content -->
  </div>
<%@include file="../../webfooter.jsp" %>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
       immediately after the control sidebar -->
<!--  右侧部分暂时不引入 
<%--  <%@include file="webright.jsp" %> --%>
<div class="control-sidebar-bg">大锅饭的认购的若干</div> 
-->
      <div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" 
		data-backdrop="static" data-keyboard="false" aria-labelledby="myModalLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <h4 class="modal-title" >提示</h4>
	            </div>
	            <div class="modal-body" align="center">是否确定删除角色</div>
	            <input type="hidden" id="Status" name="Status" value="">
	            <div class="modal-footer">
	            	<button type="button" class="btn btn-primary" onclick="deleteThis()">确认</button>
	            	<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
	            </div>
	        </div>
	    </div>
	</div> 
</div>

</body>
</html>