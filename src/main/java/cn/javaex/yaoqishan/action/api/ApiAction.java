package cn.javaex.yaoqishan.action.api;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.service.field_info.FieldInfoService;
import cn.javaex.yaoqishan.service.media_info.MediaInfoService;
import cn.javaex.yaoqishan.service.slide_info.SlideInfoService;
import cn.javaex.yaoqishan.service.video_info.VideoInfoService;
import cn.javaex.yaoqishan.view.FieldInfo;
import cn.javaex.yaoqishan.view.Result;
import cn.javaex.yaoqishan.view.VideoInfo;

@Controller
@RequestMapping("api")
public class ApiAction {

	@Autowired
	private MediaInfoService mediaInfoService;
	@Autowired
	private SlideInfoService slideProfileInfoService;
	@Autowired
	private VideoInfoService videoInfoService;
	@Autowired
	private FieldInfoService fieldInfoService;
	
	/**
	 * 幻灯片数据
	 * @param apiId 接口表主键
	 * @return
	 */
	@RequestMapping("slide.json")
	@ResponseBody
	public Result slide(
			HttpServletRequest request,
			@RequestParam(value="apiId") String apiId) {
		
		List<Map<String, Object>> list = slideProfileInfoService.mapListByApiId(apiId);

		return Result.success().add("list", list);
	}
	
	/**
	 * 获取该视频的信息
	 * @param videoId 视频主键
	 * @return
	 */
	@RequestMapping("get_video_info.json")
	@ResponseBody
	public Result getVideoInfo(
			HttpServletRequest request,
			@RequestParam(value="videoId") String videoId) {
		
		VideoInfo videoInfo = videoInfoService.selectById(videoId);
		
		return Result.success().add("videoInfo", videoInfo);
	}
	
	/**
	 * 获取视频地址
	 * @param mediaId 媒体信息的主键
	 * @return
	 */
	@RequestMapping("get_video_play.json")
	@ResponseBody
	public Result getVideoPlay(
			@RequestParam(value="videoId") String videoId) {
		
		String videoPlay = videoInfoService.selectVideoPlayById(videoId);
		
		return Result.success().add("videoPlay", videoPlay);
	}
	
	/**
	 * 获取该视频的播放列表
	 * @param mediaId 媒体信息的主键
	 * @return
	 */
	@RequestMapping("get_video_list.json")
	@ResponseBody
	public Result getVideoList(
			@RequestParam(value="mediaId") String mediaId) {
		
		List<VideoInfo> list = videoInfoService.listByMediaId(mediaId);
		
		return Result.success().add("list", list);
	}
	
	/**
	 * 根据主键，获取媒体信息
	 * @param mediaId 媒体信息的主键
	 * @return
	 * @throws QingException
	 */
	@RequestMapping("get_media_info.json")
	@ResponseBody
	public Result getMediaInfo(
			@RequestParam(value="mediaId") String mediaId) throws QingException {
		
		Map<String, Object> info = mediaInfoService.selectByMediaId(mediaId);
		
		return Result.success().add("info", info);
	}
	
	/**
	 * 搜索
	 * @param keyWord 关键词
	 * @return
	 * @throws QingException
	 */
	@RequestMapping("search.json")
	@ResponseBody
	public Result search(
			@RequestParam(value="keyWord") String keyWord,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue="10") int pageSize) throws QingException {
		
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		
		// pageHelper分页插件
		// 只需要在查询之前调用，传入当前页码，以及每一页显示多少条
		PageHelper.startPage(pageNum, pageSize);
		List<String> mediaIdList = mediaInfoService.search(keyWord);
		PageInfo<String> pageInfo = new PageInfo<String>(mediaIdList);
		
		if (mediaIdList!=null && mediaIdList.isEmpty()==false) {
			int len = mediaIdList.size();
			for (int i=0; i<len; i++) {
				String mediaId = mediaIdList.get(i);
				// 2.1 获取每一条媒体信息的主要数据
				Map<String, Object> mediaMap = mediaInfoService.selectByMediaId(mediaId);
				
				// 2.2 获取每一条媒体信息下的集数
				List<VideoInfo> videoList = videoInfoService.listByMediaId(mediaId);
				mediaMap.put("videoList", videoList);

				list.add(mediaMap);
			}
		}
		
		return Result.success()
				.add("pageInfo", pageInfo)
				.add("list", list)
				;
	}
	
	/**
	 * 获取分类筛选字段的信息
	 * @param typeId 分类信息的主键
	 * @return
	 */
	@RequestMapping("get_list_field.json")
	@ResponseBody
	public Result getListField(
			@RequestParam(value="typeId") String typeId) {

		List<FieldInfo> list = fieldInfoService.getListField(typeId);
		
		return Result.success().add("list", list);
	}
	
	/**
	 * 根据筛选结果，查询媒体列表
	 * @param filterArr 筛选结果数组
	 * @return
	 */
	@RequestMapping("get_media_list_by_filter.json")
	@ResponseBody
	public Result getMediaLisByFilter(
			@RequestParam(value="typeId") String typeId,
			@RequestParam(required=false, value="filterArr") String[] filterArr,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue="42") int pageSize) {

		// 获取分类筛选字段的信息
		List<FieldInfo> fieldList = fieldInfoService.getListField(typeId);
		
		Map<String, Object> param = new HashMap<String, Object>();
		for (int i=0; i<fieldList.size(); i++) {
			if (!"0".equals(filterArr[i].split("=")[1])) {
				param.put(fieldList.get(i).getVarName(), filterArr[i].split("=")[1]);
			}
		}
		
		// 查询该分类下的所有可筛选字段
		List<FieldInfo> fieldInfoList = fieldInfoService.listCategoryField(typeId);
		
		// pageHelper分页插件
		// 只需要在查询之前调用，传入当前页码，以及每一页显示多少条
		PageHelper.startPage(pageNum, pageSize);
		List<Map<String, Object>> list = mediaInfoService.listByFilter(typeId, param, fieldInfoList);
		PageInfo<Map<String, Object>> pageInfo = new PageInfo<Map<String, Object>>(list);
		
		return Result.success().add("pageInfo", pageInfo);
	}
	
	/**
	 * 根据接口自定义查询排行榜数据
	 * @return
	 * @throws QingException 
	 */
	@RequestMapping("rank.json")
	@ResponseBody
	public Result rank(
			@RequestParam(value="apiId") String apiId) throws QingException {
		
		List<Map<String, Object>> list = mediaInfoService.getRankDataByApiId(apiId);
		
		return Result.success().add("list", list);
	}
	
	/**
	 * 根据接口自定义查询数据
	 * @return
	 * @throws QingException 
	 */
	@RequestMapping("data.json")
	@ResponseBody
	public Result data(
			@RequestParam(value="apiId") String apiId) throws QingException {
		
		List<Map<String, Object>> list = mediaInfoService.getDataByApiId(apiId);
		
		return Result.success().add("list", list);
	}
	
	/**
	 * 获取最新视频
	 * @return
	 * @throws QingException 
	 */
	@RequestMapping("get_new_video_list.json")
	@ResponseBody
	public Result getNewVideoList(
			@RequestParam(value="num") String num) throws QingException {
		
		List<VideoInfo> list = videoInfoService.listNewVideo(num);
		
		return Result.success().add("list", list);
	}
}
