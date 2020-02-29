<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<c:import url="../common/common.jsp"></c:import>
</head>

<body>
	<div class="content">
		<!--面包屑导航-->
		<div class="content-header">
			<div class="breadcrumb">
				<span>首页</span>
				<span class="divider">/</span>
				<span class="active">收费服务</span>
			</div>
		</div>
		
		<!--主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<h2>收费服务</h2>
				<div class="main">
					${info}
				</div>
			</div>
		</div>
	</div>
</body>
</html>
