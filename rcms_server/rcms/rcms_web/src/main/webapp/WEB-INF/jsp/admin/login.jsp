<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en-gb" lang="en-gb"
	dir="ltr">
<head>
<title>RCMS-Login</title>
<link href="<%=request.getContextPath()%>/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />

<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery.md5.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/layer/layer.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/common.js"></script>
<style type="text/css">
body {
    line-height: 24px;
    background-color: #f2f2f2;
}

.body-innerwrapper {
    overflow-x: hidden;
    -webkit-transition: margin-left 400ms cubic-bezier(0.7,0,0.3,1);
    transition: margin-left 400ms cubic-bezier(0.7,0,0.3,1);
}

#sp-main-body {
    padding: 100px 0 70px;
    background:url("<%=request.getContextPath()%>/login/login-bk.jpg") no-repeat;
    background-size: cover;
} 
.logo-font{
	margin-top:100px;
}

.login.box {
    padding: 25px 30px 30px 25px;
    margin-bottom: 40px;
    margin-top: 0;
}

.box {
    background: #fff;
}

.page-login-form{
    font-size: 18px;
    line-height: 1;
    margin-bottom: 30px;
    font-weight: 400;
}

.page-login-form .login-description p {
    font-size: 14px;
    color: #9f9f9f;
    margin-top: 22px;
}

.login.box{
    margin-bottom: 30px;
}

.page-login-form .group-control input {
    border: 1px solid #f0f0f0;
    outline: 0;
    min-height: 46px;
}

.group-control select, .group-control textarea, .group-control input[type="text"], .group-control input[type="password"], .group-control input[type="datetime"], .group-control input[type="datetime-local"], .group-control input[type="date"], .group-control input[type="month"], .group-control input[type="time"], .group-control input[type="week"], .group-control input[type="number"], .group-control input[type="email"], .group-control input[type="url"], .group-control input[type="search"], .group-control input[type="tel"], .group-control input[type="color"], .group-control .uneditable-input {
    width: 100%;
}

select, textarea, input[type="text"], input[type="password"], input[type="datetime"], input[type="datetime-local"], input[type="date"], input[type="month"], input[type="time"], input[type="week"], input[type="number"], input[type="email"], input[type="url"], input[type="search"], input[type="tel"], input[type="color"], .uneditable-input {
    display: block;
    height: 34px;
    padding: 6px 12px;
    font-size: 14px;
    line-height: 1.428571429;
    color: #555555;
    background-color: #fff;
    background-image: none;
    transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    box-shadow: none;
    border-radius: 3px;
}

 .form-links {
    list-style: none;
    padding: 0;
    margin: 0;
}

.form-links ul>li {
    display: inline-block;
    margin: 0 5px;
}

.form-links ul>li a {
    color: #9f9f9f;
    font-size: 16px;
}
a, a:hover, a:focus, a:active {
    text-decoration: none;
    cursor:pointer;
    
}

a {
	color:#fe7213;
    transition: color 400ms,background-color 400ms;
}

.form-links li {
    padding: 2px 0;
}

.page-login-form .form-group button.btn.btn-login {
    box-shadow: 0 2px #4b97ff;
    color: #fff;
    display: inline-block;
    width: 100%;
    padding: 8px 20px;
    margin-top: 20px;
    background-color: #4b97ff;
    border:1px solid #4b97ff;
   
}



#sp-bottom {
	padding: 100px 0px 0px;
}

/* 修改样式
 */
 header{
	width:100%;
	height:90px;
	line-height:90px;
	background:#fff;
}
.img-warp{
	padding-left:110px;
}
.login-header{
	margin-left:20px;
	font-size:16px;
	font-weight:800;
	cursor:pointer;
}
.line{
	display: inline-block;
	height:30px;
	width:2px;
	background:#000;
	position:relative;
	top:10px;
	left:10px;
}
.login-title{
	float:left;
	cursor:pointer;
	
}
.login-rg{
	float:right;
	cursor:pointer;
	font-size:14px;
	color:#cecece;
}
.login-description{
	margin-bottom:40px;
}
.vafiy{
	padding:0;
}
.auto-login,.forget{
	float:left;
	font-size:12px;
	color:#999;
}
input[type="checkbox"]{
	vertical-align: text-bottom;
}
.forget{
	float:right;
}
footer{
  height:70px;
  text-align:center;
  padding-top:30px;
}
input:-webkit-autofill, textarea:-webkit-autofill, select:-webkit-autofill {
    background-color: #fff;
}
.input-group-addon{
    font-weight: 400;
    line-height: 1;
    color: #555;
    background-color: #fff;
    border: 1px solid #f0f0f0;
    border-radius: 0px;
}
/* 修改样式
 */
</style>


</head>
<body
	class="site com-users view-login no-layout no-task itemid-121 en-gb ltr  sticky-header layout-fluid ">
	<div class="body-innerwrapper">
		<header>
			<div class="img-warp">
				<img src="<%=request.getContextPath()%>/login/logo.png" />
				<span class="line"></span>
				<span class="login-header">登录</span>
			</div>
		</header>
		<section id="sp-main-body">
			<div class="container">
				<div class="row">
					<div id="sp-component" class="col-sm-12 col-md-12">
						<div>
							<div class="row">
								<div class="logo-font col-md-5 col-sm-3 col-xs-12">
									<img src="<%=request.getContextPath()%>/login/login-font.png">
								</div>
								<div class="col-sm-8 col-md-4 col-xs-12 pull-right">
									<div class="page-login-form box login">
										<div class="login-description clearfix">
											<span class="login-title">账号登录</span>
<!-- 											<span class="login-rg"><a href="/create-an-account">注册账号</a></span> -->
										</div>
										<form id="login" method="post" class="form-validate">
											<div class="form-group">
												<div class="group-control">
													<input type="text" name="loginCode" id="loginCode"
														class="validate-username required" size="25"
														placeholder="登录名" required aria-required="true"
														autofocus />
												</div>
											</div>
											<div class="form-group">
												<div class="group-control">
													<input type="password" name="password" id="password" placeholder="密码"
														class="validate-password required" size="25"
														maxlength="99" required aria-required="true" />
												</div>
											</div>
											
					<%-- 						<div class="form-group clearfix">
												<div class="col-md-8 col-sm-8 col-xs-8 group-control vafiy">
													<input type="text" name="loginVerCode" id="loginVerCode"
														 placeholder="请输入验证码" required aria-required="true"
														class="validate-username required" size="25"
														maxlength="99"   />
												</div>
												<div class="col-md-4 pull-right">
													<img alt="" title="看不清?换一张" id="loginPinCode" onclick="javascript:changeImg();return false;" 
														src="<%=request.getContextPath()%>/admin/system/pin/generateCode.ajax" style="width: 80px;height: 44px;">
												</div>
											</div> --%>
<!-- 											<div class="form-group clearfix"> -->
<!-- 												<span class="auto-login"><input type="checkbox">自动登录</span> -->
<!-- <!-- 												<span class="forget"><a href="/profile/edit?view=reset">忘记密码？</a></span> -->
<!-- 											</div>	 -->
											<div class="form-group">
												<button type="submit"
													class="btn btn-success btn-lg btn-login">
													登录</button>
											</div>
										
										</form>
									</div>
									<!-- <div class="form-links">
										<ul>
											<li><a href="/profile/edit?view=reset"> Forgot your
													password?</a></li>
											<li><a href="/profile/edit?view=remind"> Forgot your
													username?</a></li>
											<li><a href="/create-an-account"> Don't have an
													account?</a></li>
										</ul>
									</div> -->
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
		<footer>
			<p>技术支持：Copyright © 上海砾阳软件有限公司 All Rights Reserved | 沪ICP备09053411号-3 </p>
		</footer>
	</div>
	
	 <script type="text/javascript" language="javascript">
		function changeImg(){
			var img = document.getElementById("loginPinCode"); 
			img.src = "<%=request.getContextPath()%>/admin/system/pin/generateCode.ajax?date=" + new Date();
		}
	
		/***空方法 common.js运行***/
		function closeMask() {}
		
		$(document).keypress(function(event){  
		    var keycode = (event.keyCode ? event.keyCode : event.which);  
		    if(keycode == '13'){  
		    	//$("#loginBtn").click();
		    }  
		});
	 
        $("#login").on("submit", function(ev) {
            $.ajax({ 
            	type:"post",
    			url:"<%=request.getContextPath()%>/admin/login.ajax",
    			data :{
	    				loginCode:$("#loginCode").val(),
	    				password:$.md5($("#password").val()),
	    				loginVerCode:$("#loginVerCode").val()
    				},
    			success:function(data){
    				location.href="<%=request.getContextPath()%>/admin/index.do"; 			
    				return;
    			},
    			error:function(data){
    				changeImg();
    			}
            });  
            ev.preventDefault();  
        });  
    </script>
</body>
</html>