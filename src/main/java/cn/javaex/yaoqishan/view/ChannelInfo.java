package cn.javaex.yaoqishan.view;

/**
 * 频道栏目表
 * 
 * @author 陈霓清
 */
public class ChannelInfo {
	private String id;			// 主键
	private String name;		// 名称
	private String sort;		// 排序用
	private String template;	// 模板文件名
	private String title;		// 标题
	private String keywords;	// 关键字
	private String description;	// 描述
	
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
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getTemplate() {
		return template;
	}
	public void setTemplate(String template) {
		this.template = template;
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
	
}
