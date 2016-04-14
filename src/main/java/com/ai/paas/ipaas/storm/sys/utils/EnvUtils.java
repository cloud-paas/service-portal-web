package com.ai.paas.ipaas.storm.sys.utils;

public class EnvUtils {
	public static String getEnv(String envKey){
		return System.getenv(envKey);
	}
	public static String $HOME(){
		return getEnv("HOME");
	} 
	public static void main(String[] args) {
		System.out.println(getEnv("HOME"));
	}
}
