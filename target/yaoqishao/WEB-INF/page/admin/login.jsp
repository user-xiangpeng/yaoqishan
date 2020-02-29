<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>后台登录-妖气山视频管理系统</title>
<!--字体图标-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/icomoon.css" rel="stylesheet" />
<!--动画-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/animate.css" rel="stylesheet" />
<!--骨架样式-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/common.css" rel="stylesheet" />
<!--皮肤（缇娜）-->
<link href="${pageContext.request.contextPath}/static/default/javaex/pc/css/skin/tina.css" rel="stylesheet" />
<!--jquery，请勿轻易修改版本-->
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/lib/jquery-1.7.2.min.js"></script>
<!--全局动态修改-->
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/js/common.js"></script>
<!--核心组件-->
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/js/javaex.min.js"></script>
<!--表单验证-->
<script src="${pageContext.request.contextPath}/static/default/javaex/pc/js/javaex-formVerify.js"></script>
</head>
<style>
	html{height:100%;}
	body{background: url(http://173.javaex.cn/bj.jpg) no-repeat; width: 100%; height: 100%; background-size: 100% 100%;}
	:-webkit-autofill {-webkit-text-fill-color: none;transition: background-color 5000s ease-in-out 0s;}
	.form-data{background-color: #ffffff;width: 460px;left: 50%;margin-left: -230px;border-radius: 5px;box-shadow: 0 0 30px rgba(0,0,0,.1);padding: 65px 0 30px 0;position: fixed;top: 20%;}
	.form-data .p-input, .find_password .p-input{padding: 5px 0; height: 44px; box-sizing: border-box; border-bottom: 1px solid #e5e5e5; width: 340px; margin: 0 auto 16px; line-height: 14px; display: block;}
	::-webkit-input-placeholder{font-size: 14px; position: absolute; display: inline-block; color: #cacaca; top: 22px;}
	.form-data input, .find_password input{outline: none; border: none; z-index: 5; position: absolute; top: 13px; width: 340px; background-color: transparent; font-size: 20px;}
	.form-data .head-logo{position: absolute; top: -47px; left: 116px;}
	.pos{position: relative;}
	.login-link{width: 340px;margin: 0 auto;}
	.button.yes{width: 340px; font-size: 18px; font-weight: bold; color: white; height: 50px; line-height: 50px; text-align: center; margin: 10px auto; display: block; border-radius: 5px; cursor: pointer; background-color: #42a5f5; position: relative;padding：0；}
	a{color:#666}
	a:visited {color: #666;}
</style>
<body>
	<div class="form-data pos">
		<img src="http://173.javaex.cn/login.png" class="head-logo">
		<!--表单-->
		<form id="login">
			<p class="p-input pos">
				<input type="text" class="original" name="login_name" data-type="必填" error-pos="25" placeholder="请输入登录名">
			</p>
			<p class="p-input pos">
				<input type="password" class="original" id="pass_word" name="pass_word" data-type="必填" error-pos="25" placeholder="请输入密码">
			</p>

			<div class="login-link">
				<label zoom="0.9" class="fill-label" style="zoom: 0.9;"><input type="checkbox" class="fill" checked="1">下次自动登录<span class="fill-css icon-check" style="color: #fff;"></span></label>

				<span style="float: right;">
					<a href="#" target="_blank">忘记密码</a>
				</span>
			</div>

			<input type="button" id="submit" class="button yes" value="登录" />
		</form>
	</div>
</body>
<script>
	// 监听点击保存按钮事件
	$("#submit").click(function() {
		// 表单验证函数
		if (javaexVerify()) {
			$.ajax({
				url: "${pageContext.request.contextPath}/admin/login.json",
				type : "post",
				dataType : "json",
				data: $("#login").serialize(),
				success: function (rtn) {
					if (rtn.code=="000000") {
						window.location.href = "${pageContext.request.contextPath}/admin/index.action";
					} else {
						addErrorMsg("pass_word", rtn.message);
					}
				}
			});
		}
	});
</script>
</html>
