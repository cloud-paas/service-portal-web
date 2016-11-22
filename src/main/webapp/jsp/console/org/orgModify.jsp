<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
<%@ include file="/jsp/common/common.jsp"%>

<script type="text/javascript">
var orgId = ${orgnizeCenterVo.orgId};
var orgStatus;
var orgCenterController;
$(document).ready(function(){
	orgCenterController = new $.orgCenterController();
});

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
						if (document.getElementsByName("orgStatus")[0].checked) {
							orgStatus = 1;
						} else {
							orgStatus = 0;
						}

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
									location.href="${_base}/orgConsole/modifyOrgSuccess?orgId="+orgId+"&orgCode="+orgCode;
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
	                		required:"组织编码不能为空",
	                		rangelength:"请输入1~20位组织编码"
	                	},
	                	orgName:{
	                		required:"组织名称不能为空",
	                		rangelength:"请输入1~200位组织名称"
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
   <div class="navigation" style="background:rgb(22,154,219); height:70px">
  <div class="head">
				<div style="width: 100%; height: auto">
					<div style="float: left; width: 13%; position: relative; left: 3%">
						<img src="${_base }/resources/images/logo-white2.png"
							style="position: relative; margin: 20px 20px 0px 0px;height:35px">
					</div>
					<div class="mune_lan"  style="padding-top:1.5%;">
						<ul>
                        <li  class="yon_wnz" style="margin-left:20px;font-size:20px;margin-top:0px;" ><a href="#" onclick="changeHref()" title="返回首页"><img style="height:30px;padding-bottom:5px"  src="${_base }/resources/images/return.png"/></a></li> 
						<li class="yon_wnz"   style="padding-bottom:5px;margin-left:40px;font-size:20px;">服务申请审核</li> 
						</ul>
						<ul style="float:right">
							<li id="loginName" class="yonhz"></li>   
						</ul>
					</div> 
				</div>
			</div>
   </div>    
   <div class="container chanp">
  <div class="row chnap_row">
  
  <div class="col-md-6 left_list" >
      <div class="list_groups">
          <div class="list_groups_none">
             
            <ul>
              <li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(6,2,this);">
               <a href="#" style="color:#fff">
                <p  id="img2">服务申请审核</p>
               </a>
              </li>
              <li class="list_xinx"  id="content2" >
                <p class="xuanz"><A href="${_base }/apply/applyAudit"><span style="margin-top:2px;">服务申请审核</span></A></p>        
              </li>
            </ul>             
            <ul>
             <li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(6,3,this);">
               <a href="#" style="color:#fff">
                 <p  id="img2">组织管理</p>
               </a>
             </li>
             <li class="list_xinx"  id="content3" >
                <p class="xuanz"><A href="${_base }/orgConsole/toOrgConsole"><span style="margin-top:2px;">组织管理</span></A></p>
             </li>
            </ul>
          </div> 
    </div>
  
  </div>
  
  <div class="col-md-6 right_list">
     <form id="myForm">
     <div class="Open_cache">
        <div class="Open_cache_table">
			<ul>
			<li><a href="#">修改组织</a></li> 
			</ul>  
        </div> 
		<div class="Open_cache_table" style="background:rgb(245,245,245);height:30px;vertical-align:middle ;line-height:30px;padding-left:1%">
			 <span>组织ID：</span>
			 <span style="color:rgb(22,154,219)">${orgnizeCenterVo.orgId}</span>
		</div>
		
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
				<div class="Open_cache_list_tow" style="vertical-align:middle; padding:0px 0px 0px 20px">
	          		 <table style="vertical-align:middle">
						<tr>
							<td class='font_title_edit'>组织编码&nbsp;&nbsp;：</td>
							<td> 
								<div class="form-group" style="padding-top:5%">  
									 <input type="text" class="form-control" id="orgCode" name="orgCode" value=${orgnizeCenterVo.orgCode} style="width:300px">
								</div>
							</td>
							<td><label style="color:red; margin-left:20px" id="orgCode"/></td>
						</tr>
						<tr>
							<td class='font_title_edit'>组织名称&nbsp;&nbsp;：</td>
							<td>
								<div class="form-group" style="padding-top:5%">  
									 <input type="text" class="form-control" id="orgName" name="orgName" value=${orgnizeCenterVo.orgName}  style="width:300px">
								 </div>
							</td>
							<td><label style="color:red; margin-left:20px" id="orgName"/></td>
						</tr>
						<tr>
							<td class='font_title_edit'>组织状态&nbsp;&nbsp;：</td>
							<td>
								<div class="form-group" style="padding-top:5%">  
									<input type="radio"  id="orgStatus" name="orgStatus" value="1" style="width:10px"/>&nbsp;有效
									&nbsp;&nbsp;&nbsp;
									<input type="radio"  id="orgStatus" name="orgStatus" value="0" style="width:10px"/>&nbsp;无效									 
								</div>
								 <script>
								 if (${orgnizeCenterVo.orgStatus}==1) {
									 document.getElementsByName("orgStatus")[0].checked="checked";
								 }
								 else {
									 document.getElementsByName("orgStatus")[1].checked="checked";
								 }								 
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
