package cn.javaex.yaoqishan.view;

import java.util.Date;

/**
 * 用户历史播放记录
 * 
 * @author 陈霓清
 */
public class HistoryInfo {
	private String id;			// 主键
	private String videoId;		// 视频主键
	private String userId;		// 用户id
	private Date updateTime;	// 浏览时间
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getVideoId() {
		return videoId;
	}
	public void setVideoId(String videoId) {
		this.videoId = videoId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	
}
