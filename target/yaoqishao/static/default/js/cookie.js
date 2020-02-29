//获取指定名称的cookie的值
function getCookie(objName) {
	//得到分割的cookie名值对
	var arrStr = document.cookie.split("; ");
	for (var i = 0; i < arrStr.length; i++) {
		//将名和值分开
		var temp = arrStr[i].split("=");
		if (temp[0] == objName)
			return unescape(temp[1]);
	}
	return "";
}

//添加cookie
function addCookie(objName, objValue) { 
	var str = objName + "=" + escape(objValue);
	//为0时不设定过期时间，浏览器关闭时cookie自动消失
	var ms = 30 * 24 * 3600 * 1000;
	var date = new Date();
	date.setTime(date.getTime() + ms);
	str += "; path=/; expires=" + date.toGMTString();
	document.cookie = str;
}

// 两个参数，一个是cookie的名字，一个是值
function setCookie(name, value) {
	//此 cookie 将被保存 30 天
	var Days = 30;
	var exp = new Date();
	exp.setTime(exp.getTime() + Days * 24 * 60 * 60 * 1000);
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + exp.toGMTString();
}

// 删除cookie
function delCookie(name) {
	var exp = new Date();
	exp.setTime(exp.getTime() - 1);
	var cval = getCookie(name);
	if (cval!=null) {
		document.cookie = name + "=" + cval + "; path=/; expires=" + exp.toGMTString();
	}
}
