<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
  <head>
  <title>配置中心CCS</title>
<%@ include file="/jsp/common/common.jsp"%>
<script src="${_base }/resources/js/common/commonUtils.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// 页面初始化
		queryCcsList();	
	});
	function queryCcsList() {
		$.ajax({
					type : "POST",
					url : "${_base}/config/selectService",
					dataType : "json",
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
								html += '<th>服务名称</th>';
								html += '<th>IPAAS编码</th>';
								html += '<th>产品名称</th>';
								html += '<th>操作</th>'; 		
								html += '</tr>';
								
								html += '<tr>';		
								html += '<td colspan="4">您查询的数据不存在</td>';								
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
							html += '<th>服务名称</th>';
							html += '<th>iPAAS编码</th>';
							html += '<th>产品名称</th>';
							html += '<th>操作</th>'; 		
							html += '</tr>';
							
							html += '<tr>';		
							html += '<td colspan="4">您查询的数据不存在</td>';								
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
			html += '<th>服务名称</th>';
			html += '<th>IPAAS编码</th>';
			html += '<th>产品名称</th>';
			html += '<th>操作</th>'; 		
			html += '</tr>';
			
			html += '<tr>';		
			html += '<td colspan="4">您查询的数据不存在</td>';								
			html += '</tr>';									
			$('#table_detail tbody').append(html);								
			return;
		}
		$("#table_detail tbody").empty();
		var html = '';
		html += '<tr>';		
		html += '<th>服务名称</th>';
		html += '<th>IPAAS编码</th>';
		html += '<th>产品名称</th>';
		html += '<th>操作</th>'; 		
		html += '</tr>';
		
		$.each(obj,function(n, item) {
				html += '<tr >';
				// 服务名称
				html += '<td >' +$.parseJSON(item.userServParam).serviceName + '</td>';									
				// IPAAS编码
				html += '<td>' + item.userServIpaasId + '</td>';
				// 产品名称
				html += '<td>配置中心CCS</td>';
				//操作
				html += '<td>' 
					+ "<a href='javascript:;' onclick='toMethodPage(\""+item.userServId+"\",\"toModifyCcsServPwd\")'>修改服务密码</a>"
					+ '|<a href="${_base }/config/main/'+ item.userServIpaasId +'?pathUrl='+location.pathname+'" >配置</a>'
					+ '|<a href="#" data-toggle="modal" data-target="#cancle_model" onclick=userServId("'+ item.userServId +'"); >注销</a>'
					+ '</td>';
				html += '</tr>';
			});
		$('#table_detail tbody').append(html);
		
	}
		
	function cancle() {
		$("#cancle_back").click(); 
		var userServId = $("#userServId").val();
		$.ajax({
			async : false,
			type : "POST",
			url : "${_base}/config/cancleCcs",
			modal : true,
			showBusi : false,
			data : {									
				userServId	: userServId
			},
			success: function(data){
				var json=data		
				
				if(json&&json.resultCode=="000000"){					
					location.href="${_base}/config/showService";
				}else{									
					alert("操作失败");	
				}
			}
		});	
	}
	
	function userServId(userServId) {
		$("#userServId").val(userServId);
	}
	
	//修改ccs服务密码
	function toMethodPage(userServId, method) {
		postRequest(getContextPath() + '/ccs/' + method, {
			userServId : userServId
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
			<li><a>配置中心CCS</a></li> 
			</ul>  
        </div> 
		<div class="Open_cache_table" style="background:rgb(245,245,245);height:30px;vertical-align:middle;text-align:center;line-height:30px;padding-left:40%">
			 
		</div> 
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
	          	<div class="Open_cache_list_tow">
	          		 <table id="table_detail"  style="width:100%;">
						<tr>
							<th>服务名称</th>
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
