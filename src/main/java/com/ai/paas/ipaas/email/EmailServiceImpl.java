package com.ai.paas.ipaas.email;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ExecutionException;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.ui.velocity.VelocityEngineUtils;

import com.ai.paas.ipaas.system.util.EmailTemplUtil;
import com.ai.paas.ipaas.vo.user.EmailDetail;

/**
 * 发送邮件
 */
@Service
public class EmailServiceImpl {
	private static final Logger logger = LogManager.getLogger(EmailServiceImpl.class.getName());

	private JavaMailSender javaMailSender;
	private SimpleMailMessage simpleMailMessage;
	
	public String sendEmail(EmailDetail emailDetail) throws SQLException,
			InterruptedException, ExecutionException {
		logger.info("-------------email.toAddress:"+emailDetail.getToAddress()+"---------");
		logger.info("-------------email.title:"+emailDetail.getEmailTitle()+"---------");
		logger.info("-------------email.content:"+emailDetail.getEmailContent()+"---------");
		
		String returnFlag = "发送成功！";
		if ("".equals(emailDetail.getToAddress())
				|| emailDetail.getToAddress() == null) {
			returnFlag = "发送失败，失败原因：收件人地址为空！";
			emailDetail.setFailReason(returnFlag);
		}
		if ("".equals(emailDetail.getEmailContent())
				|| emailDetail.getEmailContent() == null) {
			returnFlag = "发送失败，失败原因：邮件内容为空！";
			emailDetail.setFailReason(returnFlag);
		}
		if ("".equals(emailDetail.getEmailTitle())
				|| emailDetail.getEmailTitle() == null) {
			returnFlag = "发送失败，失败原因：邮件标题为空！";
			emailDetail.setFailReason(returnFlag);
		}
		
		send(emailDetail);
		
		return returnFlag;
	}
	
	/**
	 * 使用JavaMailSenderImpl 发送邮件
	 * @param emailDetail
	 */
	private void send(EmailDetail emailDetail) {
		try {
			logger.info("------------ sendEmail start -------------");
			MimeMessage mimeMessage = javaMailSender.createMimeMessage();
			MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "utf-8");
			messageHelper.setFrom(simpleMailMessage.getFrom());
			messageHelper.setSubject(emailDetail.getEmailTitle());
			messageHelper.setText(emailDetail.getEmailContent(), true);
			messageHelper.setTo(emailDetail.getToAddress());
			if (emailDetail.getEmailCc() != null && !"".equals(emailDetail.getEmailCc())) {
				messageHelper.setBcc(new InternetAddress("mail.asiainfo.com",
						emailDetail.getEmailCc(), "utf-8"));
			}

			javaMailSender.send(mimeMessage);
			logger.info("------------ sendEmail complete -------------");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error(e.getMessage());
		}
	}
	
	public void setJavaMailSender(JavaMailSender javaMailSender) {
		this.javaMailSender = javaMailSender;
	}

	public void setSimpleMailMessage(SimpleMailMessage simpleMailMessage) {
		this.simpleMailMessage = simpleMailMessage;
	}

	public static void main(String[] args) {
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String time = df.format(new Date());  // "2015-09-15 20:24:20"

		String subject = "[亚信云邮件发送>测试_通知]";
		String toSenders = "yuanman2002@126.com";
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("title", subject);
		model.put("call", toSenders);
		model.put("troubleNo", "T00008");
		model.put("user", "亚信");
		model.put("sys_time", time);
		String text = "审核结果：不通过" + "<br>用户反馈:kkkwkwkkw"
				+ "<br>反馈时间：2016-06-12 15:15:15";
		model.put("message", text);
		String content = VelocityEngineUtils.mergeTemplateIntoString(
				 EmailTemplUtil.getVelocityEngineInstance(), "template/common.vm",
				 "UTF-8", model);
		
		EmailDetail email = new EmailDetail();
		email.setToAddress(toSenders);
		email.setEmailContent(content);
		email.setEmailTitle(subject);
		email.setFromAddress("ai-cloud@asiainfo.com");
		email.setFromPwd("Paas0309_");
		
		new EmailServiceImpl().send(email);
	}
}
