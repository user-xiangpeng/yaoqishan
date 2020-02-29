package cn.javaex.yaoqishan.view;

import java.util.List;

/**
 * 用户对某个视频的评论表
 * 
 * @author 陈霓清
 */
public class CommentInfo {
	private String id;			// 主键
	private String videoId;		// 视频id
	private String userId;		// 用户id
	private String loginName;	// 用户登录名
	private String content;		// 评论内容
	private String updateTime;	// 评论时间
	
	private String avatar;		// 用户头像
	private List<ReplyInfo> replyInfoLsit;	// 回复列表
	
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
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
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
	public List<ReplyInfo> getReplyInfoLsit() {
		return replyInfoLsit;
	}
	public void setReplyInfoLsit(List<ReplyInfo> replyInfoLsit) {
		this.replyInfoLsit = replyInfoLsit;
	}
	
}
