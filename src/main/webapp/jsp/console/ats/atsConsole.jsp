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
	function queryDssList() {
		$.ajax({
					type : "POST",
					url : "${_base}/atsConsole/queryAtsList",
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
							if (msg.resultList.length == 0) {
							
								$("#table_detail tbody").empty();
								var html = '';
								html += '<tr>';
								html += '<th>产品名称</th>';
								html += '<th>服务名称</th>';
								html += '<th>IPAAS编码</th>';		
								html += '<th>PAAS签名</th>';
								html += '<th>操作</th>'; 		
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
							html += '<th>PAAS签名</th>';
							html += '<th>操作</th>'; 		
							html += '</tr>';
							
							html += '<tr>';		
							html += '<td colspan="7">您查询的数据不存在</td>';								
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
		if (!!obj && obj.length == 0) {
			$("#table_detail tbody").empty();
			var html = '';
			html += '<tr>';
			html += '<th>产品名称</th>';
			html += '<th>服务名称</th>';
			html += '<th>IPAAS编码</th>';	
			html += '<th>PAAS签名</th>';
			html += '<th>操作</th>'; 		
			html += '</tr>';
			
			html += '<tr>';		
			html += '<td colspan="7">您查询的数据不存在</td>';								
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
		html += '<th>PAAS签名</th>';
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
							// IPAAS编码
							html += '<td>' + item.signatureId + '</td>';	
							//操作
							html += '<td>'
								+'<a href="#" onclick=searchUsage("'+item.userServId+'"); >查看详情</a>/'
								+'<a href="#" onclick=modifyServPwd("'+ item.userServId +'"); >修改服务密码</a>'
								+'<a href="#" onclick=checkService("'+ item.userServIpaasId +'","'+ item.signatureId +'"); >服务验证</a>'
								+ '</td>';
							html += '</tr>';
						});
		$('#table_detail tbody').append(html);		
	}
	
	
	
	function modifyServPwd(userServId) {
		var parentUrl = location.pathname;
		location.href="${_base}/atsConsole/toModifyAtsServPwd?userServId="+userServId+"&parentUrl="+parentUrl+"&productType=1";
	}
	function searchUsage(userServId){
		 
	 
		location.href="${_base}/atsConsole/searchUsages?userServId="+userServId+"";
	}
	
	//验证ats服务
	function checkService(userServIpaasId,signatureId)
	{
	    var svcPwd=prompt("请输入服务密码：");
	    if(svcPwd)
	    {
	    	var pid= "${userInfoVO.pid}";
	        alert("服务ID: "+userServIpaasId+" & 服务密码: "+ svcPwd+ " & PID："+pid
	        		+ " \n & signatureId："+signatureId);       
	    }
	    $.ajax({
			type : "POST",
			url : "${_base}/ServiceCheck/toCheckAtsService",
			dataType : "json",
			data : "serviceId="+userServIpaasId+"&pid="+pid+"&servicePwd="+ svcPwd +"&signatureId="+ signatureId,
			
			success : function(msg) {
				if (msg.sesCode == '111111') {
					alert("恭喜，ATS服务 "+userServIpaasId +" 验证成功 ! \n PAAS签名 is "+ signatureId
							+"\n ATSMessage is ："+msg.txsMsg);
				} else {
					alert("ATS服务 "+userServIpaasId +" 验证失败 ! \n PAAS签名 is "+ signatureId");
				}
			},
			error : function() {
				alert("ATS服务 "+userServIpaasId +" 验证失败 !\n PAAS签名 is "+ signatureId");
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
