package com.ai.paas.ipaas.apply.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.utils.ConfigUtil;


/**
 * Servlet Filter implementation class ApplyAuditFilter
 */
@WebFilter("/ApplyAuditFilter")
public class ApplyAuditFilter implements Filter {

	private static final Logger log = LogManager.getLogger(ApplyAuditFilter.class.getName());

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		log.debug("ApplyAuditFilter destroy");
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		//获得配置文件里的值
		String userAccessList = ConfigUtil.getParameterValue("/common/userAccess.properties", "userAccessList");
		log.debug("获得配置文件里用户信息------"+userAccessList);
		//获得session里值
		HttpSession session = ((HttpServletRequest) request).getSession();
		UserInfoVo userVo = UserUtil.getUserSession(session);
//		log.debug("获得session里用户信息------"+userVo.getUserEmail());
		
		//判断当前用户的邮箱，userid是否都在配置文件中，有一个不存在，就跳向没有权限页面
		if(userVo !=null && !"".equals(userVo)){
			if(userAccessList.indexOf(userVo.getUserEmail()) ==-1 || userAccessList.indexOf(userVo.getUserId()) ==-1){
				log.debug("当前用户无权------"+userVo.getUserEmail());
				//跳转到错误页面
				((HttpServletRequest)request).getRequestDispatcher("../jsp/apply/error.jsp").forward(request, response);
			}
		}
		chain.doFilter(request, response);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		log.debug("ApplyAuditFilter init");
	}

}
