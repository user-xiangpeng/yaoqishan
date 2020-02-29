<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>频道编辑</title>
<c:import url="../common/common.jsp"></c:import>
</head>

<body>
	<!-- 面包屑导航和主体内容 -->
	<div class="content">
		<!--面包屑导航-->
		<div class="content-header">
			<div class="breadcrumb">
				<span>界面</span>
				<span class="divider">/</span>
				<span class="active">频道编辑</span>
			</div>
		</div>

		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--修饰块元素名称-->
				<div class="banner">
					<p class="tab fixed">频道编辑</p>
				</div>
				<!--正文-->
				<div class="main">
					<!--表单-->
					<form id="form">
						<input type="hidden" name="id" value="${id}" />
						<!-- 频道名称 -->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">频道名称</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="name" value="${channelInfo.name}" data-type="必填" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!-- 排序序号 -->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">排序序号</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="sort" value="${channelInfo.sort}" data-type="非负整数" error-msg="请填写非负整数" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!-- 模板名称 -->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">模板名称</p>
							</div>
							<div class="right">
								<select id="template" name="template">
									<c:forEach items="${templateList}" var="template" varStatus="status" >
										<option value="${template.value}" <c:if test="${template.value==channelInfo.template}">selected</c:if>>${template.name}</option>
									</c:forEach>
								</select>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--title-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">title</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="title" value="${channelInfo.title}" />
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
								<input type="text" class="text" name="keywords" value="${channelInfo.keywords}" />
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
								<textarea class="desc" name="description">${channelInfo.description}</textarea>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--提交按钮-->
						<div class="unit" style="width: 800px;">
							<div style="text-align: center;">
								<!--表单提交时，必须是input元素，并指定type类型为button，否则ajax提交时，会返回error回调函数-->
								<a href="javascript:history.back();">
									<input type="button" id="return" class="button no" value="返回" />
								</a>
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

	javaex.select({
		id : "template",
		isSearch : false
	});
	
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
							// 跳转页面
							window.location.href = "list.action";
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
