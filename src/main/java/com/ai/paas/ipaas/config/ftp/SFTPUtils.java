package com.ai.paas.ipaas.config.ftp;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;
import java.util.Vector;

import org.apache.log4j.Logger;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpException;

public class SFTPUtils {

	private Logger log = Logger.getLogger(getClass());

	private static String directory = SFTPConfig.getString("SFTP.REQ.DIRECTORY");
	private static String host = SFTPConfig.getString("SFTP.REQ.HOST");
	private static String username = SFTPConfig.getString("SFTP.REQ.USERNAME");
	private static String password = SFTPConfig.getString("SFTP.REQ.PASSWORD");
	private static String prot = SFTPConfig.getString("SFTP.REQ.PORT");

	private static Map<String, String> sftpDetails = new HashMap<String, String>();

	static {
		sftpDetails.put(SFTPConstants.SFTP_REQ_HOST,host);
		sftpDetails.put(SFTPConstants.SFTP_REQ_USERNAME,username);
		sftpDetails.put(SFTPConstants.SFTP_REQ_PASSWORD,password);
		sftpDetails.put(SFTPConstants.SFTP_REQ_PORT,prot);
	}

	/**
	 * 上传文件
	 * 
	 * @param uploadFile
	 *            要上传的文件
	 */
	public boolean upload(String uploadFile) {
		boolean result = false;
		try {
			SFTPChannel channel = new SFTPChannel();
			ChannelSftp chSftp = channel.getChannel(sftpDetails, 60000);
			chSftp.cd(directory);
			File file = new File(uploadFile);
			chSftp.put(uploadFile, file.getName()); 
			chSftp.quit();
			channel.closeChannel();
			file = null;
			result = true;
		} catch (Exception e) {
			log.error(this, e);
		}
		return result;
	}

	/**
	 * 上传文件
	 * 
	 * @param directory
	 *            上传的目录
	 * @param uploadFile
	 *            要上传的文件
	 * @param sftpDetails
	 */
	public boolean upload(String directory, String uploadFile,
			Map<String, String> sftpDetails) {
		boolean result = false;
		try {
			SFTPChannel channel = new SFTPChannel();
			ChannelSftp chSftp = channel.getChannel(sftpDetails, 60000);
			chSftp.cd(directory);
			File file = new File(uploadFile);
			chSftp.put(uploadFile, file.getName());
			chSftp.quit();
			channel.closeChannel();
			file = null;
			result = true;
		} catch (Exception e) {
			log.error(this, e);
		}
		return result;
	} 
	/**
	 * 下载文件
	 * 
	 * @param directory
	 *            下载目录
	 * @param downloadFile
	 *            下载的文件
	 * @param sftpDetails
	 */
	public ByteArrayOutputStream download(String downloadFile,String type){
		ByteArrayOutputStream result = null;
		InputStream is = null;
		BufferedInputStream bis = null;
		SFTPChannel channel = null;
		ChannelSftp chSftp = null;
		try {
			channel = new SFTPChannel();
			chSftp = channel.getChannel(sftpDetails, 60000);
			if(SFTPConstants.SFTP_DIR_TYPE_SDK.equals(type)){
				chSftp.cd(directory+SFTPConstants.SFTP_DIR_SDK);
			}
			if(SFTPConstants.SFTP_DIR_TYPE_DOC.equals(type)){
				chSftp.cd(directory+SFTPConstants.SFTP_DIR_DOC);
			}
			is = chSftp.get(downloadFile); 
			bis = new BufferedInputStream(is);
			result = new ByteArrayOutputStream();
			byte[] b = new byte[1024];
			int len = -1;
			while ((len = bis.read(b, 0, 1024)) != -1) {
				result.write(b, 0, len);
			}
			result.flush();
			chSftp.quit();
			channel.closeChannel();
		} catch (SftpException	 e) {
			if(chSftp.SSH_FX_NO_SUCH_FILE == e.id){
				 throw new SFTPException("资源【"+downloadFile+"】文件不存在");
			}
		} catch (Exception e) {
			log.error(this, e);
		} finally {
			try {
				if (null != is) {
					is.close();
					is = null;
				}
				if (null != bis) {
					bis.close();
					bis = null;
				}
			} catch (Exception e) {
				log.error(this, e);
			}
		}
		return result;
	}

	/**
	 * 
	 * @param src
	 *            上传到目标服务器的输入流InputStream
	 * @param fileName
	 *            保存在服务器的文件名
	 * @param serverPath
	 *            Sftp服务器路径
	 * @return
	 */
	public boolean uploadToSftp(InputStream src, String fileName) {
		boolean result = false;
		try {
			SFTPChannel channel = new SFTPChannel();
			ChannelSftp chSftp = channel.getChannel(sftpDetails, 60000);
			chSftp.cd(directory);
			chSftp.put(src, fileName);
			src.close();// 关闭输入流
			chSftp.quit();
			channel.closeChannel();
			result = true;
		} catch (Exception e) {
			log.error(this, e);
		}
		return result;
	}

	/**
	 * 删除文件
	 * 
	 * @param fileName
	 * @return
	 */
	public boolean deleteToSftp(String fileName) {
		boolean result = false;
		try {
			SFTPChannel channel = new SFTPChannel();
			ChannelSftp chSftp = channel.getChannel(sftpDetails, 60000);
			chSftp.cd(directory);
			chSftp.rm(fileName);
			chSftp.quit();
			channel.closeChannel();
			result = true;
		} catch (Exception e) {
			log.error(this, e);
		}
		return result;
	}

	/**
	 * 展示文件列表
	 * 
	 * @param type  
	 * @return
	 */
	public List<String> getFileList(String type){ 
		List<String> list = new ArrayList<String>();
		try {
			SFTPChannel channel = new SFTPChannel();
			ChannelSftp chSftp = channel.getChannel(sftpDetails, 60000); 
			if(SFTPConstants.SFTP_DIR_TYPE_SDK.equals(type)){
				chSftp.cd(directory+SFTPConstants.SFTP_DIR_SDK);
			}
			if(SFTPConstants.SFTP_DIR_TYPE_DOC.equals(type)){
				chSftp.cd(directory+SFTPConstants.SFTP_DIR_DOC);
			}
			Vector<?> vector = chSftp.ls("*.*");
			chSftp.setFilenameEncoding("UTF-8");
			chSftp.setTerminalMode("binary".getBytes());
			int length = vector.size();
			if(length > 0){
				for(int i = 0; i < length ; i++){
					String fileName = vector.get(i).toString();
					if(fileName.startsWith("d")){
						continue;
					}
					fileName = fileName.substring(fileName.lastIndexOf(" ")+1);	
					try {
						fileName = new String(fileName.getBytes("UTF-8"),"gb2312");
						System.out.println("+++++++++++++++++++++++++++++++++"+new String(fileName.getBytes("UTF-8"),"gb2312")+"+++++++++++++++++++++++++++++++++");
					} catch (UnsupportedEncodingException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
					list.add(fileName);
				} 
			} 
		} catch (JSchException e) {
			log.error(e.getMessage());
		} catch(SftpException e){
			log.error(e.getMessage());
		}
		return list;
	}
	public static void main(String[] args) throws Exception {
		SFTPUtils util = new SFTPUtils();
		util.getFileList("");  
	}
}
