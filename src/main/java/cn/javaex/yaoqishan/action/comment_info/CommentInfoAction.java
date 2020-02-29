package cn.javaex.yaoqishan.action.comment_info;

import java.util.List;

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
import cn.javaex.yaoqishan.service.comment_info.CommentInfoService;
import cn.javaex.yaoqishan.service.user_info.UserInfoService;
import cn.javaex.yaoqishan.view.CommentInfo;
import cn.javaex.yaoqishan.view.Result;
import cn.javaex.yaoqishan.view.UserInfo;

@Controller
@RequestMapping("portal/comment_info")
public class CommentInfoAction {

	@Autowired
	private CommentInfoService commentInfoService;
	@Autowired
	private UserInfoService userInfoService;
	
	/**
	 * 保存用户评论
	 * @param videoId 视频主键
	 * @param userToken 用户凭证
	 * @param content 评论内容
	 * @return
	 * @throws QingException
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(
			HttpServletRequest request,
			@RequestParam(value="videoId") String videoId,
			@RequestParam(value="userToken") String userToken,
			@RequestParam(value="content") String content) throws QingException {
		
		// 校验用户是否登录
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
		
		commentInfoService.save(videoId, content, userInfo);
		
		return Result.success();
	}
	
	/**
	 * 获取某个视频的评论列表
	 * @param videoId 视频主键
	 * @return
	 */
	@RequestMapping("get_comment_list.json")
	@ResponseBody
	public Result getCommentList(
			@RequestParam(value="videoId") String videoId,
			@RequestParam(value="pageNum", defaultValue="1") int pageNum,
			@RequestParam(value="pageSize", defaultValue="10") int pageSize) {

		// pageHelper分页插件
		// 只需要在查询之前调用，传入当前页码，以及每一页显示多少条
		PageHelper.startPage(pageNum, pageSize);
		List<CommentInfo> list = commentInfoService.listByVideoId(videoId);
		PageInfo<CommentInfo> pageInfo = new PageInfo<CommentInfo>(list);
		
		return Result.success().add("pageInfo", pageInfo);
	}
	
	/**
	 * 获取某个视频的评论条数
	 * @param videoId 视频主键
	 * @return
	 */
	@RequestMapping("get_comment_count.json")
	@ResponseBody
	public Result getCommentCount(@RequestParam(value="videoId") String videoId) {

		int count = commentInfoService.getCommentCount(videoId);
		
		return Result.success().add("count", count);
	}
}
