<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
<title>${prodName}</title>
<%@ include file="/jsp/common/common.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		// 页面初始化
		queryDssList();	

	});	
	var muiUrl;
	function queryDssList() {
		$.ajax({
					type : "POST",
					url : "${_base}/sesConsole/querySesList",
					dataType : "json",
					data : {
					},
					beforeSend : function(XMLHttpRequest) {
						$('.fenye').css('display', 'none');
						$("#table_detail tbody").empty();
						$('#loading').shCircleLoader({
							// 设置加载颜色
							color : '#F0F0F0'
						});
					},
					success : function(msg) {
						
						if (msg.resultCode == '000000') {
							muiUrl = msg.muiUrl;
							if (msg.resultList.length == 0) {
							
								$("#table_detail tbody").empty();
								var html = '';
								html += '<tr>';
								html += '<th>产品名称</th>';
								html += '<th>服务名称</th>';
								html += '<th>IPAAS编码</th>';																							
								html += '<th>操作1</th>'; 		
								html += '</tr>';
								
								html += '<tr>';		
								html += '<td colspan="7">您未订购该服务</td>';								
								html += '</tr>';									
								$('#table_detail tbody').append(html);								
								return;
							}							
							loadData(msg.resultList);
							
						} else {
							//alert("查询不到数据");
							$("#table_detail tbody").empty();
							var html = '';
							html += '<tr>';
							html += '<th>产品名称</th>';
							html += '<th>服务名称</th>';
							html += '<th>IPAAS编码</th>';							
							html += '<th>操作</th>'; 		
							html += '</tr>';
							
							html += '<tr>';		
							html += '<td colspan="7">查询异常</td>';								
							html += '</tr>';									
							$('#table_detail tbody').append(html);								
							return;
						}
					},
					complete : function(XMLHttpRequest, textStatus) {
						$('.fenye').css('display', 'block');
						$('#loading').shCircleLoader('destroy');
					},
					error : function() {
						report('系统发生异常，数据加载失败，请登陆后重新尝试。');
						$('.fenye').css('display', 'none');
					}
				});

	}
	
	function loadData(obj) {
		console.log(obj);
		if (!!obj && obj.length == 0) {
			$("#table_detail tbody").empty();
			var html = '';
			html += '<tr>';
			html += '<th>产品名称</th>';
			html += '<th>服务名称</th>';
			html += '<th>IPAAS编码</th>';			
			html += '<th>操作</th>'; 		
			html += '</tr>';
			
			html += '<tr>';		
			html += '<td colspan="7">您未订购该服务</td>';								
			html += '</tr>';									
			$('#table_detail tbody').append(html);								
			return;
		}
		$("#table_detail tbody").empty();
		var html = '';
		html += '<tr>';
		html += '<th>产品名称</th>';
		html += '<th>服务名称</th>';
		html += '<th>IPAAS编码</th>';		
		html += '<th>操作</th>'; 		
		html += '</tr>';		
		$.each(
						obj,
						function(n, item) {
							html += '<tr >';	
							// 产品名称
							html += '<td>' + item.prodName + '</td>';
							// 服务名称
							html += '<td >' +item.serviceName + '</td>';									
							// IPAAS编码
							html += '<td>' + item.userServIpaasId + '</td>';
							//操作
							if(item.userServRunState=='0'){
								html += '<td>' 
									+'<a href="#" onclick=modifyServPwd("'+ item.userServId+'"); >修改服务密码</a>'
									+'|<a href="#" onclick=toStop("'+ item.userServId +'","'+item.serviceName+'"); >停止</a>'
									+'|<a href="#" onclick=toCancle("'+ item.userServId +'","'+item.serviceName+'"); >注销</a>'
									+'|<a href="#" onclick=checkService("'+ item.userServIpaasId +'"); >服务验证</a>'
									+ '</td>';
							}else if(item.userServRunState=='1'){
								html += '<td>' 
									+'<a href="#" onclick=modifyServPwd("'+ item.userServId +'"); >修改服务密码</a>'
									+'|<a href="#" onclick=toStart("'+ item.userServId +'","'+item.serviceName+'"); >启动</a>'
									+'|<a href="#" onclick=toCancle("'+ item.userServId+'","'+item.serviceName +'"); >注销</a>'	
									+'|<a href="#" onclick=checkService("'+ item.userServIpaasId +'"); >服务验证</a>'
									+ '</td>';
							}else{
								html += '<td>' 
									+'<a href="#" onclick=modifyServPwd("'+ item.userServId +'"); >修改服务密码</a>'
									+'|<a href="#" onclick=toStop("'+ item.userServId +'","'+item.serviceName+'"); >停止</a>'
									+'|<a href="#" onclick=toCancle("'+ item.userServId +'","'+item.serviceName+'"); >注销</a>'
									+'|<a href="#" onclick=checkService("'+ item.userServIpaasId +'"); >服务验证</a>'
									+ '</td>';
							}
						
							html += '</tr>';
						});
		$('#table_detail tbody').append(html);		
	}
	
	
    function modifyServPwd(userServId) {
		var parentUrl = location.pathname;
		location.href="${_base}/sesConsole/toModifySesServPwd?userServId="+userServId+"&parentUrl="+parentUrl+"&productType=1";
	}
      
    function toStart(userServId,serviceName) {
    	var remainMsg='确定要对服务【'+serviceName+'】做启动操作吗？';
    	Modal.confirm({msg:remainMsg}).on(function(e){
    		if(e){
    			$.ajax({
        			async:false,
        			type:"POST",
        			url:"${_base}/sesConsole/startService",
        			dataType:'json',
        			data:{
        				userServId:userServId
        			},
        			success:function(msg){
        				if(msg.resultCode=='000000'){
        					Modal.alert({
        						msg:'服务【'+serviceName+'】启动成功!'
        					}).on(queryDssList());
        					
        				}else if(msg.resultCode=='999999'){
        					Modal.alert({
        						msg:'服务【'+serviceName+'】启动失败!'
        					})
        				}
        			}
        			
        		})
    		}
    		
    	}) ;
	}
	function toStop(userServId,serviceName) {
		var remainMsg='确定要对服务【'+serviceName+'】做停止操作吗？';
		Modal.confirm({msg:remainMsg}).on(function(e){
    		if(e){
    			$.ajax({
        			async:false,
        			type:"POST",
        			url:"${_base}/sesConsole/stopService",
        			dataType:'json',
        			data:{
        				userServId:userServId
        			},
        			success:function(msg){
        				if(msg.resultCode=='000000'){
        					Modal.alert({
        						msg:'服务【'+serviceName+'】停止成功!'
        					}).on(queryDssList());
        					
        				}else if(msg.resultCode=='999999'){
        					Modal.alert({
        						msg:'服务【'+serviceName+'】停止失败!'
        					})
        				}
        			}
        			
        		})
    		}
    	}) ;
	}
	
	function toCancle(userServId,serviceName) {
		var remainMsg='确定要对服务【'+serviceName+'】做注销操作吗？';
		Modal.confirm({msg:remainMsg}).on(function(e){
			if(e){
				$.ajax({
	    			async:false,
	    			type:"POST",
	    			url:"${_base}/sesConsole/cancleService",
	    			dataType:'json',
	    			data:{
	    				userServId:userServId
	    			},
	    			success:function(msg){
	    				if(msg.resultCode=='000000'){
	    					Modal.alert({
	    						msg:'服务【'+serviceName+'】注销成功!'
	    					}).on(queryDssList());
	    					
	    				}else if(msg.resultCode=='999999'){
	    					Modal.alert({
	    						msg:'服务【'+serviceName+'】注销失败!'
	    					})
	    				}
	    			}
	    			
	    		})
			}
    	}) ;
	}
	
	function checkService(userServIpaasId)
	{
		var svcPwd=prompt("请输入服务密码：");
	    if(svcPwd)
	    {
	    	var pid= "${userInfoVO.pid}";
	        alert("服务ID: "+userServIpaasId+" & 服务密码: "+ svcPwd+ " & PID："+pid);       
	    }
	    $.ajax({
			type : "POST",
			url : "${_base}/ServiceCheck/toCheckSesService",
			dataType : "json",
			data:"serviceId="+userServIpaasId+"&pid="+pid+"&servicePwd="+ svcPwd,
			
			success : function(msg) {
				if (msg.sesCode == '111111') {
					alert("恭喜，SES服务 "+userServIpaasId +" 验证成功 ! \n SESMessage is ："+msg.sesMsg);
				} else {
					alert("SES服务 "+userServIpaasId +" 验证失败 !");
				}
			},
			error : function() {
				alert("SES服务 "+userServIpaasId +" 验证失败 !");
			}
		});
	}
	
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
     
     <div class="Open_cache">
        <div class="Open_cache_table">
			<ul>
			<li><a href="#">${prodName}</a></li> 
			</ul>  
        </div> 
		<div class="Open_cache_table" style="background:rgb(245,245,245);height:30px;vertical-align:middle;text-align:center;line-height:30px;padding-left:40%">
			 
		</div> 
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
	          	<div class="Open_cache_list_tow">
	          		 <table id="table_detail"  style="width:100%; ">
						<tr>
							<th>IPAAS编码</th>
							<th>产品名称</th>							
							<th>操作</th> 
						</tr>						
					 </table>
	           </div>                
	        </div>  
    	</div>   
     </div> 
 
  </div>
</div>

</div>
</div>  
<!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
 
  </body>
</html>
