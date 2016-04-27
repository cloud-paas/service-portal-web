function queryMcsList() {
	$.ajax({
		type : "POST",
		url :  _base+"/mcsConsole/queryMcsList",
		dataType : "json",
		data : {},
		success : function(data) {
			$("#table_detail_mcs").empty();
			var tableContents = "<tr><th>服务名称</th><th>IPAAS编码</th><th>缓存容量</th><th>集群模式</th><th>操作</th></tr>";
			if (data) {
				var dataList = data.resultList;
				if(dataList && dataList.length > 0) {
					for (var i = 0; i < dataList.length; ++i) {
						var obj = dataList[i];
						var userServParamMap = eval("(" + obj.userServParam + ")");
						tableContents += "<tr><td>"
								+ userServParamMap.serviceName
								+ "</td><td>"
								+ obj.userServIpaasId
								+ "</td><td>"
								+ obj.capacity
								+ "</td><td>"
								+ ((userServParamMap.haMode == "single") ? '单机' : '集群')
								+ "</td><td><a href='javascript:;' onclick='toMethodPage(\""+obj.userServId+"\",\"toModifyMcsServPwd\")'>修改服务密码</a>";
						if(obj.userServRunState == 1 || obj.userServRunState == null) {
							tableContents += "|<a href='javascript:;' onclick='operatServ(\""+obj.userId + "\", \"" + obj.userServId+ "\",\"/mcs/manage/start\", \"" + obj.userServIpaasId + "\", \"" + obj.capacity+"\", \"" + userServParamMap.haMode +  "\", \"" + userServParamMap.serviceName +  "\", \"启动\")'>启动</a>";
						} else if(obj.userServRunState == 0) {
							tableContents += "|<a href='javascript:;' onclick='operatServ(\""+obj.userId + "\", \"" + obj.userServId+ "\",\"/mcs/manage/stop\", \"" + obj.userServIpaasId + "\", \"" + obj.capacity+"\", \"" + userServParamMap.haMode +  "\", \"" + userServParamMap.serviceName +  "\", \"停止\")'>停止</a>"
							+ "|<a href='javascript:;' onclick='operatServ(\""+obj.userId + "\", \"" + obj.userServId+ "\",\"/mcs/manage/restart\", \"" + obj.userServIpaasId + "\", \"" + obj.capacity+"\", \"" + userServParamMap.haMode +  "\", \"" + userServParamMap.serviceName +  "\", \"重启\")'>重启</a>"
							+ "|<a href='javascript:;' onclick='operatServ(\""+obj.userId + "\", \"" + obj.userServId+ "\",\"/mcs/manage/clean\", \"" + obj.userServIpaasId + "\", " + null +", " + null +  ", \"" + userServParamMap.serviceName +  "\", \"格式化\")'>格式化</a>"
							+ "|<a href='javascript:;' onclick='toMethodPage(\""+obj.userServId+"\",\"toKeyMgr\")'>key删除</a>"
							+ "|<a href='javascript:;' onclick='toMethodPage(\""+obj.userServId+"\",\"toKeyMgr\")'>查询key数据</a>"
							+ "|<a href='javascript:;' onclick='toMethodPage(\""+obj.userServId+"\",\"toExpanseCapacity\")'>扩容</a>";
						}
						tableContents += "|<a href='javascript:;' onclick='operatServ(\""+obj.userId + "\", \"" + obj.userServId+ "\",\"/mcs/manage/cancel\", \"" + obj.userServIpaasId + "\", \"" + obj.capacity+"\", \"" + userServParamMap.haMode +  "\", \"" + userServParamMap.serviceName +  "\", \"注销\")'>注销</a>"
						+ "|<a href='javascript:;' onclick='checkService(\""+obj.userServIpaasId+"\")'>服务验证</a>"
						+ "</td></tr><tr id='mcs_server_"+obj.userServId+"'></tr>";
					}
				} else {
					tableContents += "<tr><td style='vertical-align:middle; text-align:center; color:red' colspan='5'>没有查询到相关结果</td></tr>";
				}
			}
			$("#table_detail_mcs").append(tableContents);
		},
		failuer:function() {
			alert("fault");
		}
	});
}

function operatServ(userId, userServId, applyType, userServIpaasId, capacity, haMode,
		serviceName, operatName) {
	var isKeyMgr = (applyType == '/mcs/manage/del' || applyType == '/mcs/manage/get');
	if(isKeyMgr && !$("#keyQuery").val()) {
		$("#keyMgrResult").empty();
		$("#keyMgrResult").append("<tr><td style='vertical-align:middle; text-align:center; color:red'>Key值不能为空！</td></tr>");
		return;
	}
	if (!operatName || operatName == "") {
		operatName = "查找";
		operatServAjax(userId, userServId, applyType, userServIpaasId, capacity, haMode,
				serviceName, operatName);
	} else {
		var remaindMsg = "对"
				+ ((applyType == '/mcs/manage/del') ? "Key【"
						+ $("#keyQuery").val() : "服务【" + serviceName) + "】做【"
				+ operatName + "】操作";
		Modal.confirm({
			msg : "确定要"+remaindMsg+"？"
		}).on(function(e) {
			if(e) {
				$("#mcs_server_"+userServId).empty();
				$("#mcs_server_"+userServId).append("<td style='vertical-align:middle; text-align:center; color:red' colspan='5'>正在"+remaindMsg+"，请稍后…… </td>");
				operatServAjax(userId, userServId, applyType, userServIpaasId, capacity, haMode,
						serviceName, operatName);
			}
		});
	}
}

function operatServAjax(userId,userServId,applyType,userServIpaasId,capacity,haMode,serviceName, operatName) {
	var isKeyMgr = (applyType == '/mcs/manage/del' || applyType == '/mcs/manage/get');
	var selectType = "";
	var field = "";
	if(applyType == '/mcs/manage/get'){
		selectType =$("#selectType").val();
		field = $("#mapfiledname").val();
	}
	$.ajax({
		type : "POST",
		url : getContextPath() + "/mcsConsole/operatServ",
		data : {
			userId:userId,
			applyType:applyType,
			userServIpaasId:userServIpaasId,
			capacity:capacity,
			haMode:haMode,
			serviceName:serviceName,
			userServId:userServId,
			key:$("#keyQuery").val(),
			selectType:selectType,
			field : field
		},
		success : function(data) {
			var remaindMsg = "对"
					+ (isKeyMgr ? "Key【" + $("#keyQuery").val() : "服务【"
							+ serviceName) + "】做【" + operatName + "】操作";
			var tableContents = "<td style='vertical-align:middle; text-align:center; color:red' colspan='5'>"+remaindMsg;
			if (data && data.resultCode == "000000") {
				if(isKeyMgr) {
					$("#keyMgrResult").empty();
					if(applyType == '/mcs/manage/del') {
						tableContents += "成功！</td></tr>";
						$("#keyMgrResult").append("<tr>"+tableContents);
					} else {
						tableContents = "";
						if(data.resultMessage)
							tableContents+="<tr><td style='vertical-align:middle; text-align:center; color:red'>查询结果：</td><td>"+ data.resultMessage + "</td></tr>";
						else
							tableContents+="<tr><td style='vertical-align:middle; text-align:center; color:red' colspan='2'>缓存中不存在该Key值</td></tr>";
						$("#keyMgrResult").append(tableContents);
					}
				} else {
					$("#mcs_server_"+userServId).empty();
					tableContents += "成功！</td>";
					$("#mcs_server_"+userServId).append(tableContents);
					setTimeout("clearRemaindMsgTask('mcs_server_"+userServId+"')", 2000);
				}
			} else {
				if(isKeyMgr) {
					$("#keyMgrResult").empty();
					tableContents += "失败【" + data.resultCode + "】：" + data.resultMessage+"</td></tr>";
					$("#keyMgrResult").append(tableContents);
				} else {
					$("#mcs_server_"+userServId).empty();
					tableContents += "失败【" + data.resultCode + "】：" + data.resultMessage
					+"<input type='button' style='color:white;background:green' value='知道了' onclick='clearRemaindMsg(\"mcs_server_"+userServId+"\")' /></td></tr>";
					$("#mcs_server_"+userServId).append(tableContents);
				}
			}
		}
	});
}

function clearRemaindMsg(id) {
	$("#"+id).empty();
}

function clearRemaindMsgTask(id) {
	clearRemaindMsg(id);
	queryMcsList();
}

function toMethodPage(userServId, method) {
	postRequest(getContextPath() + '/mcsConsole/' + method, {
		userServId : userServId
	});
}


function selectTypeChange(selectType) {	
	if(selectType == "Hash"){		
		 $("#mapfiledname").show();
	}else{
		$("#mapfiledname").val("");
		 $("#mapfiledname").hide();
	}
		
}

//验证mcs服务
function checkService(userServIpaasId)
{
    var svcPwd=prompt("请输入服务密码：");
    if(svcPwd)
    {
    	//var pid= "${userInfoVO.pid}";
        alert("服务ID: "+userServIpaasId+" & 服务密码: "+ svcPwd+ " & PID："+ _pid);       
    }
    $.ajax({
		type : "POST",
		url : _base + "/ServiceCheck/toCheckMcsService",
		dataType : "json",
		data : "serviceId="+userServIpaasId+"&pid="+ _pid +"&servicePwd="+ svcPwd,
		
		success : function(msg) {
			if (msg.mcsCode == '111111') {
				alert("恭喜，MCS服务 "+userServIpaasId +" 验证成功 ! \n MCSMessage is ："+msg.mcsMsg);
			} else {
				alert("MCS服务 "+userServIpaasId +" 验证失败 ! ");
			}
		},
		error : function() {
			alert("MCS服务 "+userServIpaasId +" 验证失败 !");
		}
	});
}
