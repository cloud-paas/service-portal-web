<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="shortcut icon" href="../favicon.ico" type="image/x-icon" />
<%
	String _base = request.getContextPath();
	request.setAttribute("_base", _base);
	
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Pragma", "No-cache");
%>

<link href="${_base }/resources/css/bootstrap.min.css" rel="stylesheet">
<link href="${_base }/resources/css/css.css" rel="stylesheet">
<link href="${_base }/resources/css/jquery.shCircleLoader.css" rel="stylesheet">

  
<script src="${_base }/resources/bower_components/jquery/dist/jquery-1.10.2.js"></script>
<script src="${_base }/resources/bower_components/jquery/dist/jquery-ui.js"></script>
<script src="${_base }/resources/bower_components/jquery/dist/jquery.flexslider-min.js"></script>
<script src="${_base }/resources/js/common/list.js"></script>
<script src="${_base }/resources/js/common/table-js.js"></script>
<script src="${_base }/resources/js/common/xialzs.js"></script>
<%-- <script src="${_base }/resources/js/common/top_g.js"></script> --%>
<script src="${_base }/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${_base }/resources/js/common/validate/jquery.validate.min.js"></script>
<script src="${_base }/resources/js/common/validate/additional-methods.min.js"></script>
<script src="${_base }/resources/js/common/jsview/jsviews.min.js"></script>
<script src="${_base }/resources/js/common/paging/bootstrap-paginator.js"></script>
<script src="${_base }/resources/js/common/paging/jquery.shCircleLoader-min.js"></script>
<script src="${_base }/resources/js/common/commonUtils.js"></script>

<!-- 新版本js -->
<%-- <script src="${_base }/resources/js/common_new/daoh_js/jquery-1.9.1.min.js"></script>  --%>
<%-- <script src="${_base }/resources/js/common_new/left_list/list.js"></script> --%>
<%-- <script src="${_base }/resources/js/common_new/table_js/table-js.js"></script>    --%>
<%-- <script src="${_base }/resources/js/common_new/xial_js/xialzs.js"></script> --%>

  <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!--   <script src="js/bootstrap.js"></script> -->
  <!-- Include all compiled plugins (below), or include individual files as needed -->
<!-- <script src="js/bootstrap.min.js"></script> -->
<script>
var _base = "${_base}";
</script>

<!-- system modal start -->
<div id="ycf-alert" class="modal_alert">
	<div class="modal-dialog modal-sm">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">
					<span aria-hidden="true">×</span><span class="sr-only">Close</span>
				</button>
				<h5 class="modal-title">
					<i class="fa fa-exclamation-circle"></i> [Title]
				</h5>
			</div>
			<div class="modal-body small_alert">
				<p>[Message]</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary ok"
					data-dismiss="modal">[BtnOk]</button>
				<button type="button" class="btn btn-default cancel"
					data-dismiss="modal">[BtnCancel]</button>
			</div>
		</div>
	</div>
</div>
<!-- system modal end -->