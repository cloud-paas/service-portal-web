<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
  <head>
<%@ include file="/jsp/common/common.jsp"%>
   <style>
   		.tab-change{width:100%;height:40px;line-height:40px;background:#EEEEEE;clear:both;margin-bottom:20px;border-bottom:1px solid #169ADC;}
   		.tab-change li{float:left;width:90px;text-align:center;cursor:pointer;line-height:43px;height:40px;font-size:15px;}
   		.tab-li{background:#fff;border:1px solid #169ADC;border-bottom:1px solid #fff;}
   		.again-send,.jump{width:100px;height:35px;text-align:center;border-radius:3px;margin-top:30px;font-size:15px;}
   		.again-send{background:#0077C3;color:#fff;border:1px solid #fff;margin:0px 10px 0px 110px;}
   		.jump{background:#fff;color:#0077C3;border:1px solid #0077C3;}
   		.Open_cache{position:relative;}
   		.normal,.no-normal{position:absolute;top:120px;left:0px;}
   		.no-normal{display:none}
   </style>
</head> 
<body>     
  <div class="big_k"><!--包含头部 主体-->   
   <!--导航-->
   
   <%@ include file="/jsp/common/header_console.jsp"%>
      
   <div class="container chanp">
  <div class="row chnap_row">
   <%@ include file="/jsp/common/leftMenu_console.jsp"%>
  
  <div class="col-md-6 right_list">
     <div class="Open_cache">
        <div class="Open_cache_table">
			<ul>
			<li><a href="#">最终事务一致ATS</a></li> 
			</ul>  
        </div> 
        <ul class="tab-change">
        	<li onclick="searchUsage()" >正常</li>
        	<li onclick="searchErrorUsage()">异常</li>
        </ul>
        <div class="normal">
        	<div class="Open_cache_table" style="background:rgb(245,245,245);height:50px;vertical-align:middle ;line-height:30px;padding-left:1%">
			 <span>服务名称：</span>
			 <span style="color:rgb(22,154,219)">${usageVo.serviceName}</span>
			 <span>Paas签名：</span>
 			 <span   style="color:rgb(22,154,219)">${usageVo.signatureId}</span>
			 <span>服务编码：</span>
			 <span style="color:rgb(22,154,219)">${usageVo.userServIpaasId}</span>
			 <span>分片数：</span>
			 <span style="color:rgb(22,154,219)">${partitions} </span>
			 <input type="hidden" value="${resultCode}" id="resultCode">
			 <input type="hidden" value="${resultMessage}" id="resultMessage">
		</div> 
     	<div class="Open_cache">  
		 <form  id="searchForm" onsubmit="return false">
		 	<input type="hidden" value="${usageVo.userServIpaasId }" id="userServIpassId" name="userServIpassId"> 
	       <div class="xia_center">
	       		<div class="xia_center_left">
	       			
	       		</div>
	       		<div class="xia_center_gund">
	       			<c:forEach items="${usageVo.atsUserPageVo.topicUsage }" varStatus="i" var="usage">
	       			<c:choose>
	       			<c:when test="${i.index == 0 }">
		       			<div class="xia_center_gund_A   none_top">
		       				<div class="gund_A_shuz">P${usage.partitionId }</div>
		       				<p class="total-num" >总:${usage.totalOffset }</p>
		       				<input type="hidden" id="partitionId" name="partitionId" value="${usage.partitionId }" />
				           <input type="hidden" id="avalOffset" name="avalOffset" value="${usage.avalOffset }" />
				           <input type="hidden" id="totalOffset" name="totalOffset" value="${usage.totalOffset }" />
				           <input type="hidden" id="topicEnName" name="topicEnName" value="${usageVo.signatureId}" />
		       				<div class="gund_A_shuz_cente">
		       					<div class="gund_A_shuz_cente_top">
		       						<c:choose>
		       							<c:when test="${usage.avalOffset==0}">
		       								 <p style="position:absolute;float:left;width:100px;top:-25px">有效:${usage.avalOffset }</p>
		       							</c:when>
		       							
		       							<c:otherwise>
		       								<p style="position:absolute;width:100px;left:${(usage.avalOffset)*100/usage.totalOffset}%;top:-25px">↓有效:${usage.avalOffset}</p>
		       							</c:otherwise>
		       						</c:choose>
		       						 
		       					</div>
		       					<div class="gund_A_shuz_cente_main">
		       						<c:choose>
		       							<c:when test="${usage.avalOffset==usage.totalOffset}">
		       								<div style="float:left;width:100%;height:30px;background: #d6d6d6	"></div>	       								
		       							</c:when>
		       							<c:otherwise>
		       								<div  style="float:left;width:${(usage.avalOffset)*100/usage.totalOffset}%;height:30px;background: #d6d6d6"></div>
		       								<c:choose>
		       								<c:when test="${usage.consumedOffset+1>=usage.avalOffset }">
		       									<div style="float:left;width:${(usage.consumedOffset+1-usage.avalOffset)*100/usage.totalOffset}%;height:30px;background: #73c7f0"></div>
		       									<div style="float:left;width:${(usage.totalOffset-usage.consumedOffset-1)*100/usage.totalOffset}%;height:30px;background: #98FB98	"></div>
		       								</c:when>
		       								<c:otherwise>
		       									<div style="float:left;width:${(usage.totalOffset-usage.avalOffset)*100/usage.totalOffset}%;height:30px;background:#98FB98	"></div>
		       								</c:otherwise>
		       								</c:choose>
		       							</c:otherwise>
		       						</c:choose>
				                </div> 
				                <div class="gund_A_shuz_cente_bottom">
				                	<c:choose>
					                	<c:when test="${usage.consumedOffset+1== usage.totalOffset}">
					                		<c:choose>
					                			<c:when test="${usage.totalOffset==0 }">
					                				<p class="none_shu" style="position:absolute;left: 0%">当前:${usage.consumedOffset+1 }</p>
					                			</c:when>
					                			<c:otherwise>
					                				 <p class="none_shu" style="position:absolute;left: 98.7%">↑当前:${usage.consumedOffset+1 }</p>
					                			</c:otherwise>
					                		</c:choose>
						                   
					                		
					                	</c:when>
					                	 
					                	<c:otherwise>
					                		<p class="none_shu" style="position:absolute;left: ${(usage.consumedOffset+1)*100/usage.totalOffset}%">↑当前:${usage.consumedOffset+1}</p>
					                	</c:otherwise>
				                	
				                	</c:choose>
				                </div>
		       				</div>
		       				<div class="gund_A_xuanz" ao="${usage.avalOffset }" to="${usage.totalOffset }" p = "${usage.partitionId }"  ><A href="javascript:void(0);"><img src="${_base }/resources/images/wuli_6.png"></A></div> 	 	 
		       				
				                
		       			</div>
	       			
	       			</c:when>
	       			<c:otherwise>
		       			<div class="xia_center_gund_A">
		       			<div class="gund_A_shuz">P${usage.partitionId }</div>
		       			<p class="total-num" >总:${usage.totalOffset }</p>
		       				<div class="gund_A_shuz_cente">
		       					<div class="gund_A_shuz_cente_top">
		       						<c:choose>
		       							
		       							<c:when test="${usage.avalOffset==0}">
		       								 	<p style="position:absolute;float:left;width:100px;top:-25px">有效:${usage.avalOffset }</p>
		       							</c:when>
		       							<c:otherwise>
		       								<p style="position:absolute;width:100px;top:-25px;float:left;left:${(usage.avalOffset)*100/usage.totalOffset}%">↓有效:${usage.avalOffset}</p>
		       							</c:otherwise>
		       						</c:choose>
		       						 
		       					</div>
		       					<div class="gund_A_shuz_cente_main">
		       						<c:choose>
		       							<c:when test="${usage.avalOffset==usage.totalOffset}">
		       								<div style="float:left;width:100%;height:30px;background: #d6d6d6	"></div>	
		       							</c:when>
		       							<c:otherwise>
		       								<div  style="float:left;width:${(usage.avalOffset)*100/usage.totalOffset}%;height:30px;background: #d6d6d6"></div>
		       								<c:choose>
		       								<c:when test="${usage.consumedOffset+1>=usage.avalOffset }">
		       									<div style="float:left;width:${(usage.consumedOffset+1- usage.avalOffset)*100/usage.totalOffset}%;height:30px;background: #73c7f0"></div>
		       									<div style="float:left;width:${((usage.totalOffset-usage.consumedOffset)-1)*100/usage.totalOffset}%;height:30px;background: #98FB98	"></div>
		       								</c:when>
		       								<c:otherwise>
		       									<div style="float:left;width:${(usage.totalOffset-usage.avalOffset)*100/usage.totalOffset}%;height:30px;background:#98FB98	"></div>
		       								</c:otherwise>
		       								</c:choose>
		       							</c:otherwise>
		       						</c:choose>
				                </div> 
				                <div class="gund_A_shuz_cente_bottom">
				                	 <c:choose>
					                	<c:when test="${usage.consumedOffset+1== usage.totalOffset}">
						                  <c:choose>
					                			<c:when test="${usage.totalOffset==0 }">
					                				<p class="none_shu" style="position:absolute;left: 0%">当前:${usage.consumedOffset+1 }</p>
					                			</c:when>
					                			<c:otherwise>
					                				 <p class="none_shu" style="position:absolute;left: 98.7%">↑当前:${usage.consumedOffset+1 }</p>
					                			</c:otherwise>
					                		</c:choose>
					                		
					                	</c:when>
					                	 
					                	<c:otherwise>
					                		<p class="none_shu" style="position:absolute;left: ${(usage.consumedOffset+1)*100/usage.totalOffset}%">↑当前:${usage.consumedOffset+1}</p>
					                	</c:otherwise>
				                	
				                	</c:choose>
				                </div>
		       				</div>
				          
				          <div class="gund_A_xuanz" ao="${usage.avalOffset }" to="${usage.totalOffset }" p = "${usage.partitionId }" ><A href="javascript:void(0);"><img src="${_base }/resources/images/wuli_5.png"></A></div> 	 	 
		       			</div>
	       			</c:otherwise>
	       			</c:choose>
	       			
	       			</c:forEach>
	       		</div>
	       		<div class="xia_center_right">
	       			<div id="xuanz_search_div" class="xia_center_right_shuzi">P0</div>
	       			<div class="xia_center_right_input">
			           <ul>
			           <li class="list_ri">
			           
			           
			           <input type="hidden" id="userServId" name ="userServId" value="${usageVo.userServId }" />
			           <p><input name="offset" id="offset" type="text" value="查询分区消息内容" onkeypress="searchNormal()" ></p>
			           
			           <p><A href="javascript:void(0)"><img id="search_btn" src="${_base }/resources/images/wuli_3.png"></A></p>
			          
			           </li>
			           <li id="search_clean" class="gunb"><A><img src="${_base }/resources/images/wuli_4.png" onclick="clearinfo()" style="cursor:pointer;"></A></li>
			           </ul>
			            </div>
			          <div class="xia_center_right_shuzi xx_nrie">消息内容：</div>
			          <div class="xia_center_right_dabg">
			            <textarea name="" id="topic_msg"></textarea>
			          </div>
	       		</div>
	       </div>
	       </form>
     </div>
        </div>
		<div class="no-normal">
			<div class="Open_cache_table" style="background:rgb(245,245,245);height:50px;vertical-align:middle ;line-height:30px;padding-left:1%">
			 <span>服务名称：</span>
			 <span style="color:rgb(22,154,219)">${usageVo.serviceName}</span>
			 <span>Paas签名：</span>
 			 <span style="color:rgb(22,154,219)">${signatureId}</span>
			 <span>服务编码：</span>
			 <span style="color:rgb(22,154,219)">${usageVo.userServIpaasId}</span>
			 <span>分片数：</span>
			 <span style="color:rgb(22,154,219)">${partitions} </span>
			 <input type="hidden" value="${resultCode}" id="resultCode">
			 <input type="hidden" value="${resultMessage}" id="resultMessage">
		</div> 
     	<div class="Open_cache">  
		 <form  id="searchForm" onsubmit="return false">
		 <input type="hidden" value="${usageVo.userServIpaasId }" id="userServIpassId" name="userServIpassId"> 
	       <div class="xia_center">
	       		<div class="xia_center_left">
	       			
	       		</div>
	       		<div class="xia_center_gund">
	       			<c:forEach items="${usageVo.atsUserPageVo.topicUsage }" varStatus="i" var="usage">
	       			<c:choose>
	       			<c:when test="${i.index == 0 }">
		       			<div class="xia_center_gund_A   none_top">
		       				<div class="gund_A_shuz">P${usage.partitionId }</div>
		       				<p class="total-num" >总:${usage.totalOffset }</p>
		       				<input type="hidden" id="partitionId" name="partitionId" value="${usage.partitionId }" />
				           <input type="hidden" id="avalOffset" name="avalOffset" value="${usage.avalOffset }" />
				           <input type="hidden" id="totalOffset" name="totalOffset" value="${usage.totalOffset }" />
				           <input type="hidden" id="topicEnName" name="topicEnName" value="${usageVo.signatureId}" />
		       				<div class="gund_A_shuz_cente">
		       					<div class="gund_A_shuz_cente_top">
		       						<c:choose>
		       							
		       								 
		       							<c:when test="${usage.avalOffset==0}">
		       								 <p style="position:absolute;float:left;width:100px;top:-25px">有效:${usage.avalOffset }</p>
		       							</c:when>
		       							
		       							<c:otherwise>
		       								<p style="position:absolute;width:100px;left:${(usage.avalOffset)*100/usage.totalOffset}%;top:-25px">↓有效:${usage.avalOffset}</p>
		       							</c:otherwise>
		       						</c:choose>
		       						 
		       					</div>
		       					<div class="gund_A_shuz_cente_main">
		       						<c:choose>
		       							<c:when test="${usage.avalOffset==usage.totalOffset}">
		       								<div style="float:left;width:100%;height:30px;background: #d6d6d6	"></div>
		       							</c:when>
		       							<c:otherwise>
		       								<div  style="float:left;width:${(usage.avalOffset)*100/usage.totalOffset}%;height:30px;background: #d6d6d6"></div>
		       								<c:choose>
		       								<c:when test="${usage.consumedOffset+1>=usage.avalOffset }">
		       									<div style="float:left;width:${(usage.consumedOffset+1-usage.avalOffset)*100/usage.totalOffset}%;height:30px;background: #73c7f0"></div>
		       									<div style="float:left;width:${(usage.totalOffset-usage.consumedOffset-1)*100/usage.totalOffset}%;height:30px;background: #98FB98	"></div>
		       								</c:when>
		       								<c:otherwise>
		       									<div style="float:left;width:${(usage.totalOffset-usage.avalOffset)*100/usage.totalOffset}%;height:30px;background:#98FB98	"></div>
		       								</c:otherwise>
		       								</c:choose>
		       							</c:otherwise>
		       						</c:choose>
				                </div> 
				                <div class="gund_A_shuz_cente_bottom">
				                	<c:choose>
					                	<c:when test="${usage.consumedOffset+1== usage.totalOffset}">
					                		<c:choose>
					                			<c:when test="${usage.totalOffset==0 }">
					                				<p class="none_shu" style="position:absolute;left: 0%">当前:${usage.consumedOffset+1 }</p>
					                			</c:when>
					                			<c:otherwise>
					                				 <p class="none_shu" style="position:absolute;left: 98.7%">↑当前:${usage.consumedOffset+1 }</p>
					                			</c:otherwise>
					                		</c:choose>
						                   
					                		
					                	</c:when>
					                	 
					                	<c:otherwise>
					                		<p class="none_shu" style="position:absolute;left: ${(usage.consumedOffset+1)*100/usage.totalOffset}%">↑当前:${usage.consumedOffset+1}</p>
					                	</c:otherwise>
				                	
				                	</c:choose>
				                </div>
		       				</div>
		       				
				              <div class="gund_A_xuanz" ao="${usage.avalOffset }" to="${usage.totalOffset }" p = "${usage.partitionId }" offset="${usage.consumedOffset+1}"><A href="javascript:void(0);"><img src="${_base }/resources/images/wuli_6.png"></A></div> 	 	  
		       			</div>
	       			
	       			</c:when>
	       			<c:otherwise>
		       			<div class="xia_center_gund_A">
		       			<div class="gund_A_shuz">P${usage.partitionId }</div>
		       			<p class="total-num" >总:${usage.totalOffset }</p>
		       				<div class="gund_A_shuz_cente">
		       					<div class="gund_A_shuz_cente_top">
		       						 <c:choose>
		       							
		       							<c:when test="${usage.avalOffset==0}">
		       								 	<p style="position:absolute;float:left;width:100px;top:-25px">有效:${usage.avalOffset }</p>
		       							</c:when>
		       							<c:otherwise>
		       								<p style="position:absolute;top:-25px;width:100px;float:left;left:${(usage.avalOffset)*100/usage.totalOffset}%">↓有效:${usage.avalOffset}</p>
		       							</c:otherwise>
		       						</c:choose>
		       					</div>
		       					<div class="gund_A_shuz_cente_main">
		       						<c:choose>
		       							<c:when test="${usage.avalOffset==usage.totalOffset}">
		       								<div style="float:left;width:100%;height:30px;background: #d6d6d6	"></div>
		       							</c:when>
		       							<c:otherwise>
		       								<div  style="float:left;width:${(usage.avalOffset)*100/usage.totalOffset}%;height:30px;background: #d6d6d6"></div>
		       								<c:choose>
		       								<c:when test="${usage.consumedOffset+1>=usage.avalOffset }">
		       									<div style="float:left;width:${(usage.consumedOffset+1- usage.avalOffset)*100/usage.totalOffset}%;height:30px;background: #73c7f0"></div>
		       									<div style="float:left;width:${((usage.totalOffset-usage.consumedOffset)-1)*100/usage.totalOffset}%;height:30px;background: #98FB98	"></div>
		       								</c:when>
		       								<c:otherwise>
		       									<div style="float:left;width:${(usage.totalOffset-usage.avalOffset)*100/usage.totalOffset}%;height:30px;background:#98FB98	"></div>
		       								</c:otherwise>
		       								</c:choose>
		       							</c:otherwise>
		       						</c:choose>
				                </div> 
				                <div class="gund_A_shuz_cente_bottom">
				                	 <c:choose>
					                	<c:when test="${usage.consumedOffset+1== usage.totalOffset}">
						                  <c:choose>
					                			<c:when test="${usage.totalOffset==0 }">
					                				<p class="none_shu" style="position:absolute;left: 0%">当前:${usage.consumedOffset+1 }</p>
					                			</c:when>
					                			<c:otherwise>
					                				 <p class="none_shu" style="position:absolute;left: 98.7%">↑当前:${usage.consumedOffset+1 }</p>
					                			</c:otherwise>
					                		</c:choose>
					                		
					                	</c:when>
					                	 
					                	<c:otherwise>
					                		<p class="none_shu" style="position:absolute;left: ${(usage.consumedOffset+1)*100/usage.totalOffset}%">↑当前:${usage.consumedOffset+1}</p>
					                	</c:otherwise>
				                	
				                	</c:choose>
				                </div>
		       				</div>
		       				
		       					<div class="gund_A_xuanz" ao="${usage.avalOffset }" to="${usage.totalOffset }" p = "${usage.partitionId }" offset="${usage.consumedOffset+1}"><A href="javascript:void(0);"><img src="${_base }/resources/images/wuli_5.png"></A></div> 	 	    
		       			</div>
	       			</c:otherwise>
	       			</c:choose>
	       			
	       			</c:forEach>
	       		</div>
	       		<div class="xia_center_right">
	       			<div id="xuanz_search_div" class="xia_center_right_shuzi">P0</div>
	       			<div class="xia_center_right_input">
			           <ul>
			           <li class="list_ri">
			           
			           
			           <input type="hidden" id="userServId" name ="userServId" value="${usageVo.userServId }" />
			           <input type="hidden" id="costumeOffset" >
			           <p><input name="offset" id="offset" type="text" value="查询分区消息内容" onkeypress="searchUnNormal()"></p>
			           
			           <p ><A href="javascript:void(0)"><img id="search_btn" src="${_base }/resources/images/wuli_3.png"></A></p>
			          
			           </li>
			           <li id="search_clean" class="gunb"><A><img src="${_base }/resources/images/wuli_4.png" onclick="clearinfo1()" style="cursor:pointer"></A></li>
			           </ul>
			            </div>
			          <div class="xia_center_right_shuzi xx_nrie">消息内容：</div>
			          <div class="xia_center_right_dabg">
			            <textarea name="" id="topic_msg"></textarea>
			          </div>
			          <button class="again-send" onclick="sendMessage()" type="button">重发</button>
			          <button class="jump" onclick="skipMessage()" type="button">跳过</button>
	       		</div>
	       </div>
	       </form>
     </div> 
		</div>
		

  </div>
</div>
</div>
</div>
</div>  
<script type="text/javascript"> 
function clearinfo()
{
	$(".normal #topic_msg").val("");
}

function clearinfo1(){
	$(".no-normal #topic_msg").val("");
}

$(function(){
	
	
	initfunction();
	
	if($("#resultCode").val()=="999999")
	{	
		
		var resultMsg=$("#resultMessage").val();	
		Modal.alert({
				msg : resultMsg
			});
		}
	$(".normal #offset").focus(function(){
		if($(this).val()=='查询分区消息内容'){
			$(this).val("");
		}
	});
	$(".no-normal #offset").focus(function(){
		if($(this).val()=='查询分区消息内容'){
			$(this).val("");
		}
	});
	$(".normal #offset").blur(function(){
		if($(this).val()==''){
			$(this).val("查询分区消息内容");
		}
	});
	$(".no-normal #offset").blur(function(){
		if($(this).val()==''){
			$(this).val("查询分区消息内容");
		}
	});
	
	$(".normal #search_btn").click(function(){
		var offset = parseInt($(".normal #offset").val())-1;		 
		var avalOffset = parseInt( $(".normal #avalOffset").val());
		
		var totalOffset =parseInt( $(".normal #totalOffset").val())-1;
		 
		var reg = new RegExp("^[0-9]*$"); 
		if(offset == "查询分区消息内容"){
			Modal.alert({
				msg: "请输入偏移量"
			})
			 
			return;
		}
		if(!reg.test(offset)){  
			Modal.alert({
				msg: "请输入大于0的数字!"
			})
	        return;
	    }  

		if(offset<avalOffset || offset >totalOffset){
			Modal.alert({
				msg: "请输入有效范围内的值！"
			})
			return ; 
		}
		var param =$(".normal #searchForm").serialize();
		var url ="searchOneMessage";
		$.post(url,param,function(data){
			
			if(data.resultCode=="000000"){
				$(".normal #topic_msg").val(data.searchMessage);
				
			}else{
				Modal.alert({
					msg : "查询失败!"
				});
			}
			
		});
		
		
	});
	$(".no-normal #search_btn").click(function(){
		var offset = parseInt($(".no-normal #offset").val())-1;	
		var avalOffset = parseInt( $(".no-normal #avalOffset").val());
		
		var totalOffset =parseInt( $(".no-normal #totalOffset").val())-1;
		
		var reg = new RegExp("^[0-9]*$"); 
		if(offset == "查询分区消息内容"){
			Modal.alert({
				msg: "请输入偏移量"
			})
			return;
		}
		if(!reg.test(offset)){  
	       	Modal.alert({
	       		msg:"请输入大于0的数字!"
	       	})
	        return;
	    }  

		if(offset<avalOffset || offset >totalOffset){
			Modal.alert({
				msg: "请输入有效范围内的值！"
			})
			return ; 
		}
		var topicEnName=$(".no-normal   #topicEnName").val();
		var partition=$(".no-normal   #partitionId").val();
		var userservId=$(".no-normal  #userServId").val();
		
		$.ajax({
			url:getContextPath()+"/atsConsole/searchOneMessage",
			type:"POST",
			data:{
				offset:offset+1,
				topicEnName:topicEnName,
				partitionId:partition,
				errorinfo:"error",
				userServId:userservId
				
			},
			success:function(data){
				if(data.resultCode=="000000"){
					$(".no-normal #topic_msg").val(data.searchMessage);
					
				}else{
					Modal.alert({
						msg : "查询失败!"
					});
				}
			}
		})
	 
		
		
	});
	
	
	
	
	 
	
	
	
	
	$(".normal .gund_A_xuanz").click(function(){
		var xuanzUrl = "${_base }/resources/images/wuli_6.png";
		var noneUrl = "${_base }/resources/images/wuli_5.png";
		
		$(".normal .gund_A_xuanz").each(function(){
			var obj = $(this).find("img");
			obj.attr("src",noneUrl) ;
		})
		var imgSrc  = $(this).find("img").attr("src");
		var newSrc = imgSrc.replace("5","6");
		$(this).find("img").attr("src",xuanzUrl);
		$(".normal #xuanz_search_div").html("P"+$(this).attr("p"));
		$(".normal #partitionId").val($(this).attr("p"));
		$(".normal #avalOffset").val($(this).attr("ao"));
		$(".normal #totalOffset").val($(this).attr("to"));
	})
	$(".no-normal .gund_A_xuanz").click(function(){
		var xuanzUrl = "${_base }/resources/images/wuli_6.png";
		var noneUrl = "${_base }/resources/images/wuli_5.png";
		
		$(".no-normal .gund_A_xuanz").each(function(){
			var obj = $(this).find("img");
			obj.attr("src",noneUrl) ;
		})
		var imgSrc  = $(this).find("img").attr("src");
		var newSrc = imgSrc.replace("5","6");
		$(this).find("img").attr("src",xuanzUrl);
		$(".no-normal #xuanz_search_div").html("P"+$(this).attr("p"));
		$("#costumeOffset").val($(this).attr("offset"));
		$(".no-normal #partitionId").val($(this).attr("p"));
		$(".no-normal #avalOffset").val($(this).attr("ao"));
		$(".no-normal #totalOffset").val($(this).attr("to"));
	})
	
})

function searchNormal(){
	 
	if(event.keyCode==13){
	
		var offset = parseInt($(".normal #offset").val())-1;
		var avalOffset = parseInt( $(".normal #avalOffset").val());
		
		var totalOffset =parseInt( $(".normal #totalOffset").val())-1;
			 
		var reg = new RegExp("^[0-9]*$"); 
		if(offset == "查询分区消息内容"){
			Modal.alert({
				msg: "请输入偏移量"
			})
			return;
		}
		if(!reg.test(offset)){  
			Modal.alert({
				msg: "请输入大于0的数字!"
			})
	        return;
	    }  

		if(offset<avalOffset || offset >totalOffset){
			Modal.alert({
				msg: "请输入有效范围内的值！"
			})
			 
			return ; 
		}
		var param =$(".normal #searchForm").serialize();
		var url ="searchOneMessage";
		$.post(url,param,function(data){
			
			if(data.resultCode=="000000"){
				$(".normal #topic_msg").val(data.searchMessage);
				
			}else{
				Modal.alert({
					msg : "查询失败！"
				});
			}
			
		});
		return false;
		
	}else{
		
	}
}

function searchUnNormal(){
	
	if(event.keyCode==13){
		var offset = parseInt($(".no-normal #offset").val())-1;
		var avalOffset = parseInt( $(".no-normal #avalOffset").val());
		
		var totalOffset =parseInt( $(".no-normal #totalOffset").val())-1;
		
		var reg = new RegExp("^[0-9]*$"); 
		if(offset == "查询分区消息内容"){
			Modal.alert({
				msg: "请输入偏移量"
			})
			 
			return;
		}
		if(!reg.test(offset)){  
			Modal.alert({
				msg: "请输入大于0的数字!"
			})
	         
	        return;
	    }  

		if(offset<avalOffset || offset >totalOffset){
			Modal.alert({
				msg: "请输入有效范围内的值！"
			})
			 
			return ; 
		}
		var topicEnName=$(".no-normal   #topicEnName").val();
		var partition=$(".no-normal   #partitionId").val();
		var userservId=$(".no-normal  #userServId").val();
		
		$.ajax({
			url:getContextPath()+"/atsConsole/searchOneMessage",
			type:"POST",
			data:{
				offset:offset+1,
				topicEnName:topicEnName,
				partitionId:partition,
				errorinfo:"error",
				userServId:userservId
				
			},
			success:function(data){
				if(data.resultCode=="000000"){
					$(".no-normal #topic_msg").val(data.searchMessage);
					
				}else{
					Modal.alert({
						msg : "查询失败！"
					});
				}
			}
		})
		return false;
			
	}else{
		return false;	
	}
}



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
 
 
 function sendMessage(){
	  
	  var topicmessage=$(".no-normal #topic_msg").val();
	 var ipaasId=$(".no-normal   #userServIpassId").val();
	 var partition=parseInt($(".no-normal #partitionId").val());
	 var signatureId=$(".no-normal #searchForm #topicEnName").val();  
	 
	 
	 
		if(topicmessage==""){
			Modal.alert({
				msg: "请输入要重新发送的消息！"
			})
			 
			return;
		}
	 $.ajax({
		 url:getContextPath()+"/atsConsole/resendMessage",
		 type:"POST",
		 data:{
			 message:topicmessage,
			 userServIpassId:ipaasId,
			 partitionId:partition,
			 errorinfo:"error",
			 topicEnName:signatureId
		 },
		 success: function(data){
			 if(data.resultCode=="000000"){
				 Modal.alert({
						msg :  "重发成功！"
					}).on(function(){
						 var userServId=$(".no-normal #userServId").val();
						 location.href="${_base}/atsConsole/searchUsages?userServId="+userServId+"&errorinfo=error";
					});
				 
			 }else{
				 Modal.alert({
						msg : "重发失败！"
					});
			 }
		 }
	 });
 }
 
 function skipMessage(){
	 
	 
	 var offset = parseInt($("#costumeOffset").val());
	 var topicmessage=$(".no-normal #topic_msg").val();
	 var ipaasId=$(".no-normal   #userServIpassId").val();
	 var partition=parseInt($(".no-normal #partitionId").val());
	 var signatureId=$(".no-normal #searchForm #topicEnName").val();
	 if(topicmessage==""){
		 Modal.alert({
				msg : "跳过的信息为空！"
			});
		return;
	 }
	 $.ajax({
		 url:getContextPath()+"/atsConsole/skipMessage",
		 type:"POST",
		 data:{
			 offset:offset,
			 message:topicmessage,
			 userServIpassId:ipaasId,
			 partitionId:partition,
			 errorinfo:"error",
			 topicEnName:signatureId
		 },
		 success:function(data){
			 if(data.resultCode=="000000"){
				 Modal.alert({
						msg :  "跳过成功！"
				 }).on(function(){
					 var userServId=$(".no-normal #userServId").val();
					 location.href="${_base}/atsConsole/searchUsages?userServId="+userServId+"&errorinfo=error";
				 }); 
				
			 }else{
				 Modal.alert({
						msg : "跳过失败！" 
					});
			 }
		 }
	 })
 }
function initfunction(){
	 var flag=${flag};
	 if(flag==1){
		 
		 $('.tab-change li').eq(1).addClass("tab-li").siblings().removeClass("tab-li");
		 $(".normal").css('display','none');
		 $(".no-normal").css('display','inline-block');
	 }else{
		 $('.tab-change li').eq(0).addClass("tab-li").siblings().removeClass("tab-li");
		 $(".no-normal").css('display','none');
		 $(".normal").css('display','inline-block');
	 }
 }
function searchErrorUsage(){
	 
	var userServId=${usageVo.userServId }
	location.href="${_base}/atsConsole/searchUsages?userServId="+userServId+"&errorinfo=error";
}

function searchUsage(){
	 

	var userServId=${userServId }
	location.href="${_base}/atsConsole/searchUsages?userServId="+userServId+"";
}

</script>
<!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include> 
  </body>
</html>
