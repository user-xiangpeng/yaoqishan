<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>全局</title>
</head>
<body>
	<!-- 头部导航 -->
	<c:import url="../common/nav.jsp"></c:import>
	
	<div class="admin-iframe-content">
		<div class="admin-iframe-menu">
			<ul class="menu">
				<li class="active"><a href="javascript:page('${pageContext.request.contextPath}/web_info/edit.action');">站点信息</a></li>
			</ul>
			
			<ul class="menus">
				<li>
					<a href="javascript:;">SEO设置</a>
					<ul class="menu">
						<li><a href="javascript:page('${pageContext.request.contextPath}/seo_info/edit.action?type=index');">网站首页</a></li>
						<li><a href="javascript:page('${pageContext.request.contextPath}/seo_info/edit.action?type=list');">分类检索页</a></li>
						<li><a href="javascript:page('${pageContext.request.contextPath}/seo_info/edit.action?type=profile');">视频详情页</a></li>
						<li><a href="javascript:page('${pageContext.request.contextPath}/seo_info/edit.action?type=play');">视频播放页</a></li>
					</ul>
				</li>
			</ul>
			
			<ul class="menus">
				<li>
					<a href="javascript:;">七牛云上传设置</a>
					<ul class="menu">
						<li><a href="javascript:page('${pageContext.request.contextPath}/qiniu_info/edit.action?type=haibao');">上传海报</a></li>
						<li><a href="javascript:page('${pageContext.request.contextPath}/qiniu_info/edit.action?type=dafengmian');">上传大封面</a></li>
						<li><a href="javascript:page('${pageContext.request.contextPath}/qiniu_info/edit.action?type=fengmian');">上传小封面</a></li>
						<li><a href="javascript:page('${pageContext.request.contextPath}/qiniu_info/edit.action?type=touxiang');">上传头像</a></li>
						<li><a href="javascript:page('${pageContext.request.contextPath}/qiniu_info/edit.action?type=content');">简介中的图片</a></li>
					</ul>
				</li>
			</ul>
		</div>
		
		<!--载入页面-->
		<div class="admin-markdown">
			<iframe id="page" src="${pageContext.request.contextPath}/web_info/edit.action"></iframe>
		</div>
	</div>
	
	<!-- 底部js函数 -->
	<c:import url="../common/footer.jsp"></c:import>
</body>
</html>