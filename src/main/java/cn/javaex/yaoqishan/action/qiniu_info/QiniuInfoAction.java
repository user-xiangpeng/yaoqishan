package cn.javaex.yaoqishan.action.qiniu_info;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.service.qiniu_info.QiniuInfoService;
import cn.javaex.yaoqishan.view.QiniuInfo;
import cn.javaex.yaoqishan.view.Result;

@Controller
@RequestMapping("qiniu_info")
public class QiniuInfoAction {

	@Autowired
	private QiniuInfoService qiniuInfoService;
	
	/**
	 * 配置指定类型
	 * @param map
	 * @param type
	 * @return
	 */
	@RequestMapping("edit.action")
	public String edit(ModelMap map,
			@RequestParam(value="type") String type) {
		
		QiniuInfo qiniuInfo = qiniuInfoService.selectByType(type);
		map.put("qiniuInfo", qiniuInfo);

		map.put("type", type);
		
		return "admin/qiniu_info/edit";
	}

	/**
	 * 保存配置
	 * @param qiniuInfo
	 * @return
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(QiniuInfo qiniuInfo) {
		
		qiniuInfoService.save(qiniuInfo);
		return Result.success();
	}
	
	/**
	 * 上传本地图片到七牛云
	 * @param file
	 * @param type 类型
	 * @return
	 * @throws IOException
	 * @throws QingException
	 */
	@RequestMapping("upload_image.json")
	@ResponseBody
	public Result uploadImage(
			MultipartFile file,
			@RequestParam(value="type") String type) throws IOException, QingException {
		
		QiniuInfo qiniuInfo = qiniuInfoService.selectByType(type);
		String imgUrl = qiniuInfoService.uploadImage(file, qiniuInfo);
		
		return Result.success().add("imgUrl", imgUrl);
	}
	
	/**
	 * 远程图片上传到七牛云
	 * @param url 远程图片地址
	 * @param type 类型
	 * @return
	 * @throws IOException
	 * @throws QingException
	 */
	@RequestMapping("upload_image_by_yuancheng.json")
	@ResponseBody
	public Result uploadImageByYuancheng(
			@RequestParam(value="imgUrl") String imgUrl,
			@RequestParam(value="type") String type) throws IOException, QingException {
		
		QiniuInfo qiniuInfo = qiniuInfoService.selectByType(type);
		imgUrl = qiniuInfoService.uploadImageByYuancheng(imgUrl , qiniuInfo);
		
		return Result.success().add("imgUrl", imgUrl);
	}
}
