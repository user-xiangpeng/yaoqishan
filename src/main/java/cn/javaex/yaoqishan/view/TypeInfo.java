package cn.javaex.yaoqishan.view;

/**
 * 分类表
 * 
 * @author 陈霓清
 */
public class TypeInfo {
	private String id;		// 主键
	private String name;	// 分类名称（电影、电视剧、动漫...）
	private String sort;	// 排序
	private String profileTemplate;	// 详情页模板
	private String playTemplate;	// 播放页模板
	
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
	public String getProfileTemplate() {
		return profileTemplate;
	}
	public void setProfileTemplate(String profileTemplate) {
		this.profileTemplate = profileTemplate;
	}
	public String getPlayTemplate() {
		return playTemplate;
	}
	public void setPlayTemplate(String playTemplate) {
		this.playTemplate = playTemplate;
	}
	
}
