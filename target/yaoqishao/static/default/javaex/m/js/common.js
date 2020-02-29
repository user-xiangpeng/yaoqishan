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
				// 为子级li设置宽度
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
	
	// 判断顶部是否固定
	$('[id="header"]').each(function() {
		var $this = $(this);
		$(".list-content").each(function() {
			if ($(this).hasClass("auto-header")) {
				$(this).css("margin-top", $this.height()+"px");
			}
		});
		$('[class^="list-content-"]').each(function() {
			if ($(this).hasClass("auto-header")) {
				$(this).css("margin-top", $this.height()+"px");
			}
		});
	});
	
	// 判断底部是否固定
	$('[id="footer"]').each(function() {
		var $this = $(this);
		$(".list-content").each(function() {
			if ($(this).hasClass("auto-footer")) {
				$(this).css("margin-bottom", $this.height()+8+"px");
			}
		});
		$('[class^="list-content-"]').each(function() {
			if ($(this).hasClass("auto-footer")) {
				$(this).css("margin-bottom", $this.height()+8+"px");
			}
		});
	});
	
	// 遍历含有指定类的单选框和复选框
	$(":radio, :checkbox").each(function() {
		// 填充样式
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
						$(this).parent().append('<span style="margin-left:0.2rem;">' + text + '</span>');
					}
				}
				// 判断是否已存在span标签
				if ($(this).siblings().length==1) {
					$(this).parent().append('<span class="fill-css icon-check" style="color: #fff;"></span>');
				}
			}
		} else if ($(this).hasClass("svg")) {
			// svg动画样式
			var oSvg = document.getElementById("boxGradient");
			if (oSvg==null) {
				var svgHtml = '<svg viewBox="0 0 0 0" style="position: absolute; z-index: -1; opacity: 0;">';
				svgHtml += '<defs>';
				svgHtml += '<linearGradient id="boxGradient" gradientUnits="userSpaceOnUse" x1="0" y1="0" x2="25" y2="25">';
				svgHtml += '<stop offset="0%" stop-color="#27FDC7">';
				svgHtml += '<stop offset="100%" stop-color="#0FC0F5">';
				svgHtml += '</linearGradient>';
				svgHtml += '<linearGradient id="lineGradient">';
				svgHtml += '<stop offset="0%" stop-color="#0FC0F5">';
				svgHtml += '<stop offset="100%" stop-color="#27FDC7">';
				svgHtml += '</linearGradient>';
				svgHtml += '<path id="todo_line" stroke="url(#lineGradient)" d="M21 12.3h168v0.1z"></path>';
				svgHtml += '<path id="todo_box" stroke="url(#boxGradient)" d="M21 12.7v5c0 1.3-1 2.3-2.3 2.3H8.3C7 20 6 19 6 17.7V7.3C6 6 7 5 8.3 5h10.4C20 5 21 6 21 7.3v5.4"></path>';
				svgHtml += '<path id="todo_check" stroke="url(#boxGradient)" d="M10 13l2 2 5-5"></path>';
				svgHtml += '<circle id="todo_circle" cx="13.5" cy="12.5" r="10"></circle>';
				svgHtml += '</defs>';
				svgHtml += '</svg>';
				$(document.body).append(svgHtml);
			}
			var text = "";
			if ($(this).parent()[0].tagName=="LABEL") {
				$(this).parent().addClass("todo");
				text = $(this)[0].nextSibling.nodeValue;
				$(this)[0].nextSibling.nodeValue = "";
			} else {
				text = $(this)[0].nextSibling.nodeValue;
				$(this)[0].nextSibling.nodeValue = "";
				$(this).wrap('<label class="todo"></label>');
			}
			var html = '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 200 25" class="todo_icon">';
			html += '<use xlink:href="#todo_line" class="todo_line"></use>';
			if (this.type=="radio") {
				html += '<use xlink:href="#todo_box" class="todo_box_radio"></use>';
				html += '<use xlink:href="#todo_check" class="todo_check"></use>';
				html += '<use xlink:href="#todo_circle" class="todo_circle_radio"></use>';
			} else {
				html += '<use xlink:href="#todo_box" class="todo_box"></use>';
				html += '<use xlink:href="#todo_check" class="todo_check"></use>';
				html += '<use xlink:href="#todo_circle" class="todo_circle"></use>';
			}
			html += '</svg>';
			$(this).after(html);
			if (text!="" && text!=null) {
				// 判断是否已存在div
				if ($(this).next().next().length==0) {
					$(this).parent().append('<div class="todo_text">'+text.replace(/(\s*$)/g, "")+'</div>');
				}
			}
		}
	});
	
	// 弹出底部菜单
	$(".menu").click(function() {
		// 如果当前菜单为激活状态
		if ($(this).hasClass("activate")) {
			// 则隐藏其子菜单
			$(this).children(".sub-menu").hide();
			$(".menu").removeClass("activate");
		} else {
			// 否则的话，先关闭其他兄弟菜单的子菜单
			$(".menu").removeClass("activate");
			$(".menu").children(".sub-menu").slideUp("fast");
			// 再激活当前菜单
			$(this).addClass("activate");
			$(this).children(".sub-menu").slideDown("fast");
		}
	});
});
