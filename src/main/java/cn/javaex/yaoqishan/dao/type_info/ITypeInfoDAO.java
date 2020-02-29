package cn.javaex.yaoqishan.dao.type_info;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.javaex.yaoqishan.view.TypeInfo;


public interface ITypeInfoDAO {

	/**
	 * 查询分类列表
	 */
	List<TypeInfo> list();

	/**
	 * 插入新的分类
	 * @param typeInfo
	 * @return
	 */
	int insert(TypeInfo typeInfo);
	
	/**
	 * 更新分类
	 * @param typeInfo
	 * @return
	 */
	int update(TypeInfo typeInfo);
	
	/**
	 * 批量删除分类
	 * @param idArr 主键数组
	 * @return
	 */
	int delete(@Param("idArr") String[] idArr);

	/**
	 * 根据主键查询分类信息
	 * @param id 主键
	 * @return
	 */
	TypeInfo selectById(String id);
	
}