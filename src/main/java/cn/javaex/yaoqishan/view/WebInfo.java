package cn.javaex.yaoqishan.view;

import java.io.Serializable;

/**
 * 网站信息表
 * 
 * @author 陈霓清
 */
@SuppressWarnings("serial")
public class WebInfo implements Serializable {
	private String id;				// 主键
	private String name;			// 站点名称，将显示在浏览器窗口标题等位置
	private String domain;			// 网站 URL
	private String email;			// 管理员 E-mail
	private String recordNumber;	// 网站备案信息代码
	private String statisticalCode;	// 网站第三方统计代码
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRecordNumber() {
		return recordNumber;
	}
	public void setRecordNumber(String recordNumber) {
		this.recordNumber = recordNumber;
	}
	public String getStatisticalCode() {
		return statisticalCode;
	}
	public void setStatisticalCode(String statisticalCode) {
		this.statisticalCode = statisticalCode;
	}
	
}
