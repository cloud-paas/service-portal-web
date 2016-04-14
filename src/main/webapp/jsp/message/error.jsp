<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="/spring-form" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<title>我的消息队列</title>
</head>

<body>
<!-- 头部和导航条 -->
<div class="container chanp"><div class="row">  <div class="navigation"><%@ include file="/jsp/common/header.jsp"%></div></div>
   
<div class="row chnap_row">
	<%@ include file="/jsp/common/leftMenu.jsp"%>
  
  	<div class="col-md-6 right_list">
     
     	<div class="Open_cache">
	              系统错误  
    	</div>      
  	</div>
</div>
<%@ include file="/jsp/common/footer.jsp"%>
<script>
function search(p) {
	var url = "${_base}/message/messageManage?page=" + p ;
	location.href = url;
}

</script>
</body>
</html>
