package cn.javaex.yaoqishan.action.web_info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.javaex.yaoqishan.service.web_info.WebInfoService;
import cn.javaex.yaoqishan.view.Result;
import cn.javaex.yaoqishan.view.WebInfo;

@Controller
@RequestMapping("web_info")
public class WebInfoAction {

	@Autowired
	private WebInfoService webInfoService;
	
	/**
	 * 查询站点信息
	 */
	@RequestMapping("edit.action")
	public String edit(ModelMap map) {
		
		WebInfo webInfo = webInfoService.select();
		map.put("webInfo", webInfo);
		
		return "admin/web_info/edit";
	}
	
	/**
	 * 保存站点信息配置
	 * @param webInfo
	 * @return
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(WebInfo webInfo) {
		
		webInfoService.save(webInfo);
		return Result.success();
	}
}
