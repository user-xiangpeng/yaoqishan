<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>七牛云配置</title>
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
				<span class="active">图片上传设置</span>
			</div>
		</div>
		
		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--修饰块元素名称-->
				<div class="banner">
					<p class="tab fixed">${qiniuInfo.name}配置</p>
				</div>
				<!--正文-->
				<div class="main">
					<!--表单-->
					<form id="form">
						<input type="hidden" name="type" value="${type}" />
						
						<!--域名-->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">域名</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="domain" value="${qiniuInfo.domain}" data-type="必填" placeholder="http://xxx.xxx.com/" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--ak-->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">ak</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="ak" value="${qiniuInfo.ak}" data-type="必填" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--sk-->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">sk</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="sk" value="${qiniuInfo.sk}" data-type="必填" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--空间名称-->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">空间名称</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="bucket" value="${qiniuInfo.bucket}" data-type="必填" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--图片裁剪-->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">图片裁剪</p>
							</div>
							<div class="right">
								<span><input type="text" class="text" name="width" value="${qiniuInfo.width}" style="width: auto;" data-type="非负整数" error-msg="填写正整数或0" error-pos="50" placeholder="宽" /></span>
								<span><input type="text" class="text" name="height" value="${qiniuInfo.height}" style="width: auto;" data-type="非负整数" error-msg="填写正整数或0" error-pos="50" placeholder="高" /></span>
								<!--提示说明-->
								<p class="hint">0为不裁剪</p>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>

						<!--图片压缩率-->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">压缩率</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="compress" value="${qiniuInfo.compress}" data-type="非负整数" error-msg="填写正整数或0" />
								<!--提示说明-->
								<p class="hint">0为不压缩。75代表压缩后的质量为原图的75%</p>
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