<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
<title>消息中心MDS</title>
<%@ include file="/jsp/common/common.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		// 页面初始化

	});	
	function cancle(userServId) {
		$.ajax({
			async : false,
			type : "POST",
			url : "${_base}/mdsConsole/cancleMds",
			modal : true,
			showBusi : false,
			data : {									
				userServId	: userServId
			},
			success: function(data){
				var json=data		
				
				if(json&&json.resultCode=="000000"){	
					Modal.alert({
						msg:"注销成功！"
					}).on(function(){
						location.href="${_base}/mdsConsole/toMdsConsole";
					})
					
				}else{	
					Modal.alert({
						msg:"操作失败"
					})
					 	
				}
			}
		});	
	}
	
	//验证mds服务
	function checkService(userServIpaasId,topicId)
	{
	    var svcPwd=prompt("请输入服务密码：");
	    if(svcPwd)
	    {
	    	var pid= "${userInfoVO.pid}";
	        alert("服务ID: "+userServIpaasId+" & 服务密码: "+ svcPwd+ " & PID："+pid+ " & topicId："+topicId);       
	    }
	    $.ajax({
			type : "POST",
			url : "${_base}/ServiceCheck/toCheckMdsService",
			dataType : "json",
			data:"serviceId="+userServIpaasId+"&pid="+pid+"&servicePwd="+ svcPwd+"&topicId="+ topicId,
			
			success : function(msg) {
				if (msg.mdsCode == '111111') {
					alert("恭喜，MDS服务 "+userServIpaasId +" 验证成功 ! \n MDSMessage is ：\n"
							+msg.mdsSenderMsg+" && "+msg.mdsConsumerMsg);
				} else {
					alert("MDS服务 "+userServIpaasId +" 验证失败 !");
				}
			},
			error : function() {
				alert("MDS服务 "+userServIpaasId +" 验证失败 !");
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
     <input type="hidden" id="userServId" value="${prod.userServId }"/>
     <div class="Open_cache">
        <div class="Open_cache_table">
			<ul>
			<li><a href="#">消息中心MDS</a></li> 
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
							<th>IPAAS编码</th>
							<th>产品名称</th>
							<th style="width:486px">队列名称</th>
							<th>分片数</th>
							<th style="width:64px">操作</th> 
						</tr>	
						<c:forEach items="${prodList }" var="prod">
							<tr>
								<td>${prod.userServParamMap.topicName }</td>
								<td>${prod.userServIpaasId }</td>
								<td>${prod.userProdByname }</td>
								<td>${prod.userServParamMap.topicEnName } </td>
								<td>${prod.userServParamMap.topicPartitions }</td>
								<td><a href="queryMdsInstById?userServId=${prod.userServId }">查看</a><br><br>
								<a id="cancle_back" onclick="cancle('${prod.userServId }');" href="javascript:void(0)">注销</a><br><br>
								<a id="check_svc" onclick="checkService('${prod.userServIpaasId }','${prod.userServParamMap.topicEnName }');" href="javascript:void(0)">服务验证</a></td>
								
							</tr>
						</c:forEach>					
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
