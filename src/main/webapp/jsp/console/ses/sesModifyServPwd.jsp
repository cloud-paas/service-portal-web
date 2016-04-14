<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
<%@ include file="/jsp/common/common.jsp"%>

<script type="text/javascript">
var timeStamp = "${timeStamp}";
var dssController;
$(document).ready(function(){
	dssController = new $.dssController();
});

var userServId = "${userProdInstVo.userServId}";

/*定义页面管理类*/
(function(){
	$.dssController  = function(){ 
		this.settings = $.extend(true,{},$.dssController.defaults); 
		this.init();
		
	};
	$.extend($.dssController,{
		defaults : { 
			OLDPWD : "#oldPwd",		
			NEWPWD : "#newPwd",	
			RECONFIRM : "#reconfirm",	
			MODIFY_BUTTON : "#modify_button"
		},
		prototype : {
			init : function(){
				var _this = this;
				_this.addRults();
				_this.bindEvents();				
			},
			bindEvents : function(){
				var _this = this;
				$(_this.settings.MODIFY_BUTTON).bind("click",function(){
					if ($("#myForm").valid()){	
						var oldPwd = $("#oldPwd").val();	
						var newPwd = $("#newPwd").val();
						$.ajax({
							async : false,
							type : "POST",
							url : "${_base}/dssConsole/modifyDssServPwd",
							modal : true,
							showBusi : false,
							data : {									
								userServId	: userServId,
								oldPwd : oldPwd,
								newPwd : newPwd
								
							},
							success: function(data){
								var json=data
								if(json&&json.resultCode=="000000"){
									location.href="${_base}/dssConsole/modifyDssServPwdSubbess?timeStamp="+timeStamp+"&parentUrl="+parentUrl+"&productType=1";
								}else{									
									$("#modify_error").text(json.resultMessage);
								}
							}
						});
					} 
						
				});	
				$(_this.settings.OLDPWD).bind("click",function(){					 
					$("#modify_error").text("");
				});
				$(_this.settings.NEWPWD).bind("click",function(){					
					$("#modify_error").text("");
				});
				$(_this.settings.RECONFIRM).bind("click",function(){
					$("#modify_error").text("");
				});
			},			
			addRults : function() {				
			    var myForm = $("#myForm");		
			    myForm.validate({
	                rules: {
	                	oldPwd: {
	                        required: true,
	                        rangelength:[6,18]
	                    }, 		                  
	                    newPwd: {
	                    	required: true,
	                    	rangelength:[6,18]
	                    },	                    		                  
	                    reconfirm: {
	                    	required: true,
	                    	rangelength:[6,18],
	                    	equalTo: "#newPwd"	                    	
	                    }
	                },
	                messages:{
	                	oldPwd:{
	                		required:"旧密码不能为空",
	                		rangelength:"请输入6~18位旧服务密码"
	                	},
	                	newPwd:{
	                		required:"新服务密码不能为空",
	                		rangelength:"请输入6~18位新服务密码"
	                	},
	                	reconfirm:{
	                		required:"新服务密码确认不能为空",
	                		rangelength:"请输入6~18位新服务密码确认",
	                		equalTo: "两次输入密码不一致"	                		
	                	}
	                	
	                },
	                success: function (label, element) {
	                },
	                errorPlacement: function (error, element) {
	                	$("#"+$(element).attr("id")+"_error").text($(error).text());
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
  
</head> 
<body>     
  <div class="big_k"><!--包含头部 主体-->   
   <!--导航-->
   <%@ include file="/jsp/common/header_console.jsp"%>
      
   <div class="container chanp">
   <%@ include file="/jsp/common/leftMenu_console.jsp"%>
  <div class="row chnap_row">
  
  <div class="col-md-6 right_list">
     <form id="myForm">
     <div class="Open_cache">
        <div class="Open_cache_table">
			<ul>
			<li><a href="#">${userProdInstVo.prodName}</a></li> 
			</ul>  
        </div> 
		<div class="Open_cache_table" style="background:rgb(245,245,245);height:30px;vertical-align:middle ;line-height:30px;padding-left:1%">
			 <span>服务名称：</span>
			 <span style="color:rgb(22,154,219)">${userProdInstVo.serviceName}</span>
			 <span style="margin-left:10px">服务编码：</span>
			 <span style="color:rgb(22,154,219)">${userProdInstVo.userServIpaasId}</span>
			<!--  <span> ${userProdInstVo.userServId}</span>  -->
		</div>
		
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
				<div class="Open_cache_list_tow" style="vertical-align:middle; padding:0px 0px 0px 20px">
	          		 <table style="vertical-align:middle">
						<tr>
							<td class='font_title_edit'>原&nbsp;&nbsp;密&nbsp;&nbsp;码：</td>
							<td> 
								<div class="form-group" style="padding-top:5%">  
									 <input type="text" class="form-control" id="oldPwd" name="oldPwd" style="width:300px">
								</div>
							</td>
							<td><label style="color:red; margin-left:20px" id="oldPwd_error"/></td>
						</tr>
						<tr>
							<td class='font_title_edit'>新&nbsp;&nbsp;密&nbsp;&nbsp;码：</td>
							<td>
								<div class="form-group" style="padding-top:5%">  
									 <input type="text" class="form-control" id="newPwd" name="newPwd"  style="width:300px">
								 </div>
							</td>
							<td><label style="color:red; margin-left:20px" id="newPwd_error"/></td>
						</tr>
						<tr>
							<td class='font_title_edit'>密码确认：</td>
							<td>
								<div class="form-group" style="padding-top:5%">  
									 <input type="text" class="form-control" id="reconfirm" name="reconfirm" style="width:300px">
								 </div>
							</td>
							<td><label style="color:red;margin-left:20px" id="reconfirm_error"/></td>
						</tr>						
					 </table> 
	           </div> 
	           <div class="Open_cache_list_tow" style="vertical-align:middle; line-height:5px; padding:0px 0px 0px 0px">
	          	 <label style="color:red;margin-left:80px;" id="modify_error" ></label>	          		 
	           </div>    		
				<div class="Open_cache_list_tow" style="vertical-align:middle;line-height:32px;padding:10px 0px 0px 75px">
				
					<a href="#" id="modify_button" style="float:left">
						<div style="margin:10px 0px 0px 0px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:32px;background:rgb(119,189,90);line-height:32px;vertical-align:middle;font-size:14px;font-weight:800;border:solid 1px rgb(204,204,204);color:#fff">确认</div>
					</a>
				    <a href="${_base}/sesConsole/toSesConsole" style="float:left">
				    	<div style="margin:10px 0px 0px 50px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:32px;background:rgb(230,230,230);line-height:32px;vertical-align:middle;color:#000;font-size:14px;font-weight:800;border:solid 1px rgb(204,204,204)">返回</div>
				    </a>
	           </div> 			   
    	</div>   
     </div> 
     </div>
   </form>
</div>
</div>
</div>
</div>

<!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
 
  </body>
</html>
