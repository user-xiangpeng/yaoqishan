<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>${seoInfo.title}</title>
<meta name="keywords" content="${seoInfo.keywords}" />
<meta name="description" content="${seoInfo.description}" />
<c:import url="common/common.jsp"></c:import>
</head>
<body>
	<!--头部-->
	<div class="header-wrap header-channel">
		<c:import url="common/header.jsp"></c:import>
	</div>

	<!--内容-->
	<div style="width: 1340px; margin: 20px auto;">
		<!--首页第一个聚合内容-->
		<div class="block no-shadow">
			<div class="main" style="margin-bottom: -40px;">
				<div class="grid-1-1-1 spacing-20">
					<div>
						<div style="width: 420px;height: 244px;position: relative;margin-bottom: 20px;">
							<a href="http://www.javaex.cn/" target="_blank"><img src="http://173.javaex.cn/Fl9vo0PYYkFWc95sJm9UyfSxumNz" width="100%" height="100%"></a>
							
							<div class="t">
								<p class="t1"><span><a href="http://www.javaex.cn/" target="_blank">java程序员写的前端框架</a></span></p>
							</div>
						</div>
						<ul class="equal-2" id="juhe2" style="width: 440px;margin-right: -20px;">
							<li>
								<div class="poly-ul-img">
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">
										<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
									</a>
								</div>
								<div class="poly-title">我是来测试的</div>
							</li>
							<li>
								<div class="poly-ul-img">
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">
										<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
									</a>
								</div>
								<div class="poly-title">我是来测试的</div>
							</li>
						</ul>
					</div>
					<div>
						<ul class="equal-2" id="juhe4" style="width: 440px;margin-right: -20px;">
							<li>
								<div class="poly-ul-img">
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">
										<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
									</a>
								</div>
								<div class="poly-title">我是来测试的</div>
							</li>
							<li>
								<div class="poly-ul-img">
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">
										<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
									</a>
								</div>
								<div class="poly-title">我是来测试的</div>
							</li>
							<li>
								<div class="poly-ul-img">
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">
										<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
									</a>
								</div>
								<div class="poly-title">我是来测试的</div>
							</li>
							<li>
								<div class="poly-ul-img">
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">
										<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
									</a>
								</div>
								<div class="poly-title">我是来测试的</div>
							</li>
							<li>
								<div class="poly-ul-img">
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">
										<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
									</a>
								</div>
								<div class="poly-title">我是来测试的</div>
							</li>
							<li>
								<div class="poly-ul-img">
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">
										<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
									</a>
								</div>
								<div class="poly-title">我是来测试的</div>
							</li>
						</ul>
					</div>
					<div>
						<div style="width: 420px;height: 112px;margin-bottom: 20px;">
							<a href="http://www.javaex.cn/" target="_blank"><img src="http://173.javaex.cn/FuHDdQCBVHpQjncxdm76yzO2q6fj" width="100%" height="100%"></a>
						</div>
						<div style="width: 420px;height: 244px;position: relative">
							<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank"><img src="http://173.javaex.cn/FgM-UfvaZEVK4mnlPIisI0wPASW6" width="100%" height="100%"></a>
							<div class="t">
								<p class="t1"><span><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">爱如意 电影《阿修罗》主题曲 -- 邓紫棋</a></span></p>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!--正在热播-->
		<div class="block no-shadow" style="height:259px;">
			<div class="main">
				<div class="tab">
					<div class="tab-title">
						<img class="mod-icon" src="${pageContext.request.contextPath}/static/default/images/ico1.png" />
						<em>正在热播</em>
					</div>
					<div class="tab-content">
						<ul id="month_hot" class="equal-6 cover">
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<span class="duration">更新至第8集</span>
									<img src="http://173.javaex.cn/FpDRB9J4fYUJ2EddbM3CTvway8lZ" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">热血狂篮</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<span class="duration">更新至第8集</span>
									<img src="http://173.javaex.cn/FpDRB9J4fYUJ2EddbM3CTvway8lZ" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">热血狂篮</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<span class="duration">更新至第8集</span>
									<img src="http://173.javaex.cn/FpDRB9J4fYUJ2EddbM3CTvway8lZ" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">热血狂篮</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<span class="duration">更新至第8集</span>
									<img src="http://173.javaex.cn/FpDRB9J4fYUJ2EddbM3CTvway8lZ" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">热血狂篮</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<span class="duration">更新至第8集</span>
									<img src="http://173.javaex.cn/FpDRB9J4fYUJ2EddbM3CTvway8lZ" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">热血狂篮</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<span class="duration">更新至第8集</span>
									<img src="http://173.javaex.cn/FpDRB9J4fYUJ2EddbM3CTvway8lZ" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">热血狂篮</a></p>
								<p>100次播放</p>
							</li>
							<span class="clearfix"></span>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--广告-->
		<div class="block no-shadow">
			<div class="main">
				<c:import url="ad/ad1.jsp"></c:import>
			</div>
		</div>
		
		<!--电影-->
		<div class="block no-shadow" style="height:447px;">
			<!--正文内容-->
			<div class="main">
				<!--选项卡切换-->
				<div id="tab1" class="tab">
					<!--选项卡标题部分-->
					<div class="tab-title">
						<!--可以为选项卡添加图标、大标题、链接-->
						<img class="mod-icon" src="${pageContext.request.contextPath}/static/default/images/ico3.png" />
						<em>电影  <i style="color:#ccc">></i></em>
						<ul>
							<li>最新</li>
							<li>好莱坞</li>
							<li>预告片</li>
							<!--可以为选项卡右上角添加链接-->
							<a class="more" href="#" target="_blank">电影排行</a>
							<span class="clearfix"></span>
						</ul>
					</div>
					<!--选项卡内容部分-->
					<div class="tab-content">
						<div>
							<ul id="new_movie" class="equal-6 poster">
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<img src="http://173.javaex.cn/FjYbNZwC-cRvrZtuXDAPn3AecI3B" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">人再囧途之泰囧</a></p>
									<p>国产喜剧黄金三角</p>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<img src="http://173.javaex.cn/FjYbNZwC-cRvrZtuXDAPn3AecI3B" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">人再囧途之泰囧</a></p>
									<p>国产喜剧黄金三角</p>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<img src="http://173.javaex.cn/FjYbNZwC-cRvrZtuXDAPn3AecI3B" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">人再囧途之泰囧</a></p>
									<p>国产喜剧黄金三角</p>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<img src="http://173.javaex.cn/FjYbNZwC-cRvrZtuXDAPn3AecI3B" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">人再囧途之泰囧</a></p>
									<p>国产喜剧黄金三角</p>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<img src="http://173.javaex.cn/FjYbNZwC-cRvrZtuXDAPn3AecI3B" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">人再囧途之泰囧</a></p>
									<p>国产喜剧黄金三角</p>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<img src="http://173.javaex.cn/FjYbNZwC-cRvrZtuXDAPn3AecI3B" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">人再囧途之泰囧</a></p>
									<p>国产喜剧黄金三角</p>
								</li>
								<span class="clearfix"></span>
							</ul>
						</div>
						<div>
							<ul id="haolaiwu" class="equal-6 poster">
								
							</ul>
						</div>
						<div>
							<ul id="yugaopian" class="equal-6 poster">
								
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!--电视剧-->
		<div class="block no-shadow">
			<!--正文内容-->
			<div class="main" style="margin-bottom: -40px;">
				<!--选项卡切换-->
				<div id="tab2" class="tab">
					<!--选项卡标题部分-->
					<div class="tab-title">
						<!--可以为选项卡添加图标、大标题、链接-->
						<img class="mod-icon" src="${pageContext.request.contextPath}/static/default/images/ico4.png" />
						<em>电视剧  <i style="color:#ccc">></i></em>
						<ul>
							<li>最新</li>
							<li>国产剧</li>
							<li>英美剧</li>
							<li>日韩剧</li>
							<!--可以为选项卡右上角添加链接-->
							<a class="more" href="#" target="_blank">电视剧排行</a>
							<span class="clearfix"></span>
						</ul>
					</div>
					<!--选项卡内容部分-->
					<div class="tab-content">
						<div class="grid-1-2 spacing-20" style="height:352px;">
							<div>
								<ul class="big-cover">
									<li id="newest_left">
										<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
											<span class="duration">更新至第24集</span>
											<img src="http://173.javaex.cn/FuFpI3FQhIUejcz9tMgUl_aj3pbf" width="100%" height="100%" style="animation-delay: '+Math.random()+'s" />
										</a>
										<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
										<p>杨蓉变外星人为爱痴狂</p>
									</li>
								</ul>
							</div>
							<div>
								<ul id="newest_right" class="equal-4 cover" style="width: 880px;">
									<li>
										<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
											<span class="duration">更新至第8集</span>
											<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
										</a>
										<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
										<p>杨蓉变外星人为爱痴狂</p>
									</li>
									<li>
										<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
											<span class="duration">更新至第8集</span>
											<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
										</a>
										<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
										<p>杨蓉变外星人为爱痴狂</p>
									</li>
									<li>
										<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
											<span class="duration">更新至第8集</span>
											<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
										</a>
										<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
										<p>杨蓉变外星人为爱痴狂</p>
									</li>
									<li>
										<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
											<span class="duration">更新至第8集</span>
											<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
										</a>
										<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
										<p>杨蓉变外星人为爱痴狂</p>
									</li>
									<li>
										<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
											<span class="duration">更新至第8集</span>
											<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
										</a>
										<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
										<p>杨蓉变外星人为爱痴狂</p>
									</li>
									<li>
										<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
											<span class="duration">更新至第8集</span>
											<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
										</a>
										<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
										<p>杨蓉变外星人为爱痴狂</p>
									</li>
									<li>
										<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
											<span class="duration">更新至第8集</span>
											<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
										</a>
										<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
										<p>杨蓉变外星人为爱痴狂</p>
									</li>
									<li>
										<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
											<span class="duration">更新至第8集</span>
											<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
										</a>
										<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
										<p>杨蓉变外星人为爱痴狂</p>
									</li>
									<span class="clearfix"></span>
								</ul>
							</div>
						</div>
						<div class="grid-1-2 spacing-20" style="height:352px;">
							<div>
								<ul class="big-cover">
									<li id="guochanju_left">
										
									</li>
								</ul>
							</div>
							<div>
								<ul id="guochanju_right" class="equal-4 cover" style="width: 880px;">
									
								</ul>
							</div>
						</div>
						<div class="grid-1-2 spacing-20" style="height:352px;">
							<div>
								<ul class="big-cover">
									<li id="yingmeiju_left">
										
									</li>
								</ul>
							</div>
							<div>
								<ul id="yingmeiju_right" class="equal-4 cover" style="width: 880px;">
									
								</ul>
							</div>
						</div>
						<div class="grid-1-2 spacing-20" style="height:352px;">
							<div>
								<ul class="big-cover">
									<li id="rihanju_left">
										
									</li>
								</ul>
							</div>
							<div>
								<ul id="rihanju_right" class="equal-4 cover" style="width: 880px;">
									
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<!--放剧场-->
		<div class="block no-shadow" style="height:259px;">
			<div class="main">
				<div class="tab">
					<div class="tab-title">
						<img class="mod-icon" src="${pageContext.request.contextPath}/static/default/images/ico5.png" />
						<em>放剧场</em>
					</div>
					<div class="tab-content">
						<ul id="fangjuchang" class="equal-6 cover">
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<span class="duration">更新至第8集</span>
									<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
								<p>杨蓉变外星人为爱痴狂</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<span class="duration">更新至第8集</span>
									<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
								<p>杨蓉变外星人为爱痴狂</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<span class="duration">更新至第8集</span>
									<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
								<p>杨蓉变外星人为爱痴狂</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<span class="duration">更新至第8集</span>
									<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
								<p>杨蓉变外星人为爱痴狂</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<span class="duration">更新至第8集</span>
									<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
								<p>杨蓉变外星人为爱痴狂</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<span class="duration">更新至第8集</span>
									<img src="http://173.javaex.cn/FoY7KOxNyZPPn7AQ_whR5P3SVGxl" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">冒险王卫斯理之无名发</a></p>
								<p>杨蓉变外星人为爱痴狂</p>
							</li>
							<span class="clearfix"></span>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--动漫-->
		<div class="block no-shadow" style="height: 435px;">
			<!--正文内容-->
			<div class="main">
				<!--选项卡切换-->
				<div id="tab3" class="tab">
					<!--选项卡标题部分-->
					<div class="tab-title">
						<!--可以为选项卡添加图标、大标题、链接-->
						<img class="mod-icon" src="${pageContext.request.contextPath}/static/default/images/ico6.png" />
						<em>动漫  <i style="color:#ccc">></i></em>
						<ul>
							<li>最新更新</li>
							<li>周一更新</li>
							<li>周二更新</li>
							<li>周三更新</li>
							<li>周四更新</li>
							<li>周五更新</li>
							<li>周六更新</li>
							<li>周日更新</li>
							<!--可以为选项卡右上角添加链接-->
							<a class="more" href="#" target="_blank">动漫排行</a>
							<span class="clearfix"></span>
						</ul>
					</div>
					<!--选项卡内容部分-->
					<div class="tab-content">
						<div>
							<ul id="tab3_0" class="equal-6 cover">
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<span class="duration">更新至第8集</span>
										<img src="http://173.javaex.cn/FhAfIrrRYzmhv73QKLxHVoK65d7I" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">少年锦衣卫</a></p>
									<p>少年袁小棠的传奇人生</p>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<span class="duration">更新至第8集</span>
										<img src="http://173.javaex.cn/FhAfIrrRYzmhv73QKLxHVoK65d7I" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">少年锦衣卫</a></p>
									<p>少年袁小棠的传奇人生</p>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<span class="duration">更新至第8集</span>
										<img src="http://173.javaex.cn/FhAfIrrRYzmhv73QKLxHVoK65d7I" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">少年锦衣卫</a></p>
									<p>少年袁小棠的传奇人生</p>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<span class="duration">更新至第8集</span>
										<img src="http://173.javaex.cn/FhAfIrrRYzmhv73QKLxHVoK65d7I" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">少年锦衣卫</a></p>
									<p>少年袁小棠的传奇人生</p>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<span class="duration">更新至第8集</span>
										<img src="http://173.javaex.cn/FhAfIrrRYzmhv73QKLxHVoK65d7I" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">少年锦衣卫</a></p>
									<p>少年袁小棠的传奇人生</p>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<span class="duration">更新至第8集</span>
										<img src="http://173.javaex.cn/FhAfIrrRYzmhv73QKLxHVoK65d7I" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">少年锦衣卫</a></p>
									<p>少年袁小棠的传奇人生</p>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<span class="duration">更新至第8集</span>
										<img src="http://173.javaex.cn/FhAfIrrRYzmhv73QKLxHVoK65d7I" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">少年锦衣卫</a></p>
									<p>少年袁小棠的传奇人生</p>
								</li>
								<li>
									<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
										<span class="duration">更新至第8集</span>
										<img src="http://173.javaex.cn/FhAfIrrRYzmhv73QKLxHVoK65d7I" width="100%" height="100%" />
									</a>
									<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">少年锦衣卫</a></p>
									<p>少年袁小棠的传奇人生</p>
								</li>
								<span class="clearfix"></span>
							</ul>
						</div>
						<div><ul id="tab3_1" class="equal-6 cover">1</ul></div>
						<div><ul id="tab3_2" class="equal-6 cover">2</ul></div>
						<div><ul id="tab3_3" class="equal-6 cover">3</ul></div>
						<div><ul id="tab3_4" class="equal-6 cover">4</ul></div>
						<div><ul id="tab3_5" class="equal-6 cover">5</ul></div>
						<div><ul id="tab3_6" class="equal-6 cover">6</ul></div>
						<div><ul id="tab3_7" class="equal-6 cover">7</ul></div>
					</div>
				</div>
			</div>
		</div>
		
		<!--音乐-->
		<div class="block no-shadow" style="height: 435px;">
			<!--正文内容-->
			<div class="main">
				<!--选项卡切换-->
				<div id="tab4" class="tab">
					<!--选项卡标题部分-->
					<div class="tab-title">
						<!--可以为选项卡添加图标、大标题、链接-->
						<img class="mod-icon" src="${pageContext.request.contextPath}/static/default/images/ico12.png" />
						<em>音乐  <i style="color:#ccc">></i></em>
						<ul>
							<li>内地</li>
							<li>港台</li>
							<li>欧美</li>
							<li>韩国</li>
							<li>日本</li>
							<li>二次元</li>
							<!--可以为选项卡右上角添加链接-->
							<a class="more" href="#" target="_blank">音乐排行</a>
						</ul>
					</div>
					<!--选项卡内容部分-->
					<div class="tab-content">
						<div>
							<ul id="tab4_1" class="equal-6 cover">
								<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<ul id="tab4_1" class="equal-6 cover">
								<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<span class="clearfix"></span>
							</ul>
						</div>
						<div><ul id="tab4_2" class="equal-6 cover">2</ul></div>
						<div><ul id="tab4_3" class="equal-6 cover">3</ul></div>
						<div><ul id="tab4_4" class="equal-6 cover">4</ul></div>
						<div><ul id="tab4_5" class="equal-6 cover">5</ul></div>
						<div><ul id="tab4_6" class="equal-6 cover">6</ul></div>
					</div>
				</div>
			</div>
		</div>
		
		<!--搞笑-->
		<div class="block no-shadow" style="height:259px;">
			<div class="main">
				<div class="tab">
					<div class="tab-title">
						<img class="mod-icon" src="${pageContext.request.contextPath}/static/default/images/ico8.png" />
						<em>搞笑</em>
					</div>
					<div class="tab-content">
						<ul id="gaoxiao" class="equal-6 cover">
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<span class="clearfix"></span>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--鬼畜-->
		<div class="block no-shadow" style="height:259px;">
			<div class="main">
				<div class="tab">
					<div class="tab-title">
						<img class="mod-icon" src="${pageContext.request.contextPath}/static/default/images/ico10.png" />
						<em>鬼畜</em>
					</div>
					<div class="tab-content">
						<ul id="guichu" class="equal-6 cover">
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<span class="clearfix"></span>
						</ul>
					</div>
				</div>
			</div>
		</div>
		
		<!--动漫综合-->
		<div class="block no-shadow" style="height:259px;">
			<div class="main">
				<div class="tab">
					<div class="tab-title">
						<img class="mod-icon" src="${pageContext.request.contextPath}/static/default/images/ico9.png" />
						<em>动漫综合</em>
					</div>
					<div class="tab-content">
						<ul id="dongmanzonghe" class="equal-6 cover">
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<li>
								<a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank" class="screenshot">
									<img src="http://173.javaex.cn/FmimHy5MLxEtcAg5Tm72vbT0eu_f" width="100%" height="100%" />
								</a>
								<p class="screenshot-title"><a href="${pageContext.request.contextPath}/portal/play.action?videoId=3495" target="_blank">我是来测试的</a></p>
								<p>100次播放</p>
							</li>
							<span class="clearfix"></span>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!--底部-->
	<div class="footer-wrap js-use-footer" >
		<c:import url="common/footer.jsp"></c:import>
	</div>
</body>
<script>
	javaex.tab({
		id : "tab1",
		mode : "click"
	});
	
	javaex.tab({
		id : "tab2",
		display : "flex",
		mode : "click"
	});
	
	javaex.tab({
		id : "tab3",
		display : "flex",
		mode : "click"
	});
	
	javaex.tab({
		id : "tab4",
		mode : "click"
	});
</script>
</html>
