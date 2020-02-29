package cn.javaex.yaoqishan.service.channel_info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.javaex.yaoqishan.dao.channel_info.IChannelInfoDAO;
import cn.javaex.yaoqishan.dao.nav_info.INavInfoDAO;
import cn.javaex.yaoqishan.view.ChannelInfo;
import cn.javaex.yaoqishan.view.NavInfo;

@Service("ChannelInfoService")
public class ChannelInfoService {
	@Autowired
	private IChannelInfoDAO iChannelInfoDAO;
	@Autowired
	private INavInfoDAO iNavInfoDAO;
	
	/**
	 * 查询频道列表
	 */
	public List<ChannelInfo> list() {
		return iChannelInfoDAO.list();
	}

	/**
	 * 根据主键查询频道信息
	 * @param id 主键
	 * @return
	 */
	public ChannelInfo selectById(String id) {
		if (StringUtils.isEmpty(id)) {
			return null;
		}
		
		return iChannelInfoDAO.selectById(id);
	}

	/**
	 * 保存频道内容
	 * @param channelInfo
	 */
	public void save(ChannelInfo channelInfo) {
		// 判断是新增还是更新
		if (StringUtils.isEmpty(channelInfo.getId())) {
			// 新增
			iChannelInfoDAO.insert(channelInfo);
			
			// 添加进导航
			NavInfo navInfo = new NavInfo();
			navInfo.setSort("1");
			navInfo.setName(channelInfo.getName());
			navInfo.setLink("portal/portal.action?channelId="+channelInfo.getId());
			navInfo.setIsIndex("0");
			navInfo.setIsUse("1");
			navInfo.setType("system");
			navInfo.setChannelId(channelInfo.getId());
			
			iNavInfoDAO.insert(navInfo);
		} else {
			// 更新
			iChannelInfoDAO.update(channelInfo);
			
			// 更新导航
			NavInfo navInfo = new NavInfo();
			navInfo.setName(channelInfo.getName());
			navInfo.setChannelId(channelInfo.getId());
			
			iNavInfoDAO.updateByChannel(navInfo);
		}
	}

	/**
	 * 删除频道
	 * @param id
	 */
	public void delete(String id) {
		// 删除频道
		iChannelInfoDAO.delete(id);
		
		// 删除导航中对应的链接
		iNavInfoDAO.deleteByChannelId(id);
	}

}
