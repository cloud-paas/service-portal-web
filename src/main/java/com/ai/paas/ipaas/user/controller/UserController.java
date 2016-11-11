package com.ai.paas.ipaas.user.controller;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URISyntaxException;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.tapestry5.json.JSONObject;
import org.jasig.cas.client.util.AbstractCasFilter;
import org.jasig.cas.client.validation.Assertion;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import bsh.Interpreter;

import com.ai.paas.ipaas.PaasException;
import com.ai.paas.ipaas.config.ftp.SFTPConfig;
import com.ai.paas.ipaas.config.ftp.SFTPConstants;
import com.ai.paas.ipaas.config.ftp.SFTPException;
import com.ai.paas.ipaas.config.ftp.SFTPUtils;
import com.ai.paas.ipaas.email.EmailServiceImpl;
import com.ai.paas.ipaas.storm.sys.utils.StringUtils;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.constants.ConstantsForSession;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.HttpRequestUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrgnizeUserInfoSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.interfaces.IUser;
import com.ai.paas.ipaas.user.dubbo.vo.OrgnizeUserInfoVo;
import com.ai.paas.ipaas.user.dubbo.vo.RegisterResult;
import com.ai.paas.ipaas.user.dubbo.vo.UserVo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.util.Assert;
import com.ai.paas.ipaas.util.CiperUtil;
import com.ai.paas.ipaas.util.StringUtil;
import com.ai.paas.ipaas.util.UUIDTool;
import com.ai.paas.ipaas.utils.GsonUtil;
import com.ai.paas.ipaas.zookeeper.SystemConfigHandler;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
@RequestMapping(value = "/audit")
public class UserController {
	private static final Logger logger = LogManager
			.getLogger(UserController.class.getName());

	private static final String SECURITY_KEY = "7331c9b6b1a1d521363f7bca8acb095f";// md5
	private static String directory = SFTPConfig
			.getString("SFTP.REQ.DIRECTORY");
	@SuppressWarnings("rawtypes")
	static Class config_class = UserController.class;
	@Reference
	private IUser iUser;
	
	@Reference
	private IOrgnizeUserInfoSv iOrgUser;

	@Reference
	private ISysParamDubbo iSysParam;

	@Autowired
	protected HttpSession session;

	@Autowired
	private EmailServiceImpl emailSrv;

	@RequestMapping(value = "/toLogin")
	public String toLogin(HttpServletRequest request,
			HttpServletResponse response) {
		String urlInfo = request
				.getParameter(ConstantsForSession.LoginSession.URL_INFO);
		request.setAttribute("urlInfo", urlInfo);
		session.setAttribute(ConstantsForSession.LoginSession.USER_INFO, null);
		session.setAttribute(AbstractCasFilter.CONST_CAS_ASSERTION, null);
		session.invalidate();
		return "user/login";
	}

	@RequestMapping(value = "/toNTLogin")
	public String toNTLogin(HttpServletRequest request,
			HttpServletResponse response) {
		String urlInfo = request
				.getParameter(ConstantsForSession.LoginSession.URL_INFO);
		request.setAttribute("urlInfo", urlInfo);
		logger.info("###################toNTLogin#######################urlInfo:"
				+ urlInfo);
		return "user/ntlogin";
	}

	@RequestMapping(value = "/toSignOut")
	public String toSignOut(HttpServletRequest request,
			HttpServletResponse response) {
		session.setAttribute(ConstantsForSession.LoginSession.USER_INFO, null);
		session.setAttribute(AbstractCasFilter.CONST_CAS_ASSERTION, null);
		session.invalidate();
		return "user/login";
	}

	@RequestMapping(value = "/toRegister")
	public String register(HttpServletRequest request,
			HttpServletResponse response) {
		return "user/register";
	}

	@RequestMapping(value = "/toRegisterSuccess")
	public String registerSuccess(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		model.addAttribute("email", request.getParameter("email"));
		return "user/registerSuccess";
	}

	@RequestMapping(value = "/toActiveAccount")
	public String activeAccount(ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		model.addAttribute("email", request.getParameter("email"));
		return "user/activeAccount";
	}

	@ResponseBody
	@RequestMapping(value = "/doNTLogin")
	// nt账户登陆
	public Map<String, Object> doNTLogin(HttpServletRequest request,
			HttpServletResponse response) throws PaasException {
		Map<String, Object> modelMap = new HashMap<String, Object>();
		try {
			logger.info("###################begin to do NT Login#######################");
			// 拿到用户信息
			final Assertion assertion = (Assertion) (((HttpServletRequest) request)
					.getSession() == null ? request
					.getAttribute(AbstractCasFilter.CONST_CAS_ASSERTION)
					: ((HttpServletRequest) request).getSession().getAttribute(
							AbstractCasFilter.CONST_CAS_ASSERTION));
			logger.info("###################get user info       #######################");
			if (assertion != null && assertion.getPrincipal() != null) {
				String ntAccount = assertion.getPrincipal().getName();
				logger.info("###################ntAccount:" + ntAccount
						+ "#######################");
				if (ntAccount != null) {
					// 判重处理
					String email = ntAccount + "@asiainfo.com";
					boolean uniqueEmail = iUser.uniqueEmail(email);
					UserVo uv = new UserVo();
					uv.setUserEmail(email);
					uv.setUserName(email);
					uv.setUserPwd(CiperUtil.encrypt(SECURITY_KEY, ntAccount));
					uv.setUserState("2");
					uv.setUserInsideTag("1");
					uv.setPartnerType("NT");
					uv.setUserOrgName("asiainfo");
					uv.setUserPhoneNum("18610176415");
					uv.setUserRegisterTime(new Timestamp(new Date().getTime()));
					uv.setPartnerAccount(ntAccount);
					if (uniqueEmail) {
						// nt账号入库
						uv.setUserId(UUIDTool.genId32());
						logger.info("###################register if haven't registered yet#######################");
						iUser.registerUser(uv);
					}
					UserInfoVo userInfoVo = new UserInfoVo();
					if (uv.getUserId() == null || "".equals(uv.getUserId())) {
						UserVo dbUser = iUser.getUserInfoByEmail(email);
						if (dbUser != null && dbUser.getUserId() != null) {
							uv.setUserId(dbUser.getUserId());
						} else {
							throw new RuntimeException(
									"I have got uservo from db by email but userid is null fuck!");
						}
					}
					logger.info("###################copy UserVo to  userInfoVo  userid:#######################"
							+ uv.getUserId());
					BeanUtils.copyProperties(uv, userInfoVo);
					logger.info("###################put userinfo to session   userid:#######################"
							+ userInfoVo.getUserId());
					if ("18610176415".equals(userInfoVo.getUserPhoneNum())) {
						userInfoVo.setUserPhoneNum("");
					}
					UserUtil.setUserSession(session, userInfoVo);

					logger.info("###################go to the last page before you login       if you are lucky!!!#######################");
					modelMap.put("returnFlag", "success");
				} else {
					logger.info("###################woops.......ntlogin failed go to index#######################");
					modelMap.put("returnFlag", "0");
				}
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			throw new RuntimeException(e.getMessage(), e);
		}
		return modelMap;
	}

	@RequestMapping(value = "/checkPs", produces = "text/html;charset=UTF-8")
	public @ResponseBody String checkPs(@RequestParam String userPwd,
			String userEmail, HttpServletRequest request) {
		// 调用认证中心进行认证
		JSONObject jsonobj = new JSONObject();
		try {
			String result = "";
			String authServiceUrl = SystemConfigHandler.configMap
					.get("iPaas-Auth.SERVICE.IP_PORT_SERVICE");
			String authUrl = SystemConfigHandler.configMap
					.get("AUTH.AUTH_URL.url");
			result = HttpRequestUtil.sendPost(authServiceUrl + authUrl,
					"password=" + CiperUtil.encrypt(SECURITY_KEY, userPwd)
							+ "&authUserName=" + userEmail);
			JSONObject json = new JSONObject(result);
			String returnflag = json.getString("successed");
			if (returnflag.equalsIgnoreCase("false")) {
				String errorMessage = json.getString("authMsg");
				jsonobj.put("returnFlag", "0");
				jsonobj.put("returnMessage", errorMessage);

			} else {
				jsonobj.put("returnFlag", "1");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jsonobj.toString();
	}

	@ResponseBody
	@RequestMapping(value = "/doLogin")
	public Map<String, Object> doLogin(HttpServletRequest request,
			HttpServletResponse response) throws PaasException {
		Map<String, Object> modelMap = new HashMap<String, Object>();
		String userName = request.getParameter("userName");
		String passWord = request.getParameter("passWord");
		String imageString = request.getParameter("image");

		UserVo vo = null;
		UserInfoVo userInfoVo = new UserInfoVo();

		String authServiceUrl = SystemConfigHandler.configMap
				.get("iPaas-Auth.SERVICE.IP_PORT_SERVICE");
		String authUrl = SystemConfigHandler.configMap.get("AUTH.AUTH_URL.url");
		try {
			// 调用认证中心进行认证
			String address = authServiceUrl + authUrl;
			String result = "";
			result = HttpRequestUtil.sendPost(address,
					"password=" + CiperUtil.encrypt(SECURITY_KEY, passWord)
							+ "&authUserName=" + userName);
			JSONObject json = new JSONObject(result);
			String returnflag = json.getString("successed");
			if (returnflag.equalsIgnoreCase("false")) {
				String errorMessage = json.getString("authMsg");
				modelMap.put("returnFlag", "0");
				modelMap.put("returnMessage", errorMessage);
				return modelMap;
			}

			/** 获取当前页面验证码 **/
			String kaptchaExpected = (String) request
					.getSession()
					.getAttribute(
							com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
			if (!imageString.equalsIgnoreCase(kaptchaExpected)) {
				modelMap.put("returnFlag", "false");
				modelMap.put("returnMessage", "验证码错误，请重新输入");
				return modelMap;
			}

			/** 认证成功后根据userId 查询用户信息 **/
			String userId = json.getString("userId");
			vo = iUser.getUserInfo(userId);
			if (vo == null) {
				throw new PaasException("根据用户Id返回用户信息失败");
			}

			/** 判断用户状态是否是已激活状态，如果未激活则不允许登录 **/
			if (StringUtils.isBlank(vo.getUserState())
					|| !vo.getUserState().equalsIgnoreCase(
							Constants.userState.USER_STATE_OK)) {
				modelMap.put("returnFlag", "false_1");
				modelMap.put("returnMessage", "该用户未激活，请先登录邮箱激活账号");
				return modelMap;
			}

			/** 将查到的用户信息写缓存 **/
			vo.setUserName(vo.getUserEmail());
			BeanUtils.copyProperties(vo, userInfoVo);
			userInfoVo.setUserPhoneNum(vo.getUserPhoneNum());

			// partnerType; partnerAccount;
			if (userInfoVo.getPartnerAccount() == null
					|| "".equals(userInfoVo.getPartnerAccount())) {
				userInfoVo.setPartnerAccount(vo.getUserEmail().split(
						"@asiainfo.com")[0]);
			}

			UserUtil.setUserSession(session, userInfoVo);
			modelMap.put("returnFlag", "success");
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			throw new RuntimeException(e.getMessage(), e);
		}

		return modelMap;
	}

	@RequestMapping(value = "/authUser")
	@ResponseBody
	public void authUser(HttpServletRequest request,
			HttpServletResponse response) {
		String userName = request.getParameter("userName");
		String passWord = request.getParameter("passWord");
		boolean res = true;
		try {
			String authServiceUrl = SystemConfigHandler.configMap
					.get("iPaas-Auth.SERVICE.IP_PORT_SERVICE");
			String authUrl = SystemConfigHandler.configMap
					.get("AUTH.AUTH_URL.url");
			// 调用认证中心进行认证
			String address = authServiceUrl + authUrl;
			String result = "";
			result = HttpRequestUtil.sendPost(address,
					"password=" + CiperUtil.encrypt(SECURITY_KEY, passWord)
							+ "&authUserName=" + userName);
			JSONObject json = new JSONObject(result);
			String returnflag = json.getString("successed");
			if (returnflag.equalsIgnoreCase("false")) {
				res = false;
			}
			response.getWriter().print(res);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	// 动态编辑build文件
	@RequestMapping(value = "/tosdkLoading")
	@ResponseBody
	public Map<String, Object> tosdkLoading(HttpServletRequest request,
			HttpServletResponse response) {
		Map<String, Object> result = new HashMap<String, Object>();
		String sdkList = request.getParameter("sdkList");
		String[] sdkListArr = sdkList.split(",");

		BufferedReader reader = null;
		StringBuffer content = new StringBuffer();
		String line = null;
		boolean ctsFlg;
		try {
			// 读取build文件
			FileInputStream file;
			file = new FileInputStream(new File(config_class.getResource(
					"/gbuild/build_base.txt").toURI()));
			InputStreamReader isr = new InputStreamReader(file, "UTF-8");
			reader = new BufferedReader(isr);
			while ((line = reader.readLine()) != null) {
				if (line.trim().startsWith("runtime")) {
					ctsFlg = false;
					for (String sdk : sdkListArr) {
						if (line.contains(sdk)) {
							ctsFlg = true;
							break;
						}
					}
					if (ctsFlg == true) {
						content.append(line);
						content.append("\r\n");
					}
					continue;
				}
				content.append(line);
				content.append("\r\n");
			}
			reader.close();

			// 重写build文件
			FileOutputStream fos;

			fos = new FileOutputStream(new File(config_class.getResource(
					"/gbuild/build.gradle").toURI()));

			OutputStreamWriter osw = new OutputStreamWriter(fos, "UTF-8");
			osw.write(content.toString());
			osw.flush();

			// 修改shell的执行权限
			String shpath = config_class.getResource("/gbuild/gradlebuild.sh")
					.getPath();
			System.out.println("shpath is: " + shpath);
			String cmdstring = "chmod 777 " + shpath;
			logger.info("修改权限的cmd为： " + cmdstring);
			Process proc = Runtime.getRuntime().exec(cmdstring);
			proc.waitFor(); // 阻塞，直到上述命令执行完

			cmdstring = "/bin/sh " + shpath; // 这里也可以是ksh等
			System.out.println("执行命令的cmd为： " + cmdstring);
			proc = Runtime.getRuntime().exec(cmdstring);

			// 读取标准输出流
			BufferedReader bufferedReader = new BufferedReader(
					new InputStreamReader(proc.getInputStream(), "UTF-8"));
			String outLine;
			while ((outLine = bufferedReader.readLine()) != null) {
				System.out.println(outLine);
			}
			// 读取标准错误流
			BufferedReader brError = new BufferedReader(new InputStreamReader(
					proc.getErrorStream(), "UTF-8"));
			String errline = null;
			while ((errline = brError.readLine()) != null) {
				System.out.println(errline);
			}
			// waitFor()判断Process进程是否终止，通过返回值判断是否正常终止。0代表正常终止
			int c = proc.waitFor();
			if (c != 0) {
				System.out.println("error 1: "+ c);
				result.put("resultCode", "999999");
				result.put("message", "执行gradlebuild.sh异常终止");
				return result;
			}
		} catch (IOException e1) {
			e1.printStackTrace();
			System.out.println("error 2 ");
			result.put("resultCode", "999999");
			result.put("message", "执行gradlebuild.sh异常终止");
			return result;
		} catch (Exception e1) {
			System.out.println("error 3 ");
			e1.printStackTrace();
			result.put("resultCode", "999999");
			result.put("message", "执行gradlebuild.sh异常终止");
			return result;
		}
		return result;
	}

	@RequestMapping(value = "/toDownloadPage")
	public String toDownloadPage(HttpServletRequest request,
			HttpServletResponse response) {
		SFTPUtils sftp = new SFTPUtils();
		String type = request.getParameter("type");
		type = type == null ? "1" : type;
		List<String> fileList = sftp.getFileList(type);
		request.setAttribute("type", type);
		if (fileList.size() > 0) {
			request.setAttribute("fileList", fileList);
		}
		return "user/downloadCenter";
	}

	@RequestMapping(value = "/download")
	public String download(HttpServletRequest request,
			HttpServletResponse response) {
		String fileId = request.getParameter("fileId");
		String type = request.getParameter("type");
		ByteArrayOutputStream input = null;
		BufferedOutputStream out = null;

		if (!StringUtil.isBlank(fileId)) {
			try {
				if ("2".equals(type)) {
					fileId = URLDecoder.decode(fileId);
					String path = directory + SFTPConstants.SFTP_DIR_DOC
							+ fileId;
					File file = new File(path);
				}
				System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%" + fileId
						+ "********************************");
				SFTPUtils sftp = new SFTPUtils();
				String fileName = "PaaS平台-MDS.doc";
				fileName = new String(fileId.getBytes("gb2312"), "UTF-8");
				input = sftp.download(fileName, type);
				response.reset();
				response.setContentType("application/x-msdownload");
				response.setHeader(
						"Content-Disposition",
						"attachment;filename="
								+ new String(fileId.getBytes("UTF-8"),
										"iso-8859-1"));
				response.addHeader("contentCharSet ", "utf-8");
				out = new BufferedOutputStream(response.getOutputStream());
				out.write(input.toByteArray());
				out.close();
			} catch (IOException e) {
				logger.error("ftp下载异常" + e.getMessage());
			} catch (SFTPException e) {
				logger.error("资源文件不存在" + e.getMessage());
				request.setAttribute("message", "该文件不存在！");
				request.setAttribute("type", type);
				return "user/downloadCenter";
			}
		}

		request.setAttribute("type", type);
		return null;
	}

	@RequestMapping(value = "/doRegister", produces = "text/html;charset=UTF-8")
	public @ResponseBody String register(@RequestParam String email,
			String password, String userOrgName, String mobileNumber,Integer orgId,
			HttpServletRequest request) {
		String res = null;
		try {
			Gson son = new Gson();
			UserVo uv = new UserVo();
			uv.setUserEmail(email);
			uv.setUserOrgName(userOrgName);
			uv.setUserPhoneNum(mobileNumber);
			uv.setUserPwd(CiperUtil.encrypt(SECURITY_KEY, password));
			uv.setUserState("1");
			uv.setUserInsideTag("1");
			uv.setUserRegisterTime(new Timestamp(new Date().getTime()));
			uv.setUserId(UUIDTool.genId32());
			uv.setPid(UUIDTool.genId32());
			uv.setOrgId(orgId);

			RegisterResult rr = iUser.registerUser(uv);
			
			//保存用户及组织关系
			OrgnizeUserInfoVo ov= new OrgnizeUserInfoVo();
			ov.setOrgId(orgId);
			ov.setUserId(uv.getUserId());
			iOrgUser.saveOrgnizeUserInfo(ov);

			/** 通过portal发送邮件 **/
			if (rr.isNeedSend() && rr.getEmail() != null) {
				emailSrv.sendEmail(rr.getEmail());
			}

			HttpSession session = request.getSession();
			session.setAttribute("email", email);
			session.setAttribute(email, System.currentTimeMillis());
			res = son.toJson(rr);
		} catch (Exception e) {
			logger.error(e.getMessage(), e);
			throw new RuntimeException(e);
		}

		return res;
	}

	@RequestMapping(value = "/updatebyKey", produces = "text/html;charset=UTF-8")
	public @ResponseBody String updatebyKey(@RequestParam String userId,
			String oldEmail, String newEmail, HttpServletRequest request) {

		UserVo uv = new UserVo();
		uv.setUserId(userId);
		if (newEmail != null && !"".equals(newEmail)) {
			uv.setUserEmail(newEmail); // 将新密码给 当前的UserEmail
		}
		if (oldEmail != null && !"".equals(oldEmail)) {
			uv.setOldEmail(oldEmail); // NewEmail 其实其实相当于oldEmail
			// uv.setUserEmail(userEmail);
		}
		int rr = 0;
		try {
			rr = iUser.updatebyKey(uv);
			logger.info("UserController:rr" + rr);
		} catch (PaasException e) {
			e.printStackTrace();
		}
		return "" + rr;
	}

	@RequestMapping(value = "/updateUserPs", produces = "text/html;charset=UTF-8")
	public @ResponseBody String updateUserPs(@RequestParam String userId,
			String newPwd, String oldPwd, String userEmail,
			HttpServletRequest request) {

		UserVo uv = new UserVo();
		String rr = "{\"resultCode\":999999}";
		uv.setUserId(userId);
		if (newPwd != null && !"".equals(newPwd)) {
			uv.setNewPwd(CiperUtil.encrypt(SECURITY_KEY, newPwd));
		}
		if (oldPwd != null && !"".equals(oldPwd)) {
			uv.setUserPwd(CiperUtil.encrypt(SECURITY_KEY, oldPwd));
		}
		if (userEmail != null && !"".equals(userEmail)) {
			uv.setUserEmail(userEmail);
		} else {
			return rr;
		}
		try {
			rr = iUser.updateUserPs(uv);
			logger.info("UserController:rr" + rr);
		} catch (PaasException e) {
			e.printStackTrace();
		}
		return rr;
	}

	@RequestMapping(value = "/uniqueEmail", produces = "text/html;charset=UTF-8")
	public @ResponseBody void uniqueEmail(@RequestParam String email,
			HttpServletResponse response) {
		try {
			boolean res = iUser.uniqueEmail(email);
			response.getWriter().print(res);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@RequestMapping(value = "/uniqueEmail_update", produces = "text/html;charset=UTF-8")
	public @ResponseBody String uniqueEmail_update(@RequestParam String email,
			HttpServletResponse response) {
		boolean result = false;
		try {
			result = iUser.uniqueEmail(email);
			logger.info("UserController>>>>>>>>>>>>>>uniqueEmail_update>>>result"
					+ result + email);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		return "" + result;
	}

	@RequestMapping(value = "/uniquePhone", produces = "text/html;charset=UTF-8")
	public @ResponseBody void uniquePhone(@RequestParam String phone,
			HttpServletResponse response) {
		try {
			boolean res = iUser.uniquePhone(phone);
			response.getWriter().print(res);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

	@RequestMapping(value = "/verfiy_email")
	public String verfiy_email(@RequestParam String token) throws PaasException {
		Assert.notNull(token, "token is null");
		iUser.verfiy_email(CiperUtil.decrypt(SECURITY_KEY, token));
		return "user/registerSuccess";
	}

	@RequestMapping(value = "/userOrgName", method = { RequestMethod.POST }, produces = "application/json;charset=utf-8")
	public @ResponseBody String userOrgName(HttpServletRequest request,
			HttpServletResponse response) {
		String NT_name = request.getParameter("NT_name");
		JSONObject objresult = new JSONObject();

		Map map = new HashMap();
		if (NT_name != null || !"".equals(NT_name)) {
			map.put("ntAccount", NT_name); // nt账号 "mapl"
											// userOrgNameEmail.split("@asiainfo")[0]
		}

		String result = null;
		Map<String, String> outMap = new HashMap<String, String>();
		try {
			Gson gson = new Gson();
			String json = gson.toJson(map);
			String url = "/user/iUserApi/getAiEmployeeInfo";
			String portalDubboUrl = SystemConfigHandler.configMap
					.get("CONTROLLER.CONTROLLER.url");
			result = HttpClientUtil.sendPostRequest(portalDubboUrl + url, json);

			Map resmap = GsonUtil.fromJSon(result, HashMap.class);
			String object = (String) resmap.get("object");
			Gson gson2 = new Gson();
			List<Map<String, Object>> list = gson2.fromJson(object,
					new TypeToken<List<Map<String, Object>>>() {
					}.getType());
			Map lais = list.get(0);
			JSONObject jsonww = new JSONObject(lais);
			jsonww.put("responseCode", resmap.get("responseCode"));
			result = jsonww.toString();
			logger.info("MAIN return>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>. :"
					+ result);
		} catch (IOException e) {
			logger.error(e.getMessage(), e);
			objresult.put("responseCode", "999999");
			objresult.put("mssage", "请求出错！");
		} catch (URISyntaxException e) {
			logger.error(e.getMessage(), e);
			objresult.put("responseCode", "999999");
			objresult.put("mssage", "请求出错！");
		}

		return result;
	}

	public static void main(String[] args) {
		String a, b = null;
		// try {
		/*
		 * a =HttpClientUtil.sendPostRequest(
		 * "http://127.0.0.1:20881/ipaas/user/iUserApi/getAiEmployeeInfo",
		 * "{\"ntAccount\":\"dingyi5\"}");
		 * System.out.println("\n\nSSSSSSSSSSSSSS:"+a);
		 */
		String subject = "亚信云  激活验证链接"; // Constants.SENDEMAIL
		String s = HttpRequestUtil.sendPost(
				"http://10.1.228.200:14201/iPaas-Web/email/sendEmail",
				"subject=" + subject + "&toSenders=" + "haoyh@asiainfo.com");
		// http://10.1.228.200:14201/iPaas-Web/email/sendEmail
		System.out.println(s);
		// b =
		// HttpRequestUtil.sendPost("http://10.1.228.198:14815/iPaas-Web/email/sendEmail","subject=1&content="+content+"&toSenders=majh5@asiainfo.com");
		// String token =
		// DigestUtils.sha512Hex("697CB33E9F824CCD856BE85A4EDCA8C6"+SECURITY_KEY);
		// System.out.println(token);
		// long s = System.currentTimeMillis();
		// String param
		// ="{\"userId\":\"FFF49D0D518948D0AB28D7A8EEE25D03\",\"applyType\":\"create\",\"serviceId\":\"1\",\"capacity\":\"512\",\"haMode\":\"single\"}";
		// EmailUtil.email("2", "3", "540576141@qq.com");
		// System.out.println("---------- 耗时："+(System.currentTimeMillis()-s));
		// } catch (Exception e) {
		// e.printStackTrace();
		// }
	}
}
