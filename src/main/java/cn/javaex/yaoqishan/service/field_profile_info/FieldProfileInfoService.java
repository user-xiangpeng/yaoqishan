package cn.javaex.yaoqishan.service.field_profile_info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.javaex.yaoqishan.dao.field_info.IFieldInfoDAO;
import cn.javaex.yaoqishan.dao.field_profile_info.IFieldProfileInfoDAO;
import cn.javaex.yaoqishan.view.FieldInfo;
import cn.javaex.yaoqishan.view.FieldProfileInfo;

@Service("FieldProfileInfoService")
public class FieldProfileInfoService {
	@Autowired
	private IFieldProfileInfoDAO iFieldProfileInfoDAO;
	@Autowired
	private IFieldInfoDAO iFieldInfoDAO;
	
	/**
	 * 根据字段主键查询字段详情列表
	 * @param fieldId 字段主键
	 */
	public List<FieldProfileInfo> listByFieldId(String fieldId) {
		return iFieldProfileInfoDAO.listByFieldId(fieldId);
	}

	/**
	 * 保存字段详细内容
	 * @param fieldId 字段主键
	 * @param fieldProfileInfoList
	 */
	public void save(String fieldId, List<FieldProfileInfo> fieldProfileInfoList) {
		// 1.0 保存字段内容
		for (FieldProfileInfo fieldProfileInfo : fieldProfileInfoList) {
			if (StringUtils.isEmpty(fieldProfileInfo.getId())) {
				// 插入
				iFieldProfileInfoDAO.insert(fieldProfileInfo);
			} else {
				// 更新
				iFieldProfileInfoDAO.update(fieldProfileInfo);
			}
		}
		
		// 2.0 重新生成字段模板
		fieldTemplate(fieldId);
	}

	/**
	 * 删除字段内容
	 * @param fieldId 字段主键
	 * @param idArr 主键数组
	 */
	public void delete(String fieldId, String[] idArr) {
		// 1.0 批量删除字段内容
		iFieldProfileInfoDAO.delete(idArr);
		
		// 2.0 重新生成字段模板
		fieldTemplate(fieldId);
	}

	/**
	 * 生成字段模板
	 * @param fieldId 字段主键
	 */
	public void fieldTemplate(String fieldId) {
		// 1.0 根据主键查询字段信息
		FieldInfo fieldInfo = iFieldInfoDAO.selectById(fieldId);
		
		// 2.0 生成模板代码
		// 2.1 查询字段详细内容
		List<FieldProfileInfo> list = iFieldProfileInfoDAO.listByFieldId(fieldId);
		// 编辑页面选项等分数量
		String equal = "8";
		// [\u4e00-\u9fa5]是中文的Unicode编码范围，用正则表达式的方法，若字符串中有字符满足中文的正则表达式，则判定为中文，将其替换为两个字符，故长度差就为中文的个数
		String regEx = "[\\u4e00-\\u9fa5]";
		for (FieldProfileInfo fieldProfileInfo : list) {
			String fieldName = fieldProfileInfo.getName();
			String zhongwen = fieldName.replaceAll(regEx, "aa");
			// 当有4个以上的中文 或者 字符串长度大于4时，设置为6等分
			if ((zhongwen.length()-fieldName.length())>3 || fieldName.length()>4) {
				equal = "6";
			}
		}
		
		StringBuffer sb = new StringBuffer();
		sb.append("	<div class='unit'>");
		sb.append("		<div class='left'>");
		sb.append("			<p class='subtitle'>"+fieldInfo.getName()+"</p>");
		sb.append("		</div>");
		sb.append("		<div class='right'>");
		sb.append("			<ul class='equal-"+equal+"'>");
		// 2.2 判断输入类型
		int len = list.size();
		if ("radio".equals(fieldInfo.getInputType())) {
			// 单选框
			for (int i=0; i<len; i++) {
				if (i==0) {
					sb.append("		<li><input type='radio' class='fill' name='"+fieldInfo.getVarName()+"' value='"+list.get(i).getId()+"' checked />"+list.get(i).getName()+"</li>");
				} else {
					sb.append("		<li><input type='radio' class='fill' name='"+fieldInfo.getVarName()+"' value='"+list.get(i).getId()+"' />"+list.get(i).getName()+"</li>");
				}
			}
		} else if ("checkbox".equals(fieldInfo.getInputType())) {
			// 复选框
			for (int i=0; i<len; i++) {
				sb.append("		<li><input type='checkbox' class='fill' name='"+fieldInfo.getVarName()+"' value='"+list.get(i).getId()+"' />"+list.get(i).getName()+"</li>");
			}
		}
		sb.append("			</ul>");
		sb.append("		</div>");
		// 清浮动
		sb.append("		<span class='clearfix'></span>");
		sb.append("	</div>");

		// 3.0 更新字段模板
		fieldInfo.setContent(sb.toString());
		iFieldInfoDAO.update(fieldInfo);
	}
}
