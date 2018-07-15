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
				{"dataField":"userName","label":"人员姓名","align":"center","valign":"middle"},
				{"dataField":"loginCode","label":"登录名","align":"center","valign":"middle"},
				{"dataField":"userStatus","label":"员工状态","align":"center","valign":"middle"},
				{"dataField":"dirName","label":"部门名称","align":"center","valign":"middle"},
				{"dataField":"roleListView","label":"角色名称","align":"center","valign":"middle"},
	];
	$("#myTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"userRoleList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/role/userRoleList.ajax",//请求数据地址（必须）
		drag:true,//表格是否可以拖动换行
		limit:10,//表格显示行数，默认为10
		pagination:true,//是否进行分页，默认true
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
		},
		error:function(){
		}
	});
		
		$("#myTable").loadData();
});	
</script>
<script type="text/javascript">
function toAdd(){
	window.location.href="<%=request.getContextPath()%>/admin/role/roleAdd.do"
}
</script>

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
    <section class="content-header">
      <h1>
       &nbsp;
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Home</a></li>
        <li class="active">Dashboard</li>
      </ol>
    </section>

    <!-- Main content 在这里引入主要内容-->
    <section class="content"> 
    <div class="row">
        <div class="col-md-12">
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">人员角色管理</h3>

              <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div>
            </div>
            <div class="box-body">
              <div class="row">
              	<div class="col-md-12">
					<button type="button" class="btn btn-info btn-sm">
					  <span class="glyphicon glyphicon-eye-open" aria-hidden="true"><span class="my-operation">角色权限详情</span></span>
					</button>
              		<div id="myTable"></div>
              	</div>
              </div>
              <!-- /.row -->
            </div>
            <!-- ./box-body -->
            
            <!-- /.box-footer -->
          </div>
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

</div>

</body>
</html>