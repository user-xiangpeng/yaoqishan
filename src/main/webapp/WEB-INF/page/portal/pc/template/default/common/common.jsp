<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<!--cookie-->
<script src="${pageContext.request.contextPath}/static/default/js/cookie.js"></script>

<style>
	.equal-2 > li{position: relative;margin-bottom: 20px;}
	.poly-ul-img{width: 200px;height: 112px;}
	.poly-title{height: 40px;line-height: 45px;background: linear-gradient(transparent,rgba(0,0,0,0.1) 20%,rgba(0,0,0,0.2) 35%,rgba(0,0,0,0.6) 65%,rgba(0,0,0,0.9));font-size: 14px;font-weight: 500;color: #fff;padding: 0 10px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;position: absolute;bottom: 0;left: 0;width: 180px;}
	.big-cover .screenshot{display: block;width: 420px;height: 288px;position: relative;}
	.cover .screenshot{display: block;width: 200px;height: 112px;position: relative;}
	.poster .screenshot{display: block;width: 200px;height: 300px;position: relative;}
	.screenshot-title a{font-size: 14px;color: #333;text-decoration: none;}
	.big-cover li p, .cover li p, .poster li p{padding-right: 20px;font-size: 12px;color: #999;display: block;overflow: hidden;height: 18px;line-height: 18px;}
	.big-cover li a:hover, .cover li a:hover, .poster li a:hover{color: #2fb3ff;opacity: 0.9;}
	.screenshot-title{margin-top: 8px;}
	.duration{line-height: 18px;height: 18px;position: absolute;top: 86px;right: 10px;padding: 0 5px;color: #fff;z-index: 9;background: #000;opacity: .8;-ms-filter: alpha(opacity=50);filter: alpha(opacity=50);font-size: 12px;}
	.big-cover .duration{top: 262px;}
	.equal-6{width: 1320px;}
	.equal-4 > li, .equal-6 > li{margin-bottom: 20px;}
</style>