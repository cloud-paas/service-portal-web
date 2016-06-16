package com.ai.paas.ipaas.config.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URISyntaxException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ai.paas.ipaas.PaasRuntimeException;
import com.ai.paas.ipaas.config.param.ConfigRequestParam;
import com.ai.paas.ipaas.system.constants.Constants;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.ICcsConsoleDubboSv;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.ai.paas.ipaas.user.dubbo.vo.ResponseHeader;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageRequest;
import com.ai.paas.ipaas.user.dubbo.vo.SelectWithNoPageResponse;
import com.ai.paas.ipaas.user.dubbo.vo.UserProdInstVo;
import com.ai.paas.ipaas.user.vo.UserInfoVo;
import com.ai.paas.ipaas.zookeeper.SystemConfigHandler;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
@RequestMapping(value = "/config")
public class ConfigConsoleController {
	private Logger logger = Logger.getLogger(ConfigConsoleController.class);
	
	@Reference
	private ICcsConsoleDubboSv ccsConsoleDubboSv;
	
	@Reference
	private ISysParamDubbo iSysParam;
	
	@RequestMapping("/showService")
	public ModelAndView showService(HttpServletRequest request ,HttpServletResponse response) {
		ModelAndView view = new ModelAndView("config/ccsConsole");
		return view;
	}
	
	@RequestMapping("/selectService")
	@ResponseBody
	public Map<String, Object> selectService(HttpServletRequest request ,HttpServletResponse response) {
		SelectWithNoPageResponse<UserProdInstVo> responseResult = null;
		Map<String, Object> result = new HashMap<String, Object>();
		try{
			UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
			String userId = userVo.getUserId();
			SelectWithNoPageRequest<UserProdInstVo> param = new SelectWithNoPageRequest<UserProdInstVo>();
			UserProdInstVo userProdInstVo = new UserProdInstVo();
			userProdInstVo.setUserId(userId);
			param.setSelectRequestVo(userProdInstVo);
			responseResult = ccsConsoleDubboSv.selectUserProdInsts(param);
			result.put("code", "000000");	
			result.put("resultCode", responseResult.getResponseHeader().getResultCode());
			result.put("resultMessage", responseResult.getResponseHeader().getResultMessage());
			result.put("resultList", responseResult.getResultList());			
		}catch(Exception e){
			logger.error(e.getMessage(),e);
		}
		return result;
	}
		
	@RequestMapping("/main/{serviceId}")
	public ModelAndView managerMain(HttpServletRequest request ,HttpServletResponse response,@PathVariable String serviceId) {
		UserInfoVo userVo = UserUtil.getUserSession(request.getSession());
		String userId = userVo.getUserId();	
		request.setAttribute("serviceId", serviceId);
		request.setAttribute("userId", userId);
		request.setAttribute("parentUrl", request.getParameter("pathUrl"));
		ModelAndView view = new ModelAndView("config/manage");
		return view;
	}
	
	/**
	 * 用户自定义配置--获取子节点，不分页传参数serviceId,path,keyword
	 *
	 * @param customConfigRequestPage
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/children/all")
	public String getCustomChildren(HttpSession session,@RequestBody ConfigRequestParam param) {
        String result = "";
		try {
			String iPaasDubboUrl = SystemConfigHandler.configMap.get("PASS.SERVICE.IP_PORT_SERVICE");
			String ccsListUrl =SystemConfigHandler.configMap.get("CCS_CUST.LIST_PATH_DATA.url");
			String address = iPaasDubboUrl + ccsListUrl;
			result = HttpClientUtil.sendPostRequest(address, new Gson().toJson(param));
		} catch (IOException | URISyntaxException e ) {
			e.printStackTrace();
		}
		return result;
	}	
		
	/**
	 * 用户自定义配置--新增
	 *
	 * @param customConfigRequestVo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/custom/add")
	public String customAdd(HttpSession session,@RequestBody ConfigRequestParam param) {
        String result = "";
		try {		
			String iPaasDubboUrl = SystemConfigHandler.configMap.get("PASS.SERVICE.IP_PORT_SERVICE");
			String ccsAddUrl =SystemConfigHandler.configMap.get("CCS_CUST.ADD.url");
			String address = iPaasDubboUrl + ccsAddUrl;
			result = HttpClientUtil.sendPostRequest(address, new Gson().toJson(param));
		} catch (IOException | URISyntaxException  e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 用户自定义配置--修改
	 *
	 * @param customConfigRequestVo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/custom/modify")
	public String customModify(HttpSession session,@RequestBody ConfigRequestParam param) {
        String result = "";
		try {		
			String iPaasDubboUrl = SystemConfigHandler.configMap.get("PASS.SERVICE.IP_PORT_SERVICE");
			String ccsModifyUrl = SystemConfigHandler.configMap.get("CCS_CUST.MODIFY.url");
			String address = iPaasDubboUrl + ccsModifyUrl;
			result = HttpClientUtil.sendPostRequest(address, new Gson().toJson(param));
		} catch (IOException | URISyntaxException  e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 自定义配置，获取配置信息，传参：serviceId,path
	 *
	 * @param customConfigRequestVo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/custom/get")
	public String getCustomConfig(HttpServletRequest req,@RequestBody ConfigRequestParam param) {
        String result = "";
		try {			
			String iPaasDubboUrl = SystemConfigHandler.configMap.get("PASS.SERVICE.IP_PORT_SERVICE");
			String ccsGetUrl = SystemConfigHandler.configMap.get("CCS_CUST.GET.url");
			String address = iPaasDubboUrl + ccsGetUrl;
			logger.info("address---yinzf:"+address);
//			System.out.println("address---yinzf:"+address);
			result = HttpClientUtil.sendPostRequest(address, new Gson().toJson(param));
//			System.out.println("result---yinzf:"+result);
			logger.info("result---yinzf:"+result);
		} catch (IOException | URISyntaxException  e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 用户自定义配置--删除
	 *
	 * @param customConfigRequestVo
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/custom/deleteBatch")
	public String customDelete(HttpSession session,@RequestBody List<ConfigRequestParam> paramList) {
        String result = "";
		try {			
			String iPaasDubboUrl = SystemConfigHandler.configMap.get("PASS.SERVICE.IP_PORT_SERVICE");
			String ccsBatchDelUrl = SystemConfigHandler.configMap.get("CCS_CUST.DELETE_BATCH.url");
			String address = iPaasDubboUrl + ccsBatchDelUrl;
			result = HttpClientUtil.sendPostRequest(address, new Gson().toJson(paramList));
		} catch (IOException | URISyntaxException  e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/**
	 * 下载路径下的所有值
	 *
	 * @param customConfigRequestVo
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/download")
	public void downLoadFile(HttpServletRequest req,HttpServletResponse res) throws Exception {
		Properties properties = new Properties();
		File file = new File("ccsInfomation.properties");
		createFile(file);
//		String userId = (String) session.getAttribute("userId");
//		String serviceId = (String) session.getAttribute("serviceId");
		String userId = req.getParameter("userId");
		String serviceId = req.getParameter("serviceId");
		ConfigRequestParam param = new ConfigRequestParam();
		param.setPath("/");
		param.setServiceId(serviceId);
		param.setUserId(userId);
		String result = "";
		Gson gson = new Gson();
		try {	
			String iPaasDubboUrl = SystemConfigHandler.configMap.get("PASS.SERVICE.IP_PORT_SERVICE");
			String ccsDownloadUrl = SystemConfigHandler.configMap.get("CCS_CUST.DOWNLOAD.url");
			String address = iPaasDubboUrl + ccsDownloadUrl;
			result = HttpClientUtil.sendPostRequest(address, gson.toJson(param));	
			Map<String,Object> map = gson.fromJson(result, new TypeToken<Map<String,Object>>(){}.getType());
			if(map.get("resultCode").equals("000000")){
				Map<String,String> data = (Map<String, String>) map.get("data");
				for(Entry<String, String> pathData : data.entrySet()){
					properties.setProperty(pathData.getKey(), pathData.getValue());
				}
				FileOutputStream fos = new FileOutputStream(file); 
				properties.store(fos, "Configuration center configuration information");// 向新文件存储
			}	
		}catch(Exception e){
			logger.error(e.getMessage(),e);
		}  
		OutputStream os = res.getOutputStream(); 
	    try {  
	        res.reset();  
	        res.setHeader("Content-Disposition", "attachment; filename=ccsInfomation.properties");  
	        res.setContentType("application/octet-stream; charset=utf-8");  
	        os.write(FileUtils.readFileToByteArray(file));  
	        os.flush();  
	    } finally {  
	        if (os != null) {  
	            os.close();  
	        }  
	    }  
	}
	
	/**
	 * 创建文件
	 * 
	 * @param fileName
	 * @return
	 */
	public void createFile(File fileName) throws Exception {
		try {
			if (!fileName.exists()) {
				fileName.createNewFile();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
		
	/**
	 * 用户自定义配置---批量新增，properties文件
	 *
	 * @param session
	 * @param file
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "/custom/upload/{userId}")
	public String customUpload(HttpSession session, HttpServletRequest request,@RequestParam MultipartFile uploadFile,@PathVariable String userId) throws Exception {
//		String userId = (String) session.getAttribute("userId");
//		serviceId = (String) session.getAttribute("serviceId");
		String serviceId = userId.split(",")[1];
		userId = userId.split(",")[0];
		logger.info("yinzf------serviceId---:"+serviceId);
		logger.info("yinzf------userid---:"+userId);
		String result = "";
		try {
			String fileName = uploadFile.getOriginalFilename();
			if (!fileName.endsWith(".properties"))
				return "{\"resultCode\":\"666666\",\"resultMessage\":\"只支持以.property结尾的文件\"}";
			InputStream in = uploadFile.getInputStream();
			Properties props = new Properties();
			props.load(in);
			Iterator it=props.entrySet().iterator();
			List<ConfigRequestParam> paramList = new ArrayList<ConfigRequestParam>();
			while(it.hasNext()){
			    Map.Entry entry=(Map.Entry)it.next();
			    Object key = entry.getKey();
			    Object value = entry.getValue();
			    ConfigRequestParam param= new ConfigRequestParam();
			    param.setUserId(userId);
			    param.setServiceId(serviceId);
			    param.setData((String)value);
			    param.setPath(formatPath((String)key));
			    paramList.add(param);
			}		
			try {
				String iPaasDubboUrl = SystemConfigHandler.configMap.get("PASS.SERVICE.IP_PORT_SERVICE");
				String ccsBatchAddUrl = SystemConfigHandler.configMap.get("CCS_CUST.ADD_BATCH.url");
				String address = iPaasDubboUrl + ccsBatchAddUrl;
				result = HttpClientUtil.sendPostRequest(address, new Gson().toJson(paramList));
			} catch (IOException | URISyntaxException e) {
				e.printStackTrace();
			}
		} catch (PaasRuntimeException e) {
			throw new Exception();
		} catch (IOException e) {
			throw new Exception();
		}
		return result;
	}
	
	/**
	 * CCS注销
	 * 
	 * @return
	 */
	@RequestMapping(value = "/cancleCcs")
	@ResponseBody
	public Map<String, Object> cancleCcs(HttpServletRequest req, HttpServletResponse resp) {
		Map<String, Object> result = new HashMap<String, Object>();
		String userServId=req.getParameter("userServId");
		UserInfoVo userVo = UserUtil.getUserSession(req.getSession());
		ResponseHeader responseHeader = new ResponseHeader();
		UserProdInstVo vo = new UserProdInstVo();
		vo.setUserId(userVo.getUserId());
		vo.setUserServId(Long.parseLong(userServId));;
		try {
			// 注销
			responseHeader = ccsConsoleDubboSv.cancleUserProdInst(vo);
			result.put("resultCode", responseHeader.getResultCode());
			result.put("resultMessage", responseHeader.getResultCode());
		} catch (Exception e) {
			result.put("resultCode", Constants.OPERATE_CODE_FAIL);
			result.put("resultMessage", "注销异常！");
			logger.error(e.getMessage(),e);
		}
		return result;
	}
	
	public String formatPath(String path){
		if(!path.startsWith("/")){
			return "/"+path;
		}
		return path;
	}
}
