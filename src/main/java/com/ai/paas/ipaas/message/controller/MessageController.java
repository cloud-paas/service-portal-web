package com.ai.paas.ipaas.message.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.cache.CacheUtils;
import com.ai.paas.ipaas.message.param.MessageInfo;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrder;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.interfaces.MessageDisplayDubboSv;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailRequest;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailResponse;
import com.ai.paas.ipaas.user.dubbo.vo.PageEntity;
import com.ai.paas.ipaas.user.dubbo.vo.PageResult;
import com.ai.paas.ipaas.user.dubbo.vo.SysParamVo;
import com.ai.paas.ipaas.user.dubbo.vo.SysParmRequest;
import com.ai.paas.ipaas.user.dubbo.vo.UserMessageRequest;
import com.ai.paas.ipaas.user.dubbo.vo.UserMessageResponse;
import com.ai.paas.ipaas.user.dubbo.vo.UserMessageVo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.StringUtil;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.JsonObject;

@Controller
@RequestMapping(value = "/mds")
public class MessageController {
	@Reference
	private IOrder iOrder;
	@Reference
	private ISysParamDubbo iSysParam;
	@Reference
	private MessageDisplayDubboSv messageDisplayDubboSv;
	private static final Logger log = LogManager
			.getLogger(MessageController.class.getName());
	
	
	@RequestMapping(value="/introduce")
	public String toIndex(HttpServletRequest request,HttpServletResponse response){
        request.getSession().removeAttribute("list_index");
        request.getSession().setAttribute("list_index", "list_4");
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
	@RequestMapping(value="/addMessage")
	public String addMessage(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception{
		MessageInfo messageInfo = new MessageInfo();
		SysParmRequest req = new SysParmRequest();
		req.setTypeCode(Constants.serviceName.MDS);
		req.setParamCode(Constants.paramCode.OPTIONS);
		List<SysParamVo> list = iSysParam.getSysParams(req);
		model.addAttribute("optionList", list);
		model.addAttribute("messageInfo", messageInfo);
		return "message/addMessage";	
	}
	
	/**
	 * 保存消息服务申请
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value="/saveMessage",produces = {"application/json;charset=UTF-8"})
	public String saveMessage(ModelMap model,HttpServletRequest request,HttpServletResponse response) throws Exception{
		String messageName =request.getParameter("queueName");
		String partitions = request.getParameter("partitions");
		String queuePwd = request.getParameter("queuePwd");
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		String userId=userVo.getUserId();
		MessageInfo messageInfo = new MessageInfo();
		OrderDetailRequest orderDetailRequest=new OrderDetailRequest();
		orderDetailRequest.setProdByname(Constants.serviceName.MDS);
		orderDetailRequest.setUserId(userId);								//用户ID
		orderDetailRequest.setOperateType(Constants.OperateType.APPLY);		//操作类型
		orderDetailRequest.setProdId(Constants.serviceType.MESSAGE_CENTER+"");	//产品ID
		orderDetailRequest.setProdType(Constants.ProductType.IPAAS_CunChu);		//产品类型  PROD_IPAAS
		orderDetailRequest.setUserServIpaasPwd(queuePwd);
		JsonObject prodParamJson = new JsonObject();
		prodParamJson.addProperty("userId", userId);
		prodParamJson.addProperty("applyType", "create");
		prodParamJson.addProperty("topicName", messageName);
		prodParamJson.addProperty("topicPartitions", partitions);
		prodParamJson.addProperty("msgReplica", "2");
		log.info("产品参数："+prodParamJson.toString());
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
	
	@RequestMapping(value = "/messageDisplay")
	public String toMessageDisplay(HttpServletRequest request, HttpServletResponse response) {
		String str="";
		PageEntity pageEntity=new PageEntity();
		String page=request.getParameter("page");
		String size=request.getParameter("size");
		String userId=UserUtil.getUserSession(request.getSession()).getUserId();
		Map<String, String> param=new HashMap<String, String>();
		pageEntity.setCurrentPage(StringUtil.isBlank(page) ? 1: Integer.valueOf(page));
		pageEntity.setPageSize(StringUtil.isBlank(size) ? 5: Integer.valueOf(size));
		param.put("userId", userId);
		pageEntity.setParams(param);
		UserMessageRequest userMessageRequest = new UserMessageRequest();
		userMessageRequest.setPageEntity(pageEntity);
		String[] Admin = CacheUtils.getValueByKey("System.Admin").split(";");
		try {
			UserMessageResponse userMessageResponse = messageDisplayDubboSv.searchPage(userMessageRequest);
			PageResult<UserMessageVo> pageResult = new PageResult<UserMessageVo>();
			pageResult = userMessageResponse.getPageResult();
			request.setAttribute("pagingResult", pageResult);
			
			request.setAttribute("AdminName", Admin[0]);
			request.setAttribute("AdminPhone", Admin[1]);
			request.setAttribute("AdminEmail", Admin[2]);
			int num=pageResult.getTotalPages();
				str="message/messageDisplay";
		} catch (PaasException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return str;
		
	}

}
