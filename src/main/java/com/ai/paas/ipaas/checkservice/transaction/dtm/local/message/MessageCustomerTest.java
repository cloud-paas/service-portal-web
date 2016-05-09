package com.ai.paas.ipaas.checkservice.transaction.dtm.local.message;

//import org.springframework.context.ApplicationContext;
//import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.ai.paas.ipaas.checkservice.ats.consumer.TransactionMsgCustomerFactory;
import com.ai.paas.ipaas.checkservice.sample.configImpl.PaaSTransactionUserAuth;

public class MessageCustomerTest {
	//private static ApplicationContext context = null;

	static {
//		context = new ClassPathXmlApplicationContext(new String[] {
//				"/context/applicationContext.xml"});
		PaaSTransactionUserAuth auth = new PaaSTransactionUserAuth();
		auth.init();
	}
	
	public void testMessage(String signatureId){
		TransactionMsgCustomerFactory.register(IDoMessage.class, new DoMessageSample());
		TransactionMsgCustomerFactory.start(signatureId);
		
		while(true){
			try {
				Thread.sleep(10000000L);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}
