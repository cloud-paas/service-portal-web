package com.ai.paas.ipaas.console.org;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.constants.Constants.RType;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrgnizeCenterSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrgnizeUserInfoSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.OrgnizeCenterVo;
import com.alibaba.dubbo.config.annotation.Reference;

/**
 * 组织管理控制台* 
 * @author sunhz
 * 
 */
@RequestMapping(value = "/orgConsole")
@Controller
public class OrgCenterController {
	private static final Logger logger = LogManager
			.getLogger(OrgCenterController.class.getName());
	
	@Reference
	private ISysParamDubbo iSysParam;
	
	@Reference
	private IOrgnizeCenterSv OrgcenterSvImpl;
	
	@Reference
	private IOrgnizeUserInfoSv orgUserSv;
	
	@RequestMapping(value = "/toOrgConsole")
	public String toOrgConsole(HttpServletRequest req,
			HttpServletResponse resp) {
		
		return "console/org/orgConsole";
	}
	
	/**
	 * Org列表查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryOrgList")
	@ResponseBody
	public Map<String, Object> queryOrgList(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		List<OrgnizeCenterVo> resultList = new ArrayList<OrgnizeCenterVo>();
		List<OrgnizeCenterVo> invalidList = new ArrayList<OrgnizeCenterVo>();
		try {		
			resultList = OrgcenterSvImpl.getOrgnizeCenterByStatus(RType.STATUS_VALID);//有效的组织
			invalidList = OrgcenterSvImpl.getOrgnizeCenterByStatus(RType.STATUS_INVALID);//无效的组织			
			if (invalidList.size() > 0) {
				for (OrgnizeCenterVo vo : invalidList) {
					resultList.add(vo);
				}
			}
     		result.put("resultCode", Constants.OPERATE_CODE_SUCCESS);
			result.put("resultMessage", "查询成功");
			result.put("resultList", resultList);
			
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "查询出现异常！");
			logger.error(e);
		}
		return result;
	}	
	
	/**
	 * 修改組織
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping(value = "/toModifyOrg")
	public String toModifyOrgServPwd(HttpServletRequest req,HttpServletResponse resp) {
		String orgId = req.getParameter("orgId"); 
		String parentUrl = req.getParameter("parentUrl"); 
		req.setAttribute("parentUrl",parentUrl);;
		try {
			OrgnizeCenterVo orgnizeCenterVo = new OrgnizeCenterVo();
			orgnizeCenterVo = OrgcenterSvImpl.getOrgnizeCenterById(Integer.valueOf(orgId));		
			req.setAttribute("orgnizeCenterVo", orgnizeCenterVo);
		} catch (Exception e) {
			logger.error(e.getMessage(),e);
		}
		return "console/org/orgModify";
	}
	
	@RequestMapping("/addOrgnize")
	@ResponseBody
	public String addOrgnize(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		OrgnizeCenterVo vo = new OrgnizeCenterVo();
		vo.setOrgCode(request.getParameter("orgCode"));
		vo.setOrgName(request.getParameter("orgName"));
		vo.setOrgStatus(Integer.valueOf(request.getParameter("orgStatus")));
		int addResult = 0;
		try {
			addResult = OrgcenterSvImpl.insertOrgnizeCenter(vo);
		} catch (PaasException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (addResult > 0) {
			result.put("resultCode", Constants.OPERATE_CODE_SUCCESS);
		} else {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
		}
		return result.toString();	
	}
	
	@RequestMapping("/deleteOrgnize")
	@ResponseBody
	public String deleteOrgnize(HttpServletRequest request,HttpServletResponse response){
		JSONObject result=new JSONObject();
		String orgIdStr=request.getParameter("orgId");
		int orgId = Integer.valueOf(orgIdStr);
		int delResult = 0;
		try {
			if (orgUserSv.getOrgUsrInfoCntByOrgId(orgId) < 1) {
				delResult = OrgcenterSvImpl.deleteOrgnize(orgId);
			} else {
				result.put("resultCode", Constants.OPERATE_CODE_INTERRUPT);
				return result.toString();
			}
			
		} catch (PaasException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (delResult > 0) {
			result.put("resultCode", Constants.OPERATE_CODE_SUCCESS);
		} else {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
		}
		return result.toString();	
	}
	
	@RequestMapping("/updateOrgnize")
	@ResponseBody
	public Map<String, Object> updateOrgnize(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		String orgId = req.getParameter("orgId"); 
		String orgCode = req.getParameter("orgCode"); 
		String orgName = req.getParameter("orgName"); 
		String orgStatus = req.getParameter("orgStatus"); 
		try {
			OrgnizeCenterVo orgnizeCenterVo = new OrgnizeCenterVo();
			orgnizeCenterVo.setOrgId(Integer.valueOf(orgId)); //组织Id
			orgnizeCenterVo.setOrgCode(orgCode);;
			orgnizeCenterVo.setOrgName(orgName);
			orgnizeCenterVo.setOrgStatus(Integer.valueOf(orgStatus));
			int resultCode = OrgcenterSvImpl.updateOrgnizeCenter(orgnizeCenterVo);
			result.put("resultCode", Constants.OPERATE_CODE_SUCCESS);
			result.put("resultMessage", "修改組織成功！");
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "修改組織失败！");
			logger.error(e.getMessage(),e);
		}
		return result;
	}
	
	
	@RequestMapping(value = "/modifyOrgSuccess")
	public String modifyOrgSuccess(HttpServletRequest req,HttpServletResponse resp) {
		String parentUrl = req.getParameter("parentUrl"); 
		req.setAttribute("parentUrl",parentUrl);
		String orgId = req.getParameter("orgId"); 
		req.setAttribute("orgId",orgId);
		String orgCode = req.getParameter("orgCode"); 
		req.setAttribute("orgCode",orgCode);
		return "console/org/modifyOrgSuccess";
	}
}
