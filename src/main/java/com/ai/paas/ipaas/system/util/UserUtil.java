package com.ai.paas.ipaas.system.util;

import javax.servlet.http.HttpSession;

import com.ai.paas.ipaas.system.constants.ConstantsForSession;
import com.ai.paas.ipaas.user.vo.UserInfoVo;

/**
 * 用户session工具类
 * @author jonrey
 *
 */
public class UserUtil {

	public UserUtil() {
	}
	/**
	 * 存放USerInfo到session中
	 * @author jonrey
	 */
	public static void setUserSession(HttpSession session,UserInfoVo userVo){
		session.setAttribute(ConstantsForSession.LoginSession.USER_INFO, userVo);
	}
	/**
	 * 从session中获取User的信息
	 */
	public static UserInfoVo getUserSession(HttpSession session){
		UserInfoVo userVo = null;
		userVo=(UserInfoVo)session.getAttribute(ConstantsForSession.LoginSession.USER_INFO);
		if (userVo == null) {
			return null;
		}
		return userVo;
	}
	
}
