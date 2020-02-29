package cn.javaex.yaoqishan.dao.star_info;

import java.util.List;

import cn.javaex.yaoqishan.view.StarInfo;

public interface IStarInfoDAO {

	/**
	 * 查询明星列表
	 */
	List<StarInfo> list();

	/**
	 * 查询单个明星的信息
	 * @param id
	 * @return
	 */
	StarInfo selectById(String id);

	/**
	 * 插入一条明星数据
	 * @param starInfo
	 */
	int insert(StarInfo starInfo);
	
	/**
	 * 更新一条明星数据
	 * @param starInfo
	 */
	int update(StarInfo starInfo);

}