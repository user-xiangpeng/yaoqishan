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
				<span class="active">媒体信息</span>
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
					<!--表格上方的搜索操作-->
					<div style="text-align:right;margin-bottom:10px;">
						<select id="type_id" name="typeId" class="no-shadow">
							<c:forEach items="${typeList}" var="entity" varStatus="status" >
								<option value="${entity.id}" <c:if test="${entity.id==typeId}">selected</c:if>>${entity.name}</option>
							</c:forEach>
						</select>
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
							<button id="add" class="button blue"><span class="icon-plus"></span> 添加</button>
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
								<th style="width:20%;">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${fn:length(pageInfo.list)==0}">
									<tr>
										<td colspan="5" style="text-align:center;">暂无记录</td>
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
											<td>
												<a href="edit.action?mediaId=${entity.mediaId}">
													<button class="button wathet"><span class="icon-edit-2"></span> 媒体信息</button>
												</a>
												<a href="${pageContext.request.contextPath}/video_info/list.action?mediaId=${entity.mediaId}">
													<button class="button wathet"><span class="icon-edit-2"></span> 播放地址</button>
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
							<label zoom="1.2"><input type="radio" class="fill" name="radio" value="change_type" />批量移动到分类</label>
							<select id="type_id2" name="typeId" class="no-shadow">
								<c:forEach items="${typeList}" var="entity" varStatus="status" >
									<option value="${entity.id}">${entity.name}</option>
								</c:forEach>
							</select>
							<br />
							<label zoom="1.2"><input type="radio" class="fill" name="radio" value="ban" />批量删除</label>
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

	javaex.select({
		id : "type_id",
		isSearch : false
	});
	
	javaex.select({
		id : "type_id2",
		isSearch : false
	});
	
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

		// 分类id
		var typeId = $("#type_id").val();
		// 关键字检索
		var keyWord = $("#biaoti").val();
		
		window.location.href = "list_normal.action"
				+ "?pageNum="+pageNum
				+ "&typeId="+typeId
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
	
	// 添加
	$("#add").click(function() {
		// 分类id
		var typeId = $("#type_id").val();
		
		window.location.href = "edit.action?typeId="+typeId;
	});
	
	// 批量提交按钮点击事件
	$("#save").click(function() {
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
					"mediaIdArr" : mediaIdArr,
					"status" : "0"
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
		} else if (opt=="change_type") {
			// 批量移动到分类
			// 获取目标用户组的id
			var typeId = $("#type_id2").val();
			
			javaex.optTip({
				content : "数据提交中，请稍候...",
				type : "submit"
			});
			
			$.ajax({
				url : "batch_change_type.json",
				type : "POST",
				dataType : "json",
				traditional : "true",
				data : {
					"mediaIdArr" : mediaIdArr,
					"typeId" : typeId
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
