package cn.javaex.yaoqishan.action.star_info;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.javaex.yaoqishan.constant.FixedOption.Blood;
import cn.javaex.yaoqishan.constant.FixedOption.Constellation;
import cn.javaex.yaoqishan.service.star_info.StarInfoService;
import cn.javaex.yaoqishan.view.Result;
import cn.javaex.yaoqishan.view.StarInfo;

@Controller
@RequestMapping("star_info")
public class StarInfoAction {

	@Autowired
	private StarInfoService starInfoService;
	
	/**
	 * 查询明星列表
	 */
	@RequestMapping("list.action")
	public String list(ModelMap map) {
		
		List<StarInfo> list = starInfoService.list();
		map.put("list", list);

		return "admin/star_info/list";
	}
	
	/**
	 * 明星信息编辑
	 * @return
	 */
	@RequestMapping("edit.action")
	public String edit(ModelMap map,
			@RequestParam(required = false, value = "id") String id) {
		
		// 查询单个明星的信息
		if (!StringUtils.isEmpty(id)) {
			StarInfo starInfo = starInfoService.selectById(id);
			map.put("starInfo", starInfo);
		}
		
		// 血型选项
		List<Map<String, String>> bloodList = new ArrayList<Map<String, String>>();
		Map<String, String> bloodMap = null;
		for (Blood blood : Blood.values()) {
			bloodMap = new HashMap<String, String>();
			bloodMap.put("value", blood.getValue());
			bloodMap.put("name", blood.getName());
			bloodList.add(bloodMap);
		}
		map.put("bloodList", bloodList);
		
		// 星座选项
		List<Map<String, String>> constellationList = new ArrayList<Map<String, String>>();
		Map<String, String> constellationMap = null;
		for (Constellation constellation : Constellation.values()) {
			constellationMap = new HashMap<String, String>();
			constellationMap.put("value", constellation.getValue());
			constellationMap.put("name", constellation.getName());
			constellationList.add(constellationMap);
		}
		map.put("constellationList", constellationList);
		
		map.put("id", id);
		return "admin/star_info/edit";
	}
	
	/**
	 * 明星信息保存
	 * @return
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(StarInfo starInfo) {
		
		starInfoService.save(starInfo);
		return Result.success();
	}
}
