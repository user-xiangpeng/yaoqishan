package cn.javaex.yaoqishan.action.collection_info;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

import cn.javaex.yaoqishan.constant.ErrorMsg;
import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.service.collection_info.CollectionInfoService;
import cn.javaex.yaoqishan.service.user_info.UserInfoService;
import cn.javaex.yaoqishan.view.CollectionInfo;
import cn.javaex.yaoqishan.view.Result;
import cn.javaex.yaoqishan.view.UserInfo;

@Controller
@RequestMapping("portal/collection_info")
public class CollectionInfoAction {

	@Autowired
	private CollectionInfoService collectionInfoService;
	@Autowired
	private UserInfoService userInfoService;
	
	/**
	 * 判断当前视频是否已被用户收藏过了
	 * @throws QingException
	 */
	@RequestMapping("isCollectioned_by_user.json")
	@ResponseBody
	public Result isCollectionedByUser(
			@RequestParam(value="mediaId") String mediaId,
			@RequestParam(value="userId") String userId) throws QingException {
		
		if (StringUtils.isEmpty(userId)) {
			throw new QingException(ErrorMsg.ERROR_100012);
		}

		int count = collectionInfoService.countByMediaIdAndUserId(mediaId, userId);
		if (count>0) {
			throw new QingException(ErrorMsg.ERROR_X00001);
		}
		
		return Result.success();
	}
	
	/**
	 * 添加视频收藏
	 * @throws QingException
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(
			HttpServletRequest request,
			@RequestParam(value="mediaId") String mediaId,
			@RequestParam(value="userToken") String userToken) throws QingException {
		
		if (StringUtils.isEmpty(userToken)) {
			throw new QingException(ErrorMsg.ERROR_100012);
		}
		
		// 判断session
		HttpSession session  = request.getSession();
		// 从session中取出用户身份信息
		UserInfo userInfo = (UserInfo)session.getAttribute("userInfo");
		
		if (userInfo==null) {
			userInfo = userInfoService.getUserInfoByUserToken(userToken);
			// 将用户信息保存进session
			request.getSession().setAttribute("userInfo", userInfo);
		}
		
		CollectionInfo collectionInfo = new CollectionInfo();
		collectionInfo.setMediaId(mediaId);
		collectionInfo.setUserId(userInfo.getId());
		
		collectionInfoService.save(collectionInfo);

		return Result.success();
	}
	
	/**
	 * 获取收藏列表
	 * @param request
	 * @param userToken 用户凭证
	 * @param pageNum
	 * @param pageSize
	 * @return
	 * @throws QingException
	 */
	@RequestMapping("get_collection_list.json")
	@ResponseBody
	public Result getCollectionList(
			HttpServletRequest request,
			@RequestParam(value="userToken") String userToken,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue="15") int pageSize) throws QingException {

		if (StringUtils.isEmpty(userToken)) {
			throw new QingException(ErrorMsg.ERROR_100012);
		}
		
		// 判断session
		HttpSession session  = request.getSession();
		// 从session中取出用户身份信息
		UserInfo userInfo = (UserInfo)session.getAttribute("userInfo");
		
		if (userInfo==null) {
			userInfo = userInfoService.getUserInfoByUserToken(userToken);
			// 将用户信息保存进session
			request.getSession().setAttribute("userInfo", userInfo);
		}
		
		// pageHelper分页插件
		// 只需要在查询之前调用，传入当前页码，以及每一页显示多少条
		PageHelper.startPage(pageNum, pageSize);
		List<Map<String, Object>> list = collectionInfoService.listCollection(userInfo.getId());
		PageInfo<Map<String, Object>> pageInfo = new PageInfo<Map<String, Object>>(list);
		
		return Result.success().add("pageInfo", pageInfo);
	}
	
	/**
	 * 删除收藏的视频
	 * @param request
	 * @param mediaId 媒体主键
	 * @param userToken 用户凭证
	 * @return
	 * @throws QingException
	 */
	@RequestMapping("delete_collection.json")
	@ResponseBody
	public Result deleteCollection(
			HttpServletRequest request,
			@RequestParam(required=false, value="mediaId") String mediaId,
			@RequestParam(value="userToken") String userToken) throws QingException {
		
		if (StringUtils.isEmpty(userToken)) {
			throw new QingException(ErrorMsg.ERROR_100012);
		}

		// 判断session
		HttpSession session  = request.getSession();
		// 从session中取出用户身份信息
		UserInfo userInfo = (UserInfo)session.getAttribute("userInfo");
		
		if (userInfo==null) {
			userInfo = userInfoService.getUserInfoByUserToken(userToken);
			// 将用户信息保存进session
			request.getSession().setAttribute("userInfo", userInfo);
		}
		
		CollectionInfo collectionInfo = new CollectionInfo();
		collectionInfo.setMediaId(mediaId);
		collectionInfo.setUserId(userInfo.getId());
		
		collectionInfoService.delete(collectionInfo);
		
		return Result.success();
	}
}
