package com.ai.paas.ipaas.inputOpen;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value="/input")
public class inputOpenController {
	
//	@RequestMapping(value="/openInit")
//	public String openInit(HttpServletRequest request,HttpServletResponse response)
//	{
//		Map<String,String> initParam=new HashMap<String, String>();
//		String belongCloud=request.getParameter("belongCloud");
//		String system=request.getParameter("SysTem");
// 		List<CodeValueObject> usernamelist=new ArrayList<CodeValueObject>();
//		usernamelist=CacheUtils.getCodeValueListByKey("InputOpen.userName");
// 		CodeValueObject password=CacheUtils.getCodeValueByKey("InputOpen.initParam");
//		
//		initParam.put("orderDetailId", request.getParameter("DetailId"));
//		initParam.put("orderWoId", request.getParameter("WoId"));
//		initParam.put("operateId", request.getParameter("operate_id"));
//		initParam.put("belongCloud",belongCloud );
//		for(int i=0;i<usernamelist.size();i++){
//			if(usernamelist.get(i).getCode().equals(system)){
//				initParam.put("username",usernamelist.get(i).getValue());
//			}
//		}
//		initParam.put("password", password.getValue());
//		initParam.put("vmNumber", request.getParameter("Vmnumber"));
//		initParam.put("netBand", request.getParameter("NetBand")); 
//	    request.setAttribute("inputparam", initParam);
//	    
//		initParam.put("kkpage", request.getParameter("kkpage"));
//		return "/inputOpen/inputOpen";
//		
//	}
//	@RequestMapping(value="/inputOpen",method={RequestMethod.POST})
//	public @ResponseBody String inputOpen(HttpServletRequest request,HttpServletResponse response) throws IOException, URISyntaxException
//	{
//		UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
//		Map<String, String> params=new HashMap<String, String>();
//		Map<String, Object> openParam=new HashMap<String, Object>();
//		ArrayList<String> iplist=new ArrayList<String>();
//		String  ip=request.getParameter("ip_net");
//		String iparray[]=ip.split(",");
//		for(int i=0;i<iparray.length;i++){
//			iplist.add(iparray[i]);
//		}
//		
//		openParam.put("username", request.getParameter("username"));
//		openParam.put("password", request.getParameter("password"));
//		openParam.put("ip",iplist);
//		params.put("email", userInfoVo.getUserEmailTmp());
//		params.put("orderDetailId", request.getParameter("orderDeatilId"));
//		params.put("orderWoId",request.getParameter("orderWoId"));
//		params.put("openParam", JSonUtil.toJSon(openParam));
//		
//		
//		String data=JSonUtil.toJSon(params);
//		String service =CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");
//		String result=HttpClientUtil.sendPostRequest(service+"/user/iOrderApi/saveIaasOpenParam", data);
//		//String result=HttpClientUtil.sendPostRequest("http://127.0.0.1:20881/ipaas/user/iOrderApi/saveIaasOpenParam", data);
//		
//		return result; 
//	}
}
