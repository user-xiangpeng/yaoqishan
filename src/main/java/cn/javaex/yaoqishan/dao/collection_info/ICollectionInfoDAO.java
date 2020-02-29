package cn.javaex.yaoqishan.dao.collection_info;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import cn.javaex.yaoqishan.view.CollectionInfo;

public interface ICollectionInfoDAO {

	/**
	 * 判断该视频是否已被用户收藏过了
	 * @param mediaId 媒体主键
	 * @param userId 用户id
	 * @return
	 */
	int countByMediaIdAndUserId(@Param("mediaId") String mediaId, @Param("userId") String userId);
	
	/**
	 * 添加视频收藏
	 * @param collectionInfo
	 * @return
	 */
	int insert(CollectionInfo collectionInfo);

	/**
	 * 删除收藏的视频
	 * @param collectionInfo
	 * @return
	 */
	int delete(CollectionInfo collectionInfo);
	
	/**
	 * 获取用户的视频收藏列表
	 * @param userId 用户id
	 * @return
	 */
	List<Map<String, Object>> listCollection(String userId);

	/**
	 * 删除收藏表中的内容
	 * @param userIdArr 用户id数组
	 * @return
	 */
	int deleteByUserIdArr(@Param("userIdArr") String[] userIdArr);

}