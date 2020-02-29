<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>视频信息编辑</title>
<c:import url="../common/common.jsp"></c:import>
</head>
<body>
	<!-- 面包屑导航和主体内容 -->
	<div class="content">
		<!--面包屑导航-->
		<div class="content-header">
			<div class="breadcrumb">
				<span>视频管理</span>
				<span class="divider">/</span>
				<span class="active">视频播放地址编辑</span>
			</div>
		</div>
		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--修饰块元素名称-->
				<div class="banner">
					<p class="tab fixed">${biaoti}</p>
				</div>

				<!--正文-->
				<div class="main">
					<!--表单-->
					<form id="form">
						<input type="hidden" name="videoId" value="${videoInfo.videoId}" />
						<input type="hidden" name="mediaId" value="${mediaId}" />
						
						<!--上传封面-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">封面</p>
							</div>
							<div class="right">
								<div class="grid-1-9">
									<div style="min-width:142px;">
										<!-- 图片承载容器 -->
										<label for="upload" style="display: inline-block; width:132px;height:80.6px;">
											<c:choose>
												<c:when test="${empty videoInfo.image}">
													<img id="upload_image" src="${pageContext.request.contextPath}/static/default/javaex/pc/images/default.png" width="100%" height="100%" />
												</c:when>
												<c:otherwise>
													<img id="upload_image" src="${videoInfo.image}" width="100%" height="100%" />
												</c:otherwise>
											</c:choose>
										</label>
										<input type="file" class="hide" id="upload" accept="image/gif, image/jpeg, image/jpg, image/png" />
									</div>
									<div style="position: relative;">
										<input type="text" id="image" class="text" style="position: absolute;bottom: 0;width:84%;" name="image" value="${videoInfo.image}" />
										<input type="button" id="upload_fengmian_by_yuancheng" class="button green" style="position: absolute;width: 60px;bottom: 0;right: -20px;" value="远程上传" />
									</div>
								</div>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--第几集-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">第几集</p>
							</div>
							<div class="right">
								<input type="text" class="text" id="num" name="num" value="${videoInfo.num}" onblur="fillSort()" />
								<!--提示说明-->
								<p class="hint">并不是一定要写数字型，可以写任意字符</p>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--排序-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">排序</p>
							</div>
							<div class="right">
								<input type="text" class="text" id="sort" name="sort" data-type="空|非负整数" error-msg="请填写非负整数" value="${videoInfo.sort}" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--标题-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">标题</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="title" value="${videoInfo.title}" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--播放器-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">播放器</p>
							</div>
							<div class="right">
								<select id="playerId" name="playerId">
									<c:forEach items="${playerList}" var="playerInfo" varStatus="status" >
										<option value="${playerInfo.id}" <c:if test="${playerInfo.id==videoInfo.playerId}">selected</c:if>>${playerInfo.name}</option>
									</c:forEach>
								</select>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--播放地址-->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">播放地址</p>
							</div>
							<div class="right">
								<input type="text" class="text" id="url" name="url" value="${videoInfo.url}" data-type="必填" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--播放次数-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">播放次数</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="viewCount" data-type="空|非负整数" error-msg="正整数格式错误" value="${videoInfo.viewCount}" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--播放权限-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">播放权限</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="power" data-type="空|非负整数" error-msg="非负整数格式错误" value="${videoInfo.power}" />
								<!--提示说明-->
								<p class="hint">如果不填或填0，则该视频对游客开放</p>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--视频简介-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">视频简介</p>
							</div>
							<div class="right">
								<textarea class="desc" name="remark">${videoInfo.remark}</textarea>
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
		id : "playerId",
		isSearch : false
	});

	// 根据集数，自动填充排序
	function fillSort() {
		$("#sort").val($("#num").val());
	}
	
	// 上传封面
	javaex.upload({
		type : "image",
		url : "${pageContext.request.contextPath}/qiniu_info/upload_image.json?type=fengmian",	// 请求路径
		id : "upload",	// <input type="file" />的id
		param : "file",			// 参数名称，SSM中与MultipartFile的参数名保持一致
		dataType : "url",		// 返回的数据类型：base64 或 url
		callback : function (rtn) {
			// 后台返回的数据
			if (rtn.code=="000000") {
				var imgUrl = rtn.data.imgUrl;
				$("#upload_image").attr("src", imgUrl);
				$("#image").val(imgUrl);
			} else {
				javaex.optTip({
					content : rtn.msg,
					type : "error"
				});
			}
		}
	});
	
	// 远程上传封面
	$("#upload_fengmian_by_yuancheng").click(function() {
		var imgUrl = $("#image").val();
		if (imgUrl=="") {
			javaex.optTip({
				content : "请填写远程图片地址",
				type : "error"
			});
			return;
		}
		
		imgUrl = imgUrl.replace("https", "http");
		// 如果是爱奇艺的图片
		if (imgUrl.indexOf("qiyipic")>0) {
			imgUrl = imgUrl.replace("220_124", "320_180");
			imgUrl = imgUrl.replace("180_101", "320_180");
			imgUrl = imgUrl.replace("160_90", "320_180");
			imgUrl = imgUrl.replace("116_65", "320_180");
		}
		
		javaex.optTip({
			content : "图片上传中，请稍候...",
			type : "submit"
		});
		
		$.ajax({
			url : "${pageContext.request.contextPath}/qiniu_info/upload_image_by_yuancheng.json",
			type : "POST",
			dataType : "json",
			data : {
				"imgUrl" : imgUrl,
				"type" : "fengmian"
			},
			success : function(rtn) {
				// 后台返回的数据
				if (rtn.code=="000000") {
					javaex.optTip({
						content : "上传成功",
						type : "success",
						live : 1000
					});
					
					var imgUrl = rtn.data.imgUrl;
					$("#upload_image").attr("src", imgUrl);
					$("#image").val(imgUrl);
				} else {
					javaex.optTip({
						content : rtn.message,
						type : "error"
					});
				}
			}
		});
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
							window.location.href = "list.action?mediaId=${mediaId}";
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