package cn.javaex.yaoqishan.action.slide_info;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.javaex.yaoqishan.service.slide_info.SlideInfoService;
import cn.javaex.yaoqishan.view.Result;
import cn.javaex.yaoqishan.view.SlideInfo;

@Controller
@RequestMapping("slide_info")
public class SlideInfoAction {

	@Autowired
	private SlideInfoService slideProfileInfoService;

	/**
	 * 根据幻灯片主键，查询所有幻灯片数据
	 * @param map
	 * @param apiId 接口表的主键
	 * @return
	 */
	@RequestMapping("list.action")
	public String list(ModelMap map,
			@RequestParam(value="apiId") String apiId,
			@RequestParam(value="apiName") String apiName) {
		
		List<SlideInfo> list = slideProfileInfoService.listByApiId(apiId);
		map.put("list", list);
		
		map.put("apiId", apiId);
		map.put("apiName", apiName);
		
		return "admin/slide_info/list";
	}
	
	/**
	 * 保存幻灯片数据
	 * @param apiId 接口主键
	 * @param idArr 幻灯片主键数组
	 * @param sortArr 幻灯片排序数组
	 * @param titleArr 幻灯片标题数组
	 * @param summaryArr 幻灯片看点数组
	 * @param imageArr 幻灯片大图数组
	 * @param thumbnailArr 幻灯片小图数组
	 * @param urlArr 幻灯片链接数组
	 * @return
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(
			@RequestParam(value="apiId") String apiId,
			@RequestParam(value="idArr") String[] idArr,
			@RequestParam(value="sortArr") String[] sortArr,
			@RequestParam(value="titleArr") String[] titleArr,
			@RequestParam(value="summaryArr") String[] summaryArr,
			@RequestParam(value="imageArr") String[] imageArr,
			@RequestParam(value="thumbnailArr") String[] thumbnailArr,
			@RequestParam(value="urlArr") String[] urlArr) {
		
		List<SlideInfo> slideProfileInfoList = new ArrayList<SlideInfo>();
		
		// 判断是否已有既存数据
		if (idArr.length==0) {
			// 全是新增
			// 遍历sortArr数组
			for (int i=0; i<sortArr.length; i++) {
				SlideInfo slideProfileInfo = new SlideInfo();
				slideProfileInfo.setApiId(apiId);
				slideProfileInfo.setSort(sortArr[i]);
				slideProfileInfo.setTitle(titleArr[i]);
				slideProfileInfo.setSummary(summaryArr[i]);
				slideProfileInfo.setImage(imageArr[i]);
				slideProfileInfo.setThumbnail(thumbnailArr[i]);
				slideProfileInfo.setUrl(urlArr[i]);
				
				slideProfileInfoList.add(slideProfileInfo);
			}
		} else {
			// 遍历idArr数组
			for (int i=0; i<idArr.length; i++) {
				SlideInfo slideProfileInfo = new SlideInfo();
				slideProfileInfo.setId(idArr[i]);
				slideProfileInfo.setApiId(apiId);
				slideProfileInfo.setSort(sortArr[i]);
				slideProfileInfo.setTitle(titleArr[i]);
				slideProfileInfo.setSummary(summaryArr[i]);
				slideProfileInfo.setImage(imageArr[i]);
				slideProfileInfo.setThumbnail(thumbnailArr[i]);
				slideProfileInfo.setUrl(urlArr[i]);
				
				slideProfileInfoList.add(slideProfileInfo);
			}
		}
		
		slideProfileInfoService.save(slideProfileInfoList);
		
		return Result.success();
	}
	
	/**
	 * 删除
	 * @param idArr 幻灯片主键数组
	 */
	@RequestMapping("delete.json")
	@ResponseBody
	public Result delete(@RequestParam(value="idArr") String[] idArr) {
		
		slideProfileInfoService.delete(idArr);
		
		return Result.success();
	}

}
