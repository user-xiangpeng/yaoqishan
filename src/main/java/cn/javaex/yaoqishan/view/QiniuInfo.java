package cn.javaex.yaoqishan.view;

import java.io.Serializable;

/**
 * 七牛云配置表
 * 
 * @author 陈霓清
 */
@SuppressWarnings("serial")
public class QiniuInfo implements Serializable {
	private String id;		// 主键
	private String type;	// 类型
	private String name;	// 名称
	private String domain;	// 空间绑定域名
	private String ak;		// 密钥ak
	private String sk;		// 密钥sk
	private String bucket;	// 空间名称
	private String width;	// 自动裁剪后的宽度（0为不裁剪）
	private String height;	// 自动裁剪后的高度（0为不裁剪）
	private String compress;// 压缩率（0为不压缩）
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getDomain() {
		return domain;
	}
	public void setDomain(String domain) {
		this.domain = domain;
	}
	public String getAk() {
		return ak;
	}
	public void setAk(String ak) {
		this.ak = ak;
	}
	public String getSk() {
		return sk;
	}
	public void setSk(String sk) {
		this.sk = sk;
	}
	public String getBucket() {
		return bucket;
	}
	public void setBucket(String bucket) {
		this.bucket = bucket;
	}
	public String getWidth() {
		return width;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public String getHeight() {
		return height;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public String getCompress() {
		return compress;
	}
	public void setCompress(String compress) {
		this.compress = compress;
	}
	
}
