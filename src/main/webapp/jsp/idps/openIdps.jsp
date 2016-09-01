<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<html lang="zh-cn">
  <head>
<title>开通图片服务IDPS</title>
   <%@ include file="/jsp/common/common.jsp"%>
 <script>
	var openOCSController;
	$(document).ready(function(){
		$("#${list_index}").attr('style', 'margin-top:2px;color:#1699dc');
		$("#navi_tab_product").addClass("chap");
		openOCSController = new $.OpenOCSController();
		//$("#my_size").find("option[value='${userCacheResultVo.cache_memory}']").attr("selected",true);
	});
	/*定义页面管理类*/
	(function(){
		$.OpenOCSController  = function(){ 
			this.settings = $.extend(true,{},$.OpenOCSController.defaults); 
			this.init();
		};
		
		jQuery.validator.addMethod("regexpName", function(val) {
			return new RegExp("^[A-Za-z0-9_\u4e00-\u9fa5]+$").test(val);
		},"请输入合法的服务名称");
        
        jQuery.validator.addMethod("regexpPwd", function(val) {
			return new RegExp("^[A-Za-z0-9_]+$").test(val);
		},"只能输入字母数字和下划线");
		
		$.extend($.OpenOCSController,{
			defaults : { 
					CPUNUM_ID : "#cpuNum",
					MEMSIZE_ID : "#memSize",
					NODENUM_ID : "#nodeNum",
					IDPSSERVICEPWD_ID : "#idpsServicePwd",
					DSSSERVICEID_ID : "#dssServiceId",
					SERVICENAME_ID : "#serviceName",
					SUBMIT_ID : "#my_submit"
			},
			prototype : {
				init : function(){
					var _this = this;
					_this.addRults();
					_this.bindEvents();				
				},
				bindEvents : function(){
					var _this = this;					
					$(_this.settings.SUBMIT_ID).bind("click",function(){
						if ($("#myForm").valid()){							
							var cpuNum=$(_this.settings.CPUNUM_ID).val();
							var memSize=$(_this.settings.MEMSIZE_ID).val();							
							var nodeNum=$(_this.settings.NODENUM_ID).val();							
							var idpsServicePwd=$(_this.settings.IDPSSERVICEPWD_ID).val();
							var dssServiceId=$(_this.settings.DSSSERVICEID_ID).val();
							var serviceName=$(_this.settings.SERVICENAME_ID).val();
							$('.waitCover').show();
							$.ajax({
								async : true,
								type : "POST",
								url : "${_base}/idps/openIdps",
								modal : true,
								showBusi : false,
								data : {									
									cpuNum	: cpuNum,
									memSize : memSize,
									nodeNum : nodeNum,
									idpsServicePwd : idpsServicePwd,
									dssServiceId : dssServiceId,
									serviceName : serviceName
								},
								success: function(data){
									var json=data									
									if(json&&json.resultCode=="0000"){
										
										location.href=getContextPath() +"/mcs/applyCompleted?prod=IDPS";  //&url=/dss/toOpenDss&prodType=1
										$('.waitCover').hide();
									}else{									
										alert(json.resultMessage);
										$('.waitCover').hide();
									}
								}
							});	
						}
					});										
				},			
				addRults : function() {				
				    var myForm = $("#myForm");
				    myForm.validate({
		                rules: {
		                	serviceName: {
		                		regexpName: true,
		                        required: true,
		                        rangelength:[1,128]
		                    }, 		 
		                    dssServiceId: {
		                		regexpName: false,
		                        required: true,
		                        rangelength:[1,128]
		                    }, 	
		                    idpsServicePwd: {
		                    	regexpPwd: true,
		                    	required: true,
		                    	rangelength:[6,18]
		                    }
		                },
		                messages:{
		                	serviceName:{
		                		required:"请输入服务名称",
		                		rangelength:"服务名称最大长度不超过50"
		                	},
		                	dssServiceId:{
		                		required:"请输入dss服务id",
		                		rangelength:"dss服务id最大长度不超过50"
		                	},
		                	idpsServicePwd:{
		                		required:"请输入服务密码",
		                		rangelength:"服务密码长度应为6~16个字符"
		                	}
		                	
		                },
		                success: function (label, element) {
		                    $(element).removeAttr("style");
		                },
		                errorPlacement: function (error, element) {
		                	//error.appendTo($(element+(_error))); 
		                	$("#"+$(element).attr("id")+"_error").text($(error).text());
		                    $(element).css("border-color", "rgb(249, 135, 135)");
		                },
		                submitHandler: function () {
		                	myForm.valid();
		                }
		            }); 
				}
			}
		});
	})(jQuery);
	</script>
   <script>
   	$(document).ready(function(){
   		$('a[id^=active_]').each(function(){
   			$(this).css('color', '#949494');
   		});
   		$('#active_prod').css('color', '#1699dc');
//    		$('.mune_2').css('padding-left', '1%');
   		
   	});
   </script>
	
  </head> 
  <body> 
  <!-- 遮盖层 -->
    <div class="waitCover">
	   <img  src="${_base }/resources/images/waitPng.png" class="waitPng" >
	   <div class="waitTxt">正在加载请稍后...</div>
	</div>    
   <div class="big_k">
<!-- 头部和导航条 -->
<div class="navigation">
		<%@ include file="/jsp/common/header.jsp"%>
	</div>
  <div class="container chanp">
	 	<div class="row chnap_row">
    <%@ include file="/jsp/common/leftMenu_new.jsp"%>
  <div class="col-md-6 right_list">
     
     <div class="Open_cache">
        <div class="Open_cache_table">
			<ul style="border-bottom:1px #eee">
			<li><a>开通图片服务IDPS</a></li> 
			</ul>  
        </div>  
          <form id="myForm">
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
	          	<div class="Open_cache_list_tow">
	          		<ul>
			          <li class="font-title" style="margin-left:30px;">产品名称：</li>
			          <li class="font-title" >图片服务IDPS</li> 
		          	</ul>
		          	<ul>
			          <li class="font-title" style="margin-left:30px;">CPU数量：</li>				          
			          <li  >			          
			          		<select id=cpuNum name="cpuNum"  class="ch_select">
									<c:forEach items="${cpuNumList}" var="optionVo">
										<option value="${optionVo.serviceValue }">${optionVo.serviceOption}</option>
									</c:forEach>									
								</select>
										          
			          </li>	
			           <li  style="padding-top:0.5%;font-size:18px;font-weight:400">核</li>			          		          
		          	</ul>
		          	<ul>
			          <li class="font-title" style="margin-left:30px;">内存大小：</li>				          
			          <li  >			          
			          		<select id="memSize" name="memSize"  class="ch_select">
									<c:forEach items="${memSizeList}" var="optionVo">
										<option value="${optionVo.serviceValue }">${optionVo.serviceOption}</option>
									</c:forEach>									
								</select>
										          
			          </li>	
			           <li  style="padding-top:0.5%;font-size:18px;font-weight:400">M</li>			          		          
		          	</ul>
		          	<ul>
			          <li class="font-title" style="margin-left:30px;">节点数量：</li>				          
			          <li  >			          
			          		<select id="nodeNum" name="nodeNum"  class="ch_select">
									<c:forEach items="${nodeNumList}" var="optionVo">
										<option value="${optionVo.serviceValue }">${optionVo.serviceOption}</option>
									</c:forEach>									
								</select>
										          
			          </li>	
			           <li  style="padding-top:0.5%;font-size:18px;font-weight:400">个</li>			          		          
		          	</ul>		          	
		          	<ul>
			          <li class="font-title" style="margin-left:17px;">DSS服务ID：</li>
			          <li ><input name="dssServiceId" id="dssServiceId" type="text" class="form-control"aria-describedby="sizing-addon2"></li>
			          <li><label style="color:red;" id="dssServiceId_error"></label></li>
		          	</ul>
		          	<ul>
			          <li class="font-title" style="margin-left:2px;">IDPS服务名称：</li>
			          <li ><input name="serviceName" id="serviceName" type="text" class="form-control"aria-describedby="sizing-addon2"></li>
			          <li><label style="color:red;" id="serviceName_error"></label></li>
		          	</ul>
	         		<ul>
			          <li class="font-title" style="margin-left:2px;">IDPS服务密码：</li>
			          <li ><input name="idpsServicePwd" id="idpsServicePwd" type="text" class="form-control"aria-describedby="sizing-addon2"></li>
			          <li><label style="color:red;" id="idpsServicePwd_error"></label></li>
		          	</ul>
		          	
					<ul style="padding-left:10%">   
			          <li>
						<a A href="javascript:void(0);" id="my_submit"><div style="margin-top:20px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(121,189,90);line-height:30px;vertical-align:middle;color:#fff">立即开通</div></a>
					  </li> 
		          	</ul> 
	           </div>                
	        </div>  
    	</div>  
    	</form> 
     </div> 
 
  </div>
</div>

</div>
</div>  
<!--页脚-->
<%@ include file="/jsp/common/footer_new.jsp"%>	
  </body>
</html>
