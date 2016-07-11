<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/jsp/common/common.jsp"%>
<title>下载中心</title>
</head>
<script type="text/javascript">
$(function(){
	$("#navi_tab_download").addClass("chap");//头部高亮显示“下载中心”
});
var message = '${message}'; 
if(message){
	alert("文件不存在！");
	window.location.href = "${_base}/jsp/user/sdkSelect.jsp";
}
</script>
<body>
<div class="big_k">
	 <div class="navigation">
		<%@ include file="/jsp/common/header.jsp"%>
	</div>
	 <div class="container chanp">
	 	<div class="row chnap_row">
	 		<div class="col-md-6 left_list" >
	 			<div class="list_groups">
	 				<div class="list_groups_none">
	 					<ul>
	 						<li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(6,2,this);">
					             <a href="/jsp/user/sdkSelect.jsp" style="color:#fff">
					             <p id="img2">下载</p>
					             </a>
					         </li>
				             <li class="list_xinx"  id="content2" >
				             	<c:if test="${type == 1}">
					             <p class="xuanz"><A href="${_base}/jsp/user/sdkSelect.jsp"><span style="margin-top:2px;">SDK下载</span></A></p>
					             <p><A href="${_base}/audit/toDownloadPage?type=2"><span style="margin-top:2px;">文档下载</span></A></p>
								</c:if>
								<c:if test="${type == 2}">
									<p ><A href="${_base}/jsp/user/sdkSelect.jsp"><span style="margin-top:2px;">SDK下载</span></A></p>
					                <p class="xuanz"><A href="${_base}/audit/toDownloadPage?type=2"><span style="margin-top:2px;">文档下载</span></A></p>
								</c:if>
				             </li>
	 					</ul>
	 				</div>
	 			</div>
	 		</div>
	 	
		 	<div class="col-md-6 right_list">
		 		<div class="Open_cache_table">
		 			<ul style="border-bottom:1px #eee">
						<li>
							<c:if test="${type == 1}">
							<a href="#">SDK下载</a>
							</c:if>
							<c:if test="${type == 2}">
							<a href="#">文档下载</a>
							</c:if>
						</li>
					</ul>
		 		</div>
		 		<div class="download">
		 			<ul>
		 				<c:choose>
		 					<c:when test="${fileList != null }">
				 				<c:forEach var="file" items="${fileList}">
									<li style="float: none;"><span>&bull;</span>
									
									<c:if test="${type==1 }">
									<a href="${_base}/audit/download?fileId=${file}&type=${type}">${file}</a>
									
									</c:if>
									<c:if test="${type==2 }">
									<a href="javascript:void(0)" onclick="downloadFile('${file}','${type}')">${file}</a>
									</c:if>
									
									</li>
								</c:forEach>
		 					
		 					</c:when>
		 					<c:otherwise>
		 						<li style="float: none;">暂无数据</li>
		 					</c:otherwise>
		 				</c:choose>
		 			</ul>
		 		</div>
		 	</div>
		 	</div>
	 </div>
</div>
	   <script>
	   	$(document).ready(function(){
	   		$('a[id^=active_]').each(function(){
	   			$(this).css('color', '#949494');
	   		});
	   		$('#active_download').css('color', '#1699dc');
	   	});
	   	
	   	function downloadFile(fileId,type){
	   	 var url ="${_base}/audit/download?fileId="+fileId+"&type="+type;
	   	 url = encodeURI(encodeURI(url));
	   	 window.location.href=url;
	   	 
	    }
	   </script>
		<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
</body>
</html> 