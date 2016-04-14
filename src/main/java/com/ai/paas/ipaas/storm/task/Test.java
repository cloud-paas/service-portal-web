//package com.ai.paas.ipaas.storm.task;
//
//import java.io.File;
//import java.lang.reflect.Method;
//import java.net.URL;
//import java.net.URLClassLoader;
//
//public class Test {
//	@SuppressWarnings("unchecked")
//	public static void main(String[] args) {
//		try {
//			File xFile = new File("C:/Users/ASUS/Desktop/WordCounter.jar");
//			URL xUrl = xFile.toURL();
//			URLClassLoader ClassLoader = new URLClassLoader(new URL[] { xUrl });
//			Class<?> xClass = ClassLoader.loadClass("TopologyMain");
//			Object xObject = xClass.newInstance();
//			Method xMethod = xClass.getDeclaredMethod("test");
//			System.out.println(Integer.parseInt(String.valueOf(xMethod.invoke(xObject,null))));
//            System.out.println(xMethod.getGenericReturnType());
//		    System.out.println(xObject);
//		    ClassLoader.close();
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
//}
