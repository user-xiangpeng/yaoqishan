<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>${videoInfo.biaoti}-${seoInfo.title}</title>
<meta name="keywords" content="${mediaInfo.biaoti}-${seoInfo.keywords}" />
<meta name="description" content="${mediaInfo.jianjie}" />
<c:import url="../common/common.jsp"></c:import>
</head>
<style>
.player{position: relative;background: url(${pageContext.request.contextPath}/static/default/images/loading.gif) no-repeat center center;}
.block h2 {line-height: 50px;border-bottom: 0;padding-left: 0;}

.jianjie p {display: initial;}
.equal-3 a:link{color: #2fb3ff;}
.equal-3 a:visited{color: #2fb3ff;}
.equal-3 a:hover{color: #ff3c00;}
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
				<div class="player">
					<h2 id="video_title" style="color: #fff;padding-left: 20px;">
						${videoInfo.biaoti}<c:if test="${!empty videoInfo.num}">：第${videoInfo.num}集 ${videoInfo.title}</c:if>
					</h2>
					<span style="position: absolute;color: #ddd;right: 20px;top: 20px;">${videoInfo.viewCount} 次播放</span>
					<div id="player" style="width:1340px;height:720px;">
						
					</div>
				</div>
			</div>
		</div>
		
		<div class="grid-25-8 spacing-20">
			<div>
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
</script>
</html>