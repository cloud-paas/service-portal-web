<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html lang="zh-cn">
  <head>    
    <%@ include file="/jsp/common/common.jsp"%>
    
    <link href="${_base }/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${_base }/resources/css/virtual.css" rel="stylesheet">
    <script type="text/javascript" src="${_base }/resources/bower_components/jquery/dist/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="${_base }/resources/js/virtual/timejs/laydate.js"></script>
    <script type="text/javascript" src="${_base }/resources/js/virtual/virtualMachineModify.js"></script>
    
<style type="text/css">
.date{background: url(${_base }/resources/images/date.png) no-repeat right center;}
.info-line1 .other-system1,.info-line1 .other-system2{width:350px;}

.inform-success,.inform-fault{width: 460px;height: 205px;background: #fff;box-shadow: 0 0 5px 1px #ccc;position: relative;}
.ok{position: absolute;left: 50%;top: 37px;margin-left:-15px;}
.inform-success h4,.inform-fault h4{color: #333;position: absolute;left: 191px;top:70px;}
.sure{color: #fff;background:#169ADB;border: 1px solid #056A9E;left: 177px;width: 110px;height: 35px;text-align:center;line-height: 35px;font-weight: bold;font-size: 16px;position: absolute;top: 137px;}
.div_overlay{display:none;position: fixed;width: 100%;height:100%;z-index:1010;-moz-opacity: 0.0; opacity:.00;filter: alpha(opacity=0);background-color: black;}
.closeBtn{position:absolute;right:8px;top:6px;cursor:pointer;background:url(../resources/images/x1.png) no-repeat;width:16px;height:16px;}
.alertBox{height: 400px;width: 644px;margin-left:-322px;margin-top:-173px;box-shadow: #999 0px 0px 22px;display: none;z-index: 13;position: absolute;left: 50%;top: 50%;background: #fff;}
</style>


<script type="text/javascript">
//手机号验证
function limitNumber(value){
		var phone = value;
		var reg = /^0?(13|15|17|18|14)[0-9]{9}$/;
		if(phone.length != 11 || reg.test(phone) == false){
			$("#userPhone1").val("");
			$("#userPhone4").val("");
			//alert("联系电话输入格式错误！请重新输入");
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
	$("#"+str).val("");
	alert("输入格式有误，请输入数字！")
	}else{
	$("#"+str).css('border','1px solid #ccc')
	}

}

//租用云修改成功、失败
function mdfsuccess_zuyong(){
	location.href="${_base}/VirtualIntegration/vmSearch";	
}
function mdffault_zuyong(){
	$("#fadeshow").hide(); 
	$("#fault_zuyong").hide();
}

//研发云修改成功、失败
function mdfsuccess_yanfa(){
	location.href="${_base}/VirtualIntegration/vmSearch";	
}
function mdffault_yanfa(){
	$("#fadeshow").hide(); 
	$("#fault").hide();
}

var belongCloudTmp;
//成本按钮
function openBox(num){
	belongCloudTmp=num;
	var isProject;
	var isCheckedFlag;
	if(num==1){
		isCheckedFlag=$("#isProject1").prop('checked');
	}else{
		isCheckedFlag=$("#isProject2").prop('checked');
	}
	if(isCheckedFlag){
		isProject='Y';
	}else{
		isProject='N';
	}
	if(isProject == 'Y'){
		$('#alertBox').css('display','block')
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
function closeBox(){
// 	var topWin = window.top.document.getElementById("rightMain").contentWindow;
// 	var projectRadio = topWin.document.getElementById("checkRadioValue").value; //这里获取元素的属性;
	$('#alertBox').css('display','none');
	arrs  = projectRadio.split("_");
	if(belongCloudTmp==1){
		$('#projectName4').text(arrs[0]) ;
		$('#costcenter_id4').text(arrs[1]) ; 
	}else{
		$('#projectName1').text(arrs[0]) ;
		$('#costcenter_id1').text(arrs[1]) ; 
	}
	
}


</script>

 </head> 
  <body>    
  
  	<div class="alertBox" id="alertBox">
  		<span class="closeBtn" onclick="closeBox()"></span>
  		<iframe name="right" id="rightMain" src="${_base}/oa/erpProjectsInit" frameborder="no" scrolling="no" width="644px" height="415px" allowtransparency="true"></iframe>
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
	        				<input type="hidden" id="orderDetailId" value="${orderDetailId}">
	        				<input type="hidden" id="cloud_id" >
	        				<ul>
	        					<li id="zysign">华为租用云</li>
	        					<li id="yfsign">研发云</li>
	        				</ul>
	        			</div> 
	        			<div class="Open_cache_list" >
	        				<div class="rent" value="1">
	        					<div class="basic-info">
	        						<div class="left-tittle">基本信息</div>		
	        						<div class="basic-content">
	        							<div class="info-line1">
		        							<label class="label">申请人:</label>
		        							<span class="label-content label-mar" id="applyUser1"></span>
		        							<label>申请部门:</label>
		        							<span class="label-content" id="applyDepartment1"></span>
		        						</div>
		        						<div class="info-line1">
		        							<label class="label">联系电话:</label>
		        							<input type="text"  style="margin-right:130px" maxlength="11" class="txt" id="userPhone1" onkeyup="value=value.replace(/[^0-9_]/g,'')" onblur="checkMobile(this.value)" >
		        							<label>邮箱地址:</label>
		        							<span class="label-content" Id="userEmail1"></span>
		        						</div>
		        						<div class="info-line1">
		        							<label class="label reason">申请原因:</label>
		        							<textarea onblur="checkReason1()" style="width:617px;height:72px;resize:none;border:1px solid #CCCCCC;border-radius: 2px;margin-left:145px;" id="applyReason1" ></textarea>
		        						</div>
	        						</div>	        						
	        					</div>
	        					<div class="project">
	        						<div class="project-tittle">项目信息</div>
	        						<div class="project-content">
	        							<div class="info-line1">
		        							<label class="label">成本中心/名称:</label>
		        							<span id="projectName1"></span> (<span id="costcenter_id1"></span>)
		        							<label class="label" style="margin-left:10px;"><input id="isProject1" type="checkbox" name="isProject2" onclick="openBox(1);" style=" margin-right:10px;margin-bottom: -3px;width:15px;height:15px" >项目成本</label>
		        						
		        						</div>
		        						<div class="info-line1" style="margin-bottom:15px;">
		        							<label class="label">用户数:</label>
		        							<input type="text"  style="margin-right:114px" id="projectNum1" onkeyup="value=value.replace(/[^0-9_]/g,'')" onblur="checkUsernum1(this.value)">
		        							<label>并发访问量:</label>
		        							<input type="text" id="projectCount1" onkeyup="value=value.replace(/[^0-9_]/g,'')" onblur="checkVisitum1(this.value)" >
		        						</div>
		        						<div class="info-line1" style="margin-bottom:45px;margin-top:-5px;">
		        							<label class="label reason">用途说明:</label>
		        							<div style="margin-left:185px;margin-top:-2px;position:relative;" class="radio"> 
		        								<!-- <input type="radio" style="width:13px;height:20px;line-height:10px;position:absolute;left:-5px;top:-1px;" name="function" class="projectExplain1" value="1" id="produce_sign"  >
		        								<span style="position:absolute;left:6px;top:1px;width:40px;">生产</span>
		        								<input type="radio" style="width:13px;height:20px;line-height:10px;position:absolute;left:90px;top:-1px;" name="function" class="projectExplain1" value="2" id="other_sign"  >
		        								<span style="width:40px;display:inline-block;position:absolute;left:104px;top:1px;">其他</span> -->
		        								<input type="radio" style="width:13px;height:20px;line-height:10px;position:absolute;left:-5px;top:-1px;" name="function" class="projectExplain1" value="1" id="develop_sign">
		        								<span style="position:absolute;left:6px;top:1px;width:40px;">开发</span>  
		        								<input type="radio" style="width:13px;height:20px;line-height:10px;position:absolute;left:90px;top:-1px;" name="function" class="projectExplain1" value="2" id="test_sign">
		        								<span style="width:40px;display:inline-block;position:absolute;left:104px;top:1px;">测试</span>
		        								<input type="radio" style="width:13px;height:20px;line-height:10px;position:absolute;left:190px;top:-1px;" name="function" class="projectExplain1" value="3" id="produce_sign">
		        								<span style="position:absolute;left:200px;top:1px;width:40px;">生产</span>
		        								<input type="radio" style="width:13px;height:20px;line-height:10px;position:absolute;left:288px;top:-1px;" name="function" class="projectExplain1" value="4" id="other_sign">
		        								<span style="width:40px;display:inline-block;position:absolute;left:298px;top:1px;">其他</span>
		        								
		        							</div>		        				
		        						</div>
		        						<div class="info-line1" style="margin-top:-11px;">
		        							<label class="label reason">业务描述:</label>
		        							<textarea style="width:617px;height:72px;resize:none;border:1px solid #CCCCCC;border-radius: 2px;margin-left:145px;" id="projectNot1" onblur="checkBusiness1()"></textarea>
		        						</div>
		        						<div class="info-line1">
		        							<label class="label">当前时间:</label>
		        							<span class="label-content label-mar time1" id="Clock"></span>
		        							<label>到期时间:</label>
		        							<input type="text" onClick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="date time1-1" id="projectEndTime1" onblur="timeCheck1(this.value)" >
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
															   <ul >   
																   <!-- <li class=" hideclass radius_left" id="c1"><a class="radius_left" href="#top_one">		WEB服务器</a></li>
																   <li><a href="#top_one">应用服务器</a></li>
																   <li class="hideclass radius_right" id="c2"><a class="radius_right gray-border" href="#top_two" >数据库</a></li>   -->
															   </ul> 
														  </div> 
														</div>  
													</div> 
	        							</li>
	        							<li>
	        								<div class="iaas_table_title td1-1" >虚拟机数量：</div>
											<div class="td2-2">
												<input id="zy_v-num-countW" type="text" class="v-num1" onblur="checkNum1(this.value)" onkeyup="value=value.replace(/[^0-9_]/g,'')" style="width:190px;height:30px;border:1px solid #ccc;border-radius:3px;position:absolute;left:0px;"> 
											</div>
	        							</li>
	        							<li>
	        								<div class="iaas_table_title td3">cpu：</div>
													<div class="td4">
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
													<div  class="td4-1">
														<!--TAB切换-->
														 <div class="tab_div_neicun">
														  <div class="tab_div_a_neicun neicun1">
															<ul id="ul_neicun1">
			                                                 
															</ul> 
														  </div> 
														</div>  
													</div>
	        							</li>
	        							<li>
	        								<div class="iaas_table_title td6" >数据盘：</div>
													<div class="td4-4">
														
														 <div class="tab_div_a_yp" style="position:absolute;left:-10px;top:-10px;">
									  <div class="User_ratings User_grade" id="div_fraction0"> 
										<div class="ratings_bars">  
											<div class="scale" id="bar0">
												<div></div>
												<span id="btn0">
													<span id="title0">10G</span>
												</span>

											</div>
										<label class="tenG">10G</label>
										<label class="twoG">200G</label>
										 <input type="text" class="caliche input-blur"  onblur="move()"  value="10">
										 <label class="m">G</label>
										</div>
									</div>
													</div>
	        							</li>
	        						</ul>
	        					</div>
				   				
								<div class="net">
	        						<div class="net-tittle net-tittle1">网络资源</div>
	        						<div class="net-content">
	        							<div class="info-line1 line-link" >
		        							<label class="label">链路类型:</label>
		        							<div class="link-type">
											    <div class="tab_div_a_sys2">
												   <ul>  
													 <!--   <li class="qieh hideclass radius_left liantong" id="c1"><a class="radius_left" href="#top_one">		联通</a></li>
													   <li class="dianxin"><a href="#top_one">
													  电信
													   </a></li>
													   <li class="double"><a href="#top_one">
													  联通+电信
													   </a></li>
													   <li class="hideclass radius_right BGP" id="c2"><a class="radius_right gray-border" href="#top_two" >
													  BGP
													   </a></li>  --> 
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
																<label class="m">M</label>
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
		        							<input type="text" id="netNumber" onchange="netNumber()" onblur="checkNetnumber(this.value)"  onkeyup="value=value.replace(/[^0-9_]/g,'')">
		        						</div>
	        						</div>	        						
	        					</div>
								<div class="net system">
	        						<div class="net-tittle system-tittle">操作系统</div>
	        						<div class="net-content system-content" id="system1">
	        							<div class="info-line1 system-mar1 line-system" style="">
		        							<label class="label">操作系统:</label>
		        							<div class="link-type">
											    <div class="tab_div_a_sys1">
												   <ul class="system1"> 
													  <!--  <li class="qieh hideclass radius_left Linux1" id="c1"><a class="radius_left" href="#top_one">Linux版本</a></li>
													   <li class="Window1"><a href="#top_one">
													  Window版本
													   </a></li>			
													   <li class="hideclass radius_right Ubuntu1" id="c2"><a class="radius_right gray-border" href="#top_two" >
													 Ubuntu
													   </a></li>   -->
												   </ul> 
											    </div> 
											</div>  			
		        						</div>
		        						<ul class="linux1">     
		        							
		        						</ul>
		        						<ul class="window1">
		        							
		        						</ul>
		        						<ul class="ubuntu1">
		        						
		        						</ul>
		        						<div class="info-line1">
		        							<label class="label" style="margin-right:31px;">其他操作系统:</label>
		        							<input type="text" id="otherSys1" class="other-system1" onchange="otherSystem()"  >
		        						</div>
	        						</div>	        						
	        					</div>
	        					<div class="soft">
	        						<div class="soft-tittle">安装软件</div>
	        						<div class="soft-content">
	        							<div class="save-soft gray">存储软件:</div>
	        							<div class="save-soft-content">
	        								
	        								
	        								
	        							</div>
	        							<div class="run-soft">运行环境软件:</div>
	        							<div class="run-soft-content">
	        									        								
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
											虚拟机类型:&nbsp;<span id="virtualType1"></span>、
											虚拟机数量:&nbsp;<span id="zy_v-num-countU"></span>个、
											CPU:&nbsp;<span id="virtualCpu1"></span>、
											内存:&nbsp;<span id="virtualRam1"></span>、
											数据盘:&nbsp;<span id="virtualHard1"></span>G
											
											</span>
										</li>
										<li>
											<span class="basicSpan">网络资源</span>
											<span class="contentSpan">
												链路类型:&nbsp;<span id="netType1"></span>、
												公网宽带:&nbsp;<span id="netWbn1"></span>M、
												公网数量:&nbsp;<span id="netNum1"></span>、
											</span>
										</li>
										<li>
											<span class="basicSpan">操作系统</span>
											<span class="contentSpan">
											操作系统:&nbsp;<span id="SysTem11"></span>
											         &nbsp;<span id="SysTemChild1"></span>、
											其他操作系统:&nbsp;<span id="SysOtherTem1"></span>											
											</span>
										</li>
										<li>
											<span class="basicSpan">安装软件</span>
											<span class="contentSpan">
											存储软件:&nbsp;<span id="storageSoft1"></span>&nbsp;、
											运行环境软件:&nbsp;<span id="environmentSoft1"></span>											
											</span>
										</li>
									</ul>
									<textarea style="height:100px;width:790px;resize:none;margin-left:10px;font-size:14px;" id="otherExplain1">其他需求可再次补充</textarea>
									<!--  <a href="#" target="_self">-->
									 <input type="button" onclick="zyCloudModify()" class="apply-submit" value="修改提交" > 
									 <span class="zy-warning" style="margin-left:20px;font-size:15px;color:red;"></span>
									<!--  </a>-->
								</div>
	        				</div> 
	        				
	        				
	 <!-- **********************研发云***************************** -->     				
	        				<div class="resaerch" >
	        					<div class="basic-info">
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
		        							<input type="text"  style="margin-right:130px" maxlength="11" class="txt" id="userPhone4" onkeyup="value=value.replace(/[^0-9_]/g,'')" onblur="checkMobile2(this.value)">
		        							<label>邮箱地址:</label>
		        							<span class="label-content" Id="userEmail4"></span>
		        						</div>
		        						<div class="info-line1">
		        							<label class="label reason">申请原因:</label>
		        							<textarea style="width:617px;height:72px;resize:none;border:1px solid #CCCCCC;border-radius: 2px;margin-left:145px;" id="applyReason4" onblur="checkReason2()"></textarea>
		        						</div>
	        						</div>	        						
	        					</div>
	        					<div class="project">
	        						<div class="project-tittle">项目信息</div>
	        						<div class="project-content">
	        							<div class="info-line1">
		        							<label class="label">成本中心/名称:</label>
		        							<span id="projectName4"></span>	(<span id="costcenter_id4"></span>)	
		        							<label class="label" style="margin-left:10px;"><input id="isProject2" type="checkbox" name="isProject2" onclick="openBox(2);" style=" margin-right:10px;margin-bottom: -3px;width:15px;height:15px" >项目成本</label>
		        						</div>
		        						<div class="info-line1" style="margin-bottom:15px;">
		        							<label class="label">用户数:</label>
		        							<input type="text" onblur="checkUserum2(this.value)"  style="margin-right:114px" id="projectNum4" onkeyup="value=value.replace(/[^0-9_]/g,'')">
		        							<label>并发访问量:</label>
		        							<input type="text" id="projectCount4" onblur="checkVisitum2(this.value)" onkeyup="value=value.replace(/[^0-9_]/g,'')">
		        						</div>
		        						<div class="info-line1" style="margin-bottom:45px;margin-top:-5px;">
		        							<label class="label reason">用途说明:</label>
		        							<div style="margin-left:185px;margin-top:-2px;position:relative;" class="radio">
		        							<!-- 	<input type="radio" style="width:13px;height:20px;line-height:10px;position:absolute;left:-5px;top:-1px;" name="function2" class="projectExplain4" value="1"  id="produce_sign1"  >
		        								<span style="position:absolute;left:6px;top:1px;width:40px;">生产</span>
		        								<input type="radio" style="width:13px;height:20px;line-height:10px;position:absolute;left:90px;top:-1px;" name="function2" class="projectExplain4" value="2" id="other_sign1"  >
		        								<span style="width:40px;display:inline-block;position:absolute;left:104px;top:1px;">其他</span> -->
		        								<input type="radio" style="width:13px;height:20px;line-height:10px;position:absolute;left:-5px;top:-1px;" name="function2" class="projectExplain4" value="1" id="develop_sign1">
		        								<span style="position:absolute;left:6px;top:1px;width:40px;">开发</span>  
		        								<input type="radio" style="width:13px;height:20px;line-height:10px;position:absolute;left:90px;top:-1px;" name="function2" class="projectExplain4" value="2" id="test_sign1">
		        								<span style="width:40px;display:inline-block;position:absolute;left:104px;top:1px;">测试</span>
		        								<input type="radio" style="width:13px;height:20px;line-height:10px;position:absolute;left:190px;top:-1px;" name="function2" class="projectExplain4" value="3" id="produce_sign1">
		        								<span style="position:absolute;left:200px;top:1px;width:40px;">生产</span>
		        								<input type="radio" style="width:13px;height:20px;line-height:10px;position:absolute;left:288px;top:-1px;" name="function2" class="projectExplain4" value="4" id="other_sign1">
		        								<span style="width:40px;display:inline-block;position:absolute;left:298px;top:1px;">其他</span>
		        							
		        							</div>
		        						</div>
		        						<div class="info-line1" style="margin-top:-11px;">
		        							<label class="label reason">业务描述:</label>
		        							<textarea onblur="checkBusiness2()" style="width:617px;height:72px;resize:none;border:1px solid #CCCCCC;border-radius: 2px;margin-left:145px;" id="projectNot4" ></textarea>
		        						</div>
		        						<div class="info-line1">
		        							<label class="label">当前时间:</label>
		        							<span class="label-content label-mar Clock4 time2" id="Clock4"  ></span>
		        							                               
		        							<label>到期时间:</label>
		        							<input type="text" onblur="timeCheck2(this.value)"  onClick="laydate({istime: true, format: 'YYYY-MM-DD'})" class="date time2-1" id="projectEndTime4">
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
															   <ul>
																  
															   </ul> 
														  </div> 
														</div>  
													</div>
	        							</li>
	        							<li>
	        								<div class="iaas_table_title td1-1" >虚拟数量：</div>
											<div class="td2-2">
												<input id="yf_v-num-countW" type="text" class="v-num2" onblur="checkNum2(this.value)" onkeyup="value=value.replace(/[^0-9_]/g,'')" style="width:190px;height:30px;border:1px solid #ccc;border-radius:3px;position:absolute;left:0px;">	
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
														 <div class="tab_div_neicun">
														  <div class="tab_div_a_neicun neicun1" id="yfneicun2">
															   <ul id="ul_neicun4">
																   <li class="hideclass radius_left" id="c1"><A class="radius_left" href="#top_one">4G</A></li>
																   <li class="qieh hideclass" id="c1"><A class="" href="#top_one">8G</A></li>
																   <li class="hideclass" id="c1"><A class="" href="#top_one">10G</A></li>
																   <li class="hideclass" id="c1"><A class="" href="#top_one">16G</A></li>
																   <li class="hideclass radius_right" id="c2"><a class="radius_right gray-border" href="#top_two">
																   32G
																   </a></li>  
															   </ul> 
														  </div> 
														</div>  
													</div>
	        							</li>
	        							<li>
	        								<div class="iaas_table_title td6" >数据盘：</div>
											<div class="td4-4">
												 <div class="tab_div_a_yp" style="position:absolute;left:-10px;top:-10px;">
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
								<div class="net system">
	        						<div class="net-tittle system-tittle">操作系统</div>
	        						<div class="net-content system-content">
	        							<div class="info-line1 system-mar2 line-system">
		        							<label class="label">操作系统:</label>
		        							<div class="link-type">
											    <div class="tab_div_a_sys1">
												   <ul class="system2">
													  <!--  <li class="qieh hideclass radius_left Linux2" id="c1"><a class="radius_left" href="#top_one">Linux版本</a></li>
													   <li class="Window2"><a href="#top_one">
													  Window版本
													   </a></li>			
													   <li class="hideclass radius_right Ubuntu2" id="c2"><a class="radius_right gray-border" href="#top_two" >
													 Ubuntu
													   </a></li>   -->
												   </ul> 
											    </div> 
											</div>  			
		        						</div>
		        						<ul class="linux2">
		        							 
		        						</ul>
		        						<ul class="window2">
		        							
		        						</ul>
		        						<ul class="ubuntu2">
		        							 
		        						</ul>
		        						<div class="info-line1">
		        							<label class="label" style="margin-right:31px;">其他操作系统:</label>
		        							<input type="text" id="otherSys2" class="other-system2" onchange="otherSystem2()" >
		        						</div>
	        						</div>	        						
	        					</div>
	        					<div class="soft">
	        						<div class="soft-tittle">安装软件</div>
	        						<div class="soft-content">
	        							<div class="save-soft gray">存储软件:</div>
	        							<div class="save-soft-content">
	        								 
											  
	        							</div>
	        							<div class="run-soft">运行环境软件:</div>
	        							<div class="run-soft-content">
	        								 
												
												 
												
											 
												
												 
												
												 
        								
	        							</div>
	        						</div>
	        					</div>
	        					<div class="presentDeploy2">
									<div class="deploy-tittle">当前配置</div>
									<div class="present-line"></div>
									<ul class="present-content">
										<li>
											<span class="basicSpan">基本配置</span>
											<span class="contentSpan">
											虚拟机类型:&nbsp;<span id="virtualType4"></span>、
											虚拟机数量:&nbsp;<span id="yf_v-num-countU"></span>个、
											CPU:&nbsp;<span id="virtualCpu4"></span>、
											内存:&nbsp;<span id="virtualRam4"></span>、
											数据盘:&nbsp;<span id="virtualHard4"></span>G
											</span>
										</li>										
										<li>
											<span class="basicSpan">操作系统</span>
											<span class="contentSpan">
												操作系统:&nbsp;<span id="SysTem4"></span>
											         &nbsp;<span id="SysTemChild4"></span>、
											其他操作系统:&nbsp;<span id="SysOtherTem4"></span>	
											</span>
										</li>
										<li>
											<span class="basicSpan">安装软件</span>
											<span class="contentSpan">
											存储软件:&nbsp;<span id="storageSoft4"></span>&nbsp;、
											运行环境软件:&nbsp;<span id="environmentSoft4"></span>											
											</span>
										</li>
										
									</ul>
									<textarea style="height:100px;width:790px;resize:none;margin-left:10px;font-size:14px;" id="otherExplain2">其他需求可再次补充</textarea>
									<input type="button" onclick="yfCloudMofify()" class="apply-submit" value="修改提交">
									<span class="yf-warning" style="margin-left:20px;font-size:15px;color:red;"></span>
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
  
