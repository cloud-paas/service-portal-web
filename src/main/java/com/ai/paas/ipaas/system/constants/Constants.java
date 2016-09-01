package com.ai.paas.ipaas.system.constants;

public class Constants {

	/**
	 * 常量定义类
	 */
	public static class serviceType {
		/**
		 * 服务类型定义
		 */
		public final static int CONFIG_CENTER = 1;
		public final static int CACHE_CENTER = 2;
		public final static int MESSAGE_CENTER = 3;
		public final static int CALCULATE_CENTER = 4;
		public final static int TRANSACTION_CENTER = 5;
		public final static int DBCENTER_CENTER = 6;
		public final static int TRANS_CENTER = 7;
		public final static int DBS_CENTER = 8;

		public final static String IAAS_PHYSICAL = "10";
		public final static String IAAS_VIRTAL = "11";
		public final static String IAAS_MEMORY = "12";

		public final static String DES_CENTER = "14";
		public final static String SES_CENTER = "15";
		public final static int IDPS_CENTER = 16;
		public final static int RDS_CENTER = 17;
	}

	public static class serviceName {
		/**
		 * @author zhaogw 服务名称定义
		 */
		public final static String CCS = "CCS";
		public final static String MCS = "MCS";
		public final static String MDS = "MDS";
		public final static String RCS = "RCS";
		public final static String ATS = "ATS";
		public final static String DSS = "DSS";
		public final static String TXS = "TXS";
		public final static String DBS = "DBS";
		public final static String TSC = "TSC";
		public final static String DES = "DES";
		public final static String SES = "SES";
		public final static String IDPS = "IDPS";
		public final static String RDS = "RDS";

		public final static String IAAS_PHYSICAL = "IAAS_PHYSICAL";
		public final static String IAAS_VIRTAL = "IAAS_VIRTAL";
		public final static String IAAS_MEMORY = "IAAS_MEMORY";
	}

	public static class paramCode {
		public final static String OPTIONS = "OPTIONS";
		public final static String MODES = "MODES";
		public final static String OPEN_RESULT = "OPEN_RESULT"; // ORDER_DETAIL表中OPEN_RESUIT字段
		public final static String ORDER_CHECK_RESULT = "ORDER_CHECK_RESULT"; // ORDER_DETAIL表中ORDER_CHECK_RESULT字段
		public final static String SELETE_TYPE = "SELETE_TYPE"; // ORDER_DETAIL表中ORDER_CHECK_RESULT字段
	}

	/**
	 * 表名称
	 * 
	 * @author yinxiao
	 */
	public static class TableName {
		public final static String ORDER_DETAIL = "ORDER_DETAIL";
	}

	/**
	 * 返回结果
	 * 
	 * @author lixiongcheng
	 *
	 */
	public static class RType {
		public static final String SUCCESS = "0";
		public static final String FAILED = "1";
	}

	/**
	 * 产品类型
	 * 
	 * @author yinxiao
	 */
	public static class ProductType {
		// Ipaas
		// 1计算 2 数据库服务 3存储 2015.11.6
		public static final String IPAAS_JiSuan = "1"; // PROD_IAAS = "2";//计算

		// Iaas
		public static final String IPAAS_ShuJK = "2"; // PROD_TAB = "3"; //数据库

		// TAB
		public static final String IPAAS_CunChu = "3"; // PROD_IPAAS = "1";//存储
	}

	/**
	 * 操作类型
	 * 
	 * @author yinxiao
	 */
	public static class OperateType {
		public static final String APPLY = "1"; // 申请
		public static final String UPDATE = "2"; // 扩容
		public static final String UNSUBSCRIBE = "3"; // 退订
	}

	/**
	 * 账户来源
	 */
	public static class authSource {
		public static final String AUTHSOURCE_WEB = "WEB";
	}

	public static class PageResult {
		public static final int PAGE_SIZE = 10;
		public static final int SMALL_PAGE_SIZE = 5;
	}

	/**
	 * 用户状态
	 * 
	 */
	public static class userState {
		public static final String USER_STATE_OK = "2";// 已激活
		public static final String USER_STATE_NOK = "1";// 未激活
	}

	public static final String OPERATE_CODE_SUCCESS = "000000";// 操作成功

	public static final String OPERATE_CODE_FAIL = "999999";// 操作失败

	public static final String SECURITY_KEY = "7331c9b6b1a1d521363f7bca8acb095f";// md5
}
