package cn.javaex.yaoqishan.dao.media_info;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import cn.javaex.yaoqishan.view.MediaInfo;

public interface IMediaInfoDAO {

	/**
	 * 查询媒体列表
	 * @param param
	 * @return
	 */
	List<MediaInfo> list(Map<String, Object> param);
	
	/**
	 * 插入一条媒体信息
	 * @param alterSql
	 * @return
	 */
	int insert(@Param("alterSql") String alterSql);

	/**
	 * 更新一条媒体信息
	 * @param alterSql
	 * @return
	 */
	int update(@Param("alterSql") String alterSql);
	
	/**
	 * 根据主键查询媒体信息
	 * @param mediaId
	 * @return
	 */
	MediaInfo selectById(String mediaId);

	/**
	 * 根据主键，查询该视频名称
	 * @param mediaId
	 * @return
	 */
	String selectBiaotiById(String mediaId);

	/**
	 * 根据主键，获取媒体信息
	 * @param mediaId 媒体信息的主键
	 * @return
	 */
	Map<String, Object> selectByMediaId(@Param("mediaId") String mediaId);

	/**
	 * 根据关键词，查询符合条件的媒体信息，获取其主键（这里只取10条记录）
	 * @param keyWord 关键词
	 * @return
	 */
	List<String> searchIdByKeyWord(@Param("keyWord") String keyWord);

	/**
	 * 根据筛选结果，查询媒体列表
	 * @param selectSql
	 * @return
	 */
	List<Map<String, Object>> listByFilter(@Param("selectSql") String selectSql);

	/**
	 * 更新对应的媒体的时间、状态等
	 * @param mediaInfo
	 * @return
	 */
	int updateMedia(MediaInfo mediaInfo);

	/**
	 * 查询标题对应的媒体的数量
	 * @param biaoti 标题
	 * @param mediaId 主键
	 * @return
	 */
	int countByBiaoti(@Param("biaoti") String biaoti, @Param("mediaId") String mediaId);

	/**
	 * 批量更新媒体
	 * @param param
	 */
	int batchUpdate(Map<String, Object> param);

	/**
	 * 向媒体表中添加字段
	 * @param alterSql
	 */
	void alter(@Param("alterSql") String alterSql);

	/**
	 * 查询媒体信息，返回map
	 * @param selectSql
	 * @return
	 */
	Map<String, Object> selectSqlById(@Param("selectSql") String selectSql);

	/**
	 * 根据接口自定义查询数据
	 * @param selectSql
	 * @return
	 */
	List<Map<String, Object>> selectSqlByApi(@Param("selectSql") String selectSql);

	/**
	 * 批量删除
	 * @param mediaIdArr 主键数组
	 */
	int batchDelete(@Param("mediaIdArr") String[] mediaIdArr);

}