package cn.javaex.yaoqishan.action.field_info;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.javaex.yaoqishan.constant.FixedOption.Option;
import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.service.field_info.FieldInfoService;
import cn.javaex.yaoqishan.service.field_profile_info.FieldProfileInfoService;
import cn.javaex.yaoqishan.view.FieldInfo;
import cn.javaex.yaoqishan.view.FieldProfileInfo;
import cn.javaex.yaoqishan.view.Result;

@Controller
@RequestMapping("field_info")
public class FieldInfoAction {

	@Autowired
	private FieldInfoService fieldInfoService;
	@Autowired
	private FieldProfileInfoService fieldProfileInfoService;
	
	/**
	 * 查询所有用户自定义字段
	 */
	@RequestMapping("list.action")
	public String list(ModelMap map,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue="10") int pageSize) {
		
		// pageHelper分页插件
		// 只需要在查询之前调用，传入当前页码，以及每一页显示多少条
		PageHelper.startPage(pageNum, pageSize);
		List<FieldInfo> list = fieldInfoService.list();
		PageInfo<FieldInfo> pageInfo = new PageInfo<FieldInfo>(list);
		map.put("pageInfo", pageInfo);
		
		// 字段类型选项
		List<Map<String, String>> optList = new ArrayList<Map<String, String>>();
		Map<String, String> optMap = null;
		for (Option opt : Option.values()) {
			optMap = new HashMap<String, String>();
			optMap.put("value", opt.getValue());
			optMap.put("name", opt.getName());
			optList.add(optMap);
		}
		map.put("optList", optList);
		
		return "admin/field_info/list";
	}
	
	/**
	 * 保存字段
	 * @param idArr 字段主键数组
	 * @param sortArr 字段排序数组
	 * @param nameArr 字段名称数组
	 * @param varNameArr 变量名称数组
	 * @param inputTypeArr 填写类型数组
	 * @throws QingException
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(
			@RequestParam(value="idArr") String[] idArr,
			@RequestParam(value="sortArr") String[] sortArr,
			@RequestParam(value="nameArr") String[] nameArr,
			@RequestParam(value="varNameArr") String[] varNameArr,
			@RequestParam(value="inputTypeArr") String[] inputTypeArr) throws QingException {
		
		List<FieldInfo> fieldInfoList = new ArrayList<FieldInfo>();
		
		// 判断是否已有既存数据
		if (idArr.length==0) {
			// 全是新增
			// 遍历sortArr数组
			for (int i=0; i<sortArr.length; i++) {
				FieldInfo fieldInfo = new FieldInfo();
				fieldInfo.setSort(sortArr[i]);
				fieldInfo.setName(nameArr[i]);
				fieldInfo.setVarName(varNameArr[i]);
				fieldInfo.setInputType(inputTypeArr[i]);
				// 判断该字段是否可编辑
				if ("radio".equals(inputTypeArr[i]) || "checkbox".equals(inputTypeArr[i]) || "select".equals(inputTypeArr[i])) {
					fieldInfo.setIsAllowEdit("1");
				}
				
				fieldInfoList.add(fieldInfo);
			}
		} else {
			// 遍历idArr数组
			for (int i=0; i<idArr.length; i++) {
				FieldInfo fieldInfo = new FieldInfo();
				fieldInfo.setId(idArr[i]);
				fieldInfo.setSort(sortArr[i]);
				fieldInfo.setName(nameArr[i]);
				fieldInfo.setVarName(varNameArr[i]);
				fieldInfo.setInputType(inputTypeArr[i]);
				// 判断该字段是否可编辑
				if ("radio".equals(inputTypeArr[i]) || "checkbox".equals(inputTypeArr[i]) || "select".equals(inputTypeArr[i])) {
					fieldInfo.setIsAllowEdit("1");
				}
				
				fieldInfoList.add(fieldInfo);
			}
		}
		
		fieldInfoService.save(fieldInfoList);
		
		return Result.success();
	}
	
	/**
	 * 删除
	 * @param idArr 字段主键数组
	 * @throws QingException
	 */
	@RequestMapping("delete.json")
	@ResponseBody
	public Result delete(@RequestParam(value="idArr") String[] idArr) throws QingException {
		
		fieldInfoService.delete(idArr);
		
		return Result.success();
	}

	/**
	 * 查询字段变量名和其类型
	 * @return
	 */
	@RequestMapping("get_data_by_type_id.json")
	@ResponseBody
	public Result getDataByTypeId(@RequestParam(value="typeId") String typeId) {
		
		List<FieldInfo> list = fieldInfoService.listByTypeId(typeId);
		
		return Result.success().add("list", list);
	}
	
	
	/**
	 * 查询字段输入类型为单选框的字段信息
	 * @return
	 */
	@RequestMapping("get_radio_field.json")
	@ResponseBody
	public Result getRadioField() {
		
		List<FieldInfo> list = fieldInfoService.listRadio();
		
		return Result.success().add("list", list);
	}
	
	/**
	 * 根据分类id，查询单选选项
	 * @return
	 */
	@RequestMapping("get_radio_field_by_type_id.json")
	@ResponseBody
	public Result getRadioFieldByTypeId(@RequestParam(value="typeId") String typeId) {
		
		List<FieldInfo> radioList = fieldInfoService.listRadioByTypeId(typeId);
		if (radioList!=null && radioList.isEmpty()==false) {
			for (FieldInfo fieldInfo : radioList) {
				List<FieldProfileInfo> list = fieldProfileInfoService.listByFieldId(fieldInfo.getId());
				fieldInfo.setFieldProfileInfoList(list);
			}
		}
		
		return Result.success().add("radioList", radioList);
	}
}
