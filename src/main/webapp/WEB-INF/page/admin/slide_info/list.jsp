<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>幻灯片数据管理</title>
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
				<span class="active">幻灯片</span>
			</div>
		</div>
		
		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--页面有多个表格时，可以用于标识表格-->
				<h2>${apiName}</h2>
				<a href="javascript:history.back();">
					<button class="button wathet" style="position: absolute;right: 20px;top: 16px;"><span class="icon-arrow_back"></span> 返回</button>
				</a>
				
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
								<th style="width:70px;">显示顺序</th>
								<th>标题（title）</th>
								<th>看点（summary）</th>
								<th>大图（image）</th>
								<th>小图（thumbnail）</th>
								<th>链接（url）</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="entity" varStatus="status" >
								<tr>
									<td class="checkbox"><input type="checkbox" class="fill listen-1-2" value="${entity.id}" name="id" /> </td>
									<td><input type="text" class="text" name="sort" value="${entity.sort}" data-type="非负整数" error-msg="请填写非负整数" /></td>
									<td><input type="text" class="text" name="title" value="${entity.title}" /></td>
									<td><input type="text" class="text" name="summary" value="${entity.summary}" /></td>
									<td><input type="text" class="text" name="image" value="${entity.image}" /></td>
									<td><input type="text" class="text" name="thumbnail" value="${entity.thumbnail}" /></td>
									<td><input type="text" class="text" name="url" value="${entity.url}" /></td>
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

	// 幻灯片表主键
	var apiId = "${apiId}";

	var idArr = new Array();
	var sortArr = new Array();
	var titleArr = new Array();
	var summaryArr = new Array();
	var imageArr = new Array();
	var thumbnailArr = new Array();
	var urlArr = new Array();
	
	// 点击添加按钮，table向下追加一行
	$("#add").click(function() {
		var trHtml = '';
		trHtml += '<tr>';
		trHtml += '<td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="id" value="" /> </td>';
		trHtml += '<td><input type="text" class="text" name="sort" value="" data-type="非负整数" error-msg="请填写非负整数" /></td>';
		trHtml += '<td><input type="text" class="text" name="title" value="" /></td>';
		trHtml += '<td><input type="text" class="text" name="summary" value="" /></td>';
		trHtml += '<td><input type="text" class="text" name="image" value="" /></td>';
		trHtml += '<td><input type="text" class="text" name="thumbnail" value="" /></td>';
		trHtml += '<td><input type="text" class="text" name="url" value="" /></td>';
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
				dataType : "json",
				traditional : "true",	// 允许传递数组
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
			titleArr = [];
			summaryArr = [];
			imageArr = [];
			thumbnailArr = [];
			urlArr = [];
			
			// id
			$(':checkbox[name="id"]').each(function() {
				idArr.push($(this).val());
			});
			
			// 显示顺序
			$('input[name="sort"]').each(function() {
				sortArr.push($(this).val());
			});
			
			// 标题
			$('input[name="title"]').each(function() {
				titleArr.push($(this).val());
			});
			
			// 看点
			$('input[name="summary"]').each(function() {
				summaryArr.push($(this).val());
			});
			
			// 大图
			$('input[name="image"]').each(function() {
				imageArr.push($(this).val());
			});
			
			// 小图
			$('input[name="thumbnail"]').each(function() {
				thumbnailArr.push($(this).val());
			});
			
			// 链接
			$('input[name="url"]').each(function() {
				urlArr.push($(this).val());
			});
			
			javaex.optTip({
				content : "数据提交中，请稍候...",
				type : "submit"
			});
			
			// 向后台提交
			$.ajax({
				url : "save.json",
				type : "POST",
				dataType : "json",
				traditional : "true",
				data : {
					"apiId" : apiId,
					"idArr" : idArr,
					"sortArr" : sortArr,
					"titleArr" : titleArr,
					"summaryArr" : summaryArr,
					"imageArr" : imageArr,
					"thumbnailArr" : thumbnailArr,
					"urlArr" : urlArr
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
