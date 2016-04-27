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
					url : "${_base}/dbsConsole/queryDbsList",
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
								html += '<th>主库数量</th>';
								html += '<th>分布式事务</th>';																
								html += '<th>操作</th>'; 		
								html += '</tr>';
								
								html += '<tr>';		
								html += '<td colspan="7">您未订购改服务</td>';								
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
							html += '<th>主库数量</th>';
							html += '<th>分布式事务</th>';
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
		if (!!obj && obj.length == 0) {
			$("#table_detail tbody").empty();
			var html = '';
			html += '<tr>';
			html += '<th>产品名称</th>';
			html += '<th>服务名称</th>';
			html += '<th>IPAAS编码</th>';			
			html += '<th>主库数量</th>';
			html += '<th>分布式事务</th>';
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
		html += '<th>主库数量</th>';
		html += '<th>分布式事务</th>';
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
							
							// 主库数量
							html += '<td>' + item.userServParamMap.masterNum + '</td>';
							// 分布式事务
							html += '<td>' + item.userServParamMap.isNeedDistributeTrans + '</td>';
							//操作
							html += '<td>' 
								+'<a href="#" onclick=modifyServPwd("'+ item.userServId +'"); >修改服务密码</a>'
								+'|<a href="#" onclick=toMUI("'+ item.userServId +'"); >MUI工具</a>'
								+'|<a href="#" onclick=checkService("'+ item.userServIpaasId +'"); >服务验证</a>'
								+ '</td>';
							html += '</tr>';
						});
		$('#table_detail tbody').append(html);		
	}
	
	
	
	function modifyServPwd(userServId) {
		var parentUrl = location.pathname;
		location.href="${_base}/dbsConsole/toModifyDbsServPwd?userServId="+userServId+"&parentUrl="+parentUrl+"&productType=1";
	}
	
	function toMUI(userServId) {
		window.open (muiUrl);
	}
	
	//验证dbs服务
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
			url : "${_base}/ServiceCheck/toCheckDbsService",
			dataType : "json",
			data:"serviceId="+userServIpaasId+"&pid="+pid+"&servicePwd="+ svcPwd,
			
			success : function(msg) {
				if (msg.dbsCode == '111111') {
					alert("恭喜，DBS服务 "+userServIpaasId +" 验证成功 ! \n DBSMessage is ："+msg.dbsMsg);
				} else {
					alert("DBS服务 "+userServIpaasId +" 验证失败 !");
				}
			},
			error : function() {
				alert("DBS服务 "+userServIpaasId +" 验证失败 !");
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
