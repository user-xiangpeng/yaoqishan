package cn.javaex.yaoqishan.service.group_info;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.javaex.yaoqishan.constant.ErrorMsg;
import cn.javaex.yaoqishan.dao.group_info.IGroupInfoDAO;
import cn.javaex.yaoqishan.dao.user_profile_info.IUserProfileInfoDAO;
import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.view.GroupInfo;

@Service("GroupInfoService")
public class GroupInfoService {
	@Autowired
	private IGroupInfoDAO iGroupInfoDAO;
	@Autowired
	private IUserProfileInfoDAO iUserProfileInfoDAO;
	
	/**
	 * 查询用户组列表
	 */
	public List<GroupInfo> list() {
		return iGroupInfoDAO.list();
	}

	/**
	 * 保存用户组
	 * @param groupInfoList
	 * @throws QingException
	 */
	public void save(List<GroupInfo> groupInfoList) throws QingException {
		for (GroupInfo groupInfo : groupInfoList) {
			if (StringUtils.isEmpty(groupInfo.getId())) {
				// 插入
				// 判断组名是否重复
				int count = iGroupInfoDAO.countByName(groupInfo.getName(), null);
				if (count>0) {
					throw new QingException(ErrorMsg.ERROR_110001);
				}
				groupInfo.setType("user");
				iGroupInfoDAO.insert(groupInfo);
			} else {
				// 更新
				// 判断组名是否重复（排除自己）
				int count = iGroupInfoDAO.countByName(groupInfo.getName(), groupInfo.getId());
				if (count>0) {
					throw new QingException(ErrorMsg.ERROR_110001);
				}
				iGroupInfoDAO.update(groupInfo);
			}
		}
	}

	/**
	 * 删除用户组
	 * @param idArr 用户组主键数组
	 * @throws QingException 
	 */
	public void delete(String[] idArr) throws QingException {
		// 判断所选用户组有没有被使用的
		for (int i=0; i<idArr.length; i++) {
			int count = iUserProfileInfoDAO.countByGroupId(idArr[i]);
			if (count>0) {
				throw new QingException(ErrorMsg.ERROR_110002);
			}
		}
		
		// 批量删除用户组
		iGroupInfoDAO.delete(idArr);
	}

	/**
	 * 查询用户权限值
	 * @param id
	 * @return
	 */
	public String selectPowerByUserId(String id) {
		return iGroupInfoDAO.selectPowerByUserId(id);
	}

}
