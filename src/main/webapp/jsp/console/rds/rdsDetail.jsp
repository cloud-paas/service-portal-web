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
			 <span style="color:rgb(22,154,219)">${userProdInstVo.prodName}</span>
			 <span style="margin-left:10px">服务编码：</span>
			 <span style="color:rgb(22,154,219)" id="userServIpaasId">${userProdInstVo.userServIpaasId}</span>
		</div>
		
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
	          	<div class="Open_cache_list_tow" style="vertical-align:middle;line-height:30px">  
	          	<div class="Open_cache_list_tow" style="vertical-align:middle; padding:0px 0px 0px 20px">主节点信息：</div>
				<div class="Open_cache_list_tow" style="vertical-align:middle; padding:0px 0px 0px 20px">
	          		 <ul>
			          <li class="font-title" style="margin-left:27px;">IP地址：</li>				          
			          <li >			          
									${userProdInstVo.userServBackParamMap.incSimList[0].incIp}
			          </li>	
			          </ul>
			           <ul>
			          <li class="font-title" style="margin-left:27px;">实例id：</li>				          
			          <li >			          
									${userProdInstVo.userServBackParamMap.incSimList[0].id}
			          </li>	
			          </ul>
			           <ul>
			           <li class="font-title" style="margin-left:27px;">用户名：</li>				          
			          <li >			          
									${userProdInstVo.userServBackParamMap.incSimList[0].rootName}
			          </li>	
			          </ul>
			          <ul>
			          <li class="font-title" style="margin-left:27px;">密码：</li>				          
			          <li >			          
									${userProdInstVo.userServBackParamMap.incSimList[0].rootPassword}
			          </li>	
			          </ul>
			          <ul>
			          <li class="font-title" style="margin-left:27px;">端口：</li>				          
			          <li >			          
									${userProdInstVo.userServBackParamMap.incSimList[0].incPort}
			          </li>	
			          </ul>
			          <ul>
			          <li class="font-title" style="margin-left:27px;">主实例名称：</li>				          
			          <li >			          
									${userProdInstVo.userServBackParamMap.incSimList[0].incName}
			          </li>	
		          	 </ul>
	           </div> 
	           <div class="Open_cache_list_tow" style="vertical-align:middle; padding:0px 0px 0px 20px">从节点信息：</div>
				<div class="Open_cache_list_tow" style="vertical-align:middle; padding:0px 0px 0px 20px">
	          		 <ul>
			          <li class="font-title" style="margin-left:27px;">IP地址：</li>				          
			          <li >			          
									${userProdInstVo.userServBackParamMap.incSimList[1].incIp}
			          </li>	
			          </ul>
			           <ul>
			          <li class="font-title" style="margin-left:27px;">实例id：</li>				          
			          <li >			          
									${userProdInstVo.userServBackParamMap.incSimList[1].id}
			          </li>	
			          </ul>
			           <ul>
			           <li class="font-title" style="margin-left:27px;">用户名：</li>				          
			          <li >			          
									${userProdInstVo.userServBackParamMap.incSimList[1].rootName}
			          </li>	
			          </ul>
			          <ul>
			          <li class="font-title" style="margin-left:27px;">密码：</li>				          
			          <li >			          
									${userProdInstVo.userServBackParamMap.incSimList[1].rootPassword}
			          </li>	
			          </ul>
			          <ul>
			          <li class="font-title" style="margin-left:27px;">端口：</li>				          
			          <li >			          
									${userProdInstVo.userServBackParamMap.incSimList[1].incPort}
			          </li>	
			          </ul>
			          <ul>
			          <li class="font-title" style="margin-left:27px;">主实例名称：</li>				          
			          <li >			          
									${userProdInstVo.userServBackParamMap.incSimList[1].incName}
			          </li>	
		          	 </ul>
	           </div> 
	           <div class="Open_cache_list_tow" style="vertical-align:middle; line-height:0px; padding:0px 0px 0px 0px">
	          	 <label style="color:red;margin-left:80px;" id="modify_error"></label>	          		 
	           </div>    		
				<div class="Open_cache_list_tow" style="vertical-align:middle;line-height:30px;padding:20px 0px 0px 75px">
				
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

 </script>
  </body>
</html>
