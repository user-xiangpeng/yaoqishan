package cn.javaex.yaoqishan.view;

import java.util.List;

/**
 * 字段信息表
 * 
 * @author 陈霓清
 */
public class FieldInfo {
	private String id;			// 主键
	private String name;		// 分类名称（视频所属分类：电影、电视剧、动漫...）
	private String type;		// 该用户组是否为系统内置（system代表内置的，不可修改）
	private String sort;		// 排序
	private String inputType;	// 填写类型
	private String varName;		// 变量名
	private String content;		// 字段模板
	private String isAllowEdit;	// 该字段是否允许编辑（1：有详情，可以编辑）
	
	private List<FieldProfileInfo> fieldProfileInfoList;	// 字段详情
	private String isSelected;	// 判断在指定分类中是否已包含此字段（1：包含）
	
	public String getIsAllowEdit() {
		return isAllowEdit;
	}
	public void setIsAllowEdit(String isAllowEdit) {
		this.isAllowEdit = isAllowEdit;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
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
	public String getInputType() {
		return inputType;
	}
	public void setInputType(String inputType) {
		this.inputType = inputType;
	}
	public String getVarName() {
		return varName;
	}
	public void setVarName(String varName) {
		this.varName = varName;
	}
	public List<FieldProfileInfo> getFieldProfileInfoList() {
		return fieldProfileInfoList;
	}
	public void setFieldProfileInfoList(List<FieldProfileInfo> fieldProfileInfoList) {
		this.fieldProfileInfoList = fieldProfileInfoList;
	}
	public String getIsSelected() {
		return isSelected;
	}
	public void setIsSelected(String isSelected) {
		this.isSelected = isSelected;
	}
	
}
