package cn.javaex.yaoqishan.service.activate_info;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.javaex.yaoqishan.dao.activate_info.IActivateInfoDAO;
import cn.javaex.yaoqishan.view.ActivateInfo;

@Service("ActivateInfoService")
public class ActivateInfoService {
	@Autowired
	private IActivateInfoDAO iActivateInfoDAO;

	/**
	 * 保存认证记录
	 * @param activateInfo
	 */
	public void save(ActivateInfo activateInfo) {
		// 1.0 根据用户id和验证类型，判断认证是否已存在
		ActivateInfo activateInfo2 = iActivateInfoDAO.selectByUserIdAndType(activateInfo.getUserId(), activateInfo.getType());
		
		// 判断是否已存在
		if (activateInfo2==null) {
			// 不存在，做插入操作
			iActivateInfoDAO.insert(activateInfo);
		} else {
			// 存在，做更新操作
			activateInfo.setId(activateInfo2.getId());
			
			iActivateInfoDAO.update(activateInfo);
		}
	}
	
}
