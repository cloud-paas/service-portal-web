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
			var zkadr = $("input[name='zkAddress']").val();
			var IP = /^(((?:(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d)))\.){3}(?:25[0-5]|2[0-4]\d|((1\d{2})|([1-9]?\d))))\:\d+)$/;
			for(var value in zkadr.split(',')){
				if(!IP.test(zkadr.split(',')[value])){
					alert("输入IP地址有误，请按照示例输入");
					return;
				}				
			}
			var data = {
					zkAddress : $("input[name='zkAddress']").val(),
					zkTypeCode : $("select[name='zkTypeCode']").val(),
					zkDescription : $("input[name='zkDescription']").val(),
					superAuthName : $("input[name='superAuthName']").val(),
					superAuthPassword : $("input[name='superAuthPassword']").val()
			};
			$.ajax({
				type : 'POST',
				url : _base + '/config/zk/insert',
				dataType : 'json',
				contentType : "application/json; charset=utf-8",
				data : JSON.stringify(data),
				success : function(data) {
					if (data.resultCode == "000000") {
						alert("成功！");
					} else {
						alert("失败");
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
                            <li><a href="${_base}/config/zk/goInitUser">初始化用户</a></li>
                        </ul>
                    </div>
                    <div class="Open_cache_list">
						<div class="Open_cache_list_tow">
							<ul>
								<li class="font-title">zk_address：</li>
								<li class="font-title"><input type="text" name="zkAddress" value=""></li>
								<li>示例：10.1.228.198:2182,10.1.228.119:9999</li>
							</ul>
							<ul>
								<li class="font-title">zk_type_code：</li>
								<li class="font-title"><select style="width:174px;height:28px" name="zkTypeCode" value="">
											<option>1</option>
											<option>2</option>
										</select></li>
								<li>注释：zk类型，1—用户paas平台内部，2-用于paas平台外部</li>
							</ul>
							<ul>
								<li class="font-title">zk_description：</li>
								<li class="font-title"><input type="text" name="zkDescription" value=""></li>
							</ul>
							<ul>
								<li class="font-title">super_auth_name：</li>
								<li class="font-title"><input type="text" name="superAuthName" value=""></li>
							</ul>
							<ul>
								<li class="font-title">super_auth_password：</li>
								<li class="font-title"><input type="text" name="superAuthPassword" value=""></li>
							</ul>
							<ul>
								<li class="open_btn"><A href="javascript:void(0);"
									style="margin-top: 20px; text-align: center; -moz-border-radius: 15px; border-radius: 15px; width: 130px; height: 30px; background: rgb(121, 189, 90); line-height: 30px; vertical-align: middle; color: #fff"
									id="commitBtn">立即开通</A></li>
							</ul>
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
