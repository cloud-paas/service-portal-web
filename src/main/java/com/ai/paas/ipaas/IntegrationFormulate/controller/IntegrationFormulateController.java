package com.ai.paas.ipaas.IntegrationFormulate.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.cache.CacheUtils;
import com.ai.paas.ipaas.cache.CodeValueObject;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.vo.UserInfoVo;

@Controller
@RequestMapping(value="/IntegrationFormulate")
public class IntegrationFormulateController {
	
//	@RequestMapping(value="/InFormulateSubmit",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
//	public @ResponseBody String InFormulateSubmit(HttpServletRequest request,HttpServletResponse response) throws IOException, URISyntaxException, PaasException
//	{
//
//		String orderDetailId = request.getParameter("orderDetailId");
//		String orderWoId = request.getParameter("orderWoId");
//		String belongCloud = request.getParameter("belongCloud");
//		
//		String virtualCpu = request.getParameter("virtualCpu");//4核
//		String virtualType = request.getParameter("virtualType");
//		String virtualRam =  request.getParameter("virtualRam");//4G
//		String virtualHard =  request.getParameter("virtualHard"); //73
//		String SysTem =  request.getParameter("SysTem");
//		String SysTemChild = request.getParameter("SysTemChild");
//		String vmNumber = request.getParameter("vmNumber");
//		String storageSoft = request.getParameter("storageSoft");
//		String environmentSoft = request.getParameter("environmentSoft");
//		
//		
//		UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
//		String schemeMaker = userInfoVo.getUserEmailTmp();
//		
//		JSONObject objEn=new JSONObject();
//		objEn.put("cpu",virtualCpu);
//		objEn.put("virtualType",virtualType);
//		objEn.put("virtualRam",virtualRam);
//		objEn.put("virtualHard",virtualHard);
//		objEn.put("SysTem",SysTem);
//		objEn.put("SysTemChild", SysTemChild);
//		objEn.put("vmNumber", vmNumber);
//		objEn.put("environmentSoft", environmentSoft);
//		objEn.put("storageSoft", storageSoft);
//		
//		JSONObject objZh=new JSONObject();
//		objZh.put("处理器",virtualCpu);
//		objZh.put("虚拟机类型",virtualType);
//		objZh.put("内存",virtualRam );
//		objZh.put("数据盘",virtualHard);
//		objZh.put("操作系统",SysTem);
//		objZh.put("操作系统版本",SysTemChild);
//		objZh.put("虚拟机数量",vmNumber);
//		objZh.put("运行环境软件", environmentSoft);
//		objZh.put("存储软件", storageSoft);
//	
//		if(belongCloud!=null 
//				&& !"".equals(belongCloud) 
//				&& "2".equals(belongCloud)){	//归属平台	  1研发云   2租用云
//
//		objEn.put("netType",request.getParameter("netType") );
//		objEn.put("netBandW",request.getParameter("netBandW") );
//		objEn.put("netNum",request.getParameter("netNum") );
//		
//		objZh.put("链路类型",request.getParameter("netType") );
//		objZh.put("公网宽带",request.getParameter("netBandW") );
//		objZh.put("公网数量",request.getParameter("netNum") );
//		
//		}
//		
//		
//		Map<String ,String> map = new HashMap<String ,String>();		
//		
//		map.put("orderDetailId", orderDetailId);  //订单id**************************************************
//		map.put("orderWoId", orderWoId); //工单id**************************************************
//		map.put("prodParamZh", objZh.toString()); //中文产品参数
//		map.put("prodParam", objEn.toString()); //英文产品参数
//		map.put("schemeMaker", schemeMaker);  //当前登录人邮箱	
//		 JSONObject jsonww = new JSONObject(map);
//		 String param = jsonww.toString();
//		 System.out.println(param);
//		String result = null;
//
//		String service =CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");	
//		//String service = "http://127.0.0.1:20881/ipaas";
//		String url = "/user/iOrderApi/saveIaasIntegratedScheme";
//		System.out.println("to MAIN rest:" + service + url);
//		try {
//			result = HttpClientUtil.sendPostRequest(service + url, param);
//			System.out.println("MAIN return :" + result);
//		} catch (IOException e) {
//			e.printStackTrace();
//		} catch (URISyntaxException e) {
//			e.printStackTrace();
//		}		
//		
//		return result;
//		
//	}
//	
//	@RequestMapping(value="/SoftLoading",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
//	public @ResponseBody String vmSoftLoading(HttpServletRequest request,HttpServletResponse response){
//		
//		String SystemCode = request.getParameter("SystemCode");
//		String belongCloud = request.getParameter("belongCloud");
//		List<CodeValueObject> list1 = null;
//		List<CodeValueObject> list2 = null;
//
//		if("2".equals(belongCloud)){ //租用云
//			 list1 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_Save_Soft");
//			 list2 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_Run_Soft");
//		}
//		if("1".equals(belongCloud)){ //研发云
//			 list1 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.YF_Save_Soft");
//			 list2 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.YF_Run_Soft");
//		}
//
//		
//		 JSONObject obj=new JSONObject();
//			if( list1!=null && list2!=null ){
//				obj.put("code","0000" );
//			}else{
//				obj.put("code","9999" );
//			}
//
//		  String Save_Soft="";
//		  for(int i=0; i<list1.size();i++){
//		     if(list1.get(i).getCode().equals(SystemCode)){
//		    	 CodeValueObject temp1 = list1.get(i);
//		    	 Save_Soft+=temp1.getValue();
//		     }
//		  }
//		  
//		  String Run_Soft="";
//		  for(int i=0; i<list2.size();i++){
//		     if(list2.get(i).getCode().equals(SystemCode)){
//		    	 CodeValueObject temp1 = list2.get(i);
//		    	 Run_Soft+=temp1.getValue();
//		     }
//		  }
//
//		 obj.put("Save_Soft",Save_Soft );
//		 obj.put("Run_Soft",Run_Soft );
//
//		return obj.toString();
//	}

}
