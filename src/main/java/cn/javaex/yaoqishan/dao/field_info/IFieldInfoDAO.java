package cn.javaex.yaoqishan.dao.field_info;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.javaex.yaoqishan.view.FieldInfo;

public interface IFieldInfoDAO {

	/**
	 * 查询字段列表
	 */
	List<FieldInfo> list();

	/**
	 * 插入新的字段
	 */
	int insert(FieldInfo fieldInfo);
	
	/**
	 * 更新字段
	 */
	int update(FieldInfo fieldInfo);

	
	/**
	 * 批量删除字段
	 * @param idArr 主键数组
	 * @return
	 */
	int delete(@Param("idArr") String[] idArr);

	/**
	 * 获取分类筛选字段的信息
	 * @param typeId 分类信息的主键
	 * @return
	 */
	List<FieldInfo> listCategoryField(String typeId);

	/**
	 * 校验字段变量名是否重复（排除自己）
	 * @param varName 字段变量名
	 * @param id 主键
	 * @return
	 */
	int countByVarName(@Param("varName") String varName, @Param("id") String id);

	/**
	 * 根据主键查询字段信息
	 * @param id 字段主键
	 * @return
	 */
	FieldInfo selectById(String id);

	/**
	 * 根据主键数组，获取字段的变量名集合
	 * @param fieldIdArr
	 * @return
	 */
	List<String> listVarNameByIdArr(@Param("idArr") String[] idArr);

	/**
	 * 查询分类下的字段列表
	 * @param typeId 分类信息主键
	 * @return
	 */
	List<FieldInfo> listByTypeId(@Param("typeId") String typeId);

	/**
	 * 查询单选框字段
	 * @return
	 */
	List<FieldInfo> listRadio();

	/**
	 * 根据分类id，查询该分类的单选框字段
	 * @param typeId 分类信息的id
	 * @return
	 */
	List<FieldInfo> listRadioByTypeId(@Param("typeId") String typeId);
	
	/**
	 * 根据字段变量名，查询字段信息
	 * @param varName 字段变量名
	 * @return
	 */
	FieldInfo selectByVarName(String varName);

}