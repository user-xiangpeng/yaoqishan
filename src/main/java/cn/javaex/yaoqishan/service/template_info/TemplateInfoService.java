package cn.javaex.yaoqishan.service.template_info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.javaex.yaoqishan.dao.template_info.ITemplateInfoDAO;
import cn.javaex.yaoqishan.view.TemplateInfo;

@Service("TemplateInfoService")
public class TemplateInfoService {
	@Autowired
	private ITemplateInfoDAO iTemplateInfoDAO;

	/**
	 * 根据类型查询已选的模板
	 * @param type 类型
	 * @return
	 */
	public TemplateInfo selectByType(String type) {
		return iTemplateInfoDAO.selectByType(type);
	}
	
	/**
	 * 保存模板风格的配置
	 * @param templateInfo
	 */
	public void save(TemplateInfo templateInfo) {
		iTemplateInfoDAO.update(templateInfo);
	}

	/**
	 * 获取类型对应的模板名称
	 * @param type 类型
	 * @return
	 */
	public String selectNameByType(String type) {
		return iTemplateInfoDAO.selectNameByType(type);
	}

}
