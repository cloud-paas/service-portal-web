package com.ai.paas.ipaas.help.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.paas.ipaas.config.ftp.SFTPUtils;
import com.ai.paas.ipaas.user.manage.rest.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.vo.user.SysParamVo;
import com.ai.paas.ipaas.vo.user.SysParmRequest;
import com.alibaba.dubbo.config.annotation.Reference;

@Controller
@RequestMapping(value = "/help")
public class HelpCenterController {

	@Reference
	private ISysParamDubbo iSysParam;

	@RequestMapping(value = "/center")
	public String center(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		SysParmRequest req = new SysParmRequest();
		req.setTypeCode("CONTACTS");
		req.setParamCode("CONTACTS");
		
		List<SysParamVo> list = iSysParam.getSysParams(req);
		String contactName = "";
		String contactMobile = "";
		String contactMail = "";
		String contactQQ = "";
		
		for (SysParamVo vo : list) {
			if ("CONTACTS_NAME".equals(vo.getServiceValue())) {
				contactName = vo.getServiceOption();
			} else if ("CONTACTS_TEL".equals(vo.getServiceValue())) {
				contactMobile = vo.getServiceOption();
			} else if ("CONTACTS_QQ".equals(vo.getServiceValue())) {
				contactQQ = vo.getServiceOption();
			} else {
				contactMail = vo.getServiceOption();
			}
		}
		
		model.addAttribute("contactName", contactName);
		model.addAttribute("contactMobile", contactMobile);
		model.addAttribute("contactMail", contactMail);
		model.addAttribute("contactQQ", contactQQ);

		SFTPUtils sftp = new SFTPUtils();
		List<String> fileList = sftp.getFileList("2");
		request.setAttribute("type", "2");
		if (fileList.size() > 0) {
			for (String fileName : fileList) {
				System.out.println("_______________" + fileName
						+ "$$$$$$$$$$$$$$$$");
			}
			request.setAttribute("fileList", fileList);
		}
		return "help/center";
	}

	@RequestMapping(value = "/nt")
	public String ntLogin(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysParmRequest req = new SysParmRequest();
		req.setTypeCode("CONTACTS");
		req.setParamCode("CONTACTS");
		List<SysParamVo> list = iSysParam.getSysParams(req);
		String contactName = "";
		String contactMobile = "";
		String contactMail = "";
		String contactQQ = "";
		
		for (SysParamVo vo : list) {
			if ("CONTACTS_NAME".equals(vo.getServiceValue())) {
				contactName = vo.getServiceOption();
			} else if ("CONTACTS_TEL".equals(vo.getServiceValue())) {
				contactMobile = vo.getServiceOption();
			} else if ("CONTACTS_QQ".equals(vo.getServiceValue())) {
				contactQQ = vo.getServiceOption();
			} else {
				contactMail = vo.getServiceOption();
			}
		}
		
		model.addAttribute("contactName", contactName);
		model.addAttribute("contactMobile", contactMobile);
		model.addAttribute("contactMail", contactMail);
		model.addAttribute("contactQQ", contactQQ);
		model.addAttribute("contactList", list);
		
		return "help/ntLogin";
	}

	@RequestMapping(value = "/mail")
	public String mailLogin(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysParmRequest req = new SysParmRequest();
		req.setTypeCode("CONTACTS");
		req.setParamCode("CONTACTS");
		List<SysParamVo> list = iSysParam.getSysParams(req);
		String contactName = "";
		String contactMobile = "";
		String contactMail = "";
		String contactQQ = "";
		for (SysParamVo vo : list) {
			if ("CONTACTS_NAME".equals(vo.getServiceValue())) {
				contactName = vo.getServiceOption();
			} else if ("CONTACTS_TEL".equals(vo.getServiceValue())) {
				contactMobile = vo.getServiceOption();
			} else if ("CONTACTS_QQ".equals(vo.getServiceValue())) {
				contactQQ = vo.getServiceOption();
			} else {
				contactMail = vo.getServiceOption();
			}
		}
		model.addAttribute("contactName", contactName);
		model.addAttribute("contactMobile", contactMobile);
		model.addAttribute("contactMail", contactMail);
		model.addAttribute("contactQQ", contactQQ);
		return "help/mailLogin";
	}

	@RequestMapping(value = "/iaas")
	public String iaapApply(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysParmRequest req = new SysParmRequest();
		req.setTypeCode("CONTACTS");
		req.setParamCode("CONTACTS");
		List<SysParamVo> list = iSysParam.getSysParams(req);
		String contactName = "";
		String contactMobile = "";
		String contactMail = "";
		String contactQQ = "";
		for (SysParamVo vo : list) {
			if ("CONTACTS_NAME".equals(vo.getServiceValue())) {
				contactName = vo.getServiceOption();
			} else if ("CONTACTS_TEL".equals(vo.getServiceValue())) {
				contactMobile = vo.getServiceOption();
			} else if ("CONTACTS_QQ".equals(vo.getServiceValue())) {
				contactQQ = vo.getServiceOption();
			} else {
				contactMail = vo.getServiceOption();
			}
		}
		model.addAttribute("contactName", contactName);
		model.addAttribute("contactMobile", contactMobile);
		model.addAttribute("contactMail", contactMail);
		model.addAttribute("contactQQ", contactQQ);
		return "help/iaasApply";
	}

	@RequestMapping(value = "/paas")
	public String paasApply(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysParmRequest req = new SysParmRequest();
		req.setTypeCode("CONTACTS");
		req.setParamCode("CONTACTS");
		List<SysParamVo> list = iSysParam.getSysParams(req);
		String contactName = "";
		String contactMobile = "";
		String contactMail = "";
		String contactQQ = "";
		for (SysParamVo vo : list) {
			if ("CONTACTS_NAME".equals(vo.getServiceValue())) {
				contactName = vo.getServiceOption();
			} else if ("CONTACTS_TEL".equals(vo.getServiceValue())) {
				contactMobile = vo.getServiceOption();
			} else if ("CONTACTS_QQ".equals(vo.getServiceValue())) {
				contactQQ = vo.getServiceOption();
			} else {
				contactMail = vo.getServiceOption();
			}
		}
		model.addAttribute("contactName", contactName);
		model.addAttribute("contactMobile", contactMobile);
		model.addAttribute("contactMail", contactMail);
		model.addAttribute("contactQQ", contactQQ);
		return "help/paasApply";
	}

	@RequestMapping(value = "/FAQ")
	public String faq(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysParmRequest req = new SysParmRequest();
		req.setTypeCode("CONTACTS");
		req.setParamCode("CONTACTS");
		List<SysParamVo> list = iSysParam.getSysParams(req);
		String contactName = "";
		String contactMobile = "";
		String contactMail = "";
		String contactQQ = "";
		for (SysParamVo vo : list) {
			if ("CONTACTS_NAME".equals(vo.getServiceValue())) {
				contactName = vo.getServiceOption();
			} else if ("CONTACTS_TEL".equals(vo.getServiceValue())) {
				contactMobile = vo.getServiceOption();
			} else if ("CONTACTS_QQ".equals(vo.getServiceValue())) {
				contactQQ = vo.getServiceOption();
			} else {
				contactMail = vo.getServiceOption();
			}
		}
		model.addAttribute("contactName", contactName);
		model.addAttribute("contactMobile", contactMobile);
		model.addAttribute("contactMail", contactMail);
		model.addAttribute("contactQQ", contactQQ);
		return "help/faq";
	}

	@RequestMapping(value = "/manual")
	public String manual(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		SysParmRequest req = new SysParmRequest();
		req.setTypeCode("CONTACTS");
		req.setParamCode("CONTACTS");
		List<SysParamVo> list = iSysParam.getSysParams(req);
		String contactName = "";
		String contactMobile = "";
		String contactMail = "";
		String contactQQ = "";
		for (SysParamVo vo : list) {
			if ("CONTACTS_NAME".equals(vo.getServiceValue())) {
				contactName = vo.getServiceOption();
			} else if ("CONTACTS_TEL".equals(vo.getServiceValue())) {
				contactMobile = vo.getServiceOption();
			} else if ("CONTACTS_QQ".equals(vo.getServiceValue())) {
				contactQQ = vo.getServiceOption();
			} else {
				contactMail = vo.getServiceOption();
			}
		}
		model.addAttribute("contactName", contactName);
		model.addAttribute("contactMobile", contactMobile);
		model.addAttribute("contactMail", contactMail);
		model.addAttribute("contactQQ", contactQQ);
		SFTPUtils sftp = new SFTPUtils();
		List<String> fileList = sftp.getFileList("2");
		request.setAttribute("type", "2");
		if (fileList.size() > 0) {
			request.setAttribute("fileList", fileList);
		}
		return "help/manual";
	}

}
