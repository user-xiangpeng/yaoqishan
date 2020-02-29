<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>字段信息</title>
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
				<span class="active">字段设置</span>
			</div>
		</div>
		
		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--页面有多个表格时，可以用于标识表格-->
				<h2>字段列表</h2>
				<!--正文内容-->
				<div class="main">
					<p class="tip danger">看点和总集数为系统内置，禁止删除</p>
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
								<th style="width:10%;">显示顺序</th>
								<th style="width:23%;">名称</th>
								<th style="width:23%;">变量名</th>
								<th>填写类型</th>
								<th style="width:10%;">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${pageInfo.list}" var="entity" varStatus="status" >
								<tr>
									<td class="checkbox"><input type="checkbox" class="fill listen-1-2" value="${entity.id}" name="id" /> </td>
									<td><input type="text" class="text" name="sort" value="${entity.sort}" data-type="非负整数" error-msg="请填写非负整数" error-pos="36" /></td>
									<td><input type="text" class="text" name="name" value="${entity.name}" data-type="必填" error-pos="36" /></td>
									<td><input type="text" class="text" name="varName" value="${entity.varName}" data-type="必填" error-pos="36" /></td>
									<td>
										<select class="select" name="inputType">
											<c:forEach items="${optList}" var="opt">
												<option value="${opt.value}"
													<c:if test="${opt.value==entity.inputType}">selected</c:if>
													<c:if test="${opt.value=='image'}">disabled</c:if>
												>${opt.name}</option>
											</c:forEach>
										</select>
									</td>
									<td>
										<c:if test="${entity.isAllowEdit=='1'}">
											<a href="${pageContext.request.contextPath}/field_profile_info/list.action?fieldId=${entity.id}&fieldName=${entity.name}">
												<button class="button wathet"><span class="icon-edit-2"></span> 详情</button>
											</a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					
					<!-- 分页 -->
					<div class="page">
						<ul id="page" class="pagination"></ul>
					</div>
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
	var varNameArr = new Array();
	var inputTypeArr = new Array();

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
		
		window.location.href = "list.action"
				+ "?pageNum="+pageNum
				;
	}
	
	// 点击添加按钮，table向下追加一行
	$("#add").click(function() {
		var trHtml = '';
		trHtml += '<tr>';
		trHtml += '<td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="id" value="" /> </td>';
		trHtml += '<td><input type="text" class="text" name="sort" value="" data-type="非负整数" error-msg="请填写非负整数" error-pos="36" /></td>';
		trHtml += '<td><input type="text" class="text" name="name" value="" data-type="必填" error-pos="36" /></td>';
		trHtml += '<td><input type="text" class="text" name="varName" value="" data-type="必填" error-pos="36" /></td>';
		trHtml += '<td>';
		trHtml += '<select class="select" name="inputType">';
		trHtml += '<c:forEach items="${optList}" var="opt">';
		trHtml += '<option value="${opt.value}" ';
		trHtml += '<c:if test="${opt.value==\'image\'}">disabled</c:if>';
		trHtml += '>${opt.name}</option>';
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
							content : rtn.message
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
			varNameArr = [];
			inputTypeArr = [];
			
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
			
			// 变量名称
			$('input[name="varName"]').each(function() {
				varNameArr.push($(this).val());
			});
			
			// 填写类型
			$('select[name="inputType"]').each(function() {
				inputTypeArr.push($(this).val());
			});
			
			// 向后台提交
			javaex.optTip({
				content : "数据提交中，请稍候...",
				type : "submit"
			});
			
			$.ajax({
				url : "save.json",
				type : "POST",
				dataType : "json",
				traditional : "true",
				data : {
					"idArr" : idArr,
					"sortArr" : sortArr,
					"nameArr" : nameArr,
					"varNameArr" : varNameArr,
					"inputTypeArr" : inputTypeArr
				},
				success : function(rtn) {
					if (rtn.code=="000000") {
						javaex.optTip({
							content : rtn.message
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
