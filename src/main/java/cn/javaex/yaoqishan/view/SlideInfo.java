package cn.javaex.yaoqishan.view;

/**
 * 幻灯片数据表
 * 
 * @author 陈霓清
 */
public class SlideInfo {
	private String id;		// 主键
	private String apiId;	// 接口表的主键
	private String title;	// 标题
	private String summary;	// 看点
	private String image;	// 大图
	private String thumbnail;// 小图
	private String url;		// 链接地址
	private String sort;	// 排序
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getApiId() {
		return apiId;
	}
	public void setApiId(String apiId) {
		this.apiId = apiId;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	
}
