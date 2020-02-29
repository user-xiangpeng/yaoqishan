package cn.javaex.yaoqishan.service.collection_info;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.javaex.yaoqishan.dao.collection_info.ICollectionInfoDAO;
import cn.javaex.yaoqishan.dao.video_info.IVideoInfoDAO;
import cn.javaex.yaoqishan.view.CollectionInfo;
import cn.javaex.yaoqishan.view.VideoInfo;

@Service("CollectionInfoService")
public class CollectionInfoService {
	@Autowired
	private ICollectionInfoDAO iCollectionInfoDAO;
	@Autowired
	private IVideoInfoDAO iVideoInfoDAO;
	
	/**
	 * 收藏或删除指定视频
	 * @param collectionInfo
	 */
	public void save(CollectionInfo collectionInfo) {
		// 判断该视频是否已收藏过了
		int count = iCollectionInfoDAO.countByMediaIdAndUserId(collectionInfo.getMediaId(), collectionInfo.getUserId());
		if (count==0) {
			// 添加收藏
			iCollectionInfoDAO.insert(collectionInfo);
		} else {
			// 删除收藏
			iCollectionInfoDAO.delete(collectionInfo);
		}
	}

	/**
	 * 获取用户的视频收藏列表
	 * @param userId 用户id
	 * @return
	 */
	public List<Map<String, Object>> listCollection(String userId) {
		List<Map<String, Object>> list = iCollectionInfoDAO.listCollection(userId);
		if (list!=null && list.isEmpty()==false) {
			// 查询最新一集
			int len = list.size();
			for (int i=0; i<len; i++) {
				String mediaId = list.get(i).get("media_id").toString();
				VideoInfo videoInfo = iVideoInfoDAO.selectByMediaIdLast(mediaId);
				list.get(i).put("videoInfo", videoInfo);
			}
		}
		return list;
	}

	/**
	 * 判断当前视频是否已被用户收藏过了
	 * @param mediaId 媒体主键
	 * @param userId 用户id
	 * @return
	 */
	public int countByMediaIdAndUserId(String mediaId, String userId) {
		return iCollectionInfoDAO.countByMediaIdAndUserId(mediaId, userId);
	}

	/**
	 * 删除收藏的视频
	 * @param collectionInfo
	 */
	public void delete(CollectionInfo collectionInfo) {
		iCollectionInfoDAO.delete(collectionInfo);
	}

}
