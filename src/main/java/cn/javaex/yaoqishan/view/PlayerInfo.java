package cn.javaex.yaoqishan.view;

/**
 * 播放器接口表
 * 
 * @author 陈霓清
 */
public class PlayerInfo {
	private String id;		// 主键
	private String name;	// 名称
	private String content;	// 播放器内容
	private String sort;	// 排序
	
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
	public String getcontent() {
		return content;
	}
	public void setcontent(String content) {
		this.content = content;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	
}
