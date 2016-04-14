<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/jsp/common/common.jsp" %>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <style type="text/css">
	.font-title {
		font-size: 18px;
		font-weight: 600;
		color: #000;
		padding-left: 1%;
		width:200px;
	}
	</style>
<script>
	$(document).ready(function() {
		$("#commitBtn").click(function() {			
			var data = {
				userId : $("input[name='userName']").val()
			};
			$.ajax({
				type : 'POST',
				url : _base + '/config/zk/initUser',
				dataType : 'json',
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(data),
				success : function(data) {
					if (data.resultCode == "000000") {
						$("#configAddr").html(data.configAddr);
						$("#configPwd").html(data.configPwd);
						$("#show").show();
					} else {
						alert(data.resultMessage);
					}
				}
			});
		});
	});
</script>
</head>

<body>
<div class="big_k"><!--包含头部 主体-->
    <div class="herd">
        <div class="wrap">
            <ul class="wrap_left">
                <li>欢迎来到IpaaS</li>
            </ul>
        </div>
    </div>

    <!--导航-->
    <div class="navigation">
        <div class="navigation_A">
            <div class="logo"><img src="${_base}/resources/images/logo.png"></div>
        </div>
    </div>
    <div class="container chanp">
        <div class="row chnap_row xing_zx">
            <div class="col-md-6 right_list">
                <div class="Open_cache">
                    <div class="Open_cache_table xing_zx_tab">
                        <ul>
                            <li><a href="${_base}/config/zk/main">配置Zookeeper</a></li>
                            <li><a href="${_base}/config/zk/initUser">初始化用户</a></li>
                        </ul>
                    </div>
                    <div class="Open_cache_list">
						<div class="Open_cache_list_tow">
							<ul>
								<li class="font-title">用户ID：</li>
								<li class="font-title"><input type="text" name="userName" value=""></li>
							</ul>
							<ul>
								<li class="open_btn"><A href="javascript:void(0);"
									style="margin-top: 20px; text-align: center; -moz-border-radius: 15px; border-radius: 15px; width: 130px; height: 30px; background: rgb(121, 189, 90); line-height: 30px; vertical-align: middle; color: #fff"
									id="commitBtn">立即创建</A></li>
							</ul>
<!-- 							<ul> -->
<!-- 								<li class="font-title">密码：</li> -->
<!-- 								<li class="font-title"><input type="text" name="userPwd" value=""></li> -->
<!-- 							</ul> -->
						</div>
						<div id="show" style="display:none">
							<table width="100%" border="1">
								<tbody>
									<tr>
										<td>configPwd</td>
										<td id="configPwd"></td>
									</tr>
									<tr>
										<td>configAddr</td>
										<td id="configAddr"></td>
									</tr>
								</tbody>
							</table>
<!-- 							<ul> -->
<!-- 								<li >configPwd：</li> -->
<!-- 								<li ><textarea id="configPwd" value=""></li> -->
<!-- 							</ul> -->
<!-- 							<ul> -->
<!-- 								<li>configAddr：</li> -->
<!-- 								<li ><textarea id="configAddr" value=""></li> -->
<!-- 							</ul> -->
						</div>
					</div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container bott_xinx">
    <p>Copyright©2005-2015 Asiainfo All Rights Reserved </p>
</div>
</body>
</html>
