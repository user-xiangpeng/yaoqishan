package cn.javaex.yaoqishan.dao.tag_info;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.javaex.yaoqishan.view.TagInfo;

public interface ITagInfoDAO {

	/**
	 * 根据标签名称数组，查询对应的id集合，并按从小到大排序
	 * @param nameArr 标签名称数组
	 * @return
	 */
	List<String> listIdByNameArr(@Param("nameArr") String[] nameArr);

	/**
	 * 根据标签中文名称，查询标签是否已存在
	 * @param name 标签中文名称
	 * @return
	 */
	int countByName(String name);

	/**
	 * 插入新标签
	 * @param tagInfo
	 */
	int insert(TagInfo tagInfo);

	/**
	 * 根据主键数组，查询名称集合
	 * @param idArr 主键数组
	 * @return
	 */
	List<String> listNameByIdArr(@Param("idArr") String[] idArr);

	
}