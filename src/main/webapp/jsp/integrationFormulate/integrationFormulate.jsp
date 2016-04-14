<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>Document</title>
	<%@ include file="/jsp/common/common.jsp"%>
	<link href="${_base }/resources/css/bootstrap.min.css" rel="stylesheet">
	<link rel="stylesheet" type="text/css" href="${_base }/resources/css/projectCommon.css"/>
	<script type="text/javascript" src="${_base }/resources/bower_components/jquery/dist/jquery-1.10.2.js"></script>
	<script type="text/javascript" src="${_base }/resources/js/virtual/timejs/laydate.js"></script>
	<script type="text/javascript" src="${_base }/resources/js/virtual/makeProject.js"></script>
	
	<style>	
		.inform-success,.inform-fault{width: 460px;height: 205px;background: #fff;box-shadow: 0 0 5px 1px #ccc;position: relative;}
		.ok{position: absolute;left: 50%;top: 37px;margin-left:-15px;}
		.inform-success h4,.inform-fault h4{color: #333;position: absolute;left: 191px;top:70px;}
		.sure{color: #fff;background:#169ADB;border: 1px solid #056A9E;left: 177px;width: 110px;height: 35px;text-align:center;line-height: 35px;font-weight: bold;font-size: 16px;position: absolute;top: 137px;}
		.div_overlay{display:none;position: fixed;width: 100%;height:100%;z-index:1010;-moz-opacity: 0.0; opacity:.00;filter: alpha(opacity=0);background-color: black;}

	</style>	
	
	<script>
		function getSure(){
			location.href="${_base}/VirtualIntegration/vmSearch";
		}
		
		function getFault(){
			$("#fadeshow").hide(); 
			$("#fault").hide();
		}
	</script>
</head>
<body>

	<div id="fadeshow" class="div_overlay"></div> 
	<div id="success" class="inform-success" style="display: none;left:450px; top:200px;position:fixed; z-index:1011;_position:absolute;">
    	<img src="${_base }/resources/images/yes.jpg" class="ok" >
    	<h4 style="left:115px;padding:10px;margin-left:20px">集成方案制定已完成！</h4>
		<button id="confirm_success" class="sure" onclick="getSure();">知道了</button>
    </div>
    <div id="fault" class="inform-fault"  style="display: none;left:450px; top:200px;position:fixed; z-index:1011;_position:absolute;">
    	<img src="${_base }/resources/images/no.jpg" class="ok">
    	<h4 id="fault_tishi" style="left:170px;padding:10px;">集成方案制定失败！</h4>
		<button id="confirm_fault"  class="sure" onclick="getFault();">确定</button>
    </div>

	<!-- 参数隐藏域 -->
	<input type="hidden" value="${orderDetailId}" id="orderDetailId"/>
	<input type="hidden" value="${orderWoId}" id="orderWoId"/>
	<input type="hidden" id="cloud_id"/>
	<input type="hidden" id="cpu_value"/>
	<input type="hidden" id="virtualRam"/>
	<input type="hidden" id="SysTem"/>
	<input type="hidden" id="SysTemChild"/>
	
	<input type="hidden" id="BelongCloudTemp"/>
	<input type="hidden" id="SaveSoftTemp" style="width:400px"/>   
	<input type="hidden" id="RunSoftTemp" style="width:400px"/>   

 	<input type="hidden" id="prodId"/> 

	<!-- 链路 -->
	<input type="hidden" id="netType"/> 
	 
	<div class="madeBox">
		<div class="basic-info">
			<div class="left-tittle">基本信息</div>
			<div class="basic-content">
				<div class="info-line1">
					<div class="gray name">报告人:</div>
					<div class="name-txt"></div>
					<div class="gray depart">申请部门:</div>
					<div class="depart-txt"></div>
				</div>
				<div class="info-line1">
					<div class="gray link-mobile">联系电话:</div>
					<div class="link-mobile-txt"></div>
					<div id="user_email" class="gray mail-adr">邮箱地址:</div>
					<div class="mail-adr-txt"></div>
				</div>
				<div class="info-line1">
					<div class="gray apply-reason">申请原因:</div>
					<div class="apply-reason-txt"></div>
					
				</div>
			</div>	        						
		</div>
		<div class="project">
			<div class="project-tittle">项目信息</div>
			<div class="project-content">
				<div class="info-line2">
					<div class="project-name gray">项目代码/名称:</div>	
					<div class="project-name-txt"></div>	
				</div>
				<div class="info-line2">
					<div class="user-amount gray">用户数:</div>
					<div class="user-amount-txt"></div>
					<div class="visiter gray">并发访问量:</div>				
					<div class="visiter-txt"></div>		
				</div>
				<div class="info-line2">
					<div class="fund gray">资源申请方式:</div>					
					<div class="fund-txt"></div>	
					<div class="use gray">用途说明:</div>				
					<div class="use-txt"></div>				
				</div>
				<div class="info-line2">
					<div class="profession gray">业务描述:</div>				
					<div class="profession-txt"></div>	
				</div>
				<div class="info-line2">
					<div class="gray applyTime">申请时间:</div>
					<div class="applyTime-txt"></div>
					<div class="gray stopTime">到期时间:</div>
					<div class="stopTime-txt"></div>
				</div>
				
			</div>	        						
		</div>
		<div class="remark">
			<div class="remark-tittle">备注</div>
			<div class="remark-content">
				<div class="remark-info gray">备注信息：</div>
				<div class="remark-info-txt"></div>
			</div>
		</div>
		<div class="iaas_table" > 
			<div>
				<div  class="iaas_table_title" style="float:left;height:302px;background:#F2F2F2;padding:103px 20px 0px 20px;font-size:16px;width:60px;">基本配置</div>
				<div   style="background:#FAFAFA;height:302px;min-width: 803px;width:90%;float:left;">
					<div  style="text-align:center;">
						<div class="basic-line" style="position:relative;margin-top:30px;">
							<div width="10%" class="gray" style="position:absolute;left:30px;">虚拟机类型：</div>
							<div width="80%" style="text-align:left;font-size:15px;font-weight:600;position:absolute;left:146px;" id="virtualType">
								 <div class="tab_div_a_sys2 tab_div_a_sys3" style="width:430px;">
								   <ul id="Vmtype">
									<!--    <li class="qieh hideclass radius_left" id="c1"><a class="radius_left blue-b" href="#top_one">WEB服务器</a></li>
									   <li class="dianxin"><a href="#top_one">
									  WEB服务器
									   </a></li>
									   <li class="hideclass radius_right  " id="c2"><a class="radius_right " href="#top_two" >
									  WEB服务器
									   </a></li> -->
								   </ul> 
							    </div> 

							    <span class="gray" style="font-weight:normal;line-height:30px;">原：</span>
							    <span class="gray" id="Vmtype_before" style="font-weight:normal;line-height:30px;"></span>
							</div>
						</div>
						<div class="basic-line" style="position:relative;">
							<div width="10%" class="gray"   style="position:absolute;left:30px;">虚拟机数量：</div>
							<div width="80%" style="position:absolute;left:205px;">
								<input type="text" id="vmNumber" onkeyup="value=value.replace(/[^0-9_]/g,'')" style="position:absolute;left:-57px;width: 190px;height: 30px; border: 1px solid #CCCCCC;border-radius: 2px;">
							</div>
						</div>	
						<div style="position:relative;" class="basic-line">
							<div class="gray" style="padding-left:77px;float:left">cpu：</div>
							<div  style="position:absolute;left:150px;float:left">
								<!--TAB切换-->
								 <div class="tab_div_cpu">
								  <div class="tab_div_a_cpu  cpu1">
									   <ul class="cpu_param">
									   	   
									   </ul> 
									   <label class="cpu-change">3核</label>
								  </div> 
								</div>  
							</div>
						</div>
						<div style="position:relative;" class="basic-line">
							<div width="20%" class="gray" style="padding-left:72px;float:left">内存：</div>
							<div width="80%" style="position:absolute;left:150px;float:left">
								<!--TAB切换-->
								 <div class="tab_div_neicun">
								  <div class="tab_div_a_neicun neicun1">
									   <ul class="memory_param" id="neicun_value">
									   </ul> 
									   <label class="neicun-change">2G</label>
								  </div> 
								</div>  
							</div>
						</div>							
						<div style="position:relative;" class="basic-line">
							<div width="20%" class="gray" style="padding-left:44px;float:left">数据盘：</div>
							<div width="80%" style="position:absolute;left:150px;float:left">
								<!--TAB切换-->
								 <div class="tab_div_yp" style="position:absolute;left:-10px;top:-14px;">
								  <div class="tab_div_a_yp">
									  <div class="User_ratings User_grade" id="div_fraction0"> 
										<div class="ratings_bars">  
											<div class="scale" id="bar0">
												<div id="slider0"></div>
												<span id="btn0">
													<span id="title0">10G</span>
												</span>

											</div>
										<label class="tenG">10G</label>
										<label class="twoG">200G</label>
										 <input type="text" class="caliche" style="width:40px;height:22px;" onblur="move()">
										 <label style="font-size:16px;color:#A7A7A7;line-height:24px;position:absolute;left:400px;top:5px">G</label>
										</div>
									</div>
								  </div> 
								</div> 
								<div class="disk-before">40G</div> 
							</div>
						</div>
						</div>
					</div>
				</div>  
		</div>
		<div class="net resource">
			<div class="net-tittle">网络资源</div>
			<div class="net-content">
				<div class="info-line1" style="margin-bottom:100px;margin-top:10px;">
					<div class="link-tittle gray">链路类型:</div>
					<div class="link-type1" >
					    <div class="tab_div_a_sys2">
						   <ul>
							 <!--   <li class="qieh hideclass radius_left liantong" id="c1"><a class="radius_left blue-b" href="#top_one">联通</a></li>
							   <li class="dianxin"><a href="#top_one">
							  电信
							   </a></li>
							   <li class="double"><a href="#top_one">
							  联通+电信
							   </a></li>
							   <li class="hideclass radius_right BGP" id="c2"><a class="radius_right " href="#top_two" >
							  BGP
							   </a></li>   -->
						   </ul> 
					    </div> 
					</div>  
					<div class="gray type-before"></div>			
				</div>
				<div class="info-line1 line-marbottom tr1-1" style="margin-bottom:30px;">
					<div class="link-tittle gray" style="top:10px;">公网宽带:</div>
					<div class="tab_div_yp net-move" >
					  <div class="tab_div_a_yp">
						  <div class="User_ratings User_grade" id="div_fraction0"> 
							<div class="ratings_bars">  
								<div class="scale" id="bar1">
									<div id="slider1"></div>
									<span id="btn1">
										<span id="title1">1M</span>
									</span>

								</div>
							<label class="tenM">1M</label>
							<label class="twoM">100M</label>
							 <input type="text" class="net-value" id="net_value1" onblur="move1()">
							 <label style="font-size:16px;color:#A7A7A7;line-height:24px;position:absolute;left:390px;top:5px">M</label>
							</div>
						</div>
					  </div> 
					</div>  

					

					<div class="net-before" id="net-before_1"></div>

				</div>
				<div class="info-line1 line-marbottom tr2-1" style="margin-bottom:30px;">
					<div class="link-tittle gray" style="top:10px;">公网宽带:</div>
					<div class="tab_div_yp net-move">
					  <div class="tab_div_a_yp">
						  <div class="User_ratings User_grade" id="div_fraction0"> 
							<div class="ratings_bars">  
								<div class="scale" id="bar2">
									<div></div>
									<span id="btn2">
										<span id="title2">1M</span>
									</span>

								</div>
							<label class="tenM">1M</label>
							<label class="twoM">20M</label>
							 <input type="text" class="net-value company1" id="net_value2" onblur="move2()">
							 <label style="font-size:16px;color:#A7A7A7;line-height:24px;position:absolute;left:394px;top:9px">M</label>
							</div>
						</div>
					  </div> 
					</div>  
					<div class="net-before" id="net-before_2"></div>
				</div>
				
				<div class="info-line1">
					<div class="link-tittle gray" style="margin-right:34px;">公网数量:</div>
					<input type="text" class="net-Num" style="margin-left:155px;line-height:10px;height:30px;" id="netNum1" onkeyup="value=value.replace(/[^0-9_]/g,'')">
				</div>
			</div>	        						
		</div>
		<div class="net ">
			<div class="net-tittle system-tittle">操作系统</div>
			<div class="net-content system-content">
				<div class="info-line1 system-mar1" style="margin-bottom:120px;margin-top:10px;">
					<div class="link-tittle gray">操作系统:</div>
					<div class="link-type1">
					    <div class="tab_div_a_sys1">
						   <ul class="operate-sys">
							  <!--  <li class="qieh hideclasms radius_left Linux1" id="c1"><a class="radius_left " href="#top_one">Linux版本</a></li>
							   <li class="Window1"><a href="#top_one">Window版本</a></li>			
							   <li class="hideclass radius_right Ubuntu1" id="c2"><a class="radius_right " href="#top_two" >Ubuntu</a></li>   -->
						   </ul> 
					    </div> 
					</div>  			
				</div>
				<ul class="linux1">
					<!-- <li>CentOS Linux 5.5 64bit</li>
					<li>CentOS Linux 5.8 64bit</li>
					<li>CentOS Linux 6.0 64bit</li>
					<li>CentOS Linux 6.0 32bit</li>
					<li>CentOS Linux 6.1 64bit</li>
					<li>CentOS Linux 6.2 64bit</li>
					<li>CentOS Linux 6.3 64bit</li>
					<li>CentOS Linux 6.4 64bit</li>
					<li>CentOS Linux 6.5 64bit</li> -->
				</ul>
				<ul class="window1">
					<!-- <li>Windows DC 2008 R2 64bit</li>
					<li>Windows 2008 EN R2 64bit</li>
					<li>Windows EN 2008 SP2 64bit</li>
					<li>Windows Web Server 2008 R2 64bit </li> -->
				</ul>
				<ul class="ubuntu1">
					<!-- <li>Ubuntu  10.04 64bit</li>
					<li>Ubuntu  12.04 64bit</li> -->
				</ul>
			</div>	    
		</div> 
		
		<!-- 测试用例
		<input type="text" id="BelongCloudTemp"/>
	    <input type="text" id="SaveSoftTemp" style="width:400px"/>   
	    <input type="text" id="RunSoftTemp" style="width:400px"/>    -->
	
		
		<div class="soft-install">
			<div class="soft-tittle">安装软件</div>
			<div class="soft-content">
			
				<div id="save-soft-parent">
					<div class="save-soft gray">存储软件:</div>
					<div id="SaveSoft_M" class="save-soft-content"></div>
				</div>
				<div id="run-soft-parent">	
					<div class="run-soft gray">运行环境软件:</div>
					<div id="RunSoft_M" class="run-soft-content"></div>
				</div>
			</div>
		</div>
		<div style="float: left">
		<div style="float:left">
		<a href="javascript:;"><button class="submit"  onmousedown="InFormulateSubmit();">提交</button></a>  			
		<a href="${_base}/VirtualIntegration/vmSearch"><button class="cancel" >取消</button></a>
		</div>
		<div style="color:red;float:left;margin-left: 20px; padding-top:30px" id ="msg"></div>   
		</div>					
	</div>
</body>
<script type="text/javascript">
function Soft(belongCloud_V0,SystemCode_V0,Value0){
	var belongCloud_V = belongCloud_V0;
	var SystemCode_V = SystemCode_V0;
	var Value = Value0;
	
 if(belongCloud_V==null || belongCloud_V==undefined || belongCloud_V==""){
	 belongCloud_V = $("#BelongCloudTemp").val();
	// alert("01:"+belongCloud_V);
 }
 
	$("#SaveSoftTemp").val("");    
	$("#RunSoftTemp").val("");      
	$("#SaveSoft_M").text("");
	$("#RunSoft_M").text("");
	
	$.ajax({
		async:true,
		cache : true,
		type : "POST",
		url : getContextPath() +"/IntegrationFormulate/SoftLoading",
		data : {
			SystemCode: SystemCode_V.trim(),
			belongCloud: belongCloud_V.trim()
		},
		dataType : 'json',
		async : false,
		success: function(data){
			var SoftTemSv= "";
			var SoftTemRu= "";
			if(data!=null&&data.code=="0000"){
				//_______Save_Soft
				if(data.Save_Soft!=null){
					$(".rent #zy_save-soft-content").empty();
					var arr1= data.Save_Soft.split(";");
					 for (var i=0;i< arr1.length ;i++){
						
						  var chec='';
						 if(Value!=null && Value!=undefined && Value!=""){
							 var arrQ = Value.storageSoft.split(",")  //存储软件
							 for (var j=0;j< arrQ.length ;j++){
								 //alert(arr1[i]+"?"+arrQ[j])
								 if(arr1[i].trim()==arrQ[j].trim()){
									 	//alert("Save_Soft==")
										 chec='checked';
								 }
							 } 
						 }
						 //alert("chec:"+chec)
						 SoftTemSv = SoftTemSv + "<div class='check-content1' style='width:auto; float:left'>";      
						 SoftTemSv = SoftTemSv + "<input type='checkbox' "+chec+" name='storageSoft001' id='checksave"+i+"'  onclick='softCheck001();' style='float:left'>";
						 SoftTemSv = SoftTemSv + "<div style='float:left'>"+arr1[i]+"</div></div>";
					 }
					$("#SaveSoft_M").append(SoftTemSv);
				}
				
				
				 
				
				//______Run_Soft
				 if(data.Run_Soft!=null){
					$(".rent #zy_run-soft-content").empty();
					var arr2= data.Run_Soft.split(";");
					 for (var i=0;i< arr2.length ;i++){
						 var chec='';
						 if(Value!=null && Value!=undefined && Value!=""){
							 var arrQ = Value.environmentSoft.split(",")  //存储软件
							 for (var j=0;j< arrQ.length ;j++){
								 if(arr2[i].trim()==arrQ[j].trim()){
									 //alert("====");
										 chec='checked';
								 }
							 } 
						 }
						 
						 SoftTemRu = SoftTemRu + "<div class='check-content1' style='width:auto; float:left'>";
						 SoftTemRu = SoftTemRu + "<input type='checkbox' "+chec+" name='storageSoft002' id='checkrun"+i+"'  onclick='softCheck002();' style='float:left'>";
						 SoftTemRu = SoftTemRu + "<div style='float:left'>"+arr2[i]+"</div></div>";
						 
						/*  if(Value!=null && Value!=undefined && Value!=""){
							 var arrQ=Value.environmentSoft.split(",")  //运行软件
							 for (var j=0;j< arrQ.length ;j++){
							 	if(arr1[i]==arrQ[j]){
							 		//document.getElementById('checksave'+i).checked=true;
							 	}
						 	}
						 } */
							 
					 }
					$("#RunSoft_M").append(SoftTemRu);  
				} 
			
		} 

		}
	});
	
	
}

////////////////////////////////////////////////////////////////////////////

$(function(){
		// 页面初始化

	searchDetail();	
	$('.tab_div_a_cpu ul li a').click(function(){
		$(this).addClass('blue-b').parents('li').siblings('li').children('a').removeClass('blue-b');
		changememory($(this).text());
		var value=$(this).text();
		var value1=value.split("核");
		var value2=parseInt(value1[0]);
		
		var value3=$('.cpu-change').text();
		var value4=value3.split("核");
		var value5=parseInt(value4[0]);
		if(value2>value5){
			$('.cpu-change').css('background','url(../resources/images/up-arrow.jpg) no-repeat right 0px')
		}else if(value2<value5){
			$('.cpu-change').css('background','url(../resources/images/down-arrow.jpg) no-repeat right 8px')
		}
		$("#cpu_value").val($(this).text().trim());
	});
	$('.tab_div_a_sys3 ul li a').click(function(){
		$(this).addClass('blue-b').parents('li').siblings('li').children('a').removeClass('blue-b');
	})
	// 内存背景切换
	$('.tab_div_a_neicun ul li a').click(function(){
		$(this).addClass('blue-b').parents('li').siblings('li').children('a').removeClass('blue-b')
		$("#virtualRam").val($(this).text().trim());
		var value=$(this).text();
		var value1=value.split("核");
		var value2=parseInt(value1[0]);
		
		var value3=$('.neicun-change').text();
		var value4=value3.split("核");
		var value5=parseInt(value4[0]);
		
		if(value2>value5){
			$('.neicun-change').css('background','url(../resources/images/up-arrow.jpg) no-repeat right 0px')
		}else if(value2<value5){
			$('.neicun-change').css('background','url(../resources/images/down-arrow.jpg) no-repeat right 8px')
		}
	});
	$('.tab_div_a_sys1 ul li a').click(function(){
		$("#SysTem").val($(this).text().trim());
	});	
	$('.tab_div_a_sys2 ul li a').click(function(){
		$(this).addClass('blue-b').parents('li').siblings('li').children('a').removeClass('blue-b')
		$("#netType").val($(this).text().trim());
	});
	$('.operate-sys li a').click(function(){
 		$(this).addClass('blue-b').parents('li').siblings('li').children('a').removeClass('blue-b');
 		
	})
	$('.Linux1').click(function(){
		$('.linux1').css('display','inline-block');
		$('.window1').css('display','none');
		$('.ubuntu1').css('display','none');
		$('.window1 li').removeClass('blueLi');
		$('.ubuntu1 li').removeClass('blueLi');
	})
	$('.Window1').click(function(){
		$('.linux1').css('display','none')
		$('.window1').css('display','inline-block')
		$('.ubuntu1').css('display','none')
		$('.linux1 li').removeClass('blueLi');
		$('.ubuntu1 li').removeClass('blueLi');
	})
	$('.Ubuntu1').click(function(){
		$('.linux1').css('display','none')
		$('.window1').css('display','none')
		$('.ubuntu1').css('display','inline-block')
		$('.linux1 li').removeClass('blueLi');
		$('.window1 li').removeClass('blueLi');
	})
	// 操作系统下li背景
	$('.linux1 li').click(function(){
		$(this).addClass('blueLi').siblings().removeClass('blueLi');
	})
	$('.window1 li').click(function(){
		$(this).addClass('blueLi').siblings().removeClass('blueLi');
	})
	$('.ubuntu1 li').click(function(){
		$(this).addClass('blueLi').siblings().removeClass('blueLi');
	})
	
	
	
	});	
	 
	
	

function searchDetail(){
	 
	var orderDetailId=$("#orderDetailId").val();
	 
	$.ajax({
		type:"POST",
		url:getContextPath()+"/formulate/searchDetail",
		data:{
			orderDetailId:orderDetailId
		},
		async:false,
		success: function(data){
			/* console.log(data); */
			if(data.resultCode=="999999")
			{
				//alert(data.resultMsg);	
				$("#msg").text(data.resultMsg);
			}else{
				
				
				    $("#BelongCloudTemp").val(data.belongCloud);  //记录所属云
				
				 	$("#prodId").val(data.prodId);
					$(".name-txt").text(data.applicant);
					$(".depart-txt").text(data.applicantDept);
					$(".link-mobile-txt").text(data.applicantTel);
					$(".mail-adr-txt").text(data.applicantEmail);
					$(".apply-reason-txt").text(data.applicantReason);
					$(".project-name-txt").text(data.costCenterCode+data.costCenterName);
					$(".user-amount-txt").text(data.userMaxNumbers);
					$(".visiter-txt").text(data.concurrentNumbers);
					var obj = eval("("+data.prodParam+")");
/////////////////////////////////////////////////////////////////////////////////////////////////////					
					//$(".save-soft-content").text(obj.storageSoft);
					//$(".run-soft-content").text(obj.environmentSoft);
//////////////////////////////////////////////////////////////////////////////////////////////////					
					
					
					
					if(data.applyType=="1")
					{
						$(".fund-txt").text("新建");
					}else if(data.applyType=="2")
					{
						$(".fund-txt").text("变更");
					}
					if(data.useType=="1")
					{
						$(".use-txt").text("开发");
					}else if(data.useType=="2"){ 
						$(".use-txt").text("测试");
					}else if(data.useType=="3"){
						$(".use-txt").text("生产");
					}else if(data.useType=="4"){
						$(".use-txt").text("其他");
					}
					$(".profession-txt").text(data.applyDesc);
					$(".remark-info-txt").text(data.applicantDesc);
					$(".applyTime-txt").text(data.orderAppDate);
					$(".stopTime-txt").text(data.expirationDate);
					var object=JSON.parse(data.prodParam);
					
					var vmType=loadVmType(data.belongCloud);
					$("#Vmtype_before").text(object.virtualType);
					
					
					if(vmType!=null&&vmType.length>0){
						var type="";
						for(var i=0;i<vmType.length;i++)
						{
							if(vmType[i]==object.virtualType){
								
								if(i==0){
									type+="<li class='qieh hideclass radius_left' ><a class=\"radius_left blue-b\" href=\"#top_one\">"+vmType[i]+"</a></li>";
								}else if(i==vmType.length-1){
									type+="<li class='hideclass radius_right' ><a class=\"radius_right blue-b\" href=\"#top_two\" >"+vmType[i]+"</a></li>" ;

								}else{
									type+="<li><a href='#top_one' class=\"blue-b\">"+vmType[i]+"</a></li>";
								}
							}else{
								if(i==0){
									type+="<li class='qieh hideclass radius_left'  ><a class=\"radius_left\" href=\"#top_one\">"+vmType[i]+"</a></li>";
								}else if(i==vmType.length-1){
									 
									type+="<li class='hideclass radius_right' ><a class=\"radius_right  \" href=\"#top_two\" >"+vmType[i]+"</a></li>" ;

								}else{
									type+="<li><a href=\"#top_one\"  >"+vmType[i]+"</a></li>";
								}
							}
						}
						$("#Vmtype").append(type);
					}else{
						//alert("加载失败！");
						$("#msg").text("虚拟机类型加载失败！");
					}
					
					$("#vmNumber").val(data.vmNumber);
					
					var cpu="";
					cpu=loadcpu(data.belongCloud);
			 
					
					//$("#oldcpu").val(object.cpu);
					
					$("#cloud_id").val(data.belongCloud);
					 
					$("#cpu_value").val(object.cpu);
					$("#virtualRam").val(object.virtualRam);
					$("#SysTem").val(object.SysTem);
					$("#SysTemChild").val(object.SysTemChild);
					$("#netType").val(object.netType);
					
					var arr=cpu.split(";");
					var cpu="";
					$('.cpu_param').empty();
				 	$('.cpu-change').text(object.cpu);
					if(arr!=null&&arr.length>0)
					{
						
						for(var i=0;i< arr.length ;i++)
						{
							
							if(arr[i]==object.cpu)
							{
								if(i==0)
								{
									cpu+="<li class='hideclass radius_left' id='"+"c"+i+"'><A class='radius_left  blue-b' href='#top_one' >"+arr[i]+"</A></li>"
								}else if(i==arr.length-1)
								{
									cpu+="<li class='hideclass radius_right ' id='"+"c"+i+"'><a class='radius_right  blue-b' href='#top_two' >"+arr[i]+"</a></li> "
								}else{
									cpu+="<li class='hideclass ' id='"+"c"+i+"'><A class='blue-b' href='#top_one'>"+arr[i]+"</A></li>"
								}
								
							}else{
								if(i==0)
								{
									cpu+="<li class='hideclass radius_left ' id='"+"c"+i+"'><A class='radius_left' href='#top_one' >"+arr[i]+"</A></li>"
								}else if(i==arr.length-1)
								{
									cpu+="<li class='hideclass radius_right ' id='"+"c"+i+"'><a class='radius_right' href='#top_two' >"+arr[i]+"</a></li> "
								}else{
									cpu+="<li class='hideclass ' id='"+"c"+i+"'><A  href='#top_one' >"+arr[i]+"</A></li>"
								}
							}
							 
							
						}
						$('.cpu_param').append(cpu);
								
					}else{
						//alert("加载失败");
						$("#msg").text("cpu加载失败！");
					}
					
					var mem=loadmemory(data.belongCloud,object.cpu);
					var memarr=mem.split(";");
					
					var memory="";
					$('.memory_param').empty();
					$('.neicun-change').text(object.virtualRam);
					$("#oldmemory").val(object.virtualRam);
					for(var i=0;i<memarr.length;i++)
					{
						if(memarr[i]==object.virtualRam){
							if(i==0){
								memory+="<li class=' hideclass radius_left' id='"+"m"+i+"'><A class='radius_left blue-b' href='#top_one'>"+memarr[i]+"</A></li>"
							}else if(i==memarr.length-1){
								memory+="<li class='hideclass radius_right' id='"+"m"+i+"'><A class='radius_right blue-b' href='#top_one'>"+memarr[i]+"</A></li>"
							}else{
								memory+="<li class='hideclass ' id='"+"m"+i+"'><a class='blue-b' href='#top_two'>"+memarr[i]+"</a></li>"
							}
						}else{
							if(i==0){
								memory+="<li class=' hideclass radius_left' id='"+"m"+i+"'><A class='radius_left ' href='#top_one'>"+memarr[i]+"</A></li>"
							}else if(i==memarr.length-1){
								memory+="<li class='hideclass radius_right' id='"+"m"+i+"'><A class='radius_right' href='#top_one'>"+memarr[i]+"</A></li>"
							}else{
								memory+="<li class='hideclass' id='"+"m"+i+"'><a href='#top_two'>"+memarr[i]+"</a></li>"
							}
						}	
					}
					$('.memory_param').append(memory);
					$(".caliche").val(object.virtualHard);
					$("#olddisk").val(object.virtualHard);
					$('.disk-before').text(object.virtualHard+"G");
					var len=object.virtualHard*1.36;
					$('#btn0').css('left',len+"px");
					$('#slider0').css('width',len+"px");
					$('#title0').text(object.virtualHard+'G');
					
					if(data.belongCloud=="2"){
						var netSource=loadNetSource(data.belongCloud);
						var netSourcearr=netSource.split(";");
						$(" .resource").css("display",'block');
						$('.type-before').text("原："+object.netType);
						if(netSourcearr!=null&&netSourcearr!=undefined){
							var nets=""
							 
							for(var i=0;i<netSourcearr.length;i++){
								 
								if(object.netType==netSourcearr[i]){
									if(netSourcearr[i]=="BGP"){
										if(i==0){
											nets+=" <li class=\"qieh hideclass radius_left BGP\" onclick=\"bgp()\" ><a class=\"radius_left blue-b\" href=\"#top_one\">"+netSourcearr[i]+"</a></li>";
										}else if(i==netSourcearr.length-1){
											nets+=" <li class=\"hideclass radius_right BGP\" onclick=\"bgp()\" ><a class=\"radius_right blue-b\" href=\"#top_two\" >"+netSourcearr[i]+"</a></li>";
										}else{
											
											nets+="<li class=\"BGP\" onclick=\"bgp()\" ><a  class=\"blue-b\" href=\"#top_one\">"+netSourcearr[i]+"</a></li>";
										}
									}else{
										if(i==0){
											nets+=" <li class=\"qieh hideclass radius_left liantong\" onclick=\"liantong()\"><a class=\"radius_left blue-b\" href=\"#top_one\">"+netSourcearr[i]+"</a></li>";
										}else if(i==netSourcearr.length-1){
											nets+=" <li class=\"hideclass radius_right liantong\"  onclick=\"liantong()\"><a class=\"radius_right blue-b\" href=\"#top_two\" >"+netSourcearr[i]+"</a></li>";
										}else{
											nets+="<li class=\"liantong\"  onclick=\"liantong()\"><a  class=\"blue-b\" href=\"#top_one\" >"+netSourcearr[i]+"</a></li>";
										}
									}
									
								}else{
							
									if(netSourcearr[i]=="BGP"){
										if(i==0){
											nets+=" <li class=\"qieh hideclass radius_left BGP\" onclick=\"bgp()\"  ><a class=\"radius_left\" href=\"#top_one\">"+netSourcearr[i]+"</a></li>";
										}else if(i==netSourcearr.length-1){
											nets+=" <li class=\"hideclass radius_right BGP\" onclick=\"bgp()\" ><a class=\"radius_right\" href=\"#top_two\" >"+netSourcearr[i]+"</a></li>";
										}else{
											nets+="<li class=\"BGP\" onclick=\"bgp()\" ><a  href=\"#top_one\" >"+netSourcearr[i]+"</a></li>";
										}
									}else{
										if(i==0){
											nets+=" <li class=\"qieh hideclass radius_left liantong\"  onclick=\"liantong()\" ><a class=\"radius_left  \" href=\"#top_one\">"+netSourcearr[i]+"</a></li>";
										}else if(i==netSourcearr.length-1){
											nets+=" <li class=\"hideclass radius_right liantong\"  onclick=\"liantong()\"><a class=\"radius_right  \" href=\"#top_two\" >"+netSourcearr[i]+"</a></li>";
										}else{
											nets+="<li class=\"liantong\"  onclick=\"liantong()\"><a   href=\"#top_one\" >"+netSourcearr[i]+"</a></li>";
										}
									}
									
								}
							}
							$('.net .tab_div_a_sys2 ul').append(nets);
						}else{
							//alert("加载失败！");
							$("#msg").text("链路类型加载失败！");
						}
					/* 	$(".net .tab_div_a_sys2 li a").removeClass('blue-b');
						if($.trim(object.netType)=="联通"){
							$(".net .tab_div_a_sys2 li.liantong a").addClass('blue-b');
						}else if($.trim(object.netType)=="电信"){
							$(".net .tab_div_a_sys2 li.dianxin a").addClass('blue-b');
							
						}else if($.trim(object.netType)=="联通+电信"){
							$(".net .tab_div_a_sys2 li.double a").addClass('blue-b');
						}else if($.trim(object.netType)=="BGP"){
							$(".net .tab_div_a_sys2 li.BGP a").addClass('blue-b');
						} */
						if(object.netType=="BGP"){
							$(".tr1-1").css("display",'none');
							$('.tr2-1').css("display",'display');
							$('#net_value2').val(object.netBandW);
							$('#net-before_2').text(object.netBandW+'M');
							var len2=object.netBandW*13.75;
							$('#btn2').css('left',len2+"px");
							$('#slider2').css('width',len2+"px");
							$('#title2').text(object.netBandW+'M');
						}else{
							 
							$(".tr2-1").css("display",'none');
							$('.tr1-1').css("display",'display');
							$('#net_value1').val(object.netBandW);
							$('#net-before_1').text(object.netBandW+"M");
							var len1=object.netBandW*2.73;
							$('#btn1').css('left',len1+"px");
							$('#slider1').css('width',len1+"px");
							$('#title1').text(object.netBandW+'M');
						}
						
						$('.net-Num').val(object.netNum);
						
					}else{
						$(" .resource").css("display",'none');
					}
					$('.net-Num').val(object.netNum);
					$('.operate-sys li a').removeClass("blue-b");
					$('.linux1 li').removeClass('blueLi')
		    		$('.window1 li').removeClass('blueLi')
		    		$('.ubuntu1 li').removeClass('blueLi') 
		    		loadOperateSystem(data.belongCloud);
					 
					if(object.SysTem=="Linux版本"){
						
						$('.linux1').css('display','inline-block');
			    		$('.window1').css('display','none');
			    		$('.ubuntu1').css('display','none');
			    		$('.Linux1 a').addClass('blue-b');
			    		$('.linux1').find('li').each(function (){
			    			if($(this).text().trim()==object.SysTemChild)
			    			{
			    				$(this).addClass('blueLi');
			    			}
			    		})
					}else if(object.SysTem=="Window版本"){
						$('.linux1').css('display','none');
			    		$('.window1').css('display','inline-block');
			    		$('.ubuntu1').css('display','none');
			    		$(".Window1 a").addClass('blue-b'); 
			    		$('.window1').find('li').each(function (){
			    			if($(this).text().trim()==object.SysTemChild)
			    			{
			    				$(this).addClass('blueLi');
			    			}
			    		})
					}else if(object.SysTem=="Ubuntu"){
						$('.linux1').css('display','none');
			    		$('.window1').css('display','none');
			    		$('.ubuntu1').css('display','inline-block');
			    		$('.Ubuntu1 a').addClass('blue-b');
			    		$('.ubuntu1').find('li').each(function (){
			    			if($(this).text().trim()==object.SysTemChild)
			    			{
			    				 
			    				$(this).addClass('blueLi');
			    			}
			    		})
					}
					
/////////////////////////////////////////////////////////
					Soft(data.belongCloud,object.SysTem,object);
					 $("#RunSoftTemp").val(object.environmentSoft);
					 $("#SaveSoftTemp").val(object.storageSoft); 			
/////////////////////////////////////////////////////////
			}
		}
	})
}

function loadcpu(belongCloud){
	var cloudid=belongCloud;
	 result='';
	$.ajax({
		async:false,
		type:"POST",
		url:getContextPath()+"/formulate/loadcpu",
		data:{
			belongCloud:cloudid
		},
		
		success: function(data){
			 
				result=data.cpu; 
			
			
		}
		
		
	})
	 
	return result;
	
}

function loadmemory(cpu,cpuNum)
{
	var cloudid=cpu;
	var cpunum=cpuNum;
	result='';
	$.ajax({
		async:false,
		type:"POST",
		url:getContextPath()+"/formulate/loadMemory",
		data:{
			cpu:cloudid,
			cpuNum:cpunum
		},
		success: function(data){
			
			result=data.memory; 
		}
	})
	return result;
}
function changememory(cpuNum)
{
	var cpunum=cpuNum;
	var cloudid=$('#cloud_id').val();
	$.ajax({
		async:false,
		type:"POST",
		url:getContextPath()+"/formulate/loadMemory",
		data:{
			cpu:cloudid,
			cpuNum:cpunum
		},
		success: function(data){
			 
			if(data.memory!=null&&data.memory!=undefined&&data.memory!="")
			{
				 
				var arr=data.memory.split(";");
				 
				var memory="";
				$('.memory_param').empty();
				for(var i=0;i<arr.length;i++)
				{
					
						if(i==0){
							memory+="<li class='hideclass radius_left' id='"+"m"+i+"'><A class='radius_left blue-b' href='#top_one'>"+arr[i]+"</A></li>"
						}else if(i==arr.length-1){
							memory+="<li class='hideclass radius_right' id='"+"m"+i+"'><A class='radius_right' href='#top_one'>"+arr[i]+"</A></li>"
						}else{
							memory+="<li class='hideclass ' id='"+"m"+i+"'><a  href='#top_two'>"+arr[i]+"</a></li>"
						}
						
				}
				$('.memory_param').append(memory);	
				var memerypar=$('#neicun_value').find('.blue-b').text().trim();
				$("#virtualRam").val(memerypar);
					
			}
			/* $('.tab_div_a_neicun ul li a').click(function(){
				$(this).addClass('blue-b').parents('li').siblings('li').children('a').removeClass('blue-b');
				$("#virtualRam").val($(this).text().trim()); 
			}) */
			$('.tab_div_a_neicun ul li a').click(function(){
				$(this).addClass('blue-b').parents('li').siblings('li').children('a').removeClass('blue-b')
				$("#virtualRam").val($(this).text().trim());
				var value=$(this).text();
				var value1=value.split("核");
				var value2=parseInt(value1[0]);
				
				var value3=$('.neicun-change').text();
				var value4=value3.split("核");
				var value5=parseInt(value4[0]);
				
				if(value2>value5){
					$('.neicun-change').css('background','url(../resources/images/up-arrow.jpg) no-repeat right 0px')
				}else if(value2<value5){
					$('.neicun-change').css('background','url(../resources/images/down-arrow.jpg) no-repeat right 8px')
				}
			});
			
	
		}
	})
	

}

function loadVmType(belongCloud)
{
	var cloudId=belongCloud;
	var result;
	$.ajax({
		async:false,
		type:"POST",
		url:getContextPath()+"/formulate/loadVmtype",
		data:{
			belongCloud:cloudId
		},
		success: function(data)
		{
			
			if(data.VmType!=""||data.VmType!=undefined||data.VmType!=null){
				
				var arr=data.VmType.split(";");
			 
				result=arr;
			}else{
				//alert("缓存请求失败!");
				$("#msg").text("虚拟机类型缓存请求失败!");
			}
		}
	});

	return result;
	
}

 


function loadNetSource(belongCloud){
	var cloudId=belongCloud;
	var result;
	$.ajax({
		async:false,
		type:"POST",
		url:getContextPath()+"/formulate/loadNetSource",
		data:{
			belongCloud:cloudId
		},
		success:function(data)
		{
			 
			if(data.NetSource!=""||data.NetSource!=undefined||data.NetSource!=null){
				 result=data.NetSource;
			}else{
				//alert("请求缓存失败！");
				$("#msg").text("请求缓存失败！");
			}
		}
		
	})
	return result;
}


function loadOperateSystem(belongCloud){
	var cloudId=belongCloud;
	$.ajax({
		async:false,
		type:"POST",
		url:getContextPath()+"/formulate/loadOperateSystem",
		data:{
			belongCloud:cloudId
		},
		success:function(data){
			 
			
			if(data.operatesystem!=""||data.operatesystem!=null||data.operatesystem!=undefined){
				var sysarr=data.operatesystem;
				var sys="";
				for(var i=0;i<sysarr.length;i++)
				{
					
					if(sysarr[i].code=="Linux版本"){
						sys+="<li class=\"qieh hideclasms radius_left Linux1\" id=\"c1\"><a class=\"radius_left \" href=\"#top_one\" onclick=\"Soft('',this.innerHTML,'')\">"+sysarr[i].code+"</a></li>"
						loadsyschild(sysarr[i]);
						  
					}else if(sysarr[i].code=="Window版本"){
						sys+="<li class=\"Window1\"><a href=\"#top_one\" onclick=\"Soft('',this.innerHTML,'')\">"+sysarr[i].code+"</a></li>"
						loadsyschild(sysarr[i]);
					}else if(sysarr[i].code=="Ubuntu"){
						sys+=" <li class=\"hideclass radius_right Ubuntu1\" id=\"c2\"><a class=\"radius_right \" href=\"#top_two\"  onclick=\"Soft('',this.innerHTML,'')\">"+sysarr[i].code+"</a></li>";
						loadsyschild(sysarr[i]);
					}
				}
				$('.operate-sys').append(sys);
			}
			
		}
	})
}

function loadsyschild(sysarr)
{
	 
	var sys=sysarr;
	var childarr=sysarr.value.split(";");
	var signclass="";
	if(sysarr.code=="Linux版本"){
		signclass="linux1";
	}else if(sysarr.code=="Window版本"){
		signclass="window1";
	}else if(sysarr.code=="Ubuntu"){
		signclass="ubuntu1";
	}
	var child=""
	for(var i=0;i<childarr.length;i++)
	{
		child+="<li>"+childarr[i]+"</li>";
	}
	$('.'+signclass).append(child);
}



/* 	提交 */

function InFormulateSubmit(){
		var beCloud = $("#cloud_id").val();
		if(beCloud=='1' ){  // 研发云
			
		if ($('#virtualType').text()==''|| $('#cpu_value').val()==''|| $('#virtualRam').val()=='' || $('.caliche').val()=='') {
			$("#msg").text("请选择基本配置");
			return false;
		}
		
		var system = $('#SysTem').val();
		if (system == "Linux版本"){
			$('#SysTemChild').val($(".linux1 li.blueLi").text());
		}
		else if (system == "Window版本"){
			$('#SysTemChild').val($(".window1 li.blueLi").text());
		}
		else {
			$('#SysTemChild').val($(".ubuntu1 li.blueLi").text());
		}
		if ($('#SysTemChild').val()=='') {
			$("#msg").text("请选择操作系统版本");
			return false;
		}
		///////////////////////////////////////////////////////
		if ($('#SaveSoftTemp').val()=='') {
			$("#msg").text("请选择存储软件");
			return false;
		}else{
			$("#msg").text("");
		}
		
		if ($('#RunSoftTemp').val()=='') {
			$("#msg").text("请选择运行软件");
			return false;
		}else{
			$("#msg").text("");
		}  
		
		 $.ajax({
				cache : true,
				type : "POST",
				url : "${_base}/IntegrationFormulate/InFormulateSubmit",
				//dataType : 'json',
				async : true,
				data : {
					"orderDetailId" :$('#orderDetailId').val(),
					"prodId" : $("#prodId").val(),
					"orderWoId" :$('#orderWoId').val(),
					"belongCloud" :beCloud,
					
					//基本配置
					"virtualType" :$('#virtualType').find('.blue-b').text().trim(),//虚拟机类型
					"virtualCpu" :$('#cpu_value').val().trim(),//CPU
					"virtualRam" :$('#virtualRam').val().trim(),//内存
					"virtualHard" :$('.caliche').val().trim(),//数据盘
					//操作系统
					"SysTem" :$('#SysTem').val().trim(),//操作系统
					"SysTemChild" :$('#SysTemChild').val().trim(),//操作系统版本
					"vmNumber" :$('#vmNumber').val().trim(),//虚拟机数量
					
					"storageSoft" : $('#SaveSoftTemp').val(),//存储软件
					"environmentSoft" :$('#RunSoftTemp').val()//运行环境软件
					
				},
				success: function(data){
					if(data!=null && data.responseCode=='000000' ){
						
						$("#fadeshow").show(); 
						$("#success").show();
						/* alert("租用云提交成功！"); */
					}else{
						//alert(data.msg);
						$("#fault_tishi").text(data.msg);
						$("#fadeshow").show(); 
						$("#fault").show();
						/* alert("操作失败！"); */
					}
				},
				error : function(data) {
					// alert("请求失败！"); 
					 $("#msg").text("请求失败！");
					 
				}
				
			}); 
			
		}else if(beCloud=='2' ){ //租用云
			
			if ($('#virtualType').text()==''|| $('#cpu_value').val()==''|| $('#virtualRam').val()=='' || $('.caliche').val()=='') {
				$("#msg").text("请选择基本配置");
				return false;
			}
			if ($('#netType').val()==''|| $('.net-value').val()==''|| $('#netNum1').val()=='') {
				$("#msg").text("请选择网络资源");
				return false;
			}
			if($('#vmNumber').val()<$('#netNum1').val()){
				$("#msg").text("虚拟机数量需大于等于公网数量");
				return false;
			}else{
				$("#msg").text("");
			}
			var system = $('#SysTem').val();
			if (system == "Linux版本"){
				$('#SysTemChild').val($(".linux1 li.blueLi").text());
			}
			else if (system == "Window版本"){
				$('#SysTemChild').val($(".window1 li.blueLi").text());
			}
			else {
				$('#SysTemChild').val($(".ubuntu1 li.blueLi").text());
			}
			if ($('#SysTemChild').val()=='') {
				$("#msg").text("请选择操作系统版本");
				return false;
			}
			//////////////////////////////////////////////////////////
			if ($('#SaveSoftTemp').val()=='') {
				$("#msg").text("请选择存储软件");
				return false;
			}else{
				$("#msg").text("");
			}
			
			if ($('#RunSoftTemp').val()=='') {
				$("#msg").text("请选择运行软件");
				return false;
			}else{
				$("#msg").text("");
			}  
			
			 $.ajax({
					cache : true,
					type : "POST",
					url : "${_base}/IntegrationFormulate/InFormulateSubmit",
					//dataType : 'json',
					async : true,
					data : {
						"orderDetailId" :$('#orderDetailId').val(),
						"prodId" : $("#prodId").val(),
						"orderWoId" :$('#orderWoId').val(),
						"belongCloud" :beCloud,
						
						//基本配置
						"virtualType" :$('#virtualType').find('.blue-b').text().trim(),//虚拟机类型
						"virtualCpu" :$('#cpu_value').val().trim(),//CPU
						"virtualRam" :$('#virtualRam').val().trim(),//内存
						"virtualHard" :$('.caliche').val().trim(),//数据盘
						//操作系统
						"SysTem" :$('#SysTem').val().trim(),//操作系统
						"SysTemChild" :$('#SysTemChild').val().trim(),//操作系统版本
						//网络资源
						"netType" :$('#netType').val().trim(),//链路类型
						"netBandW" :$('.net-value').val().trim(),//公司宽带
						"netNum" :$('#netNum1').val().trim(),//公网数量
						"vmNumber" :$('#vmNumber').val().trim(),//虚拟机数量
						
						"storageSoft" : $('#SaveSoftTemp').val(),//存储软件
						"environmentSoft" :$('#RunSoftTemp').val()//运行环境软件
						
					},
					success: function(data){
						if(data!=null && data.responseCode=='000000' ){ 
							$("#fadeshow").show(); 
							$("#success").show();
							/* alert("研发云提交成功！"); */
						}else{
							$("#fault_tishi").text(data.msg);
							$("#fadeshow").show(); 
							$("#fault").show();
							/* alert("操作失败！"); */
						}
					},
					error : function(data) {
						// alert("请求失败！"); 
						 $("#msg").text("请求失败！");
					}
					
				}); 
		
		}
		
	}
	
function softCheck001(){
   var allCheckBoxs=document.getElementsByName("storageSoft001") ;  
	
   document.getElementById("SaveSoftTemp").value="";
   for (var i=0;i<allCheckBoxs.length ;i++)
   { 
       if(allCheckBoxs[i].checked==true){     
	       var temp = document.getElementById("SaveSoftTemp").value;
	       var idd = allCheckBoxs[i].id;
	       if(temp==""){
	        document.getElementById("SaveSoftTemp").value =  $("#"+idd).siblings().text() ; 
	       }else{
	    	   document.getElementById("SaveSoftTemp").value = temp +" , "+ $("#"+idd).siblings().text() ; 
	       }
	   }
   }     

}

function softCheck002(){
   var allCheckBoxs=document.getElementsByName("storageSoft002") ;
	
   document.getElementById("RunSoftTemp").value="";
   for (var i=0;i<allCheckBoxs.length ;i++)
   { 
       if(allCheckBoxs[i].checked==true){     
	       var temp = document.getElementById("RunSoftTemp").value;
	       var idd = allCheckBoxs[i].id;
	       if(temp==""){
	        document.getElementById("RunSoftTemp").value =  $("#"+idd).siblings().text() ; 
	       }else{
	    	   document.getElementById("RunSoftTemp").value = temp +" , "+ $("#"+idd).siblings().text() ; 
	       }
	   }
   }     

}
</script>
</html>