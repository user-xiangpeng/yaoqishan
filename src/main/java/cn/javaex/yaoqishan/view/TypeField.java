package cn.javaex.yaoqishan.view;

/**
 * 分类信息字段配置表
 * 某个分类信息中，包含哪些字段
 * 
 * @author 陈霓清
 */
public class TypeField {
	private String id;			// 主键
	private String typeId;		// 分类信息主键
	private String fieldId;		// 字段主键
	private String isScreen;	// 该字段是否允许在列表页进行筛选（1：允许；0：禁止）
	private String isRequired;	// 该字段在编辑页面是否必填（1：必填；0：不必填）
	private String sort;		// 排序
	
	private String fieldName;	// 字段名称
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getTypeId() {
		return typeId;
	}
	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
	public String getFieldId() {
		return fieldId;
	}
	public void setFieldId(String fieldId) {
		this.fieldId = fieldId;
	}
	public String getIsScreen() {
		return isScreen;
	}
	public void setIsScreen(String isScreen) {
		this.isScreen = isScreen;
	}
	public String getIsRequired() {
		return isRequired;
	}
	public void setIsRequired(String isRequired) {
		this.isRequired = isRequired;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}

}
