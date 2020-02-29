package cn.javaex.yaoqishan.view;

import java.util.HashMap;
import java.util.Map;

import org.springframework.util.StringUtils;

/**
 * 通用的返回的类
 * 
 * @author 陈霓清
 */
public class Result {

	// 状态码 000000：成功；999999：失败
	private String code;
	// 提示信息
	private String message;
	// 用户要返回给浏览器的数据
	private Map<String, Object> data = new HashMap<String, Object>();
	
	public static Result success() {
		Result result = new Result();
		result.setCode("000000");
		result.setMessage("操作成功!");
		return result;
	}
	
	public static Result error(String message) {
		Result result = new Result();
		result.setCode("999999");
		if (StringUtils.isEmpty(message)) {
			result.setMessage("操作失败!");
		} else {
			result.setMessage(message);
		}
		return result;
	}
	
	// 链式操作返回信息
	public Result add(String key, Object value) {
		this.getData().put(key, value);
		return this;
	}
	
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public Map<String, Object> getData() {
		return data;
	}
	public void setData(Map<String, Object> data) {
		this.data = data;
	}
	
}
