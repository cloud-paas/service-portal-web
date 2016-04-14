<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/jsp/common/common.jsp"%>
<title>用户中心</title>

</head>
<body>
	<jsp:include page="/jsp/common/header.jsp"></jsp:include>
	<div class="row chnap_row">
		<%@ include file="/jsp/common/leftMenu.jsp"%>
		<div class="col-md-6 right_list">

			<div class="Open_cache">

				<div class="Open_cache_table">
					<ul>
						<li><a href="#">我的服务</a></li>
					</ul>
				</div>

				<!--我的服务-->
				<div class="fuw_search">
					<ul>
						<li><input  id="searchName" name="searchName" type="text" class="search_ch"/></li>
						<li class="open_btn"><a id="btn_search" href="#">搜索</a></li>
					</ul>
				</div>

				<div class="fuw_table">

							 <table width="100%" border="0">
								<tr class="bjtr">
									<td>服务名称</td>
									<td>生效时间</td>
									<td>服务状态</td>
									<td>操作</td>
								</tr>
								<c:forEach var="v" items="${pagingResult.resultList}"
									varStatus="vs">
									<tr>
										<td>${v.serviceName}</td>
										<td><fmt:formatDate value="${v.validateTime}" type="both"
												pattern="yyyy-MM-dd HH:mm:ss" /></td>
										<td><c:if test="${v.status eq '0'}">停用</c:if> <c:if
												test="${v.status eq '1'}">启用</c:if></td>
										<td><a href="<c:url value="${v.url}" />" target="_blank">操作</a></td>
									</tr>
								</c:forEach>
							</table>
							<jsp:include page="/jsp/storm/common/jsp/page.jsp"></jsp:include>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/jsp/common/footer.jsp"></jsp:include>

	<script type="text/javascript">
		$("#btn_search").bind("click", function() {
			search(1);
		});
		function search(p) {
			var url = "${_base}/audit/uCenter?page=" + p + "&searchName="
					+ encodeURI(encodeURI($("#searchName").val()));
			location.href = url;
		}
	</script>
</body>
</html>