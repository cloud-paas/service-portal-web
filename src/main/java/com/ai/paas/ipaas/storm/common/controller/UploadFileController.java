package com.ai.paas.ipaas.storm.common.controller;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ai.paas.ipaas.storm.sys.utils.DateUtils;
import com.ai.paas.ipaas.storm.sys.utils.EnvUtils;
import com.ai.paas.ipaas.storm.sys.utils.JsonUtils;
import com.ai.paas.ipaas.storm.sys.utils.UUIDUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrder;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.alibaba.dubbo.config.annotation.Reference;
/**
 * 上传文件
 */
@Controller
@RequestMapping("/rcs/uploadFile")
public class UploadFileController {
	@Reference
	private IOrder iOrder;
	@Reference
	private ISysParamDubbo iSysParam;
	private Logger logger = Logger.getLogger(UploadFileController.class);

	/**
	 * 上传jar文件
	 */
	@RequestMapping(method = RequestMethod.POST,value = "/uploadJars")
	public void uploadJars(HttpServletResponse response,HttpServletRequest request) {
		System.out.println("comein");
		System.out.println(64364364);
	//public void uploadJar(@RequestParam("insertFile") CommonsMultipartFile mFile, HttpServletResponse response,HttpServletRequest request) {
		System.out.println("OK");
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile mFile = multipartRequest.getFile("myFile");
		try {
			if (!mFile.isEmpty()) {
				// jar文件大小校验
				if (mFile.getSize()>1024*1024*10) {
					response.getWriter().write(JsonUtils.createJSONObject("error", "1", "message", "jar文件大小不能超过10MB","errorType","1").toString());
					response.getWriter().flush();
					return;
				}
				//  jar文件后缀格式校验
				String contentType=mFile.getContentType();
				if (!"application/java-archive".equalsIgnoreCase(contentType)
						&&!"application/octet-stream".equalsIgnoreCase(contentType)
						&&!"application/x-zip-compressed".equalsIgnoreCase(contentType)) {
					response.getWriter().write(JsonUtils.createJSONObject("error", "1", "message", "jar文件格式校验失败，请检查jar文件格式","errorType","2").toString());
					response.getWriter().flush();
					return;
				}else {//主要是处理某些插件不支持mpeg结尾的mp3文件
					contentType="application/java-archive";
				}
				// 文件夹key值
				String mainFolder = EnvUtils.$HOME()+"/stormJars/";
				File mainFolderFile = new File(mainFolder);
				if (!mainFolderFile.exists()) {// 所配置的文件夹不存在需要创建
					mainFolderFile.mkdirs();
				}
				// 子文件夹方案 目前是按照月份存储
				String subFolderString = DateUtils.nowDateyyyyMM();
				File subFolderFile = new File(mainFolder + "/" + subFolderString);
				if (!subFolderFile.exists()) {// 子文件夹不存在需要创建
					subFolderFile.mkdirs();
				}
				// 先拷贝文件，在写数据库
				String newFileName = UUIDUtil.randomUUID() + ".jar";
				File newFile = new File(mainFolder + "/" + subFolderString + "/" + newFileName);
				mFile.transferTo(newFile);
				//
				JSONObject obj = new JSONObject();
				obj.put("error", 0);
				obj.put("url", "");
				obj.put("fk",newFile.getPath());
				///
				response.getWriter().write(obj.toString());
				response.getWriter().flush();
			} else {
				response.getWriter().write(JsonUtils.createJSONObject("error", "1", "message", "上传jar文件内容为空","errorType","3").toString());
				response.getWriter().flush();
				return;
			}
		} catch (Exception e) {
			try {
				logger.error("上传文件-上传jar文件", e);
				response.getWriter().write(JsonUtils.createJSONObject("error", "1", "message", "系统错误","errorType","4").toString());
				response.getWriter().flush();
				return;
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
	}
	
//	
//	/**
//	 * 上传jar文件
//	 */
//	@RequestMapping(value = "/uploadJar", method = RequestMethod.POST)
//	public void uploadJar(@RequestParam("insertFile") CommonsMultipartFile mFile, HttpServletResponse response,HttpServletRequest request) {
//		System.out.println("OK");
//		try {
//			if (!mFile.isEmpty()) {
//				// jar文件大小校验
//				if (mFile.getSize()>1024*1024*10) {
//					response.getWriter().write(JsonUtils.createJSONObject("error", "1", "message", "jar文件大小不能超过10MB").toString());
//					response.getWriter().flush();
//					return;
//				}
//				//  jar文件后缀格式校验
//				String contentType=mFile.getContentType();
//				if (!"application/java-archive".equalsIgnoreCase(contentType)
//						&&!"application/octet-stream".equalsIgnoreCase(contentType)
//						&&!"application/x-zip-compressed".equalsIgnoreCase(contentType)) {
//					response.getWriter().write(JsonUtils.createJSONObject("error", "1", "message", "jar文件格式校验失败，请检查jar文件格式").toString());
//					response.getWriter().flush();
//					return;
//				}else {//主要是处理某些插件不支持mpeg结尾的mp3文件
//					contentType="application/java-archive";
//				}
//				// 文件夹key值
//				String mainFolder = EnvUtils.$HOME()+"/stormJars/";
//				File mainFolderFile = new File(mainFolder);
//				if (!mainFolderFile.exists()) {// 所配置的文件夹不存在需要创建
//					mainFolderFile.mkdirs();
//				}
//				// 子文件夹方案 目前是按照月份存储
//				String subFolderString = DateUtils.nowDateyyyyMM();
//				File subFolderFile = new File(mainFolder + "/" + subFolderString);
//				if (!subFolderFile.exists()) {// 子文件夹不存在需要创建
//					subFolderFile.mkdirs();
//				}
//				// 先拷贝文件，在写数据库
//				String newFileName = UUIDUtil.randomUUID() + ".jar";
//				File newFile = new File(mainFolder + "/" + subFolderString + "/" + newFileName);
//				mFile.transferTo(newFile);
//				//
//				JSONObject obj = new JSONObject();
//				obj.put("error", 0);
//				obj.put("url", "");
//				obj.put("fk",newFile.getPath());
//				///
//				response.getWriter().write(obj.toString());
//				response.getWriter().flush();
//			} else {
//				response.getWriter().write(JsonUtils.createJSONObject("error", "1", "message", "上传jar文件内容为空").toString());
//				response.getWriter().flush();
//				return;
//			}
//		} catch (Exception e) {
//			try {
//				logger.error("上传文件-上传jar文件", e);
//				response.getWriter().write(JsonUtils.createJSONObject("error", "1", "message", "系统错误").toString());
//				response.getWriter().flush();
//				return;
//			} catch (IOException e1) {
//				e1.printStackTrace();
//			}
//		}
//	}
}
