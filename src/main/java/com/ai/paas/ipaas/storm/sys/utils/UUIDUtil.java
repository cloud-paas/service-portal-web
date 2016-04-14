package com.ai.paas.ipaas.storm.sys.utils;

import java.util.UUID;

public class UUIDUtil {
	/**
	 * 返回32位的UUID
	 */
	public static String randomUUID() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}
