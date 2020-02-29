<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>用户</title>
</head>
<body>
	<!-- 头部导航 -->
	<c:import url="../common/nav.jsp"></c:import>
	
	<div class="admin-iframe-content">
		<div class="admin-iframe-menu">
			<ul class="menu">
				<li class="active"><a href="javascript:page('${pageContext.request.contextPath}/group_info/list.action');">用户组</a></li>
			</ul>
			
			<ul class="menus">
				<li>
					<a href="javascript:;">用户管理</a>
					<ul class="menu">
						<li><a href="javascript:page('${pageContext.request.contextPath}/admin/user_info/list_normal.action');">正常用户</a></li>
						<li><a href="javascript:page('${pageContext.request.contextPath}/admin/user_info/list_not_active.action');">未激活用户</a></li>
						<li><a href="javascript:page('${pageContext.request.contextPath}/admin/user_info/list_ban.action');">封禁用户</a></li>
					</ul>
				</li>
			</ul>
		</div>

		<!--载入页面-->
		<div class="admin-markdown">
			<iframe id="page" src="${pageContext.request.contextPath}/group_info/list.action"></iframe>
		</div>
	</div>
	
	<!-- 底部js函数 -->
	<c:import url="../common/footer.jsp"></c:import>
</body>
</html>