package com.ai.paas.ipaas.system.util;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.tapestry5.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.velocity.VelocityEngineUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.util.CiperUtil;
import com.ai.paas.ipaas.util.JSonUtil;
import com.ai.paas.ipaas.zookeeper.SystemConfigHandler;
import com.alibaba.dubbo.config.annotation.Reference;

@Controller
@RequestMapping(value = "/email")
public class EmailUtil {
	private static final Logger log = LogManager.getLogger(EmailUtil.class.getName());
	
	@Autowired 
	private Email simpleMail;
	
	@Reference
	private ISysParamDubbo iSysParam;
	
	@ResponseBody
	@RequestMapping(value = "/sendEmail")
	public String sendEmail(HttpServletRequest request, HttpServletResponse response) {
		long beginTime = System.currentTimeMillis();
		JSONObject json = new JSONObject();
		try {
			String subject= request.getParameter("subject");
			String email= request.getParameter("toSenders");
			
			Map<String,Object> model = new HashMap<String,Object>();  
	        model.put("email", email);  
	        //获取邮件激活链接地址	
	        String iPaasDubboUrl= SystemConfigHandler.configMap.get("IPAAS-WEB.SERVICE.IP_PORT_SERVICE");
	    	String authVerifyUrl= SystemConfigHandler.configMap.get("AUTH.VERIFY.url");
			String address = iPaasDubboUrl + authVerifyUrl;
			String token   = CiperUtil.encrypt(Constants.SECURITY_KEY, email);
	        model.put("activeLink", address+"?token="+token);
	        
	    	String content = VelocityEngineUtils.mergeTemplateIntoString(
	    	EmailTemplUtil.getVelocityEngineInstance(), "mail.vm", "UTF-8", model);
			log.info("----------send emailList11      spend time："+(System.currentTimeMillis()-beginTime));
			simpleMail.sendMail(subject, content, email);
			log.info("----------send emailList22      spend time："+(System.currentTimeMillis()-beginTime));
			json.put("resultFlag", "true");
			json.put("resultMsg", "send email success");
			log.info("----------send emailList      spend time："+(System.currentTimeMillis()-beginTime));
			
			return json.toString();
		} catch (Exception e) {
			log.error(e.getMessage(),e);
			json.put("resultFlag", "false");
			json.put("resultMsg", "send email failed");
			return json.toString();
		} 
	}
	
	@ResponseBody
	@RequestMapping(value = "/sendEmailService")
	public String sendEmailService(HttpServletRequest request, HttpServletResponse response) {
		long beginTime = System.currentTimeMillis();
		JSONObject json = new JSONObject();
		try {
			String subject= request.getParameter("subject");
			String email= request.getParameter("toSenders");				
			String vmfile= request.getParameter("vmfile");
			String param= request.getParameter("param");
			Map model = JSonUtil.fromJSon(param, Map.class);
			System.out.println(model.get("message"));
			String content = VelocityEngineUtils.mergeTemplateIntoString(EmailTemplUtil.getVelocityEngineInstance(), vmfile, "UTF-8", model);
			log.info("----------send emailList11      spend time："+(System.currentTimeMillis()-beginTime));
			log.info("----------send emailList11 -----------content\n"+content);
			simpleMail.sendMail(subject, content, email);
			log.info("----------send emailList22      spend time："+(System.currentTimeMillis()-beginTime));
			json.put("resultCode", Constants.OPERATE_CODE_SUCCESS);
			json.put("resultMsg", "send email success");
			log.info("----------send emailList      spend time："+(System.currentTimeMillis()-beginTime));
			return json.toString();
		} catch (Exception e) {
			json.put("resultCode", Constants.OPERATE_CODE_FAIL);
			json.put("resultMsg", "send email failed");
			log.error(e.getMessage(),e);
			return json.toString();
			
		} 
		
	}


}
