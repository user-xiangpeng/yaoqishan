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
				<span class="active">正常用户</span>
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
					
					<!--表格上方的操作元素，添加、删除-->
					<div class="operation-wrap">
						<div class="buttons-wrap">
							<a href="edit.action"><button id="add" class="button blue"><span class="icon-plus"></span> 添加</button></a>
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
											<c:choose>
												<c:when test="${entity.groupName=='管理员'}">
													<td class="checkbox"><input type="checkbox" class="fill listen-1-2" value="${entity.id}" name="id" disabled="disabled" /> </td>
												</c:when>
												<c:otherwise>
													<td class="checkbox"><input type="checkbox" class="fill listen-1-2" value="${entity.id}" name="id" /> </td>
												</c:otherwise>
											</c:choose>
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
											<td>
												<a href="edit.action?id=${entity.id}">
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
					
					<!--块元素-->
					<div class="block no-shadow">
						<!--banner用来修饰块元素的名称-->
						<div class="banner">
							<p class="tab fixed">批量操作</p>
						</div>
						<!--正文内容-->
						<div class="main" style="margin-bottom:100px;">
							<label zoom="1.2"><input type="radio" class="fill" name="radio" value="change_group" />批量移动到用户组</label>
							<select id="group_id2" class="no-shadow">
								<c:forEach items="${groupList}" var="groupInfo" varStatus="status" >
									<option value="${groupInfo.id}">${groupInfo.name}</option>
								</c:forEach>
							</select>
							<br />
							<label zoom="1.2"><input type="radio" class="fill" name="radio" value="ban" />批量封禁</label>
							<br />
							<button id="save" class="button green" style="margin-top:20px;"><span class="icon-check" style="font-weight: bold;"></span> 提交</button>
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
	
	javaex.select({
		id : "group_id2",
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
		
		window.location.href = "list_normal.action"
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
		
		// 判断选择的哪一个单选框进行操作
		var opt = $(':radio[name="radio"]:checked').val();
		
		if (opt=="ban") {
			// 批量封禁
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
					"status" : "2"
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
		} else if (opt=="change_group") {
			// 批量更换用户组
			// 获取目标用户组的id
			var groupId = $("#group_id2").val();
			
			javaex.optTip({
				content : "数据提交中，请稍候...",
				type : "submit"
			});
			
			$.ajax({
				url : "batch_change_group.json",
				type : "POST",
				dataType : "json",
				traditional : "true",
				data : {
					"idArr" : idArr,
					"groupId" : groupId
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
		} else {
			javaex.optTip({
				content : "请选择操作选项",
				type : "error"
			});
		}
	});
</script>
</html>
