<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>频道管理</title>
<c:import url="../common/common.jsp"></c:import>
</head>

<body>
	<!-- 面包屑导航和主体内容 -->
	<div class="content">
		<!--面包屑导航-->
		<div class="content-header">
			<div class="breadcrumb">
				<span>界面</span>
				<span class="divider">/</span>
				<span class="active">频道栏目</span>
			</div>
		</div>

		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--页面有多个表格时，可以用于标识表格-->
				<h2>频道列表</h2>
				<!--正文内容-->
				<div class="main">
					<!--表格上方的操作元素，添加、删除-->
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
								<th style="width:10%;">排序</th>
								<th>名称</th>
								<th>模板</th>
								<th style="width:20%;">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${fn:length(list)==0}">
									<tr>
										<td colspan="4" style="text-align:center;">暂无记录</td>
									</tr>
								</c:when>
								<c:otherwise>
									<c:forEach items="${list}" var="entity" varStatus="status" >
										<tr>
											<td>${entity.sort}</td>
											<td>${entity.name}</td>
											<td>${entity.template}</td>
											<td>
												<a href="edit.action?id=${entity.id}">
													<button class="button wathet"><span class="icon-edit-2"></span> 编辑</button>
												</a>
												<button class="button wathet" onclick="deleteById(this, '${entity.id}')"><span class="icon-trash-can2"></span> 删除</button>
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
</body>
<script>
	javaex.loading();

	function deleteById(obj, id) {
		javaex.deleteDialog(
			obj,	// obj是必须的
			{
				content : "确定要删除么",
				callback : "callback("+id+")"
			}
		);
	}
	
	function callback(id) {
		javaex.optTip({
			content : "数据提交中，请稍候...",
			type : "submit"
		});
		
		$.ajax({
			url : "delete.json",
			type : "POST",
			dataType : "json",
			data : {
				"id" : id
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
	}
</script>
</html>
