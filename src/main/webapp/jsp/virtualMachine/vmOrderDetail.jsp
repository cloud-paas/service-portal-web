<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8" import="java.util.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>云虚拟机订单详情</title>
	<%@ include file="/jsp/common/common.jsp"%>
	<link href="${_base }/resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="${_base }/resources/css/vmOrderDetail.css" rel="stylesheet">
	<script type="text/javascript" src="${_base }/resources/bower_components/jquery/dist/jquery-1.10.2.js"></script>
	<script type="text/javascript">
	$(function(){
		querytickets();
	});
	/**
	 * 虚拟机参数详情查询
	 */
	function querytickets(){
		var orderDetailId=$('#orderDetailId').val();
		var jsondata1={
			"orderDetailId" : orderDetailId //订单状态
		}
		var jsondata=JSON.stringify(jsondata1);
		$.ajax({
			   		cache: true,
					type:"POST",
					url: getContextPath() +"/VirtualIntegration/vmDetailSelect",
					data: "jsondata="+jsondata,	
					dataType: 'json',
					async: true,
					error: function(data){
						$("#content-info").empty();
					},
					success: function(data){
						var orderInfo="";
						if(data.msg){
							orderInfo+="<div class=\"info\">";
							orderInfo+=" <h2>"+data.msg+"</h2>";
							orderInfo+="</div>";
						}else{
	                        obj=eval(data);
	                        if(obj.list!=null&&obj.list!=undefined&&obj.list!=""){
	                            $.each(obj.list,function(i,a){
	                                orderInfo+="<li class=\"info\" style=\"margin-top:2px\">";
	                                orderInfo+="<div class=\"fault-num\">"+a.orderDetailId+"</div>";
	                                orderInfo+="<ul class=\"info-top\">";
	                                orderInfo+="<li>";
	                                orderInfo+="<span class=\"report-tittle gray\">报告人:</span>";
	                                orderInfo+="<span class=\"report-info\">"+a.applicant+"</span>";
	                                orderInfo+="</li>";
	                                orderInfo+="<li>";
	                                orderInfo+="<span class=\"contact gray\">联系方式：</span>";
	                                orderInfo+="<span class=\"contact-info\">"+a.applicantTel+"</span>";
	                                orderInfo+="</li>";
	                                orderInfo+="<li>";
	                                orderInfo+="<span class=\"work gray\">部门：</span>";
	                                orderInfo+="<span class=\"work-info\">"+a.applicantDept+"</span>";
	                                orderInfo+="</li>";
	                                orderInfo+="<li>";
	                                orderInfo+="<span class=\"gray\">时间：</span>";
	                                orderInfo+="<span>"+limitTimelength(a.orderAppDate)+"</span>";
	                                orderInfo+="</li>";
	                                orderInfo+="</ul>";
	                                orderInfo+="<ul class=\"info-middle\">";
	                                orderInfo+="<span class=\"business gray\">业务描述:</span>";
	                                orderInfo+="<li>";
	                                orderInfo+="<div class=\"business-txt\">"+limitLength(a.applyDesc)+"</div>";
	                                orderInfo+="</li>";
	                                orderInfo+="</ul>";
	                                orderInfo+="<ul class=\"info-center\">";
	                                orderInfo+="<li>";
	                                orderInfo+="<span class=\"user-num gray\">用户量：</span>";
	                                orderInfo+="<span class=\"user-info\">"+a.userMaxNumbers+"</span>";
	                                orderInfo+="</li>";
	                                orderInfo+="<li>";
	                                orderInfo+="<span class=\"visit gray\">并发访问量：</span>";
	                                orderInfo+="<span class=\"visit-info\">"+a.concurrentNumbers+"</span>";
	                                orderInfo+="</li>";
	                                orderInfo+="<li>";
	                                orderInfo+="<span class=\"virtual gray\">虚拟机数量：</span>";
	                                orderInfo+="<span class=\"virtual-num\">"+a.vmNumber+"</span>";
	                                orderInfo+="</li>";
	                                orderInfo+="</ul>";
	                                orderInfo+="<div class=\"dot-line\"></div>";
	                                orderInfo+="<ul class=\"deploy\">";
	                                orderInfo+="<li>";
	                                orderInfo+="<span class=\"deploy-tittle\">配置</span>";                
	                                orderInfo+="</li>";
	                                var obj1 = eval("("+a.prodParam+")");
	                                orderInfo+="<li class=\"float-li1\">";
	                                orderInfo+="<span class=\"cpu gray\">CPU：</span>";
	                                orderInfo+="<span class=\"cpu-info\">"+obj1.cpu+"</span>";
	                                orderInfo+="</li>";
	                                orderInfo+="<li class=\"float-li2\">";
	                                orderInfo+="<span class=\"machine gray\">虚拟机类型：</span>";
	                                orderInfo+="<span class=\"machine-info\">"+obj1.virtualType+"</span>";
	                                orderInfo+="</li>";
	                                 if(a.belongCloud!=null && a.belongCloud!=undefined && a.belongCloud=="2" ){// 归属平台	  1研发云   2租用云
		                                orderInfo+="<li class=\"float-li3\">";
	                                	orderInfo+="<span class=\"link-type gray\">链路类型：</span>";
		                                orderInfo+="<span class=\"link-info\">"+obj1.netType+"</span>";
		                                orderInfo+="</li>"
		                                orderInfo+="<li class=\"float-li4\">";
		                                orderInfo+="<span class=\"net-num gray\">公网数量：</span>";
		                                orderInfo+="<span class=\"net-info\">"+obj1.netNum+"个</span>";
		                                orderInfo+="</li>";
	                                 }
	                                orderInfo+="</ul>";
	                                orderInfo+="<ul class=\"deploy1\">";
	                                orderInfo+="<li class=\"float-li5\">";
	                                orderInfo+="<span class=\"memory gray\">内存：</span>";
	                                orderInfo+="<span class=\"memory-info\">"+obj1.virtualRam+"</span>";
	                                orderInfo+="</li>";
	                                orderInfo+="<li class=\"float-li6\">";
	                                orderInfo+="<span class=\"disk gray\">数据盘容量：</span>";
	                                orderInfo+="<span class=\"disk-info\">"+obj1.virtualHard+"G</span>";
	                                orderInfo+="</li>";
	                                orderInfo+="<li class=\"float-li8\">";
	                                orderInfo+="<span class=\"operate gray\">操作系统：</span>";
	                                orderInfo+="<span class=\"operate-info\">"+obj1.SysTemChild+"</span>";
	                                orderInfo+="</li>";
	                                if(a.belongCloud!=null && a.belongCloud!=undefined && a.belongCloud=="2" ){// 归属平台	  1研发云   2租用云
	                                	orderInfo+="<li class=\"float-li7\">";
		                                orderInfo+="<span class=\"company1-net gray\">公网宽带：</span>";
		                                orderInfo+="<span class=\"companyNet-info\">"+obj1.netBandW+"M</span>";
		                                orderInfo+="</li>";
	                                 }
	                                orderInfo+="</ul>";
	                                orderInfo+="<ul class=\"deploy2\">";
	                                orderInfo+="<li>";
	                                orderInfo+="<span class=\"soft gray\">安装软件：</span>"
	                                orderInfo+="<span class=\"soft-info\">"+"存储软件: "+obj1.storageSoft+"</span>"
	                                orderInfo+="</li>";
	                                orderInfo+="<li class=\"mar-l\">";
	                                orderInfo+="<span class=\"soft-info1\">"+"运行环境软件: "+obj1.environmentSoft+"</span>";
	                                orderInfo+="</li>";
	                                orderInfo+="</ul>";

	                                orderInfo+="</li>";
	                            });
	                        }else{
	                        	$("#content-info").empty();
	                        }
						}
	                    $("#content-info").empty();
	                    $("#content-info").append(orderInfo);
					}
		});

	}
	function limitLength(str){
		var strtmp=str.substr(0,113);
		var maxlength=113;
		if(str.length>maxlength){
			return strtmp+"...";
		}else{
			return str;
		}
	}
	function limitTimelength(str){
		var strtmp=str.substr(0,19);
		var maxlength=19;
		if(str.length>maxlength){
			return strtmp;
		}else{
			return str;
		}
	}
	</script>
</head>
<body>
	<input type="hidden" id="orderDetailId" value=${orderDetailId } />
	<div class="content">
		<ul class="content-info" id="content-info">
		</ul>
	</div>
</body>
</html>