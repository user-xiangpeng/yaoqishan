package cn.javaex.yaoqishan.service.media_info;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import cn.javaex.yaoqishan.constant.ErrorMsg;
import cn.javaex.yaoqishan.dao.api_info.IApiInfoDAO;
import cn.javaex.yaoqishan.dao.field_info.IFieldInfoDAO;
import cn.javaex.yaoqishan.dao.field_profile_info.IFieldProfileInfoDAO;
import cn.javaex.yaoqishan.dao.media_info.IMediaInfoDAO;
import cn.javaex.yaoqishan.dao.tag_info.ITagInfoDAO;
import cn.javaex.yaoqishan.dao.video_info.IVideoInfoDAO;
import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.view.FieldInfo;
import cn.javaex.yaoqishan.view.MediaInfo;
import cn.javaex.yaoqishan.view.TagInfo;
import cn.javaex.yaoqishan.view.VideoInfo;

@Service("MediaInfoService")
public class MediaInfoService {
	@Autowired
	private IMediaInfoDAO iMediaInfoDAO;
	@Autowired
	private IVideoInfoDAO iVideoInfoDAO;
	@Autowired
	private IFieldInfoDAO iFieldInfoDAO;
	@Autowired
	private IFieldProfileInfoDAO iFieldProfileInfoDAO;
	@Autowired
	private ITagInfoDAO iTagInfoDAO;
	@Autowired
	private IApiInfoDAO iApiInfoDAO;
	
	/**
	 * 查询媒体列表
	 * @param param
	 * @return
	 */
	public List<MediaInfo> list(Map<String, Object> param) {
		return iMediaInfoDAO.list(param);
	}
	
	/**
	 * 保存媒体信息
	 * @param param
	 * @throws QingException
	 */
	public void save(Map<String, Object> param) throws QingException {
		// 生成标签
		if (StringUtils.isEmpty(param.get("tag"))) {
			// 清空该媒体的标签
			param.put("tag", "");
		} else {
			String tags = param.get("tag").toString();
			// 1.0 将得到的标签转为数组格式
			String[] tagArr = tags.split(",");
			for (int i=0; i<tagArr.length; i++) {
				// 根据标签中文名称，查询标签是否已存在
				int count = iTagInfoDAO.countByName(tagArr[i]);
				if (count==0) {
					// 不存在，插入新标签
					TagInfo tagInfo = new TagInfo();
					tagInfo.setName(tagArr[i]);
					
					iTagInfoDAO.insert(tagInfo);
				}
			}
			
			// 2.0 重新根据用户输入的标签，查询标签的主键，按从小到大排序
			List<String> idList = iTagInfoDAO.listIdByNameArr(tagArr);
			
			// 3.0 将集合转为 1,3这种字符串
			String str = "";
			for (int i=0; i<idList.size(); i++) {
				if (i==0) {
					str = idList.get(i);
				} else {
					str = str + "," + idList.get(i);
				}
			}
			
			// 4.0 保存新的标签
			param.put("tag", str);
		}
		
		// 分类
		String typeId = param.get("type_id").toString();
		// 标题
		String biaoti = param.get("biaoti").toString();
		// 判断是否允许标题重复
		String repeat = param.get("repeat").toString();
		
		// 查询字段列表
		List<FieldInfo> fieldInfoList = iFieldInfoDAO.listByTypeId(typeId);
		if (fieldInfoList!=null && fieldInfoList.isEmpty()==false) {
			// 判断是新增还是更新
			String mediaId = param.get("media_id").toString();
			if (StringUtils.isEmpty(mediaId)) {
				// 新增
				// 1.0 判断是否允许标题重复
				if (!"1".equals(repeat)) {
					// 校验标题是否重复
					int count = iMediaInfoDAO.countByBiaoti(biaoti, null);
					if (count>0) {
						// 重复
						throw new QingException(ErrorMsg.ERROR_300001);
					}
				}

				//2.0 生成插入数据SQL文
				StringBuffer sql = new StringBuffer();
				sql.append(" INSERT INTO ");
				sql.append(" media_info ");
				sql.append(" ( ");
				for (FieldInfo fieldInfo : fieldInfoList) {
					sql.append(fieldInfo.getVarName() + ",");
				}
				sql.append(" tag, ");
				sql.append(" type_id, ");
				sql.append(" haibao, ");
				sql.append(" dafengmian, ");
				sql.append(" fengmian, ");
				sql.append(" biaoti, ");
				sql.append(" bieming, ");
				sql.append(" jianjie, ");
				sql.append(" status, ");
				sql.append(" has_video, ");
				sql.append(" update_time ");
				sql.append(" ) ");
				sql.append(" VALUES ");
				sql.append(" ( ");
				for (FieldInfo fieldInfo : fieldInfoList) {
					String value = "";
					if (param.get(fieldInfo.getVarName())!=null) {
						value = param.get(fieldInfo.getVarName()).toString();
					}
					sql.append(" '"+value+"', ");
				}
				sql.append(" '"+param.get("tag").toString()+"', ");
				sql.append(" '"+typeId+"', ");
				sql.append(" '"+param.get("haibao").toString()+"', ");
				sql.append(" '"+param.get("dafengmian").toString()+"', ");
				sql.append(" '"+param.get("fengmian").toString()+"', ");
				sql.append(" '"+biaoti+"', ");
				sql.append(" '"+param.get("bieming").toString()+"', ");
				sql.append(" '"+param.get("jianjie").toString()+"', ");
				sql.append(" '1', ");
				sql.append(" '0', ");
				sql.append(" GETDATE() ");
				sql.append(" ) ");
				
				iMediaInfoDAO.insert(sql.toString());
			} else {
				// 更新
				// 1.0 判断是否允许标题重复
				if (!"1".equals(repeat)) {
					int count = iMediaInfoDAO.countByBiaoti(biaoti, mediaId);
					if (count>0) {
						// 重复
						throw new QingException(ErrorMsg.ERROR_300001);
					}
				}
				
				// 2.0 生成更新数据SQL文
				StringBuffer sql = new StringBuffer();
				sql.append(" UPDATE ");
				sql.append(" media_info ");
				sql.append(" SET ");
				for (FieldInfo fieldInfo : fieldInfoList) {
					String value = "";
					if (param.get(fieldInfo.getVarName())!=null) {
						value = param.get(fieldInfo.getVarName()).toString();
					}
					sql.append(fieldInfo.getVarName() + "=" + "'" + value + "',");
				}
				sql.append(" tag='"+param.get("tag").toString()+"', ");
				sql.append(" haibao='"+param.get("haibao").toString()+"', ");
				sql.append(" dafengmian='"+param.get("dafengmian").toString()+"', ");
				sql.append(" fengmian='"+param.get("fengmian").toString()+"', ");
				sql.append(" biaoti='"+biaoti+"', ");
				sql.append(" bieming='"+param.get("bieming").toString()+"', ");
				sql.append(" jianjie='"+param.get("jianjie").toString()+"' ");
				sql.append(" WHERE ");
				sql.append(" media_id = '" + mediaId + "' ");
				
				iMediaInfoDAO.update(sql.toString());
			}
		}
	}

	/**
	 * 根据主键查询媒体信息
	 * @param mediaId 主键
	 * @return
	 */
	public MediaInfo selectById(String mediaId) {
		return iMediaInfoDAO.selectById(mediaId);
	}

	/**
	 * 根据主键，查询该媒体信息标题
	 * @param mediaId 主键
	 * @return
	 */
	public String selectBiaotiById(String mediaId) {
		return iMediaInfoDAO.selectBiaotiById(mediaId);
	}

	/**
	 * 根据主键，获取媒体信息
	 * @param mediaId 媒体信息的主键
	 * @return
	 * @throws QingException
	 */
	public Map<String, Object> selectByMediaId(String mediaId) throws QingException {
		Map<String, Object> map = iMediaInfoDAO.selectByMediaId(mediaId);
		if (map==null) {
			throw new QingException(ErrorMsg.ERROR_300003);
		}
		
		// 遍历map，获取字段对应的文本
		for (String key : map.keySet()) {
			if ("media_id".equals(key) || "tag".equals(key) || "haibao".equals(key) || "biaoti".equals(key) || "kandian".equals(key) || "jianjie".equals(key)) {
				
			} else {
				String fieldProfileId = map.get(key).toString();
				String[] arr = fieldProfileId.split(",");
				if (arr!=null && arr.length>0) {
					// 判断该字段是否是复选框
					FieldInfo fieldInfo = iFieldInfoDAO.selectByVarName(key);
					if (fieldInfo!=null) {
						// 判断字段类型
						if ("radio".equals(fieldInfo.getInputType())) {
							// 单选框
							String value = iFieldProfileInfoDAO.selectById(fieldProfileId);
							if (!StringUtils.isEmpty(value)) {
								map.put(key, value);
							}
						} else if ("checkbox".equals(fieldInfo.getInputType())) {
							// 复选框
							List<String> list = iFieldProfileInfoDAO.selectByIdArr(arr);
							if (list!=null && list.isEmpty()==false) {
								map.put(key, list);
							}
						}
					}
				}
			}
		}
		
		return map;
	}

	/**
	 * 搜索
	 * @param keyWord 搜索关键词
	 * @return
	 * @throws QingException
	 */
	public List<String> search(String keyWord) throws QingException {
		if (StringUtils.isEmpty(keyWord)) {
			return null;
		}
		
		return iMediaInfoDAO.searchIdByKeyWord(keyWord);
	}

	/**
	 * 根据筛选结果，查询媒体列表
	 * @param typeId 分类主键
	 * @param param
	 * @param fieldInfoList
	 * @return
	 */
	public List<Map<String, Object>> listByFilter(String typeId, Map<String, Object> param, List<FieldInfo> fieldInfoList) {
		
		// 生成SQL文
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" media_id, ");
		sql.append(" haibao, ");
		sql.append(" biaoti, ");
		sql.append(" kandian, ");
		sql.append(" zongjishu ");
		sql.append(" FROM ");
		sql.append(" media_info ");
		sql.append(" WHERE ");
		sql.append(" type_id = '"+typeId+"' ");
		if (fieldInfoList!=null && fieldInfoList.isEmpty()==false) {
			for (FieldInfo fieldInfo : fieldInfoList) {
				String varName = fieldInfo.getVarName();
				if (!StringUtils.isEmpty(param.get(varName))) {
					if ("checkbox".equals(fieldInfo.getInputType())) {
						// 如果选项是复选框
						sql.append(" AND (',' + "+varName+" + ',' LIKE '%," + param.get(varName).toString() + ",%') ");
					} else {
						// 单选框
						sql.append(" AND "+varName+" = '"+param.get(varName).toString()+"' ");
					}
				}
			}
		}
		sql.append(" ORDER BY ");
		sql.append(" update_time DESC ");
		
		// 查询数据
		List<Map<String, Object>> list = iMediaInfoDAO.listByFilter(sql.toString());
		
		if (list!=null && list.isEmpty()==false) {
			int len = list.size();
			for (int i=len-1; i>=0; i--) {
				// 查询该视频下的最新一集
				String mediaId = list.get(i).get("media_id").toString();
				VideoInfo videoInfo = iVideoInfoDAO.selectByMediaIdLast(mediaId);
				if (videoInfo!=null) {
					list.get(i).put("videoInfo", videoInfo);
				}
			}
		}
		
		return list;
	}

	/**
	 * 批量更新媒体的状态
	 * @param param
	 */
	public void batchUpdateStatus(Map<String, Object> param) {
		// 批量更新媒体的状态
		iMediaInfoDAO.batchUpdate(param);
		
		// 批量更新视频状态
		iVideoInfoDAO.batchUpdate(param);
	}

	/**
	 * 根据主键和分类id，获取媒体字段信息
	 * @param mediaId 主键
	 * @param typeId 分类id
	 * @return
	 */
	public Map<String, Object> selectByIdAndTypeId(String mediaId, String typeId) {
		// 1.0 根据分类id，查询该媒体使用了哪些字段
		List<FieldInfo> list = iFieldInfoDAO.listByTypeId(typeId);
		if (list!=null && list.isEmpty()==false) {
			// 生成媒体查询sql（查哪些字段）
			StringBuffer sql = new StringBuffer();
			sql.append(" SELECT ");
			for (int i=0; i<list.size(); i++) {
				if (i==(list.size()-1)) {
					sql.append(list.get(i).getVarName());
				} else {
					sql.append(list.get(i).getVarName() + ",");
				}
			}
			sql.append(" FROM ");
			sql.append(" media_info ");
			sql.append(" WHERE ");
			sql.append(" media_id = '" + mediaId + "' ");
			
			// 返回查询结果
			return iMediaInfoDAO.selectSqlById(sql.toString());
		}
		
		return null;
	}

	/**
	 * 根据接口自定义查询排行榜数据
	 * @param apiId
	 * @return
	 * @throws QingException
	 */
	public List<Map<String, Object>> getRankDataByApiId(String apiId) throws QingException {
		Map<String, Object> apiInfo = iApiInfoDAO.selectById(apiId);
		if (apiInfo==null) {
			throw new QingException(ErrorMsg.ERROR_700002);
		}

		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" TOP " + apiInfo.get("num"));
		sql.append(" mi.media_id, ");
		sql.append(" mi.biaoti, ");
		sql.append(" mi.fengmian, ");
		sql.append(" mi.zongjishu, ");
		sql.append(" vi.view_count ");
		sql.append(" FROM ");
		sql.append(" media_info mi, ");
		sql.append(" ( ");
		sql.append(" SELECT ");
		sql.append(" media_id, ");
		if ("day".equals(apiInfo.get("rank_type"))) {
			sql.append(" SUM(view_count_day) AS view_count ");
		} else if ("week".equals(apiInfo.get("rank_type"))) {
			sql.append(" SUM(view_count_week) AS view_count ");
		} else if ("month".equals(apiInfo.get("rank_type"))) {
			sql.append(" SUM(view_count_month) AS view_count ");
		} else if ("year".equals(apiInfo.get("rank_type"))) {
			sql.append(" SUM(view_count_year) AS view_count ");
		} else {
			return null;
		}
		sql.append(" FROM ");
		sql.append(" video_info ");
		sql.append(" GROUP BY ");
		sql.append(" media_id ");
		sql.append(" ) vi ");
		sql.append(" WHERE ");
		sql.append(" mi.status = '1' ");
		sql.append(" AND mi.has_video = '1' ");// 其下有视频
		sql.append(" AND mi.media_id = vi.media_id ");
		sql.append(" AND mi.type_id = '" + apiInfo.get("type_id") + "' ");
		sql.append(" ORDER BY ");
		sql.append(" vi.view_count DESC ");
		
		// 返回查询结果
		List<Map<String, Object>> list = iMediaInfoDAO.selectSqlByApi(sql.toString());
		
		// 判断是否需要查询视频信息
		String selectVideo = apiInfo.get("select_video").toString();
		if ("0".equals(selectVideo)) {
			// 不查询
		} else {
			if (list!=null && list.isEmpty()==false) {
				int len = list.size();
				for (int i=0; i<len; i++) {
					String mediaId = list.get(i).get("media_id").toString();
					VideoInfo videoInfo = null;
					if ("1".equals(selectVideo)) {
						// 查询第一集
						videoInfo = iVideoInfoDAO.selectByMediaIdFirst(mediaId);
					} else if ("2".equals(selectVideo)) {
						// 查询最新一集
						videoInfo = iVideoInfoDAO.selectByMediaIdLast(mediaId);
					}
					if (videoInfo!=null) {
						list.get(i).put("videoInfo", videoInfo);
					}
				}
			}
		}

		return list;
	}
	
	/**
	 * 根据接口自定义查询数据
	 * @param apiId 接口表主键
	 * @return
	 * @throws QingException 
	 */
	public List<Map<String, Object>> getDataByApiId(String apiId) throws QingException {

		Map<String, Object> apiInfo = iApiInfoDAO.selectById(apiId);
		if (apiInfo==null) {
			throw new QingException(ErrorMsg.ERROR_700002);
		}
		
		if (StringUtils.isEmpty(apiInfo.get("field"))) {
			throw new QingException(ErrorMsg.ERROR_700002);
		}
		
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ");
		sql.append(" TOP " + apiInfo.get("num").toString());
		sql.append(" media_id, ");
		sql.append(" haibao, ");
		sql.append(" dafengmian, ");
		sql.append(" fengmian, ");
		sql.append(" biaoti, ");
		sql.append(" kandian, ");
		sql.append(" zongjishu, ");
		sql.append(" CONVERT(varchar(100), update_time, 23) AS uploadTime ");
		sql.append(" FROM ");
		sql.append(" media_info ");
		sql.append(" WHERE ");
		sql.append(" status = '1' ");
		sql.append(" AND has_video = '1' ");// 其下有视频
		// 查询该接口定义了哪些字段
		String[] fieldArr = apiInfo.get("field").toString().split(",");
		for (int i=0; i<fieldArr.length; i++) {
			// 查询每一个字段
			String fieldName = fieldArr[i];
			// 得到该接口中该字段的值
			String apiFieldValue = apiInfo.get(fieldName).toString();
			// 生成查询条件
			String[] arr = apiFieldValue.split(",");
			if (arr.length==1) {
				sql.append(" AND " + fieldName + " = '"+ apiFieldValue + "' ");
			} else {
				String str = "";
				for (int j=0; j<arr.length; j++) {
					if (j==0) {
						str = "'" + arr[j] + "'";
					} else {
						str += ",'" + arr[j] + "'";
					}
				}
				sql.append(" AND " + fieldName + " IN ("+ str + ") ");
			}
		}
		
		// 标签条件
		if (!StringUtils.isEmpty(apiInfo.get("tag"))) {
			String apiTag = apiInfo.get("tag").toString();
			String[] tagArr = apiTag.split(",");
			sql.append(" AND ( ");
			for (int k=0; k<tagArr.length; k++) {
				if (k==(tagArr.length-1)) {
					sql.append(" ',' + tag + ',' LIKE '%," + tagArr[k] + ",%' ");
				} else {
					sql.append(" ',' + tag + ',' LIKE '%," + tagArr[k] + ",%' OR ");
				}
			}
			sql.append(" ) ");
		}
		sql.append(" ORDER BY update_time DESC ");
		
		// 返回查询结果
		List<Map<String, Object>> list = iMediaInfoDAO.selectSqlByApi(sql.toString());
		
		// 判断是否需要查询视频信息
		String selectVideo = apiInfo.get("select_video").toString();
		if ("0".equals(selectVideo)) {
			// 不查询
		} else {
			if (list!=null && list.isEmpty()==false) {
				int len = list.size();
				for (int i=0; i<len; i++) {
					String mediaId = list.get(i).get("media_id").toString();
					VideoInfo videoInfo = null;
					if ("1".equals(selectVideo)) {
						// 查询第一集
						videoInfo = iVideoInfoDAO.selectByMediaIdFirst(mediaId);
					} else if ("2".equals(selectVideo)) {
						// 查询最新一集
						videoInfo = iVideoInfoDAO.selectByMediaIdLast(mediaId);
					}
					if (videoInfo!=null) {
						list.get(i).put("videoInfo", videoInfo);
					}
				}
			}
		}

		return list;
	}

	/**
	 * 批量移动到分类
	 * @param param
	 */
	public void batchUpdateType(Map<String, Object> param) {
		iMediaInfoDAO.batchUpdate(param);
	}

	/**
	 * 批量删除
	 * @param mediaIdArr 主键数组
	 */
	public void batchDelete(String[] mediaIdArr) {
		// 1.0 删除其下的视频信息
		iVideoInfoDAO.batchDeleteByMediaId(mediaIdArr);
		
		// 2.0 删除媒体信息
		iMediaInfoDAO.batchDelete(mediaIdArr);
	}

}
