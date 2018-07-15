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
  <meta content="width=device-wi.dth, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- 项目类型字典操作 -->
<script type="text/javascript">
/*  项目类型字典校验 */
$(function(){
	$("#typedictForm").bootstrapValidator({
    	message: 'This value is not valid',
    	fields: {
    		typeName: {
                validators: {
                    notEmpty: {
                        message: '项目类型名称不能为空'
                    },
                    stringLength: {
                           max: 10,
                           message: '项目类型名称长度不能超过10位'
                       }
                }
            },
            typeCode: {
                validators: {
                    notEmpty: {
                        message: '项目类型编码不能为空'
                    },
                   
                       regexp: {
                           regexp: /^[a-zA-Z0-9_]{3}$/,
                           message: '项目类型编码只能三位，且由字母，数字和下划线組成'
                       }
                }
            }
      
    	}
	})
}) 

/*  项目级别字典校验  */
$(function(){
	
	$("#leveldictForm").bootstrapValidator({
    	message: 'This value is not valid',
    	fields: {
    		levelName: {
                validators: {
                    notEmpty: {
                        message: '项目级别名称不能为空'
                    },
                    stringLength: {
                           max: 10,
                           message: '项目级别名称长度不能超过10位'
                       }
                }
            }
           
    	}
	})
}) 
/*  项目紧急程度字典校验   */
$(function(){
	$("#urgentdictForm").bootstrapValidator({
    	message: 'This value is not valid',
    	fields: {
    		urgentName: {
                validators: {
                    notEmpty: {
                        message: '项目紧急程度名称不能为空'
                    },
                    stringLength: {
                           max: 10,
                           message: '项目紧急程度名称长度不能超过10位'
                       }
                }
            }
           
    	}
	})
}) 

/*  员工合同类型字典校验 */
$(function(){
	
	$("#contractTypedictForm").bootstrapValidator({
    	message: 'This value is not valid',
    	fields: {
    		detailName: {
                validators: {
                    notEmpty: {
                        message: '员工合同类型不能为空'
                    },
                    stringLength: {
                           max: 33,
                           message: '员工合同类型长度不能超过33位'
                       }
                }
            },
            detailCode: {
                validators: {
                    notEmpty: {
                        message: '员工合同类型编码不能为空'
                    },
                    stringLength: {
                           max: 100,
                           message: '员工合同类型编码不能超过100位'
                       },
                       regexp: {
                           regexp: /^[a-zA-Z0-9_]{0,}$/,
                           message: '员工合同类型编码只能是字母，数字和下划线'
                       }
                }
            }
      
    	}
	})
}) 
/*  员工工资类别字典校验 */
$(function(){
	
	$("#employeeWagesTypedictForm").bootstrapValidator({
    	message: 'This value is not valid',
    	fields: {
    		detailName: {
                validators: {
                    notEmpty: {
                        message: '员工工资类别不能为空'
                    },
                    stringLength: {
                           max: 33,
                           message: '员工工资类别长度不能超过33位'
                       }
                }
            },
            detailCode: {
                validators: {
                    notEmpty: {
                        message: '员工工资类别编码不能为空'
                    },
                    stringLength: {
                           max: 100,
                           message: '员工工资类别编码不能超过100位'
                       },
                       regexp: {
                           regexp: /^[a-zA-Z0-9_]{0,}$/,
                           message: '员工工资类别编码只能是字母，数字和下划线'
                       }
                }
            }
      
    	}
	})
}) 
/*  员工类别字典校验 */
$(function(){
	
	$("#employeeTypedictForm").bootstrapValidator({
    	message: 'This value is not valid',
    	fields: {
    		detailName: {
                validators: {
                    notEmpty: {
                        message: '员类别不能为空'
                    },
                    stringLength: {
                           max: 33,
                           message: '员工类别长度不能超过33位'
                       }
                }
            },
            detailCode: {
                validators: {
                    notEmpty: {
                        message: '员工类别编码不能为空'
                    },
                    stringLength: {
                           max: 100,
                           message: '员工类别编码不能超过100位'
                       },
                       regexp: {
                           regexp: /^[a-zA-Z0-9_]{0,}$/,
                           message: '员工类别编码只能是字母，数字和下划线'
                       }
                }
            }
    	}
	})
}) 
$(function(){
	var dataHeader = [
	  				{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
	  				{"dataField":"","label":"序号","align":"center","valign":"middle"},
	  				{"dataField":"typeName","label":"项目类型","align":"center","valign":"middle"},
	  				{"dataField":"typeCode","label":"项目类型编码","align":"center","valign":"middle"},
	  				{"dataField":"flagView","label":"封存状态","align":"center","valign":"middle"}
	            	];
	$("#typeTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"proTypeDictList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/system/dictList.ajax",//请求数据地址（必须）
		limit:5,//表格显示行数，默认为10
		param:function(){
			var obj = new Object();
			obj.typeName = $("#dictType").val();
			return obj;
		},//请求参数，返回json对象（非必须）
		success:function(data){			
		},
		error:function(){
		}
	});
		$("#typeTable").loadData();
});	
</script>
<script type="text/javascript">
/*字典数据操作  */
function dictSave(){
	var update = "<%=request.getContextPath()%>/admin/system/dictUpdate.ajax";
	var add = "<%=request.getContextPath()%>/admin/system/proTypeDictAdd.ajax";
	saveCommon("type",update,add);
}
/* 新增操作  */
function typeaddDict(){
	 addDictCommen("type");
}
function checkUpdate(code){
	var selectItmes=$("#"+code+"Table").getSelectItems();
	if (!safeKeeping(code)) return;
	if (!dataLengthUnOne(code)) return;
	dictUpdate(code,selectItmes);
}
/* 更新操作 */

function dictUpdate(code,selectItmes){
	$("#"+code+"Modal").modal("show");
	$("#"+code+"dictAddBtn").val("2");
	/* 显示归档状态div */
	$("#"+code+"flagHiden").show();
	$("#"+code+"dictHiden").hide();
	$("#"+code+"SelectHiden").show();
	$("#"+code+"flag").attr("type", "text");
	$("#"+code+"Id").val(selectItmes[0][code+"Id"]);
	$("#"+code+"Name").val(selectItmes[0][code+"Name"]);
	$("#"+code+"Code").val(selectItmes[0].typeCode);
	$("#"+code+"flag").val(selectItmes[0][code+"flag"]);
	$("#"+code+"sel").val("1");
}	
/* 归档操作  */
 
/**类型封装**/
 
function typeBinning() {
	var url = "<%=request.getContextPath()%>/admin/system/binningTypeDictFlag.ajax";
	ajaxNning(url,"type","0");
}
function typeDevanning() {
	var url = "<%=request.getContextPath()%>/admin/system/devanningTypeDictFlag.ajax";
	ajaxNning(url,"type","1");
}
function levelBinning() {
	var url = "<%=request.getContextPath()%>/admin/system/binningLevelDictFlag.ajax";
	ajaxNning(url,"level","0");
}
function levelDevanning() {
	var url = "<%=request.getContextPath()%>/admin/system/devanningLevelDictFlag.ajax";
	ajaxNning(url,"level","1");
}
function urgentBinning() {
	var url = "<%=request.getContextPath()%>/admin/system/binningUrgentDictFlag.ajax";
	ajaxNning(url,"urgent","0");
}
function urgentDevanning() {
	var url = "<%=request.getContextPath()%>/admin/system/binningUrgentDictFlag.ajax";
	ajaxNning(url,"urgent","1");
}
function ajaxNning(url,code,flag) {
	var selectItmes=$("#"+code+"Table").getSelectItems();
	if (selectItmes.length==0) {
		window.top.warning("请选择数据");
		return;
	}
	var list = new Array();
	for (var i = 0; i < selectItmes.length; i++) {
		if (flag == "0" && selectItmes[i].flagView == "封存") continue;
		if (flag == "1" && selectItmes[i].flagView == "可用") continue;
		list.push(selectItmes[i][code+"Id"]);
	}
	if (list.length == 0) {
		var warn = flag == "0" ? "封存" : "解封";
		window.top.warning("数据为"+warn+"状态，不需要"+warn);
		return;
	}
	var Idlist = JSON.stringify(list);
	$.ajax({
		type:"post",
		url:url,
		data:{"list":Idlist,"flag":flag},
		success:function(data){
			$("#"+code+"Table").loadData();
		},error:function(msg){
		}
	});
}
function deleteDictById(code) {
	if (!dataLengthUnOne(code)) return;
	if (!safeKeeping(code)) return;
	$("#deleteModal").modal("show");
	$("#introductionGener").val(code);
}
function deleteThis() {
	$("#deleteModal").modal("hide");
	var code = $("#introductionGener").val();
	var selectItmes = $("#"+code+"Table").getSelectItems();
	if (code == "type") {
		var property = selectItmes[0].typeCode;
		var url = "<%=request.getContextPath()%>/admin/system/deleteTypeDictById.ajax";
	}else if (code == "level") {
		var property = selectItmes[0].levelId;
		var url = "<%=request.getContextPath()%>/admin/system/deleteLevelDictById.ajax";
	}else{
		var property = selectItmes[0].urgentId;
		var url = "<%=request.getContextPath()%>/admin/system/deleteUrgentDictById.ajax";
	}
	deleteDictData(code,url,property);
}
function deleteDictData(code,url,property) {
	$.ajax({
		type:"post",
		url:url,
		data:{"property":property},
		success:function(data){
			var row = data.RSP_BODY.Data.row;
			if (row != 0) {
				$("#"+code+"Table").loadData();
				window.top.warning("数据删除成功");
			}else{
				window.top.warning("数据正在使用无法删除");
			}
		},error:function(msg){
			
		}
	});
}
function safeKeeping(code) {
	var selectItmes = $("#"+code+"Table").getSelectItems();
	if (selectItmes[0].flagView=="封存") {
		window.top.warning("封存的数据无法操作，请解封");
		return false;
	}
	return true;
}
function dataLengthUnOne(code) {
	var selectItmes = $("#"+code+"Table").getSelectItems();
	var warn = selectItmes.length == 0 ? "请选择一条数据" : "只能选择一条数据";
	if(selectItmes.length != 1){
		window.top.warning(warn);
		return false;
	}
	return true;
}

</script>
<!--项目级别字典处理  -->
<script type="text/javascript">
$(function(){
	var dataHeader = [
	  				{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
	  				{"dataField":"","label":"序号","align":"center","valign":"middle"},
	  				{"dataField":"levelName","label":"项目级别","align":"center","valign":"middle"},
	  				{"dataField":"flagView","label":"封存状态","align":"center","valign":"middle"}
	  	];
	$("#levelTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"proLevelDictList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/system/proLevelDictList.ajax",//请求数据地址（必须）
		limit:5,//表格显示行数，默认为5
		pagination:true,//是否进行分页，默认true
		loadDataCallBack:chooseAllItems,
		success:function(data){			
		},
		error:function(){
		}
	});
		$("#levelTable").loadData();
});	
</script>
<script type="text/javascript">
/*字典数据操作  */
	function levelsave(){
		var update = "<%=request.getContextPath()%>/admin/system/proLevelDictUpdate.ajax";
		var add = "<%=request.getContextPath()%>/admin/system/proLevelDictAdd.ajax";
		saveCommon("level",update,add);
	}
/* 新增操作  */
function leveladdDict(){
	addDictCommen("level");
}
function addDictCommen(code) {
	$("#"+code+"dictForm").data("bootstrapValidator").resetForm();
	$("#"+code+"dictForm").data("bootstrapValidator").validate();  
    if(!$("#"+code+"dictForm").data("bootstrapValidator").isValid()) return;  
	$("#"+code+"dictAddBtn").val("1");
	$("#"+code+"dictHiden").hide();
	$("#"+code+"flagHiden").hide();
	$("#"+code+"SelectHiden").hide();
}
$(function() {
	var codeList = ["type","level","urgent","employeeWagesType","employeeType","contractType"];
	for (var i = 0; i < codeList.length; i++) {
		$("#"+codeList[i]+"Modal").bind("hide.bs.modal",{"code":codeList[i]},function(event){
			$("#"+event.data.code+"dictForm").data("bootstrapValidator").resetForm();
			$("#"+event.data.code+"dictForm")[0].reset();
		});
	}
})
function chooseAllItems() {
	$(".dataGrid_thead").find("input[type='checkbox']").attr("hidden","hidden");
}
function saveCommon(code,update,add) {
	$("#"+code+"dictForm").data("bootstrapValidator").resetForm();
	$("#"+code+"dictForm").data("bootstrapValidator").validate();  
    if(!$("#"+code+"dictForm").data("bootstrapValidator").isValid()) return;  
	var sign=$("#"+code+"dictAddBtn").val();
	var url = sign=="2" ? update : add;
    $.ajax({
		type:"post",
		url:url,
		data:$("#"+code+"dictForm").serialize(),
		success:function(data){
			$("#"+code+"Modal").modal("hide");//levelModal
			$("#"+code+"Table").loadData();
		},error:function(data){
			if(sign != "2") $("#"+code+"Modal").modal("hide");
		}
	});
}
</script>
<!-- 	有效数据结束 	-->
<!-- 项目紧急程度字典处理 -->
<script type="text/javascript">
$(function(){
	var dataHeader = [
	  				{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
	  				{"dataField":"","label":"序号","align":"center","valign":"middle"},
	  				{"dataField":"urgentName","label":"项目紧急程度","align":"center","valign":"middle"},
	  				{"dataField":"flagView","label":"封存状态","align":"center","valign":"middle"}
	  	];
	$("#urgentTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"proUrgentDictList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/system/urgentDictList.ajax",//请求数据地址（必须）
		drag:true,//表格是否可以拖动换行
		limit:5,//表格显示行数，默认为5
		pagination:true,//是否进行分页，默认true
		loadDataCallBack:chooseAllItems,
		success:function(data){			
		},
		error:function(){
		}
	});
		$("#urgentTable").loadData();
});	
</script>
<script type="text/javascript">
/*字典数据操作  */
function urgentsave(){
	var update = "<%=request.getContextPath()%>/admin/system/proUrgentDictUpdate.ajax";
	var add = "<%=request.getContextPath()%>/admin/system/proUrgentDictAdd.ajax";
	saveCommon("urgent",update,add);
}
/* 新增操作  */
function urgentaddDict(){
	addDictCommen("urgent");
}

$(function(){
	var dataHeader = [
	  				{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
	  				{"dataField":"","label":"序号","align":"center","valign":"middle"},
	  				{"dataField":"detailName","label":"员工合同类型","align":"center","valign":"middle"},
	  				{"dataField":"detailCode","label":"员工合同编码","align":"center","valign":"middle"},
	  				{"dataField":"flagView","label":"封存状态","align":"center","valign":"middle"}
	            	];
	$("#contractTypeTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"BdDictDetailList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/system/BdDictDetailList.ajax",//请求数据地址（必须）
		limit:5,//表格显示行数，默认为10
		param:function(){
			var obj = new Object();
			obj.pkDict = $("#contractType").val();
			return obj;
		},//请求参数，返回json对象（非必须）
		success:function(data){			
		},
		error:function(){
		}
	});
		$("#contractTypeTable").loadData();
});	
function contractTypesave(){
	var update = "<%=request.getContextPath()%>/admin/system/updateDbDictDetail.ajax";
	var add = "<%=request.getContextPath()%>/admin/system/bdDictDetailAdd.ajax";
	saveCommon("contract",update,add);
}
/* 新增操作  */
function addBdDictDetail(){
	addDictCommen("contractType");
}
/* 归档操作  */
function checkBdDictFlag(code){
	if (!dataLengthUnOne(code)) return;
	updateDbDictFlag(code,selectItmes)
}
function updateDbDictFlag(code,selectItmes){
		var pkDetail=(selectItmes[0].pkDetail);
		var url="<%=request.getContextPath()%>/admin/system/bdDictDetailFlag.ajax";
		$.ajax({
			type:"post",
			url:url,
			data:"pkDetail="+pkDetail,
			success:function(data){
				window.location.href="<%=request.getContextPath()%>/admin/system/dictManage.do"
			},error:function(msg){
			}
		});
}
function bdDictcheckUpdate(code){
	if (!dataLengthUnOne(code)) return;
	bddictUpdate(code,selectItmes)
}
/* 更新操作 */

function bddictUpdate(code,selectItmes){
	$("#"+code+"DictModal").modal("show");
	if(code=="contractType"){
		var tail = "0";
		var num = "2";
	}else if(code=="employeeType"){
		var tail = "1";
		var num = "1";
	}else if(code=="employeeWagesType"){
		var tail = "2";
		var num = "3";
	}
	$("#"+code+"dictAddBtn").val("2");
	$("#"+code+"SelectHiden").show();
	$("#detailName"+tail).val(selectItmes[0].detailName);
	$("#detailCode"+tail).val(selectItmes[0].detailCode);
	$("#pkDict"+tail).val(num);
	$("#pkDetail"+tail).val(selectItmes[0].pkDetail);
}	

/*人员类别字典  */
$(function(){
	var dataHeader = [
	  				{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
	  				{"dataField":"","label":"序号","align":"center","valign":"middle"},
	  				{"dataField":"detailName","label":"人员级别","align":"center","valign":"middle"},
	  				{"dataField":"detailCode","label":"人员级别编码","align":"center","valign":"middle"},
	  				{"dataField":"flagView","label":"封存状态","align":"center","valign":"middle"}
	  	];
	$("#employeeTypeTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"BdDictDetailList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/system/BdDictDetailList.ajax",//请求数据地址（必须）
		limit:5,//表格显示行数，默认为5
		pagination:true,//是否进行分页，默认true
		loadDataCallBack:chooseAllItems,
		param:function(){
			var obj = new Object();
			obj.pkDict = $("#employeeType").val();
			return obj;
		},//请求参数，返回json对象（非必须）
		success:function(data){			
		},
		error:function(){
		}
	});
		$("#employeeTypeTable").loadData();
});	

function employeeTypesave(){
	var update = "<%=request.getContextPath()%>/admin/system/updateDbDictDetail.ajax";
	var add = "<%=request.getContextPath()%>/admin/system/bdDictDetailAdd.ajax";
	saveCommon("employeeType",update,add);
}
/* 新增操作  */
function employeeTypeaddDict(){
	 $("#employeeTypepedictAddBtn").val("1");
	 $("#employeeTypeSelectHiden").hide();
	 
}
/*人员工资类别字典  */
$(function(){
	var dataHeader = [
	  				{"dataField":"","label":"checkbox","align":"center","valign":"middle"},
	  				{"dataField":"","label":"序号","align":"center","valign":"middle"},
	  				{"dataField":"detailName","label":"人员工资类别","align":"center","valign":"middle"},
	  				{"dataField":"detailCode","label":"人员工资类别编码","align":"center","valign":"middle"},
	  				{"dataField":"flagView","label":"封存状态","align":"center","valign":"middle"}
	  	];
	$("#employeeWagesTypeTable").createTable({
		dataHeader:dataHeader,//数组，每列的属性（必须）
		caption:"",//表格标题内容（非必须）
		root:"BdDictDetailList",//返回数据的key（必须）
		url:"<%=request.getContextPath()%>/admin/system/BdDictDetailList.ajax",//请求数据地址（必须）
		limit:5,//表格显示行数，默认为5
		pagination:true,//是否进行分页，默认true
		loadDataCallBack:chooseAllItems,
		param:function(){
			var obj = new Object();
			obj.pkDict = $("#employeeWagesType").val();
			return obj;
		},//请求参数，返回json对象（非必须）
		success:function(data){			
		},
		error:function(){
		}
	});
		$("#employeeWagesTypeTable").loadData();
});	
/* 字典保存 */
function employeeWagesTypesave(){
	var update = "<%=request.getContextPath()%>/admin/system/updateDbDictDetail.ajax";
	var add = "<%=request.getContextPath()%>/admin/system/bdDictDetailAdd.ajax";
	saveCommon("employeeWagesType",update,add);
}

/* 新增操作  */
function employeeWagesTypeaddDict(){
	addDictCommen("employeeWagesType")
}
</script>
<style type="text/css">
	.warning-dialog{
		position: absolute;
		top: 20%;
	}
	#deleteModal{
		position: fixed;
		top: 15%;
	}
</style>
<link rel="stylesheet" type="text/css" href="css/rcms.css">
</head>
<body class="hold-transition skin-blue sidebar-mini">
<c:set var="m_active" value="/admin/system/dictManage.do"/>
<c:set var="m_active_code" value="ToolBarSysManage"/>
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
		              <h3 class="box-title">项目类型字典管理</h3>
		              <div class="box-tools pull-right">
		                
		              </div>
		            </div>
		            <div class="box box-info">
                      </div>
				    <div class="box-body">
			          <div class="row">
				          <form action="" id="userForm" class="form-horizontal">
							<div class="searchBox" >
							</div>
						  </form>
					  </div>
					  <div class="row">&nbsp;</div>
					  <div class="row">
		              	<div class="col-md-12" >
			              	<button type="button" class="btn btn-success btn-sm" onclick="typeaddDict()"  data-toggle="modal" data-target="#typeModal">
						 		 <span class="glyphicon glyphicon-plus " aria-hidden="true"><span class="my-operation">新增</span></span>
							</button>
							<button type="button" class="btn btn-danger btn-sm" onclick="deleteDictById('type')">
							       <span class="glyphicon glyphicon-trash" aria-hidden="true"><span class="my-operation">删除</span></span>
							</button>
							<button type="button" class="btn btn-primary btn-sm"  onclick="checkUpdate('type')">
						  		 <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">修改</span></span>
							</button>
							<button type="button" class="btn btn-primary btn-sm" onclick="typeBinning()">
							 	  <span class="glyphicon glyphicon-save" aria-hidden="true"><span class="my-operation">封存</span></span>
							</button>
							<button type="button" class="btn btn-primary btn-sm" onclick="typeDevanning()">
							 	  <span class="glyphicon glyphicon-open" aria-hidden="true"><span class="my-operation">解封</span></span>
							</button>
		              	</div>
	                  </div>
				      <div class="row">
					    <div class="col-md-12">
					      <div id="typeTable"></div>
				          <!-- 模态框开始 -->
				          <div class="modal fade" id="typeModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					        <div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
											&times;
										</button>
									</div>
									<div class="modal-body" >
										<form class="form-horizontal" id="typedictForm">
						                     <div class="form-group">
						                          <label for="inputEmail3" class="col-sm-5 control-label">项目类型<span id="star">&nbsp;&nbsp;*</span>&nbsp;&nbsp;:</label>
						                             <div class="col-sm-4">
						                                  <input type="text" class="form-control" name="typeName" id="typeName" >
						                             </div>
						                     </div> 
						                     <div class="form-group">
						                          <label for="inputEmail3" class="col-sm-5 control-label">项目类型编码<span id="star">&nbsp;&nbsp;*</span>&nbsp;&nbsp;:</label>
						                            <div class="col-sm-4">
						                                  <input type="text" class="form-control" name="typeCode" id="typeCode" >
						                                  <input type="hidden" class="form-control" name="flag" id="typesel" value="1">
						                             </div>
						                     </div>
						                      <!-- 下拉框弹出flag -->
						                     <!-- <div class="form-group" id="typeselectHiden">
						                           <label for="inputPassword3" class="col-sm-5 control-label">封存状态：</label>
						                               <div class="col-sm-4">
						                                    <select class="form-control" id="sel"  name="flag">
															  <option value="1">可用</option>
															  <option value="0">封存</option>
															</select>
						                               </div>
						                     </div> -->
						                     <!-- 下拉框弹出flag结束 -->
						                     <div class="form-group" id="typedictHiden">
						                           <label for="inputPassword3" class="col-sm-5 control-label">字典主键</label>
					                               <div class="col-sm-4">
					                                    <input class="form-control" value="" name="typeId" id="typeId">
					                               </div>
						                     </div>
									    </form>
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
										<button type="button" class="btn btn-primary" onclick="dictSave()" id="typedictAddBtn" value=" ">保存</button>
										
								
								    </div>
								</div><!-- /.modal-content -->
							</div><!-- /.modal -->
						  </div>
				   		  <!-- 模态框结束 --> 
					    </div>
				    </div>
				   </div>
		         </div>
		         <!-- 项目级别字典管理 -->
		         
		         <div >
		            <div class="box-header with-border">
		              <h3 class="box-title">项目级别字典管理</h3>
		              <div class="box-tools pull-right">
		                
		              </div>
		            </div>
		            <div class="box box-info">
                    </div>
		            <div class="box-body">
			            <div class="row">
				            <form action="" id="userForm" class="form-horizontal">
								<div class="searchBox" >
								</div>
							</form>
						</div>
						<div class="row">&nbsp;</div>
						<div class="row">
			              	<div class="col-md-12" >
				              	<button type="button" class="btn btn-success btn-sm" onclick="leveladdDict()"  data-toggle="modal" data-target="#levelModal">
							 		 <span class="glyphicon glyphicon-plus " aria-hidden="true"><span class="my-operation">新增</span></span>
								</button>
								<button type="button" class="btn btn-danger btn-sm" onclick="deleteDictById('level')">
							       <span class="glyphicon glyphicon-trash" aria-hidden="true"><span class="my-operation">删除</span></span>
							    </button> 
								<button type="button" class="btn btn-primary btn-sm"  onclick="checkUpdate('level')">
							 		 <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">修改</span></span>
								</button>
								<button type="button" class="btn btn-primary btn-sm" onclick="levelBinning()">
								  	<span class="glyphicon glyphicon-save" aria-hidden="true"><span class="my-operation">封存</span></span>
								</button>
								<button type="button" class="btn btn-primary btn-sm" onclick="levelDevanning()">
								  	<span class="glyphicon glyphicon-open" aria-hidden="true"><span class="my-operation">解封</span></span>
								</button>
			              	</div>
		                </div>
			            <div class="row">
			            	<div class="col-md-12">
			            		<div id="levelTable"></div>      		
		                        <!-- 模态框开始 -->
							    <div class="modal fade" id="levelModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								   <div class="modal-dialog">
								     <div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
												&times;
											</button>
										</div>
										<div class="modal-body" >
											<form class="form-horizontal" id="leveldictForm">
							                     <div class="form-group">
							                          <label for="inputEmail3" class="col-sm-5 control-label">项目级别<span id="star">&nbsp;&nbsp;*</span>&nbsp;&nbsp;:</label>
							                            <div class="col-sm-4">
							                                  <input type="text" class="form-control" name="levelName" id="levelName" >
							                                  <input type="hidden" class="form-control" name="flag" id="levelsel" >
							                             </div>
							                     </div>
							                      <!-- 下拉框弹出flag -->
							                    <!--  <div class="form-group" id="levelSelectHiden">
							                         <label for="inputPassword3" class="col-sm-5 control-label">封存状态：</label>
						                                <div class="col-sm-4">
						                                    <select class="form-control" id="levelsel"  name="flag">
															  <option value="1">可用</option>
															  <option value="0">封存</option>
															</select>
						                                </div>
							                     </div> -->
							                     <!-- 下拉框弹出flag结束 -->
							                     <div class="form-group" id="leveldictHiden">
							                         <label for="inputPassword3" class="col-sm-5 control-label">字典主键</label>
					                                 <div class="col-sm-4">
					                                    <input class="form-control" value="" name="levelId" id="levelId">
					                                 </div>
							                     </div>
										    </form>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
											<button type="button" class="btn btn-primary" onclick="levelsave()" id="leveldictAddBtn" value=" ">保存
										</button>
									    </div>
									 </div><!-- /.modal-content -->
								  </div><!-- /.modal -->
							    </div>
		                        <!-- 模态框结束 --> 
			            	</div>
			            </div>
		            </div>
		         </div>
		         <!-- 项目级别字典管理结束 -->
		         <!-- 项目紧急程度字典管理 -->
		          <div >
			            <div class="box-header with-border">
				              <h3 class="box-title">项目紧急程度字典管理</h3>
				              <div class="box-tools pull-right">
					               
				              </div>
			            </div>
			            <div class="box box-info">
                        </div>
		            <div class="box-body">
			            <div class="row">
				            <form action="" id="userForm" class="form-horizontal">
								<div class="searchBox" >
								</div>
							</form>
						</div>
						<div class="row">&nbsp;</div>
						<div class="row">
			              	<div class="col-md-12" >
				              	<button type="button" class="btn btn-success btn-sm" onclick="urgentaddDict()"  data-toggle="modal" data-target="#urgentModal">
							       <span class="glyphicon glyphicon-plus " aria-hidden="true"><span class="my-operation">新增</span></span>
							    </button>
							    <button type="button" class="btn btn-danger btn-sm" onclick="deleteDictById('urgent')">
							       <span class="glyphicon glyphicon-trash" aria-hidden="true"><span class="my-operation">删除</span></span>
							    </button>
							    <button type="button" class="btn btn-primary btn-sm" onclick="checkUpdate('urgent')">
							       <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">修改</span></span>
							    </button>
								<button type="button" class="btn btn-primary btn-sm" onclick="urgentBinning()">
								   <span class="glyphicon glyphicon-save" aria-hidden="true"><span class="my-operation">封存</span></span>
								</button>
								<button type="button" class="btn btn-primary btn-sm" onclick="urgentDevanning()">
								   <span class="glyphicon glyphicon-open" aria-hidden="true"><span class="my-operation">解封</span></span>
								</button>
			              	</div>
		                </div>
					    <div class="row">
						  <div class="col-md-12">
						    <div id="urgentTable"></div>
					        <!-- 模态框开始 -->
					        <div class="modal fade" id="urgentModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						       <div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
												&times;
											</button>
											
										</div>
										<div class="modal-body" >
											<form class="form-horizontal" id="urgentdictForm">
							                     <div class="form-group">
							                          <label for="inputEmail3" class="col-sm-5 control-label">项目紧急程度级别<span id="star">&nbsp;&nbsp;*</span>&nbsp;&nbsp;:</label>
							                             <div class="col-sm-4">
							                                  <input type="text" class="form-control" name="urgentName" id="urgentName" >
							                                  <input type="hidden" class="form-control" name="flag" id="urgentsel" >
							                             </div>
							                     </div>
							                     <!-- 下拉框弹出flag -->
							                    <!--  <div class="form-group" id="urgentSelectHiden">
							                           <label for="inputPassword3" class="col-sm-5 control-label">封存状态：</label>
							                               <div class="col-sm-4">
							                                    <select class="form-control" id="urgentSel"  name="flag">
																  <option value="1">封存</option>
																  <option value="0">可用</option>
																</select>
							                               </div>
							                     </div> -->
							                     <!-- 下拉框弹出flag结束 -->
							                     <div class="form-group" id="urgentdictHiden" hidden="hidden">
							                           <label for="inputPassword3" class="col-sm-5 control-label">字典主键</label>
							                               <div class="col-sm-4">
							                                    <input    class="form-control" value="" name="urgentId" id="urgentId" >
							                               </div>
							                     </div>
										    </form>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
											<button type="button" class="btn btn-primary" onclick="urgentsave()" id="urgentdictAddBtn" value=" ">保存
										</button>
									    </div>
									</div><!-- /.modal-content -->
							    </div><!-- /.modal -->
							</div>
					   		<!-- 模态框结束 --> 
						  </div>
					    </div>
		            </div>
		         </div>
		         <!-- 项目紧急程度字典管理结束 -->
		         
		         
		         <!-- 合同类别字典管理 -->
		         <%--  <div class="box box-info">
			            <div class="box-header with-border">
				              <h3 class="box-title">合同类别字典管理</h3>
				              <div class="box-tools pull-right">
				              <div hidden="hidden">
				               <c:forEach items="${BdDictList }" var="BdDictList">
		       		            <input id="${BdDictList.dictCode}" value="${BdDictList.pkDict }" >
		       		           
		                      </c:forEach>
				              </div>
				             
					                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
					                </button>
					                <div class="btn-group">
					                </div>
					                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
				              </div>
			            </div>
		            <div class="box-body">
			            <div class="row">
				            <form action="" id="userForm" class="form-horizontal">
								<div class="searchBox" >
								</div>
							</form>
						</div>
						<div class="row">&nbsp;</div>
						<div class="row">
			              	<div class="col-md-12" >
				              	<button type="button" class="btn btn-success btn-sm" onclick="addBdDictDetail()"  data-toggle="modal" data-target="#contractTypedictModal">
							       <span class="glyphicon glyphicon-plus " aria-hidden="true"><span class="my-operation">新增</span></span>
							    </button>
							    <button type="button" class="btn btn-primary btn-sm" onclick="bdDictcheckUpdate('contractType')">
							       <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">修改</span></span>
							    </button>
								<button type="button" class="btn btn-danger btn-sm" onclick="checkBdDictFlag('contractType')">
								   <span class="glyphicon glyphicon-trash" aria-hidden="true"><span class="my-operation">封存</span></span>
								</button>
			              	</div>
		                </div>
					    <div class="row">
						  <div class="col-md-12">
						    <div id="contractTypeTable"></div>
					        <!-- 模态框开始 -->
					        <div class="modal fade" id="contractTypeDictModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
						       <div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
												&times;
											</button>
											
										</div>
										<div class="modal-body" >
											<form class="form-horizontal" id="contractTypedictForm">
							                     <div class="form-group">
							                          <label for="inputEmail3" class="col-sm-5 control-label">员工合同类别：</label>
							                             <div class="col-sm-4">
							                                  <input type="text" class="form-control" name="detailName" id="detailName0" >
							                             </div>
							                     </div>
							                     <div class="form-group">
							                          <label for="inputEmail3" class="col-sm-5 control-label">员工合同类别编码：</label>
							                             <div class="col-sm-4">
							                                  <input type="text" class="form-control" name="detailCode" id="detailCode0" >
							                             </div>
							                     </div>
							                     <!-- 下拉框弹出flag -->
							                     <div class="form-group" id="contractTypeSelectHiden">
							                           <label for="inputPassword3" class="col-sm-5 control-label">封存状态：</label>
							                               <div class="col-sm-4">
							                                    <select class="form-control" id="contractTypeSel"  name="flag">
																  <option value="1">有效</option>
																  <option value="0">无效</option>
																</select>
							                               </div>
							                     </div>
							                     <!-- 下拉框弹出flag结束 -->
							                     <div class="form-group" id="contractTypedictHiden" hidden="hidden">
							                           <label for="inputPassword3" class="col-sm-5 control-label">字典主键</label>
							                               <div class="col-sm-4">
							                                    <input    class="form-control" value="" name="pkDetail" id="pkDetail0" >
							                               </div>
							                     </div>
							                      <div class="form-group" id="contractTypedictHiden1" hidden="hidden">
							                           <label for="inputPassword3" class="col-sm-5 control-label">大表主键</label>
							                               <div class="col-sm-4">
							                                    <input class="form-control" value="2" name="pkDict" id="pkDict0" >
							                               </div>
							                     </div>
										    </form>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
											<button type="button" class="btn btn-primary" onclick="contractTypesave()" id="contractTypedictAddBtn" value=" ">保存
										</button>
									    </div>
									</div><!-- /.modal-content -->
							    </div><!-- /.modal -->
							</div>
					   		<!-- 模态框结束 --> 
						  </div>
					    </div>
		            </div>
		         </div>
		         <!-- 合同类别字典管理结束 -->
		         
		         
		         
		          
		         <!-- 员工类别字典管理 -->
		         
		         <div class="box box-info">
		            <div class="box-header with-border">
		              <h3 class="box-title">员工类别字典管理</h3>
		              <div class="box-tools pull-right">
		                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
		                </button>
		                <div class="btn-group">
		                </div>
		                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		              </div>
		            </div>
		            <div class="box-body">
			            <div class="row">
				            <form action="" id="userForm" class="form-horizontal">
								<div class="searchBox" >
								</div>
							</form>
						</div>
						<div class="row">&nbsp;</div>
						<div class="row">
			              	<div class="col-md-12" >
				              	<button type="button" class="btn btn-success btn-sm" onclick="employeeTypeaddDict()"  data-toggle="modal" data-target="#employeeTypeDictModal">
							 		 <span class="glyphicon glyphicon-plus " aria-hidden="true"><span class="my-operation">新增</span></span>
								</button>
								
								<button type="button" class="btn btn-primary btn-sm"  onclick="bdDictcheckUpdate('employeeType')">
							 		 <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">修改</span></span>
								</button>
								<button type="button" class="btn btn-danger btn-sm" onclick="checkBdDictFlag('employeeType')">
								  	<span class="glyphicon glyphicon-trash" aria-hidden="true"><span class="my-operation">封存</span></span>
								</button>
			              	</div>
		                </div>
			            <div class="row">
			            	<div class="col-md-12">
			            		<div id="employeeTypeTable"></div>      		
		                        <!-- 模态框开始 -->
							    <div class="modal fade" id="employeeTypeDictModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								   <div class="modal-dialog">
								     <div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
												&times;
											</button>
										</div>
										<div class="modal-body" >
											<form class="form-horizontal" id="employeeTypedictForm">
							                     <div class="form-group">
							                          <label for="inputEmail3" class="col-sm-5 control-label">员工类别：</label>
							                            <div class="col-sm-4">
							                                  <input type="text" class="form-control" name="detailName" id="detailName1" >
							                             </div>
							                     </div>
							                     <div class="form-group">
							                          <label for="inputEmail3" class="col-sm-5 control-label">员工类别编码：</label>
							                             <div class="col-sm-4">
							                                  <input type="text" class="form-control" name="detailCode" id="detailCode1" >
							                             </div>
							                     </div>
							                      <!-- 下拉框弹出flag -->
							                     <div class="form-group" id="employeeTypeSelectHiden" >
							                         <label for="inputPassword3" class="col-sm-5 control-label">封存状态：</label>
						                                <div class="col-sm-4">
						                                    <select class="form-control" id=""  name="flag">
															  <option value="1">有效</option>
															  <option value="0">无效</option>
															</select>
						                                </div>
							                     </div>
							                     <!-- 下拉框弹出flag结束 -->
							                     <div class="form-group" id="employeeTypedictHiden" hidden="hidden">
							                         <label for="inputPassword3" class="col-sm-5 control-label">员工类别字典主键</label>
					                                 <div class="col-sm-4">
					                                    <input   class="form-control" value="" name="pkDetail" id="pkDetail1" >
					                                 </div>
							                     </div>
							                      <div class="form-group" id="employeeTypedictHiden1" hidden="hidden">
							                         <label for="inputPassword3" class="col-sm-5 control-label">大表字典主键</label>
					                                 <div class="col-sm-4">
					                                    <input   class="form-control" value="1" name="pkDict" id="pkDict1" >
					                                 </div>
							                     </div>
										    </form>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
											<button type="button" class="btn btn-primary" onclick="employeeTypesave()" id="employeeTypedictAddBtn" value=" ">保存
										</button>
									    </div>
									 </div><!-- /.modal-content -->
								  </div><!-- /.modal -->
							    </div>
		                        <!-- 模态框结束 --> 
			            	</div>
			            </div>
		            </div>
		         </div>
		         <!-- 员工类别字典管理结束 -->
		         
		         
		         
		         
		          <!-- 职工工资类别字典管理 -->
		         
		         <div class="box box-info">
		            <div class="box-header with-border">
		              <h3 class="box-title">职工工资类别字典管理</h3>
		              <div class="box-tools pull-right">
		                <button type="button" class="btn btn-box-tool" data-widget="collapse"><i class="fa fa-minus"></i>
		                </button>
		                <div class="btn-group">
		                </div>
		                <button type="button" class="btn btn-box-tool" data-widget="remove"><i class="fa fa-times"></i></button>
		              </div>
		            </div>
		            <div class="box-body">
			            <div class="row">
				            <form action="" id="userForm" class="form-horizontal">
								<div class="searchBox" >
								</div>
							</form>
						</div>
						<div class="row">&nbsp;</div>
						<div class="row">
			              	<div class="col-md-12" >
				              	<button type="button" class="btn btn-success btn-sm" onclick="employeeWagesTypeaddDict()"  data-toggle="modal" >
							 		 <span class="glyphicon glyphicon-plus " aria-hidden="true"><span class="my-operation">新增</span></span>
								</button>
								
								<button type="button" class="btn btn-primary btn-sm"  onclick="bdDictcheckUpdate('employeeWagesType')">
							 		 <span class="glyphicon glyphicon-pencil" aria-hidden="true"><span class="my-operation">修改</span></span>
								</button>
								<button type="button" class="btn btn-danger btn-sm" onclick="checkBdDictFlag('employeeWagesType')">
								  	<span class="glyphicon glyphicon-trash" aria-hidden="true"><span class="my-operation">封存</span></span>
								</button>
			              	</div>
		                </div>
			            <div class="row">
			            	<div class="col-md-12">
			            		<div id="employeeWagesTypeTable"></div>      		
		                        <!-- 模态框开始 -->
							    <div class="modal fade" id="employeeWagesTypeDictModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								   <div class="modal-dialog">
								     <div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
												&times;
											</button>
										</div>
										<div class="modal-body" >
											<form class="form-horizontal" id="employeeWagesTypedictForm">
							                     <div class="form-group">
							                          <label for="inputEmail3" class="col-sm-5 control-label">员工工资类别：</label>
							                            <div class="col-sm-4">
							                                  <input type="text" class="form-control" name="detailName" id="detailName2" >
							                             </div>
							                     </div>
							                     <div class="form-group">
							                          <label for="inputEmail3" class="col-sm-5 control-label">员工工资类别编码：</label>
							                             <div class="col-sm-4">
							                                  <input type="text" class="form-control" name="detailCode" id="detailCode2" >
							                             </div>
							                     </div>
							                      <!-- 下拉框弹出flag -->
							                     <div class="form-group" id="employeeWagesTypeSelectHiden" >
							                         <label for="inputPassword3" class="col-sm-5 control-label">封存状态：</label>
						                                <div class="col-sm-4">
						                                    <select class="form-control" id=""  name="flag">
															  <option value="1">有效</option>
															  <option value="0">无效</option>
															</select>
						                                </div>
							                     </div>
							                     <!-- 下拉框弹出flag结束 -->
							                     <div class="form-group" id="employeeWagesTypedictHiden" hidden="hidden">
							                         <label for="inputPassword3" class="col-sm-5 control-label">员工工资类别字典主键</label>
					                                 <div class="col-sm-4">
					                                    <input   class="form-control" value="" name="pkDetail" id="pkDetail2" >
					                                 </div>
							                     </div>
							                      <div class="form-group" id="employeeWagesTypedictHiden1" hidden="hidden">
							                         <label for="inputPassword3" class="col-sm-5 control-label">大表字典主键</label>
					                                 <div class="col-sm-4">
					                                    <input   class="form-control" value="3" name="pkDict" id="pkDict2" >
					                                 </div>
							                     </div>
										    </form>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
											<button type="button" class="btn btn-primary" onclick="employeeWagesTypesave()" id="employeeWagesTypedictAddBtn" value=" ">保存
										</button>
									    </div>
									 </div><!-- /.modal-content -->
								  </div><!-- /.modal -->
							    </div>
		                        <!-- 模态框结束 --> 
			            	</div>
			            </div>
		            </div>
		         </div> --%>
		         <!-- 职工工资类别字典管理结束 -->
		       </div>
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
			            <div class="modal-body" align="center">是否确定删除已选项目</div>
			            <input type="hidden" id="Status" name="Status" value="">
			            <div class="modal-footer">
			            	<button type="button" class="btn btn-primary" onclick="deleteThis()">确认</button>
			            	<input type="hidden" id="introductionGener">
			            	<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
			            </div>
			        </div>
			    </div>
			</div> 
	    </section>
	    <!-- /.content -->
	  </div>
	  <%@include file="../../webfooter.jsp" %>
	</div>
</body>
</html>
