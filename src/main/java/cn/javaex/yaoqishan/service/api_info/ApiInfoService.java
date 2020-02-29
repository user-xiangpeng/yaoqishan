package cn.javaex.yaoqishan.service.api_info;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.javaex.yaoqishan.dao.api_info.IApiInfoDAO;
import cn.javaex.yaoqishan.dao.tag_info.ITagInfoDAO;
import cn.javaex.yaoqishan.view.ApiInfo;
import cn.javaex.yaoqishan.view.FieldInfo;

@Service("ApiInfoService")
public class ApiInfoService {
	@Autowired
	private IApiInfoDAO iApiInfoDAO;
	@Autowired
	private ITagInfoDAO iTagInfoDAO;

	/**
	 * 查询指定类型的接口列表
	 * @param type 接口类型
	 * @return
	 */
	public List<ApiInfo> listByType(String type) {
		return iApiInfoDAO.listByType(type);
	}

	/**
	 * 保存接口
	 * @param fieldInfoList
	 */
	public void save(List<ApiInfo> slideInfoList) {
		for (ApiInfo slideInfo : slideInfoList) {
			if (StringUtils.isEmpty(slideInfo.getId())) {
				// 插入
				iApiInfoDAO.insert(slideInfo);
			} else {
				// 更新
				iApiInfoDAO.update(slideInfo);
			}
		}
	}

	/**
	 * 删除接口
	 * @param idArr 接口主键数组
	 */
	public void delete(String[] idArr) {
		// 批量删除接口
		iApiInfoDAO.delete(idArr);
	}

	/**
	 * 根据主键，获取接口设置条件
	 * @param id 主键
	 * @return
	 */
	public Map<String, Object> selectById(String id) {
		return iApiInfoDAO.selectById(id);
	}

	/**
	 * 保存自定义数据条件设置
	 * @param radioList 
	 * @param param
	 */
	public void userSave(List<FieldInfo> radioList, Map<String, Object> param) {
		// 1.0 处理标签
		if (StringUtils.isEmpty(param.get("tag"))) {
			// 清空该媒体的标签
			param.put("tag", "");
		} else {
			String tags = param.get("tag").toString();
			// 将得到的标签转为数组格式
			String[] tagArr = tags.split(",");
			// 根据用户输入的标签，查询标签的主键，按从小到大排序
			List<String> idList = iTagInfoDAO.listIdByNameArr(tagArr);
			
			// 将集合转为 1,3这种字符串
			String str = "";
			for (int i=0; i<idList.size(); i++) {
				if (i==0) {
					str = idList.get(i);
				} else {
					str = str + "," + idList.get(i);
				}
			}
			
			// 保存新的标签
			param.put("tag", str);
		}
		
		// 2.0 生成更新数据SQL文
		StringBuffer sql = new StringBuffer();
		sql.append(" UPDATE ");
		sql.append(" api_info ");
		sql.append(" SET ");
		for (FieldInfo fieldInfo : radioList) {
			String value = "";
			if (param.get(fieldInfo.getVarName())!=null) {
				value = param.get(fieldInfo.getVarName()).toString();
			}
			sql.append(fieldInfo.getVarName() + "=" + "'" + value + "',");
		}
		sql.append(" type_id='"+param.get("type_id").toString()+"', ");
		sql.append(" num='"+param.get("num").toString()+"', ");
		sql.append(" tag='"+param.get("tag").toString()+"', ");
		sql.append(" select_video='"+param.get("select_video").toString()+"', ");
		sql.append(" cache_time='"+param.get("cache_time").toString()+"', ");
		sql.append(" field='"+param.get("field").toString()+"' ");
		sql.append(" WHERE ");
		sql.append(" id = '" + param.get("id").toString() + "' ");
		
		iApiInfoDAO.updateSQL(sql.toString());
	}

	/**
	 * 保存排行榜条件设置
	 * @param apiInfo
	 */
	public void rankSave(ApiInfo apiInfo) {
		iApiInfoDAO.updateRankSet(apiInfo);
	}

}
