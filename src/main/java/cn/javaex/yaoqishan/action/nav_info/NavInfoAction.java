package cn.javaex.yaoqishan.action.nav_info;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.javaex.yaoqishan.service.nav_info.NavInfoService;
import cn.javaex.yaoqishan.view.NavInfo;
import cn.javaex.yaoqishan.view.Result;

@Controller
@RequestMapping("nav_info")
public class NavInfoAction {

	@Autowired
	private NavInfoService navInfoService;
	
	/**
	 * 查询所有导航
	 */
	@RequestMapping("list.action")
	public String list(ModelMap map) {
		
		List<NavInfo> list = navInfoService.list();
		map.put("list", list);
		
		return "admin/nav_info/list";
	}
	
	/**
	 * 保存导航
	 * @param idArr 导航主键数组
	 * @param sortArr 导航排序数组
	 * @param nameArr 导航名称数组
	 * @param powerArr 导航权限值数组
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(
			@RequestParam(value="idArr") String[] idArr,
			@RequestParam(value="sortArr") String[] sortArr,
			@RequestParam(value="nameArr") String[] nameArr,
			@RequestParam(value="linkArr") String[] linkArr,
			@RequestParam(value="isIndexArr") String[] isIndexArr,
			@RequestParam(value="isUseArr") String[] isUseArr) {
		
		List<NavInfo> navInfoList = new ArrayList<NavInfo>();
		
		// 遍历idArr数组
		for (int i=0; i<idArr.length; i++) {
			NavInfo navInfo = new NavInfo();
			navInfo.setId(idArr[i]);
			navInfo.setSort(sortArr[i]);
			navInfo.setName(nameArr[i]);
			navInfo.setLink(linkArr[i]);
			try {
				navInfo.setIsIndex(isIndexArr[i]);
			} catch (Exception e) {
				navInfo.setIsIndex("0");
			}
			try {
				navInfo.setIsUse(isUseArr[i]);
			} catch (Exception e) {
				navInfo.setIsUse("0");
			}
			
			navInfoList.add(navInfo);
		}
		
		navInfoService.save(navInfoList);

		return Result.success();
	}
	
	/**
	 * 删除
	 * @param idArr 导航主键数组
	 */
	@RequestMapping("delete.json")
	@ResponseBody
	public Result delete(ModelMap map, 
			@RequestParam(value="idArr") String[] idArr) {
		
		navInfoService.delete(idArr);
		return Result.success();
	}
}
