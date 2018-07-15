<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no" />
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" media="screen">

<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery.md5.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/layer/layer.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/common.js"></script>
</head>
<body class="page-md login">
	<div class="row">
		<div class="login_head"></div>
		<div class="container login-middle">
			<div class="login-middle_container">
				<div class=" col-md-3"></div>
				<div class="col-xs-6 col-md-4 login-middle_container_div2">
					<form role="form" style="padding-bottom: 30px;" id="login" method="post">
						<fieldset>
							<legend>用户登录</legend>
							<div class="input-group">
								<span class="input-group-addon" id="basic-addon1">账号</span>
						  		<input id="loginCode" name="loginCode" value="admin" type="text" class="form-control" placeholder="用户名" aria-describedby="basic-addon1" required autofocus>
							</div>
							<br>
							<div class="input-group">
								<span class="input-group-addon" id="basic-addon1">密码</span>
							  	<input id="password" name="password" value="123456" type="password" class="form-control" placeholder="密码" aria-describedby="basic-addon1" required>
							</div>
							<br><br>
							<button class="btn btn-sm btn-info btn-block" type="submit">登 录</button>
						</fieldset>
					</form>
				</div>
				<div class=" col-md-2"></div>
			</div>
		</div>
		<div class="login_bottom">
			<center><span>版权所有&copy;上海砾阳软件有限公司 All Rights Reserved</span></center>
		</div>
	</div>
	 <script type="text/javascript" language="javascript">
        $("#login").on("submit", function(ev) {  
            $.ajax({  
            	type:"post",
    			url:"<%=request.getContextPath()%>/admin/login.ajax",
    			data :{loginCode:$("#loginCode").val(),password:$.md5($("#password").val())},
    			success:function(data){
    				location.href="<%=request.getContextPath()%>/admin/index.do"; 			
    				return;
    			},
    			error:function(data){
    			}
            });  
            //阻止submit表单提交  
            ev.preventDefault();  
            //或者return false  
            //return false;  
        });  
    </script>  
</body>
</html>