package com.ai.paas.ipaas.system.util;

import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

/**
 * -----------------------------------------
 * 
 * @作者: jianhua.ma
 * @时间: 2015-01-30
 * @描述: 发送Email工具类 -----------------------------------------
 */
public class Email {
	private JavaMailSender javaMailSender;
	private SimpleMailMessage simpleMailMessage;

	/**
	 * @方法名: sendMail
	 * @参数名：@param subject 邮件主题
	 * @参数名：@param content 邮件主题内容
	 * @参数名：@param to 收件人Email地址
	 * @描述语: 发送邮件
	 */
	public void sendMail(String subject, String content, String to) {

		try {
			MimeMessage mimeMessage = javaMailSender.createMimeMessage();
			/**
			 * new MimeMessageHelper(mimeMessage,true)之true个人见解：
			 * 关于true参数,官方文档是这样解释的： use the true flag to indicate you need a
			 * multipart message 翻译过来就是：使用true,以表明你需要多个消息
			 * 再去翻一下MimeMessageHelper的API,找到这样一句话： supporting alternative texts,
			 * inline elements and attachments 也就是说,如果要支持内联元素和附件就必须给定第二个参数为true
			 * 否则抛出 java.lang.IllegalStateException 异常
			 */
			MimeMessageHelper messageHelper = new MimeMessageHelper(
					mimeMessage, true, "utf-8");
			messageHelper.setFrom(simpleMailMessage.getFrom()); // 设置发件人Email
			messageHelper.setSubject(subject); // 设置邮件主题
			messageHelper.setText(content, true); // 设置邮件主题内容
			messageHelper.setTo(to);
			// messageHelper.setText("<html><head></head><body><h1>hello!!chao.wang</h1></body></html>",true);
			// //设定收件人Email
			/**
			 * ClassPathResource：很明显就是类路径资源,我这里的附件是在项目里的,所以需要用ClassPathResource
			 * 如果是系统文件资源就不能用ClassPathResource,而要用FileSystemResource,例：
			 * FileSystemResource file = new FileSystemResource(new
			 * File("D:/Readme.txt"));
			 */
			// ClassPathResource file = new
			// ClassPathResource("attachment/Readme.txt");
			/**
			 * MimeMessageHelper的addAttachment方法： addAttachment(String
			 * attachmentFilename, InputStreamSource inputStreamSource)
			 * InputStreamSource是一个接口
			 * ,ClassPathResource和FileSystemResource都实现了这个接口
			 */
			// messageHelper.addAttachment(file.getFilename(), file); //添加附件
			javaMailSender.send(mimeMessage); // 发送附件邮件

		} catch (Exception e) {
			throw new RuntimeException("fail to send email ccs when register!stupid!");
		}
	}

	// Spring 依赖注入
	 public void setSimpleMailMessage(SimpleMailMessage simpleMailMessage) {
	 this.simpleMailMessage = simpleMailMessage;
	 }
	 //Spring 依赖注入
	 public void setJavaMailSender(JavaMailSender javaMailSender) {
	 this.javaMailSender = javaMailSender;
	 }
	 public static void main(String[] args) throws InterruptedException {
	        List <String> numberList=new ArrayList<String>();
	        String result =null;
			String subject = "[亚信云测试]";
			String content =  "<html><head></head><body>"
					+ "<span>"+"<font size='6px' >亲爱的帅哥，您好！</font></span></br>"
					+ "<span style='margin-left: 40px;'>"+"<font size='5px' style='font-family:宋体;'>您正在进行邮箱绑定，点击以下链接完成验证。</font></span></br>"
															
					+ "<span style='margin-left: 40px;'>"+"<font size='5px' style='font-family:宋体;'>http://10.1.228.198:14815/iPaas-Web/audit/verfiy_email?token=token</font></span></br>"
															
					+ "<span style='margin-left: 40px;'>"+"<font size='5px' style='font-family:宋体;'>如果该链接无法点击，请将其复制粘贴到你的浏览器地址栏中访问。</font></span></br>"
															
					+ "<span style='margin-left: 40px;'>"+"<font size='5px' style='font-family:宋体;'>如果这不是您的邮件，请忽略此邮件。</font></span></br>"
																									
					+ "<span style='margin-left: 40px;'>"+"<font size='5px' style='font-family:宋体;'>这是亚信云系统邮件，请勿回复。</font></span></body></html>";
			String toSenders = "majh5@asiainfo.com";
			/*
			 * JSONObject jsonObject =new JSONObject(); jsonObject.put("subject",
			 * "[亚信云测试]"); jsonObject.put("content", "[亚信云测试]");
			 * jsonObject.put("toSenders",
			 * "zhanglei11@asiainfo.com|majh5@asiainfo.com");
			 */

			result=HttpRequestUtil.sendPost("http://10.1.228.198:14815/iPaas-Web/email/sendEmail","subject="+subject+"&content="+content+"&toSenders="+toSenders);
			
			//result = HttpRequestUtil.sendPost("http://10.1.228.198:14815/iPaas-Web/email/sendEmail","subject=" + subject + "&content=" + content + "&toSenders="+ toSenders);
			System.out.println(result);
		}
}
