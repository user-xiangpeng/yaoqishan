package cn.javaex.yaoqishan.dao.user_info;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import cn.javaex.yaoqishan.view.UserInfo;

public interface IUserInfoDAO {

	/**
	 * 查询用户
	 * @param loginName 登录名
	 * @param passWord 登录密码
	 * @return
	 */
	UserInfo selectUser(@Param("loginName") String loginName, @Param("passWord") String passWord);

	/**
	 * 查询用户数量
	 * @param loginName 注册时填写的账号
	 * @param email 注册时填写的邮箱
	 * @return
	 */
	int countUser(@Param("loginName") String loginName, @Param("email") String email);

	/**
	 * 注册新用户
	 * @param userInfo
	 */
	int insert(UserInfo userInfo);

	/**
	 * 根据主键查询用户信息
	 * @param id 用户主键
	 * @return
	 */
	UserInfo selectUserById(String id);

	/**
	 * 查询所有用户
	 * @param param
	 * @return
	 */
	List<UserInfo> list(Map<String, Object> param);

	/**
	 * 批量更新用户
	 * @param param
	 */
	int batchUpdate(Map<String, Object> param);

	/**
	 * 更新用户信息
	 * @param userInfo
	 * @return
	 */
	int update(UserInfo userInfo);

	/**
	 * 校验邮箱是否已被占用
	 * @param email
	 * @return
	 */
	int countByEmail(String email);

	/**
	 * 根据邮箱查询用户
	 * @param email
	 * @return
	 */
	UserInfo selectUserByEmail(String email);

	/**
	 * 根据主键查询用户信息（后台管理专用）
	 * @param id 用户id
	 * @return
	 */
	UserInfo selectById(String id);

}