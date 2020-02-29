package cn.javaex.yaoqishan.constant;

/**
 * 固定选项类
 */
public class FixedOption {
	public enum Option {
		NUMBER("number", "数字(number)"),
		TEXT("text", "文本(text)"),
		TEXTAREA("textarea", "文本域(textarea)"),
		RADIO("radio", "单选(radio)"),
		CHECKBOX("checkbox", "多选(checkbox)"),
//		IMAGE("image", "上传图片(image)"),
//		URL("url", "超链接(url)"),
//		SELECT("select", "下拉选择(select)"),
//		DAY("day", "日期(day)"),
//		DAY2("day2", "范围日期(day2)"),
//		STAR("star", "人物(自带链接)")
		;
		
		private String value;
		private String name;
		private Option(String value, String name) {
			this.value = value;
			this.name = name;
		}

		public String getValue() {
			return value;
		}
		public void setValue(String value) {
			this.value = value;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
	}
	
	public enum Blood {
		A("A", "A型"),
		B("B", "B型"),
		AB("AB", "AB型"),
		O("O", "O型")
		;
		
		private String value;
		private String name;
		private Blood(String value, String name) {
			this.value = value;
			this.name = name;
		}

		public String getValue() {
			return value;
		}
		public void setValue(String value) {
			this.value = value;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
	}
	
	public enum Constellation {
		ARIES("白羊座", "白羊座"),
		TAURUS("金牛座", "金牛座"),
		GEMINI("双子座", "双子座"),
		CANCER("巨蟹座", "巨蟹座"),
		LEO("狮子座", "狮子座"),
		VIRGO("处女座", "处女座"),
		LIBRA("天秤座", "天秤座"),
		SCORPIO("天蝎座", "天蝎座"),
		SAGITTARIUS("射手座", "射手座"),
		CAPRICORNUS("摩羯座", "摩羯座"),
		AQUARIUS("水瓶座", "水瓶座"),
		PISCES("双鱼座", "双鱼座")
		;
		
		private String value;
		private String name;
		private Constellation(String value, String name) {
			this.value = value;
			this.name = name;
		}

		public String getValue() {
			return value;
		}
		public void setValue(String value) {
			this.value = value;
		}
		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
	}
	
	public static void main(String[] args) {
		// 输出某一枚举的值
		System.out.println(Option.TEXT.getValue());
		System.out.println(Option.TEXT.getName());
		
		// 遍历所有的枚举
		for (Option opt : Option.values()) {
			System.out.println(opt + "		value:" + opt.getValue() + "  name:" + opt.getName());
		}
	}
}
