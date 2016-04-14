package com.ai.paas.ipaas.virtual.controller;

import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.cache.CacheUtils;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.utils.DateUtils;
 
@Controller
@RequestMapping(value="/virtualMachineModify")
public class VirctualMachineModifyController {
	@RequestMapping(value="/initModify")
	public String initModify(HttpServletRequest request,HttpServletResponse response)
	{
		String orderDetailId=request.getParameter("orderDetailId");
		request.setAttribute("orderDetailId", orderDetailId);
		return "virtualMachine/virtualMachineModify";
		
	}
	
	/*@RequestMapping(value="/modifyCompleted")
	public  String modifyCompleted(ModelMap model,HttpServletRequest request,HttpServletResponse response){
		Date date = new Date () ;   
		SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy年 MM月 dd号" );   
		String   dateStr = dateFormat.format(new Date( date.getTime() + 6 * 24 * 60 * 60 * 1000));
		model.addAttribute("dateStr", dateStr);
		
		return "/virtualMachine/virtualModifySuccess";
		
	}*/
	
	@RequestMapping(value="/Cloudmodify",method={RequestMethod.POST},produces="application/json;charset=utf-8")
	public @ResponseBody String cloudModify(HttpServletRequest request,HttpServletResponse response) throws IOException, URISyntaxException{
		Map  params=new HashMap<String,String>();
		JSONObject objEn=new JSONObject();
		JSONObject objZh=new JSONObject();
		JSONObject objresult=new JSONObject();
		
		String NtName = "";
		UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
		if(userInfoVo.getPartnerAccount()!=null || !"".equals(userInfoVo.getPartnerAccount())){
			NtName = userInfoVo.getPartnerAccount(); 
		}else{
			NtName = userInfoVo.getUserEmail().split("@")[0];   //nt账号		"mapl"	
		}
		
		
		
		//String cloudid=request.getParameter("belongCloud");
		objEn.put("cpu",request.getParameter("virtualCpu") );
		objEn.put("virtualType",request.getParameter("virtualType") );
		objEn.put("virtualRam",request.getParameter("virtualRam") );
		objEn.put("virtualHard",request.getParameter("virtualHard") );
		objEn.put("SysTem",request.getParameter("SysTem") );
		objEn.put("SysTemChild",request.getParameter("SysTemChild") );
		objEn.put("SysOtherTem",request.getParameter("SysOtherTem") );
		objEn.put("storageSoft",request.getParameter("storageSoft") );
		objEn.put("environmentSoft",request.getParameter("environmentSoft") );
		
		
		objZh.put("处理器",request.getParameter("virtualCpu") );
		objZh.put("虚拟机类型",request.getParameter("virtualType") );
		objZh.put("内存",request.getParameter("virtualRam") );
		objZh.put("数据盘",request.getParameter("virtualHard") );
		objZh.put("操作系统",request.getParameter("SysTem") );
		objZh.put("操作系统版本",request.getParameter("SysTemChild") );
		objZh.put("其他操作系统",request.getParameter("SysOtherTem") );
		objZh.put("存储软件",request.getParameter("storageSoft") );
		objZh.put("运行环境软件",request.getParameter("environmentSoft") );
		
		if(request.getParameter("belongCloud").equals("2"))
		{
			objEn.put("netType",request.getParameter("netType") );
			objEn.put("netBandW",request.getParameter("netBandW") );
			objEn.put("netNum",request.getParameter("netNum") );
				
			objZh.put("链路类型",request.getParameter("netType") );
			objZh.put("公网宽带",request.getParameter("netBandW") );
			objZh.put("公网数量",request.getParameter("netNum") );
		}
		
		params.put("orderDetailId", request.getParameter("orderDetailId"));
		//params.put("belongCloud", request.getParameter("belongCloud"));
		params.put("applicantTel", request.getParameter("applicantTel"));
		params.put("applicantReason", request.getParameter("applicantReason"));
		params.put("costCenterName", request.getParameter("costCenterName"));
		params.put("costCenterCode", request.getParameter("costCenterCode"));
		params.put("userMaxNumbers", request.getParameter("userMaxNumbers"));
		params.put("concurrentNumbers", request.getParameter("concurrentNumbers"));
		params.put("useType", request.getParameter("useType"));
		params.put("applyDesc", request.getParameter("applyDesc"));
		Timestamp s=DateUtils.strToTimestampByPattern(request.getParameter("expirationDate"),"yyyy-MM-dd");
		params.put("expirationDate", s);
		params.put("applicantDesc", request.getParameter("applicantDesc"));
		params.put("prodParam", objEn.toString());
		params.put("prodParamZh", objZh.toString());
		params.put("vmNumber", request.getParameter("vmNumber"));  //虚拟机数量
		params.put("isProject", request.getParameter("isProject"));  //是否项目
		
		String data=new JSONObject(params).toString();
		//String service = "http://127.0.0.1:20881/ipaas";
		String service =CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");
		String url = "/user/iOrderApi/updateIaasOrder";
		 
		String result=HttpClientUtil.sendPostRequest(service+url, data);
		if(result==null){
			objresult.put("responseCode","999999" );
			objresult.put("responseMsg", "请求出错");
			return objresult.toString();
		}
		return result;
		 
		
	}
}
