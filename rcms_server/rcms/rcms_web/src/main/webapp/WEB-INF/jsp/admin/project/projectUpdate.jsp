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
  <link rel="stylesheet" href="<%=request.getContextPath()%>/selectpage/css/selectpage.css" type="text/css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/selectpage/css/selectpage.base.css" type="text/css">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/selectpage/css/selectpage.bootstrap3.css" type="text/css">
  <!--js 样式文件引入-->
  <script src="<%=request.getContextPath()%>/selectpage/js/selectpage.js" type="text/javascript"></script>
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
  
<script type="text/javascript">
$(function(){
	$('#pmId').selectPage({
	    showField : 'userName',
	    keyField : 'userId',
	    data : ${pmList},
	    eAjaxSuccess : function(d){
	        var result = new Object();
	        if(d){
	        	result.list = d.RSP_BODY.Data.list;
	        	result.totalRow = d.RSP_BODY.Data.totalRow;
	        }else{
	        	result = undefined;
	        }
	        return result;
	    }
	});
	
	$('#busId').selectPage({
	    showField : 'userName',
	    keyField : 'userId',
	    data : ${busList},
	    eAjaxSuccess : function(d){
	        var result = new Object();
	        if(d){
	        	result.list = d.RSP_BODY.Data.list;
	        	result.totalRow = d.RSP_BODY.Data.totalRow;
	        }else{
	        	result = undefined;
	        }
	        return result;
	    }
	});
	
	initDeptTree();
	$("#projectForm").bootstrapValidator({
    	message: 'This value is not valid',
    	fields: {
    		projName: {
                validators: {
                    notEmpty: {
                        message: '项目名称不能为空'
                    },
                    stringLength: {
                           max: 20,
                           message: '项目名称长度不能超过20位'
                       }
                }
            },
            projShName: {
                validators: {
                    notEmpty: {
                        message: '项目英文名称不能为空'
                    },
                    stringLength: {
                           max: 20,
                           message: '项目英文名称不能大于20位'
                       },
                       regexp: {
                           regexp: /^[a-zA-Z]+$/,
                           message: '项目英文名称只能为字母'
                       }
                }
            },
            deptName: {
                validators: {
                    notEmpty: {
                        message: '部门不能为空'
                    }
               }
            },
            projLevel: {
                validators: {
                    notEmpty: {
                        message: '项目级别不能为空'
                    }
               }
            },
            budgetSource: {
                validators: {
                    stringLength: {
                           max: 10,
                           message: '预算出处长度不能超过10位'
                       }
                }
            },
            remark: {
                validators: {
                    stringLength: {
                           max: 9,
                           message: '项目规模长度不能大于9位'
                       },
                       regexp: {
                           regexp: /^[1-9]*[1-9][0-9]*$/,
                           message: '必须为正整数'
                       }
                }
            },
            workload: {
                validators: {
                	notEmpty: {
                        message: '工作量估算不能为空'
                    },
                	stringLength: {
                           max: 11,
                           message: '工作量估算长度不能大于11位'
                       },
                       regexp: {
                    	   regexp:/^([1-9][0-9]{0,7}|0)([.][0-9]{1,2})?$/ ,
                           message: '成本估算小数点之前不能超过8位,小数点之后不能超过两位'
                       }
                }
            },
            expCost: {
                validators: {
                	notEmpty: {
                        message: '成本估算不能为空'
                    },  
                	regexp: {
                    	regexp:/^([1-9][0-9]{0,7}|0)([.][0-9]{1,2})?$/,
                        message: '成本估算小数点之前不能超过8位,小数点之后不能超过两位'
                    }
                }
            },
            projectExp: {
                validators: {
                    stringLength: {
                           max: 33,
                           message: '项目目标长度不能超过33位'
                       }
                }
            },
            deliveryDesc: {
                validators: {
                    stringLength: {
                           max: 33,
                           message: '交付物长度不能超过33位'
                       }
                }
            },
            feasibilityReport: {
                validators: {
                    stringLength: {
                           max: 33,
                           message: '可行性验证情况长度不能超过33位'
                       }
                }
            },
            includeTech: {
                validators: {
                    stringLength: {
                           max: 33,
                           message: '采用技术长度不能超过33位'
                       }
                }
            },
            riskDesc: {
                validators: {
                    stringLength: {
                           max: 33,
                           message: '主要风险描述长度不能超过33位'
                       }
                }
            },
            expSaleAmount: {
                validators: {
                	regexp: {
                        regexp:/^[1-9][0-9]{0,7}([.][0-9]{1,2})?$/ ,
                        message: '预计销售金额整数部分长度不能超过8位,保留两位小数'
                    }
                }
            },
            clientNames: {
                validators: {
                    stringLength: {
                           max: 33,
                           message: '客户名称长度不能超过33位'
                       }
                }
            },
            projDesc: {
                validators: {
                    stringLength: {
                           max: 33,
                           message: '项目描述长度不能超过33位'
                       }
                }
            },
            expStartDate: {
                validators: {
                    callback:{
                   	 message: '项目计划开始日期需小于项目计划结束日期！！',
                   	 callback:function(value, validator) {
	                    	var startTime = $("#expStartDate").val();
	                    	var endTime = $("#expEndDate").val();
	                    	
	                    	if (''!=endTime&&''!=startTime&&endTime <= startTime) {
	                    		return false;
	                    	}else{
	                    		return true;
	                    	}
                   	 }
                   }
                }
            },
            expEndDate: {
                validators: {
                    callback:{
                   	 message: '项目计划开始日期需小于项目计划结束日期！！',
                   	 callback:function(value, validator) {
	                    	var startTime = $("#expStartDate").val();
	                    	var endTime = $("#expEndDate").val();
	                    	
	                    	if (''!=endTime&&''!=startTime&&endTime <= startTime) {
	                    		return false;
	                    	}else{
	                    		return true;
	                    	}
                   	 }
                   }
                }
            },
            relStartDate: {
                validators: {
                    callback:{
                   	 message: '项目实际开始日期需小于项目实际结束日期！！',
                   	 callback:function(value, validator) {
	                    	var startTime = $("#relStartDate").val();
	                    	var endTime = $("#relEndDate").val();
	                    	
	                    	if (''!=endTime&&''!=startTime&&endTime <= startTime) {
	                    		return false;
	                    	}else{
	                    		return true;
	                    	}
                   	 }
                   }
                }
            },
            relEndDate: {
                validators: {
                    callback:{
                   	 message: '项目实际开始日期需小于项目实际结束日期！！',
                   	 callback:function(value, validator) {
	                    	var startTime = $("#relStartDate").val();
	                    	var endTime = $("#relEndDate").val();
	                    	
	                    	if (''!=endTime&&''!=startTime&&endTime <= startTime) {
	                    		return false;
	                    	}else{
	                    		return true;
	                    	}
                   	 }
                   }
                }
            },
            
    		
    	}
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
/* 树点击后执行的方法 */
 function queryDept(treeNode){
	
 	//alert(treeNode.name+treeNode.dataId+treeNode.parentId);
	$("#deptName").val(treeNode.name);
	$("#deptId").val(treeNode.dataId);
	$("#deptModel").modal('hide');
 }



function chooseDept(){
	$("#deptModel").modal('show');
}

/*保存修改数据 */
function update() {
	$('#projectForm').data('bootstrapValidator').resetForm();
	$('#projectForm').data('bootstrapValidator').validate();  
    if(!$('#projectForm').data('bootstrapValidator').isValid()){  
        return ;  
    }
    if($("#pmId").val() == ""){
    	warning("项目经理不能为空");
    	return;
    }
	var url ="<%=request.getContextPath()%>/admin/project/projectUpdate.ajax";
	$.ajax({
		type:"post",
		url:url,
		data:$('#projectForm').serialize(),
		success:function(data){
			window.top.warning("修改成功");
			window.location.href="<%=request.getContextPath()%>/admin/project/project.do";
			
		},error:function(data){
			
		}
	});
}
function back(){
	window.history.go(-1);
}
$(document).ready(function(){
	//限制字符个数
	$("#deptName").each(function(){
	var maxwidth=9;
		if($(this).val().length>maxwidth){		
			$(this).val($(this).val().substring(0,maxwidth));
			$(this).val($(this).val()+"...");
		}
	});
});
</script>
</head>
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
              <h3 class="box-title">修改项目</h3>
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
		            <form action="" id="projectForm" class="form-horizontal">
			            <div class="col-sm-11" >
			            	
							</div>
							<div class="form-group">
					             <label class="col-sm-2 control-label" for="projName">项目名称&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projName" name="projName" value="${project.projName }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="projShName">项目英文名称&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projShName" name="projShName" value="${project.projShName }" />
					             </div>
					             <label class="col-sm-2 control-label" for="projCode">项目编码&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projCode" name="projCode" value="${project.projCode }" />
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="applyDate">申请日期&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="applyDate" name="applyDate" value="<fmt:formatDate value='${project.applyDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" />
					             </div>
								
					             <label class="col-sm-2 control-label" for="deptName">部门名称&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control overflowH" title="${project.dirName}" id="deptName" name="deptName" value="${project.dirName }"  onclick="chooseDept()" />
					             	<input type="text"  id="deptId" name="deptId" value="${project.deptId }" hidden="hidden" />
					             </div>
					             
					             <label class="col-sm-2 control-label" for="budgetSource">预算出处&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="budgetSource" name="budgetSource" value="${project.budgetSource }" />
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="projType">项目类型&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             <c:set  var="projTypeid" value="${project.projType}" scope="request"/>
					             	 <select class="form-control" name="projType" id="projType">
	                                 	<c:forEach var="type" items="${projectTypeList}">
	                                    	<option value="${type.typeCode}" <c:if test="${type.typeCode==projTypeid}">selected</c:if>>${type.typeName}</option>
	                                    </c:forEach>
	                                 </select>
					             </div>
								<input type="hidden" class="form-control" id="status" name="status" value="01"/>
					             <label class="col-sm-2 control-label" for="projLevel">项目级别&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             <c:set  var="projLevelid" value="${project.projLevel}" scope="request"/>
					             	 <select class="form-control" name="projLevel" id="projLevel" value="${project.projLevel }">
	                                 	<c:forEach var="levelId" items="${levelBoList}">
	                                    	<option value="${levelId.levelId}" <c:if test="${levelId.levelId==projLevelid}">selected</c:if>>${levelId.levelName}</option>
	                                    </c:forEach>
	                                 </select>
					             </div>
					             
					             <label class="col-sm-2 control-label" for="pmId ">项目经理&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
						             <input type="text" class="form-control" id="pmId" name="pmId"  data-init="${project.pmId }"/>
					             </div>
					             
							</div>
							
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="remark">项目规模(人数)&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="remark" name="remark" value="${project.remark }"/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="urgentLevel">项目紧急程度&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					                <c:set  var="schoolid" value="${project.urgentLevel}" scope="request"/>
					             	<select class="form-control" name="urgentLevel" id="urgentLevel">
	                                 	<c:forEach var="urgent" items="${urgentBoList}">
	                                    	<option value="${urgent.urgentId}" <c:if test="${urgent.urgentId==schoolid}">selected</c:if> >${urgent.urgentName}</option>
	                                    </c:forEach>
	                                 </select>
					             </div>
					             <label class="col-sm-2 control-label" for="workload">工作量估算 (人月)&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="workload" name="workload" value="${project.workload }" />
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="expCost">成本估算(万)&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expCost" name="expCost" value="${project.expCost }"/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="projectExp">项目目标&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="projectExp" name="projectExp" value="${project.projectExp }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="deliveryDesc">交付物&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="deliveryDesc" name="deliveryDesc"  value="${project.deliveryDesc }"/>
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="feasibilityReport">可行性验证情况&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="feasibilityReport" name="feasibilityReport" value="${project.feasibilityReport }"/>
					             </div>
					             <label class="col-sm-2 control-label" for="includeTech">采用技术&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="includeTech" name="includeTech" value="${project.includeTech }" />
					             </div>
					             <label class="col-sm-2 control-label" for="clientNames">客户名称&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="clientNames" name="clientNames" value="${project.clientNames }"/>
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="expStartDate">项目计划开始时间&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expStartDate" name="expStartDate" value="<fmt:formatDate value='${project.expStartDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});"/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="expEndDate">项目计划结束时间&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expEndDate" name="expEndDate" value="<fmt:formatDate value='${project.expEndDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" />
					             </div>
					             <label class="col-sm-2 control-label" for="expSaleAmount ">预计销售金额&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="expSaleAmount" name="expSaleAmount" value="${project.expSaleAmount }" />
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="relStartDate">项目实际开始时间&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="relStartDate" name="relStartDate" value="<fmt:formatDate value='${project.relStartDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});"/>
					             </div>
								
					             <label class="col-sm-2 control-label" for="relEndDate">项目实际结束时间&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="relEndDate" name="relEndDate" value="<fmt:formatDate value='${project.relEndDate}' type='both' pattern='yyyy-MM-dd'/>"
					             	onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});"/>
					             </div>
					             
					             <label class="col-sm-2 control-label" for="busId">商务负责人&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="busId" name="busId"  data-init="${project.busId }"/>
					             </div>
					             
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="projDesc ">项目描述&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<textarea class="form-control" id="projDesc" name="projDesc">${project.projDesc }</textarea>
					             </div>
					             <label class="col-sm-2 control-label" for="riskDesc">主要风险描述&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<textarea class="form-control" id="riskDesc" name="riskDesc">${project.riskDesc }</textarea>
					             </div>
					             
					             <div>
					             <input type="hidden" class="form-control" id="pkProj" name="pkProj" value="${project.pkProj }"  />
					             
					             </div>
							</div>
						</div>
					</form>
				</div>
				
				<div class="row">
	              	<div class="col-md-12" align="center">
	              		<div class="col-md-12" align="center">
	              		<button type="button" class="btn btn-success btn-sm" onclick="update()" id="btnSave">保存
						</button>
						<button type="button" class="btn btn-danger btn-sm" onclick="back()">返回
						</button>
	              	</div>
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