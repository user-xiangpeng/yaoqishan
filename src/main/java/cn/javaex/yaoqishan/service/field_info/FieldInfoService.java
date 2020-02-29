package cn.javaex.yaoqishan.service.field_info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.javaex.yaoqishan.constant.ErrorMsg;
import cn.javaex.yaoqishan.dao.api_info.IApiInfoDAO;
import cn.javaex.yaoqishan.dao.field_info.IFieldInfoDAO;
import cn.javaex.yaoqishan.dao.field_profile_info.IFieldProfileInfoDAO;
import cn.javaex.yaoqishan.dao.type_field.ITypeFieldDAO;
import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.view.FieldInfo;
import cn.javaex.yaoqishan.view.FieldProfileInfo;

@Service("FieldInfoService")
public class FieldInfoService {
	@Autowired
	private IFieldInfoDAO iFieldInfoDAO;
	@Autowired
	private IFieldProfileInfoDAO iFieldProfileInfoDAO;
	@Autowired
	private ITypeFieldDAO iTypeFieldDAO;
	@Autowired
	private IApiInfoDAO iApiInfoDAO;
	
	/**
	 * 查询字段列表
	 */
	public List<FieldInfo> list() {
		return iFieldInfoDAO.list();
	}
	
	/**
	 * 查询字段列表，并判断某些字段是否已被选择
	 */
	public List<FieldInfo> list(String typeId) {
		List<FieldInfo> list = iFieldInfoDAO.list();
		for (FieldInfo fieldInfo : list) {
			// 判断在该分类中是否已包含此字段
			int nCount = iTypeFieldDAO.countFieldByTypeIdAndFieldId(typeId, fieldInfo.getId());
			if (nCount>0) {
				// 包含
				fieldInfo.setIsSelected("1");
			}
		}
		
		return list;
	}

	/**
	 * 查询分类下的字段列表
	 * @param typeId 分类信息主键
	 * @return
	 */
	public List<FieldInfo> listByTypeId(String typeId) {
		return iFieldInfoDAO.listByTypeId(typeId);
	}
	
	/**
	 * 保存字段
	 * @param fieldInfoList
	 * @throws QingException
	 */
	public void save(List<FieldInfo> fieldInfoList) throws QingException {
		// 保存字段信息
		for (FieldInfo fieldInfo : fieldInfoList) {
			if (StringUtils.isEmpty(fieldInfo.getId())) {
				// 1.0 校验字段变量名是否重复或者是否已被媒体表内置字段占用
				String varName = fieldInfo.getVarName();
				int count = iFieldInfoDAO.countByVarName(varName, null);
				if (count>0) {
					// 重复
					throw new QingException(ErrorMsg.ERROR_200001+"："+varName);
				}
				
				// 2.0 插入
				fieldInfo.setType("user");
				iFieldInfoDAO.insert(fieldInfo);
			} else {
				// 1.0 校验字段变量名是否重复（排除自己）
				String varName = fieldInfo.getVarName();
				int count = iFieldInfoDAO.countByVarName(varName, fieldInfo.getId());
				if (count>0) {
					// 重复
					throw new QingException(ErrorMsg.ERROR_200001+"："+varName);
				}
				
				// 2.0 更新
				iFieldInfoDAO.update(fieldInfo);
			}
		}
		
		// 2.0 重新生成字段模板
		List<FieldInfo> list = iFieldInfoDAO.list();
		for (FieldInfo fieldInfo : list) {
			if ("text".equals(fieldInfo.getInputType())) {
				// 文字输入框
				StringBuffer sb = new StringBuffer();
				sb.append("	<div class='unit'>");
				sb.append("		<div class='left'>");
				sb.append("			<p class='subtitle'>"+fieldInfo.getName()+"</p>");
				sb.append("		</div>");
				sb.append("		<div class='right'>");
				sb.append("		<input type='text' class='text' name='"+fieldInfo.getVarName()+"' value='' />");
				sb.append("		</div>");
				// 清浮动
				sb.append("		<span class='clearfix'></span>");
				sb.append("	</div>");

				// 3.0 更新字段模板
				fieldInfo.setContent(sb.toString());
				iFieldInfoDAO.update(fieldInfo);
			} else if ("textarea".equals(fieldInfo.getInputType())) {
				// 文本域
				StringBuffer sb = new StringBuffer();
				sb.append("	<div class='unit'>");
				sb.append("		<div class='left'>");
				sb.append("			<p class='subtitle'>"+fieldInfo.getName()+"</p>");
				sb.append("		</div>");
				sb.append("		<div class='right'>");
				sb.append("			<textarea class='desc' name='"+fieldInfo.getVarName()+"'></textarea>");
				sb.append("		</div>");
				// 清浮动
				sb.append("		<span class='clearfix'></span>");
				sb.append("	</div>");

				// 3.0 更新字段模板
				fieldInfo.setContent(sb.toString());
				iFieldInfoDAO.update(fieldInfo);
			} else if ("number".equals(fieldInfo.getInputType())) {
				// 数字
				StringBuffer sb = new StringBuffer();
				sb.append("	<div class='unit'>");
				sb.append("		<div class='left'>");
				sb.append("			<p class='subtitle'>"+fieldInfo.getName()+"</p>");
				sb.append("		</div>");
				sb.append("		<div class='right'>");
				sb.append("		<input type='text' class='text' name='"+fieldInfo.getVarName()+"' data-type=\"空|正整数\" error-msg=\"正整数格式错误\" value='' />");
				sb.append("		</div>");
				// 清浮动
				sb.append("		<span class='clearfix'></span>");
				sb.append("	</div>");

				// 3.0 更新字段模板
				fieldInfo.setContent(sb.toString());
				iFieldInfoDAO.update(fieldInfo);
			}
		}
		
		// 3.0 向接口表中添加字段
		for (int i=0; i<list.size(); i++) {
			String varName = list.get(i).getVarName();
			
			StringBuffer sql = new StringBuffer();
			sql.append(" IF NOT EXISTS ( ");
			sql.append(" SELECT ");
			sql.append(" * ");
			sql.append(" FROM ");
			sql.append(" syscolumns ");
			sql.append(" WHERE ");
			sql.append(" id = object_id('api_info') ");
			sql.append(" AND name = '"+varName+"' ");
			sql.append(" ) ");
			sql.append(" BEGIN ");
			sql.append(" ALTER TABLE api_info ADD "+varName+" VARCHAR (100) ");
			sql.append(" END ");
			
			iApiInfoDAO.alter(sql.toString());
		}
	}

	/**
	 * 删除字段
	 * @param idArr 字段主键数组
	 * @throws QingException
	 */
	public void delete(String[] idArr) throws QingException {
		// 校验是否可以删除字段
		for (int i=0; i<idArr.length; i++) {
			// 判断字段有没有被分类信息使用
			int count1 = iTypeFieldDAO.countByFieldId(idArr[i]);
			if (count1>0) {
				throw new QingException(ErrorMsg.ERROR_200002);
			}
			
			// 根据字段主键，查询其变量名
			FieldInfo fieldInfo = iFieldInfoDAO.selectById(idArr[i]);
			// 判断字段有没有被接口使用
			int count2 = iApiInfoDAO.countByField(fieldInfo.getVarName());
			if (count2>0) {
				throw new QingException(ErrorMsg.ERROR_200003);
			}
		}
		
		// 批量删除字段
		iFieldInfoDAO.delete(idArr);
	}

	/**
	 * 获取分类筛选字段的信息
	 * @param typeId 分类信息的主键
	 * @return
	 */
	public List<FieldInfo> getListField(String typeId) {
		// 1.0 查询该分类下的所有可筛选字段
		List<FieldInfo> fieldInfoList = iFieldInfoDAO.listCategoryField(typeId);
		if (fieldInfoList!=null && fieldInfoList.isEmpty()==false) {
			for (FieldInfo fieldInfo : fieldInfoList) {
				// 2.0 获取每个字段下的具体选项
				List<FieldProfileInfo> fieldProfileInfoList = iFieldProfileInfoDAO.listByFieldId(fieldInfo.getId());
				fieldInfo.setFieldProfileInfoList(fieldProfileInfoList);
			}
		}
		
		return fieldInfoList;
	}
	
	/**
	 * 获取分类筛选字段的信息2
	 * @param typeId 分类信息的主键
	 * @param fieldName 字段名
	 * @param fieldValue 字段选项名
	 * @return
	 */
	public List<FieldInfo> getListField(String typeId, String fieldName, String fieldValue) {
		// 1.0 查询该分类下的所有可筛选字段
		List<FieldInfo> fieldInfoList = iFieldInfoDAO.listCategoryField(typeId);
		if (fieldInfoList!=null && fieldInfoList.isEmpty()==false) {
			for (FieldInfo fieldInfo : fieldInfoList) {
				// 2.0 获取每个字段下的具体选项
				List<FieldProfileInfo> fieldProfileInfoList = iFieldProfileInfoDAO.listByFieldId(fieldInfo.getId());
				if (fieldProfileInfoList==null || fieldProfileInfoList.size()==0) {
					return null;
				}
				fieldInfo.setFieldProfileInfoList(fieldProfileInfoList);
				
				// 3.0 判断参数是否合法
				if (StringUtils.isEmpty(fieldName) && StringUtils.isEmpty(fieldValue)) {
					
				} else {
					if (StringUtils.isEmpty(fieldName) ) {
						return null;
					}
					if (StringUtils.isEmpty(fieldValue) ) {
						return null;
					}
					
					// 字段一致时，判断是否存在参数选项
					if (fieldInfo.getName().equals(fieldName)) {
						boolean flag = false;
						for (FieldProfileInfo fieldProfileInfo : fieldProfileInfoList) {
							if (fieldProfileInfo.getName().equals(fieldValue)) {
								flag = true;
							}
						}
						if (!flag) {
							return null;
						}
					}
				}
			}
		}
		
		return fieldInfoList;
	}

	/**
	 * 根据主键查询字段信息
	 * @param id 主键
	 * @return
	 */
	public FieldInfo selectById(String id) {
		return iFieldInfoDAO.selectById(id);
	}

	/**
	 * 查询单选框字段
	 * @return
	 */
	public List<FieldInfo> listRadio() {
		return iFieldInfoDAO.listRadio();
	}
	
	/**
	 * 根据分类id，查询该分类的单选框字段
	 * @param typeId 分类信息的id
	 * @return
	 */
	public List<FieldInfo> listRadioByTypeId(String typeId) {
		return iFieldInfoDAO.listRadioByTypeId(typeId);
	}

	/**
	 * 获取分类筛选字段的信息
	 * @param typeId 分类信息主键
	 * @return
	 */
	public List<FieldInfo> listCategoryField(String typeId) {
		return iFieldInfoDAO.listCategoryField(typeId);
	}

}
