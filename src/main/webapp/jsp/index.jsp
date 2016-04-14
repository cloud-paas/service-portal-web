<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<link href="${_base}/resources/css/jsoneditor/jsoneditor.min.css"rel="stylesheet" />
<script src="${_base}/resources/js/config/config_manage.js"></script>
<script src="${_base}/resources/js/common/fileupload/ajaxfileupload.min.js"></script>
<script src="${_base}/resources/js/common/jsoneditor/jsoneditor.min.js"></script>
<script src="${_base}/resources/js/common/jsonmate/json2.js"></script>
</head>
<script type="text/javascript">
	$(document).ready(function() {
		$("#loginBtn").click(function(){
			if($("#name").val()!=''){
				$("#login-form").submit();
			}else{
				alert("请输入用户名");
			}		
		});
		$("#login-btn").click(function(){
			if($("#login-content").is(":hidden")){
				$("#login-content").fadeIn();
			}
		});
	});
</script>

<body>
	<!--导航-->
	<div class="navigation">
		<div class="navigation_A">
			<div class="logo">
				<img src="${_base}/resources/images/logo.png">
			</div>
			<div class="navigation_list">
				<ul>
					<li><a id="login-btn" href="javascript:void(0)" class="chap">登录</a></li>
					<li><a href="${_base}/config/zk/main" class="chap">Zookeeper管理</a></li>
					<li><a href="#">联系我们</a></li>
				</ul>
			</div>
		</div>
	</div>
	<form id="login-form" action="${_base}/config/maintain/main" method="post">
	<div class="row z_login">
		<div style="display:none" id="login-content" class="login_main">
			<div class="login_box">
				<div class="login_ho"></div>
				<div class="login_wap_wlc">
					<p>登录运维界面</p>
				</div>
				<div class="login_wap_biaod">
					<ul>
						<li class="wa_biaod">
							<p>
								<img src="${_base}/resources/images/icon11.png">
							</p>
							<p>
								<input name="name" id="name" type="text" class="zc_input_a">
							</p>
						</li>					
					</ul>					
					<ul style="margin-top:30px">
						<li class="login_btn"><a id="loginBtn" href="javascript:void(0);">登录</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	</form>
	<div class=" container zc_bottom">
		<p>Copyright©2005-2015 Asiainfo All Rights Reserved</p>
	</div>
</body>
</html>
