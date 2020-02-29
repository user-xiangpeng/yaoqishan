<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>视频管理</title>
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
				<span class="active">播放列表</span>
			</div>
		</div>
		
		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--页面有多个表格时，可以用于标识表格-->
				<h2>${biaoti}</h2>
				<a href="${pageContext.request.contextPath}/media_info/list_normal.action">
					<button class="button wathet" style="position: absolute;right: 20px;top: 16px;"><span class="icon-arrow_back"></span> 返回</button>
				</a>
				
				<!--正文内容-->
				<div class="main">
					<!--表格上方的操作元素，添加、删除等-->
					<div class="operation-wrap">
						<div class="buttons-wrap">
							<a href="edit.action?mediaId=${mediaId}"><button id="add" class="button blue"><span class="icon-plus"></span> 添加</button></a>
							<button class="button red" onclick="updateStatus('0');"><span class="icon-block"></span> 批量禁止</button>
							<button class="button green" onclick="updateStatus('1');"><span class="icon-check2"></span> 批量恢复</button>
							<button id="delete" class="button red"><span class="icon-minus"></span> 批量删除</button>
							<span class="group-button" style="float: right;">
								<button id="update_sort" class="button green"><span class="icon-refresh" style="font-weight:bold;"></span> 更新本页排序</button>
								<button id="update_power" class="button red"><span class="icon-refresh" style="font-weight:bold;"></span> 更新统一权限</button>
								<button id="update_image" class="button indigo"><span class="icon-refresh" style="font-weight:bold;"></span> 更新统一封面</button>
							</span>
						</div>
					</div>
					<table id="table" class="table">
						<thead>
							<tr>
								<th class="checkbox"><input type="checkbox" class="fill listen-1" /> </th>
								<th>封面</th>
								<th style="width:10%">排序</th>
								<th>第几集</th>
								<th>标题</th>
								<th>播放次数</th>
								<th>状态</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${fn:length(pageInfo.list)==0}">
									<tr>
										<td colspan="8" style="text-align:center;">暂无记录</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${pageInfo.list}" var="entity" varStatus="status" >
										<tr>
											<td class="checkbox"><input type="checkbox" class="fill listen-1-2" value="${entity.videoId}" name="videoId" /> </td>
											<td>
												<div style="width:48px;height:24.8px;overflow:hidden;">
													<a href="javascript:;" onclick="img(this)">
														<img src="${entity.image}" width="100%">
													</a>
												</div>
											</td>
											<td><input type="text" class="text" name="sort" value="${entity.sort}" data-type="非负整数" error-msg="请填写非负整数" error-pos="36" /></td>
											<td>${entity.num}</td>
											<td>${entity.title}</td>
											<td>${entity.viewCount}</td>
											<td>
												<c:choose>
													<c:when test="${entity.status=='1'}">
														<font color="green">正常</font>
													</c:when>
													<c:otherwise>
														<font color="red">禁用</font>
													</c:otherwise>
												</c:choose>
											</td>
											<td>
												<a href="javascript:;" onclick="video('${entity.num}', '${entity.videoId}')">
													<button class="button wathet"><span class="icon-eye"></span> 预览</button>
												</a>
												<a href="edit.action?videoId=${entity.videoId}&mediaId=${mediaId}">
													<button class="button wathet"><span class="icon-edit-2"></span> 编辑</button>
												</a>
											</td>
										</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
					
					<!-- 分页 -->
					<div class="page">
						<ul id="page" class="pagination"></ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	javaex.loading();

	var mediaId = "${mediaId}";
	var videoIdArr = new Array();
	var sortArr = new Array();
	
	var currentPage = "${pageInfo.pageNum}";
	var pageCount = "${pageInfo.pages}";

	javaex.page({
		id : "page",
		pageCount : pageCount,	// 总页数
		currentPage : currentPage,// 默认选中第几页
		// 返回当前选中的页数
		callback:function(rtn) {
			search(rtn.pageNum);
		}
	});
	
	// 批量删除
	$("#delete").click(function() {
		videoIdArr = [];
		$(':checkbox[name="videoId"]:checked').each(function() {
			videoIdArr.push($(this).val());
		});
		
		// 判断至少选择一条记录
		if (videoIdArr.length==0) {
			javaex.optTip({
				content : "至少选择一条记录",
				type : "error"
			});
			return;
		}
		
		javaex.confirm({
			content : "确定要删除么？删除后不可恢复",
			callback : "batchDelete('"+videoIdArr+"')"
		});
	});
	
	function batchDelete(videoIdArr) {
		javaex.optTip({
			content : "数据提交中，请稍候...",
			type : "submit"
		});
		
		$.ajax({
			url : "batch_delete.json",
			type : "POST",
			dataType : "json",
			traditional : "true",
			data : {
				"videoIdArr" : videoIdArr
			},
			success : function(rtn) {
				if (rtn.code=="000000") {
					javaex.optTip({
						content : rtn.message,
						type : "success"
					});
					
					// 建议延迟加载
					setTimeout(function() {
						// 刷新页面
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
	
	// 批量更新状态
	function updateStatus(status) {
		videoIdArr = [];
		$(':checkbox[name="videoId"]:checked').each(function() {
			videoIdArr.push($(this).val());
		});
		
		// 判断至少选择一条记录
		if (videoIdArr.length==0) {
			javaex.optTip({
				content : "至少选择一条记录",
				type : "error"
			});
			return;
		}
		
		javaex.optTip({
			content : "数据提交中，请稍候...",
			type : "submit"
		});
		
		$.ajax({
			url : "batch_update_status.json",
			type : "POST",
			dataType : "json",
			traditional : "true",
			data : {
				"videoIdArr" : videoIdArr,
				"status" : status
			},
			success : function(rtn) {
				if (rtn.code=="000000") {
					javaex.optTip({
						content : rtn.message,
						type : "success"
					});
					
					// 建议延迟加载
					setTimeout(function() {
						// 刷新页面
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
	
	// 搜索
	function search(pageNum) {
		if (pageNum==undefined) {
			pageNum = 1;
		}

		window.location.href = "list.action"
				+ "?mediaId="+mediaId
				+ "&pageNum="+pageNum;
	}
	
	// obj为当前点击的元素对象
	function img(obj) {
		javaex.dialog({
			type : "image",	// 弹出层类型
			width : "480",	// 弹出层宽度
			url : obj.children[0].src	// 图片地址
		});
	}
	
	// 视频预览
	function video(num, videoId) {
		if (num=="" || num==null) {
			num = "${biaoti}";
		} else {
			num = "第" + num + "集 "
		}
		javaex.dialog({
			type : "window",
			title : num,
			url : "play_video.action?videoId="+videoId,	// 页面地址或网址
			width : "960",	// 弹出层宽度
			height : "580",	// 弹出层高度
			isBackground : true,
			scrolling : "no"
		});
	}
	
	// 更新排序
	$("#update_sort").click(function() {
		if (javaexVerify()) {
			videoIdArr = [];
			sortArr = [];
			
			$(':checkbox[name="videoId"]').each(function() {
				videoIdArr.push($(this).val());
			});
			
			// 显示顺序
			$('input[name="sort"]').each(function() {
				sortArr.push($(this).val());
			});
			
			javaex.optTip({
				content : "数据提交中，请稍候...",
				type : "submit"
			});
			
			// 向后台提交
			$.ajax({
				url : "update_sort.json",
				dataType : "json",
				traditional : "true",	// 允许传递数组
				data : {
					"videoIdArr" : videoIdArr,
					"sortArr" : sortArr
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
			
		}
	});
	
	// 更新统一封面
	$("#update_image").click(function() {
		var html = '<input id="imgUrl" type="text" class="text" style="width:100%;" />';
		
		javaex.alert({
			title : "请输入图片地址",
			width : "500",
			content : html,
			callback : "callback()"
		});
	});
	
	function callback() {
		javaex.optTip({
			content : "封面更新中，请稍候...",
			type : "submit"
		});
		
		$.ajax({
			url : "update_image.json",
			type : "POST",
			dataType : "json",
			data : {
				"mediaId" : mediaId,
				"imgUrl" : $("#imgUrl").val()
			},
			success : function(rtn) {
				if (rtn.code=="000000") {
					javaex.optTip({
						content : rtn.message
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
		return false;
	}
	
	// 更新统一权限
	$("#update_power").click(function() {
		var html = '<input id="power" type="text" class="text" style="width:100%;" />';
		
		javaex.alert({
			title : "请输入权限值",
			width : "200",
			content : html,
			callback : "setPower()"
		});
	});
	function setPower() {
		javaex.optTip({
			content : "权限值设置中，请稍候...",
			type : "submit"
		});
		
		$.ajax({
			url : "update_power.json",
			type : "POST",
			dataType : "json",
			data : {
				"mediaId" : mediaId,
				"power" : $("#power").val()
			},
			success : function(rtn) {
				if (rtn.code=="000000") {
					javaex.optTip({
						content : rtn.message
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
		return false;
	}
</script>
</html>
