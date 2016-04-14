<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
<%@ include file="/jsp/common/common.jsp"%>


  
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
			 <span style="color:rgb(22,154,219)" id="userServIpaasId">${userProdInstVo.userServIpaasId}</span>
			 <input type="hidden" id="ServId" value="${userProdInstVo.userServId}">
		</div>
		
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
	          	<div class="Open_cache_list_tow" style="vertical-align:middle;line-height:30px">  
				<div class="Open_cache_list_tow" style="vertical-align:middle; padding:0px 0px 0px 20px">
	          		 <ul>
			          <li class="font-title" style="margin-left:27px;">总容量：</li>				          
			          <li >			          
			          		<select id="capacity" name="capacity"  class="ch_select" >
									<c:forEach items="${capacityList}" var="optionVo">
										<c:if test="${optionVo.value==capacity}">
										<option value="${optionVo.value }" selected="selected">${optionVo.code }</option>
										</c:if> 
										<c:if test="${optionVo.value!=capacity}">
										<option value="${optionVo.value }">${optionVo.code }</option>
										</c:if> 
									</c:forEach>								
								</select>
										          
			          </li>	
			           <li  style="padding-top:0.5%;font-size:18px;font-weight:400">M</li>			          		          
		          	</ul>
		          	<ul>
			          <li class="font-title">单文件大小：</li>				          
			          <li class="font-title">			          
			          		<select id="singleFileSize" name="singleFileSize" class="ch_select" >
								<c:forEach items="${fileSizeList }" var="optionVo">
									<c:if test="${optionVo.value==singleFileSize}">
										<option value="${optionVo.value }" selected="selected">${optionVo.code }</option>
									</c:if> 
									<c:if test="${optionVo.value!=singleFileSize}">
										<option value="${optionVo.value }">${optionVo.code }</option>
									</c:if> 
										
								</c:forEach> 
							</select>	          
			          </li>	
			          <li  style="padding-top:0.5%;font-size:18px;font-weight:400">M</li>			          
		          	</ul>
	           </div> 
	           <div class="Open_cache_list_tow" style="vertical-align:middle; line-height:0px; padding:0px 0px 0px 0px">
	          	 <label style="color:red;margin-left:80px;" id="modify_error"></label>	          		 
	           </div>    		
				<div class="Open_cache_list_tow" style="vertical-align:middle;line-height:30px;padding:20px 0px 0px 75px">
				
					<a href="#" id="modify_button" style="float:left">
						<div style="margin:10px 0px 0px -20px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:32px;background:rgb(119,189,90);line-height:30px;vertical-align:middle;font-size:14px;font-weight:800;border:solid 1px rgb(204,204,204);color:#fff" onclick="modifyConfiguration()">修改</div>
					</a>
				    <a href="#" onclick="history.go(-1)" style="float:left">
				    	<div style="margin:10px 0px 0px 30px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:32px;background:rgb(230,230,230);line-height:30px;vertical-align:middle;color:#000;font-size:14px;font-weight:800;border:solid 1px rgb(204,204,204)">返回</div>
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
 <script type="text/javascript">
  
 	function modifyConfiguration(){
 		 
 		
 		var userservId=$("#ServId").val();
 		var capacity=$("#capacity").val();
 		var singleFileSize=$("#singleFileSize").val();
 		var iPaasId=$("#userServIpaasId").text();
 		$.ajax({
 			url:getContextPath()+"/dssConsole/modifyConfiguration",
 			type:"POST",
 			data:{
 				userServId:userservId,
 				userServIpaasId:iPaasId,
 				size:capacity,
 				limitFileSize:singleFileSize
 			},
 			success:function(data){
 				if(data.resultCode=="000000"){
 					 Modal.alert({
 						msg : "DSS服务扩容成功"
 				 }).on(function(){
 					 location.href="${_base}/dssConsole/toDssConsole";
 				 });
 				}else{
 					 Modal.alert({
  						msg :  data.resultMsg
  				 });
 				}
 			}
 		})  
 	}
 
 </script>
  </body>
</html>
