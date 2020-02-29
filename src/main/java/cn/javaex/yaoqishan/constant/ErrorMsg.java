package cn.javaex.yaoqishan.constant;


public class ErrorMsg {
	
	// 用户注册、登录、修改错误提示
	/** 用户名或密码不能为空 */
	public static final String ERROR_100001 = "账号或密码不能为空";
	/** 用户名或密码错误 */
	public static final String ERROR_100002 = "账号或密码错误";
	/** 该账号已被管理员封禁 */
	public static final String ERROR_100003 = "该账号已被管理员封禁";
	/** 账号不能为空 */
	public static final String ERROR_100004 = "账号不能为空";
	/** 账号长度应为4到10个字符 */
	public static final String ERROR_100005 = "账号长度应为4到10个字符";
	/** 密码不能为空 */
	public static final String ERROR_100006 = "密码不能为空";
	/** 密码长度应为6到16个字符 */
	public static final String ERROR_100007 = "密码长度应为6到16个字符";
	/** 邮箱不能为空 */
	public static final String ERROR_100008 = "邮箱不能为空";
	/** 账号已被占用 */
	public static final String ERROR_100009 = "账号已被占用";
	/** 邮箱已被占用 */
	public static final String ERROR_100010 = "邮箱已被占用";
	/** 注册失败，请稍后重试 */
	public static final String ERROR_100011 = "注册失败，请稍后重试";
	/** 未登录 */
	public static final String ERROR_100012 = "未登录";
	/** 验证码不能为空 */
	public static final String ERROR_100013 = "验证码不能为空";
	/** 验证码不正确 */
	public static final String ERROR_100014 = "验证码不正确";
	/** 验证码已过期 */
	public static final String ERROR_100015 = "验证码已过期";
	/** 新邮箱不能与旧邮箱相同 */
	public static final String ERROR_100016 = "新邮箱不能与旧邮箱相同";
	/** 新邮箱已被占用，如果忘记密码，可以找回 */
	public static final String ERROR_100017 = "新邮箱已被占用，如果忘记密码，可以找回";
	/** 该邮箱尚未绑定 */
	public static final String ERROR_100018 = "该邮箱尚未绑定";
	/** 该账号尚未激活 */
	public static final String ERROR_100019 = "该账号尚未激活";
	
	// 字段校验
	/** 字段变量名重复或已被系统内置字段占用 */
	public static final String ERROR_200001 = "字段变量名重复或已被系统内置字段占用";
	/** 存在已被分类信息使用的字段，无法删除 */
	public static final String ERROR_200002 = "存在已被分类信息使用的字段，无法删除";
	/** 存在已被接口使用的字段，无法删除 */
	public static final String ERROR_200003 = "存在已被接口使用的字段，无法删除";
	
	// 媒体信息校验
	/** 标题已存在 */
	public static final String ERROR_300001 = "标题已存在";
	/** 必填项不能为空 */
	public static final String ERROR_300002 = "必填项不能为空";
	/** 视频不存在 */
	public static final String ERROR_300003 = "视频不存在";
	
	// 播放器校验
	/** 存在已被使用的播放器，无法删除 */
	public static final String ERROR_400001 = "存在已被使用的播放器，无法删除";
	
	// 图片上传校验
	/** 上传失败，可能是远程图片做了防盗链处理 */
	public static final String ERROR_500001 = "上传失败，可能是远程图片做了防盗链处理";
	/** 上传失败，可能是网络不稳定 */
	public static final String ERROR_500002 = "上传失败，可能是网络不稳定";
	/** 上传失败，图片裁剪时发生异常 */
	public static final String ERROR_500003 = "上传失败，图片裁剪时发生异常";
	
	// 视频操作校验
	/** 封面转存到七牛云时发生异常 */
	public static final String ERROR_600001 = "封面转存到七牛云时发生异常";
	/** 图片地址不能为空 */
	public static final String ERROR_600002 = "图片地址不能为空";
	/** 集数不是数字，插入失败 */
	public static final String ERROR_600003 = "存在不是数字的集数，采集失败";
	/** 未获取到标题，采集失败 */
	public static final String ERROR_600004 = "未获取到标题，采集失败";
	/** 存在正常状态的视频，无法删除 */
	public static final String ERROR_600005 = "存在正常状态的视频，无法删除";
	/** 权限值不能为空 */
	public static final String ERROR_600006 = "权限值不能为空";
	
	// 接口校验
	/** 必须设置数据来源 */
	public static final String ERROR_700001 = "必须设置数据来源";
	/** 指定接口不存在 */
	public static final String ERROR_700002 = "指定接口不存在";
	/** 该接口未设置条件，不可用 */
	public static final String ERROR_700003 = "该接口未设置条件，不可用";
	/** 获取条数必须是正整数 */
	public static final String ERROR_700004 = "获取条数必须是正整数";
	
	// 分类信息校验
	/** 存在已配置字段的分类信息，无法删除 */
	public static final String ERROR_800001 = "存在已配置字段的分类信息，无法删除";
	
	// 评论校验
	/** 评论内容不能为空 */
	public static final String ERROR_900001 = "评论内容不能为空";
	/** 无法对自己回复 */
	public static final String ERROR_900002 = "无法对自己回复";
	
	// 用户操作校验
	/** 该视频已被收藏过了 */
	public static final String ERROR_X00001 = "该视频已被收藏过了";
	/** 验证失败，请尝试重新发送邮件 */
	public static final String ERROR_X00002 = "验证失败，请尝试重新发送邮件";
	
	// 用户组校验
	/** 用户组名称禁止重复 */
	public static final String ERROR_110001 = "用户组名称禁止重复";
	/** 存在已被使用的用户组，无法删除 */
	public static final String ERROR_110002 = "存在已被使用的用户组，无法删除";
	
	// 邮件相关
	/** 设置发信人失败 */
	public static final String ERROR_120001 = "设置发信人失败";
	/** 您的邮箱已满，请清理后重试 */
	public static final String ERROR_120002 = "您的邮箱已满，请清理后重试";
	/** 您的邮件账号可能输入错误 */
	public static final String ERROR_120003 = "您的邮件账号可能输入错误";
	/** 发信人的身份认证失败 */
	public static final String ERROR_120004 = "发信人的身份认证失败";
	/** 您的信箱大小受到限制 */
	public static final String ERROR_120005 = "您的信箱大小受到限制";
	/** 发信人的身份认证失败 */
	public static final String ERROR_120006 = "发信人的身份认证失败";
	/** 系统异常，请重试 */
	public static final String ERROR_120007 = "系统异常，请重试";
	/** 该网站未开启邮件发送服务 */
	public static final String ERROR_120008 = "该网站未开启邮件发送服务";
}
