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
  <!-- Tell the browser to be responsive to screen width -->
  <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
<!-- 上传预览 -->
<script src="<%=request.getContextPath()%>/js/uploadPreview.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery.md5.js"></script> 
  
<script type="text/javascript">
$(function(){
	new uploadPreview({ UpBtn: "userPhoto", ImgShow: "preview" });
	initDeptTree();
	$("#userForm").bootstrapValidator({
	    	message: 'This value is not valid',
	    	fields: {
	    			    		
	            loginCode: {
	                validators: {
	                    notEmpty: {
	                        message: '登录名不能为空'
	                    },
	                    stringLength: {
	                           max: 20,
	                           message: '登录名长度不能大于20位'
	                       },
	                       regexp: {
	                           regexp: /^[a-zA-Z0-9_]+$/,
	                           message: '用户名只能包含大写、小写、数字和下划线'
	                       }
	                }
	            },
	            userCode: {
	                validators: {
	                    notEmpty: {
	                        message: '工号不能为空'
	                    },
	                    stringLength: {
	                           max: 20,
	                           message: '工号长度不能大于20位'
	                       },
	                       regexp: {
	                           regexp: /^[a-zA-Z0-9_]+$/,
	                           message: '工号只能包含大写、小写、数字和下划线'
	                       }
	                }
	            },
	            userName: {
	                validators: {
	                    notEmpty: {
	                        message: '人员姓名不能为空'
	                    },
	                    stringLength: {
	                           max: 13,
	                           message: '人员姓名长度不能大于13位'
	                       }
	                }
	            },
	            password: {
	                validators: {
	                	notEmpty: {
	                        message: '密码不能为空'
	                    },
	                    regexp: {  
	                           regexp: /^[a-zA-Z0-9_]+$/,  
	                           message: '密码只能包含大写、小写、数字和下划线'  
	                    },
	                    stringLength: {
	                           max: 50,
	                           message: '密码长度不能大于50位'
	                    },
	                    identical: {
	                         field: 'passwordAgain',
	                          message: '密码与确认密码不一致'
	                    },
	                    
	                }
	            },
	            passwordAgain: {
	                validators: {
	                	notEmpty: {
	                        message: '密码确认不能为空'
	                    },
	                    regexp: {  
	                           regexp: /^[a-zA-Z0-9_]+$/,  
	                           message: '密码只能包含大写、小写、数字和下划线'  
	                    },
	                    stringLength: {
	                           max: 50,
	                           message: '密码长度不能大于50位'
	                    },
	                    identical: {
	                         field: 'password',
	                          message: '确认密码与密码不一致'
	                    },
	                   
	                }
	            },
	            nativePlace: {
	                validators: {
	                    notEmpty: {
	                        message: '用户籍贯不能为空'
	                    },
	                    stringLength: {
	                           max: 66,
	                           message: '用户籍贯长度不能大于66位'
	                       }
	                }
	            },
	            homeAdd: {
	                validators: {
	                    notEmpty: {
	                        message: '家庭住址不能为空'
	                    },
	                    stringLength: {
	                           max: 33,
	                           message: '家庭住址长度不能大于33位'
	                       }
	                }
	            },
	            currentAdd: {
	                validators: {
	                    notEmpty: {
	                        message: '现住址不能为空'
	                    },
	                    stringLength: {
	                           max: 33,
	                           message: '现住址长度不能大于33位'
	                       }
	                }
	            },
	            professionalRanks: {
	                validators: {
	                    
	                    stringLength: {
	                           max: 16,
	                           message: '职称长度不能大于16位'
	                       }
	                }
	            },
	            emergencyMan: {
	                validators: {
	                    
	                    stringLength: {
	                           max: 6,
	                           message: '紧急联系人长度不能大于6位'
	                       }
	                }
	            },
	            emergencyPhone: {

	                validators: {
	                	regexp: {
	                        regexp: /^[1][0-9]{10}$/,
	                        message: '请检查手机号格式，输入正确的11位手机号'
	                    }
	                }
	            },
	            homePhone: {
	                validators: {
	                    stringLength: {
	                           max: 20,
	                           message: '家庭电话长度不能大于20位'
	                       },
	                    regexp: {
	                           regexp:/(^(\d{3,4}-)\d{7,8})$|(1[0-9]{10}$)/,
	                           message: '请检查家庭电话格式，输入正确的座机号或11位手机号，座机号格式例如“025-78459621”'
	                       }
	                }
	            },
	            politicsStatus: {
	                validators: {
	                    stringLength: {
	                           max: 10,
	                           message: '政治面貌长度不能大于10位'
	                       }
	                }
	            },
	            degree: {
	                validators: {
	                    stringLength: {
	                           max: 3,
	                           message: '学位长度长度不能大于3位'
	                       }
	                }
	            },
	            graduateSchool: {
	                validators: {
	                    stringLength: {
	                           max: 16,
	                           message: '毕业学校长度长度不能大于16位'
	                       }
	                }
	            },
	            qq: {
	                validators: {
	                    stringLength: {
	                           max: 16,
	                           message: 'QQ长度不能大于16位'
	                       },
	                       regexp: {
	                           regexp: /^[1-9][0-9]{4,9}$/,
	                           message: '请检查qq号格式，输入正确的qq号'
	                       }
	                       
	                }
	            },
	            housingFundAccount: {
	                validators: {
	                    stringLength: {
	                           max: 30,
	                           message: '公积金账号长度不能大于30位'
	                       }
	                       
	                }
	            },
	            position: {
	                validators: {
	                    stringLength: {
	                           max: 10,
	                           message: '岗位长度不能大于10位'
	                       }
	                       
	                }
	            },
	            deptPosition: {
	                validators: {
	                    stringLength: {
	                           max: 6,
	                           message: '部门岗位长度不能大于6位'
	                       }
	                       
	                }
	            },
	            positionDegree: {
	                validators: {
	                    stringLength: {
	                           max: 10,
	                           message: '岗位级别长度不能大于10位'
	                       }
	                       
	                }
	            },
	            contractType: {
	                validators: {
	                    stringLength: {
	                           max: 20,
	                           message: '合同类别长度不能大于20位'
	                       }
	                       
	                }
	            },
	            employeeType: {
	                validators: {
	                    stringLength: {
	                           max: 20,
	                           message: '职工级别长度不能大于20位'
	                       }
	                       
	                }
	            },
	            employeeWagesType: {
	                validators: {
	                    stringLength: {
	                           max: 20,
	                           message: '职工工资级别长度不能大于20位'
	                       }
	                       
	                }
	            },
	            idNumber: {
	                validators: {
	                	regexp: {
	                           regexp: /^[1-9]\d{7}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}$|^[1-9]\d{5}[1-9]\d{3}((0\d)|(1[0-2]))(([0|1|2]\d)|3[0-1])\d{3}([0-9]|[xX])$/,
	                           message: '请检查身份证格式，输入正确的15-18位身份证号'
	                       }
	                }
	            },
	            nation: {
	                validators: {
	                	
	                	notEmpty: {
	                        message: '民族不能为空'
	                    },
	                    stringLength: {
	                           max: 20,
	                           message: '民族长度不能大于20位'
	                       }
	                }
	            },
	            specialty: {
	                validators: {
	                    stringLength: {
	                           max: 16,
	                           message: '专业长度不能大于16位'
	                       }
	                }
	            },
	            email: {
	                validators: {
	                	emailAddress:{
	                		message: '邮箱格式不正确'
	                	},
	                    stringLength: {
	                           max: 30,
	                           message: '邮箱长度不能大于30位'
	                       }
	                }
	            },
	           
	            officePhone: {
	                validators: {
	                    stringLength: {
	                           max: 20,
	                           message: '办公电话长度不能大于20位'
	                       },
	                    regexp: {
	                           regexp:/(^(\d{3,4}-)\d{7,8})$|(1[0-9]{10}$)/,
	                           message: '请检查办公电话格式，输入正确的座机号或11位手机号，座机号格式例如“025-78459621”'
	                       }
	                }
	            },
	            education: {
	                validators: {
	                    stringLength: {
	                           max: 10,
	                           message: '学历长度不能大于10位'
	                       }
	                }
	            },
	            cellPhone: {

	                validators: {
	                	
	                	notEmpty: {
	                        message: '手机号不能为空'
	                    },
	                	regexp: {
	                        regexp: /^[1][0-9]{10}$/,
	                        message: '请检查手机号格式，输入正确的11位手机号'
	                    }
	                }
	            },
	            dirName: {
	                validators: {
	                	notEmpty: {
	                        message: '部门不能为空'
	                    }
	                }
	            },
	            entryDate: {
	                validators: {
	                	notEmpty: {
	                        message: '入职日期不能为空'
	                    }
	                }
	            },
	            contractStartTime: {
	                validators: {
	                	notEmpty: {
	                        message: '合同开始日期不能为空'
	                    },
	                    callback:{
	                   	 message: '合同开始日期需小于合同终止日期！！',
	                   	 callback:function(value, validator) {
		                    	var startTime = $("#contractStartTime").val();
		                    	var endTime = $("#contractEndTime").val();
		                    	
		                    	if (''!=endTime&&''!=startTime&&endTime <= startTime) {
		                    		return false;
		                    	}else{
		                    		return true;
		                    	}
	                   	 }
	                   }
	                }
	            },
	            contractEndTime: {
	                validators: {	                
	                    callback:{
	                   	 message: '合同开始日期需小于合同终止日期！！',
	                   	 callback:function(value, validator) {
		                    	var startTime = $("#contractStartTime").val();
		                    	var endTime = $("#contractEndTime").val();
		                    	
		                    	if (''!=endTime&&''!=startTime&&endTime <= startTime) {
		                    		return false;
		                    	}else{
		                    		return true;
		                    	}
	                   	 }
	                   }
	                }
	            },
	            probationStart: {
	                validators: {
	                    callback:{
	                   	 message: '试用开始日期需小于试用结束日期！！',
	                   	 callback:function(value, validator) {
		                    	var startTime = $("#probationStart").val();
		                    	var endTime = $("#probationEnd").val();
		                    	
		                    	if (''!=endTime&&''!=startTime&&endTime <= startTime) {
		                    		return false;
		                    	}else{
		                    		return true;
		                    	}
	                   	 }
	                   }
	                }
	            },
	            probationEnd: {
	                validators: {
	                    callback:{
	                   	 message: '试用开始日期需小于试用结束日期！！',
	                   	 callback:function(value, validator) {
		                    	var startTime = $("#probationStart").val();
		                    	var endTime = $("#probationEnd").val();
		                    	
		                    	if (''!=endTime&&''!=startTime&&endTime <= startTime) {
		                    		return false;
		                    	}else{
		                    		return true;
		                    	}
	                   	 }
	                   }
	                }
	            }
	        }
	    })
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
}
function chooseDept(){
	$("#deptModel").modal('show');
}

function clickImg() {
	$("#userPhoto").click();
}
function update() {
	$('#userForm').data('bootstrapValidator').resetForm();
	$('#userForm').data('bootstrapValidator').validate();  
    if(!$('#userForm').data('bootstrapValidator').isValid()){ 
    	window.top.warning("校验未通过！");
        return ;
    }
    var roleId=[];
	$(".role-btn").each(function(){
		if($(this).attr("class").indexOf("success") > 0){
			roleId.push($(this).attr("roleId"));
		}
	});
	if(roleId.length==0){
		window.top.warning("人员角色必须选择！");
		return;
	}
// 	if(roleId.length >1){
// 		window.top.warning("只能选择一个角色");
// 		return;
// 	}
	var formData = new FormData($('form')[1]);
// 	var newPassword=$("#password").val();
// 	if(newPassword==$("#oldPassword").val()){
// 		formData.set("password",newPassword);
// 	}else{
// 		formData.set("password",$.md5(newPassword));
// 	}
	formData.append("roleId",roleId);
	 $.ajax({
	    	url:"<%=request.getContextPath()%>/admin/user/userUpdate.ajax",
	        type: 'POST',
	        xhr: function() {  // custom xhr
	            myXhr = $.ajaxSettings.xhr();
	            return myXhr;
	        },
	        success:function(){
	        	window.location.href="<%=request.getContextPath()%>/admin/user/userManage.do";
	        	window.top.warning("保存成功");
	        },
	        error:function(){
	        	$("#addBtn").attr("disabled",false);
	        	window.top.warning("保存失败");
	        },
	        data: formData,
	        cache: false,
	        contentType: false,
	        processData: false
	    });
}
function changeColor(btnId){
	var oldClass=$("#"+btnId+"_id").attr("class");
	if(oldClass.indexOf("success") > 0){
		$("#"+btnId+"_id").prop("class","btn btn-default role-btn");
	}else{
		$("#"+btnId+"_id").prop("class","btn btn-success role-btn");
	}
}
function back(){
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
    <!-- Content Header (Page header) -->
  <!--   <section class="content-header">
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
              <h3 class="box-title">修改人员</h3>
              <div class="box-tools pull-right">
              </div>
            </div>
          <div class="box box-info">
          </div>
           
            <div class="box-body">
	            <div class="row">
		            <form action="" id="userForm" class="form-horizontal">
		            <div class="row">
			            <div class="col-sm-11" >
			            	<div class="form-group" >
								<label class="col-sm-2 control-label" for="userPhoto">照片：</label>
				                <div class="col-sm-2">
				                 <a class="img-place" href="javascript:void(0)">
				                	 <img src="<%=request.getContextPath()%>${userInfoBo.photo}" onerror="this.src='<%=request.getContextPath()%>/common/images/addPhoto.png'" style="width:100px; height:100px" id="preview" name="preview" title="点击更换头像" onclick="clickImg()"/>
                                 </a>
                                <input name="oldPhoto" id="oldPhoto" value="${userInfoBo.photo}" hidden="hidden">
				                </div>
				                 <input type="file"  name="userPhoto" id="userPhoto" style="opacity: 0;" hidden="hidden"/>
							</div>
							<div class="form-group">
					             <label class="col-sm-2 control-label" for="userName">人员姓名<span id="star">&nbsp;&nbsp;*</span>：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="userName" name="userName" value="${userInfoBo.userName}"/>
					             	<input   name="userId" value="${userInfoBo.userId}" hidden="hidden"/>
					             </div>
					             <label class="col-sm-2 control-label" for="loginCode">登录名<span id="star">&nbsp;&nbsp;*</span>：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="loginCode" name="loginCode"  value="${userInfoBo.loginCode}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="userCode">工号<span id="star">&nbsp;&nbsp;*</span>：</label>
					             <div class="col-sm-2">
					             	<input type="text" readonly="readOnly" class="form-control" id="userCode" name="userCode" value="${userInfoBo.userCode}"/>
					             	<input hidden="hidden" id="password" name="password" value="${userInfoBo.password}"/>
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="politicsStatus">政治面貌：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="politicsStatus" name="politicsStatus" value="${userInfoBo.politicsStatus}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="gender">性别：</label>
					             <div class="col-sm-2">
					             	<select class="form-control" name="gender" id="gender">
					             		<option value="02" <c:if test="${userInfoBo.gender eq 02}">selected="selected"</c:if> >未知</option>
					             		<option value="00" <c:if test="${userInfoBo.gender eq 00}">selected="selected"</c:if> >男</option>
					             		<option value="01" <c:if test="${userInfoBo.gender eq 01}">selected="selected"</c:if> >女</option>
					             	</select>
					             </div>
					             <label class="col-sm-2 control-label" for="birthday">出生日期：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="birthday" id="birthday"  maxlength="25"
													onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" 
													value="<fmt:formatDate value="${userInfoBo.birthday}" type="both" pattern="yyyy-MM-dd"/>">
					             </div>
							</div>
							<div class="form-group" >
					             <label class="col-sm-2 control-label" for="entryDate">入职日期<span id="star">&nbsp;&nbsp;*</span>：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="entryDate" id="entryDate"  maxlength="25"
													onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" 
													value="<fmt:formatDate value="${userInfoBo.entryDate}" type="both" pattern="yyyy-MM-dd"/>">
					             </div>
					             <label class="col-sm-2 control-label" for="nativePlace">籍贯<span id="star">&nbsp;&nbsp;*</span>：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="nativePlace" name="nativePlace" value="${userInfoBo.nativePlace}" />
					             </div>
					             <label class="col-sm-2 control-label" for="nation">民族<span id="star">&nbsp;&nbsp;*</span>：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="nation" name="nation" value="${userInfoBo.nation}"/>
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="emergencyMan">紧急联系人：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="emergencyMan" name="emergencyMan" value="${userInfoBo.emergencyMan}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="emergencyPhone">紧急联系电话：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="emergencyPhone" name="emergencyPhone" value="${userInfoBo.emergencyPhone}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="homePhone ">家庭电话：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="homePhone" name="homePhone"  value="${userInfoBo.homePhone}"/>
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="officePhone ">办公电话：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="officePhone" name="officePhone"  value="${userInfoBo.officePhone}"/>
					             </div>
								 <label class="col-sm-2 control-label" for="qq">qq号：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="qq" name="qq"  value="${userInfoBo.qq}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="education">学历：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="education" name="education"  value="${userInfoBo.education}"/>
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="degree">学位：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="degree" name="degree" value="${userInfoBo.degree}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="graduateSchool">毕业学校：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="graduateSchool" name="graduateSchool" value="${userInfoBo.graduateSchool}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="specialty">专业：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="specialty" name="specialty" value="${userInfoBo.specialty}" />
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="graduateDate">毕业日期：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="graduateDate" id="graduateDate"  maxlength="25"
													onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" 
													value="<fmt:formatDate value="${userInfoBo.graduateDate}" type="both" pattern="yyyy-MM-dd"/>">
					             </div>
					             <label class="col-sm-2 control-label" for="startWorkDate">参加工作日期：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="startWorkDate" id="startWorkDate"  maxlength="25"
													onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" 
												  value="<fmt:formatDate value="${userInfoBo.startWorkDate}" type="both" pattern="yyyy-MM-dd"/>">
					             </div>
					             <label class="col-sm-2 control-label" for="professionalRanks">职称：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="professionalRanks" name="professionalRanks" value="${userInfoBo.professionalRanks}"/>
					             </div>
							</div>
							<div class="form-group" >
					             <label class="col-sm-2 control-label" for="employeeWagesType">职工工资类别：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="employeeWagesType" name="employeeWagesType" value="${userInfoBo.employeeWagesType}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="probationStart">试用开始日期：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="probationStart" id="probationStart"  maxlength="25"
													onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" 
													value="<fmt:formatDate value="${userInfoBo.probationStart}" type="both" pattern="yyyy-MM-dd"/>">
					             </div>
					              <label class="col-sm-2 control-label" for="probationEnd">试用结束日期：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="probationEnd" id="probationEnd"  maxlength="25"
													onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" 
													value="<fmt:formatDate value="${userInfoBo.probationEnd}" type="both" pattern="yyyy-MM-dd"/>">
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="housingFundAccount">公积金账户：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="housingFundAccount" name="housingFundAccount" value="${userInfoBo.housingFundAccount}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="position">岗位：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="position" name="position" value="${userInfoBo.position}" />
					             </div>
					             <label class="col-sm-2 control-label" for="employeeType">职工类别：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="employeeType" name="employeeType" value="${userInfoBo.employeeType}"/>
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="deptPosition">部门岗位：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="deptPosition" name="deptPosition" value="${userInfoBo.deptPosition}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="positionDegree">岗位级别：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="positionDegree" name="positionDegree"value="${userInfoBo.positionDegree}" />
					             </div>
					             <label class="col-sm-2 control-label" for="positionTime">上岗日期：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="positionTime" id="positionTime"  maxlength="25"
													onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" 
													value="<fmt:formatDate value="${userInfoBo.positionTime}" type="both" pattern="yyyy-MM-dd"/>">
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="contractType">职工合同类别：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="contractType" name="contractType" value="${userInfoBo.contractType}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="contractStartTime">合同开始日期<span id="star">&nbsp;&nbsp;*</span>：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="contractStartTime" id="contractStartTime"  maxlength="25"
													onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" 
													value="<fmt:formatDate value="${userInfoBo.contractStartTime}" type="both" pattern="yyyy-MM-dd"/>">
					             </div>
					             <label class="col-sm-2 control-label" for="contractEndTime">合同终止日期：</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="contractEndTime" id="contractEndTime"  maxlength="25"
													onfocus="WdatePicker({regEnddate:'%y-%M-01',dateFmt:'yyyy-MM-dd',alwaysUseStartDate:true});" 
													value="<fmt:formatDate value="${userInfoBo.contractEndTime}" type="both" pattern="yyyy-MM-dd"/>">
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="email">电子邮箱：</label>
					             <div class="col-sm-4">
					             	<input type="text" class="form-control" id="email" name="email" value="${userInfoBo.email}"/>
					             </div>
								 <label class="col-sm-2 control-label" for="idNumber">身份证：</label>
					             <div class="col-sm-4">
					             	<input type="text" class="form-control" id="idNumber" name="idNumber" value="${userInfoBo.idNumber}"/>
					             </div>
							</div>
							<div class="form-group" >
					             <label class="col-sm-2 control-label" for="dirName">部门<span id="star">&nbsp;&nbsp;*</span>：</label>
					             <div class="col-sm-4">
					             	<input type="text" readonly="readOnly" class="form-control" id="dirName" name="dirName" value="${userInfoBo.dirName}" onclick="chooseDept()"/>
					             	<input type="text"  id="dirId" name="dirId" hidden="hidden" value="${userInfoBo.dirId}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="cellPhone">手机<span id="star">&nbsp;&nbsp;*</span>：</label>
					             <div class="col-sm-4">
					             	<input type="text" class="form-control" id="cellPhone" name="cellPhone" value="${userInfoBo.cellPhone}"/>
					             </div>
							</div>
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="homeAdd">家庭住址<span id="star">&nbsp;&nbsp;*</span>：</label>
					             <div class="col-sm-4">
					             	<input type="text" class="form-control" id="homeAdd" name="homeAdd" value="${userInfoBo.homeAdd}"/>
					             </div>
					             <label class="col-sm-2 control-label" for="currentAdd">现住址<span id="star">&nbsp;&nbsp;*</span>：</label>
					             <div class="col-sm-4"> 
					             	<input type="text" class="form-control" id="currentAdd" name="currentAdd" value="${userInfoBo.currentAdd}" />
					             </div>
							</div>
						</div>
					</div>
					<hr>
					<div class="form-group">
						<h4 Style="text-align: center;">人员角色</h4>
					</div>
					<div class="form-group">
						<div class="col-sm-12" align="center">
							<c:forEach items="${roleList}" var="role" >
							<c:set var="str" value="roleId=${role.roleId})"></c:set>
								<button type="button" 
								<c:choose> 
						            <c:when test="${fn:contains(roleListContain,str)}">class="btn btn-success role-btn" </c:when> 
						            <c:otherwise>class="btn btn-default role-btn"</c:otherwise> 
								</c:choose>
								onclick="changeColor('${role.roleId}')" roleId="${role.roleId}" id="${role.roleId}_id">${role.roleName}</button>
							</c:forEach>
						</div>
					</div>	
					</form>
				</div>
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
            </div>
        </div>
      </div>
  <%@include file="../../common/deptModel.jsp" %>   
    </section>
    <!-- /.content -->
  </div>
<%@include file="../../webfooter.jsp" %>
</div>
</body>

</html>