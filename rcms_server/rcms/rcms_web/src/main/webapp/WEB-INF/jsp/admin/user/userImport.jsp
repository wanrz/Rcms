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
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<script type="text/javascript">
$(function () {
	//初始化导入
	initFileInputByZh("importUser");
});

function ajaxFileUploadExcel(){
	$("#importBtn").attr("disabled",true);
	var formData = new FormData($('form')[1]);
	$.ajax({
		url:"<%=request.getContextPath()%>/admin/user/improtUser.ajax",
		data: formData,
	    type: 'POST',
	    xhr: function() {  // custom xhr
	        myXhr = $.ajaxSettings.xhr();
	        return myXhr;
	    },
	    success:function(data){ //服务器响应成功时的处理函数
			var successMessag=data.RSP_BODY.Data.successMessag;
	   		window.top.warning("成功插入"+successMessag+"条任务");
	   		$("#importBtn").attr("disabled",false);
		},
		error:function(){
			$("#importBtn").attr("disabled",false);
		},
		contentType: false,

	    processData: false
	});
}

function backUp(){
	window.history.go(-1);
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
    <!-- Main content 在这里引入主要内容-->
    <section class="content"> 
    
    <div class="row">
        <div class="col-md-12">
          <div >
            <div class="box-header with-border">
              <h3 class="box-title">人员导入</h3>
              
              <div class="box-tools pull-right">
                
              </div>
            </div>
            <div class="box box-info">
            </div>
            <div class="box-body">
	            <div class="row">
					<form id="form1" enctype="multipart/form-data">
						<div class="row" >
							<div class="col-sm-3">&nbsp;</div>
							<div class="col-sm-6 span7 text-center"> 
								  <input  name="importUser" id="importUser"  type="file" class="col-sm-6" data-show-preview="false" data-show-upload="false" 
								  	accept=".xls,.xlsx"	data-allowed-file-extensions='["xls","xlsx"]'/>
							</div><span id="message"></span> 
							<div class="col-sm-3">&nbsp;</div> 
						</div>
						<br>
						<div class="row">              
							<div class="col-lg-3"></div> 
							<div class="col-lg-6 span7 text-center">  
								<button type="button" class="btn btn-primary" id="importBtn" onclick="ajaxFileUploadExcel()">导入</button>
								<input type="button" onclick="window.location.href='<%=request.getContextPath()%>/template/user.xlsx'" class="btn btn-default" value="下载模版">
								<button type="button" class="btn btn-default" onclick="backUp()">返回</button>
							</div>
							<div class="col-lg-3"></div> 
						</div>    
					</form>
				</div>
				<div class="row">&nbsp;</div>
	             <div class="row">
	            	<div class="col-md-12">
	            		<form action="">
							<div  class="table-responsive">
							<div class="col-lg-4">
								<h4>EXCEL导入文件说明：</h4>
							</div><br>
							<div class="col-lg-4">
								<ol>
									<p>1.工号不可重复；</p>
									<p>2.姓名，登录名，密码，工号不能为空；登录名设置<br>&nbsp;&nbsp;为与工号相同，密码统一设置123456，导入后员工<br>&nbsp;&nbsp;可自行修改</p>
									<p>3.部门不能为空，且必须与系统中保持一致</p>
									<p>4.日期格式为yyyy/mm/dd,如：1990/01/01；excel日<br>&nbsp;&nbsp;期的格式请设置为文本；并且如果为空，请去掉'--'，<br>&nbsp;&nbsp;保持空值</p>
								</ol>
							</div>
										
								<div class="col-lg-4"><h4>EXCEL导入文件格式样例：</h4>
								    <br/>
									<h2>导入文件格式请参考下载模板！</h2>
								</div>	
							</form>
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