/**
 * 
 */
/**
 * @author sunhongzhen
 *
 */
package com.ai.paas.ipaas.checkservice;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ai.paas.ipaas.checkservice.Util.MsgProcessorHandlerImpl;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.checkservice.Util.MessageCustomerTask;
import com.ai.paas.ipaas.checkservice.transaction.dtm.local.message.MessageTest;
import com.ai.paas.ipaas.image.IImageClient;
import com.ai.paas.ipaas.image.ImageClientFactory;
import com.ai.paas.ipaas.mcs.CacheFactory;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.paas.ipaas.mds.IMessageConsumer;
import com.ai.paas.ipaas.mds.IMessageSender;
import com.ai.paas.ipaas.mds.IMsgProcessorHandler;
import com.ai.paas.ipaas.mds.MsgConsumerFactory;
import com.ai.paas.ipaas.mds.MsgSenderFactory;
import com.ai.paas.ipaas.search.service.ISearchClient;
import com.ai.paas.ipaas.search.service.SearchClientFactory;
import com.ai.paas.ipaas.uac.vo.AuthDescriptor;
import com.ai.paas.ipaas.util.StringUtil;
import com.ai.paas.ipaas.zookeeper.SystemConfigHandler;
import com.ai.paas.ipaas.ccs.ConfigFactory;
import com.ai.paas.ipaas.ccs.IConfigClient;
import com.ai.paas.ipaas.ccs.inner.CCSComponentFactory;
import com.ai.paas.ipaas.ccs.inner.ICCSComponent;
import com.ai.paas.ipaas.ccs.inner.constants.ConfigPathMode;
import com.ai.paas.ipaas.dss.DSSFactory;
import com.ai.paas.ipaas.dss.interfaces.IDSSClient;

@Controller
@RequestMapping(value = "/ServiceCheck")
public class ServiceCheck {

    private static Map<String, Object> result = new HashMap<String, Object>();
    private static String authServiceUrl = SystemConfigHandler.configMap.get("iPaas-Auth.SERVICE.IP_PORT_SERVICE");
    private static String authSdkUrl = SystemConfigHandler.configMap.get("AUTH.SDKUrl.1");
	private static String AUTHURL = authServiceUrl + authSdkUrl;
	
	@RequestMapping(value = "/toCheckCcsService")
	@ResponseBody
	public  Map<String, Object> toCheckCcsService(HttpServletRequest req,HttpServletResponse resp) {
		result.clear();
		String pid = req.getParameter("pid"); 
		String serviceId = req.getParameter("serviceId");
		String servicePwd = req.getParameter("servicePwd");
		System.out.println("pid: "+pid);
		System.out.println("serviceId: "+serviceId);
		System.out.println("servicePwd: "+servicePwd);
		testCCSIN();
		testCCS(pid,serviceId,servicePwd);
		return result; 		
		
	}
	private static  Map<String, Object> testCCSIN() {
		try {
			String ccs = SystemConfigHandler.configMap.get("CCS_INNER.PARAM.1");
			if(StringUtil.isBlank(ccs)) {
				System.out.println("CCS IN Not configed, skipped!");
				result.put("innerCode", "000000");
				result.put("innerMsg", "CCS IN Not configed, skipped!");
			}
			ICCSComponent iCCSComponent = CCSComponentFactory.getConfigClient(ccs.split(",")[0], ccs.split(",")[1], ccs.split(",")[2]);
			if(!iCCSComponent.exists("/abc",ConfigPathMode.WRITABLE)){
				iCCSComponent.add("/abc", "ok".getBytes());
			}
			result.put("innerCode", "111111");
			System.out.println(iCCSComponent.get("/abc",ConfigPathMode.WRITABLE));
			result.put("innerMsg", iCCSComponent.get("/abc",ConfigPathMode.WRITABLE));
		} catch (Exception e) {
			result.put("innerCode", "000000");
			e.printStackTrace();
		}
		return result;
	}
	private static Map<String, Object> testCCS(String pid, String serviceId, String servicePwd) {
		try {
			AuthDescriptor ad = new AuthDescriptor(AUTHURL, pid, servicePwd, serviceId);
			IConfigClient iConfigClient = ConfigFactory.getConfigClient(ad);
			if(!iConfigClient.exists("/abc")) {
				iConfigClient.add("/abc", "ok".getBytes());
			}
			System.out.println(iConfigClient.get("/abc"));
			result.put("ccsCode", "111111");
			result.put("ccsMsg", iConfigClient.get("/abc"));
		} catch (Exception e) {
			result.put("ccsCode", "000000");
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "/toCheckMcsService")
	@ResponseBody
	public Map<String, Object> toCheckMcsService(HttpServletRequest req,HttpServletResponse resp) {
		result.clear();
		String pid = req.getParameter("pid"); 
		String serviceId = req.getParameter("serviceId");
		String servicePwd = req.getParameter("servicePwd");
		
		testMCS(pid,serviceId,servicePwd);
		return result; 		
	}
	
	private static Map<String, Object> testMCS(String pid, String serviceId, String servicePwd) {
		try {
			AuthDescriptor ad = new AuthDescriptor(AUTHURL, pid, servicePwd, serviceId);
			ICacheClient iCacheClient = CacheFactory.getClient(ad);
			iCacheClient.set("hello", "ok");
			System.out.println(iCacheClient.get("hello"));
			result.put("mcsCode", "111111");
			result.put("mcsMsg", iCacheClient.get("hello"));
		} catch (Exception e) {
			result.put("mcsCode", "000000");
			e.printStackTrace();
		}
		return result;
	}
	
	@RequestMapping(value = "/toCheckDssService")
	@ResponseBody
	public Map<String, Object> toCheckDssService(HttpServletRequest req,HttpServletResponse resp) {
		result.clear();
		String pid = req.getParameter("pid"); 
		String serviceId = req.getParameter("serviceId");
		String servicePwd = req.getParameter("servicePwd");
		
		testDSS(pid,serviceId,servicePwd);
		return result; 		
	}
	private static Map<String, Object> testDSS(String pid, String serviceId, String servicePwd) {
		try {
			AuthDescriptor ad = new AuthDescriptor(AUTHURL, pid, servicePwd,serviceId);
			IDSSClient iDSSClient = DSSFactory.getClient(ad);
			String id = iDSSClient.save("ok".getBytes(), "test");
			System.out.println("id:"+id);
			System.out.println(iDSSClient.read(id));
			System.out.println(new String(iDSSClient.read(id)));
			result.put("dssCode", "111111");
			result.put("dssMsg", new String(iDSSClient.read(id)));
		} catch (Exception e) {
			result.put("dssCode", "000000");
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		return result;
	}
	
	
	//TODO {"abc":{"type":"string"}} 测试前提创建模型
	@RequestMapping(value = "/toCheckSesService")
	@ResponseBody
	public static Map<String, Object> toCheckSesService(HttpServletRequest req,HttpServletResponse resp) {
		result.clear();
		String pid = req.getParameter("pid"); 
		String serviceId = req.getParameter("serviceId");
		String servicePwd = req.getParameter("servicePwd");
		
		testSES(pid,serviceId,servicePwd);
		return result; 		
	}
	
	private static Map<String, Object> testSES(String pid, String serviceId, String servicePwd) {
		try {
			
			AuthDescriptor ad = new AuthDescriptor(AUTHURL, pid, servicePwd, serviceId);			
		
			ISearchClient iSearchClient = null;
				iSearchClient = SearchClientFactory.getSearchClient(ad);
			iSearchClient.insertData("{\"abc\":\"test\"}");
//			System.out.println(iSearchClient.);
			System.out.println("testSES ok");
			result.put("sesCode", "111111");
			result.put("sesMsg", "testSES ok");
			} catch (Exception e) {
				result.put("sesCode", "000000");
		        e.printStackTrace();		      
		}
		return result;
	}
	
	@RequestMapping(value = "/toCheckIdpsService")
	@ResponseBody
	public Map<String, Object> toCheckIdpsService(HttpServletRequest req,HttpServletResponse resp) {
		result.clear();
		String pid = req.getParameter("pid"); 
		String serviceId = req.getParameter("serviceId");
		String servicePwd = req.getParameter("servicePwd");
		
		testIDPS(pid,serviceId,servicePwd);
		return result; 		
	}
	
	private static Map<String, Object> testIDPS(String pid, String serviceId, String servicePwd){
		try{
			AuthDescriptor ad = new AuthDescriptor(AUTHURL, pid, servicePwd, serviceId);
			IImageClient im = ImageClientFactory.getSearchClient(ad);
			Class<ServiceCheck> config_class = ServiceCheck.class;
			@SuppressWarnings("resource")
			InputStream inStream = new FileInputStream(new File(config_class.getResource("/config/test.jpg").toURI()));
			byte[] buff= new byte[100];
			ByteArrayOutputStream swapStream = new ByteArrayOutputStream();
			int rc = 0;  
	        while ((rc = inStream.read(buff, 0, 100)) > 0) {  
	            swapStream.write(buff, 0, rc);  
	        }  
			String imageId = im.upLoadImage(swapStream.toByteArray(), ".jpg");
			result.put("idpsMsg", im.getImageUrl(imageId, ".jpg"));
			result.put("idpsCode", "111111");
		}catch (Exception e){
			result.put("idpsCode", "000000");
			e.printStackTrace();
		}
		return result; 
	}
	
	@RequestMapping(value = "/toCheckMdsService")
	@ResponseBody
	public Map<String, Object> toCheckMdsService(HttpServletRequest req,HttpServletResponse resp) {
		result.clear();
		String pid = req.getParameter("pid"); 
		String serviceId = req.getParameter("serviceId");
		String servicePwd = req.getParameter("servicePwd");
		String topicId = req.getParameter("topicId");
		
		testMDS(pid,serviceId,servicePwd,topicId);
		return result; 		
	}
	//TODO MDS服务的参数？
	private static Map<String, Object> testMDS(String pid, String serviceId, String servicePwd, String topicId) {
		AuthDescriptor ad = new AuthDescriptor(AUTHURL, pid, servicePwd, serviceId);
		IMessageSender msgSender = null;
		System.out.println("MDS SENDER BEGIN ++++++++++++++++" +serviceId+" & "+topicId);
		try {
			msgSender = MsgSenderFactory.getClient(ad, topicId);
		} catch (Exception e) {
			result.put("mdsCode", "000000");
			System.out.println("MDS COMSUMER ERROR !");
			e.printStackTrace();
		}
		msgSender
		.send("adsajddddddddddsadsadsa"
				+ "dddddddddddddddddddasdsadsadsadd"
				+ "ddddddddddddddddddddddddasdsadsadsadsdasdsadddddddddddddddddddddasdsadsadsadsd"
				+ "dfgfdgggggdgfdgdfgfdgfdgfdgfdgfdgfdgdddddddddddddddddddddasdsadsadsadsd"
				+ "dfsdfdsferytertertretrretretedddddddddddddddddddddasdsadsadsadsd"
				+ "fsdfdsfdsfdsfsdfsdfsfsdfsdfsddddddddddddddddddddddasdsadsadsadsd"
				+ "fdsfsdfsfdsfdsfsdfdsfsdfsdfsddddddddddddddddddddddasdsadsadsadsd"
				+ "fdsfsfsdfdsfsdtryrtyryryrtyrytrdddddddddddddddddddddasdsadsadsadsd"
				+ "retetertretretretetretretertertedddddddddddddddddddddasdsadsadsadsd"
				+ "retertertetretertrefdgdgdfgdddddddddddddddddddddasdsadsadsadsd"
				+ "dgdfgggggggggggggggggggggfdgdfgdfdddddddddddddddddddddasdsadsadsadsd"
				+ "gdfggggggggggggggggggggggggggggfhdddddddddddddddddddddasdsadsadsadsd"
				+ "hgwllllllllllllllllllllllllldddddddddddddddddddddasdsadsadsadsd"
				+ "asdddddddddddddddddddddddddddddddddddddddddasdsadsadsadsd"
				+ "kkkkkkkkkkkkkkkkkkkkkdsa", 0);
		msgSender.send("Byte message01".getBytes(), 1);
		msgSender.send("Byte message02".getBytes(), 2);
		msgSender.send("Byte message03".getBytes(), 3);
		msgSender.send("Byte message04".getBytes(), 4);
		msgSender.send("Byte message05".getBytes(), 5);
		msgSender.send("Byte message06".getBytes(), 6);
		msgSender.send("Byte message07".getBytes(), 7);
		msgSender.send("Byte message08".getBytes(), 8);
		msgSender.send("Byte message09".getBytes(), 9);
		System.out.println("MDS SENDER SUCCESS");
		result.put("mdsCode", "111111");
		result.put("mdsSenderMsg", "MDS SENDER SUCCESS !");
		System.out.println("MDS COMSUMER TEST BEGIN");
		IMsgProcessorHandler msgProcessorHandler = new MsgProcessorHandlerImpl();
		IMessageConsumer msgConsumer = null;
		msgConsumer = MsgConsumerFactory.getClient(ad, topicId, msgProcessorHandler);
		msgConsumer.start();
		int i=0;
		while (i<1) {
			try {
				Thread.sleep(10000);
				i++;
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		msgConsumer.stop();
		System.out.println("MDS COMSUMER TEST SUCCESS");
		result.put("mdsConsumerMsg", "MDS CONSUMER TEST SUCCESS !");
		
		return result;
}
	
	@RequestMapping(value = "/toCheckAtsService")
	@ResponseBody
	public Map<String, Object> toCheckAtsService(HttpServletRequest req,HttpServletResponse resp) {
		result.clear();
		String pid = req.getParameter("pid"); 
		String serviceId = req.getParameter("serviceId");
		String servicePwd = req.getParameter("servicePwd");
		String signatureId = req.getParameter("signatureId");
		
		testATS(pid,serviceId,servicePwd,signatureId);
		return result; 		
	}
	//TODO ATSPARAM=pid,serviceId,servicepwd,TXS001,TXSServicePwd,topic
	private static Map<String, Object> testATS(String pid, String serviceId, String servicepwd, String signatureId) {
		//MessageCustomerTest
		try {
			Thread mcust = new Thread(new MessageCustomerTask());
			mcust.start();
			MessageTest mt = new MessageTest();
			System.out.println("testATS--send message！");
			mt.testSendMessage(signatureId);
			result.put("atsCode", "111111");
			result.put("atsMsg", "ATS SUCCESS!");
		} catch (Exception e) {
			result.put("atsCode", "000000");
			result.put("atsMsg", "ATS ERROR!");
			e.printStackTrace();
		}
		return result;
	}
		
}
