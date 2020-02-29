package cn.javaex.yaoqishan.view;

/**
 * 用户认证激活表
 * 
 * @author 陈霓清
 */
public class ActivateInfo {
	private String id;			// 主键
	private String userId;		// 用户id
	private String type;		// 激活类型
	private String code;		// 验证码
	private String createTime;	// 验证码生成时间
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}
