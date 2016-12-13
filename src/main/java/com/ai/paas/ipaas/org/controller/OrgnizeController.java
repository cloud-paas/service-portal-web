package com.ai.paas.ipaas.org.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.paas.ipaas.user.manage.rest.interfaces.IOrgnizeCenterSv;
import com.alibaba.dubbo.config.annotation.Reference;

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
