package cn.javaex.yaoqishan.view;

/**
 * 视频收藏表
 * 
 * @author 陈霓清
 */
public class CollectionInfo {
	private String id;		// 主键
	private String mediaId;	// 媒体表主键
	private String userId;	// 用户id
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMediaId() {
		return mediaId;
	}
	public void setMediaId(String mediaId) {
		this.mediaId = mediaId;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}

}
