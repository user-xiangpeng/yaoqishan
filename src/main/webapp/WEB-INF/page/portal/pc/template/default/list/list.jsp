<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>${seoInfo.title}</title>
<meta name="keywords" content="${seoInfo.keywords}" />
<meta name="description" content="${seoInfo.description}" />
<c:import url="../common/common.jsp"></c:import>
</head>
<style>
	#media_list .duration {top: 274px;}
	.page{margin-top:-20px;}
</style>

<body>
	<!-- 头部 -->
	<div class="yaoqishan-header">
		<c:import url="../common/header.jsp"></c:import>
	</div>
	
	<!--内容-->
	<div style="width: 1340px; margin: 20px auto;">
		<!--分类筛选-->
		<div class="block no-shadow">
			<div class="main">
				<div class="classify-list">
					<c:forEach items="${list}" var="entity" varStatus="status" >
						<div class="classify-item">
							<c:choose>
								<c:when test="${entity.name==fieldName && !empty fieldValue}">
									<span class="classify-title"><font style="vertical-align: inherit;">${entity.name}：</font></span>
									<div class="classify-list-outer">
										<ul id="${entity.id}" class="classify-ul">
											<li class="classify-li" value="">
												<a href="javascript:;" class="classify-letter"><font style="vertical-align: inherit;">全部</font></a>
											</li>
											<c:forEach items="${entity.fieldProfileInfoList}" var="entity2" varStatus="status" >
												<c:choose>
													<c:when test="${entity2.name==fieldValue}">
														<li class="classify-li on" value="${entity2.id}">
															<a href="javascript:;" class="classify-letter"><font style="vertical-align: inherit;">${entity2.name}</font></a>
														</li>
													</c:when>
													<c:otherwise>
														<li class="classify-li" value="${entity2.id}">
															<a href="javascript:;" class="classify-letter"><font style="vertical-align: inherit;">${entity2.name}</font></a>
														</li>
													</c:otherwise>
												</c:choose>
											</c:forEach>
										</ul>
									</div>
								</c:when>
								<c:otherwise>
									<span class="classify-title"><font style="vertical-align: inherit;">${entity.name}：</font></span>
									<div class="classify-list-outer">
										<ul id="${entity.id}" class="classify-ul">
											<li class="classify-li on" value="">
												<a href="javascript:;" class="classify-letter"><font style="vertical-align: inherit;">全部</font></a>
											</li>
											<c:forEach items="${entity.fieldProfileInfoList}" var="entity2" varStatus="status" >
												<li class="classify-li" value="${entity2.id}">
													<a href="javascript:;" class="classify-letter"><font style="vertical-align: inherit;">${entity2.name}</font></a>
												</li>
											</c:forEach>
										</ul>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>

		<!--媒体列表-->
		<div class="block">
			<!--正文内容-->
			<div class="main-20">
				<!-- 媒体列表 -->
				<ul id="media_list" class="equal-6 poster">
					
				</ul>
				
				<!-- 分页 -->
				<div class="page">
					<ul id="page" class="pagination"></ul>
				</div>
			</div>
		</div>
	</div>
	
	<!--底部-->
	<div class="footer-wrap" >
		<c:import url="../common/footer.jsp"></c:import>
	</div>
</body>
<script>
	var typeId = "${typeId}";
	var filterArr = new Array();
	
	javaex.filter({
		selector : "ul.classify-ul",
		// 点击后，返回一个回调函数
		callback: function (rtn) {
			filterArr = rtn;
			getMediaLisByFilter(filterArr, 1);
		}
	});
	
	// 根据筛选结果，请求媒体数据
	function getMediaLisByFilter(filterArr, pageNum) {
		// 预设加载动画
		var html = '';
		html += '<div class="main-0" style="margin-right:20px;height:300px;background:url(${pageContext.request.contextPath}/static/default/images/loading.gif) no-repeat center center;"></div>';
		$("#media_list").empty();
		$("#media_list").append(html);
		
		$.ajax({
			url : path + "api/get_media_list_by_filter.json",
			type : "POST",
			dataType : "json",
			traditional : "true",
			data : {
				"typeId" : typeId,
				"filterArr" : filterArr,
				"pageNum" : pageNum,
				"pageSize" : "24"
			},
			success : function(rtn) {
				if (rtn.code=="999999") {
					getMediaLisByFilter(filterArr, pageNum);
					return;
				}
				
				var pageInfo = rtn.data.pageInfo;
				var currentPage = pageInfo.pageNum;
				var pageCount = pageInfo.pages;
				
				var list = rtn.data.pageInfo.list;
				var html = '';
				for (var i=0; i<list.length; i++) {
					html += '<li>';
					html += '<a href="profile.action?mediaId='+list[i].media_id+'" target="_blank" class="screenshot">';
					if (list[i].videoInfo!=null) {
						if (!list[i].videoInfo.num) {
							html += '<span class="duration">正片</span>';
						} else if (list[i].videoInfo.num==list[i].zongjishu) {
							html += '<span class="duration">全'+list[i].videoInfo.num+'集</span>';
						} else {
							html += '<span class="duration">更新至第'+list[i].videoInfo.num+'集</span>';
						}
					} else {
						html += '<span class="duration">资料</span>';
					}
					html += '<img src="'+list[i].haibao+'" class="pop-in" width="100%" height="100%" />';
					html += '</a>';
					html += '<p class="screenshot-title"><a href="profile.action?mediaId='+list[i].media_id+'" target="_blank">'+list[i].biaoti+'</a></p>';
					html += '<p>'+list[i].kandian+'</p>';
					html += '</li>';
				}
				
				// 先清空
				$("#media_list").empty();
				// 再填充
				if (html=="") {
					html += '<div class="main-0" style="margin-right:20px;height:300px;background:url(${pageContext.request.contextPath}/static/default/images/loadnone.png) no-repeat center center;"></div>';
				} else {
					html += '<span class="clearfix"></span>';
				}
				$("#media_list").append(html);
				
				javaex.popin();
				javaex.render();
				
				$("#page").empty();
				javaex.page({
					id : "page",
					pageCount : pageCount,	// 总页数
					currentPage : currentPage,// 默认选中第几页
					callback:function(rtn) {
						getMediaLisByFilter(filterArr, rtn.pageNum);
					}
				});
			}
		});
	}
</script>
</html>