package com.ai.paas.ipaas.maintain.controller;

import com.ai.paas.ipaas.maintain.constants.CCSComponentOperationParam;
import com.ai.paas.ipaas.maintain.constants.CcsResourcePool;
import com.ai.paas.ipaas.maintain.constants.PathType;
import com.ai.paas.ipaas.maintain.model.UserIdModel;
import com.ai.paas.ipaas.maintain.model.UserModel;
import com.ai.paas.ipaas.maintain.util.ConfigUtil;
import com.ai.paas.ipaas.maintain.util.HttpClientUtil;
import com.ai.paas.ipaas.maintain.util.HttpRequestUtil;
import com.ai.paas.ipaas.maintain.util.HttpResponseUtil;
import com.ai.paas.ipaas.util.StringUtil;
import com.google.gson.Gson;

import org.apache.http.entity.ContentType;
import org.apache.http.entity.StringEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URISyntaxException;

@Controller
@RequestMapping("/config/zk")
public class ManagerZK {
	
    private final String url = ConfigUtil.getProperty("ipaas.rest.url");
    
    
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
        	 String result = HttpClientUtil.sendPostRequest(url + "/ccs-component/maintain/insertZK", new Gson().toJson(param));
             HttpResponseUtil.sendResponse(result, response);
         }catch(Exception e){
        	 e.printStackTrace();
         }
    }  
    
    @RequestMapping("/initUser")
    public void initUser(HttpServletRequest request, HttpServletResponse response,@RequestBody UserIdModel param) throws IOException {
//    	String userInfo = ""; 
    	try{
//    		userInfo =  HttpRequestUtil.sendPost(
//    				ConfigUtil.getProperty("ipaas.user.getUserID.rest.url"),
// 					"userName="+param.getUserName());
//         	 System.out.println("***********************"+userInfo);
//             Gson gson = new Gson();
//             UserIdModel userIdModel = gson.fromJson(userInfo, UserIdModel.class);
//             if(StringUtil.isBlank(userIdModel.getUserId())){
//            	 HttpResponseUtil.sendResponse("{\"resultCode\":\"999999\",\"resultMessage\":\"用户节点不存在\"}", response);
//            	 return;
//             }
//             param.setUserName(userIdModel.getUserId());
        	 String result = HttpClientUtil.sendPostRequest(url + "/ccs/manage/init", new Gson().toJson(param));
             HttpResponseUtil.sendResponse(result, response);
         }catch(Exception e){
        	 HttpResponseUtil.sendResponse("{\"resultCode\":\"999999\",\"resultMessage\":\"用户不存在\"}", response);
        	 //e.printStackTrace();
         }
    } 
}
