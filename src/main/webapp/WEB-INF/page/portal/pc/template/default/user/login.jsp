<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>用户登录</title>
<!--字体图标样式-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/icomoon.css" rel="stylesheet" />
<!--动画样式-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/animate.css" rel="stylesheet" />
<!--骨架样式-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/common.css" rel="stylesheet" />
<!--皮肤（缇娜）-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/skin/tina.css" rel="stylesheet" />
<!--jquery，当前版本不可更改jquery版本-->
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/lib/jquery-1.7.2.min.js"></script>
<!--全局动态修改-->
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/js/common.js"></script>
<!--核心组件-->
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/js/javaex.min.js"></script>
<!--表单验证-->
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/js/javaex-formVerify.js"></script>
<script src="${pageContext.request.contextPath}/static/default/js/cookie.js"></script>
</head>
<style>
	body{background-color: #fff;}
	.login-form{width: 288px;background: #fff;padding: 20px 38px 0;margin:20px;}
	.login-title{font-size: 20px;text-align: center;margin-bottom: 25px;}
	.login-item{display: flex;margin-bottom: 14px;}
	.login-link{margin-bottom: 14px;}
	.login-link label, .login-link a{color: #9B9B9C;}
	.login-link a{font-size: 14px;}
	.login-text{min-height: 40px;width: 100%;color: #B3B3B3;font-size: 14px;border: 1px solid #EEEFF0;border-radius: 3px;font-family: Helvetica, "microsoft yahei", sans-serif;padding-left: 16px;outline: none;}
	.button.login{background-color: #2D9C8B;color: white;width: 100%;border-radius: 3px;font-size: 14px;height: 40px;line-height: 40px;}
	.login-link .line{display: inline-block;width: 1px;height: 12px;background-color: #EEEEEE;margin: 0 6px;}
</style>
<body>
	<!--登录-->
	<div class="login-form">
		<form id="form">
			<!--标题-->
			<div class="login-title">登录</div>
			<!--用户名-->
			<div class="login-item">
				<input type="text" class="login-text" name="loginName" data-type="必填" placeholder="用户名" />
			</div>
			<!--密码-->
			<div class="login-item">
				<input type="password" class="login-text" id="pass_word" name="passWord" data-type="必填" placeholder="请输入密码" />
			</div>
			<!--登录按钮-->
			<div class="login-item">
				<input type="button" id="submit" class="button login" value="登录" />
			</div>
			<!--底部链接-->
			<div class="login-link">
				<label zoom="0.9"><input type="checkbox" class="fill" checked/>下次自动登录</label>

				<span style="float: right;">
					<a href="${pageContext.request.contextPath}/portal/find_pwd.action" target="_blank">忘记密码</a>
					<span class="line"></span>
					<a href="${pageContext.request.contextPath}/portal/register.action" target="_blank"">注册</a>
				</span>
			</div>
		</form>
	</div>
</body>
<script>
	// 监听点击保存按钮事件
	$("#submit").click(function() {
		// 表单验证函数
		if (javaexVerify()) {
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

						// 关闭弹出层
						parent.javaex.close();
						// 刷新页面
						parent.location.reload();
					} else {
						addErrorMsg("pass_word", rtn.message);
					}
				}
			});
		}
	});
</script>
</html>