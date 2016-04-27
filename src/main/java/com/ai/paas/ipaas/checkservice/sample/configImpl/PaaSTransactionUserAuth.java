package com.ai.paas.ipaas.checkservice.sample.configImpl;

import com.ai.paas.ipaas.checkservice.Util.ConfUtil;
import com.ai.paas.ipaas.txs.dtm.config.AbstractPaaSTransactionUserAuth;
import com.ai.paas.ipaas.txs.dtm.config.AuthLoader;
import com.ai.paas.ipaas.uac.service.UserClientFactory;
import com.ai.paas.ipaas.uac.vo.AuthDescriptor;
import com.ai.paas.ipaas.uac.vo.AuthResult;

/**
 * 示例权限配置的实现类
 * 
 * @Title: PaaSTransactionUserAuth.java
 * @author wusheng
 * @date 2015年3月26日 下午2:14:18
 *
 */
public class PaaSTransactionUserAuth extends AbstractPaaSTransactionUserAuth {
	private String serviceId;
	private String pid;
	private String servicePwd;
	
	public void init() {
		AuthLoader.init(this);
	}
	public String getServiceId(String serviceId) {
		return this.serviceId = serviceId;
	}

	public String getAuthAddr() {
		return ConfUtil.getProperty("AUTHURL");
	}

	public String getPid(String pid) {
		return this.pid = pid;
	}

	public String getPassword(String servicePwd) {
		return this.servicePwd = servicePwd;
	}
	/**
	 * 获取用户鉴权信息
	 * @return
	 */
	public AuthDescriptor getAuth(String pid,String servicePwd,String serviceId){
		AuthDescriptor auth = new AuthDescriptor();
		auth.setAuthAdress(this.getAuthAddr());
		auth.setPid(pid);
		auth.setPassword(servicePwd);
		auth.setServiceId(serviceId);
		return auth;
	}
	
	public static void main(String[] args) {
		AuthDescriptor auth = new AuthDescriptor(
				ConfUtil.getProperty("AUTHURL"),
				"sunhs3@asiainfo.com", "wfATSService", "TXS001");
		AuthResult authResult = UserClientFactory.getUserClient()
				.auth(auth);
		System.out.println(authResult.getUserName());
	}
	@Override
	public String getPassword() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public String getPid() {
		// TODO Auto-generated method stub
		return null;
	}
	@Override
	public String getServiceId() {
		// TODO Auto-generated method stub
		return null;
	}
}
