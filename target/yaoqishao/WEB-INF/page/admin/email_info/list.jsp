<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>邮件设置管理</title>
<c:import url="../common/common.jsp"></c:import>
</head>

<body>
	<!-- 面包屑导航和主体内容 -->
	<div class="content">
		<!--面包屑导航-->
		<div class="content-header">
			<div class="breadcrumb">
				<span>站长</span>
				<span class="divider">/</span>
				<span class="active">邮件设置</span>
			</div>
		</div>
		
		<!--全部主体内容-->
		<div class="list-content">
			<!--块元素-->
			<div class="block">
				<!--页面有多个表格时，可以用于标识表格-->
				<h2>邮件设置列表（可设置多个）</h2>
				<!--正文内容-->
				<div class="main">
					<p class="tip">网易邮箱SMTP：smtp.163.com，端口25 （推荐使用）</p>
					<p class="tip">腾讯邮箱SMTP：smtp.foxmail.com，端口25</p>
					<p class="tip danger">后台测试时，可能会发送失败，原因未知！ 是否设置成功，以注册时的邮件发送为准！</p>
					
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
								<th>SMTP 服务器</th>
								<th>端口</th>
								<th>发信人邮件地址</th>
								<th>SMTP 身份验证密码</th>
								<th>操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="entity" varStatus="status" >
								<tr>
									<td class="checkbox"><input type="checkbox" class="fill listen-1-2" value="${entity.id}" name="id" /> </td>
									<td><input type="text" class="text" name="smtp" value="${entity.smtp}" data-type="必填" error-pos="36"/></td>
									<td><input type="text" class="text" name="port" value="${entity.port}" style="width:20%;" data-type="正整数" error-msg="必须填写正整数" error-pos="36"/></td>
									<td><input type="text" class="text" name="email" value="${entity.email}" data-type="邮箱" error-msg="邮箱格式错误" error-pos="36"/></td>
									<td><input type="text" class="text" name="password" value="${entity.password}" data-type="必填" error-pos="36"/></td>
									<td><button class="button wathet" onclick="test('${entity.id}')">检测</button></td>
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
	var smtpArr = new Array();
	var portArr = new Array();
	var emailArr = new Array();
	var passwordArr = new Array();
	
	// 点击添加按钮，table向下追加一行
	$("#add").click(function() {
		var trHtml = '';
		trHtml += '<tr>';
		trHtml += '<td class="checkbox"><input type="checkbox" class="fill listen-1-2" name="id" value="" /> </td>';
		trHtml += '<td><input type="text" class="text" name="smtp" value="" data-type="必填" error-pos="36"/></td>';
		trHtml += '<td><input type="text" class="text" name="port" value="" style="width:20%;" data-type="正整数" error-msg="必须填写正整数" error-pos="36"/></td>';
		trHtml += '<td><input type="text" class="text" name="email" value="" data-type="邮箱" error-msg="邮箱格式错误" error-pos="36"/></td>';
		trHtml += '<td><input type="text" class="text" name="password" value="" data-type="必填" error-pos="36"/></td>';
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
	
	// 点击保存按钮事件
	$("#save").click(function() {
		// 表单验证函数
		if (javaexVerify()) {
			idArr = [];
			smtpArr = [];
			portArr = [];
			emailArr = [];
			passwordArr = [];
			
			// id
			$(':checkbox[name="id"]').each(function() {
				idArr.push($(this).val());
			});
			
			// SMTP 服务器
			$('input[name="smtp"]').each(function() {
				smtpArr.push($(this).val());
			});
			
			// 端口
			$('input[name="port"]').each(function() {
				portArr.push($(this).val());
			});
			
			// 发信人邮件地址
			$('input[name="email"]').each(function() {
				emailArr.push($(this).val());
			});

			// SMTP 身份验证密码
			$('input[name="password"]').each(function() {
				passwordArr.push($(this).val());
			});
			
			javaex.optTip({
				content : "数据提交中，请稍候...",
				type : "submit"
			});
			
			// 向后台提交
			$.ajax({
				url : "save.json",
				dataType : "json",
				traditional : "true",	// 允许传递数组
				data : {
					"idArr" : idArr,
					"smtpArr" : smtpArr,
					"portArr" : portArr,
					"emailArr" : emailArr,
					"passwordArr" : passwordArr
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
	
	// 检测邮件发送
	function test(id) {
		javaex.alert({
			title : "检测邮件发送设置",
			content : '<input type="text" class="text" style="width:100%;" id="to_email" value="" data-type="邮箱" error-msg="邮箱格式错误" error-pos="30"/>',
			confirmName : "发送",
			callback : "callback("+id+")"
		});
		// 重新渲染
		javaex.render();
	}
	
	function callback(id) {
		if (javaexVerify()) {
			javaex.optTip({
				content : "邮件发送中，请稍候...",
				type : "submit"
			});
			
			$.ajax({
				url : "test.json",
				type : "POST",
				dataType : "json",
				data : {
					"id" : id,
					"toEmail" : $("#to_email").val()
				},
				success : function(rtn) {
					if (rtn.code=="000000") {
						javaex.optTip({
							content : "发送成功",
							type : "success"
						});
						// 建议延迟加载
						setTimeout(function() {
							// 关闭弹出层
							javaex.close();
						}, 2000);
						return true;
					} else {
						javaex.optTip({
							content : rtn.message,
							type : "error"
						});
					}
				}
			});
			return false;
		} else {
			return false;
		}
	}
</script>
</html>
