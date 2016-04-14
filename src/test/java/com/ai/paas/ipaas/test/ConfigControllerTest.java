package com.ai.paas.ipaas.test;

import net.sf.json.JSONObject;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.google.gson.Gson;

public class ConfigControllerTest extends BaseTestController {
	private static final Logger log = LogManager
			.getLogger(ConfigControllerTest.class.getName());

	protected static final Gson gson = new Gson();

	
	
	public static void main(String s[]){
		
		String ss = " {\"recordJson\":{ \"_id\" : { \"$oid\" : \"556fef291fda9a26083aeabf\"} , \"chunkSize\" : 261120 , \"length\" : 4295 , \"md5\" : \"71a027da36c2f9f4c17d953478021226\" , \"filename\" : \"黑猫.jpg\" , \"contentType\" : \"jpg\" , \"uploadDate\" : { \"$date\" : \"2015-06-04T06:24:41.452Z\"} , \"aliases\" :  null  , \"metadata\" : { \"remark\" : \"\"}},\"userId\":\"82AF9FF99F164CB196D06C41EF1A2884\",\"applyType\":\"getRecord\",\"serviceId\":\"DSS071\",\"resultCode\":\"000000\",\"resultMsg\":\"Apply DSS successful!\"}";
		JSONObject obj = new JSONObject().fromObject(ss);
		
		System.out.println(obj.toString());
	}

}
