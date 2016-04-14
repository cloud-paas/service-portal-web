<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/jsp/common/common.jsp"%>

<%
String timeLimit = "1435219344413";
String email = session.getAttribute("email") == null ? "" : session.getAttribute("email").toString();
if(!"".equals(email)){
	timeLimit = session.getAttribute(email) == null ? timeLimit : session.getAttribute(email).toString();
}
%>

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
											class="hui_yuan"><img
											src="${_base }/resources/images/zc3.png"></td>
									</tr>
								</table>
							</td>

						</tr>
						<tr>
							<td height="23" align="center" valign="middle" class="lan_zi">用户注册</td>
							<td height="23" align="center" valign="middle" class="lan_zi">邮箱激活</td>
							<td height="23" align="center" valign="middle" class="hui_zi">注册完成</td>
						</tr>
					</table>
				</div>
			</div>

		</div>


		<div class="zc_youx">
			<ul>
				<li class="zc_mail" style="font-weight: bold;">亲爱的${email}，欢迎加入亚信云！</li>
				<li>为保证您的邮箱安全使用，请点击
				<a id="activeAccount" href="javascript:void(0);">激活邮箱</a>完成验证
				</li>
				<li><a id="resendActiveEmail" href="javascript:void(0);">重新发送</a>
				<a id="sending" href="javascript:void(0);"
					style="display: none; color: gray;">正在发送...</a></li>
			</ul>

		</div>


		<div></div>
	</div>
	<!--页脚-->
	<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
	<script type="text/javascript">
		$(function() {
			var timeLImit = '<%=timeLimit%>';
			var timestamp2 = (new Date()).valueOf();
			$("#resendActiveEmail").hide();
			$("#sending").hide();
			$(".head").wrap(document.createElement("div")).closest("div")
					.addClass("navigation");
			$("#activeAccount").on("click", function() {
				var hash = {
					'asiainfo.com' : 'http://mail.asiainfo.com',
					'qq.com' : 'http://mail.qq.com',
					'gmail.com' : 'http://mail.google.com',
					'sina.com' : 'http://mail.sina.com.cn',
					'163.com' : 'http://mail.163.com',
					'126.com' : 'http://mail.126.com',
					'yeah.net' : 'http://www.yeah.net/',
					'sohu.com' : 'http://mail.sohu.com/',
					'tom.com' : 'http://mail.tom.com/',
					'sogou.com' : 'http://mail.sogou.com/',
					'139.com' : 'http://mail.10086.cn/',
					'hotmail.com' : 'http://www.hotmail.com',
					'live.com' : 'http://login.live.com/',
					'live.cn' : 'http://login.live.cn/',
					'live.com.cn' : 'http://login.live.com.cn',
					'189.com' : 'http://webmail16.189.cn/webmail/',
					'yahoo.com.cn' : 'http://mail.cn.yahoo.com/',
					'yahoo.cn' : 'http://mail.cn.yahoo.com/',
					'eyou.com' : 'http://www.eyou.com/',
					'21cn.com' : 'http://mail.21cn.com/',
					'188.com' : 'http://www.188.com/',
					'foxmail.coom' : 'http://www.foxmail.com'
				};
				var email = "${email}";
				var url = email.split('@')[1];
				//window.location.href = hash[url];
				window.open(hash[url],"_blank");

			});
			var canSend = true;
			var timeInit = parseInt((timestamp2-timeLImit)/1000);
			var lim = 60-timeInit;
			if(timeInit < 60){
				var handerInit = setInterval(function() {
					$("#sending").show();
					lim--;
					if (lim <= 0) {
						canSend = true;
						clearInterval(handerInit);
						$("#sending").hide();
						$("#resendActiveEmail").show();
						$("#resendActiveEmail").removeAttr("disabled style");
					} else {
						canSend = false;
						$("#sending").attr({"disabled" : "disabled"}).css('cursor', 'not-allowed');
						$("#sending").text(lim+ "秒后可重新发送");
					}
				}, 1000);
			}else{
				canSend = true;
				$("#sending").hide();
				$("#resendActiveEmail").show();
				$("#resendActiveEmail").removeAttr("disabled style");
			}
			$("#resendActiveEmail").click(function() {
				$("#resendActiveEmail").hide();
				$("#sending").show().text("正在发送...");
				if (!canSend)
					return;
				var btn = $(this);
				var time = 60;
				if (canSend) {
					var email = "${email}";
					var url = "${_base}/email/sendEmail";
					var subject = "亚信云  激活验证链接";
					$.ajax({
						type : "post",
						url : url,
						data : {
							"subject" : subject,
							"toSenders" : email
						},
						success : function(data) {
							$("#sending").text("发送成功");
							var hander = setInterval(function() {
								time--;
								if (time <= 0) {
									canSend = true;
									clearInterval(hander);
									$("#sending").hide();
									btn.show();
									btn.removeAttr("disabled style");
								} else {
									canSend = false;
									$("#sending").attr({"disabled" : "disabled"}).css('cursor', 'not-allowed');
									$("#sending").text(time + "秒后可重新发送");
								}
							}, 1000);
						},
						error : function(msg) {
							$("#resendActiveEmail").text("发送失败");
						}
					});
				}

			});
		});
	</script>
</body>
</html>