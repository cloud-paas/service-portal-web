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
					url : "${_base}/dssConsole/queryDssList",
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
		html += '<th>总容量（M）</th>';
		html += '<th>单文件大小（M）</th>';
		html += '<th>使用量（M / B）</th>';
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
							html += '<td>'+ item.totalAmount+ ' M</td>';
							// 单文件大小（M）
							html += '<td>' + item.singleFileSize+ ' M</td>';
							// 已使用量（M）
							html += '<td>' + item.usedAmount+ ' </td>';
							//操作
							html += '<td style="font-size:14px" align="left">' 
								+ '<a href="#" onclick=detail("'+ item.userServId +'"); >文件管理</a>'
								+'|<a href="#"  onclick=cancle("'+ item.userServId +'"); >注销</a>'
								+'<br><a href="#"  onclick=cleanAll("'+ item.userServId +'"); >格式化</a>'
								+'|<a href="#" onclick=modifyServPwd("'+ item.userServId +'"); >修改服务密码</a>'
								 +'<br><a href="#"  onclick=modifyConfiguration("'+item.userServId +'") >扩容</a>' 
								 +'|<a href="#" onclick=checkService("'+ item.userServIpaasId +'"); >服务验证</a>'
								+ '</td>';
							html += '</tr>';
						});
		$('#table_detail tbody').append(html);		
	}
	
	function detail(userServId) {
		var parentUrl = location.pathname;
		location.href="${_base}/dssConsole/queryDssInstById?userServId="+userServId+"&parentUrl="+parentUrl+"&productType=1";
	}
	
	function modifyConfiguration(userServId){
		location.href="${_base}/dssConsole/modifyDetailById?userServId="+userServId+"";
	}
	function userServId(userServId) {
		$("#userServId").val(userServId);
	}
	function cancle(userServId) {
		var remaindMsg = "执行注销操作吗";
		Modal.confirm({
			msg : "注销后将无法使用，确定要"+remaindMsg+"？"
		}).on(function(e) {
			if(e) {
			$.ajax({
				async : false,
				type : "POST",
				url : "${_base}/dssConsole/cancleDss",
				modal : true,
				showBusi : false,
				data : {									
				userServId	: userServId
				},
				success: function(data){
					var json=data		
				
					if(json&&json.resultCode=="000000"){					
						location.href="${_base}/dssConsole/toDssConsole";
					}else{									
						alert("操作失败");	
					}
			}
		});	
			}
		});
		
	}
	
	function cleanAll(userServId) {
		var remaindMsg = "执行格式化操作吗";
		Modal.confirm({
			msg : "清理后将无法恢复，确定要"+remaindMsg+"？"
		}).on(function(e) {
			if(e) {
				$.ajax({
					async : false,
					type : "POST",
					url : "${_base}/dssConsole/formatDss",
					modal : true,
					showBusi : false,
					data : {									
						userServId	: userServId
					},
					success: function(data){
						var json=data
						
						if(json&&json.resultCode=="000000"){					
							location.href="${_base}/dssConsole/toDssConsole";
						}else{									
							alert("操作失败");	
						}
					}
				});	
			}
		});
		
	}
	
	function modifyServPwd(userServId) {
		var parentUrl = location.pathname;
		location.href="${_base}/dssConsole/toModifyDssServPwd?userServId="+userServId+"&parentUrl="+parentUrl+"&productType=1";;
	}
	
	function modifyServPwd(userServId) {
		var parentUrl = location.pathname;
		location.href="${_base}/dssConsole/toModifyDssServPwd?userServId="+userServId+"&parentUrl="+parentUrl+"&productType=1";;
	}
	
	//验证dss服务
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
			url : "${_base}/ServiceCheck/toCheckDssService",
			dataType : "json",
			data:"serviceId="+userServIpaasId+"&pid="+pid+"&servicePwd="+ svcPwd,
			
			success : function(msg) {
				if (msg.dssCode == '111111') {
					alert("恭喜，DSS服务 "+userServIpaasId +" 验证成功 ! \n DSSMessage is ："+msg.dssMsg);
				} else {
					alert("DSS服务 "+userServIpaasId +" 验证失败 !");
				}
			},
			error : function() {
				alert("DSS服务 "+userServIpaasId +" 验证失败 !");
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
<!-- 清理数据 -->
		<div class="modal fade bs-example-modal-sm" id="clean_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">全部清理数据</h4>
			  </div>
			  <div class="modal-body">
			       清理数据后将无法修复，您确认此操作吗？
				   <button type="button" class="btn btn-default" data-dismiss="modal" id = "cleanAll_back">取消</button>
				<button type="button" class="btn btn-primary" onclick="cleanAll()">确认</button>
			  </div> 
			</div>
		  </div>
		</div>
		<div class="modal fade bs-example-modal-sm" id="cancle_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">注销</h4>
			  </div>
			  <div class="modal-body">
			       注销后将无法修复，您确认此操作吗？
				   <button type="button" class="btn btn-default" data-dismiss="modal" id = "cancle_back">取消</button>
				<button type="button" class="btn btn-primary" onclick="cancle()">确认</button>
			  </div> 
			</div>
		  </div>
		</div>
<!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
 
  </body>
</html>
