package com.ai.paas.ipaas.checkservice.transaction.dtm.local.message;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.ai.paas.ipaas.checkservice.Util.ConfUtil;

import com.ai.paas.ipaas.checkservice.ats.producer.TransactionMessageProducer;
import com.ai.paas.ipaas.checkservice.ats.producer.TransactionMsgProducerFactory;
import com.ai.paas.ipaas.checkservice.sample.configImpl.PaaSTransactionUserAuth;
import com.ai.paas.ipaas.txs.common.protocol.TransactionMessage;
import com.ai.paas.ipaas.txs.dtm.DistributedTransactionController;

public class MessageTest {
	private static Logger logger = LogManager.getLogger(MessageTest.class);
	

	static {
//		context = new ClassPathXmlApplicationContext(
//				new String[] { "/context/applicationContext.xml" });
		PaaSTransactionUserAuth auth = new PaaSTransactionUserAuth();
		auth.init();
	}

	public void testSendMessage(String signatureId) {
		// IDBService2 service = context.getBean(IDBService2.class);
		// service.saveAndDeleteDBInfo();
		
		try {
			DistributedTransactionController.begin();

			// send
			TransactionMessageProducer sender = TransactionMsgProducerFactory
					.getClient();
			TransactionMessage message = new TransactionMessage(signatureId,
					"com.ai.paas.ipaas.checkservice.transaction.dtm.local.message.IDoMessage",
					"doThing", "b2");
			sender.sendMessage(message);

			DistributedTransactionController.commit();
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
			DistributedTransactionController.rollback();
			throw e;
		} finally {
			DistributedTransactionController.clear();
		}
	}
}
