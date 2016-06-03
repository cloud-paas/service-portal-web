package com.ai.paas.ipaas.formulateplan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/formulate")
public class FormulatePlanController {
//	@Value("#{sysConfig['CONTROLLER.CONTROLLER.url']}")
//	String portalDubboUrl= SystemConfigHandler.configMap.get("");
//
//	@RequestMapping(value = "/formulateDetail")
//	public String searchplan(HttpServletRequest request,
//			HttpServletResponse response) throws IOException,
//			URISyntaxException {
//
//		String orderDetailId = request.getParameter("orderDetailId");
//		String orderWoId = request.getParameter("orderWoId");
//		request.setAttribute("orderDetailId", orderDetailId);
//		request.setAttribute("orderWoId", orderWoId);
//
//		return "integrationFormulate/integrationFormulate";
//	}
//
//	@RequestMapping(value = "/searchDetail", method = { RequestMethod.POST })
//	public @ResponseBody Map<String, Object> searchDetail(
//			HttpServletRequest request, HttpServletResponse response)
//			throws IOException, URISyntaxException {
//		Map<String, Object> result = new HashMap<String, Object>();
//		String orderDetailId = request.getParameter("orderDetailId");
//		JSONObject jsonObject = new JSONObject();
//		jsonObject.put("orderDetailId", orderDetailId);
//
//		String data = HttpClientUtil.sendPostRequest(portalDubboUrl
//				+ "/order/queryOrdersInfo", jsonObject.toString());
//		JSONObject object = new JSONObject(data);
//		String list = object.get("list").toString();
//		Gson gson = new Gson();
//		List<Map<String, Object>> listinfo = gson.fromJson(list,
//				new TypeToken<List<Map<String, Object>>>() {
//				}.getType());
//
//		if (list != null && list != "") {
//			result = listinfo.get(0);
//			result.put("resultCode", "000000");
//
//		} else {
//			result.put("resultCode", "999999");
//			result.put("resultMsg", "查询失败");
//		}
//
//		return result;
//
//	}
//
//	@RequestMapping(value = "/loadcpu", method = { RequestMethod.POST })
//	public @ResponseBody Map<String, String> loadcpu(
//			HttpServletRequest request, HttpServletResponse response) {
//		String cloudid = request.getParameter("belongCloud");
//		List<CodeValueObject> list = new ArrayList<CodeValueObject>();
//		if (cloudid.equals("1"))// 研发云
//		{
//			list = CacheUtils
//					.getCodeValueListByKey("VirtualMachineBase.YF_CPU");
//		} else if (cloudid.equals("2"))// 租用云
//		{
//			list = CacheUtils
//					.getCodeValueListByKey("VirtualMachineBase.ZY_CPU");
//		}
//		Map<String, String> result = new HashMap<String, String>();
//		String code = "";
//		for (int i = 0; i < list.size(); i++) {
//			CodeValueObject temp1 = list.get(i);
//			if (code.equals("")) {
//				code += temp1.getCode();
//			} else {
//				code += ";" + temp1.getCode();
//			}
//		}
//
//		result.put("cpu", code);
//		return result;
//
//	}
//
//	@RequestMapping(value = "/loadMemory", method = { RequestMethod.POST })
//	public @ResponseBody Map<String, String> loadMemory(
//			HttpServletRequest request, HttpServletResponse response) {
//		String cpu = request.getParameter("cpu");
//		String cpunum = request.getParameter("cpuNum");
//		Map<String, String> result = new HashMap<String, String>();
//		List<CodeValueObject> list = new ArrayList<CodeValueObject>();
//		if (cpu.equals("1"))// 研发云
//		{
//			list = CacheUtils
//					.getCodeValueListByKey("VirtualMachineBase.YF_CPU");
//		} else if (cpu.equals("2"))// 租用云
//		{
//			list = CacheUtils
//					.getCodeValueListByKey("VirtualMachineBase.ZY_CPU");
//		}
//
//		String memory = "";
//		for (int i = 0; i < list.size(); i++) {
//			if (list.get(i).getCode().equals(cpunum)) {
//				// System.out.println(list.get(i));
//				memory = list.get(i).getValue().toString();
//			}
//		}
//		result.put("memory", memory);
//		return result;
//
//	}
//
//	@RequestMapping(value = "/loadNetSource", method = { RequestMethod.POST })
//	public @ResponseBody Map<String, String> loadNetSource(
//			HttpServletRequest request, HttpServletResponse response) {
//		String belongCloud = request.getParameter("belongCloud");
//		List<CodeValueObject> list = new ArrayList<CodeValueObject>();
//		Map<String, String> result = new HashMap<String, String>();
//		if (belongCloud.equals("2")) {
//			list = CacheUtils
//					.getCodeValueListByKey("VirtualMachineBase.ZY_NetType");
//
//		}
//		String code = "";
//		for (int i = 0; i < list.size(); i++) {
//			CodeValueObject temp1 = list.get(i);
//			if (code.equals("")) {
//				code += temp1.getCode();
//			} else {
//				code += ";" + temp1.getCode();
//			}
//		}
//		result.put("NetSource", code);
//		return result;
//
//	}
//
//	@RequestMapping(value = "/loadOperateSystem", method = { RequestMethod.POST })
//	public @ResponseBody Map loadOperateSystem(HttpServletRequest request,
//			HttpServletResponse response) {
//		String belongCloud = request.getParameter("belongCloud");
//		List<CodeValueObject> list = new ArrayList<CodeValueObject>();
//		Map result = new HashMap();
//		if (belongCloud.equals("1")) {
//			list = CacheUtils
//					.getCodeValueListByKey("VirtualMachineBase.YF_System");
//		} else if (belongCloud.equals("2")) {
//			list = CacheUtils
//					.getCodeValueListByKey("VirtualMachineBase.ZY_System");
//		}
//		result.put("operatesystem", list);
//		return result;
//
//	}
//
//	@RequestMapping(value = "/loadSoftware", method = { RequestMethod.POST })
//	public @ResponseBody Map<String, String> loadSoftware(
//			HttpServletRequest request, HttpServletResponse response) {
//		String belongCloud = request.getParameter("belongCloud");
//		String systemType = request.getParameter("SystemCode");
//
//		List<CodeValueObject> runlist = new ArrayList<CodeValueObject>();
//		List<CodeValueObject> storelist = new ArrayList<CodeValueObject>();
//		Map<String, String> result = new HashMap<String, String>();
//		String runsym = "";
//		String storesym = "";
//		if (belongCloud.equals("1")) {
//			runlist = CacheUtils
//					.getCodeValueListByKey("VirtualMachineBase.YF_Run_Soft");
//			storelist = CacheUtils
//					.getCodeValueListByKey("VirtualMachineBase.YF_Save_Soft");
//		} else if (belongCloud.equals("2")) {
//			runlist = CacheUtils
//					.getCodeValueListByKey("VirtualMachineBase.ZY_Run_Soft");
//			storelist = CacheUtils
//					.getCodeValueListByKey("VirtualMachineBase.ZY_Save_Soft");
//		}
//		for (int i = 0; i < runlist.size(); i++) {
//			if (systemType.equals(runlist.get(i).getCode())) {
//				runsym += runlist.get(i).getValue();
//			}
//		}
//
//		for (int i = 0; i < storelist.size(); i++) {
//			if (systemType.equals(storelist.get(i).getCode())) {
//				storesym += storelist.get(i).getValue();
//			}
//		}
//		result.put("runSys", runsym);
//		result.put("storeSys", storesym);
//		return result;
//
//	}
//
//	@RequestMapping(value = "/loadVmtype", method = { RequestMethod.POST })
//	public @ResponseBody Map<String, String> loadVmtype(
//			HttpServletRequest request, HttpServletResponse response) {
//		String blongCloud = request.getParameter("belongCloud");
//		List<CodeValueObject> list = new ArrayList<CodeValueObject>();
//		Map<String, String> result = new HashMap<String, String>();
//		String Vmtype = "";
//		if (blongCloud.equals("1")) {
//			list = CacheUtils
//					.getCodeValueListByKey("VirtualMachineBase.YF_VirtualType");
//
//		} else if (blongCloud.equals("2")) {
//			list = CacheUtils
//					.getCodeValueListByKey("VirtualMachineBase.ZY_VirtualType");
//		}
//		Vmtype = list.get(0).getValue().toString();
//		result.put("VmType", Vmtype);
//		return result;
//
//	}

}
