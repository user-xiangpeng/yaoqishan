package cn.javaex.yaoqishan.service.nav_info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.javaex.yaoqishan.dao.nav_info.INavInfoDAO;
import cn.javaex.yaoqishan.view.NavInfo;

@Service("NavInfoService")
public class NavInfoService {
	@Autowired
	private INavInfoDAO iNavInfoDAO;

	/**
	 * 查询导航列表
	 */
	public List<NavInfo> list() {
		return iNavInfoDAO.list();
	}
	
	/**
	 * 可用导航列表
	 * @return
	 */
	public List<NavInfo> listIsUse() {
		return iNavInfoDAO.listIsUse();
	}

	/**
	 * 保存导航
	 * @param NavInfoList
	 */
	public void save(List<NavInfo> navInfoList) {
		for (NavInfo navInfo : navInfoList) {
			if (StringUtils.isEmpty(navInfo.getId())) {
				// 插入
				navInfo.setType("user");
				iNavInfoDAO.insert(navInfo);
			} else {
				// 更新
				iNavInfoDAO.update(navInfo);
			}
		}
	}

	/**
	 * 删除导航
	 * @param idArr 导航主键数组
	 */
	public void delete(String[] idArr) {
		iNavInfoDAO.delete(idArr);
	}

}
