package cn.javaex.yaoqishan.view;

/**
 * 邮件设置表
 * 
 * @author 陈霓清
 */
public class EmailInfo {
	private String id;		// 主键
	private String smtp;	// SMTP 服务器
	private String port;	// 端口
	private String email;	// 发信人邮件地址
	private String password;// SMTP 身份验证密码
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getSmtp() {
		return smtp;
	}
	public void setSmtp(String smtp) {
		this.smtp = smtp;
	}
	public String getPort() {
		return port;
	}
	public void setPort(String port) {
		this.port = port;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	
}
