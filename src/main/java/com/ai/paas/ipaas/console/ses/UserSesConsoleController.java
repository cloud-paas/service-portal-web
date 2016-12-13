package com.ai.paas.ipaas.console.ses;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.manage.rest.interfaces.IDssConsoleDubboSv;
import com.ai.paas.ipaas.user.manage.rest.interfaces.IProdProductDubboSv;
import com.ai.paas.ipaas.user.manage.rest.interfaces.ISesConsoleDubboSv;
import com.ai.paas.ipaas.user.manage.rest.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.JSonUtil;
import com.ai.paas.ipaas.vo.user.ProdProductVo;
import com.ai.paas.ipaas.vo.user.ResponseHeader;
import com.ai.paas.ipaas.vo.user.SelectWithNoPageRequest;
import com.ai.paas.ipaas.vo.user.SelectWithNoPageResponse;
import com.ai.paas.ipaas.vo.user.UserProdInstVo;
import com.alibaba.dubbo.config.annotation.Reference;

/**
 * Ses用户控制台* 
 * @author mapl
 * 
 */
@RequestMapping(value = "/sesConsole")
@Controller
public class UserSesConsoleController {
	private static final Logger logger = LogManager
			.getLogger(UserSesConsoleController.class.getName());
	
	@Reference
	private IDssConsoleDubboSv dssConsoleDubboSv;
	
	@Reference
	private IProdProductDubboSv prodProductDubboSv;

	@Reference
	private ISysParamDubbo iSysParam;
	
	@Reference
	private ISesConsoleDubboSv sesConsoleDubboSvImpl;
	
	@RequestMapping(value = "/toSesConsole")
	public String toManageConsole(HttpServletRequest req,
			HttpServletResponse resp) {
		SelectWithNoPageResponse<ProdProductVo> prodProductVoresponse = null;
		SelectWithNoPageRequest<ProdProductVo> prodProductVoRequest = new SelectWithNoPageRequest<ProdProductVo>();
		ProdProductVo  prodProductVo = new ProdProductVo();
		short prodId = Short.parseShort(Constants.serviceType.SES_CENTER);
		prodProductVo.setProdId(prodId);
		prodProductVoRequest.setSelectRequestVo(prodProductVo);
		try {
			prodProductVoresponse = prodProductDubboSv.selectProduct(prodProductVoRequest);
		} catch (PaasException e) {
			e.printStackTrace();
		}
		prodProductVo = prodProductVoresponse.getResultList().get(0);
		req.setAttribute("prodName", prodProductVo.getProdName());
		return "console/ses/sesConsole";
	}
	
	/**
	 * Ses列表查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/querySesList")
	@ResponseBody
	public Map<String, Object> querySesList(HttpServletRequest req,
			HttpServletResponse resp) {

		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageResponse<UserProdInstVo> response = null;
		try {
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			
			UserProdInstVo vo = new UserProdInstVo();
			vo.setUserId(userVo.getUserId()); // 用户Id
			String prodId = String.valueOf(Constants.serviceType.SES_CENTER);
			vo.setUserServiceId(prodId);
			selectWithNoPageRequest.setSelectRequestVo(vo);
			
			//TODO: 2016-12-13
//			response = atsConsoleDubboSv.selectUserProdInsts(selectWithNoPageRequest);
			
			String resultCode = response.getResponseHeader().getResultCode();
			List<UserProdInstVo> resultList = response.getResultList();
			UserProdInstVo userProdInstVo = null;
			if (resultList != null && resultList.size() > 0) {
				for (int i = 0; i < resultList.size(); i++) {
					 userProdInstVo = resultList.get(i);
					 Map<String,String> jsonMap = JSonUtil.fromJSon(userProdInstVo.getUserServParam(),Map.class);
					 if(Boolean.parseBoolean(jsonMap.get("isNeedDistributeTrans"))){
						 jsonMap.put("isNeedDistributeTrans", "是");
					 }else{
						 jsonMap.put("isNeedDistributeTrans", "否");
					 }
					 userProdInstVo.setUserServParamMap(jsonMap);
				}
			}
			
	        
			result.put("resultCode", resultCode);
			result.put("resultMessage", response.getResponseHeader().getResultMessage());
			result.put("resultList", resultList);
			
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询出现异常！");
			logger.error(e);

		}
		return result;
	}	
	
	/**
	 * Ses修改服务密码
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping(value = "/toModifySesServPwd")
	public String toModifySesServPwd(HttpServletRequest req,HttpServletResponse resp) {
		SelectWithNoPageResponse<UserProdInstVo> response = null;
		String userServId = req.getParameter("userServId"); 
		String parentUrl = req.getParameter("parentUrl"); 
		req.setAttribute("parentUrl",parentUrl);
		String productType = req.getParameter("productType"); 
		req.setAttribute("productType",productType);
		try {
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo vo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			vo.setUserServId(Long.parseLong(userServId));
			selectWithNoPageRequest.setSelectRequestVo(vo);
			
			//TODO: 2016-12-13
//			response = atsConsoleDubboSv.selectUserProdInstById(selectWithNoPageRequest);	
			
			if(Constants.OPERATE_CODE_SUCCESS.equals(response.getResponseHeader().getResultCode())){
				UserProdInstVo userProdInstVo = response.getResultList().get(0);
				 Map<String,String> jsonMap = JSonUtil.fromJSon(userProdInstVo.getUserServParam(),Map.class);
				 if(Boolean.parseBoolean(jsonMap.get("isNeedDistributeTrans"))){
					 jsonMap.put("isNeedDistributeTrans", "是");
				 }else{
					 jsonMap.put("isNeedDistributeTrans", "否");
				 }
				 userProdInstVo.setUserServParamMap(jsonMap);
				req.setAttribute("userProdInstVo",userProdInstVo);	
				HttpSession session = req.getSession();
				long timeStamp = System.currentTimeMillis();
				session.setAttribute(String.valueOf(timeStamp), response.getResultList().get(0));
				req.setAttribute("timeStamp", String.valueOf(timeStamp));
			}	
			
		} catch (Exception e) {
			logger.error(e.getMessage(),e);

		}
		return "console/ses/sesModifyServPwd";
	}
	@RequestMapping("/startService")
	public @ResponseBody String startService(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		String userServId=request.getParameter("userServId");
		UserProdInstVo vo=new UserProdInstVo();
		UserInfoVo infoVo=UserUtil.getUserSession(request.getSession());
		vo.setUserId(infoVo.getUserId());
		vo.setUserServId(Long.parseLong(userServId));
		ResponseHeader responseHeader=sesConsoleDubboSvImpl.startService(vo);
		if(responseHeader==null||responseHeader.getResultCode().equals("")||responseHeader.getResultCode()==null){
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			return result.toString();
		}
		result.put("resultCode", responseHeader.getResultCode());
		result.put("resultMsg",responseHeader.getResultMessage());
		return result.toString();
		
	}
	@RequestMapping("/stopService")
	public @ResponseBody String stopService(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		String userServId=request.getParameter("userServId");
		UserProdInstVo vo=new UserProdInstVo();
		UserInfoVo infoVo=UserUtil.getUserSession(request.getSession());
		vo.setUserId(infoVo.getUserId());
		vo.setUserServId(Long.parseLong(userServId));
		ResponseHeader responseHeader=sesConsoleDubboSvImpl.stopService(vo);
		if(responseHeader==null||responseHeader.getResultCode()==null||responseHeader.getResultCode().equals("")){
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			return result.toString();
		}
		result.put("resultCode", responseHeader.getResultCode());
		result.put("resultMsg",responseHeader.getResultMessage());
		return result.toString();
		
	}
	@RequestMapping("/cancleService")
	public @ResponseBody String cancleService(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		String userServId=request.getParameter("userServId");
		UserProdInstVo vo=new UserProdInstVo();
		UserInfoVo infoVo=UserUtil.getUserSession(request.getSession());
		vo.setUserId(infoVo.getUserId());
		vo.setUserServId(Long.parseLong(userServId));
		ResponseHeader responseHeader=sesConsoleDubboSvImpl.cancleService(vo);
		if(responseHeader==null||responseHeader.getResultCode()==null||responseHeader.getResultCode().equals("")){
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			return result.toString();
		}
		result.put("resultCode", responseHeader.getResultCode());
		result.put("resultMsg",responseHeader.getResultMessage());
		return result.toString();
		
	}
	
	
	
	
	
}
