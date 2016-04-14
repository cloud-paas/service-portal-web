<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<style type="text/css">
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#list_2").addClass("xuanz");
	});
</script>
</head>
<body>
	<div class="big_k">
		<!--包含头部 主体-->
		<!--导航-->
		<div class="navigation">
			<%@ include file="/jsp/common/header.jsp"%>
		</div>
		<div class="container chanp">
			<div class="row chnap_row">
				<div class="col-md-6 left_list">
					<%@include file="/jsp/apply/userCenterList.jsp"%>
				</div>
				<div class="col-md-6 right_list">
					<div class="Open_cache">
						<div class="Open_cache_table">
							<ul>
								<li><a href="${_base}/apply/myAccount">账户管理</a></li>
							</ul>
						</div>
						<div class="Open_cache_table"
							style="background: rgb(245, 245, 245); height: 30px; vertical-align: middle; text-align: center; line-height: 30px; padding-left: 40%">
						</div>

						<div class="zhangh_gl">
							<div class="zhangh_gl_left">
								<img src="${_base}/resources/images/zh_gl.png">
							</div>
							<div class="zhangh_gl_right">
								<ul>
									<li class="zh_mail">${user.userEmail }
							<!--  		<span style=" font-size:15px; color:#03F; margin-left:8px;">
									<a href="#">账户置换</a>&nbsp;|
									<a href="#">密码修改</a>
									</span>-->
									</li>
									<%-- <li>账户ID：${user.userId }</li> --%>
									<li>绑定手机号：${user.userPhoneNum }</li>
									<li>注册时间：${fn:substring(user.userRegisterTime, 0, 19)}</li>
									<li>SDK认证地址：${SDKUrl}</li>
									<li>账户PID：${user.pid}</li>
								</ul>
								 <a href="userNameUpdate"><button class="change-user">账户置换</button></a>
                                 <a href="passwordUpadte"> <button class="change-key">修改密码</button></a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--页脚-->
	<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
</body>
</html>