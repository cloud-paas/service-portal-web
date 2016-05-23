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
					url : "${_base}/idpsConsole/queryIdpsList",
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
								html += '<th>总容量（M）</th>';
								html += '<th>单文件大小（M）</th>';
								html += '<th>使用量（M / B）</th>';
								html += '<th>操作</th>'; 		
								html += '</tr>';
								
								html += '<tr>';		
								html += '<td colspan="7">您查询的数据不存在</td>';								
								html += '</tr>';									
								$('#table_detail tbody').append(html);								
								return;
							}		
							if(indexFlag == '1'){								
								$('#infomatin').hide();
							}else{
								loadData(msg.resultList);
								$('#infomatin').show();
							}
							
						} else {
							//alert("查询不到数据");
							$("#table_detail tbody").empty();
							var html = '';
							html += '<tr>';		
							html += '<th>产品名称</th>';
							html += '<th>服务名称</th>';
							html += '<th>IPAAS编码</th>';							
							html += '<th>总容量（M）</th>';
							html += '<th>单文件大小（M）</th>';
							html += '<th>使用量（M / B）</th>';
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
			html += '<th>总容量（M）</th>';
			html += '<th>单文件大小（M）</th>';
			html += '<th>使用量（M / B）</th>';
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
		html += '<th>节点数量（个）</th>';
		html += '<th>内存大小（M）</th>';
		html += '<th>CPU（GHZ）</th>';
		html += '<th>操作</th>'; 		
		html += '</tr>';
		
		$
				.each(
						obj,
						function(n, item) {
							html += '<tr >';
							// 产品名称
							html += '<td>' + item.prodName + '</td>';
							// 服务名称
							html += '<td >' +item.serviceName + '</td>';									
							// IPAAS编码
							html += '<td>' + item.userServIpaasId + '</td>';
							
							// 总容量（M）
							html += '<td>'+ item.userServParamMap.nodeNum+ ' M</td>';
							// 单文件大小（M）
							html += '<td>' + item.userServParamMap.mem+ ' M</td>';
							// 已使用量（M）
							html += '<td>' + item.userServParamMap.cpuNum+ ' </td>';
							//操作
							html += '<td style="font-size:14px" align="left">' 
								+'<a href="#"  >暂无可操作</a>'
								+ '</td>';
							html += '</tr>';
						});
		$('#table_detail tbody').append(html);		
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
     
     <div class="Open_cache" id="infomatin" style="display:none">
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
							<th>服务名称</th>
							<th>产品名称</th>
							<th>IPAAS编码</th>							
							<th>总容量（M）</th>
							<th>单文件大小（M）</th>
							<th>使用量</th>
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
