<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="common/warning.jsp" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/common/js/jquery.md5.js"></script>
<script type="text/javascript">
$(function(){
	$("#passwordForm").bootstrapValidator({
    	message: 'This value is not valid',
    	fields: {
    		oldPassword: {
                validators: {
                    notEmpty: {
                        message: '登录密码不能为空'
                    },
                    regexp: {  
                        regexp: /^[a-zA-Z0-9_]+$/,  
                        message: '密码只能包含大写、小写、数字和下划线'  
                    },
                    stringLength: {
                        max: 50,
                         message: '密码长度不能大于50位'
                    },
                }
            },
            newPassword: {
                validators: {
                    notEmpty: {
                        message: '新密码不能为空'
                    },
                    regexp: {  
                        regexp: /^[a-zA-Z0-9_]+$/,  
                        message: '密码只能包含大写、小写、数字和下划线'  
                    },
                    stringLength: {
                        max: 50,
                         message: '新密码长度不能大于50位'
                    },
                    identical: {
                        field: 'confirmPassword',
                         message: '密码与确认密码不一致'
                   },
                }
            },
            confirmPassword: {
                validators: {
                    notEmpty: {
                        message: '确认密码不能为空'
                    },
                    regexp: {  
                        regexp: /^[a-zA-Z0-9_]+$/,  
                        message: '密码只能包含大写、小写、数字和下划线'  
                    },
                    stringLength: {
                        max: 50,
                         message: '确认密码长度不能大于50位'
                    },
                    identical: {
                        field: 'newPassword',
                         message: '确认密码与密码不一致'
                   },
                }
            },
    		
    	}
	})
})



   function loginOut(){
	   window.location.href="<%=request.getContextPath()%>/admin/logout.do"
   }
   function updatePassword(){
	   $.ajax({
			type:"post",
			url:"<%=request.getContextPath()%>/admin/user/queryPassword.ajax",
			
			success:function(data){
				var attrs = data.RSP_BODY.Data.entry;
				$("#updateUserName").val(attrs.userName);
				$("#updateUserId").val(attrs.userId);
				
				
				$("#passwordModal").modal('show');
				
			},error:function(data){
				
			}
		});
   }
   
   function save(){
	   $('#passwordForm').data('bootstrapValidator').resetForm();
	   $('#passwordForm').data('bootstrapValidator').validate();  
	   if(!$('#passwordForm').data('bootstrapValidator').isValid()){  
	        return ;  
	   }
	   $.ajax({  
       	    type:"post",
			url:"<%=request.getContextPath()%>/admin/user/updatePassword.ajax",
			data :{userId:$("#updateUserId").val(),password:$.md5($("#newPassword").val()),oldPassword:$.md5($("#oldPassword").val())},
			success:function(data){
				$("#passwordModal").modal('hide');
				window.top.warning("修改密码成功");
				$("#passwordForm")[0].reset();
			},
			error:function(data){
			}
       });  
   }
</script>
<header class="main-header" style="z-index:101 !important">
    <!-- Logo -->
    <div class="logo">
      <span class="logo-lg">RCMS</span>
    </div>
    <!-- Header Navbar: style can be found in header.less -->
    <nav class="navbar navbar-static-top">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="offcanvas" role="button">
      </a>
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- Messages: style can be found in dropdown.less-->
<!--           <li class="dropdown messages-menu"> -->
<!--             <a href="#" class="dropdown-toggle" data-toggle="dropdown"> -->
<!--               <i class="fa fa-envelope-o"></i> -->
<!--               <span class="label label-success">4</span> -->
<!--             </a> -->
<!--             <ul class="dropdown-menu"> -->
<!--               <li class="header">You have 4 messages</li> -->
<!--               <li> -->
<!--                 inner menu: contains the actual data -->
<!--                 <ul class="menu"> -->
<!--                   <li>start message -->
<!--                     <a href="#"> -->
<!--                       <div class="pull-left"> -->
<%--                         <img src="<%=request.getContextPath() %>/AdminLTE/dist/img/user2-160x160.jpg" class="img-circle" alt="User Image"> --%>
<!--                       </div> -->
<!--                       <h4> -->
<!--                         Support Team -->
<!--                         <small><i class="fa fa-clock-o"></i> 5 mins</small> -->
<!--                       </h4> -->
<!--                       <p>Why not buy a new awesome theme?</p> -->
<!--                     </a> -->
<!--                   </li> -->
<!--                   end message -->
<!--                   <li> -->
<!--                     <a href="#"> -->
<!--                       <div class="pull-left"> -->
<%--                         <img src="<%=request.getContextPath() %>/AdminLTE/dist/img/user3-128x128.jpg" class="img-circle" alt="User Image"> --%>
<!--                       </div> -->
<!--                       <h4> -->
<!--                         AdminLTE Design Team -->
<!--                         <small><i class="fa fa-clock-o"></i> 2 hours</small> -->
<!--                       </h4> -->
<!--                       <p>Why not buy a new awesome theme?</p> -->
<!--                     </a> -->
<!--                   </li> -->
<!--                   <li> -->
<!--                     <a href="#"> -->
<!--                       <div class="pull-left"> -->
<%--                         <img src="<%=request.getContextPath() %>/AdminLTE/dist/img/user4-128x128.jpg" class="img-circle" alt="User Image"> --%>
<!--                       </div> -->
<!--                       <h4> -->
<!--                         Developers -->
<!--                         <small><i class="fa fa-clock-o"></i> Today</small> -->
<!--                       </h4> -->
<!--                       <p>Why not buy a new awesome theme?</p> -->
<!--                     </a> -->
<!--                   </li> -->
<!--                   <li> -->
<!--                     <a href="#"> -->
<!--                       <div class="pull-left"> -->
<%--                         <img src="<%=request.getContextPath() %>/AdminLTE/dist/img/user3-128x128.jpg" class="img-circle" alt="User Image"> --%>
<!--                       </div> -->
<!--                       <h4> -->
<!--                         Sales Department -->
<!--                         <small><i class="fa fa-clock-o"></i> Yesterday</small> -->
<!--                       </h4> -->
<!--                       <p>Why not buy a new awesome theme?</p> -->
<!--                     </a> -->
<!--                   </li> -->
<!--                   <li> -->
<!--                     <a href="#"> -->
<!--                       <div class="pull-left"> -->
<%--                         <img src="<%=request.getContextPath() %>/AdminLTE/dist/img/user4-128x128.jpg" class="img-circle" alt="User Image"> --%>
<!--                       </div> -->
<!--                       <h4> -->
<!--                         Reviewers -->
<!--                         <small><i class="fa fa-clock-o"></i> 2 days</small> -->
<!--                       </h4> -->
<!--                       <p>Why not buy a new awesome theme?</p> -->
<!--                     </a> -->
<!--                   </li> -->
<!--                 </ul> -->
<!--               </li> -->
<!--               <li class="footer"><a href="#">See All Messages</a></li> -->
<!--             </ul> -->
<!--           </li> -->
<!--           Notifications: style can be found in dropdown.less -->
<!--           <li class="dropdown notifications-menu"> -->
<!--             <a href="#" class="dropdown-toggle" data-toggle="dropdown"> -->
<!--               <i class="fa fa-bell-o"></i> -->
<!--               <span class="label label-warning">10</span> -->
<!--             </a> -->
<!--             <ul class="dropdown-menu"> -->
<!--               <li class="header">You have 10 notifications</li> -->
<!--               <li> -->
<!--                 inner menu: contains the actual data -->
<!--                 <ul class="menu"> -->
<!--                   <li> -->
<!--                     <a href="#"> -->
<!--                       <i class="fa fa-users text-aqua"></i> 5 new members joined today -->
<!--                     </a> -->
<!--                   </li> -->
<!--                   <li> -->
<!--                     <a href="#"> -->
<!--                       <i class="fa fa-warning text-yellow"></i> Very long description here that may not fit into the -->
<!--                       page and may cause design problems -->
<!--                     </a> -->
<!--                   </li> -->
<!--                   <li> -->
<!--                     <a href="#"> -->
<!--                       <i class="fa fa-users text-red"></i> 5 new members joined -->
<!--                     </a> -->
<!--                   </li> -->
<!--                   <li> -->
<!--                     <a href="#"> -->
<!--                       <i class="fa fa-shopping-cart text-green"></i> 25 sales made -->
<!--                     </a> -->
<!--                   </li> -->
<!--                   <li> -->
<!--                     <a href="#"> -->
<!--                       <i class="fa fa-user text-red"></i> You changed your username -->
<!--                     </a> -->
<!--                   </li> -->
<!--                 </ul> -->
<!--               </li> -->
<!--               <li class="footer"><a href="#">View all</a></li> -->
<!--             </ul> -->
<!--           </li> -->
<!--           Tasks: style can be found in dropdown.less -->
<!--           <li class="dropdown tasks-menu"> -->
<!--             <a href="#" class="dropdown-toggle" data-toggle="dropdown"> -->
<!--               <i class="fa fa-flag-o"></i> -->
<!--               <span class="label label-danger">9</span> -->
<!--             </a> -->
<!--             <ul class="dropdown-menu"> -->
<!--               <li class="header">You have 9 tasks</li> -->
<!--               <li> -->
<!--                 inner menu: contains the actual data -->
<!--                 <ul class="menu"> -->
<!--                   <li>Task item -->
<!--                     <a href="#"> -->
<!--                       <h3> -->
<!--                         Design some buttons -->
<!--                         <small class="pull-right">20%</small> -->
<!--                       </h3> -->
<!--                       <div class="progress xs"> -->
<!--                         <div class="progress-bar progress-bar-aqua" style="width: 20%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"> -->
<!--                           <span class="sr-only">20% Complete</span> -->
<!--                         </div> -->
<!--                       </div> -->
<!--                     </a> -->
<!--                   </li> -->
<!--                   end task item -->
<!--                   <li>Task item -->
<!--                     <a href="#"> -->
<!--                       <h3> -->
<!--                         Create a nice theme -->
<!--                         <small class="pull-right">40%</small> -->
<!--                       </h3> -->
<!--                       <div class="progress xs"> -->
<!--                         <div class="progress-bar progress-bar-green" style="width: 40%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"> -->
<!--                           <span class="sr-only">40% Complete</span> -->
<!--                         </div> -->
<!--                       </div> -->
<!--                     </a> -->
<!--                   </li> -->
<!--                   end task item -->
<!--                   <li>Task item -->
<!--                     <a href="#"> -->
<!--                       <h3> -->
<!--                         Some task I need to do -->
<!--                         <small class="pull-right">60%</small> -->
<!--                       </h3> -->
<!--                       <div class="progress xs"> -->
<!--                         <div class="progress-bar progress-bar-red" style="width: 60%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"> -->
<!--                           <span class="sr-only">60% Complete</span> -->
<!--                         </div> -->
<!--                       </div> -->
<!--                     </a> -->
<!--                   </li> -->
<!--                   end task item -->
<!--                   <li>Task item -->
<!--                     <a href="#"> -->
<!--                       <h3> -->
<!--                         Make beautiful transitions -->
<!--                         <small class="pull-right">80%</small> -->
<!--                       </h3> -->
<!--                       <div class="progress xs"> -->
<!--                         <div class="progress-bar progress-bar-yellow" style="width: 80%" role="progressbar" aria-valuenow="20" aria-valuemin="0" aria-valuemax="100"> -->
<!--                           <span class="sr-only">80% Complete</span> -->
<!--                         </div> -->
<!--                       </div> -->
<!--                     </a> -->
<!--                   </li> -->
<!--                   end task item -->
<!--                 </ul> -->
<!--               </li> -->
<!--               <li class="footer"> -->
<!--                 <a href="#">View all tasks</a> -->
<!--               </li> -->
<!--             </ul> -->
<!--           </li> -->
          <!-- User Account: style can be found in dropdown.less -->
          <li class="dropdown user user-menu">
            <a href="#" class="dropdown-toggle" data-toggle="dropdown">
              <img src="<%=request.getContextPath() %>${loginUserPhoto}" onerror="this.src='<%=request.getContextPath()%>/common/images/defaultPhoto.png'" class="user-image" >
              <span class="hidden-xs">${ADMIN_LOGIN.userName}</span>
            </a>
            <ul class="dropdown-menu">
              <!-- User image -->
              <li class="user-header">
                <img src="<%=request.getContextPath() %>${loginUserPhoto}" onerror="this.src='<%=request.getContextPath()%>/common/images/defaultPhoto.png'" class="img-circle" >
                <p>
                 ${ADMIN_LOGIN.userName}
                </p>
              </li>
              
              <!-- Menu Footer-->
              <li class="user-footer">
                <div class="pull-left" onClick="updatePassword()">
                  <a href="#" class="btn btn-default btn-flat">修改密码</a>
                </div>
                <div class="pull-right" onClick="loginOut()">
                  <a href="#" class="btn btn-default btn-flat">退出</a>
                </div>
              </li>
            </ul>
          </li>
          <!-- Control Sidebar Toggle Button -->
        </ul>
      </div>
      <!-- 模态框开始 -->
      <div class="modal fade" id="passwordModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" data-backdrop="static">
	       <div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">
					&times;
				</button>
				<h4 class="modal-title" >密码修改</h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" id="passwordForm">
                     <div class="form-group">
                          <label for="inputEmail3" class="col-sm-3 control-label">人员名称：</label>
                            <div class="col-sm-6">
                                  <input type="text" class="form-control" name="updateUserName" id="updateUserName" readonly>
                             </div>
                     </div>
                     <div class="form-group">
                           <label for="inputPassword3" class="col-sm-3 control-label">登录密码：</label>
                               <div class="col-sm-6">
                                    <input type="password" class="form-control" name="oldPassword" id="oldPassword"  onchange="samePassword()" >
                                </div>
                     </div>
                     <div class="form-group">
                           <label for="inputPassword3" class="col-sm-3 control-label">请输入新密码：</label>
                               <div class="col-sm-6">
                                    <input type="password" class="form-control" name="newPassword" id="newPassword" >
                                </div>
                     </div>
                     <div class="form-group">
                           <label for="inputPassword3" class="col-sm-3 control-label">确认新密码：</label>
                               <div class="col-sm-6">
                                    <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" >
                                </div>
                     </div>
                      <input type="hidden" id="updateUserId" name="updateUserId">
                      
                 </form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">关闭
				</button>
				<button type="button" class="btn btn-primary" onclick="save()" id="deptAddBtn" value=" ">
					保存
				</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal -->
</div>
     <!-- 模态框结束 --> 
    </nav>
 </header>