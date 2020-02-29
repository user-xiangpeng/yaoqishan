<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>用户登录 - ${webInfo.name}</title>
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
</head>
<body>
	<div>
		<div class="register-title-con">
			<div class="register-title-subcon">
				<a href="${pageContext.request.contextPath}/portal/register.action" class="fr account-login"><font style="vertical-align: inherit;">用户注册</font></a>
				<div class="qiyiLogo"><a href="${webInfo.domain}" class="tw-qiyiLogo-link"></a></div>
			</div>
		</div>
		
		<div class="login-step-con">
			<div class="login-frame login-frame-st1 login-frame-stm login-frame-tw">
				<div class="login-frame-top">
					<form id="form">
						<div class="login-frame-ti">
							<h2 class="login-title">账号登录</h2>
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
							<div class="forget-pwd fr">
								<a href="${pageContext.request.contextPath}/portal/find_pwd.action">忘记密码</a>
							</div>
							<a href="javascript:;" onclick="login()" class="btn-green btn-login">登录</a>
						</div>
					</form>
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
	function login() {
		$.ajax({
			url : "${pageContext.request.contextPath}/portal/user_info/login.json",
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

					// 跳转到首页
					window.location.href = "${pageContext.request.contextPath}/";
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
