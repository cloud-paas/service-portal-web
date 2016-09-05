<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
  <head>
  <title>开通缓存中心MCS</title>
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
						NAME_ID : "#my_name",
						CAPACITY_ID : "#my_capacity",
					PASSWORD_ID : "#my_password",
					  HAMODE_ID : "#my_haMode",
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
							var my_capacity=$(_this.settings.CAPACITY_ID).val();
							var my_name=$(_this.settings.NAME_ID).val();
							var my_password=$(_this.settings.PASSWORD_ID).val();
							//if(my_password=="")
							var my_haMode=$(_this.settings.HAMODE_ID).val();
							
							$('.waitCover').show();
							$.ajax({
								async : true,
								type : "POST",
								url : "${_base}/mcs/openCache",
								modal : true,
								showBusi : false,
								data : {
									my_capacity : my_capacity,
										my_name	: my_name,
									my_password : my_password,
									  my_haMode : my_haMode
								},
								success: function(data){
									var json=data
									if(json&&json.resultCode=="0000"){
										
										location.href=getContextPath() +"/mcs/applyCompleted?prod=MCS"; //&url=/mcs/toOpenCache&prodType=1
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
		                	my_name: {
		                		regexpName: true,
		                        required: true,
		                        rangelength:[1,128]
		                    }, 		                  
		                    my_password: {
		                    	regexpPwd: true,
		                    	required: true,
		                    	rangelength:[6,18]
		                    }
		                },
		                messages:{
		                	my_name:{
		                		required:"请输入服务名称",
		                		rangelength:"服务名称最大长度不超过50"
		                	},
		                	my_password:{
		                		required:"请输入服务密码",
		                		rangelength:"密码长度应为6~16个字符"
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
			<li><a>开通缓存中心MCS</a></li> 
			</ul>  
        </div>  
          <form id="myForm">
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
	          	<div class="Open_cache_list_tow">
	          		 <ul>
			          <li class="font-title">产品名称：</li>
			          <li class="font-title">缓存中心MCS</li> 
		          	</ul>
		          	<ul>
	          			<li class="font-title">缓存容量：</li>
	          			<li>
	          				<select id="my_capacity"  name="my_capacity" class="ch_select">
	          					<c:forEach items="${sizeList}" var="my_size">
	          					<option value="${my_size.serviceValue}">${my_size.serviceOption}</option>
	          					</c:forEach>
	          				</select>
	          
	          			</li>
	          			<li>对应的吞吐量峰值为15MBps， QPS峰值为9000次/秒</li>
	         		</ul>
	         		<ul>
			          <li class="font-title">服务名称：</li>
			          <li><input id="my_name" name="my_name" type="text" class="form-control"aria-describedby="sizing-addon2"></li>
			          <li><label style="color:red;" id="my_name_error"></label></li>
		          	</ul>
	         		<ul>
			          <li class="font-title">服务密码：</li>
			          <li><input id="my_password" name="my_password"  type="text" class="form-control"aria-describedby="sizing-addon2"></li>
			          <li><label style="color:red;" id="my_password_error"></label></li>
		          	</ul>
                     <ul>
	          			<li class="font-title">服务模式：</li>
	          			<li>
	          				<select id="my_haMode"  name="my_haMode" class="ch_select">
	          					<c:forEach items="${modeList}" var="my_mode">
	          					<option value="${my_mode.serviceValue}">${my_mode.serviceOption}</option>
	          					</c:forEach>
	          				</select>
	          
	          			</li>
	         		</ul>
					<ul style="padding-left:10%">   
			          <li>
						<a id="my_submit" href="#"><div style="margin-top:20px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(121,189,90);line-height:30px;vertical-align:middle;color:#fff">立即开通</div></a>
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
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>			
			
<script type="text/javascript"> 
$(".mune_1 li").each(function(){
		$(this).hover(function(){
			$(this).attr("style","border-bottom:solid 2px rgb(57,150,207);color:rgb(57,150,207)")
		},function(){ 
			$(this).attr("style","border-bottom:solid 2px #fff;color:#949494")
		});
}); 
 
$(".two li").each(function(){
		$(this).hover(function(){
			$(this).attr("style","border-bottom:solid 2px rgb(120,189,90);color:rgb(120,189,90)")
		},function(){ 
			$(this).attr("style","border-bottom:solid 2px #fff;color:#949494")
		});
}); 
 
 $(".tab_div_a li").click(function(){
	 $(".tab_div_a li").each(function(i){
		$(this).removeClass("qieh");
	 })
	$(this).addClass("qieh");
 });
</script>
  </body>
</html>
