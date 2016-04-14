//package com.ai.paas.ipaas.storm.task.controller;
//
//import java.util.ArrayList;
//import java.util.List;
//
//import javax.servlet.http.HttpServletResponse;
//
//import org.apache.ibatis.builder.xml.dynamic.TrimSqlNode;
//import org.apache.logging.log4j.LogManager;
//import org.apache.logging.log4j.Logger;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//
//import com.ai.paas.ipaas.PaasException;
//import com.ai.paas.ipaas.base.orm.page.model.PageEntity;
//import com.ai.paas.ipaas.base.orm.page.model.PagingResult;
//import com.ai.paas.ipaas.storm.dubbo.interfaces.IStormDemoDubboSV;
//import com.ai.paas.ipaas.storm.dubbo.interfaces.IStormTaskDubboSV;
//import com.ai.paas.ipaas.storm.dubbo.vo.StormTaskBoltVo;
//import com.ai.paas.ipaas.storm.dubbo.vo.StormTaskInfoVo;
//import com.ai.paas.ipaas.storm.dubbo.vo.StormTaskSpoutVo;
//import com.ai.paas.ipaas.storm.sys.BaseController;
//import com.ai.paas.ipaas.storm.sys.utils.JsonUtils;
//import com.ai.paas.ipaas.storm.sys.utils.StringUtils;
//import com.ai.paas.ipaas.storm.task.param.MainArgBolt;
//import com.ai.paas.ipaas.storm.task.param.MainArgSpout;
//import com.ai.paas.ipaas.storm.task.param.MainArgTopology;
//import com.alibaba.dubbo.config.annotation.Reference;
//
///**
// * 计算任务管理
// * 
// * @author weichuang
// * 
// */
//@Controller
//@RequestMapping(value = "/storm/task")
//public class StormTaskController extends BaseController {
//	private static final Logger logger = LogManager.getLogger(StormTaskController.class.getName());
//	@Reference
//	private IStormDemoDubboSV iStormDemoDubboSV;
//	@Reference
//	private IStormTaskDubboSV iStormTaskDubboSV;
//
//	/**
//	 * 查询计算任务列表
//	 */
//	@RequestMapping(value = "/toList")
//	public String toList() throws Exception {
//		try {
//			PageEntity pageEntity = new PageEntity();
//			int page = StringUtils.trimIntDefaultOne(request.getParameter("page"), "page");
//			int size = StringUtils.trimIntDefaultTen(request.getParameter("size"), "size");
//			pageEntity.setPage(page);
//			pageEntity.setSize(size);
//			PagingResult<StormTaskInfoVo> pagingResult = iStormTaskDubboSV.searchPageTasks(pageEntity);
//			logger.info(pagingResult);
//			request.setAttribute("pagingResult", pagingResult);
//			return "storm/task/list";
//		} catch (Exception e) {
//			logger.error(e);
//			throw new PaasException("系统异常", e);
//		}
//	}
//
//	/**
//	 * 跳转到计算任务注册页面
//	 */
//	@RequestMapping(value = "/toRegisterTask")
//	public String toRegisterTask() throws Exception {
//		try {
//			return "storm/task/registerTask";
//		} catch (Exception e) {
//			logger.error(e);
//			throw new PaasException("系统异常", e);
//		}
//	}
//
//	/**
//	 * 计算任务注册
//	 */
//	@RequestMapping(value = "/registerTask")
//	public void registerTask(HttpServletResponse response) throws Exception {
//		try {
//			//
//			String name = StringUtils.trimOrNullAndBlankException(request.getParameter("name"), "计算任务名称");
//			long clusterId = StringUtils.trimLongException(request.getParameter("clusterId"), "所属集群");
//			int numWorkers = StringUtils.trimIntException(request.getParameter("numWorkers"), "work数量");
//			String comments = StringUtils.trimOrReturnNull(request.getParameter("comments"));
//			String jarFilePath = StringUtils.trimOrNullAndBlankException(request.getParameter("jarFilePath"), "jarFilePath");
//			//
//			String[] spoutNameArray = request.getParameterValues("spoutName");
//			String[] spoutClassNameArray = request.getParameterValues("spoutClassName");
//			String[] spoutThreadsArray = request.getParameterValues("spoutThreads");
//
//			String[] boltNameArray = request.getParameterValues("boltName");
//			String[] boltClassNameArray = request.getParameterValues("boltClassName");
//			String[] threadsArray = request.getParameterValues("threads");
//			String[] groupingTypesArray = request.getParameterValues("groupingTypes");
//			String[] groupingSpoutOrBlotsArray = request.getParameterValues("groupingSpoutOrBlots");
//			//
//			StormTaskInfoVo stormTaskInfoVo = new StormTaskInfoVo();
//			stormTaskInfoVo.setName(name);
//			stormTaskInfoVo.setClusterId(clusterId);
//			stormTaskInfoVo.setNumWorkers(numWorkers);
//			stormTaskInfoVo.setComments(comments);
//			stormTaskInfoVo.setJarFilePath(jarFilePath);
//
//			List<StormTaskSpoutVo> stormTaskSpoutVos = new ArrayList<StormTaskSpoutVo>();
//			if (spoutNameArray != null) {
//				for (int i = 0; i < spoutNameArray.length; i++) {
//					StormTaskSpoutVo stormTaskSpoutVo = new StormTaskSpoutVo();
//					stormTaskSpoutVo.setSpoutName(spoutNameArray[i]);
//					stormTaskSpoutVo.setSpoutClassName(spoutClassNameArray[i]);
//					stormTaskSpoutVo.setThreads(Integer.parseInt(spoutThreadsArray[i]));
//					stormTaskSpoutVos.add(stormTaskSpoutVo);
//				}
//			}
//			stormTaskInfoVo.setStormTaskSpoutVos(stormTaskSpoutVos);
//
//			List<StormTaskBoltVo> stormTaskBoltVos = new ArrayList<StormTaskBoltVo>();
//			if (boltNameArray != null) {
//				for (int i = 0; i < boltNameArray.length; i++) {
//					StormTaskBoltVo stormTaskBoltVo = new StormTaskBoltVo();
//					stormTaskBoltVo.setBoltName(boltNameArray[i]);
//					stormTaskBoltVo.setBoltClassName(boltClassNameArray[i]);
//					stormTaskBoltVo.setThreads(Integer.parseInt(threadsArray[i]));
//					stormTaskBoltVo.setGroupingTypes(groupingTypesArray[i]);
//					stormTaskBoltVo.setGroupingSpoutOrBlots(groupingSpoutOrBlotsArray[i]);
//					stormTaskBoltVos.add(stormTaskBoltVo);
//				}
//			}
//			stormTaskInfoVo.setStormTaskBoltVos(stormTaskBoltVos);
//			// 先把文件传到nimbus上 再插入数据库
//			// RestletClientUtils.uploadFile("10.1.249.31:60001",
//			// "/unibss/pocusers/devstp01/topologyToPublish/"+new
//			// File(jarFilePath).getName(), new BufferedInputStream(new
//			// FileInputStream(jarFilePath)));
//			this.iStormTaskDubboSV.registerTask(stormTaskInfoVo);
//			responseSuccess(response, "XXX成功", null);
//		} catch (Exception e) {
//			logger.error("系统错误", e);
//			responseError(response, "系统异常：" + e.getMessage(), e);
//		}
//	}
//
//	/**
//	 * 跳转到计算任务编辑页面
//	 */
//	@RequestMapping(value = "/toEditTask")
//	public String toEditTask() throws Exception {
//		try {
//			return "storm/task/editTask";
//		} catch (Exception e) {
//			logger.error(e);
//			throw new PaasException("系统异常", e);
//		}
//	}
//
//	/**
//	 * 计算任务编辑
//	 */
//	@RequestMapping(value = "/editTask")
//	public void editTask(HttpServletResponse response) throws Exception {
//		try {
//			responseSuccess(response, "XXX成功", null);
//		} catch (Exception e) {
//			logger.error("系统错误", e);
//			responseError(response, "系统异常：" + e.getMessage(), e);
//		}
//	}
//
//	/**
//	 * 计算任务操作 启动、注销、停止
//	 */
//	@RequestMapping(value = "/operTask")
//	public void operTask(HttpServletResponse response) throws Exception {
//		try {
//			String operType = StringUtils.trimOrNullAndBlankException(request.getParameter("operType"), "操作类型");
//			long id = StringUtils.trimLongException(request.getParameter("id"), "id");
//			StormTaskInfoVo stormTaskInfoVo = iStormTaskDubboSV.getTask(id);
//			if ("start".equalsIgnoreCase(operType)) {
//				String startCmd = "/unibss/pocusers/devstp01/apache-storm-0.9.3/bin/storm jar " + StringUtils.getFileName(stormTaskInfoVo.getJarFilePath())
//						+ " com.ai.pass.ipaas.storm.Main ";
//				MainArgTopology mainArgTopology = new MainArgTopology();
//				mainArgTopology.setTopologyName(stormTaskInfoVo.getName() + "$" + stormTaskInfoVo.getId());
//				mainArgTopology.setNumWorkers(stormTaskInfoVo.getNumWorkers());
//
//				List<MainArgSpout> mainArgSpouts = new ArrayList<MainArgSpout>();
//				for (StormTaskSpoutVo stormTaskSpoutVo : stormTaskInfoVo.getStormTaskSpoutVos()) {
//					MainArgSpout mainArgSpout = new MainArgSpout();
//					mainArgSpout.setSpoutClassName(stormTaskSpoutVo.getSpoutClassName());
//					mainArgSpout.setSpoutName(stormTaskSpoutVo.getSpoutName());
//					mainArgSpout.setThreads(stormTaskSpoutVo.getThreads());
//					mainArgSpouts.add(mainArgSpout);
//				}
//				mainArgTopology.setSpouts(mainArgSpouts);
//
//				List<MainArgBolt> mainArgBolts = new ArrayList<MainArgBolt>();
//				for (StormTaskBoltVo stormTaskBoltVo : stormTaskInfoVo.getStormTaskBoltVos()) {
//					MainArgBolt mainArgBolt = new MainArgBolt();
//					mainArgBolt.setBoltClassName(stormTaskBoltVo.getBoltClassName());
//					mainArgBolt.setBoltName(stormTaskBoltVo.getBoltName());
//					mainArgBolt.setThreads(stormTaskBoltVo.getThreads());
//					mainArgBolt.setGroupingTypes(stormTaskBoltVo.getGroupingTypes());
//					mainArgBolt.setGroupingSpoutOrBolts(stormTaskBoltVo.getGroupingSpoutOrBlots());
//					mainArgBolts.add(mainArgBolt);
//				}
//				mainArgTopology.setBolts(mainArgBolts);
//
//				String jsonStr = JsonUtils.toJsonString(mainArgTopology);
//				jsonStr = jsonStr.replace("\"", "'").replace("'", "T_T").replace(",", "T__T").replace("{", "_T__T").replace("}", "T__T_");
//
//				startCmd = startCmd + jsonStr;
//				logger.debug(startCmd);
//
//				// RestletClientUtils.exeCmd("10.1.249.31:60001",
//				// "/unibss/pocusers/devstp01/topologyToPublish", startCmd);
//			} else if ("cancel".equalsIgnoreCase(operType)) {
//
//			} else if ("stop".equalsIgnoreCase(operType)) {
//				String stopCmd = "storm kill " + stormTaskInfoVo.getName() + "$" + stormTaskInfoVo.getId();
//				logger.debug(stopCmd);
//				// RestletClientUtils.exeCmd("", "", stopCmd);
//			}
//			responseSuccess(response, "XXX成功", null);
//		} catch (Exception e) {
//			logger.error("系统错误", e);
//			responseError(response, "系统异常：" + e.getMessage(), e);
//		}
//	}
//
//	/**
//	 * 跳转到计算任务查看日志页面
//	 */
//	@RequestMapping(value = "/toLookLog")
//	public String toLookLog() throws Exception {
//		try {
//			return "storm/task/lookLog";
//		} catch (Exception e) {
//			logger.error(e);
//			throw new PaasException("系统异常", e);
//		}
//	}
//
//	/**
//	 * 计算任务查看日志
//	 */
//	@RequestMapping(value = "/lookLog")
//	public void lookLog(HttpServletResponse response) throws Exception {
//		try {
//			responseSuccess(response, "XXX成功", null);
//		} catch (Exception e) {
//			logger.error("系统错误", e);
//			responseError(response, "系统异常：" + e.getMessage(), e);
//		}
//	}
//}
