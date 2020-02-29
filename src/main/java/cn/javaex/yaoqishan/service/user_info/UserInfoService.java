package cn.javaex.yaoqishan.service.user_info;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.javaex.yaoqishan.constant.ErrorMsg;
import cn.javaex.yaoqishan.dao.activate_info.IActivateInfoDAO;
import cn.javaex.yaoqishan.dao.collection_info.ICollectionInfoDAO;
import cn.javaex.yaoqishan.dao.comment_info.ICommentInfoDAO;
import cn.javaex.yaoqishan.dao.history_info.IHistoryInfoDAO;
import cn.javaex.yaoqishan.dao.reply_info.IReplyInfoDAO;
import cn.javaex.yaoqishan.dao.user_info.IUserInfoDAO;
import cn.javaex.yaoqishan.dao.user_profile_info.IUserProfileInfoDAO;
import cn.javaex.yaoqishan.dao.web_info.IWebInfoDAO;
import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.service.activate_info.ActivateInfoService;
import cn.javaex.yaoqishan.service.email_info.EmailInfoService;
import cn.javaex.yaoqishan.service.group_info.GroupInfoService;
import cn.javaex.yaoqishan.util.GetIp;
import cn.javaex.yaoqishan.util.Jiami;
import cn.javaex.yaoqishan.util.MD5;
import cn.javaex.yaoqishan.view.ActivateInfo;
import cn.javaex.yaoqishan.view.UserInfo;
import cn.javaex.yaoqishan.view.UserProfileInfo;
import cn.javaex.yaoqishan.view.WebInfo;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

@Service("UserInfoService")
public class UserInfoService {
	@Autowired
	private IUserInfoDAO iUserInfoDAO;
	@Autowired
	private IUserProfileInfoDAO iUserProfileInfoDAO;
	@Autowired
	private GroupInfoService groupInfoService;
	@Autowired
	private EmailInfoService emailInfoService;
	@Autowired
	private IWebInfoDAO iWebInfoDAO;
	@Autowired
	private ActivateInfoService activateInfoService;
	@Autowired
	private IActivateInfoDAO iActivateInfoDAO;
	@Autowired
	private IReplyInfoDAO iReplyInfoDAO;
	@Autowired
	private ICommentInfoDAO iCommentInfoDAO;
	@Autowired
	private ICollectionInfoDAO iCollectionInfoDAO;
	@Autowired
	private IHistoryInfoDAO iHistoryInfoDAO;
	
	/**
	 * 查询所有用户
	 * @param param
	 * @return
	 */
	public List<UserInfo> list(Map<String, Object> param) {
		return iUserInfoDAO.list(param);
	}
	
	/**
	 * 校验用户登录
	 * @param loginName 登录名
	 * @param passWord 登录密码
	 * @return
	 */
	public UserInfo selectUser(String loginName, String passWord) {
		return iUserInfoDAO.selectUser(loginName, passWord);
	}

	/**
	 * 校验账号是否已经被注册
	 * @param loginName 注册时填写的账号
	 * @param email 注册时填写的邮箱
	 * @return
	 */
	public int countUser(String loginName, String email) {
		return iUserInfoDAO.countUser(loginName, email);
	}

	/**
	 * 注册新用户
	 * @param UserInfo
	 * @return 
	 * @throws QingException 
	 */
	public Map<String, Object> register(HttpServletRequest request) throws QingException {
		// 1.0 获取注册参数
		String szLoginName = request.getParameter("loginName");
		String szPassWord = request.getParameter("passWord");
		String szEmail = request.getParameter("email");
		
		// 2.0 校验注册信息
		// 2.1 校验账号是否填写
		if (StringUtils.isEmpty(szLoginName)) {
			throw new QingException(ErrorMsg.ERROR_100004);
		}
		// 2.2 校验账号长度
		szLoginName = szLoginName.replaceAll("\\s*", "");
		if (szLoginName.length()<4 || szLoginName.length()>10) {
			throw new QingException(ErrorMsg.ERROR_100005);
		}
		
		// 2.3 校验密码是否填写
		if (StringUtils.isEmpty(szPassWord)) {
			throw new QingException(ErrorMsg.ERROR_100006);
		}
		// 2.4 校验密码长度
		szPassWord = szPassWord.replaceAll("\\s*", "");
		if (szPassWord.length()<6 || szPassWord.length()>16) {
			throw new QingException(ErrorMsg.ERROR_100007);
		}
		
		// 2.5 校验邮箱是否填写
		if (StringUtils.isEmpty(szEmail)) {
			throw new QingException(ErrorMsg.ERROR_100008);
		}
		
		int count = 0;
		// 2.6 校验账号是否已被占用
		count = countUser(szLoginName, null);
		if (count>0) {
			throw new QingException(ErrorMsg.ERROR_100009);
		}
		// 2.7 校验邮箱是否已被占用
		szEmail = szEmail.replaceAll("\\s*", "").toLowerCase();
		count = countUser(null, szEmail);
		if (count>0) {
			throw new QingException(ErrorMsg.ERROR_100010);
		}
		
		// 3.0 注册新用户
		String szUserIp = GetIp.getIp(request);
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = formatter.format(currentTime);
		
		UserInfo userInfo = new UserInfo();
		userInfo.setLoginName(szLoginName);
		userInfo.setPassWord(MD5.md5(szPassWord));
		userInfo.setEmail(szEmail);
		userInfo.setRegisterTime(now);
		userInfo.setRegisterIp(szUserIp);
		userInfo.setLastLoginTime(now);
		userInfo.setLastLoginIp(szUserIp);
		userInfo.setStatus("0");	// 账号未激活
		
		iUserInfoDAO.insert(userInfo);
		
		UserProfileInfo userProfileInfo = new UserProfileInfo();
		userProfileInfo.setUserId(userInfo.getId());
		userProfileInfo.setGroupId("2");	// 注册会员
		userProfileInfo.setPoint(0);		// 积分0份
		iUserProfileInfoDAO.insert(userProfileInfo);
		
		// 4.0 对用户信息进行加密，用于cookie存储
		// 用户id
		String UID = userInfo.getId();
		// 用户的登录名和密码
		String userToken = Jiami.getInstance().encrypt(szLoginName) + "&&" + Jiami.getInstance().encrypt(szPassWord);
		// 将用户名转为没有特殊字符的base64编码
		BASE64Encoder encoder = new BASE64Encoder();
		userToken = encoder.encode(userToken.getBytes());
		
		Map<String, Object> info = new HashMap<String, Object>();
		info.put("UID", UID);
		info.put("userToken", userToken);
		
		return info;
	}
	
	/**
	 * 根据主键查询用户信息
	 * @param id
	 * @return
	 */
	public UserInfo selectUserById(String id) {
		return iUserInfoDAO.selectUserById(id);
	}

	/**
	 * 用户登录
	 * @param request
	 * @return
	 * @throws QingException 
	 * @throws UnsupportedEncodingException 
	 */
	public Map<String, Object> login(HttpServletRequest request) throws QingException, UnsupportedEncodingException {
		// 1.0 获取登录参数
		String szLoginName = request.getParameter("loginName");
		String szPassWord = request.getParameter("passWord");
		
		// 2.0 校验用户
		// 2.1 校验用户名或密码是否填写
		if (StringUtils.isEmpty(szLoginName) || StringUtils.isEmpty(szPassWord)) {
			throw new QingException(ErrorMsg.ERROR_100001);
		}
		
		// 2.2 校验用户名、密码是否正确
		UserInfo userInfo = selectUser(szLoginName, MD5.md5(szPassWord));
		if (userInfo==null) {
			throw new QingException(ErrorMsg.ERROR_100002);
		}
		
		// 2.3 校验用户是否正常
		if ("0".equals(userInfo.getStatus())) {
			throw new QingException(ErrorMsg.ERROR_100019);
		}
		if ("2".equals(userInfo.getStatus())) {
			throw new QingException(ErrorMsg.ERROR_100003);
		}
		
		// 3.0 将用户信息保存进session
		request.getSession().setAttribute("userInfo", userInfo);
		
		// 4.0 对用户信息进行加密，用于cookie存储
		// 用户id
		String UID = userInfo.getId();
		// 用户的登录名和密码
		String userToken = Jiami.getInstance().encrypt(szLoginName) + "&&" + Jiami.getInstance().encrypt(szPassWord);
		// 将用户名转为没有特殊字符的base64编码
		BASE64Encoder encoder = new BASE64Encoder();
		userToken = encoder.encode(userToken.getBytes());
		
		Map<String, Object> info = new HashMap<String, Object>();
		info.put("UID", UID);
		info.put("userToken", userToken);
		
		return info;
	}

	/**
	 * 根据userToken，获取用户信息
	 * @param userToken
	 * @return
	 * @throws QingException
	 */
	public UserInfo getUserByUserToken(String userToken) throws QingException {
		// userToken编码转换
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] decoderBase64;
		try {
			decoderBase64 = decoder.decodeBuffer(userToken);
			userToken = new String(decoderBase64);
		} catch (IOException e) {
			throw new QingException(ErrorMsg.ERROR_100012);
		}
		
		String[] arr = userToken.split("&&");
		if (arr.length<=1) {
			throw new QingException(ErrorMsg.ERROR_100012);
		}
		
		// userToken解密
		String szLoginName = Jiami.getInstance().decrypt(arr[0]);
		String szPassWord = Jiami.getInstance().decrypt(arr[1]);
		
		// 根据主键查询用户信息
		UserInfo userInfo = selectUser(szLoginName, MD5.md5(szPassWord));
		if (userInfo==null) {
			throw new QingException(ErrorMsg.ERROR_100012);
		}
		
		return userInfo;
	}
	
	/**
	 * 根据userToken，自动登录
	 * @param userToken
	 * @return
	 * @throws QingException
	 */
	public UserInfo getUserInfoByUserToken(String userToken) throws QingException {
		// userToken编码转换
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] decoderBase64;
		try {
			decoderBase64 = decoder.decodeBuffer(userToken);
			userToken = new String(decoderBase64);
		} catch (IOException e) {
			throw new QingException(ErrorMsg.ERROR_100012);
		}
		
		String[] arr = userToken.split("&&");
		if (arr.length<=1) {
			throw new QingException(ErrorMsg.ERROR_100012);
		}
		
		// userToken解密
		String szLoginName = Jiami.getInstance().decrypt(arr[0]);
		String szPassWord = Jiami.getInstance().decrypt(arr[1]);
		
		// 根据主键查询用户信息
		UserInfo userInfo = selectUser(szLoginName, MD5.md5(szPassWord));
		if (userInfo==null) {
			throw new QingException(ErrorMsg.ERROR_100012);
		}
		// 校验用户是否正常
		if ("0".equals(userInfo.getStatus())) {
			throw new QingException(ErrorMsg.ERROR_100019);
		}
		if ("2".equals(userInfo.getStatus())) {
			throw new QingException(ErrorMsg.ERROR_100003);
		}
		
		return userInfo;
	}

	/**
	 * 根据token获取用户权限
	 * @param token
	 * @return
	 * @throws QingException 
	 */
	public String getUserPower(String token) throws QingException {
		if (StringUtils.isEmpty(token)) {
			throw new QingException(ErrorMsg.ERROR_100012);
		}
		
		String[] arr = token.split("&&");
		if (arr.length<=1) {
			throw new QingException(ErrorMsg.ERROR_100012);
		}
		String szLoginName = Jiami.getInstance().decrypt(arr[0]);
		String szPassWord = Jiami.getInstance().decrypt(arr[1]);

		// 根据主键查询用户信息
		UserInfo userInfo = selectUser(szLoginName, MD5.md5(szPassWord));
		if (userInfo==null) {
			throw new QingException(ErrorMsg.ERROR_100012);
		}
		
		// 用户权限
		String power = groupInfoService.selectPowerByUserId(userInfo.getId());
		
		return power;
	}

	/**
	 * 批量更新用户状态
	 * @param param
	 */
	public void batchUpdateStatus(Map<String, Object> param) {
		iUserInfoDAO.batchUpdate(param);
	}

	/**
	 * 批量更换用户所在用户组
	 * @param param
	 */
	public void batchChangeGroup(Map<String, Object> param) {
		iUserProfileInfoDAO.batchUpdate(param);
	}
	
	/**
	 * 页面一加载就获取用户信息
	 * @param request
	 * @return
	 */
	public UserInfo getUserInfo(HttpServletRequest request) {
		String userToken = "";
		Cookie[] cookieArr = request.getCookies();
		if (cookieArr!=null && cookieArr.length>0) {
			for (int i=0; i<cookieArr.length; i++) {
				Cookie cookie = cookieArr[i];
				if ("userToken".equals(cookie.getName())) {
					try {
						userToken = URLDecoder.decode(cookie.getValue(), "UTF-8");
					} catch (UnsupportedEncodingException e) {
						break;
					}
					break;
				}
			}
		}
		
		if (!StringUtils.isEmpty(userToken)) {
			// 判断session
			HttpSession session  = request.getSession();
			// 从session中取出用户身份信息
			UserInfo userInfo = (UserInfo)session.getAttribute("userInfo");
			
			if (userInfo==null) {
				try {
					userInfo = getUserInfoByUserToken(userToken);
					// 将用户信息保存进session
					request.getSession().setAttribute("userInfo", userInfo);
				} catch (QingException e) {
					// 用户凭证是伪造的
					return null;
				}
			}
			
			return userInfo;
		}
		
		return null;
	}

	/**
	 * 用户自己修改密码
	 * @param userInfo
	 */
	public void changePassWord(UserInfo userInfo) {
		iUserInfoDAO.update(userInfo);
	}

	/**
	 * 用户换绑邮箱验证
	 * @param userInfo 用户信息
	 * @param subject 邮件标题
	 * @param type 验证类型
	 * @throws QingException
	 */
	public void sendEmail(UserInfo userInfo, String subject, String type) throws QingException {
		// 获取站点信息
		WebInfo webInfo = iWebInfoDAO.select();
		String webName = webInfo.getName();
		
		// 获取当前系统时间
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = formatter.format(currentTime);
		
		String verificationCode = String.valueOf((int)((Math.random()*9+1)*100000));
		
		// 生成邮件内容
		StringBuffer content = new StringBuffer();
		content.append("<div style='background:#f7f7f7;overflow:hidden'>");
		content.append("<div style='background:#fff;border:1px solid #ccc;margin:2%;padding:0 30px'>");
		content.append("<div style='line-height:40px;height:40px'>&nbsp;</div>");
		content.append("<p style='margin:0;padding:0;font-size:14px;line-height:30px;color:#333;font-family:arial,sans-serif;font-weight:bold'>亲爱的用户 <b style='font-size:18px;color:#f90'>"+userInfo.getLoginName()+"</b>：</p>");
		content.append("<div style='line-height:20px;height:20px'>&nbsp;</div>");
		content.append("<p style='margin:0;padding:0;line-height:30px;font-size:14px;color:#333;font-family:'宋体',arial,sans-serif'>您好！感谢您使用"+webName+"服务，您正在进行邮箱验证，本次请求的验证码为：</p>");
		content.append("<p style='margin:0;padding:0;line-height:30px;font-size:14px;color:#333;font-family:'宋体',arial,sans-serif'>");
		content.append("<b style='font-size:18px;color:#f90'>"+verificationCode+"</b>");
		content.append("<span style='margin:0;padding:0;margin-left:10px;line-height:30px;font-size:14px;color:#979797;font-family:'宋体',arial,sans-serif'>(为了保障您账号的安全性，请在1小时内完成验证。)</span>");
		content.append("</p>");
		content.append("<div style='line-height:80px;height:80px'>&nbsp;</div>");
		content.append("<p style='margin:0;padding:0;line-height:30px;font-size:14px;color:#333;font-family:'宋体',arial,sans-serif'>"+webName+"团队</p>");
		content.append("<p style='margin:0;padding:0;line-height:30px;font-size:14px;color:#333;font-family:'宋体',arial,sans-serif'>"+now+"</p>");
		content.append("</div>");
		content.append("</div>");
		
		// 发送验证码邮件
		emailInfoService.sendEmail(userInfo.getEmail(), subject, content.toString());
		
		// 生成验证码有效期
		ActivateInfo activateInfo = new ActivateInfo();
		activateInfo.setUserId(userInfo.getId());
		activateInfo.setType(type);	// 用户修改邮箱
		activateInfo.setCode(verificationCode);
		activateInfo.setCreateTime(now);
		
		activateInfoService.save(activateInfo);
	}

	/**
	 * 用户自己修改邮箱
	 * @param userInfo
	 * @param identifyingCode 验证码
	 * @throws QingException
	 * @throws ParseException 
	 */
	public void changeEmail(UserInfo userInfo, String identifyingCode) throws QingException, ParseException {
		// 1.0 验证新邮箱是否已经被占用
		int count = iUserInfoDAO.countByEmail(userInfo.getEmail());
		if (count>0) {
			throw new QingException(ErrorMsg.ERROR_100017);
		}
		
		// 2.0 获取验证记录
		ActivateInfo activateInfo = iActivateInfoDAO.selectByUserIdAndType(userInfo.getId(), "change_email");
		if (activateInfo==null) {
			throw new QingException(ErrorMsg.ERROR_X00002);
		}
		
		// 3.0 校验
		// 3.1 校验验证码是否正确
		if (!identifyingCode.equals(activateInfo.getCode())) {
			throw new QingException(ErrorMsg.ERROR_100014);
		}
		
		// 3.2 校验验证码是否已过期
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = formatter.format(currentTime);
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date d1 = df.parse(now);
		Date d2 = df.parse(activateInfo.getCreateTime());
		long diff = d1.getTime() - d2.getTime();
		long hours = diff / (1000 * 60 * 60);
//			System.out.println("diff:"+diff);
//			System.out.println("hours"+hours);
		if (hours>0) {
			throw new QingException(ErrorMsg.ERROR_100015);
		}
		
		// 4.0 修改用户邮箱
		iUserInfoDAO.update(userInfo);
		
		// 5.0 删除验证记录
		iActivateInfoDAO.delete(activateInfo.getId());
		
	}

	/**
	 * 邮箱验证，激活账号
	 * @param userInfo
	 * @param identifyingCode
	 * @throws QingException
	 * @throws ParseException
	 */
	public void validateEmail(UserInfo userInfo, String identifyingCode) throws QingException, ParseException {
		// 1.0 获取验证记录
		ActivateInfo activateInfo = iActivateInfoDAO.selectByUserIdAndType(userInfo.getId(), "register");
		if (activateInfo==null) {
			throw new QingException(ErrorMsg.ERROR_X00002);
		}
		
		// 2.0 校验
		// 2.1 校验验证码是否正确
		if (!identifyingCode.equals(activateInfo.getCode())) {
			throw new QingException(ErrorMsg.ERROR_100014);
		}
		
		// 2.2 校验验证码是否已过期
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = formatter.format(currentTime);
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date d1 = df.parse(now);
		Date d2 = df.parse(activateInfo.getCreateTime());
		long diff = d1.getTime() - d2.getTime();
		long hours = diff / (1000 * 60 * 60);
//		System.out.println("diff:"+diff);
//		System.out.println("hours"+hours);
		if (hours>0) {
			throw new QingException(ErrorMsg.ERROR_100015);
		}
		
		// 3.0 修改用户状态
		iUserInfoDAO.update(userInfo);
		
		// 4.0 删除验证记录
		iActivateInfoDAO.delete(activateInfo.getId());
	}

	/**
	 * 用户找回密码，发送邮箱验证码
	 * @param email 用户填写的邮箱地址
	 * @throws QingException 
	 */
	public void findPwdEmail(String email) throws QingException {
		
		if (StringUtils.isEmpty(email)) {
			throw new QingException(ErrorMsg.ERROR_100008);
		}
		
		// 校验邮箱是否存在
		UserInfo userInfo = iUserInfoDAO.selectUserByEmail(email);
		if (userInfo==null) {
			throw new QingException(ErrorMsg.ERROR_100018);
		}
		
		sendEmail(userInfo, "找回密码验证", "find_pwd");
	}

	/**
	 * 用户找回密码，校验验证码
	 * @param email 邮箱
	 * @param identifyingCode 验证码
	 * @throws QingException
	 * @throws ParseException
	 */
	public void findPwdCode(String email, String identifyingCode) throws QingException, ParseException {
		// 1.0 校验验证码是否正确
		ActivateInfo activateInfo = iActivateInfoDAO.selectByEmailAndCodeAndType(email, identifyingCode, "find_pwd");
		if (activateInfo==null) {
			throw new QingException(ErrorMsg.ERROR_100014);
		}

		// 2.0 校验验证码是否已过期
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = formatter.format(currentTime);
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date d1 = df.parse(now);
		Date d2 = df.parse(activateInfo.getCreateTime());
		long diff = d1.getTime() - d2.getTime();
		long hours = diff / (1000 * 60 * 60);
//		System.out.println("diff:"+diff);
//		System.out.println("hours:"+hours);
		if (hours>0) {
			throw new QingException(ErrorMsg.ERROR_100015);
		}
	}

	/**
	 * 用户自己设置新的密码
	 * @param email 邮箱地址
	 * @param identifyingCode 邮箱验证码
	 * @param passWord 新密码
	 * @throws QingException
	 * @throws ParseException
	 */
	public void setNewPassWord(String email, String identifyingCode, String passWord) throws QingException, ParseException {
		if (StringUtils.isEmpty(passWord)) {
			throw new QingException(ErrorMsg.ERROR_100006);
		}
		
		passWord = passWord.replaceAll("\\s*", "");
		if (passWord.length()<6 || passWord.length()>16) {
			throw new QingException(ErrorMsg.ERROR_100007);
		}
		
		// 获取用户id
		ActivateInfo activateInfo = iActivateInfoDAO.selectByEmailAndCodeAndType(email, identifyingCode, "find_pwd");
		if (activateInfo==null) {
			throw new QingException(ErrorMsg.ERROR_100014);
		}
		// 校验验证码是否已过期
		Date currentTime = new Date();
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String now = formatter.format(currentTime);
		
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		Date d1 = df.parse(now);
		Date d2 = df.parse(activateInfo.getCreateTime());
		long diff = d1.getTime() - d2.getTime();
		long hours = diff / (1000 * 60 * 60);
		if (hours>0) {
			throw new QingException(ErrorMsg.ERROR_100015);
		}
		
		UserInfo userInfo = new UserInfo();
		userInfo.setId(activateInfo.getUserId());
		userInfo.setPassWord(MD5.md5(passWord));
		
		iUserInfoDAO.update(userInfo);
	}

	/**
	 * 根据主键查询用户信息（后台管理专用）
	 * @param id 用户id
	 * @return
	 */
	public UserInfo selectById(String id) {
		return iUserInfoDAO.selectById(id);
	}

	/**
	 * 保存用户信息
	 * @param userInfo
	 * @throws QingException
	 */
	public void save(UserInfo userInfo) throws QingException {
		if (StringUtils.isEmpty(userInfo.getId())) {
			// 新增
			// 1.0 获取注册参数
			String szLoginName = userInfo.getLoginName();
			String szPassWord = userInfo.getPassWord();
			String szEmail = userInfo.getEmail();
			
			// 2.0 校验注册信息
			// 2.1 校验账号是否填写
			if (StringUtils.isEmpty(szLoginName)) {
				throw new QingException(ErrorMsg.ERROR_100004);
			}
			// 2.2 校验账号长度
			szLoginName = szLoginName.replaceAll("\\s*", "");
			if (szLoginName.length()<4 || szLoginName.length()>10) {
				throw new QingException(ErrorMsg.ERROR_100005);
			}
			
			// 2.3 校验密码是否填写
			if (StringUtils.isEmpty(szPassWord)) {
				throw new QingException(ErrorMsg.ERROR_100006);
			}
			// 2.4 校验密码长度
			szPassWord = szPassWord.replaceAll("\\s*", "");
			if (szPassWord.length()<6 || szPassWord.length()>16) {
				throw new QingException(ErrorMsg.ERROR_100007);
			}
			
			// 2.5 校验邮箱是否填写
			if (StringUtils.isEmpty(szEmail)) {
				throw new QingException(ErrorMsg.ERROR_100008);
			}
			
			int count = 0;
			// 2.6 校验账号是否已被占用
			count = countUser(szLoginName, null);
			if (count>0) {
				throw new QingException(ErrorMsg.ERROR_100009);
			}
			// 2.7 校验邮箱是否已被占用
			szEmail = szEmail.replaceAll("\\s*", "").toLowerCase();
			count = countUser(null, szEmail);
			if (count>0) {
				throw new QingException(ErrorMsg.ERROR_100010);
			}
			
			// 3.0 注册新用户
			// 获取当前时间
			Date currentTime = new Date();
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String now = formatter.format(currentTime);
			
			// 注册时间
			if (StringUtils.isEmpty(userInfo.getRegisterTime())) {
				userInfo.setRegisterTime(now);
			}
			
			// 上次访问时间
			if (StringUtils.isEmpty(userInfo.getLastLoginTime())) {
				userInfo.setLastLoginTime(now);
			}
			
			userInfo.setPassWord(MD5.md5(szPassWord));	// 密码加密
			userInfo.setStatus("1");	// 正常状态
			
			iUserInfoDAO.insert(userInfo);
			
			UserProfileInfo userProfileInfo = new UserProfileInfo();
			userProfileInfo.setUserId(userInfo.getId());
			userProfileInfo.setAvatar(userInfo.getAvatar());
			userProfileInfo.setGroupId(userInfo.getGroupId());
			userProfileInfo.setSignPersonal(userInfo.getSignPersonal());
			userProfileInfo.setPoint(userInfo.getPoint());
			
			iUserProfileInfoDAO.insert(userProfileInfo);
		} else {
			// 编辑
			if (!StringUtils.isEmpty(userInfo.getPassWord())) {
				userInfo.setPassWord(MD5.md5(userInfo.getPassWord()));	// 密码加密
				iUserInfoDAO.update(userInfo);
			}
			
			UserProfileInfo userProfileInfo = new UserProfileInfo();
			userProfileInfo.setUserId(userInfo.getId());
			userProfileInfo.setAvatar(userInfo.getAvatar());
			userProfileInfo.setGroupId(userInfo.getGroupId());
			userProfileInfo.setSignPersonal(userInfo.getSignPersonal());
			userProfileInfo.setPoint(userInfo.getPoint());
			
			iUserProfileInfoDAO.update(userProfileInfo);
		}
	}

	/**
	 * 批量删除封禁用户的内容
	 * @param userIdArr 用户id数组
	 * @param deleteArr 删除内容表名数组
	 */
	public void batchDeleteContent(String[] userIdArr, String[] deleteArr) {
		// 遍历需要删除哪些表的数据
		for (int i=0; i<deleteArr.length; i++) {
			if ("replay_info".equals(deleteArr[i])) {
				// 删除回复表中的内容
				iReplyInfoDAO.deleteByUserIdArr(userIdArr);
			} else if ("comment_info".equals(deleteArr[i])) {
				// 删除评论表中的内容
				iCommentInfoDAO.deleteByUserIdArr(userIdArr);
			} else if ("collection_info".equals(deleteArr[i])) {
				// 删除收藏表中的内容
				iCollectionInfoDAO.deleteByUserIdArr(userIdArr);
			} else if ("history_info".equals(deleteArr[i])) {
				// 删除历史浏览记录表中的内容
				iHistoryInfoDAO.deleteByUserIdArr(userIdArr);
			}
		}
	}

}
