<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
<title>组织管理</title>
<%@ include file="/jsp/common/common.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		// 页面初始化
		queryOrgList();	
	});	

	function queryOrgList() {
		$.ajax({
			type : "POST",
			url : "${_base}/orgConsole/queryOrgList",
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
					if (msg.resultList.length ==0) {
						$("#table_detail tbody").empty();
						var html = '';
						html += '<tr>';
						html += '<th></th>';
						html += '<th>组织编码</th>';
						html += '<th>组织名称</th>';																							
						html += '<th>组织狀態</th>'; 
						html += '<th>操作</th>'; 	
						html += '</tr>';
						
						html += '<tr>';		
						html += '<td colspan="7">目前還沒有組織，請添加~</td>';								
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
					html += '<th></th>';
					html += '<th>组织编码</th>';
					html += '<th>组织名称</th>';																							
					html += '<th>组织狀態</th>'; 
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
		$.each(
				obj,
				function(n, item) {
					html += '<tr >';	
					// 组织编码
					html += '<td>' + item.orgCode + '</td>';
					// 组织名称
					html += '<td >' +item.orgName + '</td>';									
					// 组织狀態
					if (item.orgStatus == 1) {
						html += '<td>' + "有效" + '</td>';
					} else {
						html += '<td>' + "無效" + '</td>';
					}
					
					//操作
					html += '<td>' 
							+'<a href="#" onclick=modifyOrg("'+ item.orgId+'"); >修改組織</a>'
							+'|<a href="#" onclick=deleteOrg("'+ item.orgId + ','+item.orgName+'"); >刪除組織</a>'
							+ '</td>';	
					html += '</tr>';
				});		
		$('#table_detail tbody').append(html);		
	}
	
	
    function modifyOrg(orgId) {
		var parentUrl = location.pathname;
		location.href="${_base}/orgConsole/toModifyOrg?orgId="+orgId;
	}
      
    function deleteOrg(orgId,orgName) {
    	var remainMsg='确定要对組織【'+orgName+'】做刪除操作吗？';
    	Modal.confirm({msg:remainMsg}).on(function(e){
    		if(e){
    			$.ajax({
        			async:false,
        			type:"POST",
        			url:"${_base}/orgConsole/deleteOrgnize",
        			dataType:'json',
        			data:{
        				orgId:orgId
        			},
        			success:function(msg){
        				if(msg.resultCode=='000000'){
        					Modal.alert({
        						msg:'組織【'+orgName+'】刪除成功!'
        					}).on(queryOrgList());
        					
        				}else if(msg.resultCode=='999999'){
        					Modal.alert({
        						msg:'組織【'+orgName+'】刪除失败!'
        					})
        				}
        			}
        			
        		})
    		}
    		
    	}) ;
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
