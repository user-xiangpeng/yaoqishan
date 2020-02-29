package cn.javaex.yaoqishan.view;

import java.io.Serializable;

/**
 * 模板配置表
 * 
 * @author 陈霓清
 */
@SuppressWarnings("serial")
public class TemplateInfo implements Serializable {
	private String id;		// 主键
	private String type;	// 类型（pc：电脑端； m：手机端）
	private String name;	// 模板的名称
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
}
