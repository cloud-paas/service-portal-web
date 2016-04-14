<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/jsp/common/common.jsp"%>
<title>登录</title>
<script type="text/javascript">
	var urlInfo = "${urlInfo}";

	$(document).ready(function() {

		function ntlogin() {
			var url = "${_base}/audit/doNTLogin";
			$.ajax({
				type : "post",
				url : url,
				success : function(data) {
					if (data.returnFlag == "success") {
						var redirectUrl = urlInfo;
						
						if (redirectUrl == "" || redirectUrl == "undefined") {
							redirectUrl = "${_base}";
						} else {
							redirectUrl = decodeURI(urlInfo);
						}
						window.location.href = redirectUrl;
					} else {
						redirectUrl = "${_base}";
					}
				}
			
			});
		}
		ntlogin();
	});
</script>
</head>

<body>



</body>



</html>