<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>找回密码 - ${webInfo.name}</title>
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
	.login-step-con .login-frame-stm{
		margin-top: 0;
	}
	#second, #second_btn, #third, #third_btn{
		display:none;
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
			<div class="stepNav">
				<div class="stepNavInner">
					<div class="stepNavInnerLt lt1">
						<i class="step-num-i"><font style="vertical-align: inherit;">1.</font></i>
						<span class="step-txt-i"><font style="vertical-align: inherit;">输入邮箱</font></span>
					</div>
					<div class="stepNavInnerCt ct1">
						<i class="step-num-i"><font style="vertical-align: inherit;">2.</font></i>
						<span class="step-txt-i"><font style="vertical-align: inherit;">填写验证码</font></span>
					</div>
					<div class="stepNavInnerRt rt1">
						<i class="step-num-i"><font style="vertical-align: inherit;">3.</font></i>
						<span class="step-txt-i"><font style="vertical-align: inherit;">设置新密码</font></span>
					</div>
				</div>
			</div>
			<div class="login-frame login-frame-st1 login-frame-stm login-frame-tw">
				<div class="login-frame-top">
					<div class="login-frame-ti">
						<h2 class="login-title">找回密码</h2>
						<div id="first" class="info-container">
							<p class="errorInfo vh"><span>邮箱错误</span></p>
							<div class="tip-container tip-account-container">
								<p class="tip-info">请输入邮箱</p>
								<input type="text" id="email" class="txt-info txt-account original" />
							</div>
						</div>
						<a id="first_btn" href="javascript:;" onclick="sendEmail()" class="btn-green btn-login">发送验证邮件</a>
						
						<div id="second" class="info-container">
							<p class="errorInfo vh"><span>验证码错误</span></p>
							<div class="tip-container tip-account-container">
								<p class="tip-info">请输入验证码</p>
								<input type="text" id="identifying_code" class="txt-info txt-account original" />
							</div>
						</div>
						<a id="second_btn" href="javascript:;" onclick="identifyingCode()" class="btn-green btn-login">校验验证码</a>
						
						<div id="third" class="info-container">
							<p class="errorInfo vh"><span>密码格式错误</span></p>
							<div class="tip-container tip-account-container">
								<p class="tip-info">请输入新的密码</p>
								<input type="password" id="pass_word" class="txt-info txt-password" />
							</div>
						</div>
						<a id="third_btn" href="javascript:;" onclick="setNewPassword()" class="btn-green btn-login">设置新密码</a>
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
	
	// 发送邮件验证码
	function sendEmail() {
		if ($("#email").val()=="") {
			javaex.optTip({
				content : "邮箱不能为空",
				type : "error"
			});
		} else {
			javaex.optTip({
				content : "邮件发送中，请稍候...",
				type : "submit"
			});
			
			$.ajax({
				url : "${pageContext.request.contextPath}/portal/user_info/find_pwd_email.json",
				type : "POST",
				dataType : "json",
				data : {
					"email" : $("#email").val()
				},
				success : function(rtn) {
					if (rtn.code=="000000") {
						javaex.optTip({
							content : "邮件已发出，请查看",
							type : "success"
						});
						
						// 邮件发送成功
						// 切换到第二个标签
						$(".stepNavInnerLt").addClass("lt2").removeClass("lt1");
						$(".stepNavInnerCt").addClass("ct2").removeClass("ct1");
						
						// 隐藏第一个标签下的元素
						$("#first").hide();
						$("#first_btn").hide();
						
						// 显示第二个标签下的元素
						$("#second").show();
						$("#second_btn").css("display", "block");
					} else {
						javaex.optTip({
							content : "邮件发送失败，请稍后重试",
							type : "error"
						});
					}
				}
			});
		}
	}
	
	// 校验验证码
	function identifyingCode() {
		if ($("#identifying_code").val()=="") {
			javaex.optTip({
				content : "验证码不能为空",
				type : "error"
			});
		} else {
			$.ajax({
				url : "${pageContext.request.contextPath}/portal/user_info/find_pwd_code.json",
				type : "POST",
				dataType : "json",
				data : {
					"email" : $("#email").val(),
					"identifyingCode" : $("#identifying_code").val()
				},
				success : function(rtn) {
					if (rtn.code=="000000") {
						// 邮件发送成功
						// 切换到第三个标签
						$(".stepNavInnerLt").addClass("lt2").removeClass("lt1");
						$(".stepNavInnerCt").addClass("ct3").removeClass("ct2");
						$(".stepNavInnerRt").addClass("rt2").removeClass("rt1");
						
						// 隐藏第二个标签下的元素
						$("#second").hide();
						$("#second_btn").hide();
						
						// 显示第三个标签下的元素
						$("#third").show();
						$("#third_btn").css("display", "block");
					} else {
						javaex.optTip({
							content : rtn.message,
							type : "error"
						});
					}
				}
			});
		}
	}
	
	// 设置新密码
	function setNewPassword() {
		if ($("#pass_word").val()=="") {
			javaex.optTip({
				content : "密码不能为空",
				type : "error"
			});
		} else {
			$.ajax({
				url : "${pageContext.request.contextPath}/portal/user_info/set_new_pass_word.json",
				type : "POST",
				dataType : "json",
				data : {
					"email" : $("#email").val(),
					"identifyingCode" : $("#identifying_code").val(),
					"passWord" : $("#pass_word").val()
				},
				success : function(rtn) {
					if (rtn.code=="000000") {
						javaex.optTip({
							content : "密码修改成功，即将为您跳转到登录页",
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
	}
</script>
</html>
