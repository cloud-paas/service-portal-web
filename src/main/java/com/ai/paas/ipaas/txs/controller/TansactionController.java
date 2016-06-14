package com.ai.paas.ipaas.txs.controller;

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
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrder;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.EmailDetail;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailRequest;
import com.ai.paas.ipaas.user.dubbo.vo.OrderDetailResponse;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.alibaba.dubbo.config.annotation.Reference;

@Controller
@RequestMapping(value = "/txs")
public class TansactionController {
    @Reference
    private IOrder iOrder;

    @Reference
    private ISysParamDubbo iSysParam;

    @Autowired
	private EmailServiceImpl emailSrv;
    
    private static final Logger log = LogManager.getLogger(TansactionController.class.getName());

    @RequestMapping(value = "/introduce")
    public String toIndex(HttpServletRequest request, HttpServletResponse response) {
        request.getSession().removeAttribute("list_index");
        request.getSession().setAttribute("list_index", "list_6");
        return "tansaction/introduce";
    }

    /**
     * 跳转至TXS 事务保障服务页面
     * 
     * @param req
     * @param resp
     * @return
     */
    @RequestMapping(value = "/txsApplyPage")
    public String txsApplyPage(HttpServletRequest req, HttpServletResponse resp) {
        return "tansaction/txsApplyPage";
    }

    /**
     * TXS 事务保障服务
     * 
     * @param req
     * @param resp
     * @return
     * @return
     */
    @RequestMapping(value = "/txsApply")
    public @ResponseBody
    Map<String, Object> txsApply(HttpServletRequest req, HttpServletResponse resp) {
        OrderDetailRequest request = new OrderDetailRequest();
        request.setProdId(Constants.serviceType.TRANS_CENTER + "");
        request.setProdType(Constants.ProductType.IPAAS_ShuJK);//PROD_TAB // 1存储  2计算   3 数据库服务
        request.setProdByname(Constants.serviceName.TXS);
        request.setOperateType(Constants.OperateType.APPLY);
        UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
        request.setUserId(userVo.getUserId());
        String servicePassword = req.getParameter("servicePassword");
        String my_name = req.getParameter("my_name");
        JSONObject prodParam = new JSONObject();
        prodParam.put("serviceName", my_name);
        request.setProdParam(prodParam.toString());
        request.setUserServIpaasPwd(servicePassword);
        log.info("=========== begin to send request and the params are : "
                + net.sf.json.JSONObject.fromObject(request));
        OrderDetailResponse response = iOrder.saveOrderDetail(request);
        log.info("=========== receive the response and the response's contents are : "
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