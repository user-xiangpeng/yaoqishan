package cn.javaex.yaoqishan.service.video_info;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.javaex.yaoqishan.constant.ErrorMsg;
import cn.javaex.yaoqishan.dao.media_info.IMediaInfoDAO;
import cn.javaex.yaoqishan.dao.player_info.IPlayerInfoDAO;
import cn.javaex.yaoqishan.dao.video_info.IVideoInfoDAO;
import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.view.MediaInfo;
import cn.javaex.yaoqishan.view.VideoInfo;

@Service("VideoInfoService")
public class VideoInfoService {
	@Autowired
	private IVideoInfoDAO iVideoInfoDAO;
	@Autowired
	private IPlayerInfoDAO iPlayerInfoDAO;
	@Autowired
	private IMediaInfoDAO iMediaInfoDAO;
	
	/**
	 * 根据媒体信息主键，查询该视频下的所有播放集数，从大到小排序（后台管理专用）
	 * @param mediaId 媒体信息主键
	 * @return
	 */
	public List<VideoInfo> listByMediaIdDesc(String mediaId) {
		return iVideoInfoDAO.listByMediaIdDesc(mediaId);
	}

	/**
	 * 根据媒体信息主键，查询该视频下的所有播放集数，从小到大排序（状态正常的）
	 * @param mediaId 媒体信息主键
	 * @return
	 */
	public List<VideoInfo> listByMediaId(String mediaId) {
		return iVideoInfoDAO.listByMediaId(mediaId);
	}
	
	/**
	 * 根据主键查询信息
	 * @param videoId 主键
	 * @return
	 */
	public VideoInfo selectById(String videoId) {
		return iVideoInfoDAO.selectById(videoId);
	}
	
	/**
	 * 根据主键查询信息（前台播放页面专用）
	 * @param videoId 主键
	 * @return
	 */
	public VideoInfo selectByIdWithPortal(String videoId) {
		// 获取视频信息（前台播放页面专用）
		VideoInfo videoInfo = iVideoInfoDAO.selectByIdWithPortal(videoId);
		if (videoInfo!=null) {
			// 播放总量自增
			int nViewCount = Integer.parseInt(videoInfo.getViewCount());
			nViewCount++;
			
			// 日播放量自增
			int nViewCountDay = Integer.parseInt(videoInfo.getViewCountDay());
			nViewCountDay++;
			
			// 周播放量自增
			int nViewCountWeek = Integer.parseInt(videoInfo.getViewCountWeek());
			nViewCountWeek++;
			
			// 月播放量自增
			int nViewCountMonth = Integer.parseInt(videoInfo.getViewCountMonth());
			nViewCountMonth++;
			
			// 年播放量自增
			int nViewCountYear = Integer.parseInt(videoInfo.getViewCountYear());
			nViewCountYear++;
			
			// 更新播放次数
			VideoInfo videoInfo2 = new VideoInfo();
			videoInfo2.setVideoId(videoInfo.getVideoId());
			videoInfo2.setViewCount(String.valueOf(nViewCount));
			videoInfo2.setViewCountDay(String.valueOf(nViewCountDay));
			videoInfo2.setViewCountWeek(String.valueOf(nViewCountWeek));
			videoInfo2.setViewCountMonth(String.valueOf(nViewCountMonth));
			videoInfo2.setViewCountYear(String.valueOf(nViewCountYear));
			
			iVideoInfoDAO.update(videoInfo2);
		}
		
		return videoInfo;
	}

	/**
	 * 视频播放地址保存
	 * @param VideoInfo
	 */
	public void save(VideoInfo videoInfo) {
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = formatter.format(currentTime);
		
		// 1.0 如果排序次数没填的话，则默认为1
		if (StringUtils.isEmpty(videoInfo.getSort())) {
			videoInfo.setSort("1");
		}
		
		// 2.0 如果播放总量没填的话，则默认为1
		if (StringUtils.isEmpty(videoInfo.getViewCount())) {
			videoInfo.setViewCount("1");
		}
		
		// 3.0 保存视频信息
		// 判断是新增还是更新
		if (StringUtils.isEmpty(videoInfo.getVideoId())) {
			// 新增
			videoInfo.setStatus("1");
			videoInfo.setUpdateTime(now);
			videoInfo.setViewCountDay("0");
			videoInfo.setViewCountWeek("0");
			videoInfo.setViewCountMonth("0");
			videoInfo.setViewCountYear("0");
			iVideoInfoDAO.insert(videoInfo);
		} else {
			// 更新
			iVideoInfoDAO.update(videoInfo);
		}
		
		// 4.0 更新对应的媒体的时间、状态等
		MediaInfo mediaInfo = new MediaInfo();
		mediaInfo.setMediaId(videoInfo.getMediaId());
		mediaInfo.setUpdateTime(currentTime);
		mediaInfo.setHasVideo(1);
		
		iMediaInfoDAO.updateMedia(mediaInfo);
	}

	/**
	 * 更新统一封面
	 * @param mediaId 媒体信息主键
	 * @param image 图片地址
	 */
	public void updateImage(String mediaId, String image) {
		iVideoInfoDAO.updateImage(mediaId, image);
	}

	/**
	 * 批量更新排序
	 * @param videoIdArr 主键数组
	 * @param sortArr 排序数组
	 */
	public void updateSort(String[] videoIdArr, String[] sortArr) {
		for (int i=0; i<videoIdArr.length; i++) {
			VideoInfo videoInfo = new VideoInfo();
			videoInfo.setVideoId(videoIdArr[i]);
			videoInfo.setSort(sortArr[i]);
			
			iVideoInfoDAO.update(videoInfo);
		}
	}

	/**
	 * 批量更新视频状态
	 * @param videoIdArr 主键数组
	 * @param status 状态
	 */
	public void batchUpdateStatus(String[] videoIdArr, String status) {
		iVideoInfoDAO.batchUpdateStatus(videoIdArr, status);
	}

	/**
	 * 批量删除视频
	 * @param videoIdArr 主键数组
	 * @throws QingException
	 */
	public void batchDelete(String[] videoIdArr) throws QingException {
		for (int i=0; i<videoIdArr.length; i++) {
			// 只有已经禁用的视频才可以被删除
			VideoInfo videoInfo = iVideoInfoDAO.selectById(videoIdArr[i]);
			if ("1".equals(videoInfo.getStatus())) {
				throw new QingException(ErrorMsg.ERROR_600005);
			}
		}
		iVideoInfoDAO.batchDelete(videoIdArr);
	}

	/**
	 * 根据视频主键查询视频播放源（电脑端）
	 * @param videoId
	 * @return
	 */
	public String selectVideoPlayById(String videoId) {
		// 1.0 获取视频信息
		VideoInfo videoInfo = iVideoInfoDAO.selectVideoPlayById(videoId);
		
		// 2.0 获取播放器配置参数
		String content = iPlayerInfoDAO.selectContentById(videoInfo.getPlayerId());

		// 3.0 判断视频地址是否存在
		if (StringUtils.isEmpty(content)) {
			content = "";
		} else {
			if (StringUtils.isEmpty(videoInfo.getUrl())) {
				// 3.1 不存在时，不返回播放内容
				content = "";
			} else {
				// 3.2 存在时，替换播放器配置中的变量
				content = content.replace("{url}", videoInfo.getUrl());
			}
		}

		return content;
	}

	/**
	 * 更新统一权限值
	 * @param mediaId
	 * @param power
	 */
	public void updatePower(String mediaId, String power) {
		iVideoInfoDAO.updatePower(mediaId, power);
	}

	/**
	 * 获取最新视频
	 * @param num
	 * @return
	 * @throws QingException
	 */
	public List<VideoInfo> listNewVideo(String count) throws QingException {
		try {
			Integer.parseInt(count);
		} catch (NumberFormatException e) {
			throw new QingException(ErrorMsg.ERROR_700004);
		}
		return iVideoInfoDAO.listNewVideo(count);
	}

	/**
	 * 清空视频点击量
	 * @param videoInfo
	 */
	public void clearViewCount(VideoInfo videoInfo) {
		iVideoInfoDAO.clearViewCount(videoInfo);
	}

}
