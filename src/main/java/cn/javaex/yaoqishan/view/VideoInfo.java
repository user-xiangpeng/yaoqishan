package cn.javaex.yaoqishan.view;

/**
 * 视频播放地址表
 * 
 * @author 陈霓清
 */
public class VideoInfo {
	private String videoId;		// 主键
	private String mediaId;		// 媒体信息主键
	private String num;			// 第几集
	private String title;		// 该集标题
	private String image;		// 该集封面
	private String url;			// 视频播放地址
	private String playerId;	// 播放器id
	private String sort;		// 排序用
	private String status;		// 状态，是否禁用。1代表正常，0代表禁用
	private String remark;		// 视频简介
	private String power;		// 视频播放权限值
	private String updateTime;	// 发布时间
	private String viewCount;		// 该视频播放总量
	private String viewCountDay;	// 日播放量
	private String viewCountWeek;	// 周播放量
	private String viewCountMonth;	// 月播放量
	private String viewCountYear;	// 年播放量
	
	private String biaoti;		// 媒体信息名称
	private String play;		// 播放内容
	
	public String getVideoId() {
		return videoId;
	}
	public void setVideoId(String videoId) {
		this.videoId = videoId;
	}
	public String getMediaId() {
		return mediaId;
	}
	public void setMediaId(String mediaId) {
		this.mediaId = mediaId;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getPlayerId() {
		return playerId;
	}
	public void setPlayerId(String playerId) {
		this.playerId = playerId;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getPower() {
		return power;
	}
	public void setPower(String power) {
		this.power = power;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public String getViewCount() {
		return viewCount;
	}
	public void setViewCount(String viewCount) {
		this.viewCount = viewCount;
	}
	public String getViewCountDay() {
		return viewCountDay;
	}
	public void setViewCountDay(String viewCountDay) {
		this.viewCountDay = viewCountDay;
	}
	public String getViewCountWeek() {
		return viewCountWeek;
	}
	public void setViewCountWeek(String viewCountWeek) {
		this.viewCountWeek = viewCountWeek;
	}
	public String getViewCountMonth() {
		return viewCountMonth;
	}
	public void setViewCountMonth(String viewCountMonth) {
		this.viewCountMonth = viewCountMonth;
	}
	public String getViewCountYear() {
		return viewCountYear;
	}
	public void setViewCountYear(String viewCountYear) {
		this.viewCountYear = viewCountYear;
	}
	public String getBiaoti() {
		return biaoti;
	}
	public void setBiaoti(String biaoti) {
		this.biaoti = biaoti;
	}
	public String getPlay() {
		return play;
	}
	public void setPlay(String play) {
		this.play = play;
	}
	
}
