package com.ai.paas.ipaas.ats.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.paas.ipaas.email.EmailServiceImpl;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.manage.rest.interfaces.IOrder;
import com.ai.paas.ipaas.user.manage.rest.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.vo.user.EmailDetail;
import com.ai.paas.ipaas.vo.user.OrderDetailRequest;
import com.ai.paas.ipaas.vo.user.OrderDetailResponse;
import com.alibaba.dubbo.config.annotation.Reference;

@Controller
@RequestMapping(value = "/ats")
public class AsynchronousController {
    @Reference
    private IOrder iOrder;

    @Reference
    private ISysParamDubbo iSysParam;

    @Autowired
	private EmailServiceImpl emailSrv;
    
    private static final Logger log = LogManager.getLogger(AsynchronousController.class.getName());

    @RequestMapping(value = "/introduce")
    public String toIndex(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().removeAttribute("list_index");
        request.getSession().setAttribute("list_index", "list_7");
        return "asynchronous/introduce";
    }

    /**
     * 跳转至ATS 最终事物一致页面
     * 
     * @param req
     * @param resp
     * @return
     */
    @RequestMapping(value = "/atsApplyPage")
    public String atsApplyPage(HttpServletRequest req, HttpServletResponse resp) {
        return "asynchronous/atsApplyPage";
    }

    /**
     * ATS 最终事物一致
     * 
     * @param req
     * @param resp
     * @return
     * @return
     */
    @RequestMapping(value = "/atsApply")
    public @ResponseBody
    Map<String, Object> atsApply(HttpServletRequest req, HttpServletResponse resp) {
        OrderDetailRequest request = new OrderDetailRequest();
        request.setProdId(Constants.serviceType.TRANSACTION_CENTER + "");
        request.setProdType(Constants.ProductType.IPAAS_ShuJK); //PROD_TAB // XXX (1存储  2计算   3 数据库服务)  1计算   2 数据库服务  3存储  2015.11.6
        request.setProdByname(Constants.serviceName.ATS);
        request.setOperateType(Constants.OperateType.APPLY);
        UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
        request.setUserId(userVo.getUserId());
        String servicePassword = req.getParameter("my_password");
        String my_name = req.getParameter("my_name");
        log.info("get the param of servicePassword is : " + servicePassword);
        JSONObject prodParam = new JSONObject();
        prodParam.put("serviceName", my_name);
        prodParam.put("orgCode", userVo.getOrgCode());
        request.setProdParam(prodParam.toString());
        request.setUserServIpaasPwd(servicePassword);
        log.info("========= begin to send request and the params are : "
                + net.sf.json.JSONObject.fromObject(request));
        OrderDetailResponse response = iOrder.saveOrderDetail(request);
        log.info("========= receive the response and the response's contents are : "
                + net.sf.json.JSONObject.fromObject(response));
        
        Map<String, Object> json = new HashMap<String, Object>();

        try {
        	log.info("========= 根据orderDetailResponse结果，发送服务开通的待审核提醒邮件=========");
    		if (response.isNeedSend() && response.getEmail() != null) {
    			for (EmailDetail email : response.getEmail()) {
    				emailSrv.sendEmail(email);
    			}
    		}
    		
            json.put("code", response.getResponseHeader().getResultCode());
            json.put("resultMessage", response.getResponseHeader().getResultMessage());
        } catch (Exception e) {
            json.put("code", "9999");
            json.put("resultMessage", "response returned an unexcept exception");
        }
        return json;
    }
}
