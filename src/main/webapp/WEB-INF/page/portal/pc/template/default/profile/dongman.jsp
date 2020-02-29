<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
 <title>${mediaInfo.biaoti}-${seoInfo.title}</title>
<meta name="keywords" content="${mediaInfo.biaoti}-${seoInfo.keywords}"/>
<meta name="description" content="${mediaInfo.jianjie}" />
<c:import url="../common/common.jsp"></c:import>
</head>
<style>
	.jianjie p {display: initial;}
	.equal-3 a:link{color: #2fb3ff;}
	.equal-3 a:visited{color: #2fb3ff;}
	.equal-3 a:hover{color: #ff3c00;}

	.play {position: absolute;bottom: 20px;}
	.play-btn{display: inline-block;width: 108px;height: 40px;line-height: 40px;font-size: 16px;cursor: pointer;text-align: center;background: #2fb3ff;border-radius: 2px;}

	.tab-title li{font-size: 16px;}
	.tab-content li>div{position: relative;width: 420px;height: 46px;line-height: 46px;color: #555;background: #f7f7fc;}
	.tab-content li>div>a{display: block;margin-left: 20px;}
	.tab-content li>div>a:hover{color: #2fb3ff;}
	
	.episodes-list .v-li.drama{padding-left: 15px; background: #f7f7fc; border-radius: 2px; margin-bottom: 2px; box-sizing: border-box;}
	.episodes-list .v-li.drama>a:hover{color: #2fb3ff;}
	.episodes-list .v-li{cursor: pointer; position: relative;}
	.episodes-list .v-li .drama-item{display: block; padding: 13px 0; font-size: 14px; margin-right: 100px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap;}
	.month_rank_count{position: absolute; top: 0; right: 0; padding: 13px 0; font-size: 14px; margin-right: 15px;}
</style>

<body>
	<!-- 头部 -->
	<div class="yaoqishan-header">
		<c:import url="../common/header.jsp"></c:import>
	</div>

	<!--内容-->
	<div style="width: 1340px; margin: 20px auto;">
		<!--视频介绍-->
		<div class="block no-shadow">
			<!--视频介绍-->
			<div class="main" style="margin-bottom: -20px;">
				<div class="grid-1-5 spacing-20">
					<div style="max-width: 200px;height: 300px;">
						<img src="${mediaInfo.haibao}" width="100%" height="100%" />
					</div>
					<div style="color: #666;">
						<h1 id="biaoti">${mediaInfo.biaoti}</h1>

						<ul class="equal-3" style="margin-top: 10px;">
							<li>地区：<a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=地区&value=${mediaInfo.dongman_diqu}" target="_blank">${mediaInfo.dongman_diqu}</a></li>
							<li>年份：<a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=年份&value=${mediaInfo.nianfen}" target="_blank">${mediaInfo.nianfen}</a></li>
							<li>状态：<a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=状态&value=${mediaInfo.zhuangtai}" target="_blank">${mediaInfo.zhuangtai}</a></li>
							<li>风格：
								<c:forEach items="${mediaInfo.dongman_fengge}" var="value" varStatus="status">
									<c:choose>
										<c:when test="${(status.index+1)==fn:length(mediaInfo.dongman_fengge)}">
											<a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=${value}" target="_blank" class="tag-link-item">${value}</a>
										</c:when>
										<c:otherwise>
											<a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=${value}" target="_blank" class="tag-link-item">${value}</a>
											<i style="color: #ccc;margin: 0 3px;">/</i>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</li>
							<span class="clearfix"></span>
						</ul>
						<div style="margin-top: 10px;">声优：${mediaInfo.shengyou}</div>
						<div class="jianjie" style="margin-top: 10px;">简介：${mediaInfo.jianjie}</div>
						
						<div class="play">
							<a id="first_video" href="javascript:;" class="play-btn" target="_blank" style="color: #fff;background-color: #d8d8d8;">立即播放</a>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div class="grid-15-7 spacing-20">
			<div style="max-width: 900px;">
				<!--视频介绍-->
				<div class="block no-shadow">
					<div class="main">
						<div class="tab">
							<div class="tab-title">
								<em>剧集列表</em>
							</div>
							<div class="tab-content">
								<ul id="play-list" class="equal-2" style="width: 880px;">
									
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div>
				<!--排行榜-->
				<div class="block no-shadow">
					<div class="main">
						<div class="tab">
							<div class="tab-title">
								<em>本月热播</em>
							</div>
							<div class="tab-content">
								<ul id="month_rank" class="episodes-list">
									
								</ul>
							</div>
						</div>
					</div>
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
	var mediaId = "${mediaId}";

	$(function() {
		// 获取视频列表
		getVideoList();
		
		// 获取月度排行榜
		getMonthRank();
	});
	
	// 获取该媒体的播放列表
	function getVideoList() {
		$.ajax({
			url : path + "api/get_video_list.json",
			type : "POST",
			dataType : "json",
			data : {
				"mediaId" : mediaId
			},
			success : function(rtn) {
				if (rtn.code=="999999") {
					getVideoList();
					return;
				}
				var list = rtn.data.list;
				if (list.length>0) {
					// 立即播放按钮
					$("#first_video").attr("href", "play.action?videoId="+list[0].videoId);
					$("#first_video").css("background", "#2fb3ff");
					
					var html = '';
					for (var i=0; i<list.length; i++) {
						html += '<li>';
						html += '<div class="p-item">';
						if (list[i].num=="" || list[i].num==null) {
							html += '<a href="play.action?videoId='+list[i].videoId+'" target="_blank">${mediaInfo.biaoti}</a>';
						} else {
							if (list[i].title==null) {
								html += '<a href="play.action?videoId='+list[i].videoId+'" target="_blank">第'+list[i].num+'集</a>';
							} else {
								html += '<a href="play.action?videoId='+list[i].videoId+'" target="_blank">第'+list[i].num+'集 '+list[i].title+'</a>';
							}
						}
						html += '</div>';
						html += '</li>';
					}
					
					html += '<span class="clearfix"></span>';
					$("#play-list").append(html);
					javaex.render();
				}
			}
		});
	}
	
	// 获取月度排行榜
	function getMonthRank() {
		$.ajax({
			url : path + "api/rank.json?apiId=35",
			type : "POST",
			dataType : "json",
			success : function(rtn) {
				if (rtn.code=="999999") {
					getMonthRank();
					return;
				}
				
				var html = '';
				var list = rtn.data.list;
				for (var i=0; i<list.length; i++) {
					html += '<li class="v-li drama">';
					html += '<a href="play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank" class="drama-item">'+(i+1)+' '+list[i].biaoti+'</a>';
					html += '<span class="month_rank_count">' + list[i].view_count + '次播放</span>';
					html += '</li>';
				}
				
				$("#month_rank").append(html);
			}
		});
	}
</script>
</html>