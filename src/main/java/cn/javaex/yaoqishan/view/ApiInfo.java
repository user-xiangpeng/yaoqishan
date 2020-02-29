package cn.javaex.yaoqishan.view;

/**
 * 接口设置类
 * 
 * @author 陈霓清
 */
public class ApiInfo {
	private String id;		// 主键
	private String name;	// 名称，用于让用户识别自己的接口
	private String sort;	// 排序
	private String type;	// 接口类型（方便管理）
	private String typeId;	// 数据来源于哪个分类
	private String field;	// 该接口定义了哪些字段
	private String num;		// 返回多少条数据
	private String tag;		// 该接口定义了哪些标签
	private String rankType;	// 排行榜类型（day：日榜；week：周榜；month：月榜；year：年榜）
	private String selectVideo;	// 是否查询该媒体下的视频信息（0：不查询；1：第一集；2：最新一集）
	private String cacheTime;	// 缓存时间
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTypeId() {
		return typeId;
	}
	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}
	public String getField() {
		return field;
	}
	public void setField(String field) {
		this.field = field;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getRankType() {
		return rankType;
	}
	public void setRankType(String rankType) {
		this.rankType = rankType;
	}
	public String getSelectVideo() {
		return selectVideo;
	}
	public void setSelectVideo(String selectVideo) {
		this.selectVideo = selectVideo;
	}
	public String getCacheTime() {
		return cacheTime;
	}
	public void setCacheTime(String cacheTime) {
		this.cacheTime = cacheTime;
	}
	
}
