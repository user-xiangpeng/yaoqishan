package cn.javaex.yaoqishan.service.qiniu_info;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.google.gson.Gson;
import com.qiniu.common.QiniuException;
import com.qiniu.common.Zone;
import com.qiniu.http.Response;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.DefaultPutRet;
import com.qiniu.util.Auth;
import com.qiniu.util.StringMap;
import com.qiniu.util.UrlSafeBase64;

import cn.javaex.yaoqishan.constant.ErrorMsg;
import cn.javaex.yaoqishan.dao.qiniu_info.IQiniuInfoDAO;
import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.view.QiniuInfo;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.RequestBody;

@Service("QiniuInfoService")
public class QiniuInfoService {
	@Autowired
	private IQiniuInfoDAO iQiniuInfofoDAO;

	/**
	 * 根据指定类型查询配置记录
	 * @param type 类型
	 * @return
	 */
	public QiniuInfo selectByType(String type) {
		return iQiniuInfofoDAO.selectByType(type);
	}

	/**
	 * 保存配置
	 * @param qiniuInfo
	 */
	public void save(QiniuInfo qiniuInfo) {
		iQiniuInfofoDAO.update(qiniuInfo);
	}

	/**
	 * 上传本地图片到七牛云
	 * @param file
	 * @param qiniuInfo
	 * @return
	 * @throws IOException
	 * @throws QingException
	 */
	public String uploadImage(MultipartFile file, QiniuInfo qiniuInfo) throws IOException, QingException {
		/**
		 * 构造一个带指定Zone对象的配置类
		 * 华东 : Zone.zone0()
		 * 华北 : Zone.zone1()
		 * 华南 : Zone.zone2()
		 * 北美 : Zone.zoneNa0()
		 */
		Configuration cfg = new Configuration(Zone.zone0());
		// ...其他参数参考类注释
		UploadManager uploadManager = new UploadManager(cfg);
		// ...生成上传凭证，然后准备上传
		String accessKey = qiniuInfo.getAk();
		String secretKey = qiniuInfo.getSk();
		String bucket = qiniuInfo.getBucket();
		// 默认不指定key的情况下，以文件内容的hash值作为文件名
		String key = null;
		
		String imgUrl = "";
		try {
			// 数据流上传
			InputStream byteInputStream = file.getInputStream();
			Auth auth = Auth.create(accessKey, secretKey);
			String upToken = auth.uploadToken(bucket);
			try {
				Response response = uploadManager.put(byteInputStream, key, upToken, null, null);
				// 解析上传成功的结果
				DefaultPutRet putRet = new Gson().fromJson(response.bodyString(), DefaultPutRet.class);
//				System.out.println(putRet.key);
//				System.out.println(putRet.hash);
				String deleteKey = putRet.hash;
				imgUrl = qiniuInfo.getDomain() + putRet.hash;

				// 判断是否需要对图片进行裁剪
				if ("0".equals(qiniuInfo.getWidth()) || "0".equals(qiniuInfo.getHeight())) {
					
				} else {
					// 图片裁剪后再次上传
					imgUrl = uploadCutImage(qiniuInfo, auth, cfg, bucket, imgUrl);
					// 删除原图
					deleteFile(auth, cfg, bucket, deleteKey);
				}
			} catch (QiniuException ex) {
				Response r = ex.response;
				System.err.println(r.toString());
				try {
					System.err.println(r.bodyString());
				} catch (QiniuException ex2) {
					// ignore
				}
				throw new QingException(ErrorMsg.ERROR_500002);
			}
		} catch (UnsupportedEncodingException ex) {
			// ignore
			throw new QingException(ErrorMsg.ERROR_500002);
		}
		
		return imgUrl;
	}
	
	/**
	 * 远程图片上传到七牛云
	 * @param url 远程图片地址
	 * @param qiniuInfo 七牛云对象
	 * @return
	 * @throws QingException
	 */
	public String uploadImageByYuancheng(String url, QiniuInfo qiniuInfo) throws QingException {
		/**
		 * 构造一个带指定Zone对象的配置类
		 * 华东 : Zone.zone0()
		 * 华北 : Zone.zone1()
		 * 华南 : Zone.zone2()
		 * 北美 : Zone.zoneNa0()
		 */
		Configuration cfg = new Configuration(Zone.zone0());
		// ...生成上传凭证，然后准备上传
		String accessKey = qiniuInfo.getAk();
		String secretKey = qiniuInfo.getSk();
		String bucket = qiniuInfo.getBucket();
		// 默认不指定key的情况下，以文件内容的hash值作为文件名
		String key = null;
		
		String imgUrl = "";
		
		Auth auth = Auth.create(accessKey, secretKey);
		// 实例化一个BucketManager对象
		BucketManager bucketManager = new BucketManager(auth, cfg);
		try {
			int index = url.indexOf(".jpg");
			if (index>0) {
				url = url.substring(0, index) + ".jpg";
			}
			
			String hash = bucketManager.fetch(url, bucket, key).hash;
//			System.out.println(hash);
			String deleteKey = hash;
			imgUrl = qiniuInfo.getDomain() + hash;
			
			// 判断是否需要对图片进行裁剪
			if ("0".equals(qiniuInfo.getWidth()) || "0".equals(qiniuInfo.getHeight())) {
				
			} else {
				// 图片裁剪后再次上传
				imgUrl = uploadCutImage(qiniuInfo, auth, cfg, bucket, imgUrl);
				// 删除原图
				deleteFile(auth, cfg, bucket, deleteKey);
			}
		} catch (QiniuException e) {
			e.printStackTrace();
			throw new QingException(ErrorMsg.ERROR_500001);
		}
		
		return imgUrl;
	}
	
	/**
	 * 图片裁剪后再次上传
	 * @param qiniuInfo
	 * @param auth
	 * @param cfg
	 * @param bucket
	 * @param imgUrl
	 * @return
	 * @throws QingException 
	 */
	public String uploadCutImage(QiniuInfo qiniuInfo, Auth auth, Configuration cfg, String bucket, String imgUrl) throws QingException {
		String apiCut = "";
		String width = qiniuInfo.getWidth();
		String height = qiniuInfo.getHeight();
		String compress = qiniuInfo.getCompress();
		
		// 判断是否需要裁剪
		if ("0".equals(width) || "0".equals(height)) {
			// 不裁剪
		} else {
			// 裁剪
			apiCut = "?imageView2/1/w/"+width+"/h/"+height;
		}
		
		// 判断是否需要压缩
		if (!"".equals(apiCut)) {
			if ("0".equals(compress)) {
				apiCut += "/q/100";
			} else {
				apiCut += "/q/"+compress+"|imageslim";
			}
		}
		
		// 实例化一个BucketManager对象
		BucketManager bucketManager = new BucketManager(auth, cfg);
		// 要fetch的url
		String url = imgUrl + apiCut;
//		System.out.println(url);
		
		try {
			// 调用fetch方法抓取文件
			String hash = bucketManager.fetch(url, bucket, null).hash;
//			System.out.println(hash);
			
			return qiniuInfo.getDomain() + hash;
		} catch (QiniuException e) {
			e.printStackTrace();
			throw new QingException(ErrorMsg.ERROR_500003);
		}
	}

	/**
	 * 删除七牛云空间的文件
	 * @param auth
	 * @param cfg
	 * @param bucket 空间名称
	 * @param fileName 文件名称
	 */
	public void deleteFile(Auth auth, Configuration cfg, String bucket, String fileName) {
		//构造一个带指定Zone对象的配置类
//		Configuration cfg = new Configuration(Zone.zone0());
		//...其他参数参考类注释
		BucketManager bucketManager = new BucketManager(auth, cfg);
		try {
			bucketManager.delete(bucket, fileName);
		} catch (QiniuException ex) {
			// 如果遇到异常，说明删除失败
			System.err.println(ex.code());
			System.err.println(ex.response.toString());
		}
	}

	/**
	 * 上传base64图片
	 * @param file64
	 * @param qiniuInfo
	 * @return
	 * @throws IOException 
	 */
	public String uploadAvatar(String file64, QiniuInfo qiniuInfo) throws IOException {
		// 密钥配置
		String ak = qiniuInfo.getAk();
		String sk = qiniuInfo.getSk();
		Auth auth = Auth.create(ak, sk);
		
		// 空间名
		String bucketname = qiniuInfo.getBucket();
		// 上传的图片名
		String key = UUID.randomUUID().toString().replace("-", "");
		
		file64 = file64.substring(22);
//		System.out.println("file64:"+file64);
		String url = "http://upload.qiniu.com/putb64/" + -1 + "/key/" + UrlSafeBase64.encodeToString(key);
		// 非华东空间需要根据注意事项 1 修改上传域名
		RequestBody rb = RequestBody.create(null, file64);
		String upToken  = auth.uploadToken(bucketname, null, 3600, new StringMap().put("insertOnly", 1));
		Request request = new Request.Builder()
				.url(url)
				.addHeader("Content-Type", "application/octet-stream")
				.addHeader("Authorization", "UpToken " + upToken)
				.post(rb).build();
//		System.out.println(request.headers());
		OkHttpClient client = new OkHttpClient();
		okhttp3.Response response = client.newCall(request).execute();
		System.out.println(response);
		
		String imgUrl = qiniuInfo.getDomain() + key;
		
		return imgUrl;
	}

}
