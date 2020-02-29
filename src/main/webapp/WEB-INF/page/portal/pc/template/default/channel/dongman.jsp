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
	
	.kenan{width: 160px;height: 50px;background: url(${pageContext.request.contextPath}/static/default/images/kn.png) no-repeat 0 0;position: absolute;right: -20px;bottom: 0;}

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
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1" target="_blank" style="color:#2fb3ff;border-bottom:1px solid #2fb3ff;">全部</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=搞笑" target="_blank">搞笑</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=热血" target="_blank">热血</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=奇幻" target="_blank">奇幻</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=竞技" target="_blank">竞技</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=战争" target="_blank">战争</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=后宫" target="_blank">后宫</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=机战" target="_blank">机战</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=悬疑" target="_blank">悬疑</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=恋爱" target="_blank">恋爱</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=科幻" target="_blank">科幻</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=推理" target="_blank">推理</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=校园" target="_blank">校园</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=战斗" target="_blank">战斗</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=魔法" target="_blank">魔法</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=1&name=风格&value=冒险" target="_blank">冒险</a></li>
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
		
		<!--连载新番-->
		<div class="block no-shadow" style="height: 435px;">
			<!--正文内容-->
			<div class="main">
				<!--选项卡切换-->
				<div id="tab1" class="tab">
					<!--选项卡标题部分-->
					<div class="tab-title">
						<em>连载新番</em>
						<ul>
							<li>最新更新</li>
							<li>周一更新</li>
							<li>周二更新</li>
							<li>周三更新</li>
							<li>周四更新</li>
							<li>周五更新</li>
							<li>周六更新</li>
							<li>周日更新</li>
						</ul>
					</div>
					<!--选项卡内容部分-->
					<div class="tab-content">
						<div><ul id="tab1_0" class="equal-6 cover"></ul></div>
						<div><ul id="tab1_1" class="equal-6 cover"></ul></div>
						<div><ul id="tab1_2" class="equal-6 cover"></ul></div>
						<div><ul id="tab1_3" class="equal-6 cover"></ul></div>
						<div><ul id="tab1_4" class="equal-6 cover"></ul></div>
						<div><ul id="tab1_5" class="equal-6 cover"></ul></div>
						<div><ul id="tab1_6" class="equal-6 cover"></ul></div>
						<div><ul id="tab1_7" class="equal-6 cover"></ul></div>
					</div>
				</div>
			</div>
		</div>
		
		<!--近期完结-->
		<div class="block no-shadow">
			<div class="main" style="margin-bottom: -40px;">
				<div class="tab">
					<div class="tab-title">
						<em>近期完结</em>
					</div>
					<div class="tab-content">
						<div class="grid-1-2 spacing-20" style="height:352px;">
							<div>
								<ul class="big-cover">
									<li id="over_data_left">
										
									</li>
								</ul>
							</div>
							<div>
								<ul id="over_data_right" class="equal-4 cover" style="width: 880px;">
									
								</ul>
							</div>
						</div>
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
		
		<!--旧番补档-->
		<div class="block no-shadow" style="height:259px;">
			<div class="main" style="margin-bottom: -40px;">
				<div class="tab">
					<div class="tab-title">
						<em>旧番补档</em>
					</div>
					<div class="tab-content">
						<ul id="jiufan" class="equal-6 cover">
					
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--优质国产-->
		<div class="block no-shadow" style="height:259px;">
			<div class="main" style="margin-bottom: -40px;">
				<div class="tab">
					<div class="tab-title">
						<em>优质国产</em>
					</div>
					<div class="tab-content">
						<ul id="youzhiguochan" class="equal-6 cover">
					
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--悬疑推理-->
		<div class="block no-shadow" style="height:259px;">
			<div class="main" style="margin-bottom: -40px;">
				<div class="tab">
					<div class="tab-title">
						<em>悬疑推理</em>
						<ul>
							<a href="${pageContext.request.contextPath}/portal/profile.action?mediaId=17" target="_blank"><em class="kenan"></em></a>
						</ul>
					</div>
					<div class="tab-content">
						<ul id="tuili" class="equal-6 cover">
					
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
							<li>热血燃魂</li>
							<li>笑不能停</li>
							<li>轮回重生</li>
							<li>后宫之路</li>
							<li>超能力者</li>
							<li>兄妹控癖</li>
							<li>竞技体育</li>
						</ul>
					</div>
					<!--选项卡内容部分-->
					<div class="tab-content">
						<div>
							<!-- 热血燃魂 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_1_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>正邪、是非、生死、善恶</h3>
										<p>世界中存在的魔导士公会“妖精的尾巴”，是一个为魔导士们从寻物到讨伐魔物等各样工作起到中介性质的组织，公会成员由众多厉害魔法师组顾。 目标成为魔导士第一人，并梦想加入“妖精的尾巴”的少女露西遇到了操纵火炎的灭龙魔导士纳兹，而纳兹竟然是露西所憧憬的魔导士公会“妖精的尾巴”中的一员！ 以纳兹为首，公会成员尽是一群问题儿童。不过他们虽然在各个地方引发各种大的骚动，但通过各种委托和事件，使伙伴们之间的羁绊逐渐加深，组织变得更团结。 在纳兹的引导下，露西终于得尝所愿，并结识了许多厉害的魔法师……</p>
									</div>
									
									<ul id="tab2_1_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 笑不能停 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_2_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>不许不开心</h3>
										<p>江户时代末期，被称为“天人”的谜之异星人来袭。于是地球人与天人之间的战争瞬即爆发，为数众多的武士和攘夷派志士都参与与天人的战斗。幕府见识到天人强大的实力后，最终向天人低头，放弃武士不管，擅自与天人签订不平等条约，准许他们入国。其后更颁布了“废刀令”，夺走了武士的刀，使他们无力反抗。自此，天人横行霸道，幕府为天人所影响，甚至被控制，成为了“傀儡政权”。在这样的时代，有一个武士与同伴愉快地过着异想天开的生活。</p>
									</div>
									
									<ul id="tab2_2_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 轮回重生 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_3_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>死亡，然后重新开始</h3>
										<p>在异世界陷入迷茫的普通高中生菜月昴，邂逅了一位银发的美少女。但想助她一臂之力的昴，却一次次地遭遇敌袭，背叛、暴力，甚至是死亡……“死亡重置”——无力的少年拥有的唯一能力，能将死后时间倒转回一开始。使用了这般力量，便会失去过去的回忆，可为了守护最重要的人们，昴必须抗争到底。“即使你忘却了我，我也不会遗忘你。”</p>
									</div>
									
									<ul id="tab2_3_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 后宫之路 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_4_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>活在女人堆的男人</h3>
										<p>春假，为了赚得购入动画 BD 而打工的宅男·安艺伦也在樱花飞舞的道路上遇到了某个少女，对该少女感兴趣的伦也以她为模特制作了相关的同人游戏。一个月後，该少女成为了他的同班同学……为了制作游戏，伦也陆续找了美术部王牌来负责插画、学年第一名的学姐来写作剧本，一行人以 Comike为目标，开始进行相关的游戏制作。 电视动画《不起眼女主角培育法》改编自由丸户史明原作、深崎暮人负责插画的同名轻小说。</p>
									</div>
									
									<ul id="tab2_4_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 超能力者 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_5_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>奇幻大作</h3>
										<p>主人公乙坂有宇拥有着只在极少一部分的青春期少年少女身上诱发产生的罕见特殊能力，仅凭这份能力盲目虚度着一帆风顺的学园生活的他，经由与神秘少女友利奈绪的邂逅，揭开了特殊能力者们身上的宿命。</p>
									</div>
									
									<ul id="tab2_5_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 兄妹控癖 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_6_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>肥水不流外人田的兄妹控</h3>
										<p>高中生兼小说作家的“和泉正宗”（笔名：和泉征宗）有个家里蹲的妹妹“和泉纱雾”。一年前才成为家人的她，却完全不走出居室，并也用力踩踏地板，要我帮她准备食物。为了这段称不上“兄妹”的关系，正宗得想个办法让她自己走出居室才行，因为两人已是目前仅存能相依为命的“家人”……至于正宗的搭挡插画家“情色漫画老师”，是个能够画出非常棒煽情图的可靠伙伴。虽然双方并没见过面，但我一直很感谢他！只是在某一天，正宗突然发现到一个冲击事实，那就是“情色漫画老师”其实就是纱雾！？</p>
									</div>
									
									<ul id="tab2_6_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 竞技体育 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_7_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>诸神之战，凡人退却</h3>
										<p>《黑子的篮球》是一部篮球相关的动画，讲述了以篮球出名的帝光中学曾出了五位被称为”奇迹世代”的球员，但事实上“奇迹世代”有第六位成员，他就是本作的男主角黑子哲也。 如梦幻般的第六人不选择篮球名校，而是偏偏选上了一所新建的学校诚凛高中。在这里，黑子遇上了从美国回来的另一位男主角火神大我，两人相遇，并带领着诚凛篮球部去挑战奇迹世代的球员。</p>
									</div>
									
									<ul id="tab2_7_2" class="equal-4 cover" style="width: 880px;">
											
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
	// 连载新番
	javaex.tab({
		id : "tab1",
		mode : "click"
	});
	
	// 独家策划
	javaex.tab({
		id : "tab2",
		mode : "click"
	});

	$(function() {
		// 幻灯片
		huandeng();
		
		// 最新番剧
		loadData("tab1_0", "api/data.json?apiId=7");
		// 周一更新
		loadData("tab1_1", "api/data.json?apiId=8");
		// 周二更新
		loadData("tab1_2", "api/data.json?apiId=9");
		// 周三更新
		loadData("tab1_3", "api/data.json?apiId=10");
		// 周四更新
		loadData("tab1_4", "api/data.json?apiId=11");
		// 周五更新
		loadData("tab1_5", "api/data.json?apiId=12");
		// 周六更新
		loadData("tab1_6", "api/data.json?apiId=13");
		// 周日更新
		loadData("tab1_7", "api/data.json?apiId=14");
		
		// 近期完结
		getOverData();
		
		// 旧番补档
		getDataByTag("jiufan", "api/data.json?apiId=16");
		
		// 优质国产
		getDataByTag("youzhiguochan", "api/data.json?apiId=17");
		
		// 悬疑推理
		getDataByTag("tuili", "api/data.json?apiId=18");
		
		// 独家策划
		// 热血燃魂
		getDataByTag2("tab2_1_1", "tab2_1_2", "api/data.json?apiId=28");
		// 笑不能停
		getDataByTag2("tab2_2_1", "tab2_2_2", "api/data.json?apiId=29");
		// 轮回重生
		getDataByTag2("tab2_3_1", "tab2_3_2", "api/data.json?apiId=30");
		// 后宫之路
		getDataByTag2("tab2_4_1", "tab2_4_2", "api/data.json?apiId=31");
		// 超能力者
		getDataByTag2("tab2_5_1", "tab2_5_2", "api/data.json?apiId=32");
		// 兄妹控癖
		getDataByTag2("tab2_6_1", "tab2_6_2", "api/data.json?apiId=33");
		// 竞技体育
		getDataByTag2("tab2_7_1", "tab2_7_2", "api/data.json?apiId=34");
		
		setTimeout(function() {
			$(".pop-in").removeClass("pop-in");
		}, 5000);
	});

	// 幻灯片
	function huandeng() {
		$.ajax({
			url : path + "api/slide.json?apiId=22",
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
	function loadData(id, api) {
		$.ajax({
			url : path + api,
			type : "POST",
			dataType : "json",
			success : function(rtn) {
				if (rtn.code=="999999") {
					loadData(id, api);
					return;
				}
				var list = rtn.data.list;
				if (list.length>0) {
					var html = '';
					for (var i=0; i<list.length; i++) {
						html += '<li>';
						html += '<a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank" class="screenshot">';
						if (list[i].zongjishu==list[i].videoInfo.num) {
							html += '<span class="duration">全'+list[i].videoInfo.num+'集</span>';
						} else {
							html += '<span class="duration">更新至第'+list[i].videoInfo.num+'集</span>';
						}
						html += '<img src="'+list[i].fengmian+'" class="pop-in" width="100%" height="100%" />';
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
	
	// 近期完结
	function getOverData() {
		$.ajax({
			url : path + "api/data.json?apiId=15",
			type : "POST",
			dataType : "json",
			success : function(rtn) {
				if (rtn.code=="999999") {
					getOverData();
					return;
				}
				var list = rtn.data.list;
				if (list.length>0) {
					var rightHtml = '';
					for (var i=0; i<list.length; i++) {
						if (i==0) {
							// 左边
							var leftHtml = '';
							leftHtml += '<a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank" class="screenshot">';
							leftHtml += '<span class="duration">全'+list[i].zongjishu+'集</span>';
							leftHtml += '<img src="'+list[i].dafengmian+'" class="pop-in" width="100%" height="100%" />';
							leftHtml += '</a>';
							leftHtml += '<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank">'+list[i].biaoti+'</a></p>';
							leftHtml += '<p>'+list[i].kandian+'</p>';
						} else {
							// 右边
							rightHtml += '<li>';
							rightHtml += '<a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank" class="screenshot">';
							rightHtml += '<span class="duration">全'+list[i].zongjishu+'集</span>';
							rightHtml += '<img src="'+list[i].fengmian+'" class="pop-in" width="100%" height="100%" />';
							rightHtml += '</a>';
							rightHtml += '<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank">'+list[i].biaoti+'</a></p>';
							rightHtml += '<p>'+list[i].kandian+'</p>';
							rightHtml += '</li>';
						}
					}
					rightHtml += '<span class="clearfix"></span>';
					$("#over_data_left").append(leftHtml);
					$("#over_data_right").append(rightHtml);
					
					javaex.popin();
					javaex.render();
				}
			}
		});
	}
	
	// 根据标签检索番剧
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
				var html = '';
				for (var i=0; i<list.length; i++) {
					html += '<li>';
					html += '<a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank" class="screenshot">';
					html += '<span class="duration">全'+list[i].zongjishu+'集</span>';
					html += '<img src="'+list[i].fengmian+'" class="pop-in" width="100%" height="100%" />';
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
		});
	}
	
	// 根据标签检索番剧（独家策划）
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