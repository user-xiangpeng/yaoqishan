<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>明星管理</title>
<style>
	tbody tr td:first-child {text-align:center;}
</style>
</head>

<body>
	<div class="wrap">
		<!-- 头部 -->
		<div id="header">
			<c:import url="../common/header.jsp"></c:import>
		</div>
		
		<!-- 左侧菜单和主体内容 -->
		<div class="grid-1-7" style="flex: 1;margin:0;">
			<!-- 左侧菜单 -->
			<c:import url="../common/menu.jsp"></c:import>
			
			<!-- 面包屑导航和主体内容 -->
			<div class="content">
				<!--面包屑导航-->
				<div class="content-header">
					<div class="breadcrumb">
						<span>明星信息管理</span>
						<span class="divider">/</span>
						<span class="active">明星信息</span>
					</div>
				</div>
				
				<!--全部主体内容-->
				<div class="list-content">
					<!--块元素-->
					<div class="block">
						<!--页面有多个表格时，可以用于标识表格-->
						<h2>明星列表</h2>
						<!--正文内容-->
						<div class="main-20">
							<!--表格上方的操作元素，添加、删除、搜索等-->
							<div class="operation-wrap">
								<div class="buttons-wrap">
									<a href="edit.action">
										<button class="button blue"><span class="icon-plus"></span> 添加</button>
									</a>
								</div>
							</div>
							<!--class加上color可以实现隔行变色-->
							<!--color1表示奇数行着色、color2表示偶数行着色-->
							<table id="table" class="table">
								<thead>
									<tr>
										<th>序号</th>
										<th>照片</th>
										<th>姓名</th>
										<th>性别</th>
										<th>地区</th>
										<th>血型</th>
										<th>生日</th>
										<th>星座</th>
										<th>职业</th>
										<th>操作</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${fn:length(list)==0}">
											<tr>
												<td colspan="10" style="text-align:center;">暂无记录</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${list}" var="entity" varStatus="status" >
												<tr>
													<td>${status.index+1}</td>
													<td>
														<div style="width:40px;height:40px;overflow:hidden;">
															<a href="javascript:;" onclick="img(this)">
																<img src="${entity.image}" width="100%">
															</a>
														</div>
													</td>
													<td>${entity.name}</td>
													<td>${entity.sex}</td>
													<td>${entity.region}</td>
													<td>${entity.blood}</td>
													<td>${entity.birthday}</td>
													<td>${entity.constellation}</td>
													<td>${entity.occupation}</td>
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
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	javaex.loading();

	// obj为当前点击的元素对象
	function img(obj) {
		javaex.dialog({
			type : "image",	// 弹出层类型
			width : "600",	// 弹出层宽度
			url : obj.children[0].src	// 图片地址
		});
	}
</script>
</html>
