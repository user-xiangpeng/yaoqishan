package cn.javaex.yaoqishan.action.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.service.group_info.GroupInfoService;
import cn.javaex.yaoqishan.service.user_info.UserInfoService;
import cn.javaex.yaoqishan.view.GroupInfo;
import cn.javaex.yaoqishan.view.Result;
import cn.javaex.yaoqishan.view.UserInfo;

@Controller
@RequestMapping("admin/user_info")
public class UserAction {

	@Autowired
	private UserInfoService userInfoService;
	@Autowired
	private GroupInfoService groupInfoService;
	
	/**
	 * 查询所有用户（正常）
	 */
	@RequestMapping("list_normal.action")
	public String listNormal(ModelMap map,
			@RequestParam(required=false, value="groupId") String groupId,
			@RequestParam(required=false, value="keyWord") String keyWord,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue="10") int pageSize) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (!StringUtils.isEmpty(groupId)) {
			param.put("groupId", groupId);
			map.put("groupId", groupId);
		}
		if (!StringUtils.isEmpty(keyWord)) {
			param.put("keyWord", keyWord.trim());
			map.put("keyWord", keyWord);
		}
		param.put("status", "1");
		
		// pageHelper分页插件
		// 只需要在查询之前调用，传入当前页码，以及每一页显示多少条
		PageHelper.startPage(pageNum, pageSize);
		List<UserInfo> list = userInfoService.list(param);
		PageInfo<UserInfo> pageInfo = new PageInfo<UserInfo>(list);
		map.put("pageInfo", pageInfo);
		
		// 查询所有用户组
		List<GroupInfo> groupList = groupInfoService.list();
		map.put("groupList", groupList);
		
		return "admin/user_info/list_normal";
	}
	
	/**
	 * 查询所有用户（未激活）
	 */
	@RequestMapping("list_not_active.action")
	public String listNotActive(ModelMap map,
			@RequestParam(required=false, value="groupId") String groupId,
			@RequestParam(required=false, value="keyWord") String keyWord,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue="10") int pageSize) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (!StringUtils.isEmpty(groupId)) {
			param.put("groupId", groupId);
			map.put("groupId", groupId);
		}
		if (!StringUtils.isEmpty(keyWord)) {
			param.put("keyWord", keyWord.trim());
			map.put("keyWord", keyWord);
		}
		param.put("status", "0");
		
		// pageHelper分页插件
		// 只需要在查询之前调用，传入当前页码，以及每一页显示多少条
		PageHelper.startPage(pageNum, pageSize);
		List<UserInfo> list = userInfoService.list(param);
		PageInfo<UserInfo> pageInfo = new PageInfo<UserInfo>(list);
		map.put("pageInfo", pageInfo);
		
		// 查询所有用户组
		List<GroupInfo> groupList = groupInfoService.list();
		map.put("groupList", groupList);
		
		return "admin/user_info/list_not_active";
	}
	
	/**
	 * 查询所有用户（封禁）
	 */
	@RequestMapping("list_ban.action")
	public String listBan(ModelMap map,
			@RequestParam(required=false, value="groupId") String groupId,
			@RequestParam(required=false, value="keyWord") String keyWord,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue="10") int pageSize) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		if (!StringUtils.isEmpty(groupId)) {
			param.put("groupId", groupId);
			map.put("groupId", groupId);
		}
		if (!StringUtils.isEmpty(keyWord)) {
			param.put("keyWord", keyWord.trim());
			map.put("keyWord", keyWord);
		}
		param.put("status", "2");
		
		// pageHelper分页插件
		// 只需要在查询之前调用，传入当前页码，以及每一页显示多少条
		PageHelper.startPage(pageNum, pageSize);
		List<UserInfo> list = userInfoService.list(param);
		PageInfo<UserInfo> pageInfo = new PageInfo<UserInfo>(list);
		map.put("pageInfo", pageInfo);
		
		// 查询所有用户组
		List<GroupInfo> groupList = groupInfoService.list();
		map.put("groupList", groupList);
		
		return "admin/user_info/list_ban";
	}
	
	/**
	 * 批量更新用户状态
	 * @param idArr 用户id数组
	 * @param status 状态
	 * @return
	 */
	@RequestMapping("batch_update_status.json")
	@ResponseBody
	public Result batchUpdateStatus(
			@RequestParam(value = "idArr") String[] idArr,
			@RequestParam(value = "status") String status) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("idArr", idArr);
		param.put("status", status);
		
		userInfoService.batchUpdateStatus(param);
		
		return Result.success();
	}
	
	/**
	 * 批量更换用户所在用户组
	 * @param idArr 用户id数组
	 * @param status 状态
	 * @return
	 */
	@RequestMapping("batch_change_group.json")
	@ResponseBody
	public Result batchChangeGroup(
			@RequestParam(value = "idArr") String[] idArr,
			@RequestParam(value = "groupId") String groupId) {
		
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("userIdArr", idArr);
		param.put("groupId", groupId);
		
		userInfoService.batchChangeGroup(param);
		
		return Result.success();
	}
	
	/**
	 * 批量删除封禁用户的内容
	 * @param idArr 用户id数组
	 * @param deleteArr 删除内容表名数组
	 * @return
	 */
	@RequestMapping("batch_delete_content.json")
	@ResponseBody
	public Result batchDeleteContent(
			@RequestParam(value = "idArr") String[] idArr,
			@RequestParam(value = "deleteArr") String[] deleteArr) {

		userInfoService.batchDeleteContent(idArr, deleteArr);
		
		return Result.success();
	}
	
	/**
	 * 用户编辑
	 * @param map
	 * @param id 用户id
	 * @return
	 */
	@RequestMapping("edit.action")
	public String edit(ModelMap map,
			@RequestParam(required = false, value = "id") String id) {
		
		// 查询单个用户的信息
		if (!StringUtils.isEmpty(id)) {
			UserInfo userInfo = userInfoService.selectById(id);
			// 此处有BUG，不能使用userInfo，否则id为空时，会默认获取管理员的信息，导致无法添加新用户
			map.put("editUserInfo", userInfo);
		}
		
		// 查询所有用户组
		List<GroupInfo> groupList = groupInfoService.list();
		map.put("groupList", groupList);
		
		map.put("id", id);
		return "admin/user_info/edit";
	}
	
	/**
	 * 保存用户信息
	 * @param idArr
	 * @param status
	 * @return
	 * @throws QingException
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(UserInfo userInfo) throws QingException {
		
		userInfoService.save(userInfo);
		
		return Result.success();
	}
}
