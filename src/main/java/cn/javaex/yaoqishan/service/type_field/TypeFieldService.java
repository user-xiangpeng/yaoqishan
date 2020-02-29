package cn.javaex.yaoqishan.service.type_field;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.javaex.yaoqishan.dao.field_info.IFieldInfoDAO;
import cn.javaex.yaoqishan.dao.media_info.IMediaInfoDAO;
import cn.javaex.yaoqishan.dao.type_field.ITypeFieldDAO;
import cn.javaex.yaoqishan.view.TypeField;

@Service("TypeFieldService")
public class TypeFieldService {
	@Autowired
	private ITypeFieldDAO iTypeFieldDAO;
	@Autowired
	private IFieldInfoDAO iFieldInfoDAO;
	@Autowired
	private IMediaInfoDAO iMediaInfoDAO;
	
	/**
	 * 根据分类信息主键，查询该分类下的字段配置
	 * @param typeId 分类信息主键
	 * @return
	 */
	public List<TypeField> listByTypeId(String typeId) {
		return iTypeFieldDAO.listByTypeId(typeId);
	}

	/**
	 * 保存某个分类信息下的字段配置
	 * @param typeId 分类信息主键
	 * @param typeFieldList
	 * @param fieldIdArr 字段主键数组
	 */
	public void save(String typeId, List<TypeField> typeFieldList, String[] fieldIdArr) {
		// 1.0 删除该分类下的所有字段配置
		iTypeFieldDAO.deleteByTypeId(typeId);
		
		// 2.0 批量插入分类信息下的字段配置
		iTypeFieldDAO.batchInsert(typeFieldList);
		
		// 3.0 生成关联字段
		// 3.1 获取字段的变量名集合
		List<String> list = iFieldInfoDAO.listVarNameByIdArr(fieldIdArr);
		if (list!=null && list.isEmpty()==false) {
			int len = list.size();
			for (int i=0; i<len; i++) {
				String varName = list.get(i);
				
				StringBuffer sql = new StringBuffer();
				sql.append(" IF NOT EXISTS ( ");
				sql.append(" SELECT ");
				sql.append(" * ");
				sql.append(" FROM ");
				sql.append(" syscolumns ");
				sql.append(" WHERE ");
				sql.append(" id = object_id('media_info') ");
				sql.append(" AND name = '"+varName+"' ");
				sql.append(" ) ");
				sql.append(" BEGIN ");
				sql.append(" ALTER TABLE media_info ADD "+varName+" VARCHAR (100) ");
				sql.append(" END ");
				
				iMediaInfoDAO.alter(sql.toString());
			}
		}
	}

	/**
	 * 检索指定字段是否必填
	 * @param typeId 分类信息主键
	 * @param varName 字段变量名
	 * @return
	 */
	public String selectIsRequired(String typeId, String varName) {
		return iTypeFieldDAO.selectIsRequired(typeId, varName);
	}
	
}
