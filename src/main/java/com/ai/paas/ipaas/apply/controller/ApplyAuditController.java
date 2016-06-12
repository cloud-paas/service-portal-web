package com.ai.paas.ipaas.apply.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.apply.vo.OrderDetailLocalVo;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrder;
import com.ai.paas.ipaas.user.dubbo.interfaces.IProdProductDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.CheckOrdersRequest;
import com.ai.paas.ipaas.user.dubbo.vo.CheckOrdersResponse;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailVo;
import com.ai.paas.ipaas.user.dubbo.vo.PageEntity;
import com.ai.paas.ipaas.user.dubbo.vo.ProdProductVo;
import com.ai.paas.ipaas.user.dubbo.vo.SelectOrderRequest;
import com.ai.paas.ipaas.user.dubbo.vo.SelectOrderResponse;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageRequest;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageResponse;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.StringUtil;
import com.ai.paas.ipaas.zookeeper.SystemConfigHandler;
import com.alibaba.dubbo.config.annotation.Reference;

@Controller
@RequestMapping(value = "/apply")
public class ApplyAuditController {

	private static final Logger logger = LogManager
			.getLogger(ApplyAuditController.class);
	@Reference
	private IOrder iOrder;
	@Reference
	private IProdProductDubboSv iProdProductDubboSv;
	
	@Reference
	private ISysParamDubbo iSysParam;

	String authServiceUrl = SystemConfigHandler.configMap.get("iPaas-Auth.SERVICE.IP_PORT_SERVICE");
	
	String authSdkUrl = SystemConfigHandler.configMap.get("AUTH.SDKUrl.1");
	
	String oaCheckUrl = SystemConfigHandler.configMap.get("OA.SEE_CHECK_URL.url");
	
	/**
	 * 服务申请审核
	 * 
	 * @return
	 */
	@RequestMapping(value = "/applyAudit")
	public String applyAudit() {
		return "apply/auditList";
	}

	/**
	 * 服务申请审核列表查询
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/queryApplyAuditList")
	public Map<String, Object> queryApplyAuditList(HttpServletRequest request,
			HttpServletResponse response) {

		Map<String, Object> resultMap = new HashMap<String, Object>();
		SelectOrderRequest selectOrderRequest = new SelectOrderRequest();
		PageEntity entity = new PageEntity();
		String page = request.getParameter("page");
		entity.setCurrentPage(StringUtil.isBlank(page) ? 1 : Integer
				.valueOf(page));
		entity.setPageSize(Constants.PageResult.PAGE_SIZE);
		selectOrderRequest.setPageEntity(entity);
		SelectOrderResponse selectOrderResponse = null;
		logger.info("call dubboService selectOrderDetails  begin ！！！！！！！！！！");
		try {
			selectOrderResponse = iOrder.selectOrderDetails(selectOrderRequest);			
			resultMap.put("resultCode", selectOrderResponse.getResponseHeader().getResultCode());
			resultMap.put("resultMessage", selectOrderResponse.getResponseHeader().getResultMessage());
			resultMap.put("pageResult", selectOrderResponse.getPageResult());
			logger.info("call dubboService selectOrderDetails  end ！！！！！！！！！！");
		} catch (Exception e) {
			// TODO: handle exception
			logger.error(e.getMessage(), e);
			resultMap.put("resultCode", Constants.OPERATE_CODE_FAIL);
			resultMap.put("resultMessage", "系统异常，请联系管理员");
		}
		return resultMap;
	}

	/**
	 * 审批不通过页面跳转
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping(value = "/toAgainstApply")
	public String toAgainstApply(HttpServletRequest req,
			HttpServletResponse resp) {
		return "apply/againstApply";
	}

	/**
	 * 审核通过或者不通过
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/approveApply")
	public Map<String, Object> approveApply(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String applyIdList = request.getParameter("orderDetailIdList");
		String suggestion = request.getParameter("suggestion");
		String checkResult = request.getParameter("checkResult");		
		List<Long> idList = new ArrayList<Long>();
		String[] applyIdListArr = applyIdList.split(",");
		for (String id : applyIdListArr) {
			idList.add(Long.parseLong(id));
		}

		try {
			logger.info("！！！！！！apply audit begin, parameters [applyIdList:" + applyIdList+"]");
			CheckOrdersRequest checkOrdersRequest = new CheckOrdersRequest();
			checkOrdersRequest.setIdlist(idList);
			checkOrdersRequest.setSuggestion(suggestion); // 建议
			UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
			checkOrdersRequest.setUserId(userVo.getUserId());// userId
			checkOrdersRequest.setCheckResult(checkResult);// 审批结果；1：通过，2：驳回			
			CheckOrdersResponse checkOrdersResponse= iOrder.checkOrders(checkOrdersRequest);
			
			/** 根据应答结果，进行邮件发送 **/
			
			resultMap.put("resultCode", checkOrdersResponse.getResponseHeader().getResultCode());
			resultMap.put("resultMessage", checkOrdersResponse.getResponseHeader().getResultMessage());
			logger.info("!!!!!!!!apply audit end，apply result："+ checkOrdersResponse.getResponseHeader().getResultCode());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			resultMap.put("resultCode", Constants.OPERATE_CODE_FAIL);
			resultMap.put("resultMessage", "系统异常，请联系管理员!");
		}

		return resultMap;
	}
	
	/**
	 * 获取申请列表
	 * @param request
	 * @param modelmap
	 * @return
	 */
	@RequestMapping(value = "/purchaseRecords")
    public String purchaseRecords(HttpServletRequest request,Map <String ,Object>modelmap) {
		Map <String ,Object> datemap= getPurchsRecordsList(request);
		modelmap.putAll(datemap);
		modelmap.put("type", request.getParameter("prodType"));
        return "apply/purchaseRecords";
    }
	
    @RequestMapping(value = "/purchaseRecordsJson", produces = { "application/json;charset=UTF-8" })
    public @ResponseBody
    String getPurchsRecordsJson(HttpServletRequest request, HttpServletResponse response)
            throws Exception {
    	Map<String ,Object> res = getPurchsRecordsList(request);
        return net.sf.json.JSONObject.fromObject(res).toString();
    }
    
    @RequestMapping(value="/myAccount")
    public String toMyAccount(HttpServletRequest request) {
        UserInfoVo userInfo = UserUtil.getUserSession(request.getSession());
        request.setAttribute("user", userInfo);
        request.setAttribute("SDKUrl", authServiceUrl + authSdkUrl);
        return "apply/myAccount";
    }
    @RequestMapping(value="/passwordUpadte")
    public String passwordUpadte(HttpServletRequest request) {
        UserInfoVo userInfo = UserUtil.getUserSession(request.getSession());
        request.setAttribute("user", userInfo);
        return "apply/passwordUpadte";
    }
    
    @RequestMapping(value="/userNameUpdate")
    public String userNameUpdate(HttpServletRequest request) {
        UserInfoVo userInfo = UserUtil.getUserSession(request.getSession());
        request.setAttribute("user", userInfo);
        return "apply/userNameUpdate";
    }

    private Map<String ,Object> getPurchsRecordsList(HttpServletRequest request) {
    	Map<String ,Object> returnMap =new HashMap<String, Object>();
        List<List<OrderDetailLocalVo>> returnList = new ArrayList<List<OrderDetailLocalVo>>();
        String userId = UserUtil.getUserSession(request.getSession()).getUserId();
        String prodType = request.getParameter("prodType");
        int currentPage=0; 
        if(request.getParameter("currentPage")!=null && !"".equals(request.getParameter("currentPage"))){
        	currentPage = Integer.parseInt(request.getParameter("currentPage"));
        }else{
        	currentPage=1;
        }
        
        int PageSize = 2;
        if (prodType == null) {
            prodType = Constants.ProductType.IPAAS_JiSuan;  //   PROD_IAAS
        }
        
        SelectOrderRequest sORequest = new SelectOrderRequest();
        
        PageEntity pageEntity = new PageEntity();
        Map<String, String> params = new HashMap<String, String>();
        params.put("userId", userId);
        params.put("prodType", prodType);
        pageEntity.setParams(params);
        pageEntity.setCurrentPage(currentPage);// 当前页和页大小随便设置都行，后面用不到。只是不设置的话pageEntity会报错
        pageEntity.setPageSize(PageSize);
        sORequest.setPageEntity(pageEntity);
        SelectOrderResponse selectOrderResponse = new SelectOrderResponse();

        try {
            selectOrderResponse = iOrder.selectOrderList(sORequest);
         } catch (PaasException e) {
            logger.error(e.getMessage(), e);
        }

        if (selectOrderResponse.getPageResult().getResultList() != null) {
            List<OrderDetailVo> resultList = selectOrderResponse.getPageResult().getResultList();
            List<OrderDetailLocalVo> resultListSplit = new ArrayList<OrderDetailLocalVo>();
            for (int i = 0, listLength = resultList.size(); i < listLength; ++i) {
                OrderDetailVo vo = resultList.get(i);

                if (i != 0 && !vo.getProdId().equals(resultList.get(i - 1).getProdId())) {
                    returnList.add(resultListSplit);
                    resultListSplit = new ArrayList<OrderDetailLocalVo>();
                }
                OrderDetailLocalVo localVo = new OrderDetailLocalVo();
                BeanUtils.copyProperties(vo, localVo);
                {      
                	int prodID = Integer.parseInt(localVo.getProdId());              	
                	
                	SelectWithNoPageRequest<ProdProductVo> requestProd = new SelectWithNoPageRequest<ProdProductVo>();
                	ProdProductVo prodVo = new  ProdProductVo();
                	prodVo.setProdId((short) prodID);
                	requestProd.setSelectRequestVo(prodVo);
                	
                	SelectWithNoPageResponse<ProdProductVo> prodResponse = null;
                    try {
                    	prodResponse = iProdProductDubboSv.selectProduct(requestProd);
                     } catch (PaasException e) {
                        logger.error(e.getMessage(), e);
                    }
                    List<ProdProductVo>   resultProdList = prodResponse.getResultList();
                    if (resultProdList.size() == 1)
                    {
                    	ProdProductVo pvo = resultProdList.get(0);
                    	localVo.setProdNameStr(pvo.getProdName());
                    }                    
                }
                localVo.setOrderAppDateStr(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(vo
                        .getOrderAppDate()));
                localVo.setOaCheckUrl(oaCheckUrl);
                resultListSplit.add(localVo);
            }
            returnList.add(resultListSplit);
        }
        returnMap.put("currentpage", selectOrderResponse.getPageResult().getCurrentPage());
        returnMap.put("totalpage", selectOrderResponse.getPageResult().getTotalPages());
        returnMap.put("totalcount", selectOrderResponse.getPageResult().getTotalCount());
        returnMap.put("list", returnList);
        return returnMap;
    }
    
    /**
	 * 审核通过或者不通过
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/iaasAudit")
	public Map<String, Object> iaasAudit(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String applyIdList = request.getParameter("orderDetailIdList");		
		String ip = request.getParameter("ip");
		String userName = request.getParameter("userName");
		String pwd = request.getParameter("pwd");
		String checkResult = request.getParameter("checkResult");		
		List<Long> idList = new ArrayList<Long>();
		String[] applyIdListArr = applyIdList.split(",");
		for (String id : applyIdListArr) {
			idList.add(Long.parseLong(id));
		}
		JSONObject prodParam = new JSONObject();
        prodParam.put("ip", ip);
        prodParam.put("userName", userName);
        prodParam.put("pwd", pwd);

		try {
			logger.info("Iaas资源申请审核：单号" + applyIdList);
			CheckOrdersRequest checkOrdersRequest = new CheckOrdersRequest();
			checkOrdersRequest.setIdlist(idList);
			UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
			checkOrdersRequest.setUserId(userVo.getUserId());// userId
			checkOrdersRequest.setCheckResult(checkResult);// 审批结果；1：通过，2：驳回
			checkOrdersRequest.setUserServBackParam(prodParam.toString());
			CheckOrdersResponse checkOrdersResponse = iOrder.checkIaasOrders(checkOrdersRequest);
			resultMap.put("resultCode", checkOrdersResponse.getResponseHeader().getResultCode());
			resultMap.put("resultMessage", checkOrdersResponse.getResponseHeader().getResultMessage());
			logger.info("IAAS申请审核调用后场服务返回："	+ checkOrdersResponse.getResponseHeader().getResultCode());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			resultMap.put("resultCode", Constants.OPERATE_CODE_FAIL);
			resultMap.put("resultMessage", "系统异常，请联系管理员!");
		}

		return resultMap;
	}
}
