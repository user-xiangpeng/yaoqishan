<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>接口条件编辑</title>
<c:import url="../common/common.jsp"></c:import>
</head>
<body>
	<!-- 面包屑导航和主体内容 -->
	<div class="content">
		<!--面包屑导航-->
		<div class="content-header">
			<div class="breadcrumb">
				<span>接口</span>
				<span class="divider">/</span>
				<span class="active">排行榜接口条件编辑</span>
			</div>
		</div>
		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--修饰块元素名称-->
				<div class="banner">
					<p class="tab fixed">${name}</p>
				</div>
				<!--正文-->
				<div class="main">
					<!--表单-->
					<form id="form">
						<input type="hidden" name="id" value="${id}" />
						
						<!-- 数据来源 -->
						<div class="unit">
							<div class="left">
								<p class="subtitle">数据来源</p>
							</div>
							<div class="right">
								<ul class="equal-8">
									<c:forEach items="${typeList}" var="entity" varStatus="status" >
										<li><input type="radio" class="fill" name="typeId" value="${entity.id}" <c:if test="${status.index==0}">checked</c:if> />${entity.name}</li>
									</c:forEach>
									<!--清浮动-->
									<span class="clearfix"></span>
								</ul>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--排行榜分类-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">分类</p>
							</div>
							<div class="right">
								<ul class="equal-8">
									<li><input type="radio" class="fill" name="rankType" value="day" checked/>日榜</li>
									<li><input type="radio" class="fill" name="rankType" value="week" />周榜</li>
									<li><input type="radio" class="fill" name="rankType" value="month" />月榜</li>
									<li><input type="radio" class="fill" name="rankType" value="year" />年榜</li>
									<!--清浮动-->
									<span class="clearfix"></span>
								</ul>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--获取条数-->
						<div class="unit">
							<div class="left">
								<span class="required">*</span><p class="subtitle">获取条数</p>
							</div>
							<div class="right">
								<input type="text" class="text" name="num" data-type="正整数" error-msg="必须填写正整数" value="${apiInfo.num}" />
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--查询媒体下的视频信息-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">视频信息</p>
							</div>
							<div class="right">
								<ul class="equal-4">
									<li><input type="radio" class="fill" name="selectVideo" value="1" />查询第一集</li>
									<li><input type="radio" class="fill" name="selectVideo" value="2" checked/>查询最新一集</li>
									<li><input type="radio" class="fill" name="selectVideo" value="0" />不查询</li>
									<!--清浮动-->
									<span class="clearfix"></span>
								</ul>
							</div>
							<!--清浮动-->
							<span class="clearfix"></span>
						</div>
						
						<!--设置缓存时间-->
						<div class="unit">
							<div class="left">
								<p class="subtitle">缓存时间</p>
							</div>
							<div class="right">
								<ul class="equal-5">
									<li><input type="radio" class="fill" name="cacheTime" value="0" checked/>不缓存</li>
									<li><input type="radio" class="fill" name="cacheTime" value="10" />10分钟</li>
									<li><input type="radio" class="fill" name="cacheTime" value="30" />30分钟</li>
									<li><input type="radio" class="fill" name="cacheTime" value="60" />1小时</li>
									<li><input type="radio" class="fill" name="cacheTime" value="-1" />不自动更新</li>
									<!--清浮动-->
									<span class="clearfix"></span>
								</ul>
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
			url : "get_api_info.json",
			type : "POST",
			dataType : "json",
			data : {
				"id" : "${id}"
			},
			success : function(rtn) {
				var apiInfo = rtn.data.apiInfo;
				if (apiInfo!=null) {
					// 回显单选框数据
					$(':radio[name="typeId"][value="'+apiInfo.type_id+'"]').attr("checked", true);
					$(':radio[name="rankType"][value="'+apiInfo.rank_type+'"]').attr("checked", true);
					$(':radio[name="selectVideo"][value="'+apiInfo.select_video+'"]').attr("checked", true);
					$(':radio[name="cacheTime"][value="'+apiInfo.cache_time+'"]').attr("checked", true);
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
				url : "rank_save.json",
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
							history.back();
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