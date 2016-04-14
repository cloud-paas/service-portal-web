<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
  <head>
<%@ include file="/jsp/common/common.jsp"%>
<style type="text/css">
	.again-send,.jump{width:100px;height:35px;text-align:center;border-radius:3px;margin-top:30px;font-size:15px;}
   	.again-send{background:#0077C3;color:#fff;border:1px solid #fff;margin:0px 10px 0px 110px;}
   	.jump{background:#fff;color:#0077C3;border:1px solid #0077C3;}
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
			<li><a href="#">消息中心MDS</a></li> 
			</ul>  
        </div> 
		<div class="Open_cache_table" style="background:rgb(245,245,245);height:50px;vertical-align:middle ;line-height:30px;padding-left:1%">
			 <span>服务名称：</span>
			 <span style="color:rgb(22,154,219)">${userProdInstVo.userServParamMap.topicName}</span>
			 <span>队列名称：</span>
			 <span  style="color:rgb(22,154,219)">${userProdInstVo.userServParamMap.topicEnName}</span> 
			 <span>服务编码：</span>
			 <span style="color:rgb(22,154,219)">${userProdInstVo.userServIpaasId}</span>
			 <span>分片数：</span>
			 <span style="color:rgb(22,154,219)">${userProdInstVo.userServParamMap.topicPartitions} </span>
		</div> 
     	<div class="Open_cache">  
		 <form  id="searchForm">
	       <div class="xia_center">
	       		<div class="xia_center_left">
	       			
	       		</div>
	       		<div class="xia_center_gund">
	       			<c:forEach items="${userProdInstVo.mdsUserPageVo.topicUsage }" varStatus="i" var="usage">
	       			<c:choose>
	       			<c:when test="${i.index == 0 }">
		       			<div class="xia_center_gund_A   none_top">
		       				<div class="gund_A_shuz">P${usage.partitionId }</div>
		       				<p class="total-num" >总:${usage.totalOffset }</p>
		       				<input type="hidden" id="partitionId" name="partitionId" value="${usage.partitionId }" />
				           <input type="hidden" id="avalOffset" name="avalOffset" value="${usage.avalOffset }" />
				           <input type="hidden" id="totalOffset" name="totalOffset" value="${usage.totalOffset }" />
				           <input type="hidden" class="cosumeOffset" value="${usage.consumedOffset+1 }" >
				           <input type="hidden" id="topicEnName" name="topicEnName" value="${userProdInstVo.userServParamMap.topicEnName}" />
				           <input type="hidden" id="userServIpaasId" name="userServIpaasId" value="${userProdInstVo.userServIpaasId}">
		       				<div class="gund_A_shuz_cente">
		       					<div class="gund_A_shuz_cente_top">
		       						<c:choose>
		       							
		       								 
		       							<c:when test="${usage.avalOffset==0}">
		       								 <p style="position:absolute;float:left;width:100px;top:-25px">有效:${usage.avalOffset }</p>
		       							</c:when>
		       							
		       							<c:otherwise>
		       								<p style="position:absolute;left:${(usage.avalOffset)*100/usage.totalOffset}%;top:-25px">↓有效:${usage.avalOffset}</p>
		       							</c:otherwise>
		       						</c:choose>
		       							
		       						 
		       						
		       						
		       						
		       					</div>
		       					<div class="gund_A_shuz_cente_main">
		       						<c:choose>
		       							<c:when test="${usage.avalOffset==usage.totalOffset}">
		       								
		       									<div style="float:left;width:100%;height:30px;background: #98FB98"></div>
		       									
		       								
		       								
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
		       				
		       				 
		       							<div class="gund_A_xuanz" ao="${usage.avalOffset }" to="${usage.totalOffset }" p = "${usage.partitionId }" cosumeOffset="${usage.consumedOffset+1}"><A href="javascript:void(0);"><img src="${_base }/resources/images/wuli_6.png"></A></div> 	 	 
		       					 
				                
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
		       								<p style="position:absolute;top:-25px;float:left;left:${(usage.avalOffset)*100/usage.totalOffset}%">↓有效:${usage.avalOffset}</p>
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
				               
			       					
			       					<div class="gund_A_xuanz" ao="${usage.avalOffset }" to="${usage.totalOffset }" p = "${usage.partitionId }" cosumeOffset="${usage.consumedOffset+1}"><A href="javascript:void(0);"><img src="${_base }/resources/images/wuli_5.png"></A></div> 	 	 
			       					
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
			           
			           
			           <input type="hidden" class="userServId" name ="userServId" value="${userProdInstVo.userServId }" />
			            
			           <p><input name="offset" id="offset" type="text" value="查询分区消息内容"></p>
			           
			           <p onclick="search_message();" ><A href="javascript:void(0)"><img id="search_btn" src="${_base }/resources/images/wuli_3.png"></A></p>
			          
			           </li>
			           <li id="search_clean" class="gunb"><A><img src="${_base }/resources/images/wuli_4.png" style="cursor:pointer;"></A></li>
			           </ul>
			            </div>
			          <div class="xia_center_right_shuzi xx_nrie">消息内容：</div>
			          <div class="xia_center_right_dabg">
			            <textarea name="" id="topic_msg"></textarea>
			          </div>
			          <button class="again-send" onclick="resendMessage()" type="button">重发</button>
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
<script type="text/javascript"> 

function search_message(){
	
	
}
$(function(){
	if(${userProdInstVo.mdsUserPageVo.resultCode}=="999999"){
	 
		Modal.alert({
			msg:"MDS查询使用量失败"
		})
	}
	$("#offset").focus(function(){
		if($(this).val()=='查询分区消息内容'){
			$(this).val("");
		}
	});
	$("#offset").blur(function(){
		if($(this).val()==''){
			$(this).val("查询分区消息内容");
		}
	});
	
	$("#search_btn").click(function(){
		var offset = parseInt($("#offset").val())-1;
		var avalOffset=  parseInt($("#avalOffset").val());
		var avalOffest1=parseInt($("#avalOffset").val());
		var totalOffset = parseInt($("#totalOffset").val())-1;
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
		var param =$("#searchForm").serialize();
		var url ="searchMessage";
		$.post(url,param,function(data){
			if(data.resultCode=="000000"){
				 
				$("#topic_msg").val(data.resultMessage);
				
			}else{
				Modal.alert({
					msg: "查询失败"
				})
				 
			}
			
		});
		
		
	});
	
	$("#search_clean").click(function(){
		
		$("#topic_msg").val("");
	});
	
	
	
	
	$(".gund_A_xuanz").click(function(){
		var xuanzUrl = "${_base }/resources/images/wuli_6.png";
		var noneUrl = "${_base }/resources/images/wuli_5.png";
		
		$(".gund_A_xuanz").each(function(){
			var obj = $(this).find("img");
			obj.attr("src",noneUrl) ;
		})
		var imgSrc  = $(this).find("img").attr("src");
		var newSrc = imgSrc.replace("5","6");
		$(this).find("img").attr("src",xuanzUrl);
		$("#xuanz_search_div").html("P"+$(this).attr("p"));
		$("#partitionId").val($(this).attr("p"));
		$("#avalOffset").val($(this).attr("ao"));
		$("#totalOffset").val($(this).attr("to"));
		$(".cosumeOffset").val($(this).attr("cosumeOffset"));
	})
	
})



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
 
function resendMessage(){
	 var topicMsg=$("#topic_msg").val();
	 if(topicMsg==""){
		Modal.alert({
			msg: "重发的消息不能为空"
		})
		 
		return;
	 }
	 var ipaasid=$("#userServIpaasId").val();
	 var partitionId=parseInt($("#partitionId").val());
	 var signatureId=$("#topicEnName").val();
	
	  
	  $.ajax({
		 url:getContextPath()+"/mdsConsole/resendMessage",
		 type:"POST",
		 data:{
			 message:topicMsg,
			 userServIpassId:ipaasid,
			 topicEnName:signatureId,
			 partition:partitionId
		 },
		 success:function(data){
			 
			 if(data.resultCode=="000000"){
				 Modal.alert({
						msg :  "信息重发成功！"
					}).on(function(){
						 var userServId=$(".userServId").val();
						 location.href="${_base}/mdsConsole/queryMdsInstById?userServId="+userServId+"";
					});
			 }else{
				 Modal.alert({
						msg : "查询失败，失败原因："+data.resultMsg
					});
			 }
		 }
	 }) 
 }
 
 function skipMessage(){
	 var offset=parseInt($(".cosumeOffset").val());
	 var topicMsg=$("#topic_msg").val();
	 var ipaasid=$("#userServIpaasId").val();
	 var partitionId=parseInt($("#partitionId").val());
	 var totalOffset = parseInt($("#totalOffset").val());
	 if(offset>=totalOffset){
		 Modal.alert({
			 msg: "当前偏移量已超过跳过界限！"
		 })
		 return;
	 }
	 var signatureId=$("#topicEnName").val();
	 $.ajax({
		 url:getContextPath()+"/mdsConsole/skipMessage",
		 type:"POST",
		 data:{
			 offset:offset,
			 message:topicMsg,
			 userServIpassId:ipaasid,
			 partition:partitionId,
			 topicEnName:signatureId
		 },
		 success:function(data){
			 if(data.resultCode=="000000"){
				 Modal.alert({
						msg : "信息跳过成功！"
				 }).on(function(){
					 var userServId=$(".userServId").val();
					 location.href="${_base}/mdsConsole/queryMdsInstById?userServId="+userServId+"";
				 });
				
			 }else{
				 Modal.alert({
						msg : "查询失败，失败原因："+data.resultMsg
					});
			 }
		 }
	 })  
 }
</script>
<!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include> 
  </body>
</html>
