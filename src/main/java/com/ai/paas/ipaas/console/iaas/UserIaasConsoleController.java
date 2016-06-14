package com.ai.paas.ipaas.console.iaas;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IaasConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageRequest;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageResponse;
import com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.alibaba.dubbo.config.annotation.Reference;

/**
 * DSS用户控制台
 */
@RequestMapping(value = "/iaasConsole")
@Controller
public class UserIaasConsoleController {
	@Reference
	private IaasConsoleDubboSv iaasConsoleDubboSv;
	
	@RequestMapping(value = "/toIaasPhysicalConsole")
	public String toIaasPhysicalConsole(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		SelectWithNoPageRequest<UserProdInstVo> req = new SelectWithNoPageRequest<UserProdInstVo>();
		UserProdInstVo selectRequestVo = new UserProdInstVo();
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		String userId=userVo.getUserId();
		selectRequestVo.setUserId(userId);
		selectRequestVo.setUserServiceId(Constants.serviceType.IAAS_PHYSICAL+"");
		req.setSelectRequestVo(selectRequestVo);
		SelectWithNoPageResponse<UserProdInstVo> res = iaasConsoleDubboSv.selectUserProdInsts(req);
		List<UserProdInstVo> list = res.getResultList();
		
		model.addAttribute("prodList", list);
		
		return "console/iaas/iaasPhysicalConsole";
	}
	
	@RequestMapping(value = "/toIaasVirtalConsole")
	public String toIaasVirtalConsole(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		SelectWithNoPageRequest<UserProdInstVo> req = new SelectWithNoPageRequest<UserProdInstVo>();
		UserProdInstVo selectRequestVo = new UserProdInstVo();
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		String userId=userVo.getUserId();
		selectRequestVo.setUserId(userId);
		selectRequestVo.setUserServiceId(Constants.serviceType.IAAS_VIRTAL+"");
		req.setSelectRequestVo(selectRequestVo);
		SelectWithNoPageResponse<UserProdInstVo> res = iaasConsoleDubboSv.selectUserProdInsts(req);
		List<UserProdInstVo> list = res.getResultList();
		
		model.addAttribute("prodList", list);
		
		return "console/iaas/iaasVirtalConsole";
	}
	
	@RequestMapping(value = "/toIaasMemoryConsole")
	public String toIaasMemoryConsole(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		
		SelectWithNoPageRequest<UserProdInstVo> req = new SelectWithNoPageRequest<UserProdInstVo>();
		UserProdInstVo selectRequestVo = new UserProdInstVo();
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		String userId=userVo.getUserId();
		selectRequestVo.setUserId(userId);
		selectRequestVo.setUserServiceId(Constants.serviceType.IAAS_MEMORY+"");
		req.setSelectRequestVo(selectRequestVo);
		SelectWithNoPageResponse<UserProdInstVo> res = iaasConsoleDubboSv.selectUserProdInsts(req);
		List<UserProdInstVo> list = res.getResultList();
		
		model.addAttribute("prodList", list);
		
		return "console/iaas/iaasMemoryConsole";
	}
}
