package cn.javaex.yaoqishan.action.type_info;

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

import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.service.template_info.TemplateInfoService;
import cn.javaex.yaoqishan.service.type_info.TypeInfoService;
import cn.javaex.yaoqishan.view.Result;
import cn.javaex.yaoqishan.view.TypeInfo;

@Controller
@RequestMapping("type_info")
public class TypeInfoAction {

	@Autowired
	private TypeInfoService typeInfoService;
	@Autowired
	private TemplateInfoService templateInfoService;
	
	/**
	 * 查询所有分类
	 */
	@RequestMapping("list.action")
	public String list(ModelMap map, HttpServletRequest request) {
		
		// 获取所选模板
		String templatePC = templateInfoService.selectNameByType("pc");
		
		// 详情页模板选项：profile
		Map<String, String> profileMap = null;
		List<Map<String, String>> profileList = new ArrayList<Map<String, String>>();
		String profilePath = request.getSession().getServletContext().getRealPath("/WEB-INF/page/portal/pc/template/"+templatePC+"/profile");
		File profilefile = new File(profilePath);
		// 获得该文件夹内的所有文件名
		File[] profileArr = profilefile.listFiles();
		if (profileArr!=null && profileArr.length>0) {
			for (int i=0; i<profileArr.length; i++) {
				profileMap = new HashMap<String, String>();
				// 获取文件夹名（即模板名称）
				String templateName = profileArr[i].getName().replace(".jsp", "");

				profileMap.put("value", templateName);
				profileMap.put("name", templateName);
				profileList.add(profileMap);
			}
		}
		map.put("profileList", profileList);
		
		// 播放页模板选项：play
		Map<String, String> playMap = null;
		List<Map<String, String>> playList = new ArrayList<Map<String, String>>();
		String playPath = request.getSession().getServletContext().getRealPath("/WEB-INF/page/portal/pc/template/"+templatePC+"/play");
		File playfile = new File(playPath);
		// 获得该文件夹内的所有文件名
		File[] playArr = playfile.listFiles();
		if (playArr!=null && playArr.length>0) {
			for (int i=0; i<playArr.length; i++) {
				playMap = new HashMap<String, String>();
				// 获取文件夹名（即模板名称）
				String templateName = playArr[i].getName().replace(".jsp", "");

				playMap.put("value", templateName);
				playMap.put("name", templateName);
				playList.add(playMap);
			}
		}
		map.put("playList", playList);

		// 分类列表
		List<TypeInfo> list = typeInfoService.list();
		map.put("list", list);
		
		return "admin/type_info/list";
	}
	
	/**
	 * 保存分类
	 * @param idArr 分类主键数组
	 * @param sortArr 分类排序数组
	 * @param nameArr 分类名称数组
	 * @param profileArr 详情页模板数组
	 * @param playArr 播放页模板数组
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(ModelMap map,
			@RequestParam(value="idArr") String[] idArr,
			@RequestParam(value="sortArr") String[] sortArr,
			@RequestParam(value="nameArr") String[] nameArr,
			@RequestParam(value="profileArr") String[] profileArr,
			@RequestParam(value="playArr") String[] playArr) {
		
		List<TypeInfo> typeInfoList = new ArrayList<TypeInfo>();
		
		// 判断是否已有既存数据
		if (idArr.length==0) {
			// 全是新增
			// 遍历sortArr数组
			for (int i=0; i<sortArr.length; i++) {
				TypeInfo typeInfo = new TypeInfo();
				typeInfo.setSort(sortArr[i]);
				typeInfo.setName(nameArr[i]);
				typeInfo.setProfileTemplate(profileArr[i]);
				typeInfo.setPlayTemplate(playArr[i]);
				
				typeInfoList.add(typeInfo);
			}
		} else {
			// 遍历idArr数组
			for (int i=0; i<idArr.length; i++) {
				TypeInfo typeInfo = new TypeInfo();
				typeInfo.setId(idArr[i]);
				typeInfo.setSort(sortArr[i]);
				typeInfo.setName(nameArr[i]);
				typeInfo.setProfileTemplate(profileArr[i]);
				typeInfo.setPlayTemplate(playArr[i]);
				
				typeInfoList.add(typeInfo);
			}
		}
		
		typeInfoService.save(typeInfoList);

		return Result.success();
	}
	
	/**
	 * 删除
	 * @param idArr 分类主键数组
	 * @throws QingException 
	 */
	@RequestMapping("delete.json")
	@ResponseBody
	public Result delete(ModelMap map, 
			@RequestParam(value="idArr") String[] idArr) throws QingException {
		
		typeInfoService.delete(idArr);
		return Result.success();
	}
}
