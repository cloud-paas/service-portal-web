package com.ai.paas.ipaas.console.txs;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IAtsConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.IDssConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.IProdProductDubboSv;
import com.ai.paas.ipaas.user.dubbo.vo.ProdProductVo;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageRequest;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageResponse;
import com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.alibaba.dubbo.config.annotation.Reference;

/**
 * Txs用户控制台* 
 * @author mapl
 * 
 */

@RequestMapping(value = "/txsConsole")
@Controller
public class UserTxsConsoleController {

	private static final Logger logger = LogManager
			.getLogger(UserTxsConsoleController.class.getName());

	@Reference
	private IDssConsoleDubboSv dssConsoleDubboSv;
	
	@Reference
	private IAtsConsoleDubboSv atsConsoleDubboSv;
	
	@Reference
	private IProdProductDubboSv prodProductDubboSv;

	@RequestMapping(value = "/toTxsConsole")
	public String toManageConsole(HttpServletRequest req,
			HttpServletResponse resp) {
		SelectWithNoPageResponse<ProdProductVo> prodProductVoresponse = null;
		SelectWithNoPageRequest<ProdProductVo> prodProductVoRequest = new SelectWithNoPageRequest<ProdProductVo>();
		ProdProductVo  prodProductVo = new ProdProductVo();
		short prodId = Constants.serviceType.TRANS_CENTER;
		prodProductVo.setProdId(prodId);
		prodProductVoRequest.setSelectRequestVo(prodProductVo);
		try {
			prodProductVoresponse = prodProductDubboSv.selectProduct(prodProductVoRequest);
		} catch (PaasException e) {
			e.printStackTrace();
		}
		prodProductVo = prodProductVoresponse.getResultList().get(0);
		req.setAttribute("prodName", prodProductVo.getProdName());
		return "console/txs/txsConsole";
	}

	/**
	 * Txs列表查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryTxsList")
	@ResponseBody
	public Map<String, Object> queryTxsList(HttpServletRequest req,
			HttpServletResponse resp) {

		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageResponse<UserProdInstVo> response = null;
		try {
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo vo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			String prodId = String.valueOf(Constants.serviceType.TRANS_CENTER);
			vo.setUserServiceId(prodId);
			selectWithNoPageRequest.setSelectRequestVo(vo);
			response = atsConsoleDubboSv.selectUserProdInsts(selectWithNoPageRequest);
			result.put("resultCode", Constants.OPERATE_CODE_SUCCESS);
			result.put("resultList", new ArrayList<UserProdInstVo>());
			
			result.put("resultCode", response.getResponseHeader().getResultCode());
			result.put("resultMessage", response.getResponseHeader().getResultMessage());
			result.put("resultList", response.getResultList());			
			
			
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询出现异常！");
			logger.error(e);

		}

		return result;
	}	
	
	
	@RequestMapping(value = "/toModifyTxsServPwd")
	public String toModifyTxsServPwd(HttpServletRequest req,HttpServletResponse resp) {
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
				req.setAttribute("userProdInstVo",response.getResultList().get(0));	
				HttpSession session = req.getSession();
				long timeStamp = System.currentTimeMillis();
				session.setAttribute(String.valueOf(timeStamp), response.getResultList().get(0));
				req.setAttribute("timeStamp", String.valueOf(timeStamp));
			}	
			
		} catch (Exception e) {
			logger.error(e.getMessage(),e);

		}
		return "console/txs/txsModifyServPwd";
	}

}
