<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>个人设置-${webInfo.name}</title>
<c:import url="../../common/common.jsp"></c:import>
<style>
	.set-tit{display: inline-block; vertical-align: top; width: 44px; line-height: 19px; font-size: 14px; color: #999;}
	.user-avatar{display: inline-block; cursor: pointer;}
	.user-avatar img{display: block; width: 50px; height: 50px; border: 3px solid #484848; border-radius: 50%;}
	.edit-input{width: 60%; height: 33px; padding: 5px 10px; background: #333; border: 1px solid #515151; border-radius: 33px; box-sizing: border-box; font-size: 14px; line-height: 19px; color: #ccc;}
	.edit-btn{height: 33px; padding: 0 15px; border-radius: 33px; margin-left: 20px; line-height: 33px; font-size: 14px; display: inline-block; background: #049b00; color: #fff; vertical-align: top; cursor: pointer;}
	.page-wrap.footer-wrap{position: absolute; width: 100%; bottom: 0; left: 0; right: 0;}
</style>
</head>
<body>
	<!-- 头部 -->
	<div class="yaoqishan-header">
		<c:import url="../../common/header.jsp"></c:import>
	</div>
			
	<!--主体-->
	<div style="width: 1340px; margin: 20px auto;">
		<div class="block no-shadow">
			<h2>个人设置</h2>
			<div class="main">
				<table class="table no-line">
					<tbody>
						<tr>
							<td style="width:10%;">
								头像
							</td>
							<td style="width:80%;">
								<a class="user-avatar">
									<c:choose>
										<c:when test="${empty userInfo.avatar}">
											<img src="http://doc.javaex.cn/javaex/javaex/pc/images/user.jpg" />
										</c:when>
										<c:otherwise>
											<img src="${userInfo.avatar}" />
										</c:otherwise>
									</c:choose>
								</a>
							</td>
							<td>
								<a href="javascript:;" onclick="changeAvatar()" style="line-height: 56px;color: #055f95;">修改</a>
							</td>
						</tr>
						<tr>
							<td style="height: 30px;">昵称</td>
							<td>${userInfo.loginName}</td>
							<td></td>
						</tr>
						<tr>
							<td style="height: 30px;">UID</td>
							<td>${userInfo.id}</td>
							<td></td>
						</tr>
						<tr>
							<td style="height: 30px;">邮箱</td>
							<td style="position: relative;">
								<span id="user_email" class="set-con">${userInfo.email}</span>
								<div id="change_email" class="name-edit" style="background: none;display: none;width: 60%;position: absolute;top: 5px;">
									<input type="text" id="email" class="edit-input original" style="width: 60%;" />
									<a class="edit-btn" onclick="changeEmail()">保存</a>
								</div>
							</td>
							<td><a href="javascript:;" onclick="showChangeEmail()" style="color: #055f95;">换绑</a></td>
						</tr>
						<tr>
							<td style="height: 30px;">密码</td>
							<td style="position: relative;">
								<span class="set-con">***********</span>
								<div id="change_password" class="name-edit" style="background: none;display: none;width: 60%;position: absolute;top: 5px;">
									<input type="text" id="password" class="edit-input original" style="width: 60%;" />
									<a class="edit-btn" onclick="changePassword()">保存</a>
								</div>
							</td>
							<td><a href="javascript:;" onclick="showChangePassword()" style="color: #055f95;">修改</a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	
	<!--底部-->
	<div class="page-wrap footer-wrap" >
		<c:import url="../../common/footer.jsp"></c:import>
	</div>
</body>
<script>
	var userToken = getCookie("userToken");
	
	// 修改头像
	function changeAvatar() {
		javaex.dialog({
			type : "login",	// 弹出层类型
			width : "900",
			height : "603",
			url : "${pageContext.request.contextPath}/portal/user_profile_info/change_avatar.action"
		});
	}
	
	// 换绑邮箱
	function showChangeEmail() {
		$("#change_email").show();
	}
	function changeEmail() {
		if ($("#email").val()=="") {
			javaex.optTip({
				content : "请填写新的邮箱地址",
				type : "error"
			});
		} else {
			sendEmail();
		}
	}
	// 获取验证码
	function sendEmail() {
		javaex.optTip({
			content : "系统处理中，请稍候...",
			type : "submit"
		});
		
		$.ajax({
			url : "${pageContext.request.contextPath}/portal/user_info/send_email.json",
			type : "POST",
			dataType : "json",
			data : {
				"userToken" : userToken
			},
			success : function(rtn) {
				if (rtn.code=="000000") {
					javaex.optTip({
						content : "邮件发送成功",
						type : "success"
					});
					
					javaex.alert({
						title : "填写验证码",
						width : "300",
						content : '验证码已发至旧邮箱，<br />请填写收到的验证码<br /><input type="text" class="text" id="identifying_code" style="width: 100%;" value="" />',
						callback : "saveEmail()"
					});
				} else {
					javaex.optTip({
						content : "邮件发送失败，请重试",
						type : "error"
					});
				}
			}
		});
	}
	// 修改邮箱
	function saveEmail() {
		var newEmail = $("#email").val();
		$.ajax({
			url : "${pageContext.request.contextPath}/portal/user_info/change_email.json",
			type : "POST",
			dataType : "json",
			data : {
				"email" : newEmail,
				"identifyingCode" : $("#identifying_code").val(),
				"userToken" : userToken
			},
			success : function(rtn) {
				if (rtn.code=="000000") {
					javaex.optTip({
						content : "修改成功",
						type : "success"
					});
					// 建议延迟加载
					setTimeout(function() {
						// 关闭弹出层
						javaex.close();
					}, 2000);
					$("#user_email").text(newEmail);
					$("#change_email").hide();
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
	}
	
	// 修改密码
	function showChangePassword() {
		$("#change_password").show();
	}
	function changePassword() {
		$.ajax({
			url : "${pageContext.request.contextPath}/portal/user_info/change_pass_word.json",
			type : "POST",
			dataType : "json",
			data : {
				"passWord" : $("#password").val(),
				"userToken" : userToken
			},
			success : function(rtn) {
				if (rtn.code=="000000") {
					javaex.optTip({
						content : "修改成功",
						type : "success"
					});
					$("#change_password").hide();
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
