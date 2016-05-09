package com.ai.paas.ipaas.checkservice.transaction.dtm.local.message;

import org.springframework.stereotype.Component;

import com.ai.paas.ipaas.checkservice.Util.ConfUtil;

import com.ai.paas.ipaas.checkservice.ats.consumer.ServiceProviderSignature;

@Component
public class DoMessageSample implements IDoMessage{
	//private String topic = ConfUtil.getProperty("ATSPARAM").split(",")[5];
	
	@ServiceProviderSignature(idFromAttribute="topic")
	@Override
	public void doThing(String arg1) {
		System.out.println("DoMessageSample-------"+arg1);
		if(arg1!=null)
			System.out.println("-----ATS  OK----");

//		throw new RuntimeException("adfa");
	}

	
}
