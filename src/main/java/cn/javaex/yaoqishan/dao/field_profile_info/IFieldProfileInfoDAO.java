package cn.javaex.yaoqishan.dao.field_profile_info;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.javaex.yaoqishan.view.FieldProfileInfo;

public interface IFieldProfileInfoDAO {

	/**
	 * 根据字段主键查询字段详情列表
	 * @param fieldId 字段主键
	 * @return
	 */
	List<FieldProfileInfo> listByFieldId(String fieldId);

	/**
	 * 插入一条新数据
	 * @param fieldProfileInfo
	 * @return
	 */
	int insert(FieldProfileInfo fieldProfileInfo);

	/**
	 * 更新一条新数据
	 * @param fieldProfileInfo
	 * @return
	 */
	int update(FieldProfileInfo fieldProfileInfo);

	/**
	 * 批量删除内容
	 * @param idArr 主键数组
	 * @return
	 */
	int delete(@Param("idArr") String[] idArr);

	/**
	 * 根据主键，查询对应的文本
	 * @param id 主键
	 * @return
	 */
	String selectById(String id);

	/**
	 * 根据主键数组，查询对应的文本list
	 * @param idArr
	 * @return
	 */
	List<String> selectByIdArr(@Param("idArr") String[] idArr);
}