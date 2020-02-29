package cn.javaex.yaoqishan.dao.slide_info;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import cn.javaex.yaoqishan.view.SlideInfo;

public interface ISlideInfoDAO {

	/**
	 * 根据接口主键，查询所有幻灯片数据
	 * @param apiId 接口表的主键
	 * @return
	 */
	List<SlideInfo> listByApiId(String apiId);

	/**
	 * 插入新的幻灯片数据
	 */
	int insert(SlideInfo slideProfileInfo);
	
	/**
	 * 更新幻灯片数据
	 */
	int update(SlideInfo slideProfileInfo);

	
	/**
	 * 批量删除幻灯片数据
	 * @param idArr 主键数组
	 * @return
	 */
	int delete(@Param("idArr") String[] idArr);

	/**
	 * 接口专用
	 * 根据幻灯片主键，查询所有幻灯片数据
	 * @param slideId 幻灯片表的主键
	 * @return
	 */
	List<Map<String, Object>> mapListByApiId(String slideId);

}