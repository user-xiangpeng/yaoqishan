package cn.javaex.yaoqishan.service.history_info;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.javaex.yaoqishan.dao.history_info.IHistoryInfoDAO;
import cn.javaex.yaoqishan.view.HistoryInfo;

@Service("HistoryInfoService")
public class HistoryInfoService {
	@Autowired
	private IHistoryInfoDAO iHistoryInfoDAO;

	/**
	 * 保存用户的播放记录
	 * @param historyInfo
	 */
	public void save(HistoryInfo historyInfo) {
		// 1.0 删除该记录
		iHistoryInfoDAO.delete(historyInfo);
		
		// 2.0 添加该记录
		historyInfo.setUpdateTime(new Date());
		iHistoryInfoDAO.insert(historyInfo);
	}

	/**
	 * 获取用户最新的5条历史记录
	 * @param userId 用户id
	 * @return
	 */
	public List<Map<String, Object>> listHistory5(String userId) {
		List<Map<String, Object>> list = iHistoryInfoDAO.listHistory5(userId);
		return list;
	}
	
	/**
	 * 获取用户的历史记录列表
	 * @param userId 用户id
	 * @return
	 */
	public List<Map<String, Object>> listHistory(String userId) {
		List<Map<String, Object>> list = iHistoryInfoDAO.listHistory(userId);
		return list;
	}

	/**
	 * 删除历史记录
	 * @param historyInfo
	 */
	public void delete(HistoryInfo historyInfo) {
		iHistoryInfoDAO.delete(historyInfo);
	}

}
