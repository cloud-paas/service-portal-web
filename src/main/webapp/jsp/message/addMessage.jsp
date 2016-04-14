<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="/spring-form" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<title>开通消息中心MDS</title>
<style>
label.error {
  color: red;
  font-style: italic;
}
</style>
<script>
	var OpenMSQController;
	
	$(document).ready(function(){
		$("#${list_index}").attr('style', 'margin-top:2px;color:#1699dc');
		$("#navi_tab_product").addClass("chap");
		OpenMSQController = new $.OpenMSQController();
		
		jQuery.validator.addMethod("regexpName", function(val) {
			return new RegExp("^[A-Za-z0-9_\u4e00-\u9fa5]+$").test(val);
		},"请输入合法的服务名称");
        
        jQuery.validator.addMethod("regexpPwd", function(val) {
			return new RegExp("^[A-Za-z0-9_]+$").test(val);
		},"只能输入字母数字和下划线");
		
		$("#messageForm").validate({
			onkeyup:false,
			rules: {
				queueName: {
					regexpName: true,
					required:true,
				},
				queuePwd:{
					regexpPwd: true,
					required:true,
					rangelength:[6,18]
				},
				maxProducer:{
					number:true,
					max:5,
					min:1,
					digits:true
				},
				mqsCheck:"required"
				
		
			},
			 messages: {
				 queueName: {
					 required:"请输入服务名称",
				 },
				 queuePwd:{
					 	required:"请输入服务密码",
					 	 rangelength:jQuery.validator.format("密码长度应为{6}~ {18}个字符")
				 },
				 maxProducer:{
						number:"请输入合法的数字",
						max:jQuery.validator.format("请输入一个最大为{0} 的值"),
						min:jQuery.validator.format("请输入一个最小为{0} 的值"),
						digits:"只能输入整数"
				 },
				 mqsCheck:"请同意MQS开通协议"
				 
			 },
			 errorPlacement: function (error, element) {
             	$("#"+$(element).attr("id")+"_error").text($(error).text());
                 $(element).css("border-color", "rgb(249, 135, 135)");
             },
			
		});
		
		
		
	});
	/*定义页面管理类*/
	(function(){
		$.OpenMSQController  = function(){ 
			this.settings = $.extend(true,{},$.OpenMSQController.defaults); 
			this.init();
			
		};
		$.extend($.OpenMSQController,{
			defaults : {
					ADVANCED_BTN : "#advanced_btn",
					MESSAGE_SAVE_BTN:"#message_save_btn",
					MQSCHECK:"#mqsCheck"
					
			     	   
			},
			prototype : {
				init : function(){
					var _this = this;
					_this.addRults();
					_this.bindEvents();				
				},
				bindEvents : function(){
					var _this = this;
					$(_this.settings.ADVANCED_BTN).bind("click",function(){
						$("#advanced_list").slideToggle();
					});
					
					$(_this.settings.MQSCHECK).bind("click",function(){
						if($("#mqsCheck").is(":checked")){
							$("#message_save_li").show();
							$("#message_save_li_none").hide();
						}else{
							$("#message_save_li").hide();
							$("#message_save_li_none").show();
						}
					});
					$(_this.settings.MESSAGE_SAVE_BTN).bind("click",function(){
						if(!$("#messageForm").valid()){
							return;
						};
						var param = $("#messageForm").serialize();
						var url = "saveMessage";
						$('.waitCover').show();
						$.post(url,param,function(json){
							
							if(json&&json.resultCode=="0000"){
								//location.href="${_base}/mcs/applyCompleted?prod=MDS";
								location.href=getContextPath() +"/mcs/applyCompleted?prod=MDS";  //&url=/mds/addMessage&prodType=1
								$('.waitCover').hide();
							}else{									
								alert(json.resultMessage);
								$('.waitCover').hide();
							}
						})
						
					});
					
				},			
				addRults : function() {				
					
				}
			}
		});
	})(jQuery);
	</script>
</head>

<body>
   <script>
   	$(document).ready(function(){
   		$('a[id^=active_]').each(function(){
   			$(this).css('color', '#949494');
   		});
   		$('#active_prod').css('color', '#1699dc');
//    		$('.mune_2').css('padding-left', '1%');
   		
   	});
   </script>
<!-- 遮盖层 -->
<div class="waitCover">
	<img  src="${_base }/resources/images/waitPng.png" class="waitPng" >
	<div class="waitTxt">正在加载请稍后...</div>
</div>
<!-- 头部和导航条 -->
  <div class="big_k"><!--包含头部 主体-->  
   <!--导航-->
   <div class="navigation">
		<%@ include file="/jsp/common/header.jsp"%>
	</div>
  <div class="container chanp">
	 	<div class="row chnap_row">
    <%@ include file="/jsp/common/leftMenu_new.jsp"%>
  <div class="col-md-6 right_list">
     	<div class="Open_cache">
	        <div class="Open_cache_table">
	        	<ul>
	        		<li><a>开通消息中心MDS</a></li>
	        	</ul>
        	</div>
        	<form:form modelAttribute="messageInfo" id="messageForm" action="">
        	<div class="Open_cache_list">
	          <div class="Open_cache_list_tow">
	          	  <ul>
			          <li class="font-title">产品名称：</li>
			          <li>消息中心MDS</li>
		          </ul>
		          <ul>
			          <li class="font-title">服务名称：</li>
			          <li><form:input path="queueName" type="text" cssClass="form-control"></form:input></li>
			          <li><label style="color:red;" id="queueName_error" for="queueName"></label></li>
		          </ul>
		          <ul>
			          <li class="font-title">服务密码：</li>
			          <li><form:input path="queuePwd" type="text" cssClass="form-control"></form:input></li>
			          <li><label style="color:red;" id="queuePwd_error" for="queuePwd"></label></li>
		          </ul>
		          <ul>
			          <li class="font-title">消息分片：</li>
			          <li>
			          		<select id="partitions"  name="partitions" class="form-control">
			          			<c:forEach items="${optionList }" var="optionVo">
			          				<option value="${optionVo.serviceValue }">${optionVo.serviceOption }</option>
			          			</c:forEach>
	          				</select>
			          </li>
		          </ul>
		            <ul  style="padding-left:10%">
	          		<li id="message_save_li" >
	          			<a id="message_save_btn" href="#"><div style="margin-top:20px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(121,189,90);line-height:30px;vertical-align:middle;color:#fff">立即开通</div></a>
	          		</li>
		          	</ul>
	           </div>
	        </div>
	        </form:form>
    	</div>      
  	</div>
</div>
</div>
</div>
<%@ include file="/jsp/common/footer_new.jsp"%>

</body>
</html>
