<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>媒体信息编辑</title>
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
				<span class="active">媒体信息编辑</span>
			</div>
		</div>
		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--修饰块元素名称-->
				<div class="banner">
					<p class="tab fixed">媒体信息编辑</p>
				</div>
				<!--正文-->
				<div class="main">
					<!--表单-->
					<form id="form">
						<input type="hidden" name="type_id" value="${typeId}" />
						<input type="hidden" name="media_id" value="${mediaId}" />
						
						<!--上传海报-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">海报</p>
							</div>
							<div class="right">
								<div class="grid-1-9">
									<div style="min-width:142px;">
										<!-- 图片承载容器 -->
										<label for="upload" style="display: inline-block; width:132px;height:192px;">
											<c:choose>
												<c:when test="${empty mediaInfo.haibao}">
													<img id="upload_haibao" src="${pageContext.request.contextPath}/static/default/javaex/pc/images/default.png" width="100%" height="100%" />
												</c:when>
												<c:otherwise>
													<img id="upload_haibao" src="${mediaInfo.haibao}" width="100%" height="100%" />
												</c:otherwise>
											</c:choose>
										</label>
										<input type="file" class="hide" id="upload" accept="image/gif, image/jpeg, image/jpg, image/png" />
									</div>
									<div style="position: relative;">
										<input type="text" id="haibao" class="text" style="position: absolute;bottom: 0;width:84%;" name="haibao" value="${mediaInfo.haibao}" />
										<input type="button" id="upload_haibao_by_yuancheng" class="button green" style="position: absolute;width: 60px;bottom: 0;right: -20px;" value="远程上传" />
									</div>
								</div>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--上传大封面-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">大封面</p>
							</div>
							<div class="right">
								<div class="grid-1-9">
									<div style="min-width:142px;">
										<!-- 图片承载容器 -->
										<label for="upload2" style="display: inline-block; width:132px;height:80.6px;">
											<c:choose>
												<c:when test="${empty mediaInfo.dafengmian}">
													<img id="upload_dafengmian" src="${pageContext.request.contextPath}/static/default/javaex/pc/images/default.png" width="100%" height="100%" />
												</c:when>
												<c:otherwise>
													<img id="upload_dafengmian" src="${mediaInfo.dafengmian}" width="100%" height="100%" />
												</c:otherwise>
											</c:choose>
										</label>
										<input type="file" class="hide" id="upload2" accept="image/gif, image/jpeg, image/jpg, image/png" />
									</div>
									<div style="position: relative;">
										<input type="text" id="dafengmian" class="text" style="position: absolute;bottom: 0;width:84%;" name="dafengmian" value="${mediaInfo.dafengmian}" />
										<input type="button" id="upload_dafengmian_by_yuancheng" class="button green" style="position: absolute;width: 60px;bottom: 0;right: -20px;" value="远程上传" />
									</div>
								</div>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--上传小封面-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">小封面</p>
							</div>
							<div class="right">
								<div class="grid-1-9">
									<div style="min-width:142px;">
										<!-- 图片承载容器 -->
										<label for="upload3" style="display: inline-block; width:132px;height:80.6px;">
											<c:choose>
												<c:when test="${empty mediaInfo.fengmian}">
													<img id="upload_fengmian" src="${pageContext.request.contextPath}/static/default/javaex/pc/images/default.png" width="100%" height="100%" />
												</c:when>
												<c:otherwise>
													<img id="upload_fengmian" src="${mediaInfo.fengmian}" width="100%" height="100%" />
												</c:otherwise>
											</c:choose>
										</label>
										<input type="file" class="hide" id="upload3" accept="image/gif, image/jpeg, image/jpg, image/png" />
									</div>
									<div style="position: relative;">
										<input type="text" id="fengmian" class="text" style="position: absolute;bottom: 0;width:84%;" name="fengmian" value="${mediaInfo.fengmian}" />
										<input type="button" id="upload_fengmian_by_yuancheng" class="button green" style="position: absolute;width: 60px;bottom: 0;right: -20px;" value="远程上传" />
									</div>
								</div>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!-- 标题 -->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">标题</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="biaoti" data-type="必填" value="${mediaInfo.biaoti}" style="width: 82%;" />
								<input type="checkbox" class="fill" name="repeat" value="1">允许重复
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!-- 别名 -->
						<div class="unit">
							<div class="left">
								<p class="subtitle">别名</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="bieming" value="${mediaInfo.bieming}" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!-- 根据字段模板，自动生成填写内容 -->
						<c:forEach items="${fieldInfoList}" var="FieldInfo">
							${FieldInfo.content}
						</c:forEach>
						
						<!-- 简介 -->
						<div class="unit">
							<div class="left">
								<p class="subtitle">简介</p>
							</div>
							<div class="right">
								<div id="edit" class="edit-container"></div>
								<input type="hidden" id="jianjie" name="jianjie" value="${mediaInfo.jianjie}" />
							</div>
							<span class="clearfix"></span>
						</div>
						
						<!-- 标签 -->
						<div class="unit">
							<div class="left">
								<p class="subtitle">标签</p>
							</div>
							<div class="right">
								<div class="tagbox"></div>
								<input type="hidden" id="tag" name="tag" value="" />
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

	$(function() {
		// 数据回显
		// 获取媒体信息
		$.ajax({
			url : "get_media_info.json",
			type : "POST",
			dataType : "json",
			data : {
				"mediaId" : "${mediaId}",
				"typeId" : "${typeId}"
			},
			success : function(rtn) {
				var mediaInfo = rtn.data.mediaInfo;
				if (mediaInfo!=null) {
					// 获取字段，回显内容
					$.ajax({
						url : "${pageContext.request.contextPath}/field_info/get_data_by_type_id.json",
						type : "POST",
						dataType : "json",
						data : {
							"typeId" : "${typeId}"
						},
						success : function(rtn) {
							var list = rtn.data.list;
							if (list.length>0) {
								for (var i=0; i<list.length; i++) {
									// 判断字段类型
									if (list[i].inputType=="text" || list[i].inputType=="number" || list[i].inputType=="textarea") {
										// 回显输入框内容
										$(':input[name="'+list[i].varName+'"]').val(mediaInfo[list[i].varName]);
									} else if (list[i].inputType=="radio") {
										// 回显单选框选中值
										if (mediaInfo[list[i].varName]==null || mediaInfo[list[i].varName]=="") {
											
										} else {
											$(':radio[name="'+list[i].varName+'"][value="'+mediaInfo[list[i].varName]+'"]').attr("checked", true);
										}
									} else if (list[i].inputType=="checkbox") {
										// 回显复选框选中值
										if (mediaInfo[list[i].varName]==null || mediaInfo[list[i].varName]=="") {
											
										} else {
											var arr = mediaInfo[list[i].varName].split(",");
											for (var j=0; j<arr.length; j++) {
												$(':checkbox[name="'+list[i].varName+'"][value="'+arr[j]+'"]').attr("checked", true);
											}
										}
									}
								}
							}
						}
					});
				}
			}
		});
	});

	// 标签
	var tagList = eval('${jsonTagList}');
	javaex.tag({
		id : "tag",
		tags : tagList
	});
	
	// 上传海报
	javaex.upload({
		type : "image",
		url : "${pageContext.request.contextPath}/qiniu_info/upload_image.json?type=haibao",	// 请求路径
		id : "upload",	// <input type="file" />的id
		param : "file",			// 参数名称，SSM中与MultipartFile的参数名保持一致
		dataType : "url",		// 返回的数据类型：base64 或 url
		maxSize : "5120",
		callback : function (rtn) {
			// 后台返回的数据
			if (rtn.code=="000000") {
				var imgUrl = rtn.data.imgUrl;
				$("#upload_haibao").attr("src", imgUrl);
				$("#haibao").val(imgUrl);
			} else {
				javaex.optTip({
					content : rtn.message,
					type : "error"
				});
			}
		}
	});
	
	// 远程上传海报
	$("#upload_haibao_by_yuancheng").click(function() {
		var imgUrl = $("#haibao").val();
		if (imgUrl=="") {
			javaex.optTip({
				content : "请填写远程图片地址",
				type : "error"
			});
			return;
		}
		imgUrl = imgUrl.replace("https", "http");
		
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
				"type" : "haibao"
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
					$("#upload_haibao").attr("src", imgUrl);
					$("#haibao").val(imgUrl);
				} else {
					javaex.optTip({
						content : rtn.message,
						type : "error"
					});
				}
			}
		});
	});
	
	// 上传大封面
	javaex.upload({
		type : "image",
		url : "${pageContext.request.contextPath}/qiniu_info/upload_image.json?type=dafengmian",	// 请求路径
		id : "upload2",	// <input type="file" />的id
		maxSize : "5120",
		param : "file",			// 参数名称，SSM中与MultipartFile的参数名保持一致
		dataType : "url",		// 返回的数据类型：base64 或 url
		callback : function (rtn) {
			// 后台返回的数据
			if (rtn.code=="000000") {
				var imgUrl = rtn.data.imgUrl;
				$("#upload_dafengmian").attr("src", imgUrl);
				$("#dafengmian").val(imgUrl);
			} else {
				javaex.optTip({
					content : rtn.message,
					type : "error"
				});
			}
		}
	});
	
	// 远程上传大封面
	$("#upload_dafengmian_by_yuancheng").click(function() {
		var imgUrl = $("#dafengmian").val();
		if (imgUrl=="") {
			javaex.optTip({
				content : "请填写远程图片地址",
				type : "error"
			});
			return;
		}
		imgUrl = imgUrl.replace("https", "http");
		
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
				"type" : "dafengmian"
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
					$("#upload_dafengmian").attr("src", imgUrl);
					$("#dafengmian").val(imgUrl);
				} else {
					javaex.optTip({
						content : rtn.message,
						type : "error"
					});
				}
			}
		});
	});
	
	// 上传小封面
	javaex.upload({
		type : "image",
		url : "${pageContext.request.contextPath}/qiniu_info/upload_image.json?type=fengmian",	// 请求路径
		id : "upload3",	// <input type="file" />的id
		maxSize : "5120",
		param : "file",			// 参数名称，SSM中与MultipartFile的参数名保持一致
		dataType : "url",		// 返回的数据类型：base64 或 url
		callback : function (rtn) {
			// 后台返回的数据
			if (rtn.code=="000000") {
				var imgUrl = rtn.data.imgUrl;
				$("#upload_fengmian").attr("src", imgUrl);
				$("#fengmian").val(imgUrl);
			} else {
				javaex.optTip({
					content : rtn.message,
					type : "error"
				});
			}
		}
	});
	
	// 远程上传小封面
	$("#upload_fengmian_by_yuancheng").click(function() {
		var imgUrl = $("#fengmian").val();
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
					$("#upload_fengmian").attr("src", imgUrl);
					$("#fengmian").val(imgUrl);
				} else {
					javaex.optTip({
						content : rtn.message,
						type : "error"
					});
				}
			}
		});
	});
	
	var content = '${mediaInfo.jianjie}';
	javaex.edit({
		id : "edit",
		image : {
			url : "${pageContext.request.contextPath}/qiniu_info/upload_image.json?type=content",	// 请求路径
			param : "file",		// 参数名称，SSM中与MultipartFile的参数名保持一致
			dataType : "url",	// 返回的数据类型：base64 或 url
			rtn : "rtnData",	// 后台返回的数据对象，在前面页面用该名字存储
			imgUrl : "data.imgUrl"	// 根据返回的数据对象，获取图片地址。  例如后台返回的数据为：{code: "000000", message: "操作成功！", data: {imgUrl: "1.jpg"}}
		},
		content : content,	// 这里必须是单引号，因为html代码中都是双引号，会产生冲突
		callback : function(rtn) {
			$("#jianjie").val(rtn.html);
		}
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
							window.location.href = "list_normal.action";
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