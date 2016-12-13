package com.ai.paas.ipaas.console.rds;

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
import com.ai.paas.ipaas.user.manage.rest.interfaces.IProdProductDubboSv;
import com.ai.paas.ipaas.user.manage.rest.interfaces.IRdsConsoleDubboSv;
import com.ai.paas.ipaas.user.manage.rest.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.vo.user.ProdProductVo;
import com.ai.paas.ipaas.vo.user.ResponseHeader;
import com.ai.paas.ipaas.vo.user.SelectWithNoPageRequest;
import com.ai.paas.ipaas.vo.user.SelectWithNoPageResponse;
import com.ai.paas.ipaas.vo.user.SysParamVo;
import com.ai.paas.ipaas.vo.user.SysParmRequest;
import com.ai.paas.ipaas.vo.user.UserProdInstVo;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;

/**
 * RDS用户控制台
 */
@RequestMapping(value = "/rdsConsole")
@Controller
public class UserRdsConsoleController {
	private static final Logger logger = LogManager
			.getLogger(UserRdsConsoleController.class.getName());
	
	@Reference
	private ISysParamDubbo iSysParam;

	@Reference
	private IProdProductDubboSv prodProductDubboSv;

	@Reference
	private IRdsConsoleDubboSv rdsConsoleDubboSv;

	@RequestMapping(value = "/consoleIndex")
	public String consoleIndex(HttpServletRequest req, HttpServletResponse resp) {
		return "console/dss/index";
	}

	@RequestMapping(value = "/toRdsConsole")
	public String toManageConsole(HttpServletRequest req,
			HttpServletResponse resp) {
		String indexFlag = req.getParameter("indexFlag");
		req.setAttribute("indexFlag", indexFlag);
		Map<String, Object> result = new HashMap<String, Object>();
		SysParmRequest sysParmRequest = new SysParmRequest();
		sysParmRequest.setTypeCode(Constants.serviceName.RDS);
		sysParmRequest.setParamCode(Constants.paramCode.OPTIONS);
		List<SysParamVo> rdsManageUrl;
		try {
			SelectWithNoPageResponse<ProdProductVo> prodProductVoresponse = null;
			SelectWithNoPageRequest<ProdProductVo> prodProductVoRequest = new SelectWithNoPageRequest<ProdProductVo>();
			ProdProductVo prodProductVo = new ProdProductVo();
			short prodId = Constants.serviceType.RDS_CENTER;
			prodProductVo.setProdId(prodId);
			prodProductVoRequest.setSelectRequestVo(prodProductVo);
			prodProductVoresponse = prodProductDubboSv
					.selectProduct(prodProductVoRequest);
			prodProductVo = prodProductVoresponse.getResultList().get(0);
			req.setAttribute("prodName", prodProductVo.getProdName());
			rdsManageUrl = iSysParam.getSysParams(sysParmRequest);
			if (rdsManageUrl!=null && rdsManageUrl.size()>0) {
				 req.setAttribute("rdsManageUrl", rdsManageUrl.get(0).getServiceOption());
				System.out.println("rdsManageUrl: "+rdsManageUrl.get(0).getServiceOption());
			 } 
		} catch (Exception e) {
			logger.error(e);
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询出现异常！");
		}
		return "console/rds/rdsConsole";
	}

	/**
	 * RDS列表查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryRdsList")
	@ResponseBody
	public Map<String, Object> queryRdsList(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageResponse<UserProdInstVo> response = null;
		try {
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo vo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			String prodId = String.valueOf(Constants.serviceType.RDS_CENTER);
			vo.setUserServiceId(prodId);
			selectWithNoPageRequest.setSelectRequestVo(vo);
			response = rdsConsoleDubboSv
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
	 * 根据条件，查看RDS列表
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryRdsListById")
	public String queryRdsListById(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageResponse<UserProdInstVo> response = null;
		try {
			String userServId = req.getParameter("userServId");
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo vo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			String prodId = String.valueOf(Constants.serviceType.RDS_CENTER);
			vo.setUserServiceId(prodId);
			vo.setUserServId(Long.parseLong(userServId));
			selectWithNoPageRequest.setSelectRequestVo(vo);
			response = rdsConsoleDubboSv
					.selectUserProdInstById(selectWithNoPageRequest);
			if(Constants.OPERATE_CODE_SUCCESS.equals(response.getResponseHeader().getResultCode())){
				UserProdInstVo prodVo = response.getResultList().get(0);
				String str = prodVo.getUserServParam();
				Map<String , String > map = new HashMap<String,String>();
				map = new Gson().fromJson(str, map.getClass());
				prodVo.setUserServParamMap(map);
				req.setAttribute("userProdInstVo",prodVo);	
			}	

		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询出现异常！");
			logger.error(e);
		}

		return "console/rds/rdsDetail";
	}

	/**
	 *   启用RDS
	 */
	@ResponseBody
	@RequestMapping(value = "/startRdsContainer")
	public Map<String, Object> startRDSContainer(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String prodBackPara = request.getParameter("prodBackPara");
		try {
			//调用----portal_bandend----启用RDS
			ResponseHeader responseHeader = rdsConsoleDubboSv.startRdsContainer(prodBackPara);
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
	 *   停用用RDS
	 */
	@ResponseBody
	@RequestMapping(value = "/stopRDSContainer")
	public Map<String, Object> stopRdsContainer(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String prodBackPara = request.getParameter("prodBackPara");
		try {
			//调用----portal_bandend----停用RDS
			ResponseHeader responseHeader =  rdsConsoleDubboSv.stopRdsContainer(prodBackPara);
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
	 *   注销RDS
	 */
	@ResponseBody
	@RequestMapping(value = "/destroyContainer")
	public Map<String, Object> destroyContainer(HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		String prodBackPara = request.getParameter("prodBackPara");
		String userServId = request.getParameter("userServId");
		String prodBackParaVal = "{\"prodBackPara\":"+"\""+prodBackPara+"\""+",\"userServId\":"+"\""+userServId+"\""+"}";
		try {
			//调用----portal_bandend----注销RDS
			ResponseHeader responseHeader = rdsConsoleDubboSv.destroyContainer(prodBackParaVal);
			logger.info("======== 注销RDS，apply result："+ responseHeader.getResultCode());
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
