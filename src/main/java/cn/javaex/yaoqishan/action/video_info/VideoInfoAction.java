package cn.javaex.yaoqishan.action.video_info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.javaex.yaoqishan.constant.ErrorMsg;
import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.service.media_info.MediaInfoService;
import cn.javaex.yaoqishan.service.player_info.PlayerInfoService;
import cn.javaex.yaoqishan.service.video_info.VideoInfoService;
import cn.javaex.yaoqishan.view.PlayerInfo;
import cn.javaex.yaoqishan.view.Result;
import cn.javaex.yaoqishan.view.VideoInfo;

@Controller
@RequestMapping("video_info")
public class VideoInfoAction {

	@Autowired
	private VideoInfoService videoInfoService;
	@Autowired
	private MediaInfoService mediaInfoService;
	@Autowired
	private PlayerInfoService playerInfoService;
	
	/**
	 * 根据媒体信息主键，查询该视频下的所有播放集数
	 * @param map
	 * @param mediaId 媒体信息主键
	 * @return
	 */
	@RequestMapping("list.action")
	public String list(ModelMap map,
			@RequestParam(value="mediaId") String mediaId,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue="10") int pageSize) {
		
		// pageHelper分页插件
		// 只需要在查询之前调用，传入当前页码，以及每一页显示多少条
		PageHelper.startPage(pageNum, pageSize);
		List<VideoInfo> list = videoInfoService.listByMediaIdDesc(mediaId);
		PageInfo<VideoInfo> pageInfo = new PageInfo<VideoInfo>(list);
		map.put("pageInfo", pageInfo);
		
		// 根据媒体信息主键，查询该媒体标题
		String biaoti = mediaInfoService.selectBiaotiById(mediaId);
		map.put("biaoti", biaoti);
		
		map.put("mediaId", mediaId);
		
		return "admin/video_info/list";
	}
	
	/**
	 * 视频播放地址编辑
	 */
	@RequestMapping("edit.action")
	public String edit(ModelMap map,
			@RequestParam(required=false, value="videoId") String videoId,
			@RequestParam(value="mediaId") String mediaId) {
		
		if (!StringUtils.isEmpty(videoId)) {
			VideoInfo videoInfo = videoInfoService.selectById(videoId);
			map.put("videoInfo", videoInfo);
		}
		
		// 根据媒体信息主键，查询该视频名称
		String biaoti = mediaInfoService.selectBiaotiById(mediaId);
		map.put("biaoti", biaoti);
		
		// 查询播放器列表
		List<PlayerInfo> playerList = playerInfoService.list();
		map.put("playerList", playerList);
		
		map.put("videoId", videoId);
		map.put("mediaId", mediaId);
		
		return "admin/video_info/edit";
	}
	
	/**
	 * 播放视频
	 */
	@RequestMapping("play_video.action")
	public String playVideo(ModelMap map,
			@RequestParam(required=false, value="videoId") String videoId) {
		
		String videoPlay = videoInfoService.selectVideoPlayById(videoId);
		map.put("videoPlay", videoPlay);
		
		return "admin/video_info/video";
	}
	
	/**
	 * 视频播放地址保存
	 * @return
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(VideoInfo videoInfo) {
		
		videoInfoService.save(videoInfo);
		return Result.success();
	}
	
	/**
	 * 更新统一封面
	 * @param mediaId 媒体信息主键
	 * @param imgUrl 图片地址
	 * @return
	 * @throws QingException
	 */
	@RequestMapping("update_image.json")
	@ResponseBody
	public Result updateImage(
			@RequestParam(value="mediaId") String mediaId,
			@RequestParam(value="imgUrl") String imgUrl) throws QingException {
		
		if (StringUtils.isEmpty(mediaId) || StringUtils.isEmpty(imgUrl)) {
			throw new QingException(ErrorMsg.ERROR_600002);
		}
		videoInfoService.updateImage(mediaId, imgUrl);
		
		return Result.success();
	}
	
	/**
	 * 更新统一权限值
	 * @param mediaId 媒体信息主键
	 * @param power 权限值
	 * @return
	 * @throws QingException
	 */
	@RequestMapping("update_power.json")
	@ResponseBody
	public Result updatePower(
			@RequestParam(value="mediaId") String mediaId,
			@RequestParam(value="power") String power) throws QingException {
		
		if (StringUtils.isEmpty(power) || StringUtils.isEmpty(power)) {
			throw new QingException(ErrorMsg.ERROR_600006);
		}
		videoInfoService.updatePower(mediaId, power);
		
		return Result.success();
	}
	
	/**
	 * 批量更新排序
	 * @param videoIdArr 主键数组
	 * @param sortArr 排序数组
	 */
	@RequestMapping("update_sort.json")
	@ResponseBody
	public Result updateSort(
			@RequestParam(value="videoIdArr") String[] videoIdArr,
			@RequestParam(value="sortArr") String[] sortArr) {
		
		videoInfoService.updateSort(videoIdArr, sortArr);

		return Result.success();
	}
	
	/**
	 * 批量更新视频状态
	 * @param videoIdArr 主键数组
	 * @param status 状态
	 * @return
	 */
	@RequestMapping("batch_update_status.json")
	@ResponseBody
	public Result batchUpdateStatus(
			@RequestParam(value="videoIdArr") String[] videoIdArr,
			@RequestParam(value="status") String status) {
		
		videoInfoService.batchUpdateStatus(videoIdArr, status);

		return Result.success();
	}
	
	/**
	 * 批量删除视频
	 * @param videoIdArr 主键数组
	 * @return
	 * @throws QingException
	 */
	@RequestMapping("batch_delete.json")
	@ResponseBody
	public Result batchDelete(
			@RequestParam(value="videoIdArr") String[] videoIdArr) throws QingException {
		
		videoInfoService.batchDelete(videoIdArr);

		return Result.success();
	}
	
}
