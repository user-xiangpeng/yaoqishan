<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>媒体管理</title>
<c:import url="../common/common.jsp"></c:import>
</head>

<body>
	<!-- 面包屑导航和主体内容 -->
	<div class="content">
		<!--面包屑导航-->
		<div class="content-header">
			<div class="breadcrumb">
				<span>内容</span>
				<span class="divider">/</span>
				<span class="active">媒体回收站</span>
			</div>
		</div>
		
		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--页面有多个表格时，可以用于标识表格-->
				<h2>媒体列表</h2>
				<!--正文内容-->
				<div class="main">
					<p class="tip">回收站中的内容依然会被检索到，只是其下视频无法再播放</p>
					<!--表格上方的搜索操作-->
					<div style="text-align:right;margin-bottom:10px;">
						<div class="input-group">
							<!-- 标题检索 -->
							<input type="text" class="text" id="biaoti" value="${keyWord}" placeholder="检索标题" onkeydown="if(event.keyCode==13){search();}" />
							<!-- 点击查询按钮 -->
							<button class="button blue" onclick="search()"><span class="icon-search"></span></button>
						</div>
					</div>
					
					<!--表格上方的操作元素，添加、删除-->
					<div class="operation-wrap">
						<div class="buttons-wrap">
							<button id="back" class="button green"><span class="icon-check2"></span> 批量还原</button>
							<button id="delete" class="button red"><span class="icon-minus"></span> 彻底删除</button>
						</div>
					</div>
					<!--class加上color可以实现隔行变色-->
					<!--color1表示奇数行着色、color2表示偶数行着色-->
					<table id="table" class="table">
						<thead>
							<tr>
								<th class="checkbox"><input type="checkbox" class="fill listen-1" /> </th>
								<th style="width:10%;">id</th>
								<th style="width:10%;">海报/封面</th>
								<th>名称</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${fn:length(pageInfo.list)==0}">
									<tr>
										<td colspan="4" style="text-align:center;">暂无记录</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${pageInfo.list}" var="entity" varStatus="status" >
										<tr>
											<td class="checkbox"><input type="checkbox" class="fill listen-1-2" value="${entity.mediaId}" name="mediaId" /> </td>
											<td>${entity.mediaId}</td>
											<td>
												<c:choose>
													<c:when test="${empty entity.haibao}">
														<div style="height:50px;overflow:hidden;">
															<a href="javascript:;" onclick="img(this)">
																<img src="${entity.fengmian}" width="100%">
															</a>
														</div>
													</c:when>
													<c:otherwise>
														<div style="width:33px;height:50px;overflow:hidden;">
															<a href="javascript:;" onclick="img(this)">
																<img src="${entity.haibao}" width="100%">
															</a>
														</div>
													</c:otherwise>
												</c:choose>
											</td>
											<td>${entity.biaoti}</td>
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
	
	function search(pageNum) {
		if (pageNum==undefined) {
			pageNum = 1;
		}

		// 关键字检索
		var keyWord = $("#biaoti").val();
		
		window.location.href = "list_recycle.action"
				+ "?pageNum="+pageNum
				+ "&keyWord="+keyWord
				;
	}
	
	// obj为当前点击的元素对象
	function img(obj) {
		javaex.dialog({
			type : "image",	// 弹出层类型
			width : "400",	// 弹出层宽度
			url : obj.children[0].src	// 图片地址
		});
	}
	
	// 批量还原
	$("#back").click(function() {
		var mediaIdArr = new Array();
		$(':checkbox[name="mediaId"]:checked').each(function() {
			mediaIdArr.push($(this).val());
		});
		
		// 判断至少选择一条记录
		if (mediaIdArr.length==0) {
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
				"mediaIdArr" : mediaIdArr,
				"status" : "1"
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
	});
	
	// 彻底删除
	$("#delete").click(function() {
		var mediaIdArr = new Array();
		$(':checkbox[name="mediaId"]:checked').each(function() {
			mediaIdArr.push($(this).val());
		});
		
		// 判断至少选择一条记录
		if (mediaIdArr.length==0) {
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
			url : "batch_delete.json",
			type : "POST",
			dataType : "json",
			traditional : "true",
			data : {
				"mediaIdArr" : mediaIdArr
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
	});
</script>
</html>
