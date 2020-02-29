<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>用户管理</title>
<c:import url="../common/common.jsp"></c:import>
</head>

<body>
	<!-- 面包屑导航和主体内容 -->
	<div class="content">
		<!--面包屑导航-->
		<div class="content-header">
			<div class="breadcrumb">
				<span>用户</span>
				<span class="divider">/</span>
				<span class="active">封禁用户</span>
			</div>
		</div>

		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--页面有多个表格时，可以用于标识表格-->
				<h2>用户列表</h2>
				<!--正文内容-->
				<div class="main">
					<!--表格上方的搜索操作-->
					<div style="text-align:right;margin-bottom:10px;">
						<select id="group_id" class="no-shadow">
							<option value="">全部</option>
							<c:forEach items="${groupList}" var="groupInfo" varStatus="status" >
								<option value="${groupInfo.id}" <c:if test="${groupInfo.id==groupId}">selected</c:if>>${groupInfo.name}</option>
							</c:forEach>
						</select>
						<div class="input-group">
							<!-- 登录名检索 -->
							<input type="text" class="text" id="keyWord" value="${keyWord}" placeholder="检索登录名" />
							<!-- 点击查询按钮 -->
							<button class="button blue" onclick="search()"><span class="icon-search"></span></button>
						</div>
					</div>
					
					<!--表格上方的操作元素，添加、删除等-->
					<div class="operation-wrap">
						<div class="buttons-wrap">
							<button id="recovery" class="button green"><span class="icon-check" style="font-weight: bold;"></span> 批量恢复</button>
						</div>
					</div>
					
					<!--class加上color可以实现隔行变色-->
					<!--color1表示奇数行着色、color2表示偶数行着色-->
					<table id="table" class="table">
						<thead>
							<tr>
								<th class="checkbox"><input type="checkbox" class="fill listen-1" /> </th>
								<th style="width:10%;">id</th>
								<th>头像</th>
								<th>登录名</th>
								<th>邮箱</th>
								<th>用户组</th>
								<th>注册时间</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${fn:length(pageInfo.list)==0}">
									<tr>
										<td colspan="7" style="text-align:center;">暂无记录</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${pageInfo.list}" var="entity" varStatus="status" >
										<tr>
											<td class="checkbox"><input type="checkbox" class="fill listen-1-2" value="${entity.id}" name="id" /> </td>
											<td>${entity.id}</td>
											<td>
												<div style="width:33px;height:50px;overflow:hidden;">
													<a href="javascript:;" onclick="img(this)">
														<img src="${entity.avatar}" width="100%">
													</a>
												</div>
											</td>
											<td>${entity.loginName}</td>
											<td>${entity.email}</td>
											<td>${entity.groupName}</td>
											<td>${entity.registerTime}</td>
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
					
					<!--块元素-->
					<div class="block no-shadow">
						<!--banner用来修饰块元素的名称-->
						<div class="banner">
							<p class="tab fixed">批量操作</p>
						</div>
						<!--正文内容-->
						<div class="main-8">
							<input type="checkbox" class="fill listen-2" />全选
							<ul class="equal-8">
								<li><input type="checkbox" class="fill listen-2-2" name="delete" value="replay_info" />删除回复</li>
								<li><input type="checkbox" class="fill listen-2-2" name="delete" value="comment_info" />删除评论</li>
								<li><input type="checkbox" class="fill listen-2-2" name="delete" value="collection_info" />删除收藏</li>
								<li><input type="checkbox" class="fill listen-2-2" name="delete" value="history_info" />删除浏览记录</li>
								<!--清浮动-->
								<span class="clearfix"></span>
							</ul>
							<button id="save" class="button red" style="margin-top:20px;"><span class="icon-check" style="font-weight: bold;"></span> 提交</button>
						</div>
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

	javaex.select({
		id : "group_id",
		isSearch : false
	});
	
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

		// 用户组id
		var groupId = $("#group_id").val();
		// 关键字检索
		var keyWord = $("#keyWord").val();
		
		window.location.href = "list_ban.action"
				+ "?pageNum="+pageNum
				+ "&groupId="+groupId
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
	
	// 批量恢复
	$("#recovery").click(function() {
		var idArr = new Array();
		$(':checkbox[name="id"]:checked').each(function() {
			idArr.push($(this).val());
		});
		
		// 判断至少选择一条记录
		if (idArr.length==0) {
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
				"idArr" : idArr,
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
	
	// 批量提交按钮点击事件
	$("#save").click(function() {
		var idArr = new Array();
		$(':checkbox[name="id"]:checked').each(function() {
			idArr.push($(this).val());
		});
		
		// 判断至少选择一条记录
		if (idArr.length==0) {
			javaex.optTip({
				content : "至少选择一条记录",
				type : "error"
			});
			return;
		}
		
		// 判断选择了哪些复选框进行操作
		var deleteArr = new Array();
		$(':checkbox[name="delete"]:checked').each(function() {
			deleteArr.push($(this).val());
		});
		
		// 判断至少选择一条删除类型
		if (deleteArr.length==0) {
			javaex.optTip({
				content : "至少选择一条删除类型",
				type : "error"
			});
			return;
		}
		
		// 删除提交
		javaex.optTip({
			content : "数据提交中，请稍候...",
			type : "submit"
		});
		
		$.ajax({
			url : "batch_delete_content.json",
			type : "POST",
			dataType : "json",
			traditional : "true",
			data : {
				"idArr" : idArr,
				"deleteArr" : deleteArr
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
