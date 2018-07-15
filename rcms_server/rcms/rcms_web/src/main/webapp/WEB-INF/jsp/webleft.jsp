<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<aside class="main-sidebar" style="z-index:100 !important">
    <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">
      <ul class="sidebar-menu">

        <c:forEach items="${menuList}" var="firstMenu">
	        <li <c:choose>
					<c:when test="${m_active_code==firstMenu.menuCode}">class="active treeview"</c:when>
					<c:otherwise>class="treeview"</c:otherwise>
				</c:choose>>
				  <a href="#">
					<i class="fa fa-dashboard"></i><span>${firstMenu.menuName}</span>
					<span class="pull-right-container">
					  <i class="fa fa-angle-left pull-right"></i>
					</span>
				  </a>
				  <ul class="treeview-menu">
					  <c:forEach items="${firstMenu.childMenuList}" var="secondMenu" >
						<li <c:if test="${m_active==secondMenu.actionUrl}">class="active"</c:if>> <a href="<%=request.getContextPath() %>${secondMenu.actionUrl}"><i class="fa fa-circle-o"></i>${secondMenu.menuName}</a></li>
					  </c:forEach>
				  </ul>
			</li>
		 </c:forEach>
<!--         <li class="active treeview"> -->
<!--           <a href="#"> -->
<!--             <i class="fa fa-files-o" ></i> -->
<!--             <span>流程测试</span> -->
<!--             <span class="pull-right-container"> -->
<!--               <i class="fa fa-angle-left pull-right"></i> -->
<!--             </span> -->
<!--           </a> -->
<!--           <ul class="treeview-menu"> -->
<%--             <li class="active"><a href="<%=request.getContextPath() %>/admin/task/taskToDo.do"><i class="fa fa-circle-o"></i>待办项目</a></li> --%>
<!--           </ul> -->
<!--         </li> -->
        

      </ul>
    </section>
  </aside>