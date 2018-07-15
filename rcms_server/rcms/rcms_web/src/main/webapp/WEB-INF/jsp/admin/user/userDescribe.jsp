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
	function goBack(){
		window.location.href="<%=request.getContextPath()%>/admin/user/userManage.do";
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
    
  <ul id="updateTree" class="ztree" style="width:230px;overflow:auto;"></ul>
    
    <div class="row">
        <div class="col-md-12">
            <div class="box-header with-border">
              <h3 class="box-title">人员信息详情</h3>
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
								<label class="col-sm-2 control-label" for="userPhoto">照片&nbsp;&nbsp;:</label>
				                <div class="col-sm-2">
				                 <a class="img-place" href="javascript:void(0)">
				                	 <img src="<%=request.getContextPath()%>${userInfoBo.photo}" onerror="this.src='<%=request.getContextPath()%>/common/images/addPhoto.png'" style="width:100px; height:100px" id="preview" name="preview" title="点击更换头像" onclick="clickImg()"/>
                                 </a>
                                <input name="oldPhoto" id="oldPhoto" value="${userInfoBo.photo}" hidden>
				                </div>
				                 <input type="file"  name="userPhoto" id="userPhoto" style="opacity: 0;" hidden="hidden"/>
							</div>
							
							<div class="form-group">
					             <label class="col-sm-2 control-label" for="userName">人员姓名&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="userName" name="userName" value="${userInfoBo.userName}" readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="loginCode">登录名&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="loginCode" name="loginCode"  value="${userInfoBo.loginCode}"	readOnly/>
					             </div>
					              <label class="col-sm-2 control-label" for="userCode">工号 &nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" readonly="readOnly" class="form-control" id="userCode" name="userCode" value="${userInfoBo.userCode}"	readOnly/>
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="politicsStatus">政治面貌&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="politicsStatus" name="politicsStatus" value="${userInfoBo.politicsStatus}"	readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="gender">性别&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<c:if test="${userInfoBo.gender eq 02}"><input type="text" class="form-control"  value="未知" readOnly/></c:if>
					             	<c:if test="${userInfoBo.gender eq 00}"><input type="text" class="form-control"  value="男" readOnly/></c:if>
					             	<c:if test="${userInfoBo.gender eq 01}"><input type="text" class="form-control"  value="女" readOnly/></c:if>
					             </div>
					             <label class="col-sm-2 control-label" for="birthday">出生日期&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="birthday" id="birthday"  maxlength="25"
													value="<fmt:formatDate value="${userInfoBo.birthday}" type="both" pattern="yyyy-MM-dd"/>"	readOnly>
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="entryDate">入职日期&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="entryDate" id="entryDate"  maxlength="25"
													value="<fmt:formatDate value="${userInfoBo.entryDate}" type="both" pattern="yyyy-MM-dd"/>"	readOnly>
					             </div>
					             <label class="col-sm-2 control-label" for="nativePlace">籍贯&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="nativePlace" name="nativePlace" value="${userInfoBo.nativePlace}" 	readOnly/>
					             </div>
					              <label class="col-sm-2 control-label" for="nation">民族&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="nation" name="nation" value="${userInfoBo.nation}"	readOnly/>
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="emergencyMan">紧急联系人&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="emergencyMan" name="emergencyMan" value="${userInfoBo.emergencyMan}"	readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="emergencyPhone">紧急联系电话&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="emergencyPhone" name="emergencyPhone" value="${userInfoBo.emergencyPhone}"	readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="homePhone ">家庭电话&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="homePhone" name="homePhone"  value="${userInfoBo.homePhone}"	readOnly/>
					             </div>
							</div>
							
							<div class="form-group" >
					             <label class="col-sm-2 control-label" for="officePhone ">办公电话&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="officePhone" name="officePhone"  value="${userInfoBo.officePhone}"	readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="qq">qq号&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="qq" name="qq"  value="${userInfoBo.qq}" readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="education">学历&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="education" name="education"  value="${userInfoBo.education}"	readOnly/>
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="degree">学位&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="degree" name="degree" value="${userInfoBo.degree}"	readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="graduateSchool">毕业学校 &nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="graduateSchool" name="graduateSchool" value="${userInfoBo.graduateSchool}"	readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="specialty">专业&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="specialty" name="specialty" value="${userInfoBo.specialty}" 	readOnly/>
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="graduateDate">毕业日期&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="graduateDate" id="graduateDate"  maxlength="25"
													value="<fmt:formatDate value="${userInfoBo.graduateDate}" type="both" pattern="yyyy-MM-dd"/>"	readOnly>
					             </div>
					             <label class="col-sm-2 control-label" for="startWorkDate">参加工作日期&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="startWorkDate" id="startWorkDate"  maxlength="25"
												  value="<fmt:formatDate value="${userInfoBo.startWorkDate}" type="both" pattern="yyyy-MM-dd"/>"	readOnly>
					             </div>
					              <label class="col-sm-2 control-label" for="professionalRanks">职称&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="professionalRanks" name="professionalRanks" value="${userInfoBo.professionalRanks}"	readOnly/>
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="housingFundAccount">公积金账户&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="housingFundAccount" name="housingFundAccount" value="${userInfoBo.housingFundAccount}"	readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="position">岗位&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="position" name="position" value="${userInfoBo.position}" 	readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="employeeType">职工类别&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="employeeType" name="employeeType" value="${userInfoBo.employeeType}"	readOnly/>
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="deptPosition">部门岗位&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="deptPosition" name="deptPosition" value="${userInfoBo.deptPosition}"	readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="positionDegree">岗位级别&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="positionDegree" name="positionDegree"value="${userInfoBo.positionDegree}" 	readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="positionTime">上岗日期&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="positionTime" id="positionTime"  maxlength="25"
													value="<fmt:formatDate value="${userInfoBo.positionTime}" type="both" pattern="yyyy-MM-dd"/>"	readOnly>
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="contractType">职工合同类别&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="contractType" name="contractType" value="${userInfoBo.contractType}"	readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="contractStartTime">合同开始日期&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="contractStartTime" id="contractStartTime"  maxlength="25"
													value="<fmt:formatDate value="${userInfoBo.contractStartTime}" type="both" pattern="yyyy-MM-dd"/>"	readOnly>
					             </div>
					             <label class="col-sm-2 control-label" for="contractEndTime">合同终止日期&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="contractEndTime" id="contractEndTime"  maxlength="25"
													value="<fmt:formatDate value="${userInfoBo.contractEndTime}" type="both" pattern="yyyy-MM-dd"/>"	readOnly>
					             </div>
							</div>
							
							<div class="form-group" >
					             <label class="col-sm-2 control-label" for="employeeWagesType">职工工资类别&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control" id="employeeWagesType" name="employeeWagesType" value="${userInfoBo.employeeWagesType}"		readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="probationStart">试用开始日期&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="probationStart" id="probationStart"  maxlength="25"
													value="<fmt:formatDate value="${userInfoBo.probationStart}" type="both" pattern="yyyy-MM-dd"/>"	readOnly>
					             </div>
					              <label class="col-sm-2 control-label" for="probationEnd">试用结束日期&nbsp;&nbsp;:</label>
					             <div class="col-sm-2">
					             	<input type="text" class="form-control datepicker" name="probationEnd" id="probationEnd"  maxlength="25" 
													value="<fmt:formatDate value="${userInfoBo.probationEnd}" type="both" pattern="yyyy-MM-dd"/>"	readOnly>
					             </div>
							</div>
							<div class="form-group" >
					             <label class="col-sm-2 control-label" for="email">电子邮箱&nbsp;&nbsp;:</label>
					             <div class="col-sm-4">
					             	<input type="text" class="form-control" id="email" name="email" value="${userInfoBo.email}"	readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="idNumber">身份证&nbsp;&nbsp;:</label>
					             <div class="col-sm-4">
					             	<input type="text" class="form-control" id="idNumber" name="idNumber" value="${userInfoBo.idNumber}"	readOnly/>
					             </div>
							</div>
							<div class="form-group" >
							     <label class="col-sm-2 control-label" for="dirName">部门&nbsp;&nbsp;:</label>
					             <div class="col-sm-4">
					             	<input type="text" class="form-control" id="dirName" name="dirName" value="${userInfoBo.dirName}" title="${userInfoBo.dirName}" readOnly/>
					             </div>
					              <label class="col-sm-2 control-label" for="cellPhone">手机&nbsp;&nbsp;:</label>
					             <div class="col-sm-4">
					             	<input type="text" class="form-control" id="cellPhone" name="cellPhone" value="${userInfoBo.cellPhone}"	readOnly/>
					             </div>
							</div>
							
							<div class="form-group" >
								 <label class="col-sm-2 control-label" for="homeAdd">家庭住址&nbsp;&nbsp;:</label>
					             <div class="col-sm-4">
					             	<input type="text" class="form-control" id="homeAdd" name="homeAdd" value="${userInfoBo.homeAdd}"	readOnly/>
					             </div>
					             <label class="col-sm-2 control-label" for="currentAdd">现住址&nbsp;&nbsp;:</label>
					             <div class="col-sm-4"> 
					             	<input type="text" class="form-control" id="currentAdd" name="currentAdd" value="${userInfoBo.currentAdd}" 	readOnly/>
					             </div>
							</div>
						</div>
					</div>
					<div class="row"></div>
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
								onclick="changeColor('${role.roleId}')" roleId="${role.roleId}" id="${role.roleId}_id"	readOnly>${role.roleName}</button>
							</c:forEach>
						</div>
					</div>	
					
				 	<div class="row">
	            		<div class="col-md-12" align="center">
							<button type="button" class="btn btn-danger btn-sm" onclick="goBack()">
						  		返回
							</button>
	              		</div>
	            	</div>
					</form>
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