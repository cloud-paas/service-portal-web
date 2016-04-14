package com.ai.paas.ipaas.storm.task.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLClassLoader;
import java.nio.ByteBuffer;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ai.paas.agent.client.AgentClient;
import com.ai.paas.ipaas.rcs.common.IFlowDefine;
import com.ai.paas.ipaas.rcs.common.Module;
import com.ai.paas.ipaas.rcs.param.BoltParam;
import com.ai.paas.ipaas.rcs.param.FlowParam;
import com.ai.paas.ipaas.rcs.param.SpoutParam;
import com.ai.paas.ipaas.storm.sys.conf.Constants;
import com.ai.paas.ipaas.storm.sys.conf.StormParam;
import com.ai.paas.ipaas.storm.sys.utils.AgentClientUtil;
import com.ai.paas.ipaas.storm.sys.utils.HttpResponseUtils;
import com.ai.paas.ipaas.storm.sys.utils.RestletClientUtils;
import com.ai.paas.ipaas.storm.sys.utils.StringUtils;
import com.ai.paas.ipaas.storm.task.vo.PageResult;
import com.ai.paas.ipaas.storm.task.vo.PageSelectValue;
import com.ai.paas.ipaas.storm.task.vo.StormClusterInfoVo;
import com.ai.paas.ipaas.storm.task.vo.StormTaskBoltVo;
import com.ai.paas.ipaas.storm.task.vo.StormTaskInfoVo;
import com.ai.paas.ipaas.storm.task.vo.StormTaskSpoutVo;
import com.ai.paas.ipaas.system.util.HttpClientUtil;
import com.ai.paas.ipaas.system.util.UserUtil;
import com.ai.paas.ipaas.user.dubbo.interfaces.IOrder;
import com.ai.paas.ipaas.user.dubbo.interfaces.ISysParamDubbo;
import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

/**
 * Storm Task Managment.
 * 
 * @author yuanman
 * @since 2015-06-22
 * 
 */
@Controller
@RequestMapping(value = "/rcs")
public class StormTaskController {
	private static final Logger logger = LogManager.getLogger(StormTaskController.class.getName());
	
	private static final String JAVA_DATE_FORMATTER = "yyyyMMddHHmmss";
	
	@Reference
	private IOrder iOrder;
	
	@Reference
	private ISysParamDubbo iSysParam;
	
	/** TODO:need to config these data in DB. **/
	private static final String RCS_SERVICE_SHOWLIST = "http://10.1.228.198:10888/ipaas/rcs/manage/showList";
	private static final String RCS_SERVICE_REGISTE_TASK = "http://10.1.228.198:10888/ipaas/rcs/manage/registerTask";
	private static final String RCS_SERVICE_TASK_LIST = "http://10.1.228.198:10888/ipaas/rcs/manage/getTask";
	private static final String RCS_SERVICE_CLUSTER_LIST = "http://10.1.228.198:10888/ipaas/rcs/manage/getCluster";
	private static final String RCS_SERVICE_OPER_TASK = "http://10.1.228.198:10888/ipaas/rcs/manage/operTask";
	private static final String STORM_CLUSTER_URL = "10.1.249.31:60001";
	private static final String STORM_PATH_FOR_JAR_FILE = "/unibss/pocusers/devstp01/topologyToPublish";
	private static final String STORM_PATH_FOR_BIN_PATH = "/unibss/pocusers/devstp01/apache-storm-0.9.3/bin";
	private static final String STORM_COMMAND_FOR_START = "/unibss/pocusers/devstp01/apache-storm-0.9.3/bin/storm jar ";

	@RequestMapping(value = "/toList")
	public String toList(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		try {
			int currentPage = StringUtils.trimIntDefaultOne(request.getParameter("page"), "page");
			int pageSize = StringUtils.trimIntDefaultTen(request.getParameter("size"), "size");
			String searchName = request.getParameter("searchName") == null ? ""
					: StringUtils.trimOrReturnNullWithDecode(request
							.getParameter("searchName"));

			String params = "{\"currentPage\":\"" + currentPage
					+ "\",\"PageSize\":\"" + pageSize + "\",\"name\":\"" + searchName 
					+ "\",\"userID\":\"" + UserUtil.getUserSession(session).getUserId() + "\"}";
			
			/** Call Service that to show the task list. **/
			String str = HttpClientUtil.sendPostRequest(RCS_SERVICE_SHOWLIST, params);

			Gson gson = new Gson();
			PageResult<StormTaskInfoVo> pagingResult = gson.fromJson(str,
					new TypeToken<PageResult<StormTaskInfoVo>>() {}.getType());
			request.setAttribute("pagingResult", pagingResult);
		} catch (Exception e) {
			logger.error("++++++ To show the task list error! " + e.getMessage());
			e.printStackTrace();
		}
		
		return "/storm/task/rcsConsole";
	}

	/**
	 * click "register" button, jump to "registerTask.jsp".
	 * 
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/toRegisterTask")
	public String toRegisterTask(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		try {
			String userId = UserUtil.getUserSession(session).getUserId();
			logger.info("++++++ userId is:" + userId);

			/** Call Service to get the cluster info. **/
			String str = HttpClientUtil.sendPostRequest(RCS_SERVICE_CLUSTER_LIST, userId);

			Gson gson = new Gson();
			PageSelectValue<StormClusterInfoVo> result = gson.fromJson(str,
					new TypeToken<PageSelectValue<StormClusterInfoVo>>() {}.getType());

			logger.info("++++++ get cluster info ,the result is:" + result.toString());
			
			request.setAttribute("pageSelectValue", result);
		} catch (Exception e) {
			logger.error("++++++ To get the cluster info error! " + e.getMessage());
			e.printStackTrace();
		}

		return "/storm/task/registerTask";
	}

	/**
	 * create a new storm task.
	 * 
	 * @param request
	 * @param response
	 * @param session
	 */
	@RequestMapping(value = "/registerTask")
	public void registerTask(HttpServletRequest request,
			HttpServletResponse response, HttpSession session) {
		
		try {
			/** 1. to convert request to stormTaskInfoVo. **/
			Gson gson = new Gson();
			StormTaskInfoVo vo = convertReqToVo(request, session);
			String params = gson.toJson(vo);

			/** 2.upload jar file to nimbus. **/
			uploadFileToNimbus(request);

			/** 3.call rcs service for registe task. **/
			String res = HttpClientUtil.sendPostRequest(RCS_SERVICE_REGISTE_TASK, params);
			if (res.equals("false")) {
				HttpResponseUtils.responseFailed(response, "任务名称重复，新建任务失败。", null);
				return;
			}
			
			/** 4.set response value. **/
			HttpResponseUtils.responseSuccess(response, "新建实时计算任务成功！", null);
		} catch (Exception e) {
			logger.error("++++++ 新建实时计算任务失败，系统错误！", e.getMessage());
			HttpResponseUtils.responseError(response, "新建实时计算任务失败，系统异常：" + e.getMessage(), e);
		}
	}

	/**
	 * upload the file of "xxx.jar" to nimbus.
	 * 
	 * @throws Exception
	 */
	private void uploadFileToNimbus(HttpServletRequest request) throws Exception {
		String uploadFilePath = StringUtils.trimOrNullAndBlankException(
				request.getParameter("jarFilePath"), "jarFilePath");
		RestletClientUtils.uploadFile(STORM_CLUSTER_URL,
				STORM_PATH_FOR_JAR_FILE + "/" + new File(uploadFilePath).getName(), new FileInputStream(uploadFilePath));
	}
	
	/**
	 * convert request to object that is StormTaskInfoVo.
	 * 
	 * @param request
	 * @param session
	 * @return
	 * @throws Exception
	 */
	private StormTaskInfoVo convertReqToVo(HttpServletRequest request, HttpSession session) throws Exception {
		String name = StringUtils.trimOrNullAndBlankException(
				request.getParameter("name"), "计算任务名称");
		long clusterId = StringUtils.trimLongException(
				request.getParameter("clusterId"), "所属集群");
		int numWorkers = StringUtils.trimIntException(
				request.getParameter("numWorkers"), "work数量");
		String comments = StringUtils.trimOrReturnNull(request
				.getParameter("comments"));
		String jarFilePath = StringUtils.trimOrNullAndBlankException(
				request.getParameter("jarFilePath"), "jarFilePath");

		String[] spoutNameArray = request.getParameterValues("spoutName");
		String[] spoutClassNameArray = request.getParameterValues("spoutClassName");
		String[] spoutThreadsArray = request.getParameterValues("spoutThreads");

		String[] boltNameArray = request.getParameterValues("boltName");
		String[] boltClassNameArray = request.getParameterValues("boltClassName");
		String[] threadsArray = request.getParameterValues("threads");
		String[] groupingTypesArray = request.getParameterValues("groupingTypes");
		String[] groupingSpoutOrBlotsArray = request.getParameterValues("groupingSpoutOrBlots");

		StormTaskInfoVo stormTaskInfoVo = new StormTaskInfoVo();
		stormTaskInfoVo.setName(name);
		stormTaskInfoVo.setClusterId(clusterId);
		stormTaskInfoVo.setNumWorkers(numWorkers);
		stormTaskInfoVo.setComments(comments);
		stormTaskInfoVo.setjarfilepath(jarFilePath);
		stormTaskInfoVo.setRegisterUserId(UserUtil.getUserSession(session).getUserId());

		List<StormTaskSpoutVo> stormTaskSpoutVos = new ArrayList<StormTaskSpoutVo>();
		if (spoutNameArray != null) {
			for (int i = 0; i < spoutNameArray.length; i++) {
				StormTaskSpoutVo stormTaskSpoutVo = new StormTaskSpoutVo();
				stormTaskSpoutVo.setSpoutName(spoutNameArray[i]);
				stormTaskSpoutVo.setSpoutClassName(spoutClassNameArray[i]);
				stormTaskSpoutVo.setThreads(Integer.parseInt(spoutThreadsArray[i]));
				stormTaskSpoutVos.add(stormTaskSpoutVo);
			}
		}
		stormTaskInfoVo.setStormTaskSpoutVos(stormTaskSpoutVos);

		List<StormTaskBoltVo> stormTaskBoltVos = new ArrayList<StormTaskBoltVo>();
		if (boltNameArray != null) {
			for (int i = 0; i < boltNameArray.length; i++) {
				StormTaskBoltVo stormTaskBoltVo = new StormTaskBoltVo();
				stormTaskBoltVo.setBoltName(boltNameArray[i]);
				stormTaskBoltVo.setBoltClassName(boltClassNameArray[i]);
				stormTaskBoltVo.setThreads(Integer.parseInt(threadsArray[i]));
				stormTaskBoltVo.setGroupingTypes(groupingTypesArray[i]);
				stormTaskBoltVo.setGroupingSpoutOrBlots(groupingSpoutOrBlotsArray[i]);
				stormTaskBoltVos.add(stormTaskBoltVo);
			}
		}
		stormTaskInfoVo.setStormTaskBoltVos(stormTaskBoltVos);
		
		return stormTaskInfoVo;
	}

	/**
	 * click "showView" button, to do something.
	 * 
	 * @param request
	 * @param response
	 * @param model
	 */
	@RequestMapping(method = RequestMethod.POST, value = "/showRelatedParam")
	public void showRelatedParam(HttpServletRequest request,
			HttpServletResponse response, ModelMap model) {
		
		// 文件名
		String fileName;
		
		// 路径名
		String path;
		
		// 目标文件
		File targetFile;
		
		// Main函数名
		String mainName;

		logger.info("++++++ to show the jar infomation and to upload web host ++++++");
		
		//TODO:只有if，没有else，什么情况？需要重构。
		// 文件上传到web服务器
		if (request instanceof MultipartHttpServletRequest) {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile file = multipartRequest.getFile("myFile");
			
			// 获取包名，去除后缀名
			String packageName = file.getOriginalFilename().replaceAll("[.][^.]+$", "");
			
			// main函数名
			mainName = packageName + "." + packageName;

			SimpleDateFormat df = new SimpleDateFormat(JAVA_DATE_FORMATTER);
			String time = df.format(new Date());
			fileName = time + file.getOriginalFilename();
			
			logger.info("++++++ to upload web host starting ++++++");
			path = request.getSession().getServletContext().getRealPath("upload");
			logger.info("++++++ the upload path is:" + path);
			targetFile = new File(path, fileName);
			if (!targetFile.exists()) {
				targetFile.mkdirs();
			}

			// 保存
			try {
				file.transferTo(targetFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			model.addAttribute("fileUrl", request.getContextPath() + "/upload/" + fileName);

			// 解析jar包并执行方法
			try {
				String jarPath = path + "/" + fileName;
				File xFile = new File(jarPath);
				
				@SuppressWarnings("deprecation")
				URL xUrl = xFile.toURL();
				// 保证了两个类都在同一个类加载器中，不会再报找不到类异常。
				URLClassLoader ClassLoader = new URLClassLoader(
						new URL[] { xUrl }, Thread.currentThread()
								.getContextClassLoader());
				
				// 实例化类
				Class<?> xClass = ClassLoader.loadClass(mainName);
				IFlowDefine ifd = null;
				ifd = (IFlowDefine) xClass.newInstance();
				
				// 定义参数
				String[] args1 = new String[100];
				Module module = new Module("-1");
				FlowParam flowParam = new FlowParam();
				ifd.define(args1, module, flowParam);
				
				// 返回值
				String name = flowParam.getFlowName();
				String workNum = flowParam.getNumWorkers() + "";
				List<SpoutParam> lSpoutParam = module.getSpoutList();
				List<BoltParam> lBoltParam = module.getBoltList();
				
				// 关闭类加载器
				ClassLoader.close();
				
				try {
					// 返回json
					PrintWriter pw = response.getWriter();
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("name", name);
					jsonObject.put("workNum", workNum);
					jsonObject.put("lSpout", lSpoutParam);
					jsonObject.put("lBolt", lBoltParam);
					pw.write(jsonObject.toString());
					pw.flush();
				} catch (Exception e) {
					e.printStackTrace();
				} finally {
					try {
						response.getWriter().close();
					} catch (Exception ei) {
						ei.printStackTrace();
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * the operation of task：start、stop、cancel.
	 * 
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(value = "/operTask")
	public void operTask(HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		try {
			Gson gson = new Gson();
			String operType = StringUtils.trimOrNullAndBlankException(
					request.getParameter("operType"), "操作类型");
			long id = StringUtils.trimLongException(request.getParameter("id"), "id");
			
			String param = id + "";
			String getTask = HttpClientUtil.sendPostRequest(RCS_SERVICE_TASK_LIST, param);
			StormTaskInfoVo stormTaskInfoVo = gson.fromJson(getTask, StormTaskInfoVo.class);
			
			//TODO:业务逻辑混杂，需要重构。远程执行的命令需要动态生成，不可固化到程序中。

			/** 启动计算任务 **/
			if ("start".equalsIgnoreCase(operType)) {
				String startCmd = STORM_COMMAND_FOR_START
						+ StringUtils.getFileName(stormTaskInfoVo.getjarfilepath())
						+ " com/ai/pass/ipaas/rcs/Flow "
						+ stormTaskInfoVo.getName()
						+ " WordCounter.WordCounter "
						+ StormParam.StartParam.level
						+ " "
						+ StormParam.StartParam.dbConnect
						+ " "
						+ StormParam.StartParam.uname
						+ " "
						+ StormParam.StartParam.password + " REMOTE words.txt";

				logger.debug(startCmd);

				RestletClientUtils.exeCmd(STORM_CLUSTER_URL, STORM_PATH_FOR_JAR_FILE, startCmd);
				
			} else if ("cancel".equalsIgnoreCase(operType)) {
				/*
				 * 1. 如果任务正在运行，需要stop任务； 2. 删除该任务对应的jar包，分布在 web 服务器 和
				 * storm的主节点（nimbus）上。 3. 删除对应的日志文件。（非必要） 4.
				 * 更新集群中对应记录的状态为，未开通。(rcs_cluster_info) 5.
				 * 删除任务表中的对应记录。（rcs_task_info）
				 */
			} else if ("stop".equalsIgnoreCase(operType)) {
				String stopCmd = "storm kill " + stormTaskInfoVo.getName();
				logger.debug(stopCmd);
				RestletClientUtils.exeCmd(STORM_CLUSTER_URL, STORM_PATH_FOR_BIN_PATH, stopCmd);
			}
			
			String paramsOpr = "{\"operType\":\"" + operType + "\",\"id\":\"" + id + "\"}";
			String operTask = HttpClientUtil.sendPostRequest(RCS_SERVICE_OPER_TASK, paramsOpr);
			logger.info("++++++ the operation task is ：" + operTask);
			
			HttpResponseUtils.responseSuccess(response, "to operate task is successful", null);
		} catch (Exception e) {
			logger.error("++++++ to operate task is failure, system error.", e);
			HttpResponseUtils.responseError(response, "system error：" + e.getMessage(), e);
		}
	}

	/**
	 * 实时计算任务列表页中，选定某任务后点击“日志”按钮的处理方法。
	 * 		页面会跳转到计算任务日志查看页面（logView.jsp）。
	 * 
	 * @param response
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/toLookLog")
	public String toLookLog(HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		try {
			// 获取拓扑id
			String topologyId = StringUtils.trimOrNullAndBlankException(
					request.getParameter("topologyId"), "任务id");
			String command = "find ./ -name '*topology-" + topologyId + "*'";
			
			logger.info("++++++++ (to look storm log) the topologyId is " + topologyId);
			logger.info("++++++++ the command is:" + command);
			
			String url = "";
			String result = null;
			
			// 创建map容器用于存放主机与该主机上日志文件
			Map<String, String[]> logsOnHosts = new HashMap<String, String[]>();
			
			// 获取所有supervisor主机ip地址
			String[] hosts = Constants.StormClusterInfo.logsHostName;
			for (String host : hosts) {
				logger.info("++++++++ to excute the command ++++++++");
				
				url = "http://" + host + ":60001/cmd/run";
				logger.info("++++++++ the url is " + url);
				
				// 获取该主机下该任务的所有日之文件名
				// 通过agent客户端工具访问一下各个主机上属于该任务（拓扑）的日志文件
				//AgentClient agentcl = new AgentClient(host, 60001);
				//result = agentcl.executeInstruction(Constants.LogInfo.LOG_DIR, command);
				
				// 使用老版本的Agent，远程执行命令的方法。(2015-06-30)
				result = AgentClientUtil.doRemoteCommand(url, Constants.LogInfo.LOG_DIR, command);
				
				logger.info("++++++++ the result is {" + result + "}");
				
				if (result == null || "".equals(result.trim())) {
					continue;
				}
				
				// 去掉因为find命令产生文件名“./”前缀
				String[] files = result.replaceAll("\\s./", " ").trim()
						.split("\\s{1,}");
				
				logsOnHosts.put(host, files);
			}
			
			// 打印日志
			logger.info("++++++" + logsOnHosts.keySet());
			
			// 将logsOnHosts放入到request作用域中
			request.setAttribute("logsOnHosts", logsOnHosts);
			
			// 传递topologyId
			request.setAttribute("topologyId", topologyId);
			
			return "storm/task/logView";
		} catch (Exception e) {
			logger.error(e);
			throw new Exception("系统异常", e);
		}
	}

	/**
	 * to view the Host log of stormTask.
	 * 
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping(value = "/lookLog")
	public void lookLog(HttpServletResponse response, HttpServletRequest request)
			throws Exception {
		BufferedReader reader = null;
		PrintWriter writer = null;
		try {
			// 获取根目录
			String rootPath = request.getContextPath();
			// 获取日志所在主机名以及日志文件名
			String hostName = StringUtils.trimOrNullAndBlankException(
					request.getParameter("hostName"), "日志文件所在主机名");
			String logName = StringUtils.trimOrNullAndBlankException(
					request.getParameter("fileName"), "日志文件名");
			String startPos = StringUtils.trimOrReturnNull(request
					.getParameter("start"));
			String pageLength = StringUtils.trimOrReturnNull(request
					.getParameter("length"));
			
			// 通过http协议发送请求logviewer获取日志文件！
			String uri = "http://" + hostName + ":"
					+ Constants.LogInfo.LOGVIEWER_PORT + "/log?file=" + logName
					+ (startPos == null ? "" : ("&start=" + startPos))
					+ (pageLength == null ? "" : ("&length=" + pageLength));
			
			logger.info("++++++ the logviewer uri is:" + uri);
			
			HttpClient httpclient = new HttpClient();
			GetMethod httpget = new GetMethod(uri);
			httpclient.executeMethod(httpget);    ///初始化httpget

			InputStream is = httpget.getResponseBodyAsStream();
			reader = new BufferedReader(new InputStreamReader(is));
			
			// 获取输出流
			writer = response.getWriter();
			String line = null;
			String pageString = "<div class=\"pagination\">[\\w\\W]*</div>";
			String headString = "<head>[\\w\\W]*</head>";
			String titleString = "<h3>[\\w\\W]*</h3>";
			String downLoadString = "<p>[\\w\\W]*</p>";
			Pattern pagePattern = Pattern.compile(pageString);
			Pattern headPattern = Pattern.compile(headString);
			
			logger.info("++++++ to readline start ++++++");
			
			while ((line = reader.readLine()) != null) {
				if (headPattern.matcher(line).find()) {
					// 替代html文件流中的<head>节点，输入流中的<head>和</head>两个节点必须在同一行
					line = line
							.replaceFirst(
									headString,
									Constants.LogInfo.LOGVIEWER_HTML_HEAD
											.replace("${ROOT_PATH}", rootPath))
							// 去除标题
							.replaceFirst(titleString, "")
							// 修改下载
							.replaceFirst(
									downLoadString,"");
					//为了与Agent版本一致，暂时屏蔽日志文件下载功能。（2015-06-29）
//									"<p><a href=\"" + rootPath
//											+ "/rcs/downloadLog?hostName="
//											+ hostName + "&fileName=" + logName
//											+ "\">下载全部日志信息</a></p>");
				}
				// 替代html文件流中分页连接地址
				if (!pagePattern.matcher(line).find()) {
					writer.write(line + System.getProperty("line.separator"));
					continue;
				} else {
					// 获取上一页以及下一页的开始位置
					Pattern startPattern = Pattern.compile("start=\\d{2,}");
					Matcher startMatcher = startPattern.matcher(new String(line));
					line = line.replaceFirst(
							"<div class=\"pagination\">[\\w\\W]*</div>",
							Constants.LogInfo.LOGVIEWER_HTML_PAGINATION);
					if (!"0".equals(startPos)
							&& !Constants.LogInfo.LOGVIEWER_DEFAUL_PAGE_SIZE
									.equals(startPos)) {
						line = line
								.replace(
										Constants.LogInfo.LOGVIEWER_PAGINATION_PAGE_PREV_START,
										startMatcher.find() ? startMatcher
												.group() : "start=null");
					} else if ("0".equals(startPos)
							|| Constants.LogInfo.LOGVIEWER_DEFAUL_PAGE_SIZE
									.equals(startPos)) {
						line = line
								.replace(
										Constants.LogInfo.LOGVIEWER_PAGINATION_PAGE_PREV_START,
										"start=0");
					} else {
						// 目前不存在
					}

					if (startMatcher.find()) {
						line = line
								.replace(
										Constants.LogInfo.LOGVIEWER_PAGINATION_PAGE_NEXT_START,
										startMatcher.group());
					}
					// 进行变量替换
					line = line
							.replace(
									Constants.LogInfo.LOGVIEWER_PAGINATION_URI_ROOT,
									rootPath + "/rcs/lookLog")
							.replace(
									Constants.LogInfo.LOGVIEWER_PAGINATION_HOST_NAME,
									hostName)
							.replace(
									Constants.LogInfo.LOGVIEWER_PAGINATION_FILE_NAME,
									logName);//
					writer.write(line + System.getProperty("line.separator"));
				}
			}
			
			writer.flush();
			httpget.releaseConnection();
		} catch (Exception e) {
			logger.error("系统错误", e);
			HttpResponseUtils.responseError(response, "系统异常：" + e.getMessage(), e);
		} finally {
			try {
				if (reader != null)
					reader.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
			try {
				if (writer != null)
					writer.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	/**
	 * 查看storm主机上的日志文件后的“下载全量日志”功能的处理方法。
	 * 
	 * @param response
	 * @param request
	 * @throws Exception
	 */
	@RequestMapping("/downloadLog")
	public void downloadLog(HttpServletResponse response,
			HttpServletRequest request) throws Exception {
		
		InputStream is = null;
		BufferedInputStream bis = null;
		BufferedOutputStream bos = null;
		OutputStream os = null;
		
		try {
			// 1.获取日志所在主机地址以及日志文件名
			String host = StringUtils.trimOrNullAndBlankException(
					request.getParameter("hostName"), "日志文件所在主机名");
			String logName = StringUtils.trimOrNullAndBlankException(
					request.getParameter("fileName"), "日志文件名");
			
			// 2.组织日志下载的uri和文件目录
			String uri = "http://" + host + ":" + Constants.AGENT_INFO.PORT
					+ Constants.AGENT_INFO.REMOTE_DOWNLOAD_SV_CODE;
			String filePath = Constants.LogInfo.LOG_DIR + "/" + logName;
			logger.info("++++++ the file uri:" + uri + ", filePath is:" + filePath);
			
			// 3.调用代理获取文件输入流  (使用新版Agent的方法，由于日志文件下载功能已屏蔽，暂不用恢复老版本 2015-06-30)
			AgentClient agentcl = new AgentClient(host, 60001);
			java.nio.channels.ReadableByteChannel rChannel = agentcl.getFile(filePath);
			
			// 4.设置相应属性
			response.setContentType("text/html;charset=UTF-8");
			response.setHeader("Content-disposition", "attachment; filename="
					+ new String(logName.getBytes("utf-8"), "ISO8859-1"));
			
			// 5.输出文件
			/*发送数据缓冲区*/  
			logger.info("++++++ init receiveBuffer ++++++");
	        ByteBuffer receiveBuffer = ByteBuffer.allocate(1024);
	        
	        os = response.getOutputStream();
			int index = -1;
			do {
				index = rChannel.read(receiveBuffer);
				if (index <= 0) {
					break;
				}
				receiveBuffer.position(0);
				os.write(receiveBuffer.array(), 0, index);
				receiveBuffer.clear();
			} while (index > 0);
	           
			logger.info("++++++ read end ++++++");
			
			os.flush();
		} finally {
			// 释放资源
			if (bis != null)
				try {
					bis.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (is != null)
				try {
					is.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (bos != null)
				try {
					bos.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			if (os != null)
				try {
					os.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
		}

	}
}
