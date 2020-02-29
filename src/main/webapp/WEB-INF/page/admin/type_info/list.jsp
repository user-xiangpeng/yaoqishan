<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>分类管理</title>
<c:import url="../common/common.jsp"></c:import>
</head>

<body>
	<!-- 面包屑导航和主体内容 -->
	<div class="content">
		<!--面包屑导航-->
		<div class="content-header">
			<div class="breadcrumb">
				<span>分类</span>
				<span class="divider">/</span>
				<span class="active">分类信息</span>
			</div>
		</div>
		
		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--页面有多个表格时，可以用于标识表格-->
				<h2>分类列表</h2>
				<!--正文内容-->
				<div class="main">
					<!--表格上方的操作元素，添加、删除、搜索等-->
					<div class="operation-wrap">
						<div class="buttons-wrap">
							<button id="add" class="button blue"><span class="icon-plus"></span> 添加</button>
							<button id="delete" class="button red"><span class="icon-minus"></span> 删除</button>
							<button id="save" class="button green"><span class="icon-check2"></span> 保存</button>
						</div>
					</div>
					<!--class加上color可以实现隔行变色-->
					<!--color1表示奇数行着色、color2表示偶数行着色-->
					<table id="table" class="table">
						<thead>
							<tr>
								<th class="checkbox"><input type="checkbox" class="fill listen-1" /> </th>
								<th style="width:20%;">显示顺序</th>
								<th>typeId</th>
								<th>分类名称</th>
								<th>详情页模板（电脑端）</th>
								<th>播放页模板（电脑端）</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="entity" varStatus="status" >
								<tr>
									<td class="checkbox"><input type="checkbox" class="fill listen-1-2" value="${entity.id}" name="id" /> </td>
									<td><input type="text" class="text" name="sort" value="${entity.sort}" data-type="非负整数" error-msg="请填写非负整数" error-pos="36" /></td>
									<td>${entity.id}</td>
									<td><input type="text" class="text" name="name" value="${entity.name}" data-type="必填" error-pos="36" /></td>
									<td>
										<select class="select" name="profileTemplate">
											<option value="">无详情页</option>
											<c:forEach items="${profileList}" var="profile">
												<option value="${profile.value}"
													<c:if test="${profile.value==entity.profileTemplate}">selected</c:if>
												>${profile.name}</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<select class="select" name="playTemplate">
											<c:forEach items="${playList}" var="play">
												<option value="${play.value}"
													<c:if test="${play.value==entity.playTemplate}">selected</c:if>
												>${play.name}</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<a href="${pageContext.request.contextPath}/type_field/list.action?typeId=${entity.id}&typeName=${entity.name}">
											<button class="button wathet"><span class="icon-edit-2"></span> 字段配置</button>
										</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	javaex.loading();

	var idArr = new Array();
	var sortArr = new Array();
	var nameArr = new Array();
	var profileArr = new Array();
	var playArr = new Array();
	
	// 点击添加按钮，table向下追加一行
	$("#add").click(function() {
		var trHtml = '';
		trHtml += '<tr>';
		trHtml += '<td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="id" value="" /> </td>';
		trHtml += '<td><input type="text" class="text" name="sort" value="" data-type="非负整数" error-msg="请填写非负整数" error-pos="36" /></td>';
		trHtml += '<td></td>';
		trHtml += '<td><input type="text" class="text" name="name" value="" data-type="必填" error-pos="36" /></td>';
		// 详情页模板选择
		trHtml += '<td>';
		trHtml += '<select class="select" name="profileTemplate">';
		trHtml += '<option value="">无详情页</option>';
		trHtml += '<c:forEach items="${profileList}" var="profile">';
		trHtml += '<option value="${profile.value}">${profile.name}</option>';
		trHtml += '</c:forEach>';
		trHtml += '</select>';
		trHtml += '</td>';
		// 播放页模板选择
		trHtml += '<td>';
		trHtml += '<select class="select" name="playTemplate">';
		trHtml += '<c:forEach items="${playList}" var="play">';
		trHtml += '<option value="${play.value}">${play.name}</option>';
		trHtml += '</c:forEach>';
		trHtml += '</select>';
		trHtml += '</td>';
		trHtml += '<td></td>';
		trHtml += '</tr>';
		$("#table tbody").append(trHtml);
		
		// 动态加载html代码之后，需要重新渲染
		javaex.render();
	});
	
	// 点击删除按钮事件
	$("#delete").click(function() {
		idArr = [];
		$(':checkbox[name="id"]').each(function() {
			if ($(this).is(":checked")) {
				var id = $(this).val();
				if (id!="") {
					idArr.push(id);
				}
			}
		});
		
		// 判断是否选择了有效值
		if (idArr.length==0) {
			// 仅仅删除多添加的tr行，不需要后台处理
			$(':checkbox[name="id"]:checked').each(function() {
				$(this).parent().parent().parent().remove();
			});
		} else {
			javaex.optTip({
				content : "数据提交中，请稍候...",
				type : "submit"
			});
			
			$.ajax({
				url : "delete.json",
				type : "POST",
				dataType : "json",
				traditional : "true",
				data : {
					"idArr" : idArr
				},
				success:function(rtn) {
					if (rtn.code=="000000") {
						javaex.optTip({
							content : rtn.message,
							type : "success"
						});
						// 建议延迟加载
						setTimeout(function() {
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
	});
	
	// 点击保存按钮事件
	$("#save").click(function() {
		// 表单验证函数
		if (javaexVerify()) {
			idArr = [];
			sortArr = [];
			nameArr = [];
			profileArr = [];
			playArr = [];
			
			// id
			$(':checkbox[name="id"]').each(function() {
				idArr.push($(this).val());
			});
			
			// 显示顺序
			$('input[name="sort"]').each(function() {
				sortArr.push($(this).val());
			});
			
			// 分类名称
			$('input[name="name"]').each(function() {
				nameArr.push($(this).val());
			});
			
			// 详情页模板
			$('select[name="profileTemplate"]').each(function() {
				profileArr.push($(this).val());
			});
			
			// 播放页模板
			$('select[name="playTemplate"]').each(function() {
				playArr.push($(this).val());
			});
			
			// 向后台提交
			$("#save").click(function() {
				javaex.optTip({
					content : "数据提交中，请稍候...",
					type : "submit"
				});
			});

			$.ajax({
				url : "save.json",
				dataType : "json",
				traditional : "true",	// 允许传递数组
				data : {
					"idArr" : idArr,
					"sortArr" : sortArr,
					"nameArr" : nameArr,
					"profileArr" : profileArr,
					"playArr" : playArr
				},
				success : function(rtn) {
					if (rtn.code=="000000") {
						javaex.optTip({
							content : rtn.message,
							type : "success"
						});
						// 建议延迟加载
						setTimeout(function() {
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
	});
</script>
</html>
