package com.ai.paas.ipaas.system.filter;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.jasig.cas.client.util.AbstractCasFilter;
import org.jasig.cas.client.validation.Assertion;

import com.ai.paas.ipaas.storm.sys.utils.StringUtils;
import com.ai.paas.ipaas.system.constants.ConstantsForSession;
import com.ai.paas.ipaas.user.vo.UserInfoVo;



public class LoginFilter implements Filter{
	private static final Logger log = LogManager.getLogger(LoginFilter.class.getName());
	public LoginFilter() {
	}
	
	private final String LoginPage ="/audit/toLogin";
	private static String[] IGNORE_PAGES = {};
	public static String[] IGNORE_SUFFIX={};
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		String ignore_suffix = filterConfig.getInitParameter("ignore_suffix");
		if (StringUtils.isNotBlank(ignore_suffix))
			IGNORE_SUFFIX = filterConfig.getInitParameter("ignore_suffix").split(",");
		
		String ignorePages = filterConfig.getInitParameter("ignore_pages");
		if (StringUtils.isNotBlank(ignorePages)) {
			IGNORE_PAGES =ignorePages.split(",");
		}
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest servletRequest  = (HttpServletRequest) request;
		HttpServletResponse servletResponse = (HttpServletResponse) response;
		HttpSession session = servletRequest.getSession();
		//拿到用户信息
		final Assertion assertion = (Assertion) (((HttpServletRequest) request).getSession() == null ? request.getAttribute(AbstractCasFilter.CONST_CAS_ASSERTION) : ((HttpServletRequest) request).getSession().getAttribute(AbstractCasFilter.CONST_CAS_ASSERTION));
		if (assertion!=null&&assertion.getPrincipal()!=null){
			//用户已经登录
			chain.doFilter(servletRequest, servletResponse);
			return;
		}
		//运维页面集成防拦截
		String paasFlag = servletRequest.getParameter("paasFlag");
		String userEmail = servletRequest.getParameter("userEmail");
		UserInfoVo userInfoVo2 =null;
		if(userEmail!=null && !"".equals(userEmail)){
			if(session.getAttribute(ConstantsForSession.LoginSession.USER_INFO)!=null){
				userInfoVo2 = (UserInfoVo)session.getAttribute(ConstantsForSession.LoginSession.USER_INFO);
				userInfoVo2.setUserEmailTmp(userEmail);
			}else{
				userInfoVo2 = new UserInfoVo();
				userInfoVo2.setUserEmailTmp(userEmail);
			}
			
		}
		if(paasFlag!=null && "true".equals(paasFlag)){
			session.setAttribute(ConstantsForSession.LoginSession.USER_INFO, userInfoVo2);
			chain.doFilter(servletRequest, servletResponse);
			return;
		}
		 // 获得用户请求的URI
		String path = servletRequest.getRequestURI();
		StringBuffer parametersBuff = new StringBuffer();
		Map parameters = request.getParameterMap();
        if (parameters != null && parameters.size() > 0) {
        	parametersBuff.append("?");
            for (Iterator iter = parameters.keySet().iterator(); iter.hasNext();) {
                String key = (String) iter.next();
                String[] values = (String[]) parameters.get(key);
                for (int i = 0; i < values.length; i++) {
                	parametersBuff.append(key).append("=").append(values[i]).append("&");
                }
            }
        }
        path = path+parametersBuff.toString();
        
		
		if (shouldFilter(servletRequest)) {
			chain.doFilter(servletRequest, servletResponse);
			return;
		}
		
		//不需要过滤的页面处理
		if (ignorePages(servletRequest)) {
			chain.doFilter(servletRequest, servletResponse);
			return;
		}
		// 从session里取用户信息
		UserInfoVo userVo = null;
		userVo = (UserInfoVo) session.getAttribute(ConstantsForSession.LoginSession.USER_INFO);
		
		//如果用户登录信息为空，则跳转到登录页面
//		if (userVo == null || StringUtils.isBlank(userVo.getUserName())) {
		if (userVo == null) {
			//把要请求你的url带到登录页面，然后登录后直接跳转到之前请求页面，不放到session中
			String url = servletRequest.getContextPath()+LoginPage+"?"+ConstantsForSession.LoginSession.URL_INFO+"="+
					 java.net.URLEncoder.encode(path, "UTF-8");
			servletResponse.sendRedirect(url);
			log.info("###################################sendRedirect:"+url);
		}else {
			//用户已经登录
			log.info("###################################have login already");
			chain.doFilter(servletRequest, servletResponse);
		}
		

	}
	
	private boolean shouldFilter(HttpServletRequest request) {
		String uri = request.getRequestURI().toLowerCase();
		for (String suffix : IGNORE_SUFFIX) {
			if (uri.endsWith(suffix))
				return true;
		}
		return false;
	}
	public boolean ignorePages(HttpServletRequest request){
		String uri = request.getRequestURI();
		for (String pageUrl: IGNORE_PAGES) {
			if (uri.endsWith(pageUrl)) {
				return true ;
			}
		}
		return false;
	}
	@Override
	public void destroy() {
		
	}

	

	
}
