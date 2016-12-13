package com.ai.paas.ipaas.console.mcs;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import com.ai.paas.ipaas.user.manage.rest.interfaces.IMcsConsoleDubboSv;
import com.ai.paas.ipaas.user.manage.rest.interfaces.IProdProductDubboSv;
import com.ai.paas.ipaas.user.manage.rest.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.utils.gson.GsonUtil;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.CiperUtil;
import com.ai.paas.ipaas.vo.user.ProdProductVo;
import com.ai.paas.ipaas.vo.user.SelectWithNoPageRequest;
import com.ai.paas.ipaas.vo.user.SelectWithNoPageResponse;
import com.ai.paas.ipaas.vo.user.SysParamVo;
import com.ai.paas.ipaas.vo.user.SysParmRequest;
import com.ai.paas.ipaas.vo.user.UserProdInstVo;
import com.ai.paas.ipaas.vo.user.ResponseHeader;
import com.alibaba.dubbo.config.annotation.Reference;

import net.sf.json.JSONObject;

/**
 * Mcs用户控制台*
 */
@RequestMapping(value = "/mcsConsole")
@Controller
public class UserMcsConsoleController {
	private static final Logger logger = LogManager
			.getLogger(UserMcsConsoleController.class.getName());

	@Reference
	private IMcsConsoleDubboSv mcsConsoleDubboSv;

	@Reference
	private IProdProductDubboSv prodProductDubboSv;

	@Reference
	private ISysParamDubbo iSysParam;

	@RequestMapping(value = "/toMcsConsole")
	public String toManageConsole(HttpServletRequest req) throws Exception {
		SelectWithNoPageResponse<ProdProductVo> prodProductVoresponse = null;
		SelectWithNoPageRequest<ProdProductVo> prodProductVoRequest = new SelectWithNoPageRequest<ProdProductVo>();
		ProdProductVo prodProductVo = new ProdProductVo();
		short prodId = Constants.serviceType.CACHE_CENTER;
		prodProductVo.setProdId(prodId);
		prodProductVoRequest.setSelectRequestVo(prodProductVo);
		prodProductVoresponse = prodProductDubboSv
				.selectProduct(prodProductVoRequest);
		prodProductVo = prodProductVoresponse.getResultList().get(0);
		req.setAttribute("prodName", prodProductVo.getProdName());
		return "console/mcs/cachemgr";
	}

	/**
	 * Mcs列表查询
	 */
	@RequestMapping(value = "/queryMcsList")
	@ResponseBody
	public Map<String, Object> queryMcsList(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageResponse<UserProdInstVo> response = null;
		try {
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo vo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			String prodId = String.valueOf(Constants.serviceType.CACHE_CENTER);
			vo.setUserServiceId(prodId);
			selectWithNoPageRequest.setSelectRequestVo(vo);
			response = mcsConsoleDubboSv
					.selectUserProdInsts(selectWithNoPageRequest);

			result.put("resultCode", response.getResponseHeader()
					.getResultCode());
			result.put("resultMessage", response.getResponseHeader()
					.getResultMessage());
			result.put("resultList", response.getResultList());
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询出现异常：" + e.getMessage());
			logger.error(e.getMessage(), e);
		}
		return result;
	}

	@RequestMapping(value = "/toModifyMcsServPwd")
	public String toModifyMcsServPwd(HttpServletRequest req,
			HttpServletResponse resp) {
		dealWithUsrProdInfo(req);
		return "console/mcs/mcsModifyServPwd";
	}

	@RequestMapping(value = "/toKeyMgr")
	public String toKeyMgr(HttpServletRequest req, HttpServletResponse resp) {
		dealWithUsrProdInfo(req);
		SysParmRequest sysParmRequest = new SysParmRequest();
		sysParmRequest.setTypeCode(Constants.serviceName.MCS);
		sysParmRequest.setParamCode(Constants.paramCode.SELETE_TYPE);
		List<SysParamVo> typelist = iSysParam.getSysParams(sysParmRequest);
		req.setAttribute("typelist", typelist);
		return "console/mcs/keyMgr";
	}

	private UserProdInstVo dealWithUsrProdInfo(HttpServletRequest req) {
		SelectWithNoPageResponse<UserProdInstVo> selectWithNoPageResponse = null;
		String userServId = req.getParameter("userServId");
		UserProdInstVo userProdInstVo = null;
		try {
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo vo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			vo.setUserServId(Long.parseLong(userServId));
			selectWithNoPageRequest.setSelectRequestVo(vo);
			selectWithNoPageResponse = mcsConsoleDubboSv
					.selectMcsById(selectWithNoPageRequest);
			if (Constants.OPERATE_CODE_SUCCESS.equals(selectWithNoPageResponse
					.getResponseHeader().getResultCode())) {
				req.getSession().removeAttribute("userProdInstVo");
				req.getSession().setAttribute("userProdInstVo",
						selectWithNoPageResponse.getResultList().get(0));
				userProdInstVo = selectWithNoPageResponse.getResultList()
						.get(0);
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
		}
		return userProdInstVo;
	}

	/**
	 * Mcs密码修改
	 */
	@RequestMapping(value = "/modifyMcsServPwd")
	@ResponseBody
	public Map<String, Object> modifyMcsServPwd(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		String userServId = req.getParameter("userServId");
		String newPwd = req.getParameter("newPwd");
		newPwd = CiperUtil.encrypt("7331c9b6b1a1d521363f7bca8acb095f", newPwd);
		String oldPwd = req.getParameter("oldPwd");
		oldPwd = CiperUtil.encrypt("7331c9b6b1a1d521363f7bca8acb095f", oldPwd);
		ResponseHeader responseHeader = null;
		try {
			UserProdInstVo userProdInstVo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			userProdInstVo.setUserId(userVo.getUserId()); // 用户Id
			userProdInstVo.setUserServId(Long.parseLong(userServId));
			userProdInstVo.setNewPwd(newPwd);
			userProdInstVo.setOldPwd(oldPwd);
			responseHeader = mcsConsoleDubboSv.mdyServPwd(userProdInstVo);
			result.put("resultCode", responseHeader.getResultCode());
			result.put("resultMessage", responseHeader.getResultMessage());
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "服务密码修改失败：" + e.getMessage());
			logger.error(e.getMessage(), e);
		}
		return result;
	}

	@RequestMapping(value = "/operatServ", produces = { "application/json;charset=UTF-8" })
	public @ResponseBody String operatMcsServer(UserProdInstVo vo) {
		JSONObject result = new JSONObject();
		try {
			ResponseHeader header = mcsConsoleDubboSv.operatMcsServer(vo);
			result = JSONObject.fromObject(header);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", e.getMessage());
		}
		return result.toString();
	}

	@RequestMapping(value = "/modifyMcsServPwdSuccess")
	public String modifyMcsServPwdSuccess(HttpServletRequest req) {
		String parentUrl = req.getParameter("parentUrl");
		req.setAttribute("parentUrl", parentUrl);
		String productType = req.getParameter("productType");
		req.setAttribute("productType", productType);
		UserProdInstVo userProdInstVo = (com.ai.paas.ipaas.vo.user.UserProdInstVo) req
				.getSession().getAttribute("userProdInstVo");
		req.setAttribute("userProdInstVo", userProdInstVo);
		return "console/modifyServPwdSuccess";
	}

	@RequestMapping(value = "/toExpanseCapacity")
	public String toExpanseCapacity(HttpServletRequest req,
			HttpServletResponse resp) {
		UserProdInstVo userProdInstVo = dealWithUsrProdInfo(req);
		String UserServParam = userProdInstVo.getUserServParam();
		@SuppressWarnings("rawtypes")
		Map map = GsonUtil.fromJSon(UserServParam, Map.class);
		String capacity = (String) map.get("capacity");

		SysParmRequest sysParmRequest = new SysParmRequest();
		sysParmRequest.setTypeCode(Constants.serviceName.MCS);
		sysParmRequest.setParamCode(Constants.paramCode.OPTIONS);
		List<SysParamVo> list = iSysParam.getSysParams(sysParmRequest);
		List<SysParamVo> capacityList = new ArrayList<SysParamVo>();
		for (SysParamVo vo : list) {
			if (Integer.parseInt(capacity) < Integer.parseInt(vo
					.getServiceValue())) {
				capacityList.add(vo);
			}
		}
		req.setAttribute("capacityList", capacityList);
		String userServId = req.getParameter("userServId");
		req.setAttribute("userServId", userServId);
		return "console/mcs/toExpanseCapacity";
	}

	@RequestMapping(value = "/expanseCapacitySuccess")
	public String expanseCapacitySuccess(HttpServletRequest req) {
		String parentUrl = req.getParameter("parentUrl");
		req.setAttribute("parentUrl", parentUrl);
		String productType = req.getParameter("productType");
		req.setAttribute("productType", productType);
		UserProdInstVo userProdInstVo = (com.ai.paas.ipaas.vo.user.UserProdInstVo) req
				.getSession().getAttribute("userProdInstVo");
		req.setAttribute("userProdInstVo", userProdInstVo);
		return "console/mcs/expanseCapacitySuccess";
	}

}