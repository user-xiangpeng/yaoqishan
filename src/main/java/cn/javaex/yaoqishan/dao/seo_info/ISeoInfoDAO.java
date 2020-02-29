package cn.javaex.yaoqishan.dao.seo_info;

import cn.javaex.yaoqishan.view.SeoInfo;

public interface ISeoInfoDAO {

	/**
	 * 根据类型，查询seo信息
	 * @param type 类型
	 * @return
	 */
	SeoInfo selectByType(String type);

	/**
	 * seo信息
	 * @param seoInfo
	 */
	int update(SeoInfo seoInfo);

}