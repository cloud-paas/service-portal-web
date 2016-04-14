<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html lang="zh-cn">
  <head>    
    <%@ include file="/jsp/common/common.jsp"%>
    
    <link href="${_base }/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${_base }/resources/css/virtual.css" rel="stylesheet">
    <script type="text/javascript" src="${_base }/resources/bower_components/jquery/dist/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="${_base }/resources/js/virtual/time2js/laydate1.js"></script>
    <script type="text/javascript" src="${_base }/resources/js/virtual/virtualMachine.js"></script>
    
<style type="text/css">
	.date{background: url(${_base }/resources/images/date.png) no-repeat right center;}
	.closeBtn{position:absolute;right:8px;top:6px;cursor:pointer;background:url(../resources/images/x1.png) no-repeat;width:16px;height:16px;}
	.inform-success,.inform-fault{width: 460px;height: 205px;background: #fff;box-shadow: 0 0 5px 1px #ccc;position: relative;}
	.ok{position: absolute;left: 50%;top: 37px;margin-left:-15px;}
	.inform-success h4,.inform-fault h4{color: #333;position: absolute;left: 191px;top:70px;}
	.sure{color: #fff;background:#169ADB;border: 1px solid #056A9E;left: 177px;width: 110px;height: 35px;text-align:center;line-height: 35px;font-weight: bold;font-size: 16px;position: absolute;top: 137px;}
	.div_overlay{display:none;position: fixed;width: 100%;height:100%;z-index:1010;-moz-opacity: 0.0; opacity:.00;filter: alpha(opacity=0);background-color: black;}
	.info-line1 .other-system1,.info-line1 .other-system2{width:350px;}
	.alertBox{height: 400px;width: 644px;margin-left:-322px;margin-top:-173px;box-shadow: #999 0px 0px 22px;display: none;z-index: 13;position: absolute;left: 50%;top: 50%;background: #fff;}
</style>
<script type="text/javascript">
$(document).ready(function(){
// 	$("#${list_index}").attr('style', 'margin-top:2px;color:#1699dc');
	$("#list_11").attr('style', 'margin-top:2px;color:#1699dc');
	$("#navi_tab_product").addClass("chap");
	//openOCSController = new $.OpenOCSController();
	//$("#my_size").find("option[value='${userCacheResultVo.cache_memory}']").attr("selected",true);
});
</script>
<script>
   	$(document).ready(function(){
   		$('a[id^=active_]').each(function(){
   			$(this).css('color', '#949494');
   		});
   		$('#active_prod').css('color', '#1699dc');
   		
}); 
</script>
   
<script type="text/javascript">
function emp(){
	if($('#zy_msage1').text()!=""){
		$('#zy_msage1').html("");
	}
	
	if($('#yf_msage1').text()!=""){
		$('#yf_msage1').text("");
	}
}

//手机号验证
function limitNumber(value){
		var phone = value;
		var reg = /^0?(13|15|17|18|14)[0-9]{9}$/;
		if(phone.length != 11 || reg.test(phone) == false){			
			$("#userPhone1").val("");
			$("#userPhone4").val("");
		}else{
			$("#userPhone1").css('border','0px solid #ccc')
			$("#userPhone4").css('border','1px solid #ccc')
		}
}
//
//只能为数字
function Number(str){
	var t=$("#"+str).val();
	if(isNaN(t)){
	$("#"+str).css('border','1px solid #F00');
	}else{
	$("#"+str).css('border','1px solid #ccc')
	}

}


//租用云
function virtualSubmitZY(){	
	
	 if ($('#projectName1').text()=='' || $('#applyUser1').text()=='') {
		$('#zy_msage1').text("页面员工信息加载失败！");
		
		return false;
	}
	if ( $("#userPhone1").val()=='') {
		$('#zy_msage1').text("请填写电话号码");
		$('#userPhone1').css('border','1px solid red')
		return false;
	}	
	
	if ( $('#applyReason1').val()=='') {
		$('#zy_msage1').text("请填写申请原因");
		$('#applyReason1').css('border','1px solid red')
		return false;
	}
	
	if ($('#projectNum1').val()=='') {
		$('#zy_msage1').text("请填用户数");
		$('#projectNum1').css('border','1px solid red')
		return false;
	}
	if ($('#projectCount1').val()=='') {
		$('#zy_msage1').text("请填写访问量");
		$('#projectCount1').css('border','1px solid red')
		return false;
	}
	var b = document.getElementsByName("function");
	if(b[0].checked==false && b[1].checked==false && b[2].checked==false &&b[3].checked==false){
		$('#zy_msage1').text("请填写用途说明");
		return false;
	}
   if ( $('#projectNot1').val()=='') {
		$('#zy_msage1').text("请填写业务描述");
		$('#projectNot1').css('border','1px solid red')
		return false;
	}
   
	  if ( $('#projectEndTime1').val()=='') {
		$('#zy_msage1').text("请填写结束时间");
		$('#projectEndTime1').css('border','1px solid red')
		return false;
	}
	  
	 if($('.time1').html()>$('.time1-1').val()){
			$('#zy_msage1').text("截止日期需大于当前日期");
			return false;
		}
	 
	if ( $('#projectEndTime1').val()=='' || $('#virtualType1').text()=='' || $('#virtualCpu1').text()=='' || $('#virtualRam1').text()=='') {
		$('#zy_msage1').text("请选择基本配置");
		return false;
	}
	if($('.v-num1').val()==''){
		$('#zy_msage1').text("请选择基本虚拟机数量");
		$('.v-num1').css('border','1px solid red')
		return false;
	}
	if ($('#virtualHard1').text()=='') {
		$('#zy_msage1').text("请选择数据盘");
		return false;
	}
	if ($('#netType1').text()=="" ) {
		$('#zy_msage1').text("请填写网络资源信息");
		return false;
	}
	if ($('#netWbn1').text()=="" ) {
		$('#zy_msage1').text("请填写公网宽带");
		return false;
	}
	
	
	if ($('#netNumber').val()=="" ) {
		$('#zy_msage1').text("请填写公网数量");
		$('#netNumber').css('border','1px solid red')
		return false;
	}
	if($('#netNumber').val()>$('#zy_v-num-count').val()){
		$('#zy_msage1').text("公网数量需小于虚拟机申请数量");
		return false;
	}

	if (  $('#SysTem11').text()=='' || $('#SysTemChild1').text()=='' ) {
		$('#zy_msage1').text("请选择操作系统");
		return false;
	}
	if ($('#storageSoft1').text()=='' || $('#environmentSoft1').text()=='') {
		$('#zy_msage1').text("请选择安装软件");
		return false;
	}
	
	var isProject;
	if($("#isProject1").prop('checked')){
		isProject='Y';
	}else{
		isProject='N';
	}
	
	$('.waitCover').show();
		 $.ajax({
			 cache : true,
			type : "POST",
			url : "${_base}/virtualMachine/vmSubmit",
			data : {
				"curType":$('.nav-right li.cur-li').text(),//云类别
				"applyUser":$('#applyUser1').text(),//申请人<span
				"applyDepartment":$('#applyDepartment1').text(),//申请部门
				"applyuserPhone":$('#userPhone1').val(),//联系电话
				"applyuserEmail":$('#userEmail1').text(),//邮箱地址
				"applyReason": $('#applyReason1').val(),//申请原因<textarea
				"projectName": $('#projectName1').text(),//成本中心/名称
				"costcenter_id": $('#costcenter_id1').text(),//成本中心ID
				"userMaxNumbers": $('#projectNum1').val(),//用户数
				"concurrentNumbers": $('#projectCount1').val(),//并发访问量
				"projectExplain": $('input[name = "function"]:checked').val(),//用途说明
				"projectNot": $('#projectNot1').val(),//业务描述<textarea
				"currentTime": $('#Clock').text(),//当前时间
				"projectEndTime": $('#projectEndTime1').val(),//到期时间
				//基本配置
				"virtualType" :$('#virtualType1').text().trim(),//虚拟机类型
				"vmNumber" : $('#zy_v-num-countT').text().trim(),//虚拟机数量
				"virtualCpu" : $('#virtualCpu1').text().trim(),//CPU
				"virtualRam" : $('#virtualRam1').text().trim(),//内存
				"virtualHard" :$('#virtualHard1').text().trim(),//数据盘
				//网络资源
				"netType" :$('#netType1').text(),//链路类型
				"netBandW" :$('#netWbn1').text(),//公司宽带
				"netNum" :$('#netNum1').text(),//公网数量
				//操作系统
				"SysTem" : $('#SysTem11').text().trim(),//操作系统
				"SysTemChild" :$('#SysTemChild1').text().trim(),//操作系统版本
				"SysOtherTem" :$('#SysOtherTem1').text(),//其他操作系统
				//安装软件
				"storageSoft" : $('#storageSoft1').text().trim(),//存储软件
				"environmentSoft" :$('#environmentSoft1').text(),//运行环境软件
				"otherExplain" :$('#otherExplain1').val(),//其他补充说明
				"isProject":isProject //是否是项目成本中心
			},
			success: function(data){
				if(data!=null && data.responseCode=='000000' ){ //
			    location.href="${_base}/mcs/applyCompleted?prod=IAAS_VIRTAL"; 
			   $('.waitCover').hide();
				}else{					
					
					$('#zy_msage1').text(data.responseMsg);
					$('.waitCover').hide();
				}
			},
			error : function(data) {
				$('#zy_msage1').text("请求失败！");
				$('.waitCover').hide();
			}
			
		}); 
}
	
//研发云
function virtualSubmitYF(){
	if ($('#applyUser4').text()=='' || $('#applyDepartment4').text()=='' || $('#projectName4').text()=='') {
		$('#yf_msage1').text("页面员工信息加载失败！");
		return false;
	}
	if ( $("#userPhone4").val()=='') {
		$("#yf_msage1").text("请填写电话号码");
		$('#userPhone4').css('border','1px solid red')
		return false;
	}
	if ( $('#applyReason4').val()=='') {
		$('#yf_msage1').text("请填写申请原因");
		$('#applyReason4').css('border','1px solid red')
		return false;
	}else{
		$('#applyReason4').css('border','1px solid #ccc')
	}
	if ( $('#projectNum4').val()=='') {
		$('#yf_msage1').text("请填写用户数");
		$('#projectNum4').css('border','1px solid red')
		return false;
	}else{
		$('#projectNum4').css('border','1px solid #ccc')
	}
	if ($('#projectCount4').val()=='') {
		$('#yf_msage1').text("请填写并发访问量");
		$('#projectCount4').css('border','1px solid red')
		return false;
	}else{
		$('#projectCount4').css('border','1px solid #ccc')
	}
	
	
	var b = document.getElementsByName("function2");
	if(b[0].checked==false && b[1].checked==false && b[2].checked==false && b[3].checked==false){
		$('#yf_msage1').text("请选择用途说明");
		return false;
	}
	if ($('#projectNot4').val()=='') {
		$('#yf_msage1').text("请填写业务描述");
		$('#projectNot4').css('border','1px solid red')
		return false;
	}else{
		$('#projectNot4').css('border','1px solid #ccc')
	}
	if ( $('#projectEndTime4').val()=='') {
		$('#yf_msage1').text("请选择到期时间");
		$('#projectEndTime4').css('border','1px solid red')
		return false;
	}else{
		$('#projectEndTime4').css('border','1px solid #ccc')
	}
	if($('.time2').html()>$('.time2-1').val()){
		$('#yf_msage1').text("截止日期需大于当前日期");
		return false;
	}
	if($('.v-num2').val()=='' || $('.v-num2').val()==null){
		$('#yf_msage1').text("请选择虚拟机数量");
		$('.v-num2').css('border','1px solid red')
		return false;
	}else{
		$('.v-num2').css('border','1px solid #ccc')
	}
	if ($('#virtualType4').text()==''|| $('#virtualCpu4').text()==''|| $('#virtualRam4').text()=='' || $('#virtualHard4').text()=='') {
		$('#yf_msage1').text("请选择基本配置");
		return false;
	}
	
	if ($('#SysTem4').text()=='' || $('#SysTemChild4').text()=='') {
		$('#yf_msage1').text("请选择操作系统");
		return false;
	}
	if ( $('#storageSoft4').text()=='' || $('#environmentSoft4').text()=='') {
		$('#yf_msage1').text("请选择安装软件");
		return false;
	}
	
	var isProject;
	if($("#isProject2").prop('checked')){
		isProject='Y';
	}else{
		isProject='N';
	}
	$('.waitCover').show();
		$.ajax({
			cache : true,
			type : "POST",
			url : "${_base}/virtualMachine/vmSubmit",
			data : {
				"curType" :$('.nav-right li.cur-li').text(),//云类别
				"applyUser":	$('#applyUser4').text(),//申请人<span
				"applyDepartment": $('#applyDepartment4').text(),//申请部门
				"applyuserPhone": $('#userPhone4').val(),//联系电话
				"applyuserEmail": $('#userEmail4').text(),//邮箱地址
				"applyReason": $('#applyReason4').val(),//申请原因<textarea
				
				"projectName": $('#projectName4').text(),//成本中心/名称
				"costcenter_id": $('#costcenter_id4').text(),//成本中心ID
				"userMaxNumbers": $('#projectNum4').val(),//用户数
				"concurrentNumbers": $('#projectCount4').val(),//并发访问量
				"projectExplain": $('input[name = "function2"]:checked').val(),//用途说明
				"projectNot": $('#projectNot4').val(),//业务描述<textarea
				"currentTime": $('#Clock4').text(),//当前时间.Clock4
				"projectEndTime": $('#projectEndTime4').val(),//到期时间
				
				//基本配置
				"virtualType" :$('#virtualType4').text().trim(),//虚拟机类型
				"vmNumber" :$('#yf_v-num-countT').text().trim(),//虚拟机数量
				"virtualCpu" :  $('#virtualCpu4').text().trim(), //CPU 
				"virtualRam" :  $('#virtualRam4').text().trim(), //内存 
				"virtualHard" :$('#virtualHard4').text().trim(),//数据盘

				//操作系统
				"SysTem" :$('#SysTem4').text().trim(),//操作系统
				"SysTemChild" :$('#SysTemChild4').text().trim(),//操作系统版本
				"SysOtherTem" :$('#SysOtherTem4').text(),//其他操作系统
				//安装软件
				"storageSoft" :$('#storageSoft4').text(),//存储软件
				"environmentSoft" :$('#environmentSoft4').text(),//运行环境软件
				"otherExplain":$('#otherExplain2').val(),//其他补充说明
				"isProject":isProject    //是否项目成本中心
			},
			success: function(data){
				if(data!=null && data.responseCode=='000000'){
					$('.waitCover').hide();
					//location.href=getContextPath() +"/mcs/applyCompleted?prod="+encodeURI(encodeURI('云虚拟机'))+"&url=/virtualMachine/goVirtualMachineApply&prodType=2";
					location.href="${_base}/mcs/applyCompleted?prod=IAAS_VIRTAL"; //&url=virtualMachine/goVirtualMachineApply
				}else{
					
					$('#yf_msage1').text(data.responseMsg);
					$('.waitCover').hide();
					

				}
			},
			error : function(data) {
				$('#yf_msage1').text("请求失败！");
				$('.waitCover').hide();
				}
			
		});
 } 

	function getSure_zuyong(){
		$("#fadeshow").hide();
		$("#success_zuyong").hide();
	}
	function getSure_yanfa(){
		$("#fadeshow").hide(); 
		$("#success_yanfa").hide();
	}
	function getFault(){
		$("#fadeshow").hide(); 
		$("#fault").hide();
	}
	//租用手机
	function checkMobile(value){
		if(value!=''){
			$('#userPhone1').css('border','1px solid #ccc')
		}
	}
	//租用申请原因
	function checkReason1(){
		if($('#applyReason1').val()!=''){
			$('#applyReason1').css('border','1px solid #ccc')
		}
	}
	//租用用户数
	function checkUsernum1(value){
		if(value!=null){
			$('#projectNum1').css('border','1px solid #ccc')
		}
	}
	//租用并发访问量
	function checkVisitum1(value){
		if(value!=null){
			$('#projectCount1').css('border','1px solid #ccc')
		}
	}
	//租用业务描述
	function checkBusiness1(){
		if($('#projectNot1').val()!=''){
			$('#projectNot1').css('border','1px solid #ccc')
		}
	}
	//租用到期时间
	function timeCheck1(value){
		if(value!=null || value!=''){
			$('#projectEndTime1').css('border','1px solid #ccc')
		}
	}
	//租用虚拟机数量
	function checkNum1(value){
		if($('.v-num1').val()!=''){
			$('.v-num1').css('border','1px solid #ccc');
			$("#zy_v-num-countT").text(value);
		}
		
		
	}

	//租用公网数量
	function checkNetnumber(value){
		if(value!=''){
			$('#netNumber').css('border','1px solid #ccc');
			$('#netNum1').text(value);
			
		}
	}
	
	//研发手机
	function checkMobile2(value){
		if(value!=''){
			$('#userPhone4').css('border','1px solid #ccc')
		}
	}
	//研发申请原因
	function checkReason2(){
		if($('#applyReason4').val()!=''){
			$('#applyReason4').css('border','1px solid #ccc')
		}
	}
	//研发用户数
	function checkUserum2(value){
		if(value!=null){
			$('#projectNum4').css('border','1px solid #ccc')
		}
	}
	//研发并发访问量
	function checkVisitum2(value){
		if(value!=null){
			$('#projectCount4').css('border','1px solid #ccc')
		}
	}
	//研发业务描述
	function checkBusiness2(){
		if($('#projectNot4').val()!=''){
			$('#projectNot4').css('border','1px solid #ccc')
		}
	}
	//研发到期时间
	function timeCheck2(value){
		if(value!=null || value!=''){
			$('#projectEndTime4').css('border','1px solid #ccc')
		}
	}
	//研发虚拟机数量
	function checkNum2(value){
		if($('.v-num2').val()!=''){
			$('.v-num2').css('border','1px solid #ccc');
			$("#yf_v-num-countT").text(value);
		}	
	}
	//租用其他说明聚焦
	function focus1(){
		if($('#otherExplain1').text()=='其他需求可再次补充'){
			$('#otherExplain1').text('')
		}
	}
	function blur1(){
		if($('#otherExplain1').text()==''){
			$('#otherExplain1').text('其他需求可再次补充')
		}
	}
	//研发其他说明聚焦
	function focus2(){
		if($('#otherExplain2').text()=='其他需求可再次补充'){
			$('#otherExplain2').text('')
		}
	}
	function blur2(){
		if($('#otherExplain2').text()==''){
			$('#otherExplain2').text('其他需求可再次补充')
		}
	}
	
	function isProject1(){		
		var isProject1;
		$("#isProject2").attr("checked", false);
		if($("#isProject1").prop('checked')){
			$('#alertBox1').css('display','block');
		}else{
			$.ajax({
				cache : true,
				type : "POST",
				url : getContextPath() +"/virtualMachine/vmUserLoading",
				data : "User=0",
				dataType : 'json',
				async : true,
				error : function(data) {
					alert("员工信息加载失败！");
				},
				success: function(data){
					var zy= "";
					var yf= "";
					if(data!=null){
						
						obj=eval(data);
					$('#applyUser1').text(data.last_name);////申请人
					$('#applyDepartment1').text(data.org_name);//申请部门
					$('#userPhone1').val(data.mobile);//联系电话
					$('#userEmail1').text(data.email_address);//邮箱地址
					$('#projectName1').text(data.costcenter_name);//成本中心/名称
					$('#costcenter_id1').text(data.costcenter_id);//成本中心ID
					$("#netWbn1").text($('.company').val());
					$("#virtualHard1").text($('.caliche ').val())
					
					$('#applyUser4').text(data.last_name);////申请人
					$('#applyDepartment4').text(data.org_name);//申请部门
					$('#userPhone4').val(data.mobile);//联系电话
					$('#userEmail4').text(data.email_address);//邮箱地址
					$('#projectName4').text(data.costcenter_name);//成本中心/名称
					$('#costcenter_id4').text(data.costcenter_id);//成本中心ID
					$("#virtualHard4").text($('.caliche1 ').val());
					}
				}				
			
			});
		}
	}
	//关闭按钮
	function closeBox1(){
		$("#isProject1").attr("checked", false);
		$('#alertBox1').css('display','none');
	}
	
	//成本按钮
	function isProject2(){		
		var isProject2;
		$("#isProject1").attr("checked", false);
		if($("#isProject2").prop('checked')){
			$('#alertBox2').css('display','block');
		}else{
			$.ajax({
				cache : true,
				type : "POST",
				url : getContextPath() +"/virtualMachine/vmUserLoading",
				data : "User=0",
				dataType : 'json',
				async : true,
				error : function(data) {
					alert("员工信息加载失败！");
				},
				success: function(data){
					var zy= "";
					var yf= "";
					if(data!=null){
						
						obj=eval(data);
					$('#applyUser1').text(data.last_name);////申请人
					$('#applyDepartment1').text(data.org_name);//申请部门
					$('#userPhone1').val(data.mobile);//联系电话
					$('#userEmail1').text(data.email_address);//邮箱地址
					$('#projectName1').text(data.costcenter_name);//成本中心/名称
					$('#costcenter_id1').text(data.costcenter_id);//成本中心ID
					$("#netWbn1").text($('.company').val());
					$("#virtualHard1").text($('.caliche ').val())
					
					$('#applyUser4').text(data.last_name);////申请人
					$('#applyDepartment4').text(data.org_name);//申请部门
					$('#userPhone4').val(data.mobile);//联系电话
					$('#userEmail4').text(data.email_address);//邮箱地址
					$('#projectName4').text(data.costcenter_name);//成本中心/名称
					$('#costcenter_id4').text(data.costcenter_id);//成本中心ID
					$("#virtualHard4").text($('.caliche1 ').val());
					}
				}				
			
			});
		}
	}
	
	//关闭按钮
	function closeBox2(){
		$("#isProject2").attr("checked", false);
		$('#alertBox2').css('display','none');
	}
</script>

 </head> 
  <body>  
     <!-- 遮盖层   -->
	  <div class="waitCover" >
		 <img  src="${_base }/resources/images/waitPng.png" class="waitPng" >
		 <div class="waitTxt">正在加载请稍后...</div>
	  </div>
  	<div class="alertBox" id="alertBox1">
  		<span class="closeBtn" onclick="closeBox1()"></span>
  		<iframe name="right" id="rightMain1" src="${_base}/oa/erpProjectsInit" frameborder="no" scrolling="no" width="644px" height="415px" allowtransparency="true"></iframe>
  	</div>
  	
  	<div class="alertBox" id = "alertBox2">
  		<span class="closeBtn" onclick="closeBox2()"></span>
  		<iframe name="right" id="rightMain2" src="${_base}/oa/erpProjectsInit" frameborder="no" scrolling="no" width="644px" height="415px" allowtransparency="true"></iframe>
  	</div>
  	
  	
  	<div id="fadeshow" class="div_overlay"></div> 
	<div id="success_zuyong" class="inform-success" style="display: none;left:450px; top:200px;position:fixed; z-index:1011;_position:absolute;">
    	<img src="${_base }/resources/images/yes.jpg" class="ok" >
    	<h4 style="left:135px;padding:10px;">租用云提交成功！</h4>
		<button id="confirm_success" class="sure" onclick="getSure_zuyong();">确定</button>
    </div>
    <div id="success_yanfa" class="inform-success" style="display: none;left:450px; top:200px;position:fixed; z-index:1011;_position:absolute;">
    	<img src="${_base }/resources/images/yes.jpg" class="ok" >
    	<h4 style="left:135px;padding:10px;">研发云提交成功！</h4>
		<button id="confirm_success" class="sure" onclick="getSure_yanfa();">确定</button>
    </div>
    <div id="fault" class="inform-fault"  style="display: none;left:450px; top:200px;position:fixed; z-index:1011;_position:absolute;">
    	<img src="${_base }/resources/images/no.jpg" class="ok">
    	<h4 id="request_message" style="text-align:center; padding:10px; margin-top:79PX;font-size:18px; color:#06F;">操作失败！</h4>
		<button id="confirm_fault"  class="sure" onclick="getFault();">确定</button>
    </div>
    
    <div class="big_k"><!--包含头部 主体-->  
   <!--导航-->
   <div class="navigation">
 		<%@ include file="/jsp/common/header.jsp"%>
   </div>
   
   
        <div class="container chanp">  
            <div class="row chnap_row">
 	 			<%@ include file="/jsp/common/leftMenu_new.jsp"%>	
            
	            <div class="col-md-6 right_list ">
		 			<div class="Open_cache">
	        			<div class="nav-right">
	        				<ul>
	        				    <li class="cur-li">研发云</li>
	        				    <li >华为租用云</li>
	        					
	        					
	        					<!-- <li class="cur-li">华为租用云</li>
	        					<li>研发云</li> -->
	        				</ul>
	        			</div> 
	        			<div class="Open_cache_list" >
	        				<div class="rent" value="1" onchange="emp()">
	        					<div class="basic-info">
	        						<div class="left-tittle">基本信息</div>		
	        						<div class="basic-content">
	        							<div class="info-line1">
		        							<label class="label" onclick="timeCheck()">申请人:</label>
		        							<span class="label-content label-mar" id="applyUser1"></span>
		        							<label>申请部门:</label>
		        							<span class="label-content" id="applyDepartment1"></span>
		        						</div>
		        						<div class="info-line1">
		        							<label class="label">联系电话:</label>
		        							<input type="text" onblur="checkMobile(this.value)"  style="margin-right:130px" maxlength="11" class="txt" id="userPhone1" onblur="limitNumber(this.value)">
		        							<label>邮箱地址:</label>
		        							<span class="label-content" Id="userEmail1"></span>
		        						</div>
		        						<div class="info-line1">
		        							<label class="label reason">申请原因:</label>
		        							<textarea style="width:617px;height:72px;resize:none;border:1px solid #CCCCCC;border-radius: 2px;margin-left:145px;" id="applyReason1" onblur="checkReason1()"></textarea>
		        						</div>
	        						</div>	        						
	        					</div>
	        					<div class="project">
	        						<div class="project-tittle">项目信息</div>
	        						<div class="project-content">
	        							<div class="info-line1">
		        							<label class="label">成本中心:</label>
		        							<span id="projectName1"></span>	(<span id="costcenter_id1"></span>)	
		        							<label class="label" style="margin-left:10px;"><input id="isProject1" type="checkbox" name="isProject2" onclick="isProject1()" style=" margin-right:10px;margin-bottom: -3px;width:15px;height:15px" >项目成本</label>
		        						</div>
		        						<div class="info-line1" style="margin-bottom:15px;">
		        							<label class="label">用户数:</label>
		        							<input type="text"  style="margin-right:114px" id="projectNum1" onkeyup="value=value.replace(/[^0-9_]/g,'')" onblur="checkUsernum1(this.value)">
		        							<label>并发访问量:</label>
		        							<input type="text" id="projectCount1"  onkeyup="value=value.replace(/[^0-9_]/g,'')" onblur="checkVisitum1(this.value)">
		        						</div>
		        						<div class="info-line1" style="margin-bottom:45px;margin-top:-5px;">
		        							<label class="label reason">用途说明:</label>
		        							<div id="ZY_ProjectExp_id"  style="margin-left:185px;margin-top:-2px;position:relative;" class="radio" onchange="emp()"> 
		        							</div>		        				
		        						</div>
		        						<div class="info-line1" style="margin-top:-11px;">
		        							<label class="label reason">业务描述:</label>
		        							<textarea style="width:617px;height:72px;resize:none;border:1px solid #CCCCCC;border-radius: 2px;margin-left:145px;" id="projectNot1" onblur="checkBusiness1()"></textarea>
		        						</div>
		        						<div class="info-line1" >
		        							<label class="label">当前时间:</label>
		        							<span class="label-content label-mar time1" id="Clock">2015-09-02</span>
		        							<label>到期时间:</label>
		        							<input type="text"  class="inline date time1-1" id="projectEndTime1"   onblur="timeCheck1(this.value)">
		        						</div>
		        						
	        						</div>	        						
	        					</div>
	        					<div class="iaas_table">
	        						<div class="basic-table-tittle">基本配置</div>
	        						<ul class="basic-table-content">
	        							<li>
	        								<div class="iaas_table_title td1" >虚拟机类型：</div>
											<div class="td2">
													<!--TAB切换-->
												<div class="tab_div_sys">
													<div class="tab_div_a_sys">
													   <ul id="tab_div_ul_zy_VirtualType">   
														  <!--  <li class="qieh hideclass radius_left" id="c1"><a class="radius_left" href="#top_one">WEB服务器</a></li>
														   <li><a href="#top_one">应用服务器</a></li>
														   <li class="hideclass radius_right" id="c2"><a class="radius_right gray-border" href="#top_two" >数据库</a></li>   -->
													   </ul> 
													 </div> 
												</div>  
											</div>
	        							</li>
	        							<li>
	        								<div class="iaas_table_title td1-1" >虚拟机数量：</div>
											<div  class="td2-2">
												<input id="zy_v-num-count" type="text" class="v-num1" onblur="checkNum1(this.value)" onkeyup="value=value.replace(/[^0-9_]/g,'')" style="width:190px;height:30px;border:1px solid #ccc;border-radius:3px;position:absolute;left:0px;">
											</div>
	        							</li>
	        							<li>
	        								<div class="iaas_table_title td3">cpu：</div>
											<div  class="td4">
												<!--TAB切换-->
												 <div class="tab_div_cpu">
												  <div class="tab_div_a_cpu  cpu1" id="CPU1">
													  <ul id="tab_div_ul_cpu1">
                                                            </ul> 
												  </div> 
												</div>  
											</div>
	        							</li>
	        							<li>
	        								<div class="iaas_table_title td5">内存：</div>
											<div class="td4-1">
												<!--TAB切换-->
												 <div class="tab_div_neicun">
												  <div class="tab_div_a_neicun neicun1">
													<ul id="ul_neicun1">
	                                                  <!--  <li class="qieh hideclass radius_left" id="c1"><A class="radius_left" href="#top_one">4G</A></li>
	                                                   <li class="hideclass" id="c1"><A class="" href="#top_one">8G</A></li>
	                                                   <li class="hideclass radius_right" id="c2"><a class="radius_right gray-border" href="#top_two">16G</a></li> 
	                                                     -->
													</ul> 
												  </div> 
												</div>  
											</div>
	        							</li>
	        							<li>
	        								<div  class="iaas_table_title td6" >数据盘：</div>
												<div  class="td4-3">
		
													 <div class="tab_div_a_yp">
														  <div class="User_ratings User_grade" id="div_fraction0" onclick="emp()"> 
															<div class="ratings_bars">  
																<div class="scale" id="bar0">
																	<div></div>
																	<span id="btn0">
																		<span id="title0" >10G</span>
																	</span>

																</div>
															<label class="tenG">10G</label>
															<label class="twoG">200G</label>
															 <input type="text" class="caliche input-blur"  onblur="move()" value="10" >
															 <label class="m">G</label>
															</div>
														</div>
													</div>
	        							</li>
	        						</ul>
	        					</div>
				   				
								<div class="net" onclick="emp()">
	        						<div class="net-tittle net-tittle1">网络资源</div>
	        						<div class="net-content">
	        							<div class="info-line1 line-link" >
		        							<label class="label">链路类型:</label>
		        							<div class="link-type">
											    <div class="tab_div_a_sys2">
												   <ul id="zy_NetType">  
													   <!-- <li class="qieh hideclass radius_left liantong" id="c1"><a class="radius_left" href="#top_one">		联通</a></li>
													   <li class="dianxin"><a href="#top_one"> 电信</a></li>
													   <li class="double"><a href="#top_one">联通+电信</a></li>
													   <li class="hideclass radius_right BGP" id="c2"><a class="radius_right gray-border" href="#top_two" >BGP</a></li>   -->
												   </ul> 
											    </div> 
											</div>  			
		        						</div>
		        						
		        						
		        						
		        						
		        						<div class="info-line1 line-marbottom tr1" style="margin-bottom:30px;">
		        							<label class="label">公网宽带:</label>
		        							<div class="company-net">
											    <div class="tab_div_yp">
													<div class="tab_div_a_yp">
														<div class="User_ratings User_grade" id="div_fraction0"> 
															<div class="ratings_bars c-net">  
																<div class="scale" id="bar1">
																	<div></div>
																	<span id="btn1"><span id="title1">1M</span></span>
																</div>
																<label class="tenG">1M</label>
																<label class="twoG">100M</label>
																<input type="text" class="company" class="m" onblur="move1()" value="1">
																<label class="m" >M</label>
															</div>
														</div> 
													</div>
												</div>  			
		        							</div>
		        						</div>
		        						
		        						
		        						
		        						<div class="info-line1 line-marbottom tr2" style="margin-bottom:30px;">
		        							<label class="label">公网宽带:</label>
		        							<div class="company-net">
											    <div class="tab_div_yp">
													<div class="tab_div_a_yp">
														<div class="User_ratings User_grade" id="div_fraction0"> 
															<div class="ratings_bars c-net">  
																<div class="scale" id="bar2" style="margin-right:25px;">
																	<div></div>
																	<span id="btn2"><span id="title2">1M</span></span>
																</div>
																<label class="tenG">1M</label>
																<label class="twoG">20M</label>
																<input type="text" class="company1 input-blur"  onblur="move2()" value="1">
																<label class="m">M</label>
															</div>
														</div> 
													</div>
												</div>  			
		        							</div>
		        						</div>
		        						
		        						
		        						
		        						
		        						
		        						<div class="info-line1">
		        							<label class="label" style="margin-right:31px;">公网数量:</label>
		        							<input type="text" id="netNumber" onblur="checkNetnumber(this.value)" onkeyup="value=value.replace(/[^0-9_]/g,'')">
		        						</div>
	        						</div>	        						
	        					</div>
								<div class="net system" onclick="emp()">
	        						<div class="net-tittle system-tittle">操作系统</div>
	        						<div class="net-content system-content" id="system1">
	        							<div class="info-line1 system-mar1 line-system" style="">
		        							<label class="label">操作系统:</label>
		        							<div class="link-type">
											    <div class="tab_div_a_sys1">
												   <ul id="rent_system_ul"> 
													   <li class="qieh hideclass radius_left Linux1" id="c1"><a class="radius_left" href="#top_one">Linux</a></li>
													   <li class="hideclass radius_right Window1" id="c2"><a class="radius_right gray-border" href="#top_one"> Window</a></li>			
												   </ul> 
											    </div> 
											</div>  			
		        						</div>
		        						<ul class="linux1" id="zy_system_child">
		        						    <li class="blue-w">CentOS Linux 5.5 64bit</li>  
		        							<li>CentOS Linux 5.8 64bit</li>
		        							<li>CentOS Linux 6.0 32bit</li>
		        							<li>CentOS Linux 6.2 64bit</li>
		        							<li>CentOS Linux 6.4 64bit</li>
		        							<li>CentOS Linux 6.5 64bit</li>
		        						</ul>
		        						
		        						<div class="info-line1">
		        							<label class="label" style="margin-right:31px;">其他操作系统:</label>
		        							<input type="text" id="otherSys1" class="other-system1" onchange="otherSystem()" >
		        						</div>
	        						</div>	        						
	        					</div>
	        					<div class="soft" onclick="emp()">
	        						<div class="soft-tittle">安装软件</div>
	        						<div class="soft-content">
	        							<div class="save-soft gray">存储软件:</div>
	        							<div class="save-soft-content" id="zy_save-soft-content">
	        								
	        								
	        							</div>
	        							<div class="run-soft">运行环境软件:</div>
	        							<div class="run-soft-content" id="zy_run-soft-content">
	        								        									        								
	        							</div>
	        						</div>
	        					</div>
	        					<div class="presentDeploy1">
									<div class="deploy-tittle">当前配置</div>
									<div class="present-line"></div>
									<ul class="present-content">
										<li>
											<span class="basicSpan">基本配置</span>
											<span class="contentSpan">
											虚拟机类型:&nbsp;<span id="virtualType1"></span>&nbsp;
											虚拟机数量:&nbsp;<span id="zy_v-num-countT"></span>个&nbsp;
											
											CPU:&nbsp;<span id="virtualCpu1"></span>&nbsp;
											内存:&nbsp;<span id="virtualRam1"></span>&nbsp;
											数据盘:&nbsp;<span id="virtualHard1"></span>G
											
											</span>
										</li>
										<li>
											<span class="basicSpan">网络资源</span>
											<span class="contentSpan">
												链路类型:&nbsp;<span id="netType1"></span>&nbsp;
												公网宽带:&nbsp;<span id="netWbn1"></span>M&nbsp;
												公网数量:&nbsp;<span id="netNum1"></span>个
											</span>
										</li>
										<li>
											<span class="basicSpan">操作系统</span>
											<span class="contentSpan">
											操作系统:&nbsp;<span id="SysTem11"></span>
											         &nbsp;<span id="SysTemChild1"></span>
											<span id='sys' style="display:none">
											&nbsp;其他操作系统:</span>	&nbsp;<span id="SysOtherTem1"></span>	
											</span>
										</li>
										<li>
											<span class="basicSpan">安装软件</span>
											<span class="contentSpan">
											存储软件:&nbsp;<span id="storageSoft1"></span>&nbsp;
											运行环境软件:&nbsp;<span id="environmentSoft1"></span>											
											</span>
										</li>
									</ul>
									<textarea style="height:100px;width:790px;resize:none;margin-left:10px;font-size:14px;" id="otherExplain1" onfocus="focus1()" onblur="blur1()">其他需求可再次补充</textarea>
									<!--  <a href="#" target="_self">-->
									 <input type="button" onclick="virtualSubmitZY()" class="apply-submit" value="申请提交" > 
									 <span id="zy_msage1" style="margin-left:20px; font-size:14px; color:#F00;"></span>
									<!--  </a>-->
								</div>
	        				</div> 
	        				
	        				
	 <!-- **********************研发云***************************** -->     				
	        				<div class="resaerch" onchange="emp()">
	        					<div class="basic-info" onclick="emp()">
	        						<div class="left-tittle">基本信息</div>
	        						<div class="basic-content">
	        							<div class="info-line1">
		        							<label class="label">申请人:</label>
		        							<span class="label-content label-mar" id="applyUser4"></span>
		        							<label>申请部门:</label>
		        							<span class="label-content" id="applyDepartment4"></span>
		        						</div>
		        						<div class="info-line1">
		        							<label class="label">联系电话:</label>
		        							<input type="text"  style="margin-right:130px" maxlength="11" class="txt" id="userPhone4" onblur="checkMobile2(this.value)" onchange="limitNumber(this.value)">
		        							<label>邮箱地址:</label>
		        							<span class="label-content" Id="userEmail4"></span>
		        						</div>
		        						<div class="info-line1">
		        							<label class="label reason">申请原因:</label>
		        							<textarea style="width:617px;height:72px;resize:none;border:1px solid #CCCCCC;border-radius: 2px;margin-left:145px;" id="applyReason4" onblur="checkReason2()"></textarea>
		        						</div>
	        						</div>	        						
	        					</div>
	        					<div class="project" onclick="emp()">
	        						<div class="project-tittle">项目信息</div>
	        						<div class="project-content">
	        							<div class="info-line1">
		        							<label class="label">成本中心:</label>
		        							<span id="projectName4"></span>	(<span id="costcenter_id4"></span>)			        							
		        							<label class="label" style="margin-left:10px;"><input id="isProject2" type="checkbox" name="isProject2" onclick="isProject2()" style=" margin-right:10px;margin-bottom: -3px;width:15px;height:15px" >项目成本</label>		        							
      							
		        						</div>
		        						<div class="info-line1" style="margin-bottom:15px;">
		        							<label class="label">用户数:</label>
		        							<input type="text"  style="margin-right:114px" id="projectNum4" onkeyup="value=value.replace(/[^0-9_]/g,'')" onblur="checkUserum2(this.value)">
		        							<label>并发访问量:</label>
		        							<input type="text" id="projectCount4" onkeyup="value=value.replace(/[^0-9_]/g,'')" onblur="checkVisitum2(this.value)">
		        						</div>
		        						<div class="info-line1" style="margin-bottom:45px;margin-top:-5px;">
		        							<label class="label reason">用途说明:</label>
		        							<div id="YF_ProjectExp_id" style="margin-left:185px;margin-top:-2px;position:relative;" class="radio">
						    				</div>
		        						</div>
		        						<div class="info-line1" style="margin-top:-11px;">
		        							<label class="label reason">业务描述:</label>
		        							<textarea style="width:617px;height:72px;resize:none;border:1px solid #CCCCCC;border-radius: 2px;margin-left:145px;" id="projectNot4" onblur="checkBusiness2()"></textarea>
		        						</div>
		        						<div class="info-line1">
		        							<label class="label">当前时间:</label>
		        							<span class="label-content label-mar Clock4 time2" id="Clock4"  >2015-09-02</span>
		        							                               
		        							<label>到期时间:</label>
		        							<input type="text"  class="inline date time2-1" id="projectEndTime4" onblur="timeCheck2(this.value)">
		        						</div>
	        						</div>	        						
	        					</div>
	        					<div class="iaas_table">
	        						<div class="basic-table-tittle">基本配置</div>
	        						<ul class="basic-table-content">
	        							<li>
	        								<div class="iaas_table_title td1" >虚拟机类型：</div>
													<div  class="td2">
														<!--TAB切换-->
														 <div class="tab_div_sys">
														  <div class="tab_div_a_sys">
															   <ul id="tab_div_ul_yf_VirtualType">
																  <!--  <li class="qieh hideclass radius_left" id="c1"><a class="radius_left" href="#top_one">		WEB服务器</a></li>
																   <li><a href="#top_one"> 应用服务器</a></li>
																   <li class="hideclass radius_right" id="c2"><a class="radius_right gray-border" href="#top_two" > 数据库 </a></li>   -->
															   </ul> 
														  </div> 
														</div>  
													</div>
	        							</li>
	        							<li>
	        								<div class="iaas_table_title td1-1" >虚拟机数量：</div>
											<div  class="td2-2">  
												<input id="yf_v-num-count" type="text" class="v-num2" onkeyup="value=value.replace(/[^0-9_]/g,'')" style="position:absolute;left:0px;width: 190px;height: 30px; border: 1px solid #CCCCCC;border-radius: 2px;" onblur="checkNum2(this.value)">
											</div>
	        							</li>
	        							<li>
	        								<div class="iaas_table_title td3">cpu：</div>
													<div class="td4">
														<!--TAB切换-->
														 <div class="tab_div_cpu">
														  <div class="tab_div_a_cpu  cpu1" id="CPU2">
															   <ul id="tab_div_ul_cpu4">
																  
															   </ul> 
														  </div> 
														</div>  
													</div>
	        							</li>
	        							<li>
	        								<div class="iaas_table_title td5">内存：</div>
													<div class="td4-1">
														<!--TAB切换-->
														 <div class="tab_div_neicun" >
														  <div class="tab_div_a_neicun neicun1" id="yfneicun2">
															   <ul id="ul_neicun4">
																   <!-- <li class="qieh hideclass radius_left" id="c1"><A class="radius_left" href="#top_one">4G</A></li>
																   <li class="hideclass" id="c1"><A class="" href="#top_one">8G</A></li>
																   <li class="hideclass radius_right" id="c2"><a class="radius_right gray-border" href="#top_two">16G</a></li> 
																     -->
															   </ul> 
														  </div> 
														</div>  
													</div>
	        							</li>
	        							<li>
	        								<div class="iaas_table_title td6" >数据盘：</div>
													<div width="80%" class="td4-4">
														 <div class="tab_div_a_yp" style="position:absolute;top:-9px;left:-4px;">
														  <div class="User_ratings User_grade" id="div_fraction0"> 
															<div class="ratings_bars">  
																<div class="scale" id="bar4">
																	<div></div>
																	<span id="btn4">
																		<span id="title4">10G</span>
																	</span>

																</div>
															<label class="tenG">10G</label>
															<label class="twoG">200G</label>
															 <input type="text" class="caliche1 input-blur" onblur="move4()" value="10">
															 <label style="font-size:16px;color:#A7A7A7;line-height:24px;">G</label>
															</div>
														</div>
												</div>
	        							</li>
	        						</ul>
	        					</div>
								<div class="net system" onclick="emp()">
	        						<div class="net-tittle system-tittle">操作系统</div>
	        						<div class="net-content system-content">
	        							<div class="info-line1 system-mar2 line-system">
		        							<label class="label">操作系统:</label>
		        							<div class="link-type">
											    <div class="tab_div_a_sys1">
												   <ul id="resaerch_system_ul">
													   <li class="qieh hideclass radius_left Linux2" id="c1"><a class="radius_left" href="#top_one">Linux版本</a></li>		
													   <li class="hideclass radius_right Ubuntu2" id="c2"><a class="radius_right gray-border" href="#top_two" >Ubuntu</a></li>
												   </ul> 
											    </div> 
											</div>  			
		        						</div>
		        						
		        						<ul class="linux2" id="yf_system_child">
		        							<li class="blue-w">CentOS Linux 5.5 64bit</li>  
		        							<li>CentOS Linux 5.8 64bit</li>
		        							<li>CentOS Linux 6.0 32bit</li>
		        							<li>CentOS Linux 6.2 64bit</li>
		        						</ul>
		        						<!-- <ul class="linux2">
		        							<li class="blue-w">CentOS Linux 5.5 64bit</li>  
		        							<li>CentOS Linux 5.8 64bit</li>
		        							<li>CentOS Linux 6.0 32bit</li>
		        							<li>CentOS Linux 6.2 64bit</li>
		        							<li>CentOS Linux 6.4 64bit</li>
		        							<li>CentOS Linux 6.5 64bit</li>
		        						</ul>
		        						<ul class="window2">
		        							<li class="blue-w">Windows DC 2008 R2 64bit</li>
		        							<li>Windows 2008 EN R2 64bit</li>
		        						</ul>
		        						<ul class="ubuntu2">
		        							<li class="blue-w">Ubuntu  10.04 64bit</li>
		        							<li>Ubuntu  12.04 64bit</li>
		        						</ul> -->
		        						<div class="info-line1">
		        							<label class="label" style="margin-right:31px;">其他操作系统:</label>
		        							<input type="text" id="otherSys2" onchange="otherSystem2()" class="other-system1" >
		        						</div>
	        						</div>	        						
	        					</div>
	        					<div class="soft">
	        						<div class="soft-tittle">安装软件</div>
	        						<div class="soft-content">
	        							<div class="save-soft gray">存储软件:</div>
	        							<div class="save-soft-content" id="yf_save-soft-content2">
	        								    <!-- <div class="check-content1">
												<input type="checkbox" name="storageSoft4" class="check-btn0" id="check-btn0" onclick="softCheck4();">
												<div>Percona-Server-5.6.21-rel70.1-698.Linux.x86_64 </div>
												</div>
												
												<div class="check-content2">
												<input type="checkbox" name="storageSoft4" class="check-btn1" id="check-btn1" onclick="softCheck4();">
												<div>Redis-3.0.1</div>
												</div>
												
												<div class="check-content3">
												<input type="checkbox" name="storageSoft4" class="check-btn2" id="check-btn2" onclick="softCheck4();">
												<div>mongodb-linux-x86_64-rhel62-3.0.3</div>
												</div> -->
	        							</div>
	        							<div class="run-soft">运行环境软件:</div>
	        							<div class="run-soft-content" id="yf_run-soft-content2">
	        								   <!--  <div class="check-content4">
												<input type="checkbox" name="storageSoft5" class="check-btn3" id="check-btn3" onclick="softCheck5();"/>
												<span>Jdk1.7.0_79</span>
												</div>
												
												<div class="check-content5">
												<input type="checkbox" name="storageSoft5" class="check-btn5" id="check-btn5" onclick="softCheck5();"/>
												<span>Apache-tomcat-7.0.62</span>
												</div>
												
												<div class="check-content6">
												<input type="checkbox" name="storageSoft5" class="check-btn6" id="check-btn6" onclick="softCheck5();"/>
												<div>Zookeeper-3.4.6</div>
												</div>
												
												<div class="check-content7">
												<input type="checkbox" name="storageSoft5" class="check-btn7" id="check-btn7" onclick="softCheck5();"/>
												<span>gradle-2.2 </span>
												</div>
												
												<div class="check-content8">
												<input type="checkbox" name="storageSoft5" class="check-btn8" id="check-btn8" onclick="softCheck5();"/>
												<span>kafka_2.10-0.8.2.0</span>
												</div> -->
        								
	        							</div>
	        						</div>
	        					</div>
	        					<div class="presentDeploy2" >
									<div class="deploy-tittle">当前配置</div>
									<div class="present-line"></div>
									<ul class="present-content">
										<li>
											<span class="basicSpan">基本配置</span>
											<span class="contentSpan">
											虚拟机类型:&nbsp;<span id="virtualType4"></span>&nbsp;
											虚拟机数量:&nbsp;<span id="yf_v-num-countT"></span>个&nbsp;
											CPU:&nbsp;<span id="virtualCpu4"></span>&nbsp;
											内存:&nbsp;<span id="virtualRam4"></span>&nbsp;
											数据盘:&nbsp;<span id="virtualHard4"></span>G
											</span>
										</li>										
										<li>
											<span class="basicSpan">操作系统</span>
											<span class="contentSpan">
												操作系统:&nbsp;<span id="SysTem4"></span>
											         &nbsp;<span id="SysTemChild4"></span>
											<span id='sys2' style="display:none">
											&nbsp;其他操作系统:</span><span id="SysOtherTem4"></span>	
											</span>
										</li>
										<li>
											<span class="basicSpan">安装软件</span>
											<span class="contentSpan">
											存储软件:&nbsp;<span id="storageSoft4"></span>&nbsp;
											运行环境软件:&nbsp;<span id="environmentSoft4"></span>											
											</span>
										</li>
										
									</ul>
									<textarea style="height:100px;width:790px;resize:none;margin-left:10px;font-size:14px;" id="otherExplain2" onfocus="focus2()" onblur="blur2()">其他需求可再次补充</textarea>
									<input type="button" onclick="virtualSubmitYF()" class="apply-submit" value="申请提交">
									
									<span id="yf_msage1" style="margin-left:20px; font-size:14px; color:#F00;"></span>
									
								</div>
	        				</div> 	          	 			
	        			</div>   
	     			</div> 	 
	            </div>
            </div>
        </div>
    </div> 
    <!-- 租用漂浮配置窗 -->
   
	
<!--页脚-->
	<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include> 

  </body>
</html>
<script>
var end = {
	    elem: '#projectEndTime1',
	    format: 'YYYY-MM-DD',
	    min: laydate.now(+1),
	    max: '2099-06-16',
	    istime: true,
	    istoday: false,
	    choose: function(datas){
	        start.max = datas; //结束日选好后，充值开始日的最大日期
	    }
	};
var end1 = {
	    elem: '#projectEndTime4',
	    format: 'YYYY-MM-DD',
	    min: laydate.now(+1),
	    max: '2099-06-16',
	    istime: true,
	    istoday: false,
	    choose: function(datas){
	        start.max = datas; //结束日选好后，充值开始日的最大日期
	    }
	};
	laydate(end);
	laydate(end1);
</script>
  
