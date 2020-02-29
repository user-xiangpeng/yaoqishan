package cn.javaex.yaoqishan.action.type_field;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.javaex.yaoqishan.service.field_info.FieldInfoService;
import cn.javaex.yaoqishan.service.type_field.TypeFieldService;
import cn.javaex.yaoqishan.view.FieldInfo;
import cn.javaex.yaoqishan.view.Result;
import cn.javaex.yaoqishan.view.TypeField;

@Controller
@RequestMapping("type_field")
public class TypeFieldAction {

	@Autowired
	private TypeFieldService typeFieldService;
	@Autowired
	private FieldInfoService fieldInfoService;
	
	/**
	 * 根据分类信息主键，查询该分类下的字段配置
	 * @param map
	 * @param typeId 分类信息主键
	 * @param typeName 分类信息名称
	 * @return
	 */
	@RequestMapping("list.action")
	public String list(ModelMap map,
			@RequestParam(value="typeId") String typeId,
			@RequestParam(value="typeName") String typeName) {
		
		// 查询所有字段，并判断在该分类中是否已包含此字段
		List<FieldInfo> fieldList = fieldInfoService.list(typeId);
		map.put("fieldList", fieldList);
		
		// 查询已配置的字段
		List<TypeField> list = typeFieldService.listByTypeId(typeId);
		map.put("list", list);
		
		map.put("typeId", typeId);
		map.put("typeName", typeName);
		return "admin/type_field/list";
	}
	
	/**
	 * 保存指定分类下的字段配置
	 * @param typeId 分类信息主键
	 * @param fieldIdArr 字段主键数组
	 * @param sortArr 排序数组
	 * @param isScreenArr 是否允许列表筛选数组
	 * @param isRequiredArr 是否必填数组
	 * @return
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(
			@RequestParam(value="typeId") String typeId,
			@RequestParam(value="fieldIdArr") String[] fieldIdArr,
			@RequestParam(value="sortArr") String[] sortArr,
			@RequestParam(value="isScreenArr") String[] isScreenArr,
			@RequestParam(value="isRequiredArr") String[] isRequiredArr) {
		
		List<TypeField> typeFieldList = new ArrayList<TypeField>();
		
		// 遍历fieldIdArr数组
		for (int i=0; i<fieldIdArr.length; i++) {
			TypeField typeField = new TypeField();
			typeField.setTypeId(typeId);
			typeField.setFieldId(fieldIdArr[i]);
			try {
				typeField.setIsScreen(isScreenArr[i]);
			} catch (Exception e) {
				typeField.setIsScreen("0");
			}
			try {
				typeField.setIsRequired(isRequiredArr[i]);
			} catch (Exception e) {
				typeField.setIsRequired("0");
			}
			typeField.setSort(sortArr[i]);

			typeFieldList.add(typeField);
		}
		
		typeFieldService.save(typeId, typeFieldList, fieldIdArr);

		return Result.success();
	}
}
