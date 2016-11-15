package com.ai.paas.ipaas.org.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.constants.Constants.RType;
import com.alibaba.dubbo.config.annotation.Reference;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrgnizeCenterSv;
import com.ai.paas.ipaas.user.dubbo.vo.OrgnizeCenterVo;

@Controller
@RequestMapping(value = "/org")
public class OrgnizeController {

	private static final Logger logger = LogManager
			.getLogger(OrgnizeController.class.getName());
	
	@SuppressWarnings("rawtypes")
	static Class config_class = OrgnizeController.class;
	
	@Reference
	private IOrgnizeCenterSv iorg;
	
	/** 方法改放到UserContoller中的toRegister中
	 * 
	@RequestMapping(value = "/toGetOrgnize")
	public String getOrgnize(HttpServletRequest request,
			HttpServletResponse response) {
		List<OrgnizeCenterVo> orgInfos = new ArrayList<OrgnizeCenterVo>();
		//Map<String, Object> result = new HashMap<String, Object>();
		try {
			orgInfos = iorg.getOrgnizeCenterByStatus(RType.STATUS_VALID);
			//result.put("resultCode", Constants.OPERATE_CODE_SUCCESS);
			//result.put("resultList", orgInfos);
			request.setAttribute("orgList", orgInfos);		
			//System.out.println("进入获取组织方法："+ orgInfos.size());
		} catch (PaasException e) {
			// TODO Auto-generated catch block
			//result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			//result.put("resultMessage", "查询出现异常！");
			logger.error(e);
		}
		return "user/register";
	}
	*/
}
