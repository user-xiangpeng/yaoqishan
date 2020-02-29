<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>用户注册 - ${webInfo.name}</title>
<link rel="shortcut icon" href=${pageContext.request.contextPath}/static/favicon.ico type=image/x-icon>
<!--字体图标样式-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/icomoon.css" rel="stylesheet" />
<!--动画样式-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/animate.css" rel="stylesheet" />
<!--骨架样式-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/common.css" rel="stylesheet" />
<!--皮肤（缇娜）-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/skin/tina.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/lib/jquery-1.7.2.min.js"></script>
<!--核心组件-->
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/js/javaex.min.js"></script>
<link href="${pageContext.request.contextPath}/static/default/css/loginreg.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/static/default/js/cookie.js"></script>
<style>
	.login-step-con{
		height: 650px;
	}
	.login-frame{
		height: 500px;
	}
	.login-frame-st .login-frame-top, .login-frame-st1 .login-frame-top{
		height: 460px;
	}
	.btn-login {
		margin-top: 60px;
	}
</style>
</head>
<body>
	<div>
		<div class="register-title-con">
			<div class="register-title-subcon">
				<a href="${pageContext.request.contextPath}/portal/login_page.action" class="fr account-login"><font style="vertical-align: inherit;">账号登录</font></a>
				<div class="qiyiLogo"><a href="${webInfo.domain}" class="tw-qiyiLogo-link"></a></div>
			</div>
		</div>
		
		<div class="login-step-con">
			<div class="login-frame login-frame-st1 login-frame-stm login-frame-tw">
				<div id="register" class="login-frame-top">
					<form id="form">
						<div class="login-frame-ti">
							<h2 class="login-title">用户注册</h2>
							<p class="sub-title">注册过程需要验证邮箱，请注意</p>
							<div class="info-container">
								<p class="errorInfo vh"><span>账号错误</span></p>
								<div class="tip-container tip-account-container">
									<p class="tip-info">请输入账号</p>
									<input type="text" class="txt-info txt-account" name="loginName" />
								</div>
							</div>
							<div class="info-container">
								<p class="errorInfo vh">
									<span>密码错误</span>
								</p>
								<div class="tip-container tip-pwd-container">
									<p class="tip-info">请输入密码</p>
									<input type="password" class="txt-info txt-password" name="passWord" />
								</div>
								<a href="javascript:;" class="eye-close"></a>
							</div>
							<div class="info-container">
								<p class="errorInfo vh"><span>邮箱错误</span></p>
								<div class="tip-container tip-account-container">
									<p class="tip-info">请输入邮箱</p>
									<input type="text" class="txt-info txt-account" name="email" />
								</div>
							</div>
							<a href="javascript:;" onclick="register()" class="btn-green btn-login">注册</a>
						</div>
					</form>
				</div>
				
				<div id="validate" class="login-frame-top" style="display:none;">
					<div class="login-frame-ti">
						<h2 class="login-title">用户激活</h2>
						<p class="sub-title">验证码已发送至邮箱</p>
						<div class="info-container">
							<p class="errorInfo vh"><span>验证码错误</span></p>
							<div class="tip-container tip-account-container">
								<p class="tip-info">请输入验证码</p>
								<input type="text" id="identifying_code" class="txt-info txt-account" />
							</div>
						</div>
						<div class="forget-pwd fr">
							<a href="javascript:;" onclick="sendEmail()">没有收到，点击重新发送</a>
						</div>
						<a href="javascript:;" onclick="validate()" class="btn-green btn-login">激活</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	$('input[type="text"], input[type="password"]').focus(function() {
		$(this).parent().parent().addClass("accountIn");
	});
	$('input[type="text"], input[type="password"]').blur(function() {
		if ($(this).val()=="") {
			$(this).parent().parent().removeClass("accountIn");
		}
	});
	
	// 点击注册
	function register() {
		$.ajax({
			url : "${pageContext.request.contextPath}/portal/user_info/register.json",
			type : "POST",
			dataType : "json",
			data : $("#form").serialize(),
			success : function(rtn) {
				if (rtn.code=="000000") {
					var info = rtn.data.info;
					
					delCookie("UID");
					delCookie("userToken");
					setCookie("UID", info.UID);
					setCookie("userToken", info.userToken);
					
					$("#register").hide();
					$("#validate").show();
					sendEmail();
				} else {
					javaex.optTip({
						content : rtn.message,
						type : "error"
					});
				}
			}
		});
	}
	
	// 发送邮件
	function sendEmail() {
		javaex.optTip({
			content : "邮件发送中，请稍候...",
			type : "submit"
		});
		
		$.ajax({
			url : "${pageContext.request.contextPath}/portal/user_info/register_email.json",
			type : "POST",
			dataType : "json",
			data : {
				"userToken" : getCookie("userToken")
			},
			success : function(rtn) {
				if (rtn.code=="000000") {
					javaex.optTip({
						content : "邮件发送成功，请前往查收验证码",
						type : "success"
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
	
	// 点击激活账号
	function validate() {
		$.ajax({
			url : "${pageContext.request.contextPath}/portal/user_info/validate_email.json",
			type : "POST",
			dataType : "json",
			data : {
				"identifyingCode" : $("#identifying_code").val(),
				"userToken" : getCookie("userToken")
			},
			success : function(rtn) {
				if (rtn.code=="000000") {
					javaex.optTip({
						content : "注册成功，即将为您跳转到登录页",
						type : "success"
					});
					
					setTimeout(function() {
						window.location.href = "${pageContext.request.contextPath}/portal/login_page.action";
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
