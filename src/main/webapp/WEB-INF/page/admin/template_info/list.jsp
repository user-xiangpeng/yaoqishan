<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>模板设置</title>
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
				<span class="active">模板风格</span>
			</div>
		</div>
		
		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--页面有多个表格时，可以用于标识表格-->
				<h2>模板风格列表（电脑端）</h2>
				<!--正文内容-->
				<div class="main">
					<ul class="equal-4">
						<c:forEach items="${templateListPC}" var="entity" varStatus="status" >
							<li>
								<div style="width:200px;height:300px;">
									<img src="${entity.previewPath}" width="100%" height="100%" />
								</div>
								<c:choose>
									<c:when test="${templateInfoPC.name==entity.templateName}">
										<input type="radio" class="fill" name="pc" value="${entity.templateName}" checked />${entity.templateName}
									</c:when>
									<c:otherwise>
										<input type="radio" class="fill" name="pc" value="${entity.templateName}" />${entity.templateName}
									</c:otherwise>
								</c:choose>
							</li>
						</c:forEach>
						<!--清浮动-->
						<span class="clearfix"></span>
					</ul>
					<button id="save" class="button green" style="margin-top:20px;"><span class="icon-check2"></span> 保存</button>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	javaex.loading();
	
	var idArr = new Array();
	var nameArr = new Array();

	// 点击保存按钮事件
	$("#save").click(function() {
		var templatePC = $(':radio[name="pc"]:checked').val();
		
		javaex.optTip({
			content : "数据提交中，请稍候...",
			type : "submit"
		});
		
		$.ajax({
			url : "save.json",
			type : "POST",
			dataType : "json",
			data : {
				"templatePC" : templatePC
			},
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
	});
</script>
</html>
