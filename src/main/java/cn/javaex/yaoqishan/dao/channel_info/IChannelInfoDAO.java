package cn.javaex.yaoqishan.dao.channel_info;

import java.util.List;

import cn.javaex.yaoqishan.view.ChannelInfo;

public interface IChannelInfoDAO {

	/**
	 * 查询频道栏目列表
	 */
	List<ChannelInfo> list();

	/**
	 * 插入新的频道栏目
	 * @param channelInfo
	 * @return
	 */
	int insert(ChannelInfo channelInfo);
	
	/**
	 * 更新频道栏目
	 * @param channelInfo
	 * @return
	 */
	int update(ChannelInfo channelInfo);

	/**
	 * 根据主键查询频道信息
	 * @param id
	 * @return
	 */
	ChannelInfo selectById(String id);

	/**
	 * 删除频道
	 * @param id
	 * @return
	 */
	int delete(String id);

}