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
	initFileInputByZh("importTask");
});

function ajaxFileUploadExcel(){
	$("#importBtn").attr("disabled",true);
	var formData = new FormData($('form')[1]);
	$.ajax({
		url:"<%=request.getContextPath()%>/admin/task/improtTask.ajax",
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
<c:set var="m_active" value="/admin/task/taskManage.do"/>
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
              <h3 class="box-title">任务分配</h3>
              
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
								  <input  name="importTask" id="importTask"  type="file" class="col-sm-6" data-show-preview="false" data-show-upload="false" 
								  	accept=".xls,.xlsx"	data-allowed-file-extensions='["xls","xlsx"]'>
							</div><span id="message"></span> 
							<div class="col-sm-3">&nbsp;</div> 
						</div>
						<br>
						<div class="row">              
							<div class="col-lg-3"></div> 
							<div class="col-lg-6 span7 text-center">  
								<button type="button" class="btn btn-primary" id="importBtn" onclick="ajaxFileUploadExcel()">导入</button>
								<input type="button" onclick="window.location.href='<%=request.getContextPath()%>/template/TaskTemplate.xls'" class="btn btn-default" value="下载模版">
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
							<div class="col-lg-3">
								<h4>EXCEL导入文件说明：</h4>
							</div><br>
							<div class="col-lg-3">
								<ol>
									<p>1.任务编码和任务名称不可重复；</p>
									<p>2.项目名称，任务编码，任务名称，任<br>&nbsp;&nbsp;务开始日期，任务结束日期，工作<br>&nbsp;&nbsp;量，任务状态和任务类型不能为空；</p>
									<p>3.填写项目名称时必须填写已存在项目<br>&nbsp;&nbsp;的项目名称；</p>
									<p>4.日期格式为yyyy/mm/dd,如：<br>&nbsp;&nbsp;1990/01/01；excel日期的格式请设置<br>&nbsp;&nbsp;为文本；</p>
								</ol>
							</div>
										
								<div class="col-lg-3"><h4>EXCEL导入文件格式样例：</h4>
									<div style="width:1200px">
										<table class="dataGrid_body table table-striped table-bordered dataTable" id="myBootDataGrid" cellspacing="0" cellpadding="0" border="0">
											<thead class="dataGrid_thead">
												<tr role="row">
													<th class="center" role="columnheader" tabindex="0" aria-controls="myBootDataGrid" rowspan="1" colspan="1" width="15%" valign="middle" align="center">项目名称</th>
													<th class="center" role="columnheader" tabindex="0" aria-controls="myBootDataGrid" rowspan="1" colspan="1" width="15%" valign="middle" align="center">任务编码</th>
													<th class="center" role="columnheader" tabindex="0" aria-controls="myBootDataGrid" rowspan="1" colspan="1" width="10%" valign="middle" align="center">任务名称</th>
													<th class="center" role="columnheader" tabindex="0" aria-controls="myBootDataGrid" rowspan="1" colspan="1" width="15%" valign="middle" align="center">任务开始日期</th>
													<th class="center" role="columnheader" tabindex="0" aria-controls="myBootDataGrid" rowspan="1" colspan="1" width="15%" valign="middle" align="center">任务结束日期</th>
													<th class="center" role="columnheader" tabindex="0" aria-controls="myBootDataGrid" rowspan="1" colspan="1" width="10%" valign="middle" align="center">工作量(天)</th>
													<th class="center" role="columnheader" tabindex="0" aria-controls="myBootDataGrid" rowspan="1" colspan="1" width="10%" valign="middle" align="center">任务状态</th>
													<th class="center" role="columnheader" tabindex="0" aria-controls="myBootDataGrid" rowspan="1" colspan="1" width="10%" valign="middle" align="center">任务类型</th>
												</tr>
											</thead>
											<tbody class="dataGrid_tbody" role="alert" aria-live="polite" aria-relevant="all">
												<tr class="gradeA even">
													<td class="center"  valign="middle" align="center">砾阳综合</td>
													<td class="center"  valign="middle" align="center">RENWU</td>
													<td class="center"  valign="middle" align="center">任务</td>
													<td class="center"  valign="middle" align="center">2017-04-05</td>
													<td class="center"  valign="middle" align="center">2017-04-25</td>
													<td class="center"  valign="middle" align="center">5</td>
													<td class="center"  valign="middle" align="center">未开始</td>
													<td class="center"  valign="middle" align="center">计划内</td>
												</tr>
												<tr class="gradeA even">
													<td class="center"  valign="middle" align="center">&nbsp;</td>
													<td class="center"  valign="middle" align="center">&nbsp;</td>
													<td class="center"  valign="middle" align="center">&nbsp;</td>
													<td class="center"  valign="middle" align="center">&nbsp;</td>
												</tr>
												<tr class="gradeA even">
													<td class="center"  valign="middle" align="center">&nbsp;</td>
													<td class="center"  valign="middle" align="center">&nbsp;</td>
													<td class="center"  valign="middle" align="center">&nbsp;</td>
													<td class="center"  valign="middle" align="center">&nbsp;</td>
												</tr>
												<tr class="gradeA even">
													<td class="center"  valign="middle" align="center">&nbsp;</td>
													<td class="center"  valign="middle" align="center">&nbsp;</td>
													<td class="center"  valign="middle" align="center">&nbsp;</td>
													<td class="center"  valign="middle" align="center">&nbsp;</td>
												</tr>
											</tbody>
										</table>
									</div>
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