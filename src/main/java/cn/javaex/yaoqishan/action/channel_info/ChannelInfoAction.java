package cn.javaex.yaoqishan.action.channel_info;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.javaex.yaoqishan.service.channel_info.ChannelInfoService;
import cn.javaex.yaoqishan.service.template_info.TemplateInfoService;
import cn.javaex.yaoqishan.view.ChannelInfo;
import cn.javaex.yaoqishan.view.Result;

@Controller
@RequestMapping("channel_info")
public class ChannelInfoAction {

	@Autowired
	private ChannelInfoService channelInfoService;
	@Autowired
	private TemplateInfoService templateInfoService;
	
	/**
	 * 查询所有频道
	 */
	@RequestMapping("list.action")
	public String list(ModelMap map) {
		
		List<ChannelInfo> list = channelInfoService.list();
		map.put("list", list);
		
		return "admin/channel_info/list";
	}
	
	/**
	 * 编辑频道
	 */
	@RequestMapping("edit.action")
	public String edit(ModelMap map,
			HttpServletRequest request,
			@RequestParam(required=false, value="id") String id) {
		
		// 获取所选模板
		String templatePC = templateInfoService.selectNameByType("pc");
		
		Map<String, String> templateMap = null;
		List<Map<String, String>> templateList = new ArrayList<Map<String, String>>();
		
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF/page/portal/pc/template/"+templatePC+"/channel");
		
		File file = new File(path);
		// 获得该文件夹内的所有文件名
		File[] arr = file.listFiles();
		if (arr!=null && arr.length>0) {
			for (int i=0; i<arr.length; i++) {
				templateMap = new HashMap<String, String>();
				// 获取文件夹名（即模板名称）
				String templateName = arr[i].getName().replace(".jsp", "");

				templateMap.put("value", templateName);
				templateMap.put("name", templateName);
				templateList.add(templateMap);
			}
		}
		map.put("templateList", templateList);
		
		ChannelInfo channelInfo = channelInfoService.selectById(id);
		map.put("channelInfo", channelInfo);
		
		map.put("id", id);
		
		return "admin/channel_info/edit";
	}
	
	/**
	 * 保存频道内容
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(ChannelInfo channelInfo) {
		
		channelInfoService.save(channelInfo);
		
		return Result.success();
	}
	
	/**
	 * 删除频道
	 */
	@RequestMapping("delete.json")
	@ResponseBody
	public Result delete(
			@RequestParam(required=false, value="id") String id) {
		
		channelInfoService.delete(id);
		
		return Result.success();
	}
}
