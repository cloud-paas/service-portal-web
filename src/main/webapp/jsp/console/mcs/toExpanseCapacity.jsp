<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
<%@ include file="/jsp/common/common.jsp"%>

<script src="${_base }/resources/js/common/commonUtils.js"></script>
<script type="text/javascript">
var timeStamp = "${timeStamp}";
var mcsController;
$(document).ready(function(){
	mcsController = new $.mcsController();
});


/*定义页面管理类*/
(function(){
	$.mcsController  = function(){ 
		this.settings = $.extend(true,{},$.mcsController.defaults); 
		this.init();
		
	};
	$.extend($.mcsController,{
		defaults : { 
			MODIFY_BUTTON : "#modify_button"
		},
		prototype : {
			init : function(){
				var _this = this;
				_this.bindEvents();				
			},
			bindEvents : function(){
				var _this = this;
				$(_this.settings.MODIFY_BUTTON).bind("click",function(){	
						var capacity = $("#capacity").val();
						var prodParam = '${userProdInstVo.userServParam}';
						var userServIpaasId = "${userProdInstVo.userServIpaasId}";
						var userServId = "${userServId}";
						$.ajax({
							async : false,
							type : "POST",
							url : "${_base}/mcs/expenseCache",
							modal : true,
							showBusi : false,
							data : {									
								capacity : capacity	,
								prodParam : prodParam,
								userServIpaasId : userServIpaasId,
								userServId : userServId
							},
							success: function(data){
								var json=data
								if(json&&json.resultCode=="0000"){
									var parentUrl = "${_base}/mcsConsole/toMcsConsole";
									postRequest('${_base}/mcsConsole/expanseCapacitySuccess', {
										parentUrl : parentUrl
									});
								}else{
									$("#modify_error").text("修改密码错误，请确认原密码是否输入错误");
								}
							}
						});					 
						
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
			<li><a href="javascript:;">${userProdInstVo.prodName}</a></li> 
			</ul>  
        </div> 
		<div class="Open_cache_table" style="background:rgb(245,245,245);height:30px;vertical-align:middle ;line-height:30px;padding-left:1%">
			 <span>服务名称：</span>
			 <span style="color:rgb(22,154,219)">${userProdInstVo.serviceName}</span>
			 <span style="margin-left:10px">服务编码：</span>
			 <span style="color:rgb(22,154,219)">${userProdInstVo.userServIpaasId}</span>			
		</div>
		
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
	          	<div class="Open_cache_list_tow" style="vertical-align:middle;line-height:30px">  
				<div class="Open_cache_list_tow" style="vertical-align:middle; padding:0px 0px 0px 20px">
	          		 <table style="vertical-align:middle">
						<tr>
							<td class='font_title_edit'>缓&nbsp;存&nbsp;容&nbsp;量：</td>
							<td> 
								<div class="form-group" style="padding-top:5%">  
									 <select id="capacity"  name="capacity" style="margin-top:10px;margin-left:10px;">
	          							<c:forEach items="${capacityList}" var="capacity">
	          								<option value="${capacity.serviceValue}">${capacity.serviceOption}</option>
	          							</c:forEach>
	          						</select>
								</div>
							</td>
							<td><label style="color:red; margin-left:20px" id="oldPwd_error"/></td>
						</tr>										
					 </table> 
	           </div> 
	           <div class="Open_cache_list_tow" style="vertical-align:middle; line-height:0px; padding:0px 0px 0px 0px">
	          	 <label style="color:red;margin-left:80px;" id="modify_error"></label>	          		 
	           </div>    		
				<div class="Open_cache_list_tow" style="vertical-align:middle;line-height:30px;padding:20px 0px 0px 75px">
				
					<a href="javascript:;" id="modify_button" style="float:left">
						<div style="margin:10px 0px 0px 0px;text-align:center;vertical-align:middle;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:32px;background:rgb(119,189,90);line-height:30px;vertical-align:middle;font-size:14px;font-weight:800;border:solid 1px rgb(204,204,204);color:#fff">确认</div>
					</a>
				    <a href="${_base}/mcsConsole/toMcsConsole" style="float:left">
				    	<div style="margin:10px 0px 0px 50px;text-align:center;vertical-align:middle;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:32px;background:rgb(230,230,230);line-height:30px;vertical-align:middle;color:#000;font-size:14px;font-weight:800;border:solid 1px rgb(204,204,204)">返回</div>
				    </a>
	           </div> 			   
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
