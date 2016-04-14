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
	<link rel="stylesheet" type="text/css" href="${_base }/resources/css/kkpager/kkpager_orange.css"/>
	<script type="text/javascript" src="${_base }/resources/bower_components/jquery/dist/jquery-1.10.2.js"></script>
	<script type="text/javascript" src="${_base }/resources/js/virtual/timejs/laydate.js"></script>
	<script type="text/javascript" src="${_base }/resources/js/virtual/virtualIntegration.js"></script>
	<script type="text/javascript" src="${_base }/resources/js/kkpager/kkpager.min.js"></script>
	<script>
		function getSure(){
			
			$.ajax({
				cache : true,
				type : "POST",
				url : getContextPath() +"/softwareInstall/softInstallSubmit",
				//dataType : 'json',
				async : true,
				data : {
					"orderDetailId" : $("input[name='OrderDetailId']").val(),//云类别
				},
				success: function(data){
					if(data.responseCode!=null && data.responseCode!=""){
						if(data.responseCode=="000000"){ 
							location.reload();
						}else if(data.responseCode=="999999"){
							location.reload();
						}
					} 
				},
				error : function(data) {
					//alert("请求失败！")
					
					$("#msg").text("请求失败！");
				}
			});
			
			/* location.reload(); */
		}
		
		function getCancel(){
			$("#fadeshow").hide(); 
			$("#success").hide();
		}
		
		function getFault(){
			$("#fadeshow").hide(); 
			$("#fault").hide();
		}
	</script>
</head>
<style type="text/css">
	.inform-success,.inform-fault{width: 460px;height: 205px;background: #fff;box-shadow: 0 0 5px 1px #ccc;position: relative;}
	.ok{position: absolute;left: 50%;top: 37px;margin-left:-15px;}
	.inform-success h4,.inform-fault h4{color: #333;position: absolute;left: 121px;top:70px;}
	.sure{color: #fff;background:#169ADB;border: 1px solid #056A9E;left: 230px;width: 80px;height: 35px;text-align:center;line-height: 35px;font-weight: bold;font-size: 16px;position: absolute;top: 127px;}
	.cancle{color: #fff;background:#CCCCCC;border: 1px solid #CCCCCC;left: 337px;width: 80px;height: 35px;text-align:center;line-height: 35px;font-weight: bold;font-size: 16px;position: absolute;top: 127px;}
	.div_overlay{display:none;position: fixed;width: 100%;height:100%;z-index:1010;-moz-opacity: 0.0; opacity:0.00;filter: alpha(opacity=0);background-color: black;}
</style>
<body>
	<input type="hidden" name="OrderDetailId"/>
	<div id="fadeshow" class="div_overlay"></div> 
	<div id="success" class="inform-success" style="display: none;left:380px; top:200px;position:fixed; z-index:1011;_position:absolute;">
    	<h4 style="left:70px;padding:8px;top:48px;">您确定软件安装已完成了吗？</h4>
			<button id="confirm_success" class="sure"  onclick="getSure();">确定</button>
			<button id="confirm_cancel" class="cancle" onclick="getCancel();">取消</button>
		
    </div>
    <div id="fault" class="inform-fault"  style="display: none;left:450px; top:200px;position:fixed; z-index:1011;_position:absolute;">
    	<img src="${_base }/resources/images/no.jpg" class="ok">
    	<h4  style="left:135px;padding:10px;">操作失败！</h4>
		<button id="confirm_fault"  class="sure"  onclick="getFault();">确定</button>
    </div>

	<div class="content">
		<div class="content-top">
			<span class="reporter">报告人</span>
			<input type="text" class="reporter-txt" id="selectUserName" >
			<span class="mobile">手机号</span>
			<input type="text" class="mobile-txt" id="selectUserPhone" maxlength="11">
			<span class="department">部门信息</span>
			<input type="text" class="department-txt" id="selectUserDepartment">
			<span class="apply-time">申请时间</span>
			<div class="white-box1"></div>
			<input type="text" id="registerDateStart" class="time-txt1" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
			<span class="time-to">至</span>
			<div class="white-box2"></div>
			<input type="text" id="registerDateEnd" class="time-txt2" onclick="laydate({istime: true, format: 'YYYY-MM-DD'})">
			<input type="button" class="search" value="查询"  onclick="querytickets(1)">
			<input type="hidden" id="operateID" value="${operateId }">
		</div>
		<div class="content-middle">
			<input type="button" class="time-turn" onclick="timeSort()">
			
			<ul class="catelogy">
				<li class="reseach-cloud">研发云</li>
				<li class="all-cloud li-cloud">全部</li>
				<li class="rent-cloud">华为租用云</li>
			</ul>
			
			<input type="hidden" id="belongCloud_V" value=""> 
			
			<input type="text" class="key" value="请输入关键字" id="key">
			<div class="search-txt" onclick="KeySearch()"></div>
		</div>
		
		<ul class="content-info" id="content-info">
        
        <!--
			<div class="info">
				<div class="fault-num">k8888888</div>
				<span class="report-tittle gray">报告人:</span>
				<span class="report-info">XXX</span>
				<span class="contact gray">联系方式：</span>
				<span class="contact-info">13911099876</span>
				<span class="work gray">部门：</span>
				<span class="work-info">XXX</span>
				<span class="business gray">业务描述:</span>
				<span class="business-txt">业务相关描述信息业务相关描述信息业务相关描述信息业务相关描述信息业务相关描述信息业务相关描述信息业务相关描述信息业务相关描述信息业务相关描述信息业务相关描述信息业务</span>
				<span class="user-num gray">用户量：</span>
				<span class="user-info">100</span>
				<span class="visit gray">并发访问量：</span>
				<span class="visit-info">50</span>
				<span class="dot-line"></span>
				<div class="deploy">
					<span class="deploy-tittle">配置</span>
					<span class="cpu gray">CPU：</span>
					<span class="cpu-info">1核</span>
					<span class="machine gray">虚拟机类型：</span>
					<span class="machine-info">WEB服务器</span>
					<span class="link-type gray">链路类型：</span>
					<span class="link-info">联通</span>
					<span class="net-num gray">公网数量：</span>
					<span class="net-info">100个</span>
					<span class="memory gray">内存：</span>
					<span class="memory-info">2G</span>
					<span class="disk gray">数据盘容量：</span>
					<span class="disk-info">20G</span>
					<span class="company-net gray">公司宽带</span>
					<span class="companyNet-info">100G</span>
					<span class="operate gray">操作系统：</span>
					<span class="operate-info">Linux版本 CentOS Linux 6.0 64bit</span>
				</div>
				<a href=""><input type="button" class="made-btn" onclick="madeBox()">
			</div>
              -->
          
            

		</ul>
	    <div id="kkpager"></div>
	    
	</div>
	