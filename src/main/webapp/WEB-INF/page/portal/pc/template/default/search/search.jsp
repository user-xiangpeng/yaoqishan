<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>${keyWord}</title>
<c:import url="../common/common.jsp"></c:import>
</head>
<style>
	.jianjie p {display: initial;}
	
	.mod-header{height: 18px; margin-bottom: 16px; color: #333;}
	.mod-header h1{display: inline; font-size: 24px; height: 24px; margin-right: 15px;}
	.base-type{position: relative; display: inline-block; border: 1px solid #e0e0e0; height: 16px; line-height: 16px; padding: 0 3px; border-radius: 2px; vertical-align: top; margin-right: 8px; font-weight: 200;}
	.mod-header .base-type{font-weight: 200;}
	.mod-header span{vertical-align: super; font-weight: 500; font-size: 14px; white-space: nowrap;}
	
	.video-item{margin: 1px 0 0 1px;margin-top: 20px;}
	.video-item li a{display: block;margin-left: -1px;margin-top: -1px;height: 31px;line-height: 31px;padding: 10px 0;background: #fbfcff;border: 1px solid #d8e1f2;text-align: center;font-size: 18px;font-family: arial,"Microsoft yahei";overflow: hidden;}
	.video-item li a:hover{background: #eaf0fa;color: #333;}
</style>

<body>
	<!-- 头部 -->
	<div class="yaoqishan-header">
		<c:import url="../common/header.jsp"></c:import>
	</div>
	
	<!-- 搜索结果 -->
	<div id="search-list" style="width: 1340px; margin: 20px auto;">
		
	</div>

	<!-- 分页 -->
	<div class="page">
		<ul id="page" class="pagination"></ul>
	</div>
	
	<!--底部-->
	<div class="footer-wrap" >
		<c:import url="../common/footer.jsp"></c:import>
	</div>
</body>
<script>
	var keyWord = "${keyWord}";

	$(document).ready(function() {
		// 查询搜索结果
		search(keyWord, 1);
	});
	
	// 查询搜索结果
	function search(keyWord, pageNum) {
		// 预设加载动画
		var html = '<div class="block no-shadow">';
		html += '<div class="main" style="margin-right:20px;height:300px;background:url(${pageContext.request.contextPath}/static/default/images/loading.gif) no-repeat center center;"></div>';
		html += '</div>';
		$("#search-list").empty();
		$("#search-list").append(html);
		
		$.ajax({
			url : path + "api/search.json",
			type : "POST",
			dataType : "json",
			data : {
				"keyWord" : keyWord,
				"pageNum" : pageNum
			},
			success : function(rtn) {
				if (rtn.code=="999999") {
					search(keyWord);
					return;
				}
				
				var pageInfo = rtn.data.pageInfo;
				var currentPage = pageInfo.pageNum;
				var pageCount = pageInfo.pages;
				
				var list = rtn.data.list;
				var html = '';
				if (list.length>0) {
					for (var i=0; i<list.length; i++) {
						var obj = list[i];
						html += '<div class="block">';
						html += '<div class="main pop-in" style="margin-bottom: -20px;">';
						html += '<div class="grid-1-5 spacing-20">';
						if (!obj.haibao) {
							html += '<div style="max-width: 200px;height: 112px;">';
							html += '<img src="'+obj.fengmian+'" width="100%" height="100%" />';
							html += '</div>';
						} else {
							html += '<div style="max-width: 200px;height: 300px;">';
							html += '<img src="'+obj.haibao+'" width="100%" height="100%" />';
							html += '</div>';
						}
						html += '<div style="color: #666;">';
						html += '<div class="mod-header">';
						html += '<h1 class="spc-lv-1">'+obj.biaoti+'</h1>';
						html += '<span class="base-type">'+obj.typeName+'</span>';
						if (!!obj.shangyingnianfen) {
							html += '<span class="spc-lv-1">'+obj.shangyingnianfen+'</span>';
						}
						html += '</div>';
						html += '<ul class="equal-3" style="margin-top: 20px;">';
						if (!!obj.zhuangtai) {
							html += '<li>状态：'+obj.zhuangtai+'</li>';
						}
						if (obj.typeName=="电影" || obj.typeName=="电视剧") {
							html += '<li>导演：'+obj.daoyan+'</li>';
							html += '<li>主演：'+obj.zhuyan+'</li>';
						} else if (obj.typeName=="动漫" && !!obj.shengyou) {
							html += '<li>声优：'+obj.shengyou+'</li>';
						}
						html += '</ul>';
						html += '<span class="clearfix"></span>';
						if (!!obj.jianjie) {
							html += '<div class="jianjie" style="margin-top: 10px;">简介：'+obj.jianjie.substring(0, 220)+'<a style="color:#2fb3ff;" href="profile.action?mediaId='+obj.media_id+'" target="_blank"> 查看详情</a></div>';
							html += '<ul class="equal-10 video-item">';
						} else {
							html += '<div class="jianjie" style="margin-top: 10px;">上传时间：'+obj.uploadTime+'</div>';
							html += '<ul class="equal-10 video-item" style="margin-top: 4px;">';
						}
						// 剧集列表
						var videoList = obj.videoList;
						if (videoList.length>0) {
							var len = videoList.length;
							for (var j=0; j<len; j++) {
								if (videoList[j].num=="" || videoList[j].num==null) {
									html += '<li><a href="play.action?videoId='+videoList[j].videoId+'" target="_blank">在线播放</a></li>';
								} else {
									html += '<li><a href="play.action?videoId='+videoList[j].videoId+'" target="_blank">'+videoList[j].num+'</a></li>';
								}
							}
						}
						html += '</ul>';
						html += '</div>';
						html += '</div>';
						html += '</div>';
						html += '</div>';
					}
				}
				
				if (html=="") {
					html += '<div class="block no-shadow">';
					html += '<div class="main" style="margin-bottom: -20px;">';
					html += '<div class="main-0" style="margin-right:20px;height:300px;background:url(${pageContext.request.contextPath}/static/default/images/loadnone.png) no-repeat center center;"></div>';
					html += '</div>';
					html += '</div>';
				}
				$("#search-list").empty();
				$("#search-list").append(html);
				
				javaex.popin();
				javaex.render();
				
				$("#page").empty();
				javaex.page({
					id : "page",
					pageCount : pageCount,	// 总页数
					currentPage : currentPage,// 默认选中第几页
					position : "center",
					callback:function(rtn) {
						search(keyWord, rtn.pageNum);
					}
				});
			}
		});
	}
</script>
</html>