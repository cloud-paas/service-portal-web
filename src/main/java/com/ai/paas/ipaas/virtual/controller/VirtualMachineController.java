package com.ai.paas.ipaas.virtual.controller;
import java.io.IOException;
import java.net.URISyntaxException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.cache.CacheUtils;
import com.ai.paas.ipaas.cache.CodeValueObject;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.utils.DateUtils;
import com.ai.paas.ipaas.virtual.gson.GsonUtil;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
 

@Controller
@RequestMapping(value="/virtualMachine")
public class VirtualMachineController {
	private static final Logger logger = LogManager.getLogger(VirtualMachineController.class.getName());

	@RequestMapping(value="/initapply")
	public String initapply(HttpServletRequest request,HttpServletResponse response) throws IOException, URISyntaxException
	{ 
		request.getSession().removeAttribute("list_index");
        request.getSession().setAttribute("list_index", "list_11");
		return "virtualMachine/introduce";
	}
	
	@RequestMapping(value="/goVirtualMachineApply")
	public String goVirtualIntegration(HttpServletRequest request,HttpServletResponse response) throws IOException, URISyntaxException
	{ 
		//http://localhost:8080/iPaas-Web/jsp/virtualMachine/virtualMachineApply.jsp
		return "virtualMachine/virtualMachineApply";
	}

	@RequestMapping(value="/vmCPULoading",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
	public @ResponseBody String vmCPULoading(HttpServletRequest request,HttpServletResponse response)
	{
		List<CodeValueObject> list01 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_ProjectExp");
		List<CodeValueObject> list02 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.YF_ProjectExp");
		
		List<CodeValueObject> list1 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_CPU");
		List<CodeValueObject> list2 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.YF_CPU");
		String S3 = CacheUtils.getValueByKey("VirtualMachineBase.ZY_VirtualType");
		String S4 = CacheUtils.getValueByKey("VirtualMachineBase.YF_VirtualType");
		List<CodeValueObject> list5 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_NetType");
		
		 JSONObject obj=new JSONObject();
		if(list1!=null && list2!=null && list1.size()>0 && list2.size()>0){
			obj.put("code","0000" );
		}else{
			obj.put("code","9999" );
		}
		// 用途说明
		 String code01="";
		  for(int i=0; i<list01.size();i++){
		     CodeValueObject temp01 = list01.get(i);
		       if(code01.equals("")){
		    	   code01+=temp01.getCode()+","+temp01.getValue();
		       }else{
		    	   code01+=";"+temp01.getCode()+","+temp01.getValue();
		       }
		  }
		  
		  String code02="";
		  for(int i=0; i<list02.size();i++){
		     CodeValueObject temp02 = list02.get(i);
		       if(code02.equals("")){
		    	   code02+=temp02.getCode()+","+temp02.getValue();
		       }else{
		    	   code02+=";"+temp02.getCode()+","+temp02.getValue();
		       }
		  }
		  
		  
		  
		//CPU
		  String code1="";
		  for(int i=0; i<list1.size();i++){
		     CodeValueObject temp1 = list1.get(i);
		       if(code1.equals("")){
		    	   code1+=temp1.getCode();
		       }else{
		    	   code1+=";"+temp1.getCode();
		       }
		  }
		  
		  String code2="";
		  for(int j=0; j<list2.size();j++){
			     CodeValueObject temp2 = list2.get(j);
			       if(code2.equals("")){
			    	   code2+=temp2.getCode();
			       }else{
			    	   code2+=";"+temp2.getCode();
			       }
		} 
		  
		 //虚拟机类型
		  if(S3==null || "".equals(S3)){  //如果为空，默认显示一下三个 ，
			  S3="WEB服务器;应用服务器;数据库";
		  }
		  if(S4==null || "".equals(S4)){
			  S4="WEB服务器;应用服务器;数据库";
		  }
		  
		//租用资源链路类型
		  String code5="";
		  for(int i=0; i<list5.size();i++){
		     CodeValueObject temp5 = list5.get(i);
		       if(code5.equals("")){
		    	   code5+=temp5.getCode();
		       }else{
		    	   code5+=";"+temp5.getCode();
		       }
		  }
		  
		 obj.put("ZY_ProjectExp",code01 );
		 obj.put("YF_ProjectExp",code02 );
		 obj.put("ZY_CPU",code1 );
		 obj.put("YF_CPU",code2 );
		 obj.put("ZY_VirtualType",S3 );
		 obj.put("YF_VirtualType",S4 );
		 obj.put("ZY_NetType",code5 );
		return obj.toString();
	}
	
	@RequestMapping(value="/vmClickCPU",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
	public @ResponseBody String vmClickCPU(HttpServletRequest request,HttpServletResponse response)
	{
		String pageCpu = request.getParameter("pageCpu");
		String cpu = request.getParameter("cpu");
		List<CodeValueObject> list3 =null;
		if("ZY_CPU".equals(cpu)){
			list3 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_CPU");
			logger.info("vmClickCPU...list3>>>>:"+list3);
		}
		if("YF_CPU".equals(cpu)){
			list3 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.YF_CPU");
			logger.info("vmClickCPU...list3>>>>:"+list3);
		}
		
		  JSONObject obj1=new JSONObject();
		  String RAM="";
		  for(int i=0; i<list3.size();i++){
		     if(list3.get(i).getCode().equals(pageCpu)){
		       //System.out.println(list.get(i));
		    	   RAM=list3.get(i).getValue().toString();
		     }
		  }
		 obj1.put("code","0000" );
		 obj1.put("RAM",RAM );
		return obj1.toString();
	}
	
	
	
	@RequestMapping(value="/vmSystemLoading",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
	public @ResponseBody String vmSystemLoading(HttpServletRequest request,HttpServletResponse response)
	{
		List<CodeValueObject> list1 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_System");
		List<CodeValueObject> list2 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.YF_System");

		 JSONObject obj=new JSONObject();
		if(list1!=null && list2!=null && list1.size()>0 && list2.size()>0){
			obj.put("code","0000" );
		}else{
			obj.put("code","9999" );
		}

		  String code1="";
		  String firstSysTemchild1=list1.get(0).getValue().toString();//默认显示第一个系统版本，及其下使用子版本
		  for(int i=0; i<list1.size();i++){
		     CodeValueObject temp1 = list1.get(i);
		       if(code1.equals("")){
		    	   code1+=temp1.getCode();
		       }else{
		    	   code1+=";"+temp1.getCode();
		       }
		  }
		  
		  String code2="";
		  String firstSysTemchild2=list2.get(0).getValue().toString();//默认显示第一个系统版本，及其下使用子版本
		  for(int j=0; j<list2.size();j++){
			     CodeValueObject temp2 = list2.get(j);
			       if(code2.equals("")){
			    	   code2+=temp2.getCode();
			       }else{
			    	   code2+=";"+temp2.getCode();
			       }
			  } 

		 obj.put("ZY_System",code1 );
		 obj.put("YF_System",code2 );
		 obj.put("firstSysTemchild1",firstSysTemchild1 );
		 obj.put("firstSysTemchild2",firstSysTemchild2 );
		return obj.toString();
	}
	
	@RequestMapping(value="/vmClickSystem",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
	public @ResponseBody String vmClickSystem(HttpServletRequest request,HttpServletResponse response)
	{
		String pageSys = request.getParameter("pageSys");
		String sys = request.getParameter("sys");
		List<CodeValueObject> list3 =null;
		if("ZY_System".equals(sys)){
			list3 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_System");
			logger.info("vmClickCPU...list3>>>>:"+list3);
		}
		if("YF_System".equals(sys)){
			list3 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.YF_System");
			logger.info("vmClickCPU...list3>>>>:"+list3);
		}
		
		  JSONObject obj1=new JSONObject();
		  String SysTemChild="";
		  for(int i=0; i<list3.size();i++){
		     if(list3.get(i).getCode().equals(pageSys)){
		       //System.out.println(list.get(i));
		    	 SysTemChild=list3.get(i).getValue().toString();
		     }
		  }
		 obj1.put("code","0000" );
		 obj1.put("SysTemChild",SysTemChild );
		return obj1.toString();
	}
	
	
	@RequestMapping(value="/vmSoftLoading",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
	public @ResponseBody String vmSoftLoading(HttpServletRequest request,HttpServletResponse response){
		
		String SystemCode = request.getParameter("SystemCode");

		List<CodeValueObject> list1 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_Save_Soft");
		List<CodeValueObject> list2 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_Run_Soft");
		
		List<CodeValueObject> list3 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.YF_Save_Soft");
		List<CodeValueObject> list4 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.YF_Run_Soft");
		
		 JSONObject obj=new JSONObject();
			if( (list1!=null && list2!=null) || (list3!=null  && list4!=null)  ){
				obj.put("code","0000" );
			}else{
				obj.put("code","9999" );
			}
		

		  String ZY_Save_Soft="";
		  for(int i=0; i<list1.size();i++){
		     if(list1.get(i).getCode().equals(SystemCode)){
		    	 CodeValueObject temp1 = list1.get(i);
		    	 ZY_Save_Soft+=temp1.getValue();
			       /*if(ZY_Save_Soft.equals("")){
			    	   ZY_Save_Soft+=temp1.getValue();
			       }else{
			    	   ZY_Save_Soft+=";"+temp1.getValue();
			       }*/
		     }
		  }
		  
		  String ZY_Run_Soft="";
		  for(int i=0; i<list2.size();i++){
		     if(list2.get(i).getCode().equals(SystemCode)){
		    	 CodeValueObject temp1 = list2.get(i);
		    	 ZY_Run_Soft+=temp1.getValue();
		     }
		  }
		  
		  String YF_Save_Soft="";
		  for(int i=0; i<list3.size();i++){
		     if(list3.get(i).getCode().equals(SystemCode)){
		    	 CodeValueObject temp1 = list3.get(i);
		    	 YF_Save_Soft+=temp1.getValue();
		     }
		  }
		  
		  String YF_Run_Soft="";
		  for(int i=0; i<list4.size();i++){
		     if(list4.get(i).getCode().equals(SystemCode)){
		    	 CodeValueObject temp1 = list4.get(i);
		    	 YF_Run_Soft+=temp1.getValue();
		     }
		  }
		
		 
		 obj.put("ZY_Save_Soft",ZY_Save_Soft );
		 obj.put("ZY_Run_Soft",ZY_Run_Soft );
		 obj.put("YF_Save_Soft",YF_Save_Soft );
		 obj.put("YF_Run_Soft",YF_Run_Soft );
		return obj.toString();
	}
	
	@RequestMapping(value="/vmSofClick",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
	public @ResponseBody String vmSofClick(HttpServletRequest request,HttpServletResponse response){
		
		String SystemCode = request.getParameter("SystemCode");
		String Colod = request.getParameter("Colod");

		List<CodeValueObject> list1 = null;
		List<CodeValueObject> list2 = null;
		
		if("1".equals(Colod)){ //研发云
			 list1 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.YF_Save_Soft");
			 list2 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.YF_Run_Soft");
		}
		if("2".equals(Colod)){ //租用云
			 list1 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_Save_Soft");
			 list2 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_Run_Soft");
		}
		
		 JSONObject obj=new JSONObject();
			if( (list1!=null && list2!=null)  ){
				obj.put("code","0000" );
			}else{
				obj.put("code","9999" );
			}
		

		  String Save_Soft="";
		  for(int i=0; i<list1.size();i++){
		     if(list1.get(i).getCode().equals(SystemCode)){
		    	 CodeValueObject temp1 = list1.get(i);
		    	 Save_Soft+=temp1.getValue();
			       /*if(ZY_Save_Soft.equals("")){
			    	   ZY_Save_Soft+=temp1.getValue();
			       }else{
			    	   ZY_Save_Soft+=";"+temp1.getValue();
			       }*/
		     }
		  }
		  
		  String Run_Soft="";
		  for(int i=0; i<list2.size();i++){
		     if(list2.get(i).getCode().equals(SystemCode)){
		    	 CodeValueObject temp1 = list2.get(i);
		    	 Run_Soft+=temp1.getValue();
		     }
		  }
		  
		 
		 obj.put("Save_Soft",Save_Soft );
		 obj.put("Run_Soft",Run_Soft );
		return obj.toString();
	}

	
	@RequestMapping(value="/vmUserLoading",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
	public @ResponseBody String vmUserLoading(HttpServletRequest request,HttpServletResponse response){
		
		JSONObject objresult=new JSONObject();
		UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
		logger.info("vmUserLoading...userInfoVo>>>>:"+userInfoVo);
		String service =CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");//http://10.1.228.198:10889/ipaas
//		String service = "http://127.0.0.1:20881/ipaas";
		logger.info("vmUserLoading...service>>>>:"+service);
		String url = "/user/iUserApi/getAiEmployeeInfo";
		
		Map map = new HashMap();
		if(userInfoVo.getPartnerAccount()!=null || !"".equals(userInfoVo.getPartnerAccount())){
			map.put("ntAccount", userInfoVo.getPartnerAccount()); 
		}else{
			map.put("ntAccount", userInfoVo.getUserEmail().split("@")[0]);   //nt账号		"mapl"	
		}
		
	
		System.out.println("to MAIN rest:" + service + url);		
		Gson gson=new Gson();
		String json=gson.toJson(map);
					System.out.println("ppp:"+json);
		String result = null;
		JSONObject json2 = new JSONObject();
		Map<String ,String > outMap = new HashMap<String,String>();
		try {
			result = HttpClientUtil.sendPostRequest(service + url, json);
			Map resmap = GsonUtil.fromJSon(result, HashMap.class);
		    String object  = (String) resmap.get("object");
		    Gson gson2 = new Gson();
		    List<Map<String,Object>> list= gson2.fromJson(object,
		    new TypeToken<List<Map<String,Object>>>() {
		    }.getType());		    
		    Map lais = list.get(0);
		    JSONObject jsonww = new JSONObject(lais);
		    jsonww.put("responseCode", resmap.get("responseCode"));
		    result = jsonww.toString();
			System.out.println("MAIN return>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>. :" + result);
			
		} catch (IOException e) {
			 objresult.put("responseCode","999999");
			 objresult.put("mssage","请求出错！");
			e.printStackTrace();
		} catch (URISyntaxException e) {
			 objresult.put("responseCode","999999");
			 objresult.put("mssage","请求出错！");
			e.printStackTrace();
		}
		
		if(result==null || "".equals(result)){	
			
			  objresult.put("Uname",userInfoVo.getPartnerAccount() );//namee[0]
			  objresult.put("Uemail",userInfoVo.getUserName() );
			  objresult.put("Uphone",userInfoVo.getUserPhoneNum());
			  result=objresult.toString();
		}
		return result;
	}
		
		
	@RequestMapping(value="/vmSubmit",method={RequestMethod.POST},produces = "application/json;charset=utf-8")
	public @ResponseBody String vmSubmit(HttpServletRequest request,HttpServletResponse response) throws IOException, URISyntaxException, PaasException
	{
		String NtName;
		UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
		if(userInfoVo.getPartnerAccount()!=null || !"".equals(userInfoVo.getPartnerAccount())){
			NtName = userInfoVo.getPartnerAccount(); 
		}else{
			NtName = userInfoVo.getUserEmail().split("@")[0];   //nt账号		"mapl"	
		}
		JSONObject objresult=new JSONObject();
		String service =CacheUtils.getOptionByKey("CONTROLLER.CONTROLLER","url");//测试环境后场地址
		//String service ="http://127.0.0.1:20881/ipaas";		
		
		JSONObject objEn=new JSONObject();
		objEn.put("cpu",request.getParameter("virtualCpu") );
		objEn.put("virtualType",request.getParameter("virtualType") );
		objEn.put("virtualRam",request.getParameter("virtualRam") );
		objEn.put("virtualHard",request.getParameter("virtualHard") );
		objEn.put("SysTem",request.getParameter("SysTem") );
		objEn.put("SysTemChild",request.getParameter("SysTemChild") );
		objEn.put("SysOtherTem",request.getParameter("SysOtherTem") );
		objEn.put("storageSoft",request.getParameter("storageSoft") );
		objEn.put("environmentSoft",request.getParameter("environmentSoft") );
		
		JSONObject objZh=new JSONObject();
		objZh.put("处理器",request.getParameter("virtualCpu") );
		objZh.put("虚拟机类型",request.getParameter("virtualType") );
		objZh.put("内存",request.getParameter("virtualRam") );
		objZh.put("数据盘",request.getParameter("virtualHard") );
		objZh.put("操作系统",request.getParameter("SysTem") );
		objZh.put("操作系统版本",request.getParameter("SysTemChild") );
		objZh.put("其他操作系统",request.getParameter("SysOtherTem") );
		objZh.put("存储软件",request.getParameter("storageSoft") );
		objZh.put("运行环境软件",request.getParameter("environmentSoft") );
		if(request.getParameter("curType")!=null 
				&& !"".equals(request.getParameter("curType")) 
				&& "华为租用云".equals(request.getParameter("curType"))){
			
		objEn.put("netType",request.getParameter("netType") );
		objEn.put("netBandW",request.getParameter("netBandW") );
		objEn.put("netNum",request.getParameter("netNum") );
			
		objZh.put("链路类型",request.getParameter("netType") );
		objZh.put("公网宽带",request.getParameter("netBandW") );
		objZh.put("公网数量",request.getParameter("netNum") );
		}
		
		Map map = new HashMap();		
		
		if(request.getParameter("curType")!=null && !"".equals(request.getParameter("curType")) && "华为租用云".equals(request.getParameter("curType"))){
			map.put("belongCloud", "2");  //归属平台	  1研发云   2租用云
		}else{
			map.put("belongCloud", "1");
		}
		
		//     后台查出来的    map.put("prodType", "2");  // 1 存储  2计算   3数据库服务
		map.put("operateType", "1");   //操作类型  1 为申请 ， 2扩容 ， 3退订 OPERATE_TYPE	
		map.put("prodId", "11"); //产品id**************************************************
		map.put("applyType", "1"); //资源申请方式    1， 新建    2变更*****************************************	
		map.put("userId", userInfoVo.getUserId());  //userId
		map.put("prodParamZh", objZh.toString()); //中文产品参数
		map.put("prodParam", objEn.toString()); //英文产品参数
		map.put("applicant", request.getParameter("applyUser"));  //申请人		
		map.put("applicantDept", request.getParameter("applyDepartment"));  //申请人部门		
		map.put("applicantTel", request.getParameter("applyuserPhone"));  //申请人电话		
		map.put("applicantEmail", request.getParameter("applyuserEmail")); //申请人邮箱		
		map.put("applicantReason", request.getParameter("applyReason"));  //申请原因		
		map.put("applicantDesc", request.getParameter("otherExplain"));  //备注
		Timestamp s=DateUtils.strToTimestampByPattern(request.getParameter("projectEndTime"),"yyyy-MM-dd");
		map.put("expirationDate",s );  //到期时间
		map.put("costCenterCode", request.getParameter("costcenter_id"));  //成本中心编码
		map.put("costCenterName", request.getParameter("projectName"));  //成本中心名称
		map.put("userMaxNumbers", request.getParameter("userMaxNumbers"));  //用户数		
		map.put("concurrentNumbers", request.getParameter("concurrentNumbers"));   //最大访问量		
		map.put("useType", request.getParameter("projectExplain"));  //用途说明	 // 1 开发   2测试  3 生产  4 其他	
		map.put("applyDesc", request.getParameter("projectNot"));  //业务描绘
		map.put("vmNumber", request.getParameter("vmNumber"));  //虚拟机数量
		map.put("isProject", request.getParameter("isProject"));  //虚拟机数量
		
		

		//String param = GsonUtil.toJSon(map);
		//Gson gson=new Gson();
		//String param =gson.toJson(map);
	
		
		 JSONObject jsonww = new JSONObject(map);
		 String param = jsonww.toString();
		 logger.info("vmSubmit...map to param>>>>:"+param);
		 
		String result = null;
		String url = "/user/iOrderApi/saveIaasOrder";
		logger.info("vmSubmit...service>>>>:"+service+url);
		try {
			result = HttpClientUtil.sendPostRequest(service + url, param);
			logger.info("vmSubmit...result>>>>:"+result);
		} catch (IOException e) {
			e.printStackTrace();
		} catch (URISyntaxException e) {
			e.printStackTrace();
		}		

		
		
		
		if(result==null){
			objresult.put("responseCode","999999" );
			objresult.put("responseMsg", "请求出错");
			return objresult.toString();
		}
		return result;
	}
	
	@RequestMapping(value = "/toVirtualApplyCompleted")
	public String toVirtualApplyCompleted(ModelMap model,HttpServletRequest request,HttpServletResponse response){

		Date date = new Date () ;   
		SimpleDateFormat dateFormat = new SimpleDateFormat( "yyyy年 MM月 dd号" );   
		String   dateStr = dateFormat.format(new Date( date.getTime() + 6 * 24 * 60 * 60 * 1000));
		model.addAttribute("dateStr", dateStr);
		
		return "/virtualMachine/virtualApplySuccess";
	}
	
	
	
	
	public static void main(String[] args) throws IOException, URISyntaxException {			
				List<CodeValueObject> list1 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_Save_Soft");
		List<CodeValueObject> list2 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.ZY_Run_Soft");
		
		List<CodeValueObject> list3 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.YF_Save_Soft");
		List<CodeValueObject> list4 = CacheUtils.getCodeValueListByKey("VirtualMachineBase.YF_Run_Soft");
		
		 String ZY_Save_Soft="";
		  for(int i=0; i<list1.size();i++){
		     if(list1.get(i).getCode().equals("Linux版本")){
		    	 CodeValueObject temp1 = list1.get(i);
		    	 ZY_Save_Soft+=temp1.getValue();			  
		     }
		  }
		  System.out.println(ZY_Save_Soft);
	
    
}


}