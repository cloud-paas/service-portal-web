<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<title>消息通知</title>
<script type="text/javascript">
function slideDiv(msgId){
	$("#content_"+msgId).slideToggle();
	
}
</script>
  
</head>
<body>
	<div class="big_k">
	<!-- 头部和导航条 -->
	<div class="navigation">
		<%@ include file="/jsp/common/header.jsp"%>
	</div>
   <div class="container chanp">
  <div class="row chnap_row">
  <div class="col-md-6 left_list" >
      <%@include file="/jsp/apply/userCenterList.jsp" %>
  
  </div>
				<div class="col-md-6 right_list">
					<div class="Open_cache">
						<div class="Open_cache_table">
							<ul style="border-bottom:1px #eee">
							<li><a href="#">消息中心</a></li> 
							</ul>  
				        </div> 
				        <div id="sq_js1" style="min-height: 400px;">
				        	<div class="application">
				        		<ul>
						       <li class="ahov"><A href="javascript:void(0)">订购消息</A></li>
						       </ul>
				        	</div>
				        	
					        	<div class="dg_message">
				        	<c:forEach var="v" items="${pagingResult.resultList}" varStatus="vs">
					        		<ul>
					        			<li onclick="javascript:slideDiv('${v.userMsgId }')"><a href="javascript:void(0)"><img src="${_base }/resources/images/yj.png"></a></li>
					        			<li onclick="javascript:slideDiv('${v.userMsgId }')"><a href="javascript:void(0)">${v.userMsgContent}</a></li>
					        			<li class="move"><fmt:formatDate value="${v.userMsgSendTime}" pattern="yy-MM-dd HH:mm:ss"/></li>
					        			<div class="zk_mail" id="content_${v.userMsgId }" style="display:none;">
									        <div class="zk_mail_A">审核结果通知</div>
									        <div class="zk_mail_B">
									        <ul>
									        <li>亲爱的${userName}，您好：</li>
									        <li class="nyr">${v.userMsgContent},时间：<fmt:formatDate value="${v.userMsgSendTime}" pattern="yy-MM-dd HH:mm:ss"/>；</li>
									        <li class="nyra">若您对结果有异议，请联系运维人员！</li>
									        </ul>
									        </div>
									        <div class="zk_mail_C">
									        <ul>
									        <li>联系人:${AdminName}</li>
									        <li>手机号:${AdminPhone} </li>
									        <li>邮  箱:${AdminEmail}</li>                                                   
									        </ul>
									       </div>
									      </div>
					        		</ul>
				        	</c:forEach>
					        	</div>
				        </div>
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
	</div>
	<!--底部-->
	<%@ include file="/jsp/common/footer.jsp"%>
	
	<script>
function paging(p) {
	 location.href="${_base}/mds/messageDisplay?page="+p;
}
$(function(){
	
	$("#list_0").addClass("xuanz");
	var options = {
			bootstrapMajorVersion : 3,
			currentPage : "${pagingResult.currentPage}",//当前页面
			numberOfPages : 10,//一页显示几个按钮（在ul里面生成5个li）
			totalPages : "${pagingResult.totalPages }"
		//总页数
		}
		$('#pageUl').bootstrapPaginator(options);
	
})


</script>
</body>
</html>