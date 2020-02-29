package cn.javaex.yaoqishan.action.api_info;

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

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.service.api_info.ApiInfoService;
import cn.javaex.yaoqishan.service.field_info.FieldInfoService;
import cn.javaex.yaoqishan.service.field_profile_info.FieldProfileInfoService;
import cn.javaex.yaoqishan.service.tag_info.TagInfoService;
import cn.javaex.yaoqishan.service.type_info.TypeInfoService;
import cn.javaex.yaoqishan.view.ApiInfo;
import cn.javaex.yaoqishan.view.FieldInfo;
import cn.javaex.yaoqishan.view.FieldProfileInfo;
import cn.javaex.yaoqishan.view.Result;
import cn.javaex.yaoqishan.view.TypeInfo;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("api_info")
public class ApiInfoAction {

	@Autowired
	private ApiInfoService apiInfoService;
	@Autowired
	private FieldProfileInfoService fieldProfileInfoService;
	@Autowired
	private TypeInfoService typeInfoService;
	@Autowired
	private FieldInfoService fieldInfoService;
	@Autowired
	private TagInfoService tagInfoService;
	
	/**
	 * 查询所有幻灯片接口
	 */
	@RequestMapping("list_slide.action")
	public String listSlide(ModelMap map) {
		
		List<ApiInfo> list = apiInfoService.listByType("slide");
		map.put("list", list);
		
		return "admin/api_info/list_slide";
	}
	
	/**
	 * 查询所有排行榜接口
	 */
	@RequestMapping("list_rank.action")
	public String listRank(ModelMap map,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue="10") int pageSize) {
		
		// pageHelper分页插件
		// 只需要在查询之前调用，传入当前页码，以及每一页显示多少条
		PageHelper.startPage(pageNum, pageSize);
		List<ApiInfo> list = apiInfoService.listByType("rank");
		PageInfo<ApiInfo> pageInfo = new PageInfo<ApiInfo>(list);
		map.put("pageInfo", pageInfo);
		
		return "admin/api_info/list_rank";
	}
	
	/**
	 * 排行榜接口配置
	 */
	@RequestMapping("rank_edit.action")
	public String rankEdit(ModelMap map,
			@RequestParam(value="id") String id,
			@RequestParam(value="name") String name) {
		
		// 数据来源，分类
		List<TypeInfo> typeList = typeInfoService.list();
		map.put("typeList", typeList);
		
		// 查询排行榜接口配置选项
		Map<String, Object> apiInfo = apiInfoService.selectById(id);
		map.put("apiInfo", apiInfo);
		
		map.put("id", id);
		map.put("name", name);
		
		return "admin/api_info/rank_edit";
	}
	
	/**
	 * 保存排行榜条件设置
	 * @throws QingException 
	 */
	@RequestMapping("rank_save.json")
	@ResponseBody
	public Result rankSave(ApiInfo apiInfo) throws QingException {
		
		apiInfoService.rankSave(apiInfo);
		
		return Result.success();
	}
	
	/**
	 * 查询所有自定义接口
	 */
	@RequestMapping("list_user.action")
	public String listUser(ModelMap map,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue="10") int pageSize) {
		
		// pageHelper分页插件
		// 只需要在查询之前调用，传入当前页码，以及每一页显示多少条
		PageHelper.startPage(pageNum, pageSize);
		List<ApiInfo> list = apiInfoService.listByType("user");
		PageInfo<ApiInfo> pageInfo = new PageInfo<ApiInfo>(list);
		map.put("pageInfo", pageInfo);
		
		return "admin/api_info/list_user";
	}
	
	/**
	 * 用户自定义接口配置
	 */
	@RequestMapping("user_edit.action")
	public String userEdit(ModelMap map,
			@RequestParam(value="id") String id,
			@RequestParam(value="name") String name) {
		
		// 数据来源，分类
		List<TypeInfo> typeList = typeInfoService.list();
		map.put("typeList", typeList);
		
		// 查询该接口的信息
		Map<String, Object> apiInfo = apiInfoService.selectById(id);
		String typeId = "";
		if (apiInfo.get("type_id")==null) {
			// 首次设置条件时，默认查询第一条分类的id
			typeId = typeList.get(0).getId();
		} else {
			typeId = apiInfo.get("type_id").toString();
		}
		
		// 查询单选框字段的变量名
		List<FieldInfo> radioList = fieldInfoService.listRadioByTypeId(typeId);
		map.put("radioList", radioList);
		if (radioList!=null && radioList.isEmpty()==false) {
			for (FieldInfo fieldInfo : radioList) {
				List<FieldProfileInfo> list = fieldProfileInfoService.listByFieldId(fieldInfo.getId());
				fieldInfo.setFieldProfileInfoList(list);
			}
		}
		
		// 标签
		if (apiInfo.get("tag")!=null) {
			// 将标签字符串分割成数组形式
			String[] tagIdArr = apiInfo.get("tag").toString().split(",");
			
			// 查询这些标签信息
			List<String> tagList = tagInfoService.listNameByIdArr(tagIdArr);
			if (tagList!=null && tagList.isEmpty()==false) {
				// 将标签集合转为json格式，方便js调用
				JSONArray jsonTagList = JSONArray.fromObject(tagList);
				map.put("jsonTagList", jsonTagList);
			}
		}
		
		map.put("id", id);
		map.put("name", name);
		map.put("apiInfo", apiInfo);
		
		return "admin/api_info/user_edit";
	}
	
	/**
	 * 保存自定义数据条件设置
	 * @throws QingException 
	 */
	@RequestMapping("user_save.json")
	@ResponseBody
	public Result userSave(HttpServletRequest request) throws QingException {
		Map<String, Object> param = new HashMap<String, Object>();
		
		// 该接口需要用到哪些字段
		String field = "";
		
		String id = request.getParameter("id");
		param.put("id", id);
		
		// 视频来源：电影、动漫等分类id
		String typeId = request.getParameter("type_id");
		param.put("type_id", typeId);
		field += "type_id";
		
		// 查询单选框字段的变量名
		List<FieldInfo> radioList = fieldInfoService.listRadio();
		if (radioList!=null && radioList.isEmpty()==false) {
			for (FieldInfo fieldInfo : radioList) {
				String varName = fieldInfo.getVarName();// 字段变量名
				
				String[] arr = request.getParameterValues(varName);
				if (arr!=null && arr.length>0) {
					// 将数组转为 xx,xx 形式的字符串（因为StringUtils引了别的包，不支持StringUtils.join(arr, ",");，所以这里我们手写）
					String str = "";
					for (int i=0; i<arr.length; i++) {
						if (i==0) {
							str = arr[i];
						} else {
							str = str + "," + arr[i];
						}
					}
					param.put(varName, str);
					field += "," + varName;
				}
			}
		}
		
		param.put("field", field);
		param.put("num", request.getParameter("num"));
		param.put("tag", request.getParameter("tag"));
		param.put("select_video", request.getParameter("select_video"));
		param.put("cache_time", request.getParameter("cache_time"));
		
		apiInfoService.userSave(radioList, param);
		
		return Result.success();
	}
	
	/**
	 * 保存接口
	 * @param type 接口类型
	 * @param idArr 接口主键数组
	 * @param sortArr 接口排序数组
	 * @param nameArr 接口名称数组
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(
			@RequestParam(value="type") String type,
			@RequestParam(value="idArr") String[] idArr,
			@RequestParam(value="sortArr") String[] sortArr,
			@RequestParam(value="nameArr") String[] nameArr) {
		
		List<ApiInfo> apiInfoList = new ArrayList<ApiInfo>();
		
		// 判断是否已有既存数据
		if (idArr.length==0) {
			// 全是新增
			// 遍历sortArr数组
			for (int i=0; i<sortArr.length; i++) {
				ApiInfo apiInfo = new ApiInfo();
				apiInfo.setSort(sortArr[i]);
				apiInfo.setName(nameArr[i]);
				apiInfo.setType(type);
				
				apiInfoList.add(apiInfo);
			}
		} else {
			// 遍历idArr数组
			for (int i=0; i<idArr.length; i++) {
				ApiInfo apiInfo = new ApiInfo();
				apiInfo.setId(idArr[i]);
				apiInfo.setSort(sortArr[i]);
				apiInfo.setName(nameArr[i]);
				apiInfo.setType(type);
				
				apiInfoList.add(apiInfo);
			}
		}
		
		apiInfoService.save(apiInfoList);
		
		return Result.success();
	}
	
	/**
	 * 删除
	 * @param idArr 接口主键数组
	 */
	@RequestMapping("delete.json")
	@ResponseBody
	public Result delete(
			@RequestParam(value="idArr") String[] idArr) {
		
		apiInfoService.delete(idArr);
		
		return Result.success();
	}
	
	/**
	 * 根据主键，获取接口信息
	 * @param id 主键
	 * @return
	 */
	@RequestMapping("get_api_info.json")
	@ResponseBody
	public Result getApiInfo(@RequestParam(value="id") String id) {
		
		Map<String, Object> apiInfo = apiInfoService.selectById(id);
		
		return Result.success().add("apiInfo", apiInfo);
	}
}
