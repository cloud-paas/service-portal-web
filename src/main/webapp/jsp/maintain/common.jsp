<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<%
	String _base = request.getContextPath();
	request.setAttribute("_base", _base);
	
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma", "No-cache");
%>

<link href="${_base }/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="${_base }/resources/css/css.css" rel="stylesheet">
  
<script src="${_base }/resources/bower_components/jquery/dist/jquery-1.9.1.min.js"></script>
<script src="${_base }/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${_base }/resources/js/common/validate/jquery.validate.min.js"></script>
<script src="${_base }/resources/js/common/validate/additional-methods.min.js"></script>
<script src="${_base}/resources/js/common/jsview/jsviews.min.js"></script>
<script>
var _base = "${_base}";
</script>