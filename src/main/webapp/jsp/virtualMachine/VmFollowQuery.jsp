<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="UTF-8" import="java.util.*"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>虚拟机工单查询</title>
	<%@ include file="/jsp/common/common.jsp"%>
	<link href="${_base }/resources/css/bootstrap.min.css" rel="stylesheet">
	<link href="${_base }/resources/css/projectCommon.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="${_base }/resources/css/kkpager/kkpager_orange.css"/>
	<script type="text/javascript" src="${_base }/resources/bower_components/jquery/dist/jquery-1.10.2.js"></script>
	<script type="text/javascript" src="${_base }/resources/js/virtual/timejs/laydate.js"></script>
	<script type="text/javascript" src="${_base }/resources/js/virtual/vmFollowQuery.js"></script>
	<script type="text/javascript" src="${_base }/resources/js/kkpager/kkpager.min.js"></script>
	<script>
		
		
		
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


	<div class="content">
		<div class="content-top">
			<span class="reporter">报告人</span>
			<input type="text" class="reporter-txt" id="selectUserName">
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
		
		<ul class="content-info" id="content-info"></ul>
	    <div id="kkpager"></div>
	    
	</div>
	
	<!--跟踪查询-->
	<div id="follwQuery" class="check-deal-details">
  		
  	</div>
  	<div class="coverBox"></div>
</body>
</html>