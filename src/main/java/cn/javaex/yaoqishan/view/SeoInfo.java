package cn.javaex.yaoqishan.view;

import java.io.Serializable;

/**
 * seo
 * 
 * @author 陈霓清
 */
@SuppressWarnings("serial")
public class SeoInfo implements Serializable {
	private String id;			// 主键
	private String title;		// 标题
	private String keywords;	// 关键字
	private String description;	// 描述
	private String type;		// 类型（首页、播放页...）
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getKeywords() {
		return keywords;
	}
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
}
