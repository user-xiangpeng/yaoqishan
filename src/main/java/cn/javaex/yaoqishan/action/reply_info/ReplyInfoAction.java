package cn.javaex.yaoqishan.action.reply_info;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import cn.javaex.yaoqishan.constant.ErrorMsg;
import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.service.reply_info.ReplyInfoService;
import cn.javaex.yaoqishan.service.user_info.UserInfoService;
import cn.javaex.yaoqishan.view.ReplyInfo;
import cn.javaex.yaoqishan.view.Result;
import cn.javaex.yaoqishan.view.UserInfo;

@Controller
@RequestMapping("portal/reply_info")
public class ReplyInfoAction {

	@Autowired
	private ReplyInfoService replyInfoService;
	@Autowired
	private UserInfoService userInfoService;
	
	/**
	 * 保存用户回复
	 * @param videoId 视频主键
	 * @param commentId 评论主键
	 * @param userToken 用户凭证
	 * @param toUserId 被回复用户id
	 * @param toLoginName 被回复用户登录名
	 * @param content 回复内容
	 * @return
	 * @throws QingException
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(
			HttpServletRequest request,
			@RequestParam(value="videoId") String videoId,
			@RequestParam(value="commentId") String commentId,
			@RequestParam(value="userToken") String userToken,
			@RequestParam(value="toUserId") String toUserId,
			@RequestParam(value="toLoginName") String toLoginName,
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
		
		// 校验是否是自己回复自己
		if (toUserId.equals(userInfo.getId())) {
			throw new QingException(ErrorMsg.ERROR_900002);
		}
		
		// 校验回复内容
		if (StringUtils.isEmpty(content)) {
			throw new QingException(ErrorMsg.ERROR_900001);
		}
		
		// 删除普通标签
		content = content.replaceAll("<(S*?)[^>]*>.*?|<.*? />", "");
		// 删除转义字符
		content = content.replaceAll("&.{2,6}?;", "");
		
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = formatter.format(currentTime);
		
		// 保存回复内容
		ReplyInfo replyInfo = new ReplyInfo();
		replyInfo.setVideoId(videoId);
		replyInfo.setCommentId(commentId);
		replyInfo.setToUserId(toUserId);
		replyInfo.setToLoginName(toLoginName);
		replyInfo.setContent(content);
		replyInfo.setUserId(userInfo.getId());
		replyInfo.setLoginName(userInfo.getLoginName());
		replyInfo.setUpdateTime(now);
		
		replyInfoService.save(replyInfo);
		
		return Result.success();
	}
	
}
