<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="/spring-form" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<title>MQS开通</title>
<style>
label.error {
  color: red;
  font-style: italic;
}
</style>
<script>
	var OpenMSQController;
	jQuery.validator.addMethod("largerTarget", function(value, element, target) {
	  return this.optional(element) || ( parseInt(value) >= parseInt($(target).val()));   
	}, $.validator.format("最大并发数只能递增"));
	
	$(document).ready(function(){
		OpenMSQController = new $.OpenMSQController();
		if($("#mqsCheck").is(":checked")){
			$("#message_save_li").show();
			$("#message_save_li_none").hide();
		}else{
			$("#message_save_li").hide();
			$("#message_save_li_none").show();
		}
		$("#messageForm").validate({
			onkeyup:false,
			rules: {
				queueName: {
					required:true,
					rangelength:[2,20]
				},
				partitions:{
					required:true,
					number:true,
					max:20,
					min:2,
					largerTarget:"#desPartitions",
					digits:true
					
				},
				maxProducer:{
					number:true,
					max:5,
					min:1,
					digits:true
				}
			},
			 messages: {
				 queueName: {
					 required:"请输入队列名称",
					 rangelength:jQuery.validator.format("队列名称必须介于 {0}和 {1} 之间的字符串")
				 },
				 partitions:{
					 	required:"请输入最大并发数",
						number:"请输入合法的数字",
						max:jQuery.validator.format("请输入一个最大为{0} 的值"),
						min:jQuery.validator.format("请输入一个最小为{0} 的值"),
						digits:"只能输入整数"
				 },
				 maxProducer:{
						number:"请输入合法的数字",
						max:jQuery.validator.format("请输入一个最大为{0} 的值"),
						min:jQuery.validator.format("请输入一个最小为{0} 的值"),
						digits:"只能输入整数"
				 }
			 }
			
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
					MESSAGE_UPDATE_BTN:"#message_update_btn",
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
					$(_this.settings.MESSAGE_UPDATE_BTN).bind("click",function(){
						if(!$("#messageForm").valid()){
							return;
						};
						var param = $("#messageForm").serialize();
						var url = "messageUpdate";
						$.post(url,param,function(data){
							if(data.result==1){
								alert("保存成功");
								var reloadUrl = "messageManage";
								window.location.href=reloadUrl;
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
<!-- 头部和导航条 -->
<div class="container chanp"><div class="row">  <div class="navigation"><%@ include file="/jsp/common/header.jsp"%></div></div>
   
<div class="row chnap_row">
	<%@ include file="/jsp/common/leftMenu.jsp"%>
  
  	<div class="col-md-6 right_list">
     
     	<div class="Open_cache">
	        <div class="Open_cache_table">
	        	<ul>
	        		<li><a href="#">消息队列服务MQS开通</a></li>
	        	</ul>
        	</div>
        	<form:form modelAttribute="messageInfo" id="messageForm" action="">
        	<div class="Open_cache_list">
	          <div class="Open_cache_list_none">
		          <p><img src="${_base }/resources/images/icon10.png"></p>
		          <p style=" margin-top:2px;">开通需申请公测资格。</p>
	          </div>
	          <div class="Open_cache_list_tow">
		          <ul>
			          <li class="lef_zi">队列名称：</li>
			          <li>
			          	<form:input path="queueName" type="text" cssClass="pei_input"></form:input>
			          	<form:hidden path="queueId"/>
			          	<form:hidden path="queueNameEn"/>
			          	
			          </li>
		          </ul>
		          <ul>
			          <li class="lef_zi">最大并发数：</li>
			          <li>
			          	<form:input path="partitions" cssClass="pei_input"></form:input>
			          	<input  type="hidden" id="desPartitions" value="${messageInfo.partitions }">
			          </li>
		          </ul>
		          <ul>
			          <li class="lef_zi">最大生产者数：</li>
			          <li><form:input path="maxProducer" cssClass="pei_input"></form:input></li>
		          </ul>
	           </div>
	        </div>
	        	<div class="Open_cache_list_tow">
		           <ul>
			          	<li><input name="mqsCheck" id="mqsCheck" type="checkbox" value="Y" class="peiz_checkbox ">我已阅读并同意 消息服务MQS开通协议</li>
		          	</ul>
		            <ul>
		          		<li class="open_btn" id="message_save_li" style="display:none"><A href="javascript:void(0)" id="message_update_btn">立即开通</A></li>
		          		<li class="open_btn" id="message_save_li_none"><A href="javascript:void(0)" style="background: none repeat scroll 0 0 #666;" id="">立即开通</A></li>
		          	</ul>
	         	</div>
	        </form:form>
    	</div>      
  	</div>
</div>
<%@ include file="/jsp/common/footer.jsp"%>

</body>
</html>
