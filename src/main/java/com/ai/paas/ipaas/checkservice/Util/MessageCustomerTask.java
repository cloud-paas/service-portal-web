package com.ai.paas.ipaas.checkservice.Util;

import com.ai.paas.ipaas.checkservice.transaction.dtm.local.message.MessageCustomerTest;

public class MessageCustomerTask implements Runnable {
    private String signatureId;
	@Override
	public void run() {
		new MessageCustomerTest().testMessage(this.signatureId);
	}

}
