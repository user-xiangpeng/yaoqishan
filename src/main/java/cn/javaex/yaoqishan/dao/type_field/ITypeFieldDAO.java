package cn.javaex.yaoqishan.dao.type_field;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.javaex.yaoqishan.view.TypeField;

public interface ITypeFieldDAO {

	/**
	 * 根据分类信息主键，查询该分类下的字段配置
	 * @param typeId 分类信息主键
	 * @return
	 */
	List<TypeField> listByTypeId(String typeId);

	/**
	 * 判断在该分类中是否已包含此字段
	 * @param typeId 分类信息主键
	 * @param fieldId 字段主键
	 * @return
	 */
	int countFieldByTypeIdAndFieldId(@Param("typeId") String typeId, @Param("fieldId") String fieldId);

	/**
	 * 删除该分类下的所有字段配置
	 * @param typeId 分类信息主键
	 * @return
	 */
	int deleteByTypeId(String typeId);
	
	/**
	 * 批量插入分类信息下的字段配置
	 * @param typeFieldList
	 * @return
	 */
	int batchInsert(@Param("typeFieldList") List<TypeField> typeFieldList);

	/**
	 * 检索指定字段是否必填
	 * @param typeId 分类信息主键
	 * @param varName 字段变量名
	 * @return
	 */
	String selectIsRequired(@Param("typeId") String typeId, @Param("varName") String varName);

	/**
	 * 查询字段被使用的分类数量
	 * @param fieldId 字段主键
	 * @return
	 */
	int countByFieldId(String fieldId);

	/**
	 * 根据分类信息主键，查询条数
	 * @param typeId 分类信息主键
	 * @return
	 */
	int countByTypeId(String typeId);

}