<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="/spring-form" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<title>我的消息队列</title>
    <script>
	var openOCSController;
	$(document).ready(function(){
		openOCSController = new $.OpenOCSController();
	});
	/*定义页面管理类*/
	(function(){
		$.OpenOCSController  = function(){ 
			this.settings = $.extend(true,{},$.OpenOCSController.defaults); 
			this.init();
			
		};
		$.extend($.OpenOCSController,{
			defaults : {
			             SIZE_ID : "#my_size",
			             TIME_ID : "#my_time",
			     		 PLUS_ID : "#my_plus",
			     		MINUS_ID : "#my_minus",
			     		  NUM_ID : "#my_num",
			      MESSAGE_DELETE : ".message_delete",
			     	   SUBMIT_ID : "#mySubmit"
			     	   
			},
			prototype : {
				init : function(){
					var _this = this;
					_this.addRults();
					_this.bindEvents();				
				},
				bindEvents : function(){
					var _this = this;
					
					
				},			
				addRults : function() {				
					
				}
			}
		});
	})(jQuery);
	
	function delMessageQueue(queueId){
		
		if(confirm("确定要删除该消息队列吗？该队列下可能还有未处理完的消息")){
			var url = "messageDelete?queueId="+queueId;
			$.post(url,function(data){
				if(data.result==1){
					$("#messageQueueTr_"+queueId).slideToggle();
				}
			});	
		}
		
		
	}
	</script>
</head>

<body>
<!-- 头部和导航条 -->
<div class="container chanp"><div class="row">  <div class="navigation"><%@ include file="/jsp/common/header.jsp"%></div></div>
   
<div class="row chnap_row">
	<%@ include file="/jsp/common/leftMenu.jsp"%>
  
  	<div class="col-md-6 right_list">
     
     	<div class="Open_cache">
	        <div class="Open_cache_table">
	        	<ul>
	        		<li><a href="#">我的消息队列</a></li>
	        	</ul>
        	</div>
        	<div class="fuw_search">
        		<ul>
        			<li class="xil" id="message_add_btn" style=" float:right;"><A href="addMessage" class="gy_btn">新增</A></li>
        		</ul>
        	</div>
        	<div class="fuw_table">
        		<table width="100%" border="0">
        			<tr class="bjtr">
        				<td>队列名称</td>
					    <td>队列编码</td>
					    <td>最大并发数</td>
					    <td>消息备份数</td>
					    <td>创建时间</td>
					    <td>操作</td>
        			</tr>
        			<c:forEach items="${pagingResult.resultList }" var="messageQueue">
        			<tr id="messageQueueTr_${messageQueue.queueId }">
					    <td>${messageQueue.queueName }</td>
					    <td>${messageQueue.queueNameEn }</td>
					    <td>${messageQueue.partitions }</td>
					    <td>${messageQueue.replications }</td>
					    <td><fmt:formatDate value="${messageQueue.createTime }" type="both" pattern="yyyy-MM-dd HH:mm:ss" /></td>
					    <td><A href="editMessage?queueId=${messageQueue.queueId }">修改</A>&nbsp;
					        <A href="javascript:void(0)" onclick="javascript:delMessageQueue('${messageQueue.queueId }')" class="message_delete">删除</A>&nbsp;
					        <A href="javascript:void(0)" onclick="javascript:delMessageQueue('${messageQueue.queueId }')" class="message_delete">查看</A>
					    </td>
					   </tr>
        			</c:forEach>
        		</table>
        		 <nav class="fenye">
							<span style="font-size: 14px;">
								<ul class="pagination" id="pageUl">
								</ul>
							</span>
			  	</nav>
        	</div>
	                
    	</div>      
  	</div>
</div>
<%@ include file="/jsp/common/footer.jsp"%>
<script>
function search(p) {
	var url = "${_base}/message/messageManage?page=" + p ;
	location.href = url;
}
$(function(){
	
	$("#list_0").addClass("xuanz");
	var options = {
			bootstrapMajorVersion : 3,
			currentPage : "${pagingResult.currentPage}",//当前页面
			numberOfPages : 10,//一页显示几个按钮（在ul里面生成5个li）
			totalPages : "${pagingResult.totalCount }"
		//总页数
		}
		$('#pageUl').bootstrapPaginator(options);
	
})


</script>
</body>
</html>
