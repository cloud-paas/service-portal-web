package com.ai.paas.ipaas.console.dbs;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.cache.CacheUtils;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IAtsConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.IDssConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.IProdProductDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.ProdProductVo;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageRequest;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageResponse;
import com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.JSonUtil;
import com.alibaba.dubbo.config.annotation.Reference;

/**
 * Dbs用户控制台* 
 * @author mapl
 * 
 */

@RequestMapping(value = "/dbsConsole")
@Controller
public class UserDbsConsoleController {

	private static final Logger logger = LogManager
			.getLogger(UserDbsConsoleController.class.getName());

	@Reference
	private IDssConsoleDubboSv dssConsoleDubboSv;
	
	@Reference
	private IAtsConsoleDubboSv atsConsoleDubboSv;
	
	@Reference
	private IProdProductDubboSv prodProductDubboSv;

	@Reference
	private ISysParamDubbo iSysParam;
	
	@RequestMapping(value = "/toDbsConsole")
	public String toManageConsole(HttpServletRequest req,
			HttpServletResponse resp) {
		SelectWithNoPageResponse<ProdProductVo> prodProductVoresponse = null;
		SelectWithNoPageRequest<ProdProductVo> prodProductVoRequest = new SelectWithNoPageRequest<ProdProductVo>();
		ProdProductVo  prodProductVo = new ProdProductVo();
		short prodId = Constants.serviceType.DBS_CENTER;
		prodProductVo.setProdId(prodId);
		prodProductVoRequest.setSelectRequestVo(prodProductVo);
		try {
			prodProductVoresponse = prodProductDubboSv.selectProduct(prodProductVoRequest);
		} catch (PaasException e) {
			e.printStackTrace();
		}
		prodProductVo = prodProductVoresponse.getResultList().get(0);
		req.setAttribute("prodName", prodProductVo.getProdName());
		return "console/dbs/dbsConsole";
	}

	/**
	 * Dbs列表查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryDbsList")
	@ResponseBody
	public Map<String, Object> queryDbsList(HttpServletRequest req,
			HttpServletResponse resp) {

		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageResponse<UserProdInstVo> response = null;
		try {
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo vo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			String prodId = String.valueOf(Constants.serviceType.DBS_CENTER);
			vo.setUserServiceId(prodId);
			selectWithNoPageRequest.setSelectRequestVo(vo);
			response = atsConsoleDubboSv.selectUserProdInsts(selectWithNoPageRequest);
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
								
	        String muiUrl = CacheUtils.getOptionByKey("IPAAS-MUI.SERVICE","IP_PORT_SERVICE");
			result.put("resultCode", resultCode);
			result.put("resultMessage", response.getResponseHeader().getResultMessage());
			result.put("resultList", resultList);
			result.put("muiUrl", muiUrl);
			
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询出现异常！");
			logger.error(e);

		}

		return result;
	}	
	
	
	@RequestMapping(value = "/toModifyDbsServPwd")
	public String toModifyDbsServPwd(HttpServletRequest req,HttpServletResponse resp) {
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
			response = atsConsoleDubboSv.selectUserProdInstById(selectWithNoPageRequest);		
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
		return "console/dbs/dbsModifyServPwd";
	}
	


}
