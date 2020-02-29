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
	"身份证号" : "/(^\\d{15}$)|(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)/"
};

/**
 * javaex表单验证插件入口
 */
function javaexVerify() {
	var result = false;
	// 遍历当前页面所有input元素
	$("input, textarea, select").each(function() {
		var dataTypeAll = $(this).attr("data-type");
		// 判断该输入框是否需要进行验证
		if (dataTypeAll!=null) {
			result = formVerify($(this), dataTypeAll);
		}
	});

	return result;
}

/**
 * 正则表达式验证函数
 * obj : jquery对象
 * dataTypeAll : 需要验证哪些类型（集合）
 */
function formVerify(obj, dataTypeAll) {
	// 判断内容去除左右两边空格后是否为空
	if ($.trim(obj.val()).length==0) {
		var errorMsg = "不能为空";
		// 获取标签内容
		var label = obj.parent().parent().children().children().text();
		if (label!=undefined) {
			errorMsg = label + errorMsg;
		}
		// 添加错误状态
		addErrorMsg(errorMsg);
		return false;
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
			// 验证失败时
			if (!reg.test(obj.val())) {
				// 获取当前节点的错误信息
				var errorMsg = obj.attr("error-msg");
				if (errorMsg==null) {
					errorMsg = "验证失败";
				}
				// 获取标签内容
				var label = obj.parent().parent().children().children().text();
				if (label!=undefined) {
					errorMsg = label + errorMsg;
				}
				// 添加错误状态
				addErrorMsg(errorMsg);
			} else {
				return true;
			}
		}
	}

	return false;
}

/**
 * 添加错误状态
 */
function addErrorMsg(errorMsg) {
	javaex.tip({
		content : errorMsg
	});
}