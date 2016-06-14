package com.ai.paas.ipaas.maintain.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ai.paas.ipaas.maintain.constants.CcsResourcePool;
import com.ai.paas.ipaas.maintain.model.UserIdModel;
import com.ai.paas.ipaas.maintain.util.ConfigUtil;
import com.ai.paas.ipaas.maintain.util.HttpClientUtil;
import com.ai.paas.ipaas.maintain.util.HttpResponseUtil;
import com.ai.paas.ipaas.zookeeper.SystemConfigHandler;
import com.google.gson.Gson;

@Controller
@RequestMapping("/config/zk")
public class ManagerZK {
	
//    private final String url = ConfigUtil.getProperty("ipaas.rest.url");
    
    public void initUser(){
    }
    
    @RequestMapping("/main")
    public ModelAndView main(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("manazoo/index");
        return mav;
    }
    
    @RequestMapping("/goInitUser")
    public ModelAndView goInitUser(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("manazoo/initUser");
        return mav;
    }

    @RequestMapping("/insert")
    public void insert(HttpServletRequest request, HttpServletResponse response,@RequestBody CcsResourcePool param) {
         try{
             String url = SystemConfigHandler.configMap.get("PASS.SERVICE.IP_PORT_SERVICE");
        	 String result = HttpClientUtil.sendPostRequest(url + "/ccs-component/maintain/insertZK", new Gson().toJson(param));
             HttpResponseUtil.sendResponse(result, response);
         }catch(Exception e){
        	 e.printStackTrace();
         }
    }  
    
	@RequestMapping("/initUser")
	public void initUser(HttpServletRequest request, HttpServletResponse response, @RequestBody UserIdModel param) throws IOException {
		try {
			String url = SystemConfigHandler.configMap.get("PASS.SERVICE.IP_PORT_SERVICE");
			String result = HttpClientUtil.sendPostRequest(url + "/ccs/manage/init", new Gson().toJson(param));
			HttpResponseUtil.sendResponse(result, response);
		} catch (Exception e) {
			HttpResponseUtil.sendResponse("{\"resultCode\":\"999999\",\"resultMessage\":\"用户不存在\"}", response);
		}
	}
}
