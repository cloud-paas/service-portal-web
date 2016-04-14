<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/jsp/common/common.jsp"%>
<title>注册激活</title>
</head>
<body>
	<jsp:include page="/jsp/common/header.jsp"></jsp:include>
	<div class="row help shenq">


		<div class="steps">

			<div class="steps-tow">
				<div class="steps-tow_A">
					<table width="100%" border="0" cellspacing="1">
						<tr>
							<td class="lan_xi">
								<table border="0" cellspacing="1" align="center">
									<tr>
										<td height="23" align="center" valign="middle"
											class="lan_yuan"><img
											src="${_base }/resources/images/zc1.png"></td>
									</tr>
								</table>
							</td>
							<td class="lan_xi">
								<table border="0" cellspacing="1" align="center">
									<tr>
										<td height="23" align="center" valign="middle"
											class="lan_yuan"><img
											src="${_base }/resources/images/zc2.png"></td>
									</tr>
								</table>
							</td>
							<td class="hui_xi">
								<table border="0" cellspacing="1" align="center">
									<tr>
										<td height="23" align="center" valign="middle"
											class="lan_yuan"><img
											src="${_base }/resources/images/zc3.png"></td>
									</tr>
								</table>
							</td>

						</tr>
						<tr>
							<td height="23" align="center" valign="middle" class="lan_zi">用户注册</td>
							<td height="23" align="center" valign="middle" class="lan_zi">邮箱激活</td>
							<td height="23" align="center" valign="middle" class="lan_zi">注册完成</td>
						</tr>
					</table>
				</div>
			</div>

		</div>


		<div class="zc_youx">
			<ul>
				<li><img src="${_base }/resources/images/zcsb3.png"></li>
				<li class="gx_mail">恭喜您！您已成功注册为亚信云的用户</li>
				<li>亚信云欢迎您，您可以享用亚信云服务了！</li>
				<li class="tow_link"><a href="${_base }/audit/toLogin">进入亚信云</a> <a href="${_base }/audit/toLogin">开通云服务</a></li>
			</ul>

		</div>


		<div></div>
	</div>
	<!--页脚-->
	<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
	<script type="text/javascript">
		$(function() {
			$(".head").wrap(document.createElement("div")).closest("div").addClass("navigation");
		});
	</script>
</body>
</html>