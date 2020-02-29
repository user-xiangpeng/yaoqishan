<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>网站首页seo信息</title>
<c:import url="../common/common.jsp"></c:import>
</head>

<body>
	<!-- 面包屑导航和主体内容 -->
	<div class="content">
		<!--面包屑导航-->
		<div class="content-header">
			<div class="breadcrumb">
				<span>全局</span>
				<span class="divider">/</span>
				<span class="active">网站首页SEO信息</span>
			</div>
		</div>
		
		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--修饰块元素名称-->
				<div class="banner">
					<p class="tab fixed">网站首页SEO信息配置</p>
				</div>
				<!--正文-->
				<div class="main">
					<!--表单-->
					<form id="form">
						<input type="hidden" name="type" value="${seoInfo.type}" />
						<!--title-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">title</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="title" value="${seoInfo.title}" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--keywords-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">keywords</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="keywords" value="${seoInfo.keywords}" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--description-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">description</p>
							</div>
							<div class="right">
								<textarea class="desc" name="description">${seoInfo.description}</textarea>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--提交按钮-->
						<div class="unit" style="width: 800px;">
							<div style="text-align: center;">
								<!--表单提交时，必须是input元素，并指定type类型为button，否则ajax提交时，会返回error回调函数-->
								<input type="button" id="save" class="button yes" value="保存" />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	javaex.loading();

	// 点击保存按钮事件
	$("#save").click(function() {
		if (javaexVerify()) {
			javaex.optTip({
				content : "数据提交中，请稍候...",
				type : "submit"
			});
			
			$.ajax({
				url : "${pageContext.request.contextPath}/seo_info/save.json",
				type : "POST",
				dataType : "json",
				data : $("#form").serialize(),
				success : function(rtn) {
					if (rtn.code=="000000") {
						javaex.optTip({
							content : rtn.message,
							type : "success"
						});
						// 建议延迟加载
						setTimeout(function() {
							window.location.reload();
						}, 2000);
					} else {
						javaex.optTip({
							content : rtn.message,
							type : "error"
						});
					}
				}
			});
		}
	});
</script>
</html>