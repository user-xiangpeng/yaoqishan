package cn.javaex.yaoqishan.service.comment_info;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.javaex.yaoqishan.constant.ErrorMsg;
import cn.javaex.yaoqishan.dao.comment_info.ICommentInfoDAO;
import cn.javaex.yaoqishan.dao.reply_info.IReplyInfoDAO;
import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.view.CommentInfo;
import cn.javaex.yaoqishan.view.ReplyInfo;
import cn.javaex.yaoqishan.view.UserInfo;

@Service("CommentInfoService")
public class CommentInfoService {
	@Autowired
	private ICommentInfoDAO iCommentInfoDAO;
	@Autowired
	private IReplyInfoDAO iReplyInfoDAO;

	/**
	 * 保存用户评论
	 * @param videoId
	 * @param content
	 * @param userInfo
	 * @throws QingException
	 */
	public void save(String videoId, String content, UserInfo userInfo) throws QingException {
		
		// 1.0 校验评论内容
		if (StringUtils.isEmpty(content)) {
			throw new QingException(ErrorMsg.ERROR_900001);
		}
		
		// 删除普通标签
		content = content.replaceAll("<(S*?)[^>]*>.*?|<.*? />", "");
		// 删除转义字符
		content = content.replaceAll("&.{2,6}?;", "");

		// 2.0 保存评论内容
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = formatter.format(currentTime);
		
		CommentInfo commentInfo = new CommentInfo();
		commentInfo.setVideoId(videoId);
		commentInfo.setUserId(userInfo.getId());
		commentInfo.setLoginName(userInfo.getLoginName());
		commentInfo.setContent(content);
		commentInfo.setUpdateTime(now);
		
		iCommentInfoDAO.insert(commentInfo);
	}
	
	/**
	 * 获取某个视频的评论列表
	 * @param videoId 视频主键
	 * @return
	 */
	public List<CommentInfo> listByVideoId(String videoId) {
		List<CommentInfo> list = iCommentInfoDAO.listByVideoId(videoId);
		if (list!=null && list.isEmpty()==false) {
			int len = list.size();
			for (int i=0; i<len; i++) {
				// 查询该评论下的回复列表
				List<ReplyInfo> replyInfoLsit = iReplyInfoDAO.listByCommentId(list.get(i).getId());
				list.get(i).setReplyInfoLsit(replyInfoLsit);
			}
		}
		
		return list;
	}

	/**
	 * 获取某个视频的评论条数
	 * @param videoId 视频id
	 * @return
	 */
	public int getCommentCount(String videoId) {
		// 评论条数
		int commentCount = iCommentInfoDAO.countByVideoId(videoId);
		// 回复条数
		int replyCount = iReplyInfoDAO.countByVideoId(videoId);
		
		return (commentCount+replyCount);
	}

}
