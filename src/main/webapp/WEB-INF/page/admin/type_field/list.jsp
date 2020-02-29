<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>字段配置管理</title>
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
				<h2>${typeName}</h2>
				<a href="javascript:history.back();">
					<button class="button wathet" style="position: absolute;right: 20px;top: 16px;"><span class="icon-arrow_back"></span> 返回</button>
				</a>
				
				<!--正文内容-->
				<div class="main">
					<div style="display: flow-root;margin-bottom:20px;">
						<ul class="equal-6">
							<c:forEach items="${fieldList}" var="field">
								<li>
									<input type="checkbox" class="fill" name="field" value="${field.id}" <c:if test="${field.isSelected=='1'}">checked</c:if> />${field.name}
								</li>
							</c:forEach>
						</ul>
					</div>

					<!--表格上方的操作元素，添加、删除等-->
					<div class="operation-wrap">
						<div class="buttons-wrap">
							<button id="delete" class="button red"><span class="icon-minus"></span> 移除</button>
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
								<th>字段名称</th>
								<th>列表筛选</th>
								<th>必填</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="entity" varStatus="status" >
								<tr>
									<td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="fieldId" value="${entity.fieldId}" /> </td>
									<td><input type="text" class="text" name="sort" value="${entity.sort}" data-type="非负整数" error-msg="请填写非负整数" error-pos="36" /></td>
									<td>${entity.fieldName}</td>
									<td><input type="checkbox" class="fill" name="isScreen" value="1" <c:if test="${entity.isScreen=='1'}">checked</c:if> /> </td>
									<td><input type="checkbox" class="fill" name="isRequired" value="1" <c:if test="${entity.isRequired=='1'}">checked</c:if> /> </td>
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

	var fieldIdArr = new Array();
	var sortArr = new Array();
	var isScreenArr = new Array();
	var isRequiredArr = new Array();
	
	// 点击字段复选框事件
	$(':checkbox[name="field"]').click(function() {
		var fieldId = $(this).val();
		
		// 判断是否选中
		if ($(this).is(":checked")) {
			// 选中时，向表格中添加该字段
			var trHtml = '';
			trHtml += '<tr>';
			trHtml += '<td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="fieldId" value="'+fieldId+'" /> </td>';
			trHtml += '<td><input type="text" class="text" name="sort" value="" data-type="非负整数" error-msg="请填写非负整数" error-pos="36" /></td>';
			trHtml += '<td>'+$(this).next("span").text()+'</td>';
			trHtml += '<td><input type="checkbox" class="fill" name="isScreen" value="1" /> </td>';
			trHtml += '<td><input type="checkbox" class="fill" name="isRequired" value="1" /> </td>';
			trHtml += '</tr>';
			$("#table tbody").append(trHtml);
			// 动态加载html代码之后，需要重新渲染
			javaex.render();
		} else {
			// 删除表格中对应的字段
			// 遍历表格
			$(':checkbox[name="fieldId"]').each(function() {
				if (fieldId==$(this).val()) {
					$(this).parent().parent().parent().remove();
				}
			});
		}
	});
	
	// 点击删除按钮事件
	$("#delete").click(function() {
		fieldIdArr = [];
		// 遍历表格中选中的列
		$(':checkbox[name="fieldId"]:checked').each(function() {
			var fieldId = $(this).val();
			
			// 删除选中列
			$(this).parent().parent().parent().remove();
			
			// 遍历上面所有字段列
			$(':checkbox[name="field"]:checked').each(function() {
				if (fieldId==$(this).val()) {
					$(this).attr("checked", false);
				}
			});
		});
	});
	
	// 点击保存按钮事件
	$("#save").click(function() {
		// 表单验证函数
		if (javaexVerify()) {
			fieldIdArr = [];
			sortArr = [];
			isScreenArr = [];

			// fieldId 字段主键
			$(':checkbox[name="fieldId"]').each(function() {
				fieldIdArr.push($(this).val());
			});
			
			// 显示顺序
			$('input[name="sort"]').each(function() {
				sortArr.push($(this).val());
			});
			
			// 是否允许列表筛选
			$(':checkbox[name="isScreen"]').each(function() {
				if ($(this).is(":checked")) {
					isScreenArr.push($(this).val());
				} else {
					isScreenArr.push("");
				}
			});

			// 是否必填
			$(':checkbox[name="isRequired"]').each(function() {
				if ($(this).is(":checked")) {
					isRequiredArr.push($(this).val());
				} else {
					isRequiredArr.push("");
				}
			});
			
			// 向后台提交
			javaex.optTip({
				content : "数据提交中，请稍候...",
				type : "submit"
			});
			
			$.ajax({
				url : "save.json",
				dataType : "json",
				traditional : "true",	// 允许传递数组
				data : {
					"typeId" : "${typeId}",
					"fieldIdArr" : fieldIdArr,
					"sortArr" : sortArr,
					"isScreenArr" : isScreenArr,
					"isRequiredArr" : isRequiredArr
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
