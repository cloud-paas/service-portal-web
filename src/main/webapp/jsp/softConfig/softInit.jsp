<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8" import="java.util.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>集成制定</title>
	<%@ include file="/jsp/common/common.jsp"%>
	<link href="${_base }/resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="${_base }/resources/css/projectCommon.css" rel="stylesheet">
	<link href="${_base }/resources/css/loadBox.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="${_base }/resources/css/kkpager/kkpager_orange.css"/>
	<script type="text/javascript" src="${_base }/resources/bower_components/jquery/dist/jquery-1.10.2.js"></script>
	<script type="text/javascript" src="${_base }/resources/js/virtual/timejs/laydate.js"></script>
	<script type="text/javascript" src="${_base }/resources/js/virtual/virtualIntegration.js"></script>
	<script type="text/javascript" src="${_base }/resources/js/kkpager/kkpager.min.js"></script>
	<script>
		function getSure(){
			location.href="${_base}/VirtualIntegration/vmSearch";	
		}
	</script>
</head>
<style type="text/css">
	.inform-success,.inform-fault{width: 460px;height: 205px;background: #fff;box-shadow: 0 0 5px 1px #ccc;position: relative;}
	.ok{position: absolute;left: 50%;top: 37px;margin-left:-15px;}
	.inform-success h4,.inform-fault h4{color: #333;position: absolute;left: 191px;top:70px;}
	.sure{color: #fff;background:#169ADB;border: 1px solid #056A9E;left: 177px;width: 110px;height: 35px;text-align:center;line-height: 35px;font-weight: bold;font-size: 16px;position: absolute;top: 137px;}
	.div_overlay{display:none;position: fixed;width: 100%;height:100%;z-index:1010;-moz-opacity: 0.0; opacity:.00;filter: alpha(opacity=0);background-color: black;}
	
	.warn-must{color: red;font-size: 14px;display: none;}
	.warn1{position: absolute;left: 410px;top: 48px;}
	.warn2{position: absolute;left: 410px;top: 85px;}
	.warn3{position: absolute;left: 410px;top: 125px;}
	.warn4{position: absolute;left: 410px;top: 165px;}
	.warn-must{color: red;font-size: 14px;display: none;}
	.warn1{position: absolute;left: 410px;top: 48px;}
	.warn2{position: absolute;left: 410px;top: 85px;}
	.warn3{position: absolute;left: 410px;top: 125px;}
	.warn4{position: absolute;left: 410px;top: 165px;}
</style>
<body>

	<div id="fadeshow" class="div_overlay"></div> 
    <div id="success" class="inform-success" style="display: none;left:450px; top:200px;position:fixed; z-index:1011;_position:absolute;">
    	<img src="${_base }/resources/images/yes.jpg" class="ok" >
    	<h4 style="left:135px;padding:10px;">软件安装录入成功！</h4>
		<button id="confirm_success" class="sure" onclick="getSure();">确定</button>
    </div>
    <div id="fault_open" class="inform-fault"  style="display: none;left:450px; top:200px;position:fixed; z-index:1011;_position:absolute;">
    	<img src="${_base }/resources/images/no.jpg" class="ok">
    	<h4 style="left:135px;padding:10px;">软件安装录入失败！</h4>
		<button id="confirm_fault"  class="sure"  onclick="getSure();">确定</button>
    </div>

	<div class="content">
		<div class="content-top">
			<span class="reporter">报告人</span>
			<input type="text" class="reporter-txt" id="selectUserName">
			<span class="mobile">手机号</span>
			<input type="text" class="mobile-txt" id="selectUserPhone">
			<span class="department">部门信息</span>
			<input type="text" class="department-txt" id="selectUserDepartment">
			<span class="apply-time">申请时间</span>
			<img src="${_base }/resources/images/date.png" class="date1">
			<input type="text" id="registerDateStart" class="time-txt1" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm'})">
			<span class="time-to">至</span>
			<img src="${_base }/resources/images/date.png" class="date2">
			<input type="text" id="registerDateEnd" class="time-txt2" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm'})">
			<input type="button" class="search" value="查询"  onclick="querytickets(1)">
			<input type="button" class="made" value="制定">
			<input type="hidden" value="${orderDetailId }" id="orderDetailId">
			<input type="hidden" value="${orderWoId }" id="orderWoId">
			<input type="hidden" id="operateID" value="${operateId }">
		</div>
		<div class="content-middle">
			<input type="checkbox" class="all-btn">
			<label class="all">全选</label>
			<input type="button" class="time-turn" onclick="timeSort()">
			<input type="text" class="key" value="请输入关键字" id="key">
			<div class="search-txt" onclick="KeySearch()"></div>
		</div>
		<div class="content-info" id="content-info">
                      
        
		</div>
		<!-- 录入弹窗盒子 -->
		<div class="loadBox">
		<!--   用于跳转到该页，暂存页数，按页数查询 -->
		   <input type="hidden" value="${kkpage }" id="kkpage_temp_value">
			<div class="loadBox-content">
				<div class="load-top">
					<div class="load-left">
						<span class="load-blue load-num">软件信息</span>
					</div>
					<ul class="load-right">
						<li>
							<textarea name="softsConfig" id="softsConfig"  style="width:500px;height:200px"></textarea>							
						</li>						
					</ul>
				</div>			

				<button class="load-submit" onclick="inputSubmit()">提交</button>
				<button class="load-cancel" onclick="cancel()" >取消</button>
			</div>
		</div>
		<div class="cover"></div>
	    <div id="kkpager"></div>
	    
	</div>
	

</body>
<script type="text/javascript">
	function inputSubmit(){

		var softsConfig=$("#softsConfig").val();
		var orderWoId=$("#orderWoId").val();
		var orderDetailId=$("#orderDetailId").val();
		var operateId=$("#operateID").val();
		$.ajax({
			type:"POST",
			url:getContextPath()+"/softwareInstall/softInstallSubmit",
			data:{
				softsConfig:softsConfig,
				orderWoId:orderWoId,
				orderDetailId:orderDetailId,
				operateId:operateId
			},
			success: function(data)
			{
				if(data.responseCode=="999999")
				{
					$("#fadeshow").show(); 
					$(".loadBox").hide();
					$("#fault_open").show();					
				}else{
					
					$("#fadeshow").show(); 
					$(".loadBox").hide();
					$("#success").show();					
					
				}
			}
		});
	}
	
	
	function cancel()
	{		
		location.href=getContextPath() +"/VirtualIntegration/vmSearch";
	}
	
	
</script>
</html>