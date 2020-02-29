<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link rel="shortcut icon" href=${pageContext.request.contextPath}/static/favicon.ico type=image/x-icon>
<!--字体图标-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/icomoon.css" rel="stylesheet" />
<!--动画-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/animate.css" rel="stylesheet" />
<!--骨架样式-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/common.css" rel="stylesheet" />
<!--皮肤（缇娜）-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/skin/tina.css" rel="stylesheet" />
<!--jquery，请勿轻易修改版本-->
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/lib/jquery-1.7.2.min.js"></script>
<!--全局动态修改-->
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/js/common.js"></script>
<!--核心组件-->
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/js/javaex.min.js"></script>
<!--表单验证-->
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/js/javaex-formVerify.js"></script>
<!--顶部导航-->
<div id="nav" class="admin-iframe-header">
	<h1 class="logo"><a href="javascript:;">妖气山后台管理</a></h1>
	<div class="admin-iframe-nav">
		<ul class="navs">
			<li class="nav active"><a href="${pageContext.request.contextPath}/admin/index.action">首页</a></li>
			<li class="nav"><a href="${pageContext.request.contextPath}/admin/basic.action">全局</a></li>
			<li class="nav"><a href="${pageContext.request.contextPath}/admin/layout.action">界面</a></li>
			<li class="nav"><a href="${pageContext.request.contextPath}/admin/user.action">用户</a></li>
			<li class="nav"><a href="${pageContext.request.contextPath}/admin/type.action">分类</a></li>
			<li class="nav"><a href="${pageContext.request.contextPath}/admin/content.action">视频</a></li>
			<li class="nav"><a href="${pageContext.request.contextPath}/admin/api.action">接口</a></li>
			<li class="nav"><a href="${pageContext.request.contextPath}/admin/founder.action">站长</a></li>
		</ul>
	</div>

	<!--右侧功能-->
	<div class="admin-iframe-header-right">
		<ul class="navs">
			<li class="nav">
				<p class="pull-left margin-left-10">欢迎您，<span id="admin_name">管理员</span></p>
				<label class="margin-left-10">|</label>
				<a href="${pageContext.request.contextPath}/admin/logout.action">退出</a>
			</li>
			<li class="nav"><a href="${pageContext.request.contextPath}/" target="_blank">站点首页</a></li>
		</ul>
	</div>
</div>

<script>
	$(function() {
		// 获取登录用户
		$.ajax({
			url : "${pageContext.request.contextPath}/admin/get_admin.json",
			type : "POST",
			dataType : "json",
			success : function(rtn) {
				if (rtn.code=="000000") {
					$("#admin_name").text(rtn.data.userInfo.loginName);
				}
			}
		});
	});
	
	javaex.nav({
		id : "nav",	// 导航的id
		isAutoSelected : true
	});
</script>