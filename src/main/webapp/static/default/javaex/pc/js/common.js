/**
 * 作者：陈霓清
 * 官网：http://www.javaex.cn
 */
$(function() {
	// 改变元素的大小（放大、缩小）
	$(":button, input, p, select, textarea, label").each(function() {
		var zoom = $(this).attr("zoom");
		if (zoom!=null) {
			$(this).css("zoom", zoom);
		}
	});

	// 改变元素的圆角
	$(":button, input, textarea").each(function() {
		if (!$(this).attr("class")) {
			return;
		}
		// 判断含有多少个属性
		var classArr = $(this).attr("class").split(" ");
		for (var i in classArr) {
			if (classArr[i].indexOf("radius-")>=0) {
				// 获取圆角数值
				var num = classArr[i].split("-")[1];
				// 改变css样式
				$(this).css("border-radius", num + "px");
			}
		}
	});
	
	// 圆角
	$('[class^="radius-"]').each(function() {
		// 判断含有多少个属性
		var classArr = $(this).attr("class").split(" ");

		for (var i in classArr) {
			if (classArr[i].indexOf("radius-")>=0) {
				// 获取圆角数值
				var num = classArr[i].split("-")[1];
				// 改变css样式
				$(this).css("border-radius", num + "px");
			}
		}
	});

	// 栅格系统
	$('[class^="grid-"]').each(function() {
		// 判断含有多少个属性
		var classArr = $(this).attr("class").split(" ");

		for (var i in classArr) {
			if (classArr[i].indexOf("grid-")>=0) {
				// 获取栅格布局
				var arr = classArr[i].split("-");
				// 计算一共需要分成多少份
				var sum = 0;
				for (var j in arr) {
					if (j>0) {
						sum = parseInt(sum) + parseInt(arr[j]);
					}
				}
				// 为子级div设置宽度
				$(this).children("div").each(function(k) {
					$(this).css("width", (100/sum) * arr[k+1] + "%");
				});
			} else if (classArr[i].indexOf("spacing-")>=0) {
				// 获取栅格间距
				var spacing = classArr[i].split("-")[1];
				
				// 为该栅格div添加下外边距
				$(this).css("margin-bottom", parseInt(spacing) + "px");
				var length = $(this).children("div").length;
				
				// 为子级div设置间距
				var width = "calc(100% + "+parseInt(spacing)+"px)";
				$(this).css("width", width);
				$(this).children("div").each(function(k) {
					$(this).css("margin-right", parseInt(spacing) + "px");
				});
			}
		}
	});

	// 等分系统
	$('[class^="equal-"]').each(function() {
		// 判断含有多少个属性
		var classArr = $(this).attr("class").split(" ");

		for (var i in classArr) {
			if (classArr[i].indexOf("equal-")>=0) {
				// 获取等分布局的等分数
				var num = classArr[i].split("-")[1];
				// 为子级div设置宽度
				$(this).children("li").css("width", (100/num) + "%");
			}
		}
	});

	// 全体内容外边距设定
	$('[class^="list-content-"]').each(function() {
		// 判断含有多少个属性
		var classArr = $(this).attr("class").split(" ");

		for (var i in classArr) {
			if (classArr[i].indexOf("list-content-")>=0) {
				// 获取外边距数值
				var num = classArr[i].split("-")[2];
				// 为div设置外边距
				$(this).css({
					"margin-top" : num + "px",
					"margin-right" : num + "px",
					"margin-bottom" : 0,
					"margin-left" : num + "px"
				});
			}
		}
	});
	
	// 主要内容内边距设定
	$('[class^="main-"]').each(function() {
		// 判断含有多少个属性
		var classArr = $(this).attr("class").split(" ");

		for (var i in classArr) {
			if (classArr[i].indexOf("main-")>=0) {
				// 获取内边距数值
				var num = classArr[i].split("-")[1];
				// 为div设置内边距
				$(this).css("padding", num + "px");
			}
		}
	});

	// 遍历含有指定类的单选框和复选框
	$(":radio, :checkbox").each(function() {
		if ($(this).hasClass("fill")) {
			// 判断用户是否自己包裹了一层LABEL
			if ($(this).parent()[0].tagName=="LABEL") {
				$(this).parent().addClass("fill-label");
				// 判断是否已存在span标签
				if ($(this).siblings().length==0) {
					$(this).parent().append('<span class="fill-css icon-check" style="color: #fff;"></span>');
				}
			} else {
				// 先获取input之后的文本，保存起来
				var text = $(this)[0].nextSibling.nodeValue;
				// 清空input之后的文本
				$(this)[0].nextSibling.nodeValue = "";
				// 为input创建父节点
				$(this).wrap('<label class="fill-label"></label>');
				if (text!="" && text!=null) {
					// 重新追加之前保存的input之后的文本
					text = text.replace(/(\s*$)/g, "");
					if (text.length==0) {
						$(this).parent().append('<span>' + text + '</span>');
					} else {
						$(this).parent().append('<span style="margin-left: 6px;">' + text + '</span>');
					}
				}
				// 判断是否已存在span标签
				if ($(this).siblings().length==1) {
					$(this).parent().append('<span class="fill-css icon-check" style="color: #fff;"></span>');
				}
			}
		}
	});
	
	// 监听复选框的点击事件
	$(":checkbox").click(function() {
		// 如果是原生的复选框，则直接返回
		if (!$(this).attr("class")) {
			return;
		}
		
		// 判断含有多少个属性
		var classArr = $(this).attr("class").split(" ");

		for (var i in classArr) {
			var listen = classArr[i];
			// 如果该复选框需要监听
			if (listen.indexOf("listen-")>=0) {
				// 提取key
				var listenKey = listen.replace(listen.split("-")[0]+"-", "");
				var keyArr = listenKey.split("-");
				
				// 判断当前点击的复选框的选中状态
				if ($(this).is(":checked")) {
					// 当前级别的复选框的选中个数
					var num = 0;
					// 选中时
					$(":checkbox").each(function() {
						var classArr = $(this).attr("class").split(" ");
						for (var j in classArr) {
							// 让子级复选框全部选中
							if (classArr[j].indexOf(listen)>=0 && classArr[j]!=listen) {
								// 跳过禁用的
								if (!$(this).attr("disabled")) {
									$(this).attr("checked", true);
								}
							}
							if (classArr[j]==listen) {
								if ($(this).is(":checked") || $(this).attr("disabled")) {
									num++;
								}
							}
						}
					});
					
					// 判断当前级别的复选框是否已全部选中
					if (num==($("."+listen).length)) {
						// 自动选中父级
						var parentClass = listen.replace("-"+keyArr[keyArr.length-1], "");
						$(":checkbox").each(function() {
							if ($(this).hasClass(parentClass)) {
								$(this).attr("checked", true);
							}
						});
					}
				} else {
					// 未选中时
					$(":checkbox").each(function() {
						var classArr = $(this).attr("class").split(" ");
						for (var j in classArr) {
							// 让子级复选框全部取消选中
							if (classArr[j].indexOf(listen)>=0 && classArr[j]!=listen) {
								$(this).attr("checked", false);
							}
							// 让父级复选框全部取消选中
							var parentClass = "listen";
							for (var k in keyArr) {
								if (keyArr[k]!=keyArr[keyArr.length-1]) {
									parentClass += "-";
									parentClass += keyArr[k];
									if (classArr[j]==parentClass) {
										$(this).attr("checked", false);
									}
								}
							}
						}
					});
				}
			}
		}
	});
});
