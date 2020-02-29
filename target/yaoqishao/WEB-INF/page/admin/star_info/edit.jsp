<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>明星管理</title>
</head>
<style>
	input.text{width:226px;}
	.win.win-hint{left:0;}
</style>
<body>
	<div class="wrap">
		<!-- 头部 -->
		<div id="header">
			<c:import url="../common/header.jsp"></c:import>
		</div>
		<!-- 左侧菜单和主体内容 -->
		<div class="grid-1-7" style="flex: 1;margin:0;">
			<!-- 左侧菜单 -->
			<c:import url="../common/menu.jsp"></c:import>
			
			<!-- 面包屑导航和主体内容 -->
			<div class="content">
				<!--面包屑导航-->
				<div class="content-header">
					<div class="breadcrumb">
						<span>明星管理</span>
						<span class="divider">/</span>
						<span class="active">明星编辑</span>
					</div>
				</div>
				<!--全部主体内容-->
				<div class="list-content">
					<!--块元素-->
					<div class="block">
						<!--修饰块元素名称-->
						<div class="banner">
							<p class="tab fixed">明星信息编辑</p>
						</div>
						<!--正文-->
						<div class="main">
							<div class="grid-1-6-1">
								<div></div>
								<div>
									<!--表单-->
									<form id="form">
										<input type="hidden" name="id" value="${id}" />
										
										<!--照片-->
										<div class="unit">
											<div style="margin-left:44px;">
												<!--上传按钮-->
												<!-- 图片承载容器 -->
												<label id="container" for="upload" style="display: inline-block; width:200px;height:200px;">
													<c:choose>
														<c:when test="${empty starInfo.image}">
															<img src="${pageContext.request.contextPath}/static/javaex/pc/images/default.png" width="100%" height="100%" />
														</c:when>
														<c:otherwise>
															<img src="${starInfo.image}" width="100%" height="100%" />
														</c:otherwise>
													</c:choose>
												</label>
												<input type="file" class="hide" id="upload" accept="image/gif, image/jpeg, image/jpg, image/png" />
											</div>
											<!--清浮动-->
											<span class="clearfix"></span>
										</div>

										<!--照片地址-->
										<div class="unit">
											<div style="float: left;">
												<p class="subtitle">照片</p>
											</div>
											<div class="right" style="margin-left:4px;">
												<input type="text" class="text" id="image" name="image" value="${starInfo.image}" />
											</div>
											<!--清浮动-->
											<span class="clearfix"></span>
										</div>
										<!--分割线-->
										<p class="divider"></p>
										
										<!--姓名、别名、地区-->
										<div class="unit">
											<p class="subtitle">姓名</p>
											<span><input type="text" class="text" name="name" data-type="必填" value="${starInfo.name}" /></span>
											<p class="subtitle">别名</p>
											<input type="text" class="text" name="alias" value="${starInfo.alias}" />
											<p class="subtitle">地区</p>
											<input type="text" class="text" name="region" value="${starInfo.region}" />
										</div>
										<!--分割线-->
										<p class="divider"></p>
										
										<!--性别-->
										<div class="unit">
											<p class="subtitle">性别</p>
											<input type="radio" class="fill" name="sex" value="男" checked />男
											<span style="display:inline-block;width:20px;"></span>
											<input type="radio" class="fill" name="sex" value="女" />女
										</div>
										<!--分割线-->
										<p class="divider"></p>
										
										<!--血型-->
										<div class="unit">
											<p class="subtitle">血型</p>
											<select id="blood" name="blood">
												<option value="">请选择</option>
												<c:forEach items="${bloodList}" var="blood" varStatus="status" >
													<option value="${blood.value}" <c:if test="${blood.value==starInfo.blood}">selected</c:if>>${blood.name}</option>
												</c:forEach>
											</select>
										</div>
										<!--分割线-->
										<p class="divider"></p>
										
										<!--生日-->
										<div class="unit">
											<p class="subtitle">生日</p>
											<input type="text" id="birthday" name="birthday" class="date" style="width: 160px;" value="" readonly/>
										</div>
										<!--分割线-->
										<p class="divider"></p>
										
										<!--星座-->
										<div class="unit">
											<p class="subtitle">星座</p>
											<select id="constellation" name="constellation">
												<option value="">请选择</option>
												<c:forEach items="${constellationList}" var="constellation" varStatus="status" >
													<option value="${constellation.value}" <c:if test="${constellation.value==starInfo.constellation}">selected</c:if>>${constellation.name}</option>
												</c:forEach>
											</select>
										</div>
										<!--分割线-->
										<p class="divider"></p>
										
										<!--职业-->
										<div class="unit">
											<div style="float: left;">
												<p class="subtitle">职业</p>
											</div>
											<div class="right" style="margin-left:4px;">
												<input type="text" class="text" name="occupation" value="${starInfo.occupation}" />
											</div>
											<!--清浮动-->
											<span class="clearfix"></span>
										</div>
										<!--分割线-->
										<p class="divider"></p>
										
										<!--简介-->
										<div class="unit">
											<div style="float: left;">
												<p class="subtitle">简介</p>
											</div>
											<div class="right" style="margin-left:4px;">
												<textarea class="desc" style="height: 100px;" name="introduction" placeholder="请填写简介">${starInfo.introduction}</textarea>
												<!--提示说明-->
												<p class="hint">请填写个人简介。简介中不得包含令人反感的信息，且长度应在10到255个字符之间。</p>
											</div>
											<!--清浮动-->
											<span class="clearfix"></span>
										</div>
										<!--分割线-->
										<p class="divider"></p>
										
										<!--提交按钮-->
										<div class="unit">
											<div style="margin-left: 200px;">
												<!--表单提交时，必须是input元素，并指定type类型为button，否则ajax提交时，会返回error回调函数-->
												<input type="button" id="return" class="button no" value="返回" />
												<input type="button" id="save" class="button yes" value="保存" />
											</div>
											<!--清浮动-->
											<span class="clearfix"></span>
										</div>
									</form>
								</div>
								<div></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	javaex.loading();

	$(function() {
		// 回显单选框选中值
		$(':radio[name="sex"][value="${starInfo.sex}"]').attr("checked", true);
	});
	
	javaex.select({
		id : "blood",
		isSearch : false
	});
	
	javaex.select({
		id : "constellation",
		isSearch : false
	});
	
	javaex.date({
		id : "birthday",		// 承载日期组件的id
		monthNum : 1,	// 1代表选择单日日期
		date : "${starInfo.birthday}"
	});
	
	javaex.upload({
		type : "image",
		url : "${pageContext.request.contextPath}/upload/upload_image.json",	// 请求路径
		id : "upload",	// <input type="file" />的id
		param : "file",			// 参数名称，SSM中与MultipartFile的参数名保持一致
		dataType : "url",		// 返回的数据类型：base64 或 url
		callback : function (rtn) {
			// 后台返回的数据
			if (rtn.code=="000000") {
				var imgUrl = rtn.data.imgUrl;
				$("#container img").attr("src", imgUrl);
				$("#image").val(imgUrl);
			} else {
				javaex.optTip({
					content : rtn.msg,
					type : "error"
				});
			}
		}
	});
	
	$("#return").click(function() {
		history.back();
	});
	
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