package cn.javaex.yaoqishan.util;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import sun.misc.BASE64Encoder;

/**
 * 根据图片地址转换为base64编码字符串
 */
public class ImgBase64 {
	public static String getImageBase64(String imgFile) {
		InputStream inputStream = null;
		byte[] data = null;
		try {
			inputStream = new FileInputStream(imgFile);
			data = new byte[inputStream.available()];
			inputStream.read(data);
			inputStream.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		// 返回Base64编码过的字节数组字符串
		BASE64Encoder encoder = new BASE64Encoder();
		String imgStr = encoder.encode(data);
		
		return "data:image/jpeg;base64,"+imgStr;
	}
}
