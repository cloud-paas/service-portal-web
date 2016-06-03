package com.ai.paas.ipaas.console.dss;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IDssConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.IProdProductDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.DocumentVo;
import com.ai.paas.ipaas.user.dubbo.vo.ProdMenuVo;
import com.ai.paas.ipaas.user.dubbo.vo.ProdProductVo;
import com.ai.paas.ipaas.user.dubbo.vo.ResponseHeader;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageRequest;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageResponse;
import com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.CiperUtil;
import com.ai.paas.ipaas.util.JSonUtil;
import com.ai.paas.ipaas.zookeeper.SystemConfigHandler;
import com.alibaba.dubbo.config.annotation.Reference;

/**
 * DSS用户控制台
 * @author mapl
 */
@RequestMapping(value = "/dssConsole")
@Controller
public class UserDssConsoleController {
	private static final Logger logger = LogManager
			.getLogger(UserDssConsoleController.class.getName());
	
	String portalDubboUrl = SystemConfigHandler.configMap.get("CONTROLLER.CONTROLLER.url");
	
	String capacity_1024 = SystemConfigHandler.configMap.get("DSS.capacity.1024");
	
	String capacity_1536 = SystemConfigHandler.configMap.get("DSS.capacity.1536");
	
	String capacity_2048 = SystemConfigHandler.configMap.get("DSS.capacity.2048");
	
	String capacity_512 = SystemConfigHandler.configMap.get("DSS.capacity.512");
			
	String singleFile_1 = SystemConfigHandler.configMap.get("DSS.singleFileSize.1");
	
	String singleFile_5 = SystemConfigHandler.configMap.get("DSS.singleFileSize.5");
	
	String singleFile_10 = SystemConfigHandler.configMap.get("DSS.singleFileSize.10");
	
	String singleFile_20 = SystemConfigHandler.configMap.get("DSS.singleFileSize.20");
	
	@Reference
	private ISysParamDubbo iSysParam;

	@Reference
	private IDssConsoleDubboSv dssConsoleDubboSv;
	
	@Reference
	private IProdProductDubboSv prodProductDubboSv;
	
	@RequestMapping(value = "/toConsole")
	@ResponseBody
	public ModelAndView toConsole(HttpServletRequest req,
			HttpServletResponse resp) {

		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageResponse<ProdMenuVo> response = null;
		ProdMenuVo prodMenuVo = null;
		try {
			SelectWithNoPageRequest<ProdMenuVo> selectWithNoPageRequest = new SelectWithNoPageRequest<ProdMenuVo>();
			ProdMenuVo vo = new ProdMenuVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			selectWithNoPageRequest.setSelectRequestVo(vo);
			response = dssConsoleDubboSv.queryLeftMenuList(selectWithNoPageRequest);
			if(null == response.getResultList() || 0==response.getResultList().size()){
				return new ModelAndView("redirect:/dssConsole/consoleIndex");
			}			
			prodMenuVo  = 	response.getResultList().get(0);		
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询出现异常！");
		}
		
		return new ModelAndView("redirect:"+prodMenuVo.getConsoleUrl());
	}
	
	@RequestMapping(value = "/consoleIndex")
	public String consoleIndex(HttpServletRequest req,
			HttpServletResponse resp) {
		return "console/dss/index";
	}

	@RequestMapping(value = "/toDssConsole")
	public String toManageConsole(HttpServletRequest req,
			HttpServletResponse resp) {
		String indexFlag=req.getParameter("indexFlag");
		req.setAttribute("indexFlag", indexFlag);
		Map<String, Object> result = new HashMap<String, Object>();		
		try {
			SelectWithNoPageResponse<ProdProductVo> prodProductVoresponse = null;
			SelectWithNoPageRequest<ProdProductVo> prodProductVoRequest = new SelectWithNoPageRequest<ProdProductVo>();
			ProdProductVo  prodProductVo = new ProdProductVo();
			short prodId = Constants.serviceType.DBCENTER_CENTER;
			prodProductVo.setProdId(prodId);
			prodProductVoRequest.setSelectRequestVo(prodProductVo);
			prodProductVoresponse = prodProductDubboSv.selectProduct(prodProductVoRequest);
			prodProductVo = prodProductVoresponse.getResultList().get(0);
			req.setAttribute("prodName", prodProductVo.getProdName());
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询出现异常！");
			logger.error(e);

		}
		
		return "console/dss/dssConsole";
	}

	/**
	 * DSS列表查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryDssList")
	@ResponseBody
	public Map<String, Object> queryDssList(HttpServletRequest req,
			HttpServletResponse resp) {

		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageResponse<UserProdInstVo> response = null;
		try {
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo vo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			String prodId = String.valueOf(Constants.serviceType.DBCENTER_CENTER);
			vo.setUserServiceId(prodId);
			selectWithNoPageRequest.setSelectRequestVo(vo);
			
			response = dssConsoleDubboSv.selectUserProdInsts(selectWithNoPageRequest);
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

	/**
	 * DSS注销
	 * 
	 * @return
	 */
	@RequestMapping(value = "/cancleDss")
	@ResponseBody
	public Map<String, Object> cancleDss(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		String userServId=req.getParameter("userServId");
		UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
		ResponseHeader responseHeader = new ResponseHeader();
		UserProdInstVo vo = new UserProdInstVo();
		vo.setUserId(userVo.getUserId());
		vo.setUserServId(Long.parseLong(userServId));;
		try {
			responseHeader = dssConsoleDubboSv.cancleUserProdInst(vo);
			result.put("resultCode", responseHeader.getResultCode());
			result.put("resultMessage", responseHeader.getResultCode());
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "注销异常！");
			logger.error(e.getMessage(),e);
		}
		
		return result;
	}

	/**
	 * DSS格式化
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping(value = "/formatDss")
	@ResponseBody
	public Map<String, Object> formatDss(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		String userServId=req.getParameter("userServId");
		UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
		ResponseHeader responseHeader = new ResponseHeader();
		UserProdInstVo vo = new UserProdInstVo();
		vo.setUserId(userVo.getUserId());
		vo.setUserServId(Long.parseLong(userServId));;
		try {
			responseHeader = dssConsoleDubboSv.fullClear(vo);
			result.put("resultCode", responseHeader.getResultCode());
			result.put("resultMessage", responseHeader.getResultCode());
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "格式化失败！");
			logger.error(e.getMessage(),e);
		}
		
		return result;
	}
	
	/**
	 * 根据userServId 查询用户产品实例 
	 * @return
	 */
	@RequestMapping(value = "/queryDssInstById")	
	public String queryDssInstById(HttpServletRequest req,
			HttpServletResponse resp) {

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
			response = dssConsoleDubboSv.selectDssById(selectWithNoPageRequest);		
			if(Constants.OPERATE_CODE_SUCCESS.equals(response.getResponseHeader().getResultCode())){
				req.setAttribute("userProdInstVo",response.getResultList().get(0));	
			}	
			
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
		}

		return "console/dss/dssDetail";
	}
	
	/**
	 * 
	 * 根据key，在dss中查询文档上传记录
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping(value = "/selectDocumentByKey")
	@ResponseBody
	public Map<String, Object> selectDocumentByKey(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		String userServId=req.getParameter("userServId");
		String key=req.getParameter("key");
		UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
		UserProdInstVo userProdInstVo = new UserProdInstVo();
		userProdInstVo.setUserId(userVo.getUserId());
		userProdInstVo.setUserServId(Long.parseLong(userServId));
		userProdInstVo.setKey(key);
		SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
		SelectWithNoPageResponse<DocumentVo> selectWithNoPageResponse = null;
		selectWithNoPageRequest.setSelectRequestVo(userProdInstVo);
		try {
			// 格式化
			selectWithNoPageResponse = dssConsoleDubboSv.selectDocumentByKey(selectWithNoPageRequest);
			result.put("resultCode", selectWithNoPageResponse.getResponseHeader().getResultCode());
			result.put("resultMessage", selectWithNoPageResponse.getResponseHeader().getResultMessage());
			if(Constants.OPERATE_CODE_SUCCESS.equals(selectWithNoPageResponse.getResponseHeader().getResultCode())){
				result.put("documentVo", selectWithNoPageResponse.getResultList().get(0));
			}
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询文档上传记录失败！");
			logger.error(e.getMessage(),e);
		}
		
		return result;
	}
	
	/**
	 * 
	 * 根据key，在dss中删除文档
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping(value = "/clearDocumentByKey")
	@ResponseBody
	public Map<String, Object> clearDocumentByKey(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		String userServId=req.getParameter("userServId");
		String key=req.getParameter("key");
		UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
		UserProdInstVo userProdInstVo = new UserProdInstVo();
		userProdInstVo.setUserId(userVo.getUserId());
		userProdInstVo.setUserServId(Long.parseLong(userServId));
		userProdInstVo.setKey(key);
		ResponseHeader responseHeader = null;
		try {
			responseHeader = dssConsoleDubboSv.clearDocumentByKey(userProdInstVo);
			result.put("resultCode", responseHeader.getResultCode());
			result.put("resultMessage", responseHeader.getResultMessage());
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "删除文档失败！");
			logger.error(e.getMessage(),e);
		}
		return result;
	}
	
	@RequestMapping(value = "/toModifyDssServPwd")
	public String toModifyDssServPwd(HttpServletRequest req,HttpServletResponse resp) {
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
			response = dssConsoleDubboSv.selectDssById(selectWithNoPageRequest);		
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
		return "console/dss/dssModifyServPwd";
	}
	
	/**
	 * DSS密码修改
	 * 
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping(value = "/modifyDssServPwd")
	@ResponseBody
	public Map<String, Object> modifyDssServPwd(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		String userServId = req.getParameter("userServId"); 
		String newPwd = req.getParameter("newPwd"); 
		String oldPwd = req.getParameter("oldPwd"); 
		newPwd = CiperUtil.encrypt("7331c9b6b1a1d521363f7bca8acb095f", newPwd);
	    oldPwd = CiperUtil.encrypt("7331c9b6b1a1d521363f7bca8acb095f", oldPwd);
		ResponseHeader responseHeader = null;
		try {
			UserProdInstVo userProdInstVo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			userProdInstVo.setUserId(userVo.getUserId()); // 用户Id
			userProdInstVo.setUserServId(Long.parseLong(userServId));
			userProdInstVo.setNewPwd(newPwd);
			userProdInstVo.setOldPwd(oldPwd);
			responseHeader = dssConsoleDubboSv.mdyServPwd(userProdInstVo);
			result.put("resultCode", responseHeader.getResultCode());
			result.put("resultMessage", responseHeader.getResultMessage());
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "服务密码修改失败！");
			logger.error(e.getMessage(),e);
		}
		return result;
	}
	/**
	 * 根据user_id 查询左侧菜单列
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryLeftMenuList")
	@ResponseBody
	public Map<String, Object> queryLeftMenuList(HttpServletRequest req,
			HttpServletResponse resp) {

		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageResponse<ProdMenuVo> response = null;
		try {
			SelectWithNoPageRequest<ProdMenuVo> selectWithNoPageRequest = new SelectWithNoPageRequest<ProdMenuVo>();
			ProdMenuVo vo = new ProdMenuVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			selectWithNoPageRequest.setSelectRequestVo(vo);
			response = dssConsoleDubboSv.queryLeftMenuList(selectWithNoPageRequest);
						
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
	
	@RequestMapping(value = "/modifyDssServPwdSubbess")
	public String modifyDssServPwdSubbess(HttpServletRequest req,HttpServletResponse resp) {
		String parentUrl = req.getParameter("parentUrl"); 
		req.setAttribute("parentUrl",parentUrl);
		String productType = req.getParameter("productType"); 
		req.setAttribute("productType",productType);
		String timeStamp = req.getParameter("timeStamp");
		UserProdInstVo userProdInstVo = (com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo) req.getSession().getAttribute(timeStamp);
		req.setAttribute("userProdInstVo",userProdInstVo);	
		return "console/dss/modifyServPwdSuccess";
	}
	
	@RequestMapping(value="/modifyDetailById")
	public String modifyDetailById(HttpServletRequest req,HttpServletResponse resp){
		SelectWithNoPageResponse<UserProdInstVo> response = null;
		String userServId = req.getParameter("userServId"); 
		List<String> clist = new ArrayList<String>();
		clist.add(capacity_512);
		clist.add(capacity_1024);
		clist.add(capacity_1536);
		clist.add(capacity_2048);
		List<String> slist=new ArrayList<String>();
		slist.add(singleFile_1);
		slist.add(singleFile_5);
		slist.add(singleFile_10);
		slist.add(singleFile_20);
		try {
			SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo vo = new UserProdInstVo();
			UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
			vo.setUserId(userVo.getUserId()); // 用户Id
			vo.setUserServId(Long.parseLong(userServId));
			selectWithNoPageRequest.setSelectRequestVo(vo);
			response = dssConsoleDubboSv.selectDssById(selectWithNoPageRequest);		
			if(Constants.OPERATE_CODE_SUCCESS.equals(response.getResponseHeader().getResultCode())){
				req.setAttribute("userProdInstVo",response.getResultList().get(0));	
				JSONObject object=new JSONObject(response.getResultList().get(0).getUserServParam());
				if(clist!=null&&clist.size()>0){
					 req.setAttribute("capacityList", clist);
					  
				}
				if(slist!=null&&slist.size()>0){
					 req.setAttribute("fileSizeList", slist);
				}
				req.setAttribute("capacity", object.getString("capacity"));
				req.setAttribute("singleFileSize", object.getString("singleFileSize"));
			}	
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		
		return "console/dss/modifyConfiguration";
	}
	
	@RequestMapping(value="/modifyConfiguration",method={RequestMethod.POST})
	public  @ResponseBody Map<String, String> modifyConfiguration(HttpServletRequest request,HttpServletResponse response) throws PaasException, IOException, URISyntaxException{
		Map<String, String> resultinfo=new HashMap<String, String>();
		UserInfoVo userInfoVo=UserUtil.getUserSession(request.getSession());
		Map<String,String> params=new HashMap<String, String>();
		
		params.put("userId", userInfoVo.getUserId());
		params.put("serviceId",request.getParameter("userServIpaasId"));
		params.put("userServId", request.getParameter("userServId"));
		params.put("size", request.getParameter("size"));
		params.put("limitFileSize", request.getParameter("limitFileSize"));
		String data=JSonUtil.toJSon(params);
		String result="";
		String address = portalDubboUrl;
		result=HttpClientUtil.sendPostRequest(address+"/dss/console/modifyConfiguration", data);
		
		JSONObject object=new JSONObject(result);
		resultinfo.put("resultCode", object.getString("resultCode"));
		resultinfo.put("resultMsg", object.getString("resultMsg"));
		return resultinfo;
	}

}
