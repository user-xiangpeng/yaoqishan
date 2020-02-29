<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>网站信息</title>
<c:import url="../common/common.jsp"></c:import>
<style>
.unit .left {
	width: 120px !important;
}
</style>
</head>

<body>
	<!-- 面包屑导航和主体内容 -->
	<div class="content">
		<!--面包屑导航-->
		<div class="content-header">
			<div class="breadcrumb">
				<span>全局</span>
				<span class="divider">/</span>
				<span class="active">站点信息</span>
			</div>
		</div>
		
		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--修饰块元素名称-->
				<div class="banner">
					<p class="tab fixed">站点信息配置</p>
				</div>
				<!--正文-->
				<div class="main">
					<!--表单-->
					<form id="form">
						<!--网站名称-->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">网站名称</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="name" value="${webInfo.name}" data-type="必填" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--网站 URL-->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">网站 URL</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="domain" value="${webInfo.domain}" data-type="必填" />
								<!--提示说明-->
								<p class="hint">开头带上http或https，结尾必须带<font color="red">/</font></p>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--管理员邮箱-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">管理员邮箱</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="email" value="${webInfo.email}" data-type="空|邮箱" error-msg="邮箱格式错误" />
								<p class="hint">管理员邮箱，将作为网站的收件箱</p>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--网站备案信息代码-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">备案信息</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="recordNumber" value="${webInfo.recordNumber}" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--网站第三方统计代码-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">统计代码</p>
							</div>
							<div class="right">
								<textarea name="statisticalCode" class="desc">${webInfo.statisticalCode}</textarea>
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
				url : "save.json",
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