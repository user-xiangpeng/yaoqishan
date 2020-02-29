package cn.javaex.yaoqishan.action.media_info;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import cn.javaex.yaoqishan.service.field_info.FieldInfoService;
import cn.javaex.yaoqishan.service.media_info.MediaInfoService;
import cn.javaex.yaoqishan.service.tag_info.TagInfoService;
import cn.javaex.yaoqishan.service.type_field.TypeFieldService;
import cn.javaex.yaoqishan.service.type_info.TypeInfoService;
import cn.javaex.yaoqishan.view.FieldInfo;
import cn.javaex.yaoqishan.view.MediaInfo;
import cn.javaex.yaoqishan.view.Result;
import cn.javaex.yaoqishan.view.TypeInfo;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("media_info")
public class MediaInfoAction {

	@Autowired
	private MediaInfoService mediaInfoService;
	@Autowired
	private FieldInfoService fieldInfoService;
	@Autowired
	private TagInfoService tagInfoService;
	@Autowired
	private TypeInfoService typeInfoService;
	@Autowired
	private TypeFieldService typeFieldService;
	
	/**
	 * 查询所有媒体信息（正常）
	 * @param map
	 * @param keyWord 搜索关键字
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	@RequestMapping("list_normal.action")
	public String listNormal(ModelMap map,
			@RequestParam(required=false, value="typeId") String typeId,
			@RequestParam(required=false, value="keyWord") String keyWord,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue="10") int pageSize) {
		
		// 查询分类信息
		List<TypeInfo> typeList = typeInfoService.list();
		map.put("typeList", typeList);
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (!StringUtils.isEmpty(keyWord)) {
			param.put("keyWord", keyWord.trim());
			map.put("keyWord", keyWord);
		}
		param.put("typeId", typeId);
		map.put("typeId", typeId);
		
		param.put("status", "1");
		
		// pageHelper分页插件
		// 只需要在查询之前调用，传入当前页码，以及每一页显示多少条
		PageHelper.startPage(pageNum, pageSize);
		List<MediaInfo> list = mediaInfoService.list(param);
		PageInfo<MediaInfo> pageInfo = new PageInfo<MediaInfo>(list);
		map.put("pageInfo", pageInfo);
		
		return "admin/media_info/list_normal";
	}
	
	/**
	 * 查询所有媒体信息（回收站）
	 * @param map
	 * @param keyWord 搜索关键字
	 * @param pageNum
	 * @param pageSize
	 * @return
	 */
	@RequestMapping("list_recycle.action")
	public String listRecycle(ModelMap map,
			@RequestParam(required=false, value="keyWord") String keyWord,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue="10") int pageSize) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (!StringUtils.isEmpty(keyWord)) {
			param.put("keyWord", keyWord.trim());
			map.put("keyWord", keyWord);
		}
		param.put("status", "0");
		
		// pageHelper分页插件
		// 只需要在查询之前调用，传入当前页码，以及每一页显示多少条
		PageHelper.startPage(pageNum, pageSize);
		List<MediaInfo> list = mediaInfoService.list(param);
		PageInfo<MediaInfo> pageInfo = new PageInfo<MediaInfo>(list);
		map.put("pageInfo", pageInfo);
		
		return "admin/media_info/list_recycle";
	}
	
	/**
	 * 媒体信息编辑
	 * @param map
	 * @param typeId 分类主键
	 * @param mediaId 媒体主键
	 * @return
	 */
	@RequestMapping("edit.action")
	public String edit(ModelMap map,
			@RequestParam(required=false, value="typeId") String typeId,
			@RequestParam(required=false, value="mediaId") String mediaId) {
		
		MediaInfo mediaInfo = mediaInfoService.selectById(mediaId);
		if (mediaInfo!=null) {
			map.put("mediaInfo", mediaInfo);
			
			// 分类id
			typeId = mediaInfo.getTypeId();
			
			// 标签
			if (mediaInfo.getTag()!=null) {
				// 将标签字符串分割成数组形式
				String[] tagIdArr = mediaInfo.getTag().split(",");
				
				// 查询这些标签信息
				List<String> tagList = tagInfoService.listNameByIdArr(tagIdArr);
				if (tagList!=null && tagList.isEmpty()==false) {
					// 将标签集合转为json格式，方便js调用
					JSONArray jsonTagList = JSONArray.fromObject(tagList);
					map.put("jsonTagList", jsonTagList);
				}
			}
		}

		// 查询该分类下的字段列表
		List<FieldInfo> fieldInfoList = fieldInfoService.listByTypeId(typeId);
		map.put("fieldInfoList", fieldInfoList);
		
		map.put("typeId", typeId);
		map.put("mediaId", mediaId);
		
		return "admin/media_info/edit";
	}
	
	/**
	 * 媒体信息保存
	 * @return
	 * @throws QingException
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(HttpServletRequest request) throws QingException {
		Map<String, Object> param = new HashMap<String, Object>();

		String typeId = request.getParameter("type_id");
		// 查询字段列表
		List<FieldInfo> fieldInfoList = fieldInfoService.listByTypeId(typeId);
		if (fieldInfoList!=null && fieldInfoList.isEmpty()==false) {
			for (FieldInfo fieldInfo : fieldInfoList) {
				String name = fieldInfo.getName();		// 字段中文名
				String varName = fieldInfo.getVarName();// 字段变量名
				
				// 判断是否是复选框
				if ("checkbox".equals(fieldInfo.getInputType())) {
					String[] arr = request.getParameterValues(varName);
					if (arr==null || arr.length==0) {
						// 判断该字段是否是必填项
						String isRequired = typeFieldService.selectIsRequired(typeId, varName);
						if ("1".equals(isRequired)) {
							throw new QingException(ErrorMsg.ERROR_300002 + "：" + name);
						}
						param.put(varName, arr);
					} else {
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
					}
				} else {
					String value = request.getParameter(varName);
					if (value==null || "".equals(value)) {
						// 判断该字段是否是必填项
						String isRequired = typeFieldService.selectIsRequired(typeId, varName);
						if ("1".equals(isRequired)) {
							throw new QingException(ErrorMsg.ERROR_300002 + "：" + name);
						}
					}
					param.put(varName, value);
				}
			}
			
			// 分类
			param.put("type_id", typeId);
			// 主键
			param.put("media_id", request.getParameter("media_id"));
			// 海报
			param.put("haibao", request.getParameter("haibao"));
			// 大封面
			param.put("dafengmian", request.getParameter("dafengmian"));
			// 小封面
			param.put("fengmian", request.getParameter("fengmian"));
			// 标题
			String biaoti = request.getParameter("biaoti");
			if (!StringUtils.isEmpty(biaoti)) {
				biaoti = biaoti.replace("'", "");
			}
			param.put("biaoti", biaoti);
			// 是否允许标题重复
			if (request.getParameter("repeat")==null) {
				param.put("repeat", "0");
			} else {
				param.put("repeat", "1");
			}
			// 别名
			String bieming = request.getParameter("bieming");
			if (!StringUtils.isEmpty(bieming)) {
				bieming = bieming.replace("'", "");
			}
			param.put("bieming", bieming);
			// 简介
			String jianjie = request.getParameter("jianjie");
			if (!StringUtils.isEmpty(jianjie)) {
				jianjie = jianjie.replace("'", "");
			}
			param.put("jianjie", jianjie);
			// 标签
			String tag = request.getParameter("tag");
			if (!StringUtils.isEmpty(tag)) {
				tag = tag.replace("'", "");
			}
			param.put("tag", tag);
		}
		
		mediaInfoService.save(param);
		
		return Result.success();
	}
	
	/**
	 * 根据主键，获取媒体信息
	 * @param mediaId 媒体信息的主键
	 * @return
	 */
	@RequestMapping("get_media_info.json")
	@ResponseBody
	public Result getMediaInfo(
			@RequestParam(value="mediaId") String mediaId,
			@RequestParam(value="typeId") String typeId) {
		
		Map<String, Object> mediaInfo = mediaInfoService.selectByIdAndTypeId(mediaId, typeId);
		
		return Result.success().add("mediaInfo", mediaInfo);
	}
	
	/**
	 * 批量更新媒体的状态
	 * @param mediaIdArr 主键数组
	 * @param status 状态
	 * @return
	 */
	@RequestMapping("batch_update_status.json")
	@ResponseBody
	public Result batchUpdateStatus(
			@RequestParam(value = "mediaIdArr") String[] mediaIdArr,
			@RequestParam(value = "status") String status) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("mediaIdArr", mediaIdArr);
		param.put("status", status);
		
		mediaInfoService.batchUpdateStatus(param);
		
		return Result.success();
	}
	
	/**
	 * 批量移动到分类
	 * @param mediaIdArr 主键数组
	 * @param typeId 分类id
	 * @return
	 */
	@RequestMapping("batch_change_type.json")
	@ResponseBody
	public Result batchUpdateType(
			@RequestParam(value = "mediaIdArr") String[] mediaIdArr,
			@RequestParam(value = "typeId") String typeId) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("mediaIdArr", mediaIdArr);
		param.put("typeId", typeId);
		
		mediaInfoService.batchUpdateType(param);
		
		return Result.success();
	}
	
	/**
	 * 批量删除
	 * @param mediaIdArr 主键数组
	 * @return
	 */
	@RequestMapping("batch_delete.json")
	@ResponseBody
	public Result batchDelete(
			@RequestParam(value = "mediaIdArr") String[] mediaIdArr) {
		
		mediaInfoService.batchDelete(mediaIdArr);
		
		return Result.success();
	}
}
