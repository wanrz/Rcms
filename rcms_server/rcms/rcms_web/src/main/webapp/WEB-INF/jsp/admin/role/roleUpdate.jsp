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
	$("#roleForm").bootstrapValidator({
    	message: 'This value is not valid',
    	fields: {
    		roleName: {
                validators: {
                    notEmpty: {
                        message: '角色名称不能为空'
                    },
                    stringLength: {
                           max: 10,
                           message: '角色名称长度不能大于10位'
                    }
                }
            },
            roleDesc: {
                validators: {
                    stringLength: {
                           max: 300,
                           message: '角色描述长度不能大于300位'
                    }
                }
            },
            roleCode: {
                validators: {
                    notEmpty: {
                        message: '角色编码不能为空'
                    },
                    stringLength: {
                           max: 4,
                           message: '角色编码长度不能大于4位'
                    },
                    regexp: {
                        regexp: /^[A-Z]+$/,
                        message: '只能输入由26个大写英文字母组成的编码'
                    }
                }
            },
    	}
    });
});	
	
$().ready(function(){
	var menuCodeList = '${menuCodeList}';
	var dateArray = eval("("+menuCodeList+")");
	for(var j=0;j<dateArray.length;j++){
		var menuCode = dateArray[j];
		var x = document.getElementsByClassName(menuCode+"_code");
 		var index = 0;
 		for(var i=0;i<x.length;i++)
 		{
			if(x[i].checked){
				index ++;
 			}
 		} 
 		if(index == x.length){
			$("."+menuCode).prop("checked",true);
		}
	}
});

function changeColor(btnId){
	var oldClass=$("#"+btnId+"_id").attr("class");
	if(oldClass.indexOf("success") > 0){
		$("#"+btnId+"_id").attr("class","btn btn-default data-btn");
	}else{
		$("#"+btnId+"_id").attr("class","btn btn-success data-btn");
	}
}
function update(){
	$('#roleForm').data('bootstrapValidator').resetForm();
	$('#roleForm').data('bootstrapValidator').validate();  
    if(!$('#roleForm').data('bootstrapValidator').isValid()){  
        return ;  
    }
	
	if($('input[name="attributeIds"]:checked').length==0){
		window.top.warning("功能权限必须选择！");
		return;
	}
	var dataId=[];
	$(".data-btn").each(function(){
		if($(this).attr("class").indexOf("success") > 0){
			dataId.push($(this).attr("dataId"));
		}
	});
	if(dataId.length==0){
		window.top.warning("数据权限必须选择！");
		return;
	}
	if(dataId.length>1){
		window.top.warning("只能选择一个数据权限");
		return;
	}
	var formData = new FormData($('form')[1]);
	formData.append("dataIds",dataId);
	 $.ajax({
	    	url:"<%=request.getContextPath()%>/admin/role/roleUpdate.ajax",
	        type: 'POST',
	        xhr: function() {  // custom xhr
	            myXhr = $.ajaxSettings.xhr();
	            return myXhr;
	        },
	        success:function(){
	        	window.location.href="<%=request.getContextPath()%>/admin/role/roleManage.do";
	        },
	        data: formData,
	        cache: false,
	        contentType: false,
	        processData: false
	    });
}
function checkBox(menuCode,obj){
	if($(obj).prop("checked")){
		$("."+menuCode+"_code").prop("checked",true);
	}else{
		$("."+menuCode+"_code").prop("checked",false);
	}
}
function checkAll(menuCode,obj){
	var x = document.getElementsByClassName(menuCode+"_code");
	var index = 0;
	for(var i=0;i<x.length;i++)
	{
		if(x[i].checked){
			index ++;
		}
	} 
	if(index == x.length){
		$("."+menuCode).prop("checked",true);
	}else{
		$("."+menuCode).prop("checked",false);
	}
}
function back(){
	window.location.href="<%=request.getContextPath()%>/admin/role/roleManage.do";
}
</script>
<link rel="stylesheet" type="text/css" href="css/rcms.css">
<style type="text/css">
.myClass{
    padding-left: 30px;
    border-left: 1px solid #817d7d;
}
</style>
</head>

<body class="hold-transition skin-blue sidebar-mini" >
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
              <h3 class="box-title">修改角色</h3>

              <!-- <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div> -->
            </div>
          <div class="box box-info form-horizontal">
          </div>
            <div class="box-body">
           		<form action="" method="post" id="roleForm">
	              <div class="form-group">
	              	<div class="col-md-12">
	              		<label class="col-sm-2 control-label" for="roleName">角色名称<span id="star">&nbsp;&nbsp;*</span>&nbsp;&nbsp;:</label>
		                <div class="col-sm-3">
		                	<input type="text" class="form-control" id="roleName" name="roleName" value="${authRoleBo.roleName}" />
		                	<input id="roleId" name="roleId" value="${authRoleBo.roleId}" hidden="hidden"/>
		                </div>
		                <label class="col-sm-2 control-label" for="roleDesc">角色描述&nbsp;&nbsp;:</label>
		                <div class="col-sm-5">
		                	<textarea type="text" class="form-control" id="roleDesc" name="roleDesc" >${authRoleBo.roleDesc}</textarea>
		                </div>
	              	</div>
	              </div>
	              <%-- <div class="form-group">
	              	<div class="col-md-12">
		                <label class="col-sm-2 control-label" for="roleDesc">角色描述：</label>
		                <div class="col-sm-5">
		                	<textarea type="text" class="form-control" id="roleDesc" name="roleDesc" >${authRoleBo.roleDesc}</textarea>
		                </div>
	              	</div>
	              </div> --%>
	              <hr>
	              <div class="form-group" align="center">
	              	<h4 align="center">功能权限</h4>
	              	<div class="col-md-12" align="center">
	              		<div class="row" style="margin-top:10px">
	              		<c:forEach items="${attrList}" var="menuList"  varStatus="status">
	              			<c:set var="ss" value="${(status.index+1)%4 eq 0}"></c:set>
	              			
	              			<div class="col-md-1">&nbsp;</div>
		              		<div class="col-md-2" align="left" style="margin-top:10px !important">
		              		<label class="checkbox" menuCode="${menuList.menuCode}">${menuList.menuName}</label>
			              		<div class="myClass">
				              		<label class="checkbox">
										<input type="checkbox" class="${menuList.menuCode}"  onclick="checkBox('${menuList.menuCode}',this)">全选
									</label>
									
			              			<c:forEach items="${menuList.attrList}" var="action">
			              			<c:set var="str" value=",${action.attributeId},"></c:set>
					              		<label class="checkbox">
										  <input type="checkbox" onclick="checkAll('${menuList.menuCode}',this)" class="${menuList.menuCode}_code"
										  name="attributeIds" value="${action.attributeId}"
										  	<c:choose> 
									            <c:when test="${fn:contains(containAttr,str)}">checked="true" </c:when> 
									            <c:otherwise></c:otherwise> 
											</c:choose>
										  >
										  ${action.title}
										</label>
			              			</c:forEach>
			              		</div>
		              		</div>
	              			<c:if test="${ss}">
	              				</div>
	              				<div class="row" style="margin-top:10px">
	              			</c:if>
	              		</c:forEach>
	              		</div>
	              	</div>
	              </div>
	              <hr>
	              <div class="form-group">
	              	<h4 align="center">数据权限</h4>
	              	<div class="row" >&nbsp;</div>
	           		<div class="col-md-12" align="center">
						<c:forEach items="${dataList}" var="data" >
						<c:set var="str2" value=",${data.dataId},"></c:set>
							<button type="button"  
								<c:choose> 
						            <c:when test="${fn:contains(containData,str2)}">class="btn btn-success data-btn"</c:when> 
						            <c:otherwise>class="btn btn-default data-btn"</c:otherwise> 
								</c:choose>
							onclick="changeColor('${data.dataId}')" 
							dataId="${data.dataId}" 
							id="${data.dataId}_id">${data.dataName}</button>
						</c:forEach>
					</div>
	              </div>
              </form>
              <div class="row">&nbsp;</div>
				<div class="row">
	              	<div class="col-md-12" align="center">
	              		<div class="col-md-12" align="center">
	              		<button type="button" class="btn btn-success btn-sm" onclick="update()">保存
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="back()">返回
						</button>
	              	</div>
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

</div>

</body>
</html>