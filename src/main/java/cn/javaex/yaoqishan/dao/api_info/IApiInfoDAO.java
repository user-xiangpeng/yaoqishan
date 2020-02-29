package cn.javaex.yaoqishan.dao.api_info;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import cn.javaex.yaoqishan.view.ApiInfo;

public interface IApiInfoDAO {

	/**
	 * 查询指定类型的接口列表
	 * @param type 接口类型
	 * @return
	 */
	List<ApiInfo> listByType(String type);

	/**
	 * 插入新的接口
	 */
	int insert(ApiInfo apiInfo);
	
	/**
	 * 更新接口
	 */
	int update(ApiInfo apiInfo);

	
	/**
	 * 批量删除接口
	 * @param idArr 主键数组
	 * @return
	 */
	int delete(@Param("idArr") String[] idArr);

	/**
	 * 根据主键，获取接口设置条件
	 * @param id 主键
	 * @return
	 */
	Map<String, Object> selectById(String id);

	/**
	 * 用自定义SQL文更新
	 * @param string
	 */
	int updateSQL(@Param("alterSql") String alterSql);

	/**
	 * 判断字段有没有被接口使用
	 * @param field
	 * @return
	 */
	int countByField(@Param("field") String field);

	/**
	 * 向接口表中添加字段
	 * @param alterSql
	 */
	void alter(@Param("alterSql") String alterSql);

	/**
	 * 保存排行榜条件设置
	 * @param apiInfo
	 * @return
	 */
	int updateRankSet(ApiInfo apiInfo);

}