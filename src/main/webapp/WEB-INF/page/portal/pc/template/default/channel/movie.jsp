<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>${channelInfo.title}</title>
<meta name="keywords" content="${channelInfo.keywords}" />
<meta name="description" content="${channelInfo.description}" />
<c:import url="../common/common.jsp"></c:import>
<script src="${pageContext.request.contextPath}/static/default/js/jquery.SuperSlide.2.1.1.js"></script>
</head>
<style>
	.fenlei{width: 1300px; padding: 5px 20px 0; background: #fff;}
	.fenlei ul.n_num{display: block; height: 42px; border-bottom: 1px solid #e5e5e5;}
	.fenlei ul.n_num li{text-align: center; float: left; display: block; color: #6d757a; margin-right: 15px;}
	.fenlei ul.n_num li a{height: 42px; font-size: 14px; color: #6d757a; line-height: 42px; display: block; text-decoration: none; transition: none;}
	.fenlei ul.n_num li a:hover {color:#2fb3ff;border-bottom:1px solid #2fb3ff;line-height: 42px;height: 42px;}
	
	.imageFocus .hd{width:519px;overflow:hidden;position: absolute;bottom:40px;right:30px;}
	.imageFocus .hd ul{margin-right:-5px;  overflow:hidden; zoom:1;}
	.imageFocus .hd ul li{margin-right:10px;width:64px; height:48px;float:left;  text-align:center;position: relative;overflow: hidden;}
	.imageFocus .hd ul li img{width:60px; height:44px; border:2px solid #fff; cursor:pointer;}
	.imageFocus .hd ul li .mask {position: absolute;width: 100%;height: 100%;top: 0;left: 0; background-color: rgba(255,255,255,0);transition: .2s;z-index: 100;display: block no-shadow;}
	.imageFocus .hd ul li.on img{border-color:#f25d8e;}
	.imageFocus .hd ul li.on .mask {background-color: rgba(255,255,255,0.3);}
	.imageFocus .bd li{vertical-align:middle; width: 1300px;float: left;}
	.imageFocus .bd img{width:1300px; height:360px; display:block no-shadow;}
	.focus-bdaa {height: 60px;line-height: 60px;font-size:30px;font-weight: bold;color:#fff;padding-left:20px;position: absolute;bottom:40px;text-shadow: 0 0 1px #000;}
	.focus-bda {height: 60px;line-height: 60px;font-size:18px;color:#fff;padding-left:20px;position: absolute;bottom: 0;text-shadow: 0 0 1px #000;font-family: helvetica,"微软雅黑","microsoft yahei",verdana,lucida,arial,sans-serif,"黑体";}
	
	.jb{line-height: 24px; background: #3EC743; position: absolute; top: 0; padding: 0 10px; color: #fff; z-index: 9;}
	
	.tab-content div{overflow: visible;}
	.tab-content div.javaext{height: 62px;line-height: 24px;overflow: hidden;position: absolute;left: 0;bottom: 0;color: #fff;background: url(http://doc.javaex.cn/demo/images/png24.png) repeat-x;}
	.javaextp1{font-size: 22px;color: #fff;display: block no-shadow;overflow: hidden;height: 24px;line-height: 24px;padding-left: 15px;}
	.javaextp2{height: 20px;line-height: 20px;font-size: 16px;font-weight: 100;position: absolute;bottom: 12px;left: 15px;z-index: 2;overflow: hidden;width: 380px;color: #ddd;}
	.tit-box{height:140px;margin-top: 20px;}
	.tit-box h3{font-size: 20px;line-height: 42px;font-weight: 100;}
	.tit-box p{color: #777;height: 72px;line-height: 24px;padding-right: 20px;overflow: hidden;}
	.tc{margin-top:10px;height: 55px;}
	.tc .tit{padding: 0 10px;width: 182px;font-size: 16px;height: 24px;line-height: 24px;overflow: hidden;}
	.tc .des{padding: 0 10px;width: 182px;font-size: 14px;height: 22px;line-height: 22px;overflow: hidden;color: #999;}
</style>
<body>
	<!-- 头部 -->
	<div class="yaoqishan-header">
		<c:import url="../common/header.jsp"></c:import>
	</div>

	<!--内容-->
	<div style="width: 1340px; margin: 20px auto;">
		<!--幻灯片-->
		<div class="block no-shadow">
			<div class="fenlei">
				<ul class="n_num">
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=4" target="_blank" style="color:#2fb3ff;border-bottom:1px solid #2fb3ff;">全部</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=4&name=类型&value=武侠" target="_blank">武侠</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=4&name=类型&value=警匪" target="_blank">警匪</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=4&name=类型&value=犯罪" target="_blank">犯罪</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=4&name=类型&value=科幻" target="_blank">科幻</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=4&name=类型&value=悬疑" target="_blank">悬疑</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=4&name=类型&value=历史" target="_blank">历史</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=4&name=类型&value=战争" target="_blank">战争</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=4&name=类型&value=恐怖" target="_blank">恐怖</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=4&name=类型&value=冒险" target="_blank">冒险</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=4&name=类型&value=动作" target="_blank">动作</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=4&name=类型&value=奇幻" target="_blank">奇幻</a></li>
				</ul>
			</div>
			<div class="main">
				<div class="imageFocus">
					<div class="bd">
						<ul id="huandeng">
							
						</ul>
					</div>
					<div class="hd">
						<ul id="thumbnail">
							
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--预告片-->
		<div class="block no-shadow">
			<div class="main" style="margin-bottom: -40px;">
				<div class="tab">
					<div class="tab-title">
						<em>预告片</em>
					</div>
					<div class="tab-content">
						<div class="grid-1-2 spacing-20" style="height:352px;">
							<div>
								<ul class="big-cover">
									<li id="yugao_left" style="position: relative;">
										
									</li>
								</ul>
							</div>
							<div>
								<ul id="yugao_right" class="equal-4 cover" style="width: 880px;">
									
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!--最新上线-->
		<div class="block no-shadow" style="height:447px;">
			<div class="main" style="margin-bottom: -40px;">
				<div class="tab">
					<div class="tab-title">
						<em>最新上线</em>
					</div>
					<div class="tab-content">
						<ul id="zuixin" class="equal-6 poster">
					
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--广告-->
		<div class="block no-shadow">
			<div class="main">
				<c:import url="../ad/ad1.jsp"></c:import>
			</div>
		</div>
		
		<!--特工-->
		<div class="block no-shadow" style="height:447px;">
			<div class="main" style="margin-bottom: -40px;">
				<div class="tab">
					<div class="tab-title">
						<em>特工</em>
					</div>
					<div class="tab-content">
						<ul id="tegong" class="equal-6 poster">
					
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--都市-->
		<div class="block no-shadow" style="height:447px;">
			<div class="main" style="margin-bottom: -40px;">
				<div class="tab">
					<div class="tab-title">
						<em>都市</em>
					</div>
					<div class="tab-content">
						<ul id="dushi" class="equal-6 poster">
					
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--动作-->
		<div class="block no-shadow" style="height:447px;">
			<div class="main" style="margin-bottom: -40px;">
				<div class="tab">
					<div class="tab-title">
						<em>动作</em>
					</div>
					<div class="tab-content">
						<ul id="dongzuo" class="equal-6 poster">
					
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--独家策划-->
		<div class="block no-shadow">
			<!--正文内容-->
			<div class="main" style="margin-bottom: -40px;">
				<!--选项卡切换-->
				<div id="tab2" class="tab">
					<!--选项卡标题部分-->
					<div class="tab-title">
						<em>独家策划</em>
						<ul>
							<li>玫瑰之约</li>
							<li>拯救不开心</li>
							<li>男神女神</li>
							<li>无忧童心</li>
							<li>烧脑穿越</li>
							<li>奇幻大片</li>
						</ul>
					</div>
					<!--选项卡内容部分-->
					<div class="tab-content">
						<div>
							<!-- 玫瑰之约 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_1_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>电影圆你童话梦</h3>
										<p>《美女与野兽》最初是经典爱情童话，讲述的是美女贝儿代替触怒野兽的父亲被囚古堡，却在朝夕相处中发现野兽内心善良高尚，最后真爱战胜魔咒，有情人终成眷属。对跨越世俗偏见的心灵之美的礼赞，使《美女与野兽》童话在问世数百年来长盛不衰。</p>
									</div>
									
									<ul id="tab2_1_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 拯救不开心 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_2_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>不许不开心</h3>
										<p>傻子才悲伤，就是要你笑！《快手枪手快枪手》讲述“快手”小庄、“枪手”若云与石佛（腾格尔饰）、金三娘（刘晓庆饰）在共同经历了一系列啼笑皆非的事件后，组成了夺宝者联盟集体干“大事儿”的故事。影片语言逗比十足、画面精心打磨、剧情悬念丛生，化身“污辣”CP的林更新、张静初给足观众惊喜，两人一路互不相让，“针尖对麦芒”唇枪舌战不停歇，不时甩下的金句让人啼笑皆非，必将成为今夏不可错过的动作喜剧大片。</p>
									</div>
									
									<ul id="tab2_2_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 男神女神 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_3_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>男神女神撩起来</h3>
										<p>颜值为王，鲜肉当道！电影中怎能缺少人气偶像？多款舔屏收割机，总有一个是你的菜。吴亦凡刘亦菲甜蜜搭档比“亦”双飞，即将上演2016第一青春爱情大片。电影《致青春·原来你还在这里》改编自著名作家辛夷坞的同名畅销小说，由周拓如执导，张一白监制，吴亦凡、刘亦菲、金世佳、李沁、李梦、郝劭文、乔任梁、陈燃等主演，讲述了对爱情真诚执着的男主人公程铮（吴亦凡饰），爱上了倔强、自尊心强的苏韵锦（刘亦菲饰），演绎了一段纯粹又虐心的爱情故事。</p>
									</div>
									
									<ul id="tab2_3_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 无忧童心 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_4_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>童年集结号</h3>
										<p>每个人的内心都住着个小孩子，我们无法时时刻刻都无忧无虑的开怀大笑，好在还有电影。 《冰川时代5》将于暑期档7月22日在北美上映，中国内地有望引进。熟悉的冰川萌物们集体回归，带来更为浩大的冒险，这次松鼠奎特追逐松果飞上宇宙，酿成让地球近乎毁灭的大祸，而在地球上还在泡妞的树懒希德、以及其他玩闹、争斗的冰川动物们，对这个灭顶之灾毫无准备，因而在这场逃亡之路上笑料百出。</p>
									</div>
									
									<ul id="tab2_4_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 烧脑穿越 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_5_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>穿越之后</h3>
										<p>全世界都在玩儿穿越！这里不仅展现历史和未来，更有队哲学终极问题的思考，搞穿越，我们是很严肃滴！15年上映的科幻电影《前目的地》堪称史上最坑爹时间旅行者故事。全篇都在讲一个字：宿命。有点开启上帝视角，个体挣扎多么渺小，只能在写好的命定里徒劳浮沉。正如某话所说：所有我们曾走过的路，都是必经之路。看完悲凉得想哭。关键一切看似都是他自己的选择，可实际上，他有选择么？</p>
									</div>
									
									<ul id="tab2_5_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 奇幻大片 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_6_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>奇幻大剧</h3>
										<p>电影是造梦的机器，既然是梦，何不做大一点！在这里，想象力的高度已突破天际！《大闹天宫》有好莱坞的特效水准，也有国际超级英雄大片的气质，主演阵容更是汇聚了华语影坛的最强阵容，无论是化身为猴的甄子丹，还是化身为牛的郭富城，以及周润发、何润东、海一天等一票型男，也包括陈慧琳、梁咏琪、张梓琳、夏梓桐、陈乔恩等一票散落于人、神、魔三界的绝色美女，共同组成了庞大的“西游”生态阵容，算是前所未有。</p>
									</div>
									
									<ul id="tab2_6_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!--底部-->
	<div class="footer-wrap js-use-footer" >
		<c:import url="../common/footer.jsp"></c:import>
	</div>
</body>
<script>
	// 独家策划
	javaex.tab({
		id : "tab2",
		mode : "click"
	});

	$(function() {
		// 幻灯片
		huandeng();
		
		// 预告片
		loadData("yugao_left", "yugao_right", "api/data.json?apiId=62");
		
		// 最新上线
		getDataByTag("zuixin", "api/data.json?apiId=61");
		
		// 特工
		getDataByTag("tegong", "api/data.json?apiId=60");
		
		// 都市
		getDataByTag("dushi", "api/data.json?apiId=59");
		
		// 动作
		getDataByTag("dongzuo", "api/data.json?apiId=58");
		
		// 独家策划
		// 玫瑰之约
		getDataByTag2("tab2_1_1", "tab2_1_2", "api/data.json?apiId=57");
		// 拯救不开心
		getDataByTag2("tab2_2_1", "tab2_2_2", "api/data.json?apiId=56");
		// 男神女神
		getDataByTag2("tab2_3_1", "tab2_3_2", "api/data.json?apiId=55");
		// 无忧童心
		getDataByTag2("tab2_4_1", "tab2_4_2", "api/data.json?apiId=54");
		// 烧脑穿越
		getDataByTag2("tab2_5_1", "tab2_5_2", "api/data.json?apiId=53");
		// 奇幻大片
		getDataByTag2("tab2_6_1", "tab2_6_2", "api/data.json?apiId=51");
		
		setTimeout(function() {
			$(".pop-in").removeClass("pop-in");
		}, 5000);
	});

	// 幻灯片
	function huandeng() {
		$.ajax({
			url : path + "api/slide.json?apiId=63",
			type : "POST",
			dataType : "json",
			success : function(rtn) {
				if (rtn.code=="999999") {
					huandeng();
					return;
				}
				var list = rtn.data.list;
				var html = '';
				var html2 = '';
				for (var i=0; i<list.length; i++) {
					html += '<li>';
					html += '<a href="'+list[i].url+'" target="_blank">';
					html += '<img src="'+list[i].image+'" width="100%" height="100%">';
					html += '</a>';
					html += '<p class="focus-bdaa">'+list[i].title+'</p>';
					html += '<p class="focus-bda">'+list[i].summary+'</p>';
					html += '</li>';
					
					html2 += '<li><img src="'+list[i].thumbnail+'" width="100%" height="100%" /><a href="javascript:;" class="mask"></a></li>';
				}
				$("#huandeng").append(html);
				$("#thumbnail").append(html2);
				
				$(".imageFocus").slide({
					mainCell : ".bd ul",
					effect : "left",
					autoPlay : true
				});
			}
		});
	}
	
	// 加载数据
	function loadData(id1, id2, api) {
		$.ajax({
			url : path + api,
			type : "POST",
			dataType : "json",
			success : function(rtn) {
				if (rtn.code=="999999") {
					loadData();
					return;
				}
				var list = rtn.data.list;
				if (list.length>0) {
					var rightHtml = '';
					for (var i=0; i<list.length; i++) {
						if (i==0) {
							// 左边
							var leftHtml = '<span class="jb">预告</span>';
							leftHtml += '<a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank" class="screenshot">';
							leftHtml += '<img src="'+list[i].dafengmian+'" class="pop-in" width="100%" height="100%" />';
							leftHtml += '</a>';
							leftHtml += '<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank">'+list[i].biaoti+'</a></p>';
							leftHtml += '<p>'+list[i].kandian+'</p>';
						} else {
							// 右边
							rightHtml += '<li style="position: relative;">';
							rightHtml += '<span class="jb">预告</span>';
							rightHtml += '<a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank" class="screenshot">';
							rightHtml += '<img src="'+list[i].fengmian+'" class="pop-in" width="100%" height="100%" />';
							rightHtml += '</a>';
							rightHtml += '<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank">'+list[i].biaoti+'</a></p>';
							rightHtml += '<p>'+list[i].kandian+'</p>';
							rightHtml += '</li>';
						}
					}
					rightHtml += '<span class="clearfix"></span>';
					$("#"+id1).append(leftHtml);
					$("#"+id2).append(rightHtml);
					
					javaex.popin();
					javaex.render();
				}
			}
		});
	}
	
	// 根据标签检索
	function getDataByTag(id, api) {
		$.ajax({
			url : path + api,
			type : "POST",
			dataType : "json",
			success : function(rtn) {
				if (rtn.code=="999999") {
					getDataByTag(id, api);
					return;
				}
				var list = rtn.data.list;
				if (list.length>0) {
					var html = '';
					for (var i=0; i<list.length; i++) {
						html += '<li>';
						html += '<a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank" class="screenshot">';
						html += '<img src="'+list[i].haibao+'" class="pop-in" width="100%" height="100%" />';
						html += '</a>';
						html += '<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank">'+list[i].biaoti+'</a></p>';
						html += '<p>'+list[i].kandian+'</p>';
						html += '</li>';
					}
					html += '<span class="clearfix"></span>';
					$("#"+id).append(html);
					
					javaex.popin();
					javaex.render();
				}
			}
		});
	}
	
	// 根据标签检索（独家策划）
	function getDataByTag2(id1, id2, api) {
		$.ajax({
			url : path + api,
			type : "POST",
			dataType : "json",
			success : function(rtn) {
				if (rtn.code=="999999") {
					getDataByTag2(id1, id2, api);
					return;
				}
				var list = rtn.data.list;
				if (list.length>0) {
					for (var i=0; i<list.length; i++) {
						if (i==0) {
							// 左边
							var leftHtml = '';
							leftHtml += '<a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank">';
							leftHtml += '<img src="'+list[i].dafengmian+'" class="pop-in" width="100%" height="100%" />';
							leftHtml += '</a>';
							leftHtml += '<div class="javaext">';
							leftHtml += '<p class="javaextp1">'+list[i].biaoti+'</p>';
							leftHtml += '<div class="javaextp2">'+list[i].kandian+'</div>';
						} else {
							var rightHtml = '';
							// 右边
							for (var i=1; i<list.length; i++) {
								rightHtml += '<li>';
								rightHtml += '<a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank" class="screenshot">';
								rightHtml += '<img src="'+list[i].fengmian+'" class="pop-in" width="100%" height="100%" />';
								rightHtml += '</a>';
								rightHtml += '<div class="tc">';
								rightHtml += '<p class="tit"><a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank">'+list[i].biaoti+'</a></p>';
								rightHtml += '<p class="des">'+list[i].kandian+'</p>';
								rightHtml += '</div>';
								rightHtml += '</li>';
							}
						}
					}
				}
				
				$("#"+id1).append(leftHtml);
				$("#"+id2).append(rightHtml);
				
				javaex.popin();
				javaex.render();
			}
		});
	}
</script>
</html>