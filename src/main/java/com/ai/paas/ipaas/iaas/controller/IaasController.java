package com.ai.paas.ipaas.iaas.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.message.param.MessageInfo;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrder;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.interfaces.IaasConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.MessageDisplayDubboSv;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailRequest;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailResponse;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageRequest;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageResponse;
import com.ai.paas.ipaas.user.dubbo.vo.SysParamVo;
import com.ai.paas.ipaas.user.dubbo.vo.SysParmRequest;
import com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.JsonObject;

@Controller
@RequestMapping(value = "/iaas")
public class IaasController {
	@Reference
	private IOrder iOrder;
	@Reference
	private ISysParamDubbo iSysParam;
	
	@Reference
	private IaasConsoleDubboSv iaasConsoleDubboSv;
	
	@Reference
	private MessageDisplayDubboSv messageDisplayDubboSv;
	private static final Logger log = LogManager
			.getLogger(IaasController.class.getName());
	
	
	@RequestMapping(value="/introduce")
	public String toIndex(HttpServletRequest request,HttpServletResponse response){
		return "message/introduce";
	}
	
	/**
	 * 进入申请消息服务页面
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/applyPhysicalMachine")
	public String applyPhysicalMachine(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception{
		MessageInfo messageInfo = new MessageInfo();
		SysParmRequest req = new SysParmRequest();
		req.setTypeCode(Constants.serviceName.MDS);
		req.setParamCode(Constants.paramCode.OPTIONS);
		List<SysParamVo> list = iSysParam.getSysParams(req);
		model.addAttribute("optionList", list);
		model.addAttribute("messageInfo", messageInfo);
		return "iaas/applyPhysicalMachine";	
	}
	
	@ResponseBody
	@RequestMapping(value="/savePhysicalMachineInfo",produces = {"application/json;charset=UTF-8"})
	public String savePhysicalMachineInfo(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		String systemType =request.getParameter("my_sys");
		String cpuType = request.getParameter("my_cpu");
		String machineName = request.getParameter("my_vmname");
		String memoryInfo = request.getParameter("my_yp");
		String busiInfo = request.getParameter("my_busi");
		String cacheInfo = request.getParameter("my_nc");
		
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		String userId=userVo.getUserId();
		OrderDetailRequest orderDetailRequest=new OrderDetailRequest();
		orderDetailRequest.setProdByname(Constants.serviceName.IAAS_PHYSICAL);
		orderDetailRequest.setUserId(userId);								//用户ID
		orderDetailRequest.setOperateType(Constants.OperateType.APPLY);		//操作类型
		orderDetailRequest.setProdId(Constants.serviceType.IAAS_PHYSICAL);	//产品ID
		orderDetailRequest.setProdType(Constants.ProductType.IPAAS_JiSuan);	 //PROD_IAAS 	//产品类型  // 1存储  2计算   3 数据库服务
		JsonObject prodParamJson = new JsonObject();
		prodParamJson.addProperty("systemType", systemType);
		prodParamJson.addProperty("cpuType", cpuType);
		prodParamJson.addProperty("machineName", machineName);
		prodParamJson.addProperty("memoryInfo", memoryInfo);
		prodParamJson.addProperty("busiInfo", busiInfo);
		prodParamJson.addProperty("cacheInfo", cacheInfo);
		orderDetailRequest.setProdParam(prodParamJson.toString());
		OrderDetailResponse orderDetailResponse=new OrderDetailResponse();
		try{
			orderDetailResponse=iOrder.saveOrderDetail(orderDetailRequest);
		}catch(Exception e){
			log.info(e.getCause().getMessage()+e.getMessage()+"---------");
		}
		log.info("saveOrderDetail返回结果："+orderDetailResponse.getResponseHeader().getResultCode()+":"+orderDetailResponse.getResponseHeader().getResultMessage());
		JsonObject resultJson = new JsonObject();
		resultJson.addProperty("resultCode",orderDetailResponse.getResponseHeader().getResultCode());
		resultJson.addProperty("resultMessage", orderDetailResponse.getResponseHeader().getResultMessage());
		
		return resultJson.toString();
	}
	
	
	@RequestMapping(value="/applyVirtalMachine")
	public String applyVirtalMachine(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception{
		MessageInfo messageInfo = new MessageInfo();
		SysParmRequest req = new SysParmRequest();
		req.setTypeCode(Constants.serviceName.MDS);
		req.setParamCode(Constants.paramCode.OPTIONS);
		List<SysParamVo> list = iSysParam.getSysParams(req);
		model.addAttribute("optionList", list);
		model.addAttribute("messageInfo", messageInfo);
		return "iaas/applyVirtalMachine";	
	}
	
	@ResponseBody
	@RequestMapping(value="/saveVirtalMachineInfo",produces = {"application/json;charset=UTF-8"})
	public String saveVirtalMachineInfo(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		String systemType =request.getParameter("my_sys");
		String cpuType = request.getParameter("my_cpu");
		String machineName = request.getParameter("my_vmname");
		String memoryInfo = request.getParameter("my_yp");
		String busiInfo = request.getParameter("my_busi");
		String cacheInfo = request.getParameter("my_nc");
		
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		String userId=userVo.getUserId();
		OrderDetailRequest orderDetailRequest=new OrderDetailRequest();
		orderDetailRequest.setProdByname(Constants.serviceName.IAAS_VIRTAL);
		orderDetailRequest.setUserId(userId);								//用户ID
		orderDetailRequest.setOperateType(Constants.OperateType.APPLY);		//操作类型
		orderDetailRequest.setProdId(Constants.serviceType.IAAS_VIRTAL);	//产品ID
		orderDetailRequest.setProdType(Constants.ProductType.IPAAS_JiSuan); //PROD_IAAS		//产品类型
		JsonObject prodParamJson = new JsonObject();
		prodParamJson.addProperty("systemType", systemType);
		prodParamJson.addProperty("cpuType", cpuType);
		prodParamJson.addProperty("machineName", machineName);
		prodParamJson.addProperty("memoryInfo", memoryInfo);
		prodParamJson.addProperty("busiInfo", busiInfo);
		prodParamJson.addProperty("cacheInfo", cacheInfo);
		orderDetailRequest.setProdParam(prodParamJson.toString());
		OrderDetailResponse orderDetailResponse=new OrderDetailResponse();
		try{
			orderDetailResponse=iOrder.saveOrderDetail(orderDetailRequest);
		}catch(Exception e){
			log.info(e.getCause().getMessage()+e.getMessage()+"---------");
		}
		log.info("saveOrderDetail返回结果："+orderDetailResponse.getResponseHeader().getResultCode()+":"+orderDetailResponse.getResponseHeader().getResultMessage());
		JsonObject resultJson = new JsonObject();
		resultJson.addProperty("resultCode",orderDetailResponse.getResponseHeader().getResultCode());
		resultJson.addProperty("resultMessage", orderDetailResponse.getResponseHeader().getResultMessage());
		
		return resultJson.toString();
	}
	
	
	
	
	@RequestMapping(value="/applyMemory")
	public String applyMemory(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		SelectWithNoPageRequest<UserProdInstVo> req = new SelectWithNoPageRequest<UserProdInstVo>();
		UserProdInstVo selectRequestVo = new UserProdInstVo();
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		String userId=userVo.getUserId();
		selectRequestVo.setUserId(userId);
		selectRequestVo.setUserServiceId(Constants.serviceType.IAAS_VIRTAL);
		req.setSelectRequestVo(selectRequestVo);
		SelectWithNoPageResponse<UserProdInstVo> res = iaasConsoleDubboSv.selectUserProdInsts(req);
		List<UserProdInstVo> list = res.getResultList();
		model.addAttribute("optionList", list);
		return "iaas/applyMemory";	
	}
	
	
	@ResponseBody
	@RequestMapping(value="/saveMemoryInfo",produces = {"application/json;charset=UTF-8"})
	public String saveMemorInfo(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		String systemType =request.getParameter("my_sys");
		String memoryInfo = request.getParameter("my_yp");
		String busiInfo = request.getParameter("my_busi");
		
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		String userId=userVo.getUserId();
		OrderDetailRequest orderDetailRequest=new OrderDetailRequest();
		orderDetailRequest.setProdByname(Constants.serviceName.IAAS_MEMORY);
		orderDetailRequest.setUserId(userId);								//用户ID
		orderDetailRequest.setOperateType(Constants.OperateType.APPLY);		//操作类型
		orderDetailRequest.setProdId(Constants.serviceType.IAAS_MEMORY);	//产品ID
		orderDetailRequest.setProdType(Constants.ProductType.IPAAS_JiSuan); //PROD_IAAS		//产品类型
		JsonObject prodParamJson = new JsonObject();
		prodParamJson.addProperty("memoryType", systemType);
		prodParamJson.addProperty("memorySize", memoryInfo);
		prodParamJson.addProperty("machineName", busiInfo);
		orderDetailRequest.setProdParam(prodParamJson.toString());
		OrderDetailResponse orderDetailResponse=new OrderDetailResponse();
		try{
			orderDetailResponse=iOrder.saveOrderDetail(orderDetailRequest);
		}catch(Exception e){
			log.info(e.getCause().getMessage()+e.getMessage()+"---------");
		}
		log.info("saveOrderDetail返回结果："+orderDetailResponse.getResponseHeader().getResultCode()+":"+orderDetailResponse.getResponseHeader().getResultMessage());
		JsonObject resultJson = new JsonObject();
		resultJson.addProperty("resultCode",orderDetailResponse.getResponseHeader().getResultCode());
		resultJson.addProperty("resultMessage", orderDetailResponse.getResponseHeader().getResultMessage());
		
		return resultJson.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/validName",produces = {"application/json;charset=UTF-8"})
	public boolean validName(HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		String vmName =request.getParameter("vmName");
		
		SelectWithNoPageRequest<UserProdInstVo> req = new SelectWithNoPageRequest<UserProdInstVo>();
		UserProdInstVo selectRequestVo = new UserProdInstVo();
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		String userId=userVo.getUserId();
		selectRequestVo.setUserId(userId);
		selectRequestVo.setUserServiceId(Constants.serviceType.IAAS_VIRTAL);
		req.setSelectRequestVo(selectRequestVo);
		SelectWithNoPageResponse<UserProdInstVo> res = iaasConsoleDubboSv.selectUserProdInsts(req);
		List<UserProdInstVo> list = res.getResultList();
		boolean returnStr = true;
		for(UserProdInstVo vo : list){
			Map<String,String>  userServParamMap = vo.getUserServParamMap();
			String machineName = userServParamMap.get("machineName");
			if(StringUtils.isNoneEmpty(vmName)&&vmName.equals(machineName)){
				returnStr =false;
				break;
			}
		}
		return returnStr;
	}
	
	
	

}
