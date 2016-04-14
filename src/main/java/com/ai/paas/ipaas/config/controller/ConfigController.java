package com.ai.paas.ipaas.config.controller;

import java.util.HashMap;
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
import com.ai.paas.ipaas.user.dubbo.interfaces.IMcsConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrder;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailRequest;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailResponse;
import com.ai.paas.ipaas.user.dubbo.vo.ResponseHeader;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageRequest;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageResponse;
import com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.CiperUtil;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;

@Controller
@RequestMapping(value = "/ccs")
public class ConfigController {
	private static final Logger logger = LogManager
			.getLogger(ConfigController.class.getName());
	@Reference
	private IOrder iOrder;
	
	 @Reference
	 private IMcsConsoleDubboSv mcsConsoleDubboSv;

	
	@RequestMapping(value = "/introduce")
	public String configInfo(HttpServletRequest request,
			HttpServletResponse response) {
        request.getSession().removeAttribute("list_index");
        request.getSession().setAttribute("list_index", "list_1");
		return "config/introduce";
	}
	
	
	/**
	 * 准备开通配置服务
	 */
	@RequestMapping(value = "/toOpenConfig")
	public String toRegisterService(HttpServletRequest request,
			HttpServletResponse response) {
		return "config/openConfig";
	}

	/**
	 * 开通配置服务
	 * 
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/openConfig")
	public Map<String, Object> applyCMSService(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> resultMap = new HashMap<String, Object>();

		OrderDetailRequest orderDetailRequest = new OrderDetailRequest();
		orderDetailRequest.setOperateType(Constants.OperateType.APPLY);// 操作类型
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		orderDetailRequest.setUserId(userVo.getUserId()); // 用户Id
		orderDetailRequest.setProdType(Constants.ProductType.IPAAS_CunChu); //PROD_IPAAS // 产品类型
		String prodId = Constants.serviceType.CONFIG_CENTER+"";
		orderDetailRequest.setProdId(prodId); // 产品id
		orderDetailRequest.setProdByname(Constants.serviceName.CCS); // 别名
		
		String serviceName = request.getParameter("serviceName"); //服务名称
		Gson prodParam = new Gson();
		Map<String, Object> serviceMap = new HashMap<String, Object>();
		serviceMap.put("serviceName", serviceName);
		orderDetailRequest.setProdParam(prodParam.toJson(serviceMap)); // 配置中心参数为空
		orderDetailRequest.setUserServIpaasPwd(request.getParameter("servicePassword"));// 服务密码
		
		
		logger.info("!!!!!!! call dubboService saveOrderDetail begin.....");
		OrderDetailResponse orderDetailResponse = new OrderDetailResponse();
		try {
			orderDetailResponse = iOrder.saveOrderDetail(orderDetailRequest);
			logger.info("!!!!!!! call dubboService saveOrderDetail result："
					+ orderDetailResponse.getResponseHeader().getResultCode() + ":"
					+ orderDetailResponse.getResponseHeader().getResultMessage());
			resultMap.put("code", orderDetailResponse.getResponseHeader()
					.getResultCode());
			resultMap.put("data", prodId);
			resultMap.put("message", orderDetailResponse.getResponseHeader()
					.getResultMessage());
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			resultMap.put("code", "9999");
			resultMap.put("message", "系统异常，请联系管理员");
		}
		
		return resultMap;
	}
	/**
	 * 修改ccs密码服务
	 * @param req
	 * @param resp
	 * @return
	 */
	@RequestMapping(value = "/toModifyCcsServPwd")
    public String toModifyMcsServPwd(HttpServletRequest req, HttpServletResponse resp) {
        dealWithUsrProdInfo(req);
        return "console/ccs/ccsModifyServPwd";
    }
	private void dealWithUsrProdInfo(HttpServletRequest req) {
        SelectWithNoPageResponse<UserProdInstVo> response = null;
        String userServId = req.getParameter("userServId");
        try {
            SelectWithNoPageRequest<UserProdInstVo> selectWithNoPageRequest = new SelectWithNoPageRequest<UserProdInstVo>();
            UserProdInstVo vo = new UserProdInstVo();
            UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
            vo.setUserId(userVo.getUserId()); // 用户Id
            vo.setUserServId(Long.parseLong(userServId));
            selectWithNoPageRequest.setSelectRequestVo(vo);
            response = mcsConsoleDubboSv.selectMcsById(selectWithNoPageRequest);
            if (Constants.OPERATE_CODE_SUCCESS.equals(response.getResponseHeader().getResultCode())) {
                req.getSession().removeAttribute("userProdInstVo");
                req.getSession().setAttribute("userProdInstVo", response.getResultList().get(0));
            }
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
        }
    }
    /**
     * ccs密码修改
     * 
     * @param req
     * @param resp
     * @return
     */
    @RequestMapping(value = "/modifyCcsServPwd")
    @ResponseBody
    public Map<String, Object> modifyMcsServPwd(HttpServletRequest req, HttpServletResponse resp) {
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
    @RequestMapping(value = "/modifyCcsServPwdSuccess")
    public String modifyMcsServPwdSuccess(HttpServletRequest req) {
        String parentUrl = req.getParameter("parentUrl");
        req.setAttribute("parentUrl", parentUrl);
        String productType = req.getParameter("productType");
        req.setAttribute("productType", productType);
        UserProdInstVo userProdInstVo = (com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo) req
                .getSession().getAttribute("userProdInstVo");
        req.setAttribute("userProdInstVo", userProdInstVo);
        return "console/modifyServPwdSuccess";
    }


}
