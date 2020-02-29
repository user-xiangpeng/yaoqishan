package cn.javaex.yaoqishan.view;

/**
 * 用户组表
 * 
 * @author 陈霓清
 */
public class GroupInfo {
	private String id;			// 主键
	private String name;	// 用户组名称
	private String power;	// 用户组权限值，管理员最大（255）
	private String type;	// 该用户组是否为系统内置（system代表内置的，不可修改）
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
	public String getPower() {
		return power;
	}
	public void setPower(String power) {
		this.power = power;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	
}
