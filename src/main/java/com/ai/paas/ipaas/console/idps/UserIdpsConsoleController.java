package com.ai.paas.ipaas.console.idps;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IIdpsConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.IProdProductDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.ProdProductVo;
import com.ai.paas.ipaas.user.dubbo.vo.ResponseHeader;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageRequest;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageResponse;
import com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.alibaba.dubbo.config.annotation.Reference;

/**
 * DSS用户控制台
 */
@RequestMapping(value = "/idpsConsole")
@Controller
public class UserIdpsConsoleController {
	private static final Logger logger = LogManager
			.getLogger(UserIdpsConsoleController.class.getName());
	
	@Reference
	private ISysParamDubbo iSysParam;

	@Reference
	private IProdProductDubboSv prodProductDubboSv;

	@Reference
	private IIdpsConsoleDubboSv idpsConsoleDubboSv;

	@RequestMapping(value = "/consoleIndex")
	public String consoleIndex(HttpServletRequest req, HttpServletResponse resp) {
		return "console/dss/index";
	}

	@RequestMapping(value = "/toIdpsConsole")
	public String toManageConsole(HttpServletRequest req,
			HttpServletResponse resp) {
		String indexFlag = req.getParameter("indexFlag");
		req.setAttribute("indexFlag", indexFlag);
		Map<String, Object> result = new HashMap<String, Object>();
		try {
			SelectWithNoPageResponse<ProdProductVo> prodProductVoresponse = null;
			SelectWithNoPageRequest<ProdProductVo> prodProductVoRequest = new SelectWithNoPageRequest<ProdProductVo>();
			ProdProductVo prodProductVo = new ProdProductVo();
			short prodId = Constants.serviceType.IDPS_CENTER;
			prodProductVo.setProdId(prodId);
			prodProductVoRequest.setSelectRequestVo(prodProductVo);
			prodProductVoresponse = prodProductDubboSv
					.selectProduct(prodProductVoRequest);
			prodProductVo = prodProductVoresponse.getResultList().get(0);
			req.setAttribute("prodName", prodProductVo.getProdName());
		} catch (Exception e) {
			logger.error(e);
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询出现异常！");
		}
		return "console/idps/idpsConsole";
	}

	/**
	 * Idps列表查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryIdpsList")
	@ResponseBody
	public Map<String, Object> queryIdpsList(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageResponse<UserProdInstVo> response = null;
		try {
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo vo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			String prodId = String.valueOf(Constants.serviceType.IDPS_CENTER);
			vo.setUserServiceId(prodId);
			selectWithNoPageRequest.setSelectRequestVo(vo);
			response = idpsConsoleDubboSv
					.selectUserProdInsts(selectWithNoPageRequest);

			result.put("resultCode", response.getResponseHeader()
					.getResultCode());
			result.put("resultMessage", response.getResponseHeader()
					.getResultMessage());
			result.put("resultList", response.getResultList());

		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询出现异常！");
			logger.error(e);
		}

		return result;
	}

	/**
	 *   启用容器
	 */
	@ResponseBody
	@RequestMapping(value = "/startIdpsContainer")
	public Map<String, Object> startIdpsContainer(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String prodBackPara = request.getParameter("prodBackPara");
		try {
			//调用----portal_bandend----启用容器
			ResponseHeader responseHeader = idpsConsoleDubboSv.startIdpsContainer(prodBackPara);
			logger.info("======== apply audit end，apply result："+ responseHeader.getResultCode());
			resultMap.put("resultCode", responseHeader.getResultCode());
			resultMap.put("resultMessage", responseHeader.getResultMessage());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			resultMap.put("resultCode", Constants.OPERATE_CODE_FAIL);
			resultMap.put("resultMessage", "系统异常，请联系管理员!");
		}
		return resultMap;
	}
	
	/**
	 *   停用用容器
	 */
	@ResponseBody
	@RequestMapping(value = "/stopIdpsContainer")
	public Map<String, Object> stopIdpsContainer(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String prodBackPara = request.getParameter("prodBackPara");
		try {
			//调用----portal_bandend----停用容器
			ResponseHeader responseHeader =  idpsConsoleDubboSv.stopIdpsContainer(prodBackPara);
			logger.info("======== apply audit end，apply result："+ responseHeader.getResultCode());
			resultMap.put("resultCode", responseHeader.getResultCode());
			resultMap.put("resultMessage", responseHeader.getResultMessage());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			resultMap.put("resultCode", Constants.OPERATE_CODE_FAIL);
			resultMap.put("resultMessage", "系统异常，请联系管理员!");
		}
		return resultMap;
	}
	
	/**
	 *   升级容器
	 */
	@ResponseBody
	@RequestMapping(value = "/upgradleContainer")
	public Map<String, Object> upgradleContainer(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String prodBackPara = request.getParameter("prodBackPara");
		try {
			//调用----portal_bandend----启用容器
			ResponseHeader responseHeader = idpsConsoleDubboSv.upgradeContainer(prodBackPara);
			logger.info("======== apply audit end，apply result："+ responseHeader.getResultCode());
			resultMap.put("resultCode", responseHeader.getResultCode());
			resultMap.put("resultMessage", responseHeader.getResultMessage());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			resultMap.put("resultCode", Constants.OPERATE_CODE_FAIL);
			resultMap.put("resultMessage", "系统异常，请联系管理员!");
		}
		return resultMap;
	}
	
	/**
	 *   注销容器
	 */
	@ResponseBody
	@RequestMapping(value = "/destroyContainer")
	public Map<String, Object> destroyContainer(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String prodBackPara = request.getParameter("prodBackPara");
		String userServId = request.getParameter("userServId");
		prodBackPara = prodBackPara.substring(0, prodBackPara.length()-1)+",userServId:"+userServId+"}";
		try {
			//调用----portal_bandend----注销容器
			ResponseHeader responseHeader = idpsConsoleDubboSv.destroyContainer(prodBackPara);
			logger.info("======== 注销容器，apply result："+ responseHeader.getResultCode());
			resultMap.put("resultCode", responseHeader.getResultCode());
			resultMap.put("resultMessage", responseHeader.getResultMessage());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			resultMap.put("resultCode", Constants.OPERATE_CODE_FAIL);
			resultMap.put("resultMessage", "系统异常，请联系管理员!");
		}
		return resultMap;
	}
	
}
