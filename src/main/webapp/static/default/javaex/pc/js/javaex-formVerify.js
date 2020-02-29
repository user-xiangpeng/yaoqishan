/**
 * 作者：陈霓清
 * 官网：http://www.javaex.cn
 */
// 自定义验证类型	必填项：页面中直接写 data-type="必填" 即可，不需要为其定义正则表达式
var regJson = {
	"金额" : "/(^[1-9]([0-9]+)?(\.[0-9]{1,2})?$)|(^(0){1}$)|(^[0-9]\.[0-9]([0-9])?$)/",	// 0 + 正整数 + 最多2位小数(正数)
	"整数" : "/^-?\\d+$/",
	"正整数" : "/^[0-9]*[1-9][0-9]*$/",
	"负整数" : "/^-[0-9]*[1-9][0-9]*$/",
	"非负整数" : "/^\\d+$/",	// 正整数 + 0
	"非正整数" : "/^((-\\d+)|(0+))$/",	// 负整数 + 0
	"正小数" : "/^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$/",
	"负小数" : "/^(-(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*)))$/",
	"非负小数" : "/^\\d+(\\.\\d+)?$/",	// 0 + 正小数
	"非正小数" : "/^((-\\d+(\\.\\d+)?)|(0+(\\.0+)?))$/",	// 0 + 负小数
	"邮箱" : "/^[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+$/",
	"手机号" : "/^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0,5-9]))\\d{8}$/",
	"身份证号" : "/(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)/",
	"中文" : "/^[\u4e00-\u9fa5]+$/",
	"英文字母" : "/^[a-zA-Z]+$/",
	"英文字母或数字" : "/^[0-9a-zA-Z]+$/",
	"QQ" : "/^[1-9][0-9]{4,9}$/",
	"车牌号" : "/^[京津沪渝冀豫云辽黑湘皖鲁新苏浙赣鄂桂甘晋蒙陕吉闽贵粤青藏川宁琼使领A-Z]{1}[A-Z]{1}[A-Z0-9]{4}[A-Z0-9挂学警港澳]{1}$/",
	"登录名" : "/^[a-zA-Z]{1}([a-zA-Z0-9]){4,9}$/"		// 只能输入5-10个以字母开头，可带数字的字符串
};

/**
 * javaex表单验证插件入口
 */
function javaexVerify() {
	var result = true;
	// 遍历当前页面所有input元素
	$("input, textarea, select").each(function() {
		var dataTypeAll = $(this).attr("data-type");
		// 判断该输入框是否需要进行验证
		if (dataTypeAll!=null && dataTypeAll!=undefined) {
			// 防止自定义错误提示后，再次提交
			if ($(this).next()!=null) {
				if ($(this).next().hasClass("win")) {
					// 因为这里直接return false;不知道为什么没有效果，但又不想遍历所有项，所以这样写
					result = false;
					return result;
				}
			}
			if (!formVerify($(this), dataTypeAll)) {
				result = false;
			}
		}
	});
	
	return result;
}

/**
 * 正则表达式验证函数
 * obj : jquery对象
 * dataTypeAll : 需要验证哪些类型
 */
function formVerify(obj, dataTypeAll) {
	// 判断内容去除左右两边空格后是否为空
	if ($.trim(obj.val()).length==0) {
		// 解除错误状态
		deleteErrorState(obj);
		// 判断是否允许空
		if (dataTypeAll.indexOf("空")==-1) {
			var errorMsg = "必填项不能为空";
			// 添加错误状态
			addErrorMsg(obj, errorMsg);
			return false;
		} else {
			return true;
		}
	}
	
	// 判断验证类型是否是 必填
	if (dataTypeAll.indexOf("必填")>=0) {
		return true;
	}
	
	// 遍历这些验证类型并验证
	var dataTypeArr = dataTypeAll.split("|");
	for (var i in dataTypeArr) {
		// 获得正则表达式
		var reg = eval(regJson[dataTypeArr[i]]);
		if (reg!=undefined) {
			// 解除错误状态
			deleteErrorState(obj);
			// 验证失败时
			if (!reg.test(obj.val())) {
				// 获取当前节点的错误信息
				var errorMsg = obj.attr("error-msg");
				if (errorMsg==null) {
					errorMsg = "验证失败";
				}
				// 添加错误状态
				addErrorMsg(obj, errorMsg);
			} else {
				return true;
			}
		}
	}
	
	return false;
}

/**
 * 解除错误状态
 * obj : jquery对象
 */
function deleteErrorState(obj) {
	if (obj.next()!=null) {
		if (obj.next().hasClass("win")) {
			obj.parent().removeClass("error-parent");
			obj.next().remove();
		}
	}
}

/**
 * 添加错误状态
 * obj : jquery对象
 */
function addErrorMsg(obj, errorMsg) {
	if (typeof obj=="string") {
		obj = $("#" + obj);
	}
	// 添加错误状态样式
	obj.parent().addClass("error-parent");

	var errorPos = obj.attr("error-pos");
	if (errorPos==null) {
		errorPos = 42;
	} else {
		errorPos = parseInt(errorPos);
	}
	
	// 创建兄弟元素，并添加class和内容
	var html = '<div class="win win-hint" style="opacity: 1; display: block; top: -'+errorPos+'px;z-index:9999;">';
	html += '<div class="error-text">' + errorMsg + '</div>';
	html += '<div class="tail top"></div>';
	html += '</div>';
	obj.after(html);
}

/**
 * 实时监听
 */
$(document).ready(function() {
	// 监听元素获得焦点事件
	$('input[type="text"], input[type="password"], textarea').focus(function() {
		var dataTypeAll = $(this).attr("data-type");
		// 判断该输入框是否需要进行验证
		if (dataTypeAll!=null && dataTypeAll!=undefined) {
			// 解除错误状态
			deleteErrorState($(this));
		}

		if ($(this).hasClass("original")) {
			// 使用原生样式，不添加边框颜色
		} else {
			// 添加蓝色边框
			$(this).css("border", "1px solid #3b9eff");
		}
	});
	
	// 监听元素失去焦点事件
	$('input[type="text"], input[type="password"], textarea').blur(function() {
		// 清除颜色边框
		$(this).css("border", "");
		// 判断该输入框是否需要进行验证
		var dataTypeAll = $(this).attr("data-type");
		if (dataTypeAll!=null && dataTypeAll!=undefined) {
			// 如果未输入内容，则不验证
			if ($(this).val().length==0) {
				// 解除错误状态
				deleteErrorState($(this));
			} else {
				// 验证
				formVerify($(this), dataTypeAll);
			}
		}
	});
});