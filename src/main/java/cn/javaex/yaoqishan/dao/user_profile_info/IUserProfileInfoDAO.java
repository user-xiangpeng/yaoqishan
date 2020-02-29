package cn.javaex.yaoqishan.dao.user_profile_info;

import java.util.Map;

import cn.javaex.yaoqishan.view.UserProfileInfo;

public interface IUserProfileInfoDAO {

	/**
	 * 注册新用户
	 * @param userProfileInfo
	 */
	int insert(UserProfileInfo userProfileInfo);

	/**
	 * 查询指定用户组的数量
	 * @param groupId 用户组主键
	 * @return
	 */
	int countByGroupId(String groupId);

	/**
	 * 保存用户信息
	 * @param userProfileInfo
	 */
	int update(UserProfileInfo userProfileInfo);

	/**
	 * 批量更新用户
	 * @param param
	 */
	int batchUpdate(Map<String, Object> param);

}