<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/jsp/common/common.jsp"%>
<script src="${_base }/resources/js/common/prod_param_transfer.js"></script>
<title>我的申请</title>
<script>
	$(function() {
		$(".prod_name").each(function(){
			$(this).css('color',prodColorTransfer($(this).attr("id")));
		});

	});
</script>
</head>

<body>
	<div class="big_k">
		
		<div class="container-fluid">
		<!-- 头部和导航条 -->
		<div class="row">
		<%@ include file="/jsp/common/header.jsp"%>
		</div>
			<div class="row chnap_row">
			<%@ include file="/jsp/common/leftMenu2.jsp"%>
			
				<div class="col-lg-9 ">

					<div class="Open_cache">
						<div class="Open_cache_table">
							<ul>
								<li><a href="#">我的申请</a></li>
							</ul>
						</div>

						
						<c:forEach var="sonList" items="${resultList }">
							<div class="fuw_table">
								<h4 class="prod_name" id="${sonList[0].prodByname}"><script>document.write(prodNameTransfer('${sonList[0].prodByname}'))</script></h4>
								
								<table width="100%" border="0">
									<tr class="bjtr">
										<td>申请订单号</td>
										<td>服务标识</td>
										<!-- <td>服务密码</td> -->
										<td>产品信息</td>
										<td>申请时间</td>
										<td>开通结果</td>
										<td>审批结果</td>
									</tr>
									<c:forEach var="v" items="${sonList }">
										<tr>
											<td>${v.orderDetailId }</td>
											<td>${v.userServIpaasId }</td>
											<%-- <td>${v.userServIpaasPwd}</td> --%>
											<td width=300><script>document.write(prodParamTransfer('${v.prodParam}'));</script></td>
											<td>${fn:substring(v.orderAppDate, 0, 19)}</td>
											<td>${v.openResult }</td>
											<td>${v.orderCheckResult}</td>										
										</tr>
									</c:forEach>
								</table>
							</div>								
						</c:forEach>														
						

					
					</div>

				</div>
			</div>

		</div>

	</div>

	<%@ include file="/jsp/common/footer.jsp"%>

</body>
</html>
