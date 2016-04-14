/**
 * 产品参数中英文转换工具类
 */
// 产品参数常量定义
var prod_param = {
	// CCS
	'serviceName' : '服务名称',
	// MCS
	'capacity' : '容量',
	'haMode' : '集群模式',
	'cluster' : '集群',
	'single' : '单机',
	// DBS
	'masterNum' : '主库数量',
	'isNeedDistributeTrans' : '是否开启分布式事务',
	'isMysqlProxy' : '是否读写分离',
	'isAutoSwitch' : '是否主从自动切换',
	'true' : '是',
	'false' : '否',
	// MDS
	'serviceId':'IPAAS编码',
	'applyType' : '申请类型',
	'create' : '新建',
	'update' : '扩容',
	'unsubscribe' : '推荐',
	'topicName' : '消息名称',
	'topicEnName':'队列名称',
	'topicPartitions' : '消息分片',
	'msgReplica' : '消息副本',
	
	//IAASs
	'systemType' : '操作系统',
	'cpuType' : 'CPU',
	'machineName' : '虚拟机名称',
	'memoryInfo' : '硬盘',
	'busiInfo' : '业务名称',
	'cacheInfo' : '内存',
	'memoryType' : '硬盘类型',
  // DSS
  'singleFileSize': '单文件大小',
  // RCS
  'prodCluster': '计算类型',
  'prodCluster_val': ['集群规模：1台  每台：双核  每台内存：1G 每台文件存储：2G',
  '集群规模：2台  每台：双核  每台内存：2G 每台文件存储：4G',
  '集群规模：3台  每台：四核  每台内存：4G 每台文件存储：6G',
  '集群规模：4台  每台：四核  每台内存：8G 每台文件存储：8G'],
	//SES
	'clusterNum':'集群个数',
	'shardNum':'索引分片个数',
	'sesMem':'分片内存',
	'replicasNum':'索引副本个数',
	'userServIpaasPwd':'服务密码',
	'userServIpaasId' : 'IPAAS编码',
	 'userServId' : '服务实例编码'
};


// 产品名称常量
var prod_name={
'CCS':'配置中心',
'DBS':'分布式数据库服务',
'RCS':'实时计算',
'MDS':'消息中心',
'MCS':'缓存中心',
'TXS':'事务保障服务',
'ATS':'最终事物一致',
'DSS':'存储中心',
'IAAS_PHYSICAL':'IAAS-物理机',
'IAAS_VIRTAL':'IAAS-虚拟机',
'IAAS_MEMORY':'IAAS-存储',
'DES':'实时增量数据获取服务',
'SES':'搜索服务'
};

//产品名称颜色常量
var prod_color={
	'CCS':'#1ABC9C',
	'DBS':'#2ECC71',
	'RCS':'#3498DB',
	'MDS':'#9B59B6',
	'MCS':'#F1C40F',
	'TXS':'#E67E22',
	'ATS':'#E74C3C',
	'DSS':'#34495E'		
};

// 产品名称转换
function prodNameTransfer(key) {
return prod_name[key] ? prod_name[key] : key;
}

//产品名称颜色转换
function prodColorTransfer(key) {
return prod_color[key] ? prod_color[key] : key;
}

function prodTypeTransfer(obj){
	try {
		   //  1计算   2 数据库服务  3存储  2015.11.6
		if (obj == "3") {  //obj == "1"
			return "存储";
		}
		else if (obj == "1"){  //obj == "2"
			return "计算";
		}
		else if (obj == "2"){  //obj == "3"
			return "数据库服务";
		}
		else {
			return obj;
		} 
			
	} catch (e) {
	}
  return obj;	
	
}

// 参数转换，将英文转化为中文
function prodParamTransfer(obj) {
	
	try {
		obj = eval('(' + obj + ')');
		var tar = '[';
		$.each(obj, function(key, value) {
			if (key && key != 'userId') {
				if (key != 'prodCluster') {
					tar += valTransfer(prod_param, key) + "：";
				}
				var val = obj[key];
				if (key == 'prodCluster') {
			          tar += prod_param['prodCluster_val'][parseInt(val)-1];
			     } else {
					tar += valTransfer(prod_param, val) ;
					if (key == 'capacity' || key == 'singleFileSize'||key=='sesMem') {
						tar += 'M';
					}
			   }
				//tar += "，";
				tar += "，";
			}
		});
		if (tar.substring(tar.length - 1) == '，') {
			tar = tar.substring(0, tar.length - 1);
		}
		tar += ']';
		tar = tar.replace('[','').replace(']','');
		//翻译后，对参数进行按逗号分隔，以冒号对齐
		var str=tar.split("，");
		var returnstr="";
		for(var i =0; i<str.length;i++){
			returnstr+=str[i]+"</br>";
			//alert(str[i]);
		}
		
		return returnstr;
	} catch (e) {
		return "";
	}
}

function prodParamZh(obj){
	try {
		obj = eval('(' + obj + ')');
		var tar = '[';
		$.each(obj, function(key, value) {
				tar += key + "："+obj[key];
				if (key == '公网宽带') {
					tar += 'M';
				}
				if (key == '公网数量') {
					tar += '个';
				}
				if (key == '数据盘') {
					tar += 'G';
				}
				tar += "，";
		});
		if (tar.substring(tar.length - 1) == '，') {
			tar = tar.substring(0, tar.length - 1);
		}
		tar += ']';
		tar = tar.replace('[','').replace(']','');
		//翻译后，对参数进行按逗号分隔，以冒号对齐
		var str=tar.split("，");
		var returnstr="";
		for(var i =0; i<str.length;i++){
			returnstr+=str[i]+"</br>";
			//alert(str[i]);
		}
		
		return returnstr.substring(0, returnstr.length - 5);
	} catch (e) {
		return "";
	}
}

function subs(s) {
	if (s && s.length > 27) {
		s = s.substring(0, 27)+'...';
	}
	return s;
}

function valTransfer(jsonObj, key) {
	return jsonObj[key] ? jsonObj[key] : key;
}

/**
 * 产品审核状态转换
 * 
 * @param state
 * @returns {String}
 */
function stateTransfer(state) {
	if (state == 1) {
		return "待审核";
	}
	return "审核未通过";
}


/**
 * 操作类型转换
 * 
 * @param operateType
 * @returns {String}
 */
function operateTypeTransfer(operateType) {
	if (operateType == 1) {
		return "申请";
	}
	if (operateType == 2) {
		return "扩容";
	}
	if (operateType == 3) {
		return "退订";
	}	
}


//js时间戳格式化成日期格式
function dateformat(timestamp,chinese){
    if (!timestamp){
        datetime = new Date().toLocaleString();
    }else{
        datetime = new Date(parseInt(timestamp)*1000).toLocaleString();
    }
    if (!chinese){
        return datetime.replace(/年|月/g, '-').replace(/日/g, '');
    }
    return datetime;
}
function changeTableType(type,page) {
	$("input[name='prodtype']").val(type);
	$.ajax({
		type : "POST",
		url : getContextPath() + "/apply/purchaseRecordsJson",
		data : {
			prodType : type,
			currentPage:page
		},
		dataType:"json",
		success : function(dataObj) {
			var table1Contents="";
			if (type == 3) { //type == 1
				//存储
				//2015.11.6     1计算   2 数据库服务  3存储  
				table1Contents += "<tr><th width='14%'>订单号</th><th width='14%'>服务类型</th><th width='29%'>产品信息</th><th width='15%'>申请时间</th><th width='14%'>开通状态</th><th width='14%'>审核状态</th></tr>";
				
				if (dataObj.list) {
					for (var i = 0; i < dataObj.list.length; ++i) {
						var sonList = dataObj.list[i];
						for (var j = 0; j < sonList.length; ++j) {
							var obj = sonList[j];
							table1Contents += "<tr>";
							table1Contents += "<td>"+obj.orderDetailId + "</td>";
//							table1Contents +="<td>"+obj.prodByname + "</td>"
							
							table1Contents +="<td>"+prodTypeTransfer(obj.prodType) + "</td>"
							table1Contents +="<td  style=\"text-align: left;\">"+ obj.prodNameStr +"</br>"+ prodParamTransfer(obj.prodParamZh)+ "</td>";
							table1Contents +="<td>"+ obj.orderAppDateStr+ "</td>";
							table1Contents +="<td>" +pasreOpenStatus(obj.openStatus)+ "</td>";
							table1Contents +="<td>"+ pasreOrderCheckResult(obj.orderCheckResult)+ "</td>";
						
							table1Contents +="</tr>";
						}
						
					}
				}
			} else if (type == 1) { //type == 2
				//计算
				
				//2015.11.6     1计算   2 数据库服务  3存储  
				table1Contents += "<tr><th width='10%'>订单号</th><th width='11%'>服务类型</th><th width='28%'>产品信息</th><th width='14%'>申请时间</th><th width='12%'>开通状态</th><th width='12%'>审核状态</th><th width='13%'>操作</th></tr>";

				if (dataObj.list) {
					for (var i = 0; i < dataObj.list.length; ++i) {
						var sonList = dataObj.list[i];
						for (var j = 0; j < sonList.length; ++j) {
							var obj = sonList[j];
							table1Contents += "<tr>";
								table1Contents += "<td>"+obj.orderDetailId + "</td>";
								table1Contents +="<td>"+prodTypeTransfer(obj.prodType) + "</td>";
								table1Contents +="<td   style=\"text-align: left;\">"+obj.prodNameStr +"</br>"+prodParamZh(obj.prodParamZh);
								if(obj.prodByname=='IAAS_VIRTAL'){
									table1Contents+="</br>虚拟机数量："+obj.vmNumber;
								}
								table1Contents+="</td>";
								table1Contents +="<td>"+ obj.orderAppDateStr+ "</td>";
								table1Contents +="<td>" + pasreOpenStatus(obj.openStatus)+ "</td>";
								table1Contents +="<td>"+pasreOrderCheckResult(obj.orderCheckResult)+ "</td>";
								table1Contents +="<td>";
								if(obj.prodByname=='IAAS_VIRTAL'){
									if(obj.orderStatus==10){
										table1Contents +="<a href=\"javascript:void(0)\" onclick=\"openOaDiv("+obj.orderDetailId+",'"+obj.oaCheckUrl+"');\">审批查看</a><br><br><a href=\""+getContextPath()+"/virtualMachineModify/initModify?orderDetailId="+obj.orderDetailId+"\">申请修改</a>";
									}else{
										table1Contents +="<a href=\"javascript:void(0)\" onclick=\"openOaDiv("+obj.orderDetailId+",'"+obj.oaCheckUrl+"');\">审批查看</a>";
									}
								}
								table1Contents +="</td>";
								table1Contents +="</tr>";
						}
					}
				}
			} else if (type == 2) {   //type == 3
				//数据库服务
				
				//2015.11.6     1计算   2 数据库服务  3存储  
				table1Contents += "<tr><th width='14%'>订单号</th><th width='14%'>服务类型</th><th width='29%'>产品信息</th><th width='15%'>申请时间</th><th width='14%'>开通状态</th><th width='14%'>审核状态</th></tr>";
				
				if (dataObj.list) {
					for (var i = 0; i < dataObj.list.length; ++i) {
						var sonList = dataObj.list[i];
						for (var j = 0; j < sonList.length; ++j) {
							var obj = sonList[j];
							table1Contents += "<tr>";
							table1Contents += "<td>"+obj.orderDetailId + "</td>";
//							table1Contents +="<td>"+obj.prodByname + "</td>"
							
							table1Contents +="<td>"+prodTypeTransfer(obj.prodType) + "</td>"
							table1Contents +="<td   style=\"text-align: left;\">"+obj.prodNameStr +"</br>"+ prodParamTransfer(obj.prodParamZh)+ "</td>";
							table1Contents +="<td>"+ obj.orderAppDateStr+ "</td>";
							table1Contents +="<td>" +pasreOpenStatus(obj.openStatus)+ "</td>";
							table1Contents +="<td>"+ pasreOrderCheckResult(obj.orderCheckResult)+ "</td>";
						
							table1Contents +="</tr>";
						}
						
					}
				}
				
			}
			$("#table_detail_1").empty().append(table1Contents);
			//追加分页代码
			$('#pageUl').empty();
			if(dataObj.totalpage!=0){
			var options = {
					bootstrapMajorVersion : 3,
					currentPage : dataObj.currentpage,//当前页面
					numberOfPages : 10,//一页显示几个按钮
					totalPages : dataObj.totalpage
				//总页数
				}
			$('#pageUl').bootstrapPaginator(options);
			}
			
		}
	});
}
/**
 * OA审批查看
 * @param orderDetailId
 */
function openOaDiv(orderDetailId,url){
	$('.alertBox').css('display','block');
	$('.box-cover').css('display','block');
	$("#rightMain").attr("src",url+orderDetailId);
	
}
function formatStrToTable(paramsStr) {
	var paramsRow = paramsStr.split('，');
	var result = "<table style='border:0;padding:2px;align:center;margin-left: auto;margin-right: auto;'>";
	for(var i = 0; i<paramsRow.length; ++i) {
		var params = paramsRow[i].split("：");
		result += "<tr style='border:0;padding:2px'><td style='text-align:right;border:0;padding:2px;'>"+params[0]+"：</td>";
		if(params.length==2) {
			result += "<td style='text-align:left;padding:2px;border:0;'>"+params[1]+"</td>";
		}
		result += "</tr>";
	}
	result += "</table>";
	return result;
}