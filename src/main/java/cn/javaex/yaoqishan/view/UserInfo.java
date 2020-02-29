package cn.javaex.yaoqishan.view;

/**
 * 用户登录注册表
 * 
 * @author 陈霓清
 */
public class UserInfo {
	private String id;				// 主键
	private String loginName;		// 登录名
	private String passWord;		// 登录密码
	private String email;			// 注册邮箱
	private String registerTime;	// 注册时间
	private String registerIp;		// 注册ip
	private String lastLoginTime;	// 上一次登陆时间
	private String lastLoginIp;		// 上一次登陆ip
	private String status;			// 用户状态。（0：未激活；1：正常；2：封禁）
	
	private String avatar;			// 用户头像
	private String signPersonal;	// 用户个性签名
	private int point;				// 用户积分
	private String groupId;			// 用户所在用户组id
	private String groupName;		// 用户所在用户组
	private String power;			// 用户的权限值
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getPassWord() {
		return passWord;
	}
	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRegisterTime() {
		return registerTime;
	}
	public void setRegisterTime(String registerTime) {
		this.registerTime = registerTime;
	}
	public String getRegisterIp() {
		return registerIp;
	}
	public void setRegisterIp(String registerIp) {
		this.registerIp = registerIp;
	}
	public String getLastLoginTime() {
		return lastLoginTime;
	}
	public void setLastLoginTime(String lastLoginTime) {
		this.lastLoginTime = lastLoginTime;
	}
	public String getLastLoginIp() {
		return lastLoginIp;
	}
	public void setLastLoginIp(String lastLoginIp) {
		this.lastLoginIp = lastLoginIp;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getAvatar() {
		return avatar;
	}
	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}
	public String getSignPersonal() {
		return signPersonal;
	}
	public void setSignPersonal(String signPersonal) {
		this.signPersonal = signPersonal;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getGroupId() {
		return groupId;
	}
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getPower() {
		return power;
	}
	public void setPower(String power) {
		this.power = power;
	}

}
