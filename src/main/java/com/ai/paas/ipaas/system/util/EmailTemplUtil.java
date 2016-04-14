package com.ai.paas.ipaas.system.util;


import java.util.HashMap;
import java.util.Map;

import org.apache.velocity.app.VelocityEngine;
import org.springframework.ui.velocity.VelocityEngineUtils;

/**
 * User: jianhua.ma
 * Date: 2015-06-08
 * 描述 : 邮件模板
 */
public class EmailTemplUtil {

    private static Map<String, Object> proMap = null;
    private static VelocityEngine velocityEngine = null;

    static {
        proMap = new HashMap<String, Object>();
        proMap.put("resource.loader", "class");
        proMap.put("class.resource.loader.class", "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader");

    }
    public static VelocityEngine getVelocityEngineInstance() {
        if (null == velocityEngine) {
            synchronized (VelocityEngine.class) {
                if (null == velocityEngine) {
                    velocityEngine = new VelocityEngine();
                    for (Map.Entry<String, Object> entry : proMap.entrySet()) {
                        velocityEngine.setProperty(entry.getKey(), entry.getValue());
                    }
                }
            }
        }
        return velocityEngine;
    }
    public static void main(String[] args) {
    	Map<String,Object> model = new HashMap<String,Object>();  
        model.put("msgContent", "我靠 出大事儿了！");  
    	 String text = VelocityEngineUtils.mergeTemplateIntoString(
    			 EmailTemplUtil.getVelocityEngineInstance(), "mail.vm", "UTF-8", model);
    	 System.out.println(text);
	}

}
