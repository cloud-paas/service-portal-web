package com.ai.paas.ipaas.storm.sys.conf;

public class Constants {
	/**
	 * storm集群信息
	 * @author ja-ence
	 *	注意：目前再次配置，后续可能从配置中心获取
	 */
	public static final class StormClusterInfo{
		public static final String[] logsHostName = {
			"10.1.249.31",
			"10.1.249.32",
			"10.1.249.33"
		};
	}
	public static final class LogInfo{
//		public static final String LOG_DIR = "${STORM_HOME}/logs";
		public static final String LOG_DIR = "/unibss/pocusers/devstp01/apache-storm-0.9.3/logs";
		public static final String LOGVIEWER_PORT = "8000";
		public static final String LOGVIEWER_DEFAUL_PAGE_SIZE = "51200";
		public static final String LOGVIEWER_PAGINATION_URI_ROOT = "${PAGINATION_URI_ROOT}";
		public static final String LOGVIEWER_PAGINATION_HOST_NAME = "${HOST_NAME}";
		public static final String LOGVIEWER_PAGINATION_FILE_NAME = "${FILE_NAME}";
//		public static final String LOGVIEWER_LOG_DOWNLOAD_URI = "${SERVICE_PATH}?";
		public static final String LOGVIEWER_PAGINATION_PAGE_PREV_START = "${PREV_START}";
		public static final String LOGVIEWER_PAGINATION_PAGE_NEXT_START = "${NEXT_START}";
		public static final String LOGVIEWER_HTML_HEAD = "<head><script type=\"text/javascript\" src=\"${ROOT_PATH}/resources/bower_components/jquery/dist/jquery.min.js\"></script><script type=\"text/javascript\" src=\"${ROOT_PATH}/resources/bower_components/bootstrap/dist/js/bootstrap.min.js\"></script><link rel=\"stylesheet\" href=\"${ROOT_PATH}/jsp/storm/common/css/logstyle.css\"></head>";
		//用于正则替换
		public static final String LOGVIEWER_HTML_PAGINATION = "<div class=\"pagination\"><ul><li><a href=\"" + "\\" + LOGVIEWER_PAGINATION_URI_ROOT + "?fileName=\\${FILE_NAME}&amp;hostName=" + "\\"+LOGVIEWER_PAGINATION_HOST_NAME + "&amp;start=0&amp;length=51200\">首页</a></li><li><a href=\"" + "\\" + LOGVIEWER_PAGINATION_URI_ROOT + "?fileName=\\${FILE_NAME}&amp;hostName=" + "\\"+LOGVIEWER_PAGINATION_HOST_NAME + "&amp;\\${PREV_START}&amp;length=51200\">上一页</a></li><li class=\"next disabled\"><a href=\"" + "\\" + LOGVIEWER_PAGINATION_URI_ROOT + "?fileName=\\${FILE_NAME}&amp;hostName=" + "\\"+LOGVIEWER_PAGINATION_HOST_NAME + "&amp;\\${NEXT_START}&amp;length=51200\">下一页</a></li><li><a href=\"" + "\\" + LOGVIEWER_PAGINATION_URI_ROOT + "?fileName=\\${FILE_NAME}&amp;hostName=" + "\\"+LOGVIEWER_PAGINATION_HOST_NAME + "&amp;length=51200\">末页</a></li></ul></div>";
	}
	/**
	 * 代理程序的相关配置信息
	 * @author ja-ence
	 * 
	 */
	public final static class AGENT_INFO{
		/**
		 * 用于代理的端口
		 */
		public static final String PORT = "60001";
		/**
		 * 代理cmd服务的虚拟路径码
		 */
		public static final String REMOTE_CMD_SV_CODE = "";
		/**
		 * 代理远程上传的服务的虚拟路径编码
		 */
		public static final String REMOTE_UPLOAD_SV_CODE = "/normal/file";
		/**
		 * 文件上传
		 */
		public static final String REMOTE_DOWNLOAD_SV_CODE = "/file/transfer";
		/**
		 * 代理远程xml节点添加服务的虚拟路径编码
		 */
		public static final String REMOTE_XML_APPEND_SV_CODE = "/xml/append";
		/**
		 * 操作成功返回字符串
		 */
		public static final String OPER_SUCCESS_RESULT = "SUCCESS";
		/**
		 * 操作失败返回字符串
		 */
		public static final String OPER_FAIL_RESULT = "FAIL";
	}
}
