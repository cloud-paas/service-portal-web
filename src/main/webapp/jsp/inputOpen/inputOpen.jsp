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
	<script type="text/javascript">
		$(function(){
			initOpen();
		})
		 function initOpen(){
			 
			 
			 
			var belongCloud=$("#belongCloud").val();
			 
			var vmNumber=$("#vmNumber").val();
		
			var netBand=$("#netBand").val();
			$(".load-num").text(vmNumber+"台");
			var init="";
			
			for(var i=0;i<vmNumber;i++){
				init+="<li><label>内网IP：</label><input type=\"text\" id='"+"in"+i+"' class=\"must-ip1\">";
				init+="	<label>公网IP：</label>";
				if(belongCloud==1){
					init+="<input type=\"text\" id='"+"out"+i+"' style=\"background:#f9f9f9;border:1px solid eaeaea;\" readonly></li>";
				}else if(belongCloud==2){
					init+="<input type=\"text\" id='"+"out"+i+"' class=\"must-ip2\" ></li>";
				}
				
			}
			$('.load-right').append(init);
			
		} 
		
	</script>
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
	<div id="success" class="inform-success"
		style="display: none; left: 450px; top: 200px; position: fixed; z-index: 1011; _position: absolute;">
		<img src="${_base }/resources/images/yes.jpg" class="ok">
		<h4 style="left: 170px; padding: 10px;">录入开通成功！</h4>
		<button id="confirm_success" class="sure" onclick="getSure();">确定</button>
	</div>
	<div id="fault_open" class="inform-fault"  style="display: none;left:450px; top:200px;position:fixed; z-index:1011;_position:absolute;">
    	<img src="${_base }/resources/images/no.jpg" class="ok">
    	<h4 style="left:170px;padding:10px;">录入开通失败！</h4>
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
			<div class="loadBox-content">
				<div class="load-top">
				    <input type="hidden" value="${inputparam.kkpage }" id="kkpage_temp_value">
					<input type="hidden" value="${inputparam.orderDetailId }" id="orderDetailId">
					<input type="hidden" value="${inputparam.orderWoId}" id="woId">
					<input type="hidden" id="operateID" value="${ inputparam.operateId}">
					<input type="hidden" id="belongCloud" value="${inputparam.belongCloud }"> 
					<input type="hidden" id="vmNumber" value="${inputparam.vmNumber}">
					<input type="hidden" id="netBand" value="${inputparam.netBand}">
					<div class="load-left">
						<span class="load-blue load-num">4台</span>
						<span class="load-blue load-ip-ad">虚拟机IP地址</span>
					</div>
					<ul class="load-right">
						
						
					</ul>
				</div>
				
				<div class="load-bottom">
					<ul class="load-b-right">
						<li>
							<label class="load-user">用户名：</label>
							<input type="text" class="load-user-c" readonly="readonly" value="${inputparam.username }">
							<label class="load-key">密码：</label>
							<input type="text" class="load-key-c" readonly="readonly" value="${inputparam.password }">
						</li>
					</ul>
				</div>
				<button class="load-submit"  onclick="inputSubmit()">提交</button>
				<button class="load-cancel" onclick="cancel()">取消</button>
				<span class="ip-warn" style="color:red"></span>
			</div>
		</div>
		<div class="cover"></div>
	    <div id="kkpager"></div>
	    
	</div>
	

</body>
<script type="text/javascript">
	function inputSubmit(){
		//研发校验
		if($('#belongCloud').val()==1){
			var flag1111=true;
			$('.must-ip1').each(function(){
				var re = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/ ;
				if(re.test($(this).val())==false){
					$('.ip-warn').html('请输入正确的内网IP')
					flag1111=false;
				}
			})
			if(flag1111==false){
				return false;
			}
		}
		//租用校验
		if($('#belongCloud').val()==2){
			var flag2222=true;
			$('.must-ip1').each(function(){
				var re = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/ ;
				if(re.test($(this).val())==false){
					$('.ip-warn').html('请输入内网IP')
					//alert(1)
					//alert("0"+flag2222)
					flag2222=false;
					//alert("1"+flag2222)
				}
				//alert("2"+flag2222)
				
			})
			//alert("3"+flag2222)
			if(flag2222==false){
				return false;
			}
			//alert(888)
			
			
			
			var newArr=[];
			var hu=$('.must-ip2').length;
			//alert(hu)
	       	for (var i = 0; i < $('.must-ip2').length; i++) {
	           	newArr.push($('.must-ip2').eq(i).val()); // 将文本框的值添加到数组中
	       	}
	       	//alert(newArr)
	       	var num222=0;
	       	var num333=0;
	       	for (var i = 0; i < $('.must-ip2').length; i++) {
		       	if (newArr[i]!='') {
						num222++;
					};  
				if (newArr[i]=='') {
					num333++;
				}; 
	      	};
	       //alert(num222);
	       //alert($('#netBand').val())
	       //alert(num333);
			if(num222!=$('#netBand').val()){
				$('.ip-warn').html('请输入数量相对应的公网IP')
				return false;
			}
		}
		
		
		var num=$(".load-right li").length;
		//alert(num)
		var ip="";
		for(var i=0;i<num;i++){
			
			if(i==0){
				ip+=$("#in"+i).val()+"_"+$("#out"+i).val();
			}else{
				ip+=","+$("#in"+i).val()+"_"+$("#out"+i).val();
			}
			
			 
		}
		 
		 
		 
		var username_txt=$(".load-user-c").val();
		var password_txt=$(".load-key-c").val();
		var orderdetailID=$("#orderDetailId").val();
		var woId=$("#woId").val();
		$.ajax({
			type:"POST",
			url:getContextPath()+"/input/inputOpen",
			data:{
				ip_net:ip,
				username:username_txt,
				password:password_txt,
				orderDeatilId:orderdetailID,
				orderWoId:woId
			},
			success: function(data)
			{
				 
				var object=JSON.parse(data);
				if(object.responseCode=="999999")
				{
					$("#fadeshow").show(); 
					$(".loadBox").hide();
					$("#fault_open").show();
					
						 
				}else if(object.responseCode=="000000"){
					
					$("#fadeshow").show(); 
					$(".loadBox").hide();
					$("#success").show();
					
				}
			}
		});
	}
	
	function checkValue(){
		var flag=true;
		$('.must-txt1').each(function(){
			if($(this).val()=='' || $(this).val()==null){
				$(this).siblings('span').css('display','inline-block');
				flag=false;
				
			}else if($(this).val()=='' || $(this).val()!=null){
				$(this).siblings('span').css('display','none');
			}
		})
		return flag;
	}
	
	function cancel()
	{
	 
		$(".load-user-c").val("");
		$(".load-key-c").val("");
		$(".loadBox").css('display','none');
		$(".cover").css('display','none');
		location.href=getContextPath() +"/VirtualIntegration/vmSearch";
	}
	
	function testIp1(ip){
		var ip_value=ip;
		var re =  /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/ ;
		if(re.test(ip)==false)
		{
			$('.warn1').css('display','inline-block');
			$('.in-IP-txt').val('');
		}else{
			$('.warn1').css('display','none');
		}
	}
	
	function testIp2(ip){
		var ip_value=ip;
		var re =  /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/ ;
		if(re.test(ip)==false)
		{
			$('.warn2').css('display','inline-block');
			$('.out-IP-txt').val('');
			 
		}else{
			$('.warn2').css('display','none');
		}
	}
	
	function testpwd(pwd)
	{
			var password=pwd;
			var reg=/^[0-9A-Za-z_]{6,18}$/;
			if(reg.test(password)==false)
			{
				$('.warn4').css('display','inline-block');
				$('.passKey-txt').val('');
				 
			}else{
				$('.warn4').css('display','none');
			}
	}
	
	function testuserName(name)
	{
		var username=name;
		var regex=/^[0-9A-Za-z_]{6,18}$/;
		if(regex.test(username)==false)
		{
			$('.warn3').css('display','inline-block');
			$('.userContent').val('');
		}else{
			$('.warn3').css('display','none');	
		}
	}
</script>
</html>