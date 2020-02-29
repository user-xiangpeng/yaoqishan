package cn.javaex.yaoqishan.service.tag_info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.javaex.yaoqishan.dao.tag_info.ITagInfoDAO;

@Service("TagInfoService")
public class TagInfoService {
	@Autowired
	private ITagInfoDAO iTagInfoDAO;

	/**
	 * 根据主键数组，查询名称集合
	 * @param idArr 主键数组
	 * @return
	 */
	public List<String> listNameByIdArr(String[] idArr) {
		return iTagInfoDAO.listNameByIdArr(idArr);
	}
}
