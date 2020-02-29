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
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3" target="_blank" style="color:#2fb3ff;border-bottom:1px solid #2fb3ff;">全部</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=古装" target="_blank">古装</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=武侠" target="_blank">武侠</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=警匪" target="_blank">警匪</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=军事" target="_blank">军事</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=神话" target="_blank">神话</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=科幻" target="_blank">科幻</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=悬疑" target="_blank">悬疑</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=历史" target="_blank">历史</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=都市" target="_blank">都市</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=搞笑" target="_blank">搞笑</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=偶像" target="_blank">偶像</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=言情" target="_blank">言情</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=穿越" target="_blank">穿越</a></li>
					<li><a href="${pageContext.request.contextPath}/portal/list.action?typeId=3&name=类型&value=奇幻" target="_blank">奇幻</a></li>
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
		
		<!--同步跟播-->
		<div class="block no-shadow">
			<div class="main" style="margin-bottom: -40px;">
				<div class="tab">
					<div class="tab-title">
						<em>同步跟播</em>
					</div>
					<div class="tab-content">
						<div class="grid-1-2 spacing-20" style="height:352px;">
							<div>
								<ul class="big-cover">
									<li id="newest_left">
										
									</li>
								</ul>
							</div>
							<div>
								<ul id="newest_right" class="equal-4 cover" style="width: 880px;">
									
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!--网络神剧-->
		<div class="block no-shadow" style="height:259px;">
			<div class="main">
				<div class="tab">
					<div class="tab-title">
						<em>网络神剧</em>
					</div>
					<div class="tab-content">
						<ul id="internet_drama" class="equal-6 cover">
					
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
		
		<!--偶像剧集地-->
		<div class="block no-shadow" style="height:259px;">
			<div class="main" style="margin-bottom: -40px;">
				<div class="tab">
					<div class="tab-title">
						<em>偶像剧集地</em>
					</div>
					<div class="tab-content">
						<ul id="idols" class="equal-6 cover">
					
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--英美强档-->
		<div class="block no-shadow">
			<div class="main" style="margin-bottom: -40px;">
				<div class="tab">
					<div class="tab-title">
						<em>英美强档</em>
					</div>
					<div class="tab-content">
						<div class="grid-1-2 spacing-20" style="height:352px;">
							<div>
								<ul class="big-cover">
									<li id="yingmei_left">
										
									</li>
								</ul>
							</div>
							<div>
								<ul id="yingmei_right" class="equal-4 cover" style="width: 880px;">
									
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!--日韩风尚-->
		<div class="block no-shadow" style="height:259px;">
			<div class="main" style="margin-bottom: -40px;">
				<div class="tab">
					<div class="tab-title">
						<em>日韩风尚</em>
					</div>
					<div class="tab-content">
						<ul id="rihan" class="equal-6 cover">
					
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
							<li>招牌古装</li>
							<li>经典武侠</li>
							<li>穿越时空</li>
							<li>古装魔幻</li>
							<li>悬疑佳作</li>
							<li>英雄儿女</li>
							<li>都市爱情</li>
						</ul>
					</div>
					<!--选项卡内容部分-->
					<div class="tab-content">
						<div>
							<!-- 招牌古装 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_1_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>扶摇皇后</h3>
										<p>五洲大陆以无极皇城统领太渊、天煞、璇玑与宗学圣地穹苍隔扶风海相望。上古穹苍曾孕育神莲一朵于孟扶摇之身，孟扶摇幼时投太渊玄元剑派门下，因资质愚钝饱受师门鄙弃。于十六岁上得“破九霄”神功，从此武功精进。为收集五洲密令，静候扶风海破海之日前往穹苍，孟扶摇踏上了五洲历险之路，与无极皇城太子长孙无极相识相爱，二人合力平息太渊摄政王篡政，无极国南戎犯境，德王宫变，与天煞烈王战北野联手夺回王权，揭示孟扶摇璇玑王女身世。众人陪伴孟扶摇前往穹苍，以血肉之躯抗衡上古邪物帝非天，历经艰险考验，终破穹苍阴谋，斩杀各路邪毒，守护五洲安泰，孟扶摇与长孙无极的爱情也终成善果。</p>
									</div>
									
									<ul id="tab2_1_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 经典武侠 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_2_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>飘香一剑</h3>
										<p>武林，正处于水深火热之中。自从李寻欢、西门吹雪、陆小凤等大侠相继引退，正道后继无人，进入了一个黑暗的武林年代。正道衰落，邪恶崛起，杀戮、破坏、战争随处可见，尤以天筝教势力最大，版图日渐扩张，四处围剿正道之士，使得江湖人心惶惶……然而，已退隐江湖的李寻欢，不忍武林被邪魔歪道所操控，遂成立聚贤山庄，以孙敏、钟静等为首，组成年轻的特别行动小队，负责四处寻找匿藏在江湖中的武林高手，把他们带到聚贤山庄，积聚实力，伺机反击邪魔歪道。</p>
									</div>
									
									<ul id="tab2_2_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 穿越时空 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_3_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>史上最燃韩信</h3>
										<p>秦末汉初，群雄逐鹿。空怀经天纬地之才却埋没民间的淮阴少年韩信，因缘际会遇到一名神秘黑衣人，称可借助神力帮韩信崛起，条件是只要韩信答应与他做一场交易。历史的车轮不断转动，秦始皇、刘邦、项羽、张良纷纷卷进权力纷争的核心，身处其中的韩信发现，王朝更替与权利交织的背后，竟有一股神秘的未知力量在操纵。</p>
									</div>
									
									<ul id="tab2_3_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 古装魔幻 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_4_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>跨越千年的爱恨纠葛</h3>
										<p>药师谷谷主许宣和师妹冷凝行医救人，在桃花节和白夭夭邂逅，历经波折两人终成眷属。但白夭夭为救许宣盗取仙草，触犯天条，病愈的许宣忆起前尘往事，只身救回白夭夭。师妹冷凝嫉妒白夭夭，引得蛟龙出世，为祸人间。白夭夭为了自我救赎，被齐霄镇压于雷峰塔下，许宣悲痛欲绝，不恋红尘，遁迹禅林。小青听得白夭夭规劝回山修炼，二十年后，白夭夭重见天日，与许宣因果已解，齐霄了断其尘缘，遁入空门。</p>
									</div>
									
									<ul id="tab2_4_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 悬疑佳作 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_5_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>地下惊奇世界</h3>
										<p>几个解放初期的盗墓贼从战国古墓中盗出了本书的一条主线：战国帛书。这是吴邪爷爷辈的事情，也就是狗五爷年少时候的故事，当时还没有江湖上的排行，当时最有名的一共是九个人，陈皮阿四，狗五，黑背老六等等，其中最末的九是解阿九，也就是解连环的老爸，这是吴邪没提过的。而就在这时，吴邪却发现自己慢慢的陷入了一个恐怖的漩涡之中...</p>
									</div>
									
									<ul id="tab2_5_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 英雄儿女 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_6_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>四个女人一台戏</h3>
										<p>这是四个女人的成长史。故事展开于1927年战火纷飞的江西，泼辣的农家女陈满金、来自上海的知识女性倪之慧、地主家的小姐蔡福、帮助过红军的女孩玄易，因为不同原因参加了红军，走进革命队伍。 　　她们共同经历了瑞金时代，在长征前夕各奔东西，直到1948年解放前夕在上海再次聚首，而此时，陈满金、倪之慧、玄易都已经成长为坚定的革命战士，蔡福则脱离革命，她们的友谊和人生面临着新的考验。1949年上海解放后，她们再次别离。　 　　1978年改革开放，命运让已是古稀老人的她们再次聚首，此时经历了生生死死的她们在华发之年共享夕阳。</p>
									</div>
									
									<ul id="tab2_6_2" class="equal-4 cover" style="width: 880px;">
											
									</ul>
								</div>
							</div>
						</div>
						<div>
							<!-- 都市爱情 -->
							<div class="grid-1-2 spacing-20">
								<div id="tab2_7_1" style="min-width:420px;height:338px;position: relative;">
									
								</div>
								<div>
									<div class="tit-box">
										<h3>都市伦理</h3>
										<p>少女乔安有着公主般的人生，然而突遭变故远走他乡，所有人都以为她的人生将就此没落，没想到乔安又光鲜回归上海，她要夺回父亲失去的广告帝国奥里斯。奥里斯上海总裁陆远扬是当年乔父的助理，了解乔安种种历史，频频刁难。打拼多年的老辣精英和势在必得的新人，在职场中展开了一场猫鼠游戏。乔安不言放弃，终获陆远扬认可，两人也产生了别样情愫，但摩擦不断。乔安唯一朋友倪好，遭遇失恋失业，与乔安抱团取暖，并认识了纨绔子弟江齐飞，二人经历了一系列共同成长，倪好却迟迟等不到江齐飞的表白。此时，乔安的富二代前男友回头，陆远扬与初恋也再度职场重逢。奥里斯面临被收购，最终，乔安、陆远扬联手保住公司，乔安身世暴露，再次消失。陆远扬带领奥里斯重回正轨，等待乔安归来。</p>
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
	// 独家策划
	javaex.tab({
		id : "tab2",
		mode : "click"
	});

	$(function() {
		// 幻灯片
		huandeng();
		
		// 同步跟播
		loadData2("newest_left", "newest_right", "api/data.json?apiId=48");
		
		// 网络神剧
		getDataByTag("internet_drama", "api/data.json?apiId=44");
		
		// 近期完结
		loadData2("over_data_left", "over_data_right", "api/data.json?apiId=46");
		
		// 偶像剧集地
		getDataByTag("idols", "api/data.json?apiId=47");
		
		// 英美强档
		loadData2("yingmei_left", "yingmei_right", "api/data.json?apiId=45");
		
		// 日韩风尚
		loadData("rihan", "api/data.json?apiId=43");
		
		// 独家策划
		// 招牌古装
		getDataByTag2("tab2_1_1", "tab2_1_2", "api/data.json?apiId=42");
		// 经典武侠
		getDataByTag2("tab2_2_1", "tab2_2_2", "api/data.json?apiId=41");
		// 穿越时空
		getDataByTag2("tab2_3_1", "tab2_3_2", "api/data.json?apiId=40");
		// 古装魔幻
		getDataByTag2("tab2_4_1", "tab2_4_2", "api/data.json?apiId=39");
		// 悬疑佳作
		getDataByTag2("tab2_5_1", "tab2_5_2", "api/data.json?apiId=38");
		// 英雄儿女
		getDataByTag2("tab2_6_1", "tab2_6_2", "api/data.json?apiId=37");
		// 都市爱情
		getDataByTag2("tab2_7_1", "tab2_7_2", "api/data.json?apiId=36");
		
		setTimeout(function() {
			$(".pop-in").removeClass("pop-in");
		}, 5000);
	});

	// 幻灯片
	function huandeng() {
		$.ajax({
			url : path + "api/slide.json?apiId=50",
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
	
	// 加载数据2
	function loadData2(id1, id2, api) {
		$.ajax({
			url : path + api,
			type : "POST",
			dataType : "json",
			success : function(rtn) {
				if (rtn.code=="999999") {
					loadData2();
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
							if (list[i].zongjishu==list[i].videoInfo.num) {
								leftHtml += '<span class="duration">全'+list[i].videoInfo.num+'集</span>';
							} else {
								leftHtml += '<span class="duration">更新至第'+list[i].videoInfo.num+'集</span>';
							}
							leftHtml += '<img src="'+list[i].dafengmian+'" class="pop-in" width="100%" height="100%" />';
							leftHtml += '</a>';
							leftHtml += '<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank">'+list[i].biaoti+'</a></p>';
							leftHtml += '<p>'+list[i].kandian+'</p>';
						} else {
							// 右边
							rightHtml += '<li>';
							rightHtml += '<a href="${pageContext.request.contextPath}/portal/play.action?videoId='+list[i].videoInfo.videoId+'" target="_blank" class="screenshot">';
							if (list[i].zongjishu==list[i].videoInfo.num) {
								rightHtml += '<span class="duration">全'+list[i].videoInfo.num+'集</span>';
							} else {
								rightHtml += '<span class="duration">更新至第'+list[i].videoInfo.num+'集</span>';
							}
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