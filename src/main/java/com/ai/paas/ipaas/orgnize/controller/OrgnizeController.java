package com.ai.paas.ipaas.orgnize.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.system.constants.Constants.RType;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.alibaba.dubbo.config.annotation.Reference;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrgnizeCenterSv;
import com.ai.paas.ipaas.user.dubbo.vo.OrgnizeCenterVo;

@Controller
@RequestMapping(value = "/orgnize")
public class OrgnizeController {

	private static final Logger logger = LogManager
			.getLogger(OrgnizeController.class.getName());

	@SuppressWarnings("rawtypes")
	static Class config_class = OrgnizeController.class;
	@Reference
	private IOrgnizeCenterSv iorg;

	@Reference
	private ISysParamDubbo iSysParam;

	@Autowired
	protected HttpSession session;
	
	@RequestMapping(value = "/getOrgnize")
	public String getOrgnize(ModelMap model,HttpServletRequest request,
			HttpServletResponse response) {
		List<OrgnizeCenterVo> orgInfos = new ArrayList<OrgnizeCenterVo>();
		try {
			orgInfos = iorg.getOrgnizeCenterByStatus(RType.STATUS_VALID);
		} catch (PaasException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		model.addAttribute("orgInfoList", orgInfos);
		return "user/register";
	}
}
