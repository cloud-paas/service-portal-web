package com.ai.paas.ipaas.console.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.user.dubbo.interfaces.IDssConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.vo.ResponseHeader;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageResponse;
import com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo;
import com.alibaba.dubbo.config.annotation.Reference;

/**
 * 用户控制台
 */

@RequestMapping(value = "/console")
@Controller
public class UserConsoleController {
	@Reference
	private IDssConsoleDubboSv consoleDubboSv;

	@RequestMapping(value = "/toManageConsole")
	public String toManageConsole() {
		return "console/manageconsole";
	}

	/**
	 * 缓存列表查询
	 * 
	 * @return
	 */
	@RequestMapping(value = "/queryMCSList")
	@ResponseBody
	public Map<String, Object> queryMCSList(HttpServletRequest req,
			HttpServletResponse resp) {

		Map<String, Object> result = new HashMap<String, Object>();
		SelectWithNoPageResponse<UserProdInstVo> response = null;
		ResponseHeader header = new ResponseHeader();
		try {
			result.put("code", "000000");
			result.put("resultList", new ArrayList<UserProdInstVo>());
		} catch (Exception e) {
			// TODO: handle exception
			result.put("code", "999999");
			result.put("resultMessage", "查询出现异常！");
		}
		return result;
	}

	/**
	 * 缓存注销
	 * 
	 * @return
	 */
	@RequestMapping(value = "/cancleMCS")
	@ResponseBody
	public Map<String, Object> cancleMCS(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		ResponseHeader header = new ResponseHeader();
		try {
			// 注销
			result.put("code", "000000");
			result.put("resultList", new ArrayList<UserProdInstVo>());
		} catch (Exception e) {
			// TODO: handle exception
			result.put("code", "999999");
			result.put("resultMessage", "注销出现异常！");
		}
		return result;
	}

	/**
	 * 缓存格式化
	 */
	@RequestMapping(value = "/formatMCS")
	@ResponseBody
	public Map<String, Object> formatMCS(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		ResponseHeader header = new ResponseHeader();
		try {
			// 缓存格式化
			result.put("code", "000000");
			result.put("resultList", new ArrayList<UserProdInstVo>());
		} catch (Exception e) {
			// TODO: handle exception
			result.put("code", "999999");
			result.put("resultMessage", "缓存格式化异常！");
		}
		return result;
	}

	/**
	 * 缓存密码修改
	 */
	@RequestMapping(value = "/updateMCSPwd")
	@ResponseBody
	public Map<String, Object> updateMCSPwd(HttpServletRequest req,
			HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		ResponseHeader header = new ResponseHeader();
		try {
			// 缓存密码修改
			result.put("code", "000000");
			result.put("resultList", new ArrayList<UserProdInstVo>());
		} catch (Exception e) {
			// TODO: handle exception
			result.put("code", "999999");
			result.put("resultMessage", "缓存密码修改出现异常！");
		}
		return result;
	}
	
	@RequestMapping(value = "/iaasConsole")
	public String iaasConsole() {
		return "console/manageconsole";
	}
	
}
