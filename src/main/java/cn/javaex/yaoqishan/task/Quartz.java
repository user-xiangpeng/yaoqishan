package cn.javaex.yaoqishan.task;

import java.util.Calendar;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;

import cn.javaex.yaoqishan.service.video_info.VideoInfoService;
import cn.javaex.yaoqishan.view.VideoInfo;

/**
 * Quartz定时任务类
 */
public class Quartz {
	
	@Autowired
	private VideoInfoService videoInfoService;
	
	/***
	 * 定时任务
	 * 清空视频点击量
	 */
	public void execute() {
		Date now = new Date();
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(now);
		
		VideoInfo videoInfo = new VideoInfo();
		// 1.0 清空视频的今日点击量
		videoInfo.setViewCountDay("0");
		
		// 2.0 星期一，清空视频的周点击量
		int nWeek = calendar.get(Calendar.DAY_OF_WEEK)-1;
		if (nWeek==1) {
			videoInfo.setViewCountWeek("0");
		}

		// 3.0 每月1号，清空视频的月点击量
		int nMonth = calendar.get(Calendar.DAY_OF_MONTH);
		if (nMonth==1) {
			videoInfo.setViewCountMonth("0");
			
			// 4.0 每年1月1号，清空视频的年点击量
			int nYear = calendar.get(Calendar.MONTH);
			if (nYear==1) {
				videoInfo.setViewCountYear("0");
			}
		}
		
		videoInfoService.clearViewCount(videoInfo);
	}
}
