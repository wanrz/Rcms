<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="../../common/head.jsp" %>
<%@include file="../../common/tree.jsp" %>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>RCMS</title>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
<script type="text/javascript">
$(function(){
	initDeptTree();
	
	$("#deptForm").bootstrapValidator({
    	message: 'This value is not valid',
    	fields: {
    		dirName: {
                validators: {
                    notEmpty: {
                        message: '用户姓名不能为空'
                    },
                    stringLength: {
                           max: 10,
                           message: '用户姓名长度不能大于10位'
                       }
                }
            },
            phone: {
                validators: {
                   
                    stringLength: {
                           max: 20,
                           message: '电话长度不能大于20位'
                       },
                       regexp: {
                           regexp:/(^(\d{3,4}-)\d{7,8})$|(1[0-9]{10}$)/,
                           message: '手机或电话格式不正确,请重新输入,座机格式例如"025-74512547"'
                       }
                }
            },
            email: {
                validators: {
                    
                    emailAddress: {
                        message: '邮箱地址格式有误'
                    } ,
                    stringLength: {
                        max: 50,
                        message: '邮箱长度不能大于50位'
                 }     
               }
            },
            memo: {
                validators: {
                    stringLength: {
                           max: 16,
                           message: '简介长度不能超过16位'
                       }
                }
            },
    		
    	}
	})
})

var treeThisNode = null;
/*****部门树初始化****/
function initDeptTree(){	
	var treeRootUrl = "<%=request.getContextPath()%>/admin/department/dirTree.ajax";
	$.beTree({
		treeId:"deptTree",
		treeRootUrl:treeRootUrl,
		onClick:queryDept,
		defaultSelectedNode:treeThisNode,
		notQueryAfterInit:false
	});
}
/* 树点击后执行的方法 */
function queryDept(treeNode){
	treeThisNode = treeNode;
	$("#hiddenDirId").val(treeNode.dataId);
	$("#hiddenDirSeq").val(treeNode.dirSeq);
	$("#dirId").val(treeNode.dataId);
	var dirId=treeNode.dataId;
	var url="<%=request.getContextPath()%>/admin/department/queryDept.ajax";
	$.ajax({
		type:"post",
		url:url,
		data:{"dirId":dirId},
		dataType: "json",
		success:function(data){
			var attrs = data.RSP_BODY.Data.authDir;
			$("#dirNameDept").html(attrs.dirName);
			$("#dirCodeDept").html(attrs.dirCode);
			$("#emailDept").html(attrs.email);
			$("#phoneDept").html(attrs.phone);
			$("#memoDept").html(attrs.memo);
		},error:function(msg){
			
		}
	});
}


function saveDept(){
	
	$('#deptForm').data('bootstrapValidator').resetForm();
	$('#deptForm').data('bootstrapValidator').validate();  
    if(!$('#deptForm').data('bootstrapValidator').isValid()){  
        return ;  
    }
	var sign=document.getElementById("deptAddBtn").value;
	var url="";
	   if(sign=="2"){
		   url="<%=request.getContextPath()%>/admin/department/deptUpdate.ajax";
	   }else{
		   url="<%=request.getContextPath()%>/admin/department/deptSave.ajax";
	   }
	
	var deq=document.getElementById("hiddenDirSeq").value;
	
	
	$("#dirSeq").val(deq);
	$.ajax({
		type:"post",
		url:url,
		data:$('#deptForm').serialize(),
		success:function(data){
			if(sign=="2"){
				var node = treeThisNode;
			}else{
				treeThisNode = null;
			}
			$("#myModal").modal('hide');
			initDeptTree();
			queryDept(node);
		},error:function(data){
			
		}
	});
}

function btnDelete(){
	 var dirId=document.getElementById("hiddenDirId").value;
	 var dirSeq = $("#hiddenDirSeq").val();
	 if(dirId==""||dirSeq==""){
		 window.top.warning("请选中需要删除的部门");
		 return;
	 }
	$("#deleteModal").modal('show');
}

function deleteThis(){
	 var dirId=document.getElementById("hiddenDirId").value;
	 var dirSeq = $("#hiddenDirSeq").val();
	 var url="<%=request.getContextPath()%>/admin/department/deptDelete.ajax";
		$.ajax({
			type:"post",
			url:url,
			data:{"dirId":dirId,"dirSeq":dirSeq},
			dataType: "json",
			success:function(data){
				window.top.warning("删除成功！");
				treeThisNode = null;
				initDeptTree();		
				$("#deleteModal").modal('hide');
				document.getElementById('dirNameDept').innerHTML="";
				document.getElementById('dirCodeDept').innerHTML="";
				document.getElementById('phoneDept').innerHTML="";
				document.getElementById('emailDept').innerHTML="";
				document.getElementById('memoDept').innerHTML="";
			},error:function(msg){
				$("#deleteModal").modal('hide');
			}
		});
}

function deptAdd(){
	document.getElementById("deptAddBtn").value="1";
	var dept=$("#hiddenDirId").val();
	$("#parentId").val(dept);
	if(dept==""){
		window.top.warning("请先选择上级部门");
		return;
	}
	$.ajax({
		type:"post",
		url:"<%=request.getContextPath()%>/admin/department/deptSeqCode.ajax",
		dataType: "json",
		success:function(data){
			var a = data.RSP_BODY.Data.userCodeSeq;
			$("#dirCode").val(a);
			$("#myModal").modal('show');
		}
	});
	
}
function deptUpdate(){
	var dirId=document.getElementById("hiddenDirId").value;
	if(dirId==""){
		window.top.warning("请选择需要修改的部门");
		return;
	}
	var url="<%=request.getContextPath()%>/admin/department/queryDept.ajax";
	$.ajax({
		type:"post",
		url:url,
		data:{"dirId":dirId},
		dataType: "json",
		success:function(data){
			var attrs = data.RSP_BODY.Data.authDir;
			$("#dirName").val(attrs.dirName);
			$("#dirCode").val(attrs.dirCode);
			$("#email").val(attrs.email);
			$("#phone").val(attrs.phone);
			$("#memo").val(attrs.memo);
			$("#parentId").val(attrs.parentId);
			$("#seq").val(attrs.seq);
			$("#myModal").modal('show');
		},error:function(msg){
			
		}
	});
	document.getElementById("deptAddBtn").value="2";
}

$(function () {
	$("#myModal").on('hide.bs.modal',function(){
		$("#deptForm").data('bootstrapValidator').resetForm();
		$("#deptForm")[0].reset();
	});
});
</script>
<link rel="stylesheet" type="text/css" href="css/rcms.css">
<style type="text/css">
	.leftLable{
		text-align:left !important;
		min-width: 180px;
	}
	.minWidth{
		min-width: 100px;
		text-align: right;
	}
</style>
</head>

<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/department/deptManage.do"/>
<c:set var="m_active_code" value="ToolBarBaseInfo"/>
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
              <h3 class="box-title">  部门管理</h3>



              <!-- <div class="box-tools pull-right">
                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
                </button>
                <div class="btn-group">
                  <button type="button" class="btn btn-box-tool dropdown-toggle" data-toggle="dropdown">
                    <i class="fa fa-wrench"></i></button>
                  <ul class="dropdown-menu" role="menu">
                    <li><a href="#">Action</a></li>
                    <li><a href="#">Another action</a></li>
                    <li><a href="#">Something else here</a></li>
                    <li class="divider"></li>
                    <li><a href="#">Separated link</a></li>
                  </ul>
                </div>
                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
              </div> -->
            </div>
          <div class="box box-info">
          </div>
           
            <div class="box-body">
            <input type="hidden" name="dirId" value=""  id="hiddenDirId">
             <input type="hidden" name="dirSeq" value=""  id="hiddenDirSeq">
              <div class="row">
              	<div class="col-md-4">
              		<ul id="deptTree" class="ztree" style="width:230px;overflow:auto;"></ul>
              	</div>
                <div class="col-md-8" >
                   <form action="" id="queryForm">
                       <div class="row">
              	           <div class="col-md-12 form-horizontal">
              	                <div class="col-sm-6">
              	                    <label class="col-sm-4 control-label minWidth" for="role_name">部门名称&nbsp;&nbsp;:</label>
	                             	<label class="col-sm-8 control-label leftLable"  id="dirNameDept" name="dirNameDept" />
	                            </div>
	                            <div class="col-sm-6">
              	                    <label class="col-sm-4 control-label minWidth" for="role_name">电话&nbsp;&nbsp;:</label>
	                             	<label class="col-sm-8 control-label leftLable"  id="phoneDept" name="phoneDept" />
	                            </div>
	                            
                           </div>
                        </div>
                        <div class="row">
              	           <div class="col-md-12 form-horizontal">
              	                <div class="col-sm-6">
	                                <label class="col-sm-4 control-label minWidth" for="desc">部门编码&nbsp;&nbsp;:</label>
	                	            <label class="col-sm-8 control-label leftLable"  id="dirCodeDept" name="dirCodeDept" />
	                            </div>
	                            <div class="col-sm-6">
	                                <label class="col-sm-4 control-label minWidth" for="desc">邮箱&nbsp;&nbsp;:</label>
	                	            <label class="col-sm-8 control-label leftLable"  id="emailDept" name="emailDept" />
	                            </div>
                           </div>
                        </div>
                        <div class="row">
              	           <div class="col-md-12 form-horizontal">
              	                <div class="col-sm-6">
	                                <label class="col-sm-4 control-label minWidth" for="memoDept">部门简介&nbsp;&nbsp;:</label>
	                	            <label class="col-sm-8 control-label leftLable"  id="memoDept" name="memoDept" />
	                            </div>
	                            
                           </div>
                        </div>
                      
                   </form>
                </div>
                               
              </div>
               
              <!-- /.row -->
              
            </div>
           
          
         
        </div>
         <div class="row" align="center">
              	<div class="col-md-12">
	              	<button type="button" class="btn btn-success btn-sm"  onclick="deptAdd()" data-backdrop="static" >
					  <span class="glyphicon glyphicon-plus " aria-hidden="true"><span class="my-operation" >新增</span></span>
					</button>
					<button type="button" class="btn btn-primary btn-sm"  onclick="deptUpdate()">
					  <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">修改</span></span>
					</button>
					<button type="button" class="btn btn-danger btn-sm" onclick="btnDelete()">
					  <span class="glyphicon glyphicon-trash" aria-hidden="true"><span class="my-operation" >删除</span></span>
					</button>
              		<div id="myTable"></div>
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
				
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="deptForm">
                     <div class="form-group">
                          <label for="inputEmail3" class="col-sm-3 control-label">部门名称<span id="star">&nbsp;&nbsp;*</span>&nbsp;&nbsp;:</label>
                            <div class="col-sm-6">
                                  <input type="text" class="form-control" name="dirName" id="dirName" >
                             </div>
                     </div>
                     <div class="form-group">
                           <label for="inputPassword3" class="col-sm-3 control-label">部门编码&nbsp;&nbsp;:</label>
                               <div class="col-sm-6">
                                    <input type="text" class="form-control" name="dirCode" id="dirCode"  readOnly >
                                </div>
                     </div>
                     <div class="form-group">
                           <label for="inputPassword3" class="col-sm-3 control-label">电话&nbsp;&nbsp;:</label>
                               <div class="col-sm-6">
                                    <input type="text" class="form-control" name="phone" id="phone" >
                                </div>
                     </div>
                     <div class="form-group">
                           <label for="inputPassword3" class="col-sm-3 control-label">邮箱&nbsp;&nbsp;:</label>
                               <div class="col-sm-6">
                                    <input type="text" class="form-control" name="email" id="email" >
                                </div>
                     </div>
                     <div class="form-group">
                           <label for="inputPassword3" class="col-sm-3 control-label">简介&nbsp;&nbsp;:</label>
                               <div class="col-sm-6">
                                    <input type="text" class="form-control" name="memo" id="memo" >
                                </div>
                     </div>
                     
                       <input type="hidden" id="dirSeq" name="dirSeq" value=" "/>
                       <input type="hidden" id="parentId" name="parentId" value="parentId"/>
                       <input type="hidden" id="dirId" name="dirId" value=" "/>
                 </form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="button" class="btn btn-primary" onclick="saveDept()" id="deptAddBtn" value=" ">
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
	            <div class="modal-body" align="center">是否确定删除部门</div>
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