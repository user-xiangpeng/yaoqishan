<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>${videoInfo.biaoti}<c:if test="${!empty videoInfo.num}">：第${videoInfo.num}集 ${videoInfo.title}</c:if>-${seoInfo.title}</title>
<meta name="keywords" content="${mediaInfo.biaoti}-${seoInfo.keywords}" />
<meta name="description" content="${mediaInfo.jianjie}" />
<c:import url="../common/common.jsp"></c:import>
</head>
<style>
.player{position: relative;background: url(${pageContext.request.contextPath}/static/default/images/loading.gif) no-repeat center center;}
.block h2 {line-height: 50px;border-bottom: 0;padding-left: 0;}
.play-list{width:300px;margin-left: 20px;background: url(${pageContext.request.contextPath}/static/default/images/loading.gif) no-repeat center center;}
.play-list-ul::-webkit-scrollbar {width: 12px;height: 12px;}
.play-list-ul::-webkit-scrollbar-thumb {background-color: #616161;background-clip: padding-box;min-height: 28px;}
.play-list-ul::-webkit-scrollbar-track-piece {background-color: #1a1a1a;}
.play-list-ul{top: 68px;height: 564px; overflow:auto;}
.play-info{display: flex;margin-bottom:10px;}
.play-info-img{width:112px;height: 63px;}
.play-info-text{width:170px;margin-left: 10px;position: relative;}
.play-info-title{margin-top: 5px;}
.play-info-count{position: absolute;bottom: 5px;color:#555;}

.play-list-ul .v-li.drama{padding-left: 15px;background: #242424;border-radius: 2px;margin-bottom: 2px;box-sizing: border-box;}
.play-list-ul .v-li{cursor: pointer;position: relative;}
.play-list-ul .v-li .drama-item{display: block;padding: 13px 0;font-size: 14px;margin-right: 28px;overflow: hidden;text-overflow: ellipsis;white-space: nowrap;color:#fff;}
.play-list-ul .v-li.drama.selected:after{content: "";display: block;position: absolute;top: 0;left: 0;bottom: 0;right: 0;border-radius: 4px;border: 2px solid #2fb3ff;}
.play-list-ul .v-li.drama:hover{background:#1e1e1e}

.jianjie p {display: initial;}
.equal-3 a:link, .fengge a:link{color: #2fb3ff;}
.equal-3 a:visited, .fengge a:visited{color: #2fb3ff;}
.equal-3 a:hover, .fengge a:hover{color: #ff3c00;}
</style>

<body>
	<!-- 头部 -->
	<div class="yaoqishan-header">
		<c:import url="../common/header.jsp"></c:import>
	</div>

	<!--播放内容-->
	<div style="width: 1340px; margin: 20px auto;">
		<div class="block no-shadow" style="background-color:#1a1a1a;">
			<!--正文内容-->
			<div class="main-0">
				<div style="display: flex;">
					<div class="player">
						<h2 id="video_title" style="color: #fff;padding-left: 20px;">
							${videoInfo.biaoti}<c:if test="${!empty videoInfo.num}">：第${videoInfo.num}集 ${videoInfo.title}</c:if>
						</h2>
						<span style="position: absolute;color: #ddd;right: 0;top: 20px;">${videoInfo.viewCount} 次播放</span>
						<div id="player" style="width:1000px;height:564px;">
							
						</div>
					</div>
					<div class="play-list">
						<h2 style="color: #fff;">播放列表</h2>
						<ul id="play-list" class="play-list-ul">
							
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<div class="grid-25-8 spacing-20">
			<div>
				<!--视频介绍-->
				<div class="block no-shadow">
					<div class="main" style="margin-bottom: -20px;">
						<div class="grid-3-20 spacing-20">
							<div style="min-width: 140px;height: 210px;">
								<a href="profile.action?mediaId=${mediaInfo.media_id}" target="_blank">
									<img src="${mediaInfo.haibao}" width="100%" height="100%" />
								</a>
							</div>
							<div style="color: #666;position: relative;">
								<h1><a href="profile.action?mediaId=${mediaInfo.media_id}" target="_blank">${mediaInfo.biaoti}</a></h1>
								
								<ul class="equal-3" style="margin-top: 10px;">
									<li>地区：<a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=地区&value=${mediaInfo.dongman_diqu}" target="_blank">${mediaInfo.dongman_diqu}</a></li>
									<li>年份：<a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=年份&value=${mediaInfo.nianfen}" target="_blank">${mediaInfo.nianfen}</a></li>
									<li>状态：<a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=状态&value=${mediaInfo.zhuangtai}" target="_blank">${mediaInfo.zhuangtai}</a></li>
									<span class="clearfix"></span>
								</ul>
								<div class="fengge">
									风格：
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
								</div>
								<div style="margin-top: 10px;">声优：${mediaInfo.shengyou}</div>
								<div class="jianjie" style="margin-top: 10px;">
									简介：${fn:substring(mediaInfo.jianjie, 0, 80)}
									<a style="color:#2fb3ff;" href="profile.action?mediaId=${mediaInfo.media_id}" target="_blank"> 查看详情</a>
								</div>
							</div>
						</div>
					</div>
				</div>
				
				<!--评论-->
				<div class="block no-shadow">
					<div class="main">
						<!-- 评论列表 -->
						<div id="comment" class="comment">
							
						</div>
						
						<!-- 分页 -->
						<div class="page">
							<ul id="page" class="pagination"></ul>
						</div>
					</div>
				</div>
			</div>
			<div>
				<!--广告位-->
				<c:import url="../ad/ad2.jsp"></c:import>
			</div>
		</div>
	</div>
	
	<!--底部-->
	<div class="footer-wrap" >
		<c:import url="../common/footer.jsp"></c:import>
	</div>
</body>
<script>
	var mediaId = "${mediaInfo.media_id}";
	var videoId = "${videoId}";
	var pageNum = "1";
	
	$(function() {
		var videoPower = "${videoInfo.power}";
		if (videoPower=="" || videoPower==null || videoPower=="0") {
			getVideoPlay();
		} else {
			var userPower = "${userInfo.power}";
			if (userPower=="" || userPower==null) {
				loginDialog();
			} else {
				if (parseInt(userPower)<parseInt(videoPower)) {
					javaex.alert({
						content : "您没有权限观看该视频"
					});
				} else {
					getVideoPlay();
				}
			}
		}
		
		// 获取评论列表
		getCommentList(pageNum);
		
		// 获取该媒体的播放列表
		getVideoList(mediaId);
	});
	
	// 获取评论列表
	function getCommentList(pageNum) {
		// 获取评论条数
		$.ajax({
			url : "${pageContext.request.contextPath}/portal/comment_info/get_comment_count.json",
			type : "POST",
			dataType : "json",
			data : {
				"videoId" : videoId
			},
			success : function(rtn) {
				if (rtn.code=="999999") {
					getCommentList(pageNum);
					return;
				}
				var commentCount = rtn.data.count;
				
				// 获取评论列表
				$.ajax({
					url : "${pageContext.request.contextPath}/portal/comment_info/get_comment_list.json",
					type : "POST",
					dataType : "json",
					data : {
						videoId : videoId,
						pageNum : pageNum
					},
					success : function(rtn) {
						if (rtn.code=="999999") {
							getCommentList(pageNum);
							return;
						}
						
						var pageInfo = rtn.data.pageInfo;
						var currentPage = pageInfo.pageNum;
						var pageCount = pageInfo.pages;
						
						var list = pageInfo.list;
						
						javaex.comment({
							id : "comment",
							avatar : "http://doc.javaex.cn/javaex/javaex/pc/images/user.jpg",
							url : "http://www.javaex.cn/?UID=",
							commentCount : commentCount,
							list : list,
							commentMapping : {
								commentId : "id",
								userId : "userId",
								userName : "loginName",
								avatar : "avatar",
								content : "content",
								time : "updateTime",
								replyInfoLsit : "replyInfoLsit"
							},
							replyMapping : {
								userId : "userId",
								userName : "loginName",
								avatar : "avatar",
								toUserId : "toUserId",
								toUserName : "toLoginName",
								content : "content",
								time : "updateTime"
							},
							userId : getCookie("UID"),
							callback: function (rtn) {
								if (rtn.type=="comment") {
									// 对视频的评论
									comment(rtn.content);
								} else {
									// 对评论的回复
									reply(rtn.commentId, rtn.toUserId, rtn.toUserName, rtn.content);
								}
							}
						});
						
						$("#page").empty();
						javaex.page({
							id : "page",
							pageCount : pageCount,	// 总页数
							currentPage : currentPage,// 默认选中第几页
							// 返回当前选中的页数
							callback:function(rtn) {
								getCommentList(rtn.pageNum);
							}
						});
					}
				});
			}
		});
	}
	
	// 对视频的评论
	function comment(content) {
		$.ajax({
			url : "${pageContext.request.contextPath}/portal/comment_info/save.json",
			type : "POST",
			dataType : "json",
			data : {
				"videoId" : videoId,
				"userToken" : getCookie("userToken"),
				"content" : content
			},
			success : function(rtn) {
				if (rtn.code=="000000") {
					// 获取评论列表
					getCommentList(pageNum);
				} else {
					javaex.optTip({
						content : rtn.message,
						type : "error"
					});
				}
			}
		});
	}

	// 回复
	function reply(commentId, toUserId, toUserName, content) {
		$.ajax({
			url : "${pageContext.request.contextPath}/portal/reply_info/save.json",
			type : "POST",
			dataType : "json",
			data : {
				"videoId" : videoId,
				"commentId" : commentId,
				"userToken" : getCookie("userToken"),
				"toUserId" : toUserId,
				"toLoginName" : toUserName,
				"content" : content
			},
			success : function(rtn) {
				if (rtn.code=="000000") {
					// 获取评论列表
					getCommentList(pageNum);
				} else {
					javaex.optTip({
						content : rtn.message,
						type : "error"
					});
				}
			}
		});
	}

	// 打开登录框
	function loginDialog() {
		javaex.dialog({
			type : "login",	// 弹出层类型
			width : "400",
			height : "320",
			url : "${pageContext.request.contextPath}/portal/login.action"
		});
	}
	
	// 获取视频地址
	function getVideoPlay() {
		$.ajax({
			url : path + "api/get_video_play.json",
			type : "POST",
			dataType : "json",
			data : {
				"videoId" : videoId
			},
			success : function(rtn) {
				if (rtn.code=="999999") {
					getVideoPlay();
					return;
				}
				$("#player").append(rtn.data.videoPlay);
			}
		});
	}
	
	// 获取该媒体的播放列表
	function getVideoList(mediaId) {
		$.ajax({
			url : path + "api/get_video_list.json",
			type : "POST",
			dataType : "json",
			data : {
				"mediaId" : mediaId
			},
			success : function(rtn) {
				if (rtn.code=="999999") {
					getVideoList(mediaId);
					return;
				}
				var list = rtn.data.list;
				if (list.length>0) {
					var html = '';
					for (var i=0; i<list.length; i++) {
						var num = "";
						if (list[i].num=="" || list[i].num==null) {
							
						} else {
							if (list[i].title==null || list[i].title=="") {
								num = "第"+list[i].num+"集";
							} else {
								num = "第"+list[i].num+"集：";
							}
						}
						if (videoId==list[i].videoId) {
							html += '<li id="li_video_'+videoId+'" class="v-li drama selected">';
						} else {
							html += '<li class="v-li drama">';
						}
						if (videoId==list[i].videoId) {
							if (list[i].title==null || list[i].title=="") {
								html += '<a href="play.action?videoId='+list[i].videoId+'" class="drama-item">'+num+'</a>';
							} else {
								html += '<a href="play.action?videoId='+list[i].videoId+'" class="drama-item">'+num+list[i].title+'</a>';
							}
						} else {
							if (list[i].title==null || list[i].title=="") {
								html += '<a href="play.action?videoId='+list[i].videoId+'" class="drama-item">'+num+'</a>';
							} else {
								html += '<a href="play.action?videoId='+list[i].videoId+'" class="drama-item">'+num+list[i].title+'</a>';
							}
						}
						html += '</li>';
					}
					
					$(".play-list").css("background", "none");
					$("#play-list").append(html);
					javaex.render();
					
					var diff = $("#li_video_"+videoId).position().top;
					if (diff>520) {
						diff = diff-67+"px";
						$("#play-list").animate({"scrollTop": diff}, 1000);
					}
				}
			}
		});
	}
</script>
</html>