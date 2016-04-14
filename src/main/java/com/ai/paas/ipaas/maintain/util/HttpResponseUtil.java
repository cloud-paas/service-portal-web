package com.ai.paas.ipaas.maintain.util;

import org.apache.log4j.Logger;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletResponse;
/**
 * 
 * 请求响应到客户端
 * @author Fenggw
 *
 */
public class HttpResponseUtil {
	
	private static Logger logger = Logger.getLogger(HttpResponseUtil.class);
	
    public static void sendResponse(String result,HttpServletResponse response) throws IOException{
    	
    	PrintWriter printWriter = null;
 		try {
 			response.setContentType("text/html;charset=utf-8");
 			printWriter = response.getWriter();
 			printWriter.write(result);
 			printWriter.flush();
 		} catch (Exception e) {
 			logger.error("重大异常，responseSuccess报错！", e);
 		} finally {
 			printWriter.close();
 		}
    }
}
