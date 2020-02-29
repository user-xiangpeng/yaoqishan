package cn.javaex.yaoqishan.action.field_profile_info;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.javaex.yaoqishan.service.field_profile_info.FieldProfileInfoService;
import cn.javaex.yaoqishan.view.FieldProfileInfo;
import cn.javaex.yaoqishan.view.Result;

@Controller
@RequestMapping("field_profile_info")
public class FieldProfileInfoAction {

	@Autowired
	private FieldProfileInfoService fieldProfileInfoService;
	
	/**
	 * 字段详情编辑
	 * @param fieldId 字段主键
	 * @param fieldName 字段名称
	 */
	@RequestMapping("list.action")
	public String list(ModelMap map,
			@RequestParam(value="fieldId") String fieldId,
			@RequestParam(value="fieldName") String fieldName) {
		
		// 字段对应的详情内容
		List<FieldProfileInfo> list = fieldProfileInfoService.listByFieldId(fieldId);
		map.put("list", list);

		map.put("fieldId", fieldId);
		map.put("fieldName", fieldName);
		
		return "admin/field_profile_info/list";
	}
	
	/**
	 * 保存字段
	 * @param fieldId 字段主键
	 * @param idArr 字段主键数组
	 * @param sortArr 字段排序数组
	 * @param nameArr 字段名称数组
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(
			@RequestParam(value="fieldId") String fieldId,
			@RequestParam(value="idArr") String[] idArr,
			@RequestParam(value="sortArr") String[] sortArr,
			@RequestParam(value="nameArr") String[] nameArr) {
		
		List<FieldProfileInfo> fieldProfileInfoList = new ArrayList<FieldProfileInfo>();
		
		// 判断是否已有既存数据
		if (idArr.length==0) {
			// 全是新增
			// 遍历sortArr数组
			for (int i=0; i<sortArr.length; i++) {
				FieldProfileInfo fieldProfileInfo = new FieldProfileInfo();
				fieldProfileInfo.setSort(sortArr[i]);
				fieldProfileInfo.setName(nameArr[i]);
				fieldProfileInfo.setFieldId(fieldId);
				
				fieldProfileInfoList.add(fieldProfileInfo);
			}
		} else {
			// 遍历idArr数组
			for (int i=0; i<idArr.length; i++) {
				FieldProfileInfo fieldProfileInfo = new FieldProfileInfo();
				fieldProfileInfo.setId(idArr[i]);
				fieldProfileInfo.setSort(sortArr[i]);
				fieldProfileInfo.setName(nameArr[i]);
				fieldProfileInfo.setFieldId(fieldId);
				
				fieldProfileInfoList.add(fieldProfileInfo);
			}
		}
		
		fieldProfileInfoService.save(fieldId, fieldProfileInfoList);

		return Result.success();
	}
	
	/**
	 * 删除
	 * @param fieldId 字段主键
	 * @param idArr 字段主键数组
	 */
	@RequestMapping("delete.json")
	@ResponseBody
	public Result delete(
			@RequestParam(value="fieldId") String fieldId,
			@RequestParam(value="idArr") String[] idArr) {
		
		fieldProfileInfoService.delete(fieldId, idArr);
		
		return Result.success();
	}
}
