package cn.javaex.yaoqishan.dao.activate_info;

import org.apache.ibatis.annotations.Param;

import cn.javaex.yaoqishan.view.ActivateInfo;

public interface IActivateInfoDAO {

	/**
	 * 根据用户id和验证类型，判断认证是否已存在
	 * @param userId 用户id
	 * @param type 验证类型
	 * @return
	 */
	ActivateInfo selectByUserIdAndType(@Param("userId") String userId, @Param("type") String type);

	/**
	 * 插入
	 * @param activateInfo
	 * @return
	 */
	int insert(ActivateInfo activateInfo);

	/**
	 * 新增
	 * @param activateInfo
	 * @return
	 */
	int update(ActivateInfo activateInfo);

	/**
	 * 删除验证记录
	 * @param id
	 * @return
	 */
	int delete(String id);

	/**
	 * 获取验证记录
	 * @param email
	 * @param code
	 * @param type
	 * @return
	 */
	ActivateInfo selectByEmailAndCodeAndType(
			@Param("email") String email,
			@Param("code") String code,
			@Param("type") String type
			);
}