package cn.javaex.yaoqishan.service.type_info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.javaex.yaoqishan.constant.ErrorMsg;
import cn.javaex.yaoqishan.dao.type_field.ITypeFieldDAO;
import cn.javaex.yaoqishan.dao.type_info.ITypeInfoDAO;
import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.view.TypeInfo;

@Service("TypeInfoService")
public class TypeInfoService {
	@Autowired
	private ITypeInfoDAO iTypeInfoDAO;
	@Autowired
	private ITypeFieldDAO iTypeFieldDAO;
	
	/**
	 * 查询分类列表
	 */
	public List<TypeInfo> list() {
		return iTypeInfoDAO.list();
	}

	/**
	 * 保存分类
	 * @param typeInfoList
	 */
	public void save(List<TypeInfo> typeInfoList) {
		for (TypeInfo typeInfo : typeInfoList) {
			if (StringUtils.isEmpty(typeInfo.getId())) {
				// 插入
				iTypeInfoDAO.insert(typeInfo);
			} else {
				// 更新
				iTypeInfoDAO.update(typeInfo);
			}
		}
	}

	/**
	 * 删除分类
	 * @param idArr 分类主键数组
	 * @throws QingException 
	 */
	public void delete(String[] idArr) throws QingException {
		// 1.0 校验该分类下是否已有字段配置（防止误删除）
		for (int i=0; i<idArr.length; i++) {
			int count  = iTypeFieldDAO.countByTypeId(idArr[i]);
			if (count>0) {
				throw new QingException(ErrorMsg.ERROR_800001);
			}
		}
		
		// 2.0 批量删除分类
		iTypeInfoDAO.delete(idArr);
	}

	/**
	 * 根据主键查询分类信息
	 * @param id 主键
	 * @return
	 */
	public TypeInfo selectById(String id) {
		return iTypeInfoDAO.selectById(id);
	}

}
