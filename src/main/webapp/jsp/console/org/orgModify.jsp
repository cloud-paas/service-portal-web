<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
<%@ include file="/jsp/common/common.jsp"%>

<script type="text/javascript">
var timeStamp = "${timeStamp}";
var dssController;
$(document).ready(function(){
	orgCenterController = new $.orgCenterController();
});

var orgId = "${orgnizeInfo.orgId}";

/*定义页面管理类*/
(function(){
	$.orgCenterController  = function(){ 
		this.settings = $.extend(true,{},$.orgCenterController.defaults); 
		this.init();
		
	};
	$.extend($.orgCenterController,{
		defaults : { 
			ORGCODE : "#orgCode",		
			ORGNAME : "#orgName",	
			ORGSTATUS : "#orgStatus",	
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
						var orgCode = $("#orgCode").val();	
						var orgName = $("#orgName").val();
						var orgStatus = $("#orgStatus").val();
						$.ajax({
							async : false,
							type : "POST",
							url : "${_base}/orgConsole/updateOrgnize",
							modal : true,
							showBusi : false,
							data : {									
								orgId	: orgId,
								orgCode : orgCode,
								orgName : orgName,
								orgStatus: orgStatus
							},
							success: function(data){
								var json=data
								if(json&&json.resultCode=="000000"){
									location.href="${_base}/orgConsole/modifyOrgSuccess?orgId="+orgId+"&parentUrl="+parentUrl+"&orgCode="+orgCode;
								}else{									
									$("#modify_error").text(json.resultMessage);
								}
							}
						});
					} 
						
				});	
				$(_this.settings.ORGCODE).bind("click",function(){					 
					$("#modify_error").text("");
				});
				$(_this.settings.ORGNAME).bind("click",function(){					
					$("#modify_error").text("");
				});
				$(_this.settings.ORGSTATUS).bind("click",function(){
					$("#modify_error").text("");
				});
			},			
			addRults : function() {				
			    var myForm = $("#myForm");		
			    myForm.validate({
	                rules: {
	                	orgCode: {
	                        required: true,
	                        rangelength:[1,20]
	                    }, 		                  
	                    orgName: {
	                    	required: true,
	                    	rangelength:[1,200]
	                    },	                    		                  
	                },
	                messages:{
	                	orgCode:{
	                		required:"組織編碼不能为空",
	                		rangelength:"请输入1~20位組織編碼"
	                	},
	                	orgName:{
	                		required:"組織名稱不能为空",
	                		rangelength:"请输入1~200位組織名稱"
	                	}，	                	
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
			<li><a href="#">修改組織</a></li> 
			</ul>  
        </div> 
		<div class="Open_cache_table" style="background:rgb(245,245,245);height:30px;vertical-align:middle ;line-height:30px;padding-left:1%">
			 <span>組織ID：</span>
			 <span style="color:rgb(22,154,219)">${orgnizeInfo.orgId}</span>
		</div>
		
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
				<div class="Open_cache_list_tow" style="vertical-align:middle; padding:0px 0px 0px 20px">
	          		 <table style="vertical-align:middle">
						<tr>
							<td class='font_title_edit'>組織編碼&nbsp;&nbsp;：</td>
							<td> 
								<div class="form-group" style="padding-top:5%">  
									 <input type="text" class="form-control" id="orgCode" name="orgCode" value=${orgnizeInfo.orgCode} style="width:300px">
								</div>
							</td>
							<td><label style="color:red; margin-left:20px" id="orgCode"/></td>
						</tr>
						<tr>
							<td class='font_title_edit'>組織名稱&nbsp;&nbsp;：</td>
							<td>
								<div class="form-group" style="padding-top:5%">  
									 <input type="text" class="form-control" id="orgName" name="orgName" value=${orgnizeInfo.orgName}  style="width:300px">
								 </div>
							</td>
							<td><label style="color:red; margin-left:20px" id="orgName"/></td>
						</tr>
						<tr>
							<td class='font_title_edit'>組織狀態&nbsp;&nbsp;：</td>
							<td>
								<div class="form-group" style="padding-top:5%">  
									 <input type="radio" class="form-control" id="orgStatus" name="orgStatus" value="1"/>有效
									 <input type="radio" class="form-control" id="orgStatus" name="orgStatus" value="2"/>無效
								 </div>
								 <script>if (${orgnizeInfo.orgStatus}==1) {document.getElementsByName("orgStatus")[1].checked="checked";}
								 else {document.getElementsByName("orgStatus")[2].checked="checked";}
								 </script>
							</td>
							<td><label style="color:red;margin-left:20px" id="orgStatus"/></td>
						</tr>						
					 </table> 
	           </div> 
	           <div class="Open_cache_list_tow" style="vertical-align:middle; line-height:5px; padding:0px 0px 0px 0px">
	          	 <label style="color:red;margin-left:80px;" id="modify_error" ></label>	          		 
	           </div>    		
				<div class="Open_cache_list_tow" style="vertical-align:middle;line-height:32px;padding:10px 0px 0px 75px">
				
					<a href="#" id="modify_button" style="float:left">
						<div style="margin:10px 0px 0px 0px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:32px;background:rgb(119,189,90);line-height:32px;vertical-align:middle;font-size:14px;font-weight:800;border:solid 1px rgb(204,204,204);color:#fff">修改</div>
					</a>
				    <a href="${_base}/orgConsole/toOrgConsole" style="float:left">
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
