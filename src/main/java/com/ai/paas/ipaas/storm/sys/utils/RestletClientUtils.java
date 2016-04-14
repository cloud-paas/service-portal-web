package com.ai.paas.ipaas.storm.sys.utils;

import java.io.FileInputStream;
import java.io.InputStream;

import org.restlet.representation.InputRepresentation;
import org.restlet.representation.Representation;
import org.restlet.resource.ClientResource;

public class RestletClientUtils {
	/**
	 * 执行远程指令
	 */
	public static String executeInstruction(String uri, String instruction) throws Exception{
		String result = null;
		ClientResource clientResource = new ClientResource(uri);
		Representation representation = clientResource.post(instruction);
		result = representation.getText();
		clientResource.release();
		return result;
	}
	/**
	 * 上传文件
	 * http://10.1.228.198:60001
	 */
	public static String uploadFile(String ipAndPort, String dstPath,FileInputStream inputStream) throws Exception{
		try {
			String result = null;
			String uri = "http://"+ipAndPort+"/exe/file?dstPath="+dstPath;
			ClientResource clientResource = new ClientResource(uri);
			//FileInputStream fileInputStream = (FileInputStream) (inputStream);
			Representation representation = clientResource.post(new InputRepresentation(inputStream));
			//Representation representation = clientResource.post(inputStream);
			result = representation.getText();
			clientResource.release();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}finally{
			inputStream.close();
		}
	}
	/**
	 * 远程服务器执行命令
	 * http://10.1.228.198:60001
	 */
	public static String exeCmd(String ipAndPort, String dstPath,String cmd) throws Exception{
		try {
			String result = null;
			String uri = "http://"+ipAndPort+"/cmd/run";
			ClientResource clientResource = new ClientResource(uri);
			System.out.println(uri);
			String param="CMD|path="+dstPath+",cmd="+cmd;
			System.out.println(param);
			Representation representation = clientResource.post(param);
			result = representation.getText();
			System.out.println(result);
			clientResource.release();
			return result;
		} catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
	}
}
