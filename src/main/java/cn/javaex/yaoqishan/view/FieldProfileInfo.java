package cn.javaex.yaoqishan.view;

/**
 * 字段简况表
 * 
 * @author 陈霓清
 */
public class FieldProfileInfo {
	private String id;		// 主键
	private String fieldId;	// 字段的主键
	private String name;	// 字段内容名称（大陆、香港、欧美...）
	private String sort;	// 排序
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFieldId() {
		return fieldId;
	}
	public void setFieldId(String fieldId) {
		this.fieldId = fieldId;
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
	
}
