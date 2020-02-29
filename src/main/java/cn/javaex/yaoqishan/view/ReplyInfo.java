package cn.javaex.yaoqishan.view;

/**
 * 对某条评论或回复的回复表
 * 
 * @author 陈霓清
 */
public class ReplyInfo {
	private String id;				// 主键
	private String videoId;			// 视频id
	private String commentId;		// 评论表的主键
	private String userId;			// 回复人的id
	private String loginName;		// 回复人的登录名
	private String toUserId;		// 被回复人的id
	private String toLoginName;		// 被回复人的登录名
	private String content;			// 回复内容
	private String updateTime;		// 回复时间
	
	private String avatar;		// 用户头像

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
	public String getCommentId() {
		return commentId;
	}
	public void setCommentId(String commentId) {
		this.commentId = commentId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getToUserId() {
		return toUserId;
	}
	public void setToUserId(String toUserId) {
		this.toUserId = toUserId;
	}
	public String getToLoginName() {
		return toLoginName;
	}
	public void setToLoginName(String toLoginName) {
		this.toLoginName = toLoginName;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	
}
