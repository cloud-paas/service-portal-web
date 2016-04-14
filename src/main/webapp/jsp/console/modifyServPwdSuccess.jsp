<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<head>
<%@ include file="/jsp/common/common.jsp"%>

<script src="${_base }/resources/js/common/commonUtils.js"></script>
<script type="text/javascript">
	function goBack(url, userServId) {
		postRequest(url, {
			userServId : userServId
		});
	}
</script>

</head>
<body>
	<div class="big_k">
		<!--包含头部 主体-->
		<!--导航-->
		<%@ include file="/jsp/common/header_console.jsp"%>

		<div class="container chanp">
			<%@ include file="/jsp/common/leftMenu_console.jsp"%>
			<div class="row chnap_row">

				<div class="col-md-6 right_list">

					<div class="Open_cache">
						<div class="Open_cache_table">
							<ul>
								<li><a href="#">${userProdInstVo.prodName}</a></li>
							</ul>
						</div>
						<div class="Open_cache_table"
							style="background: rgb(245, 245, 245); height: 30px; vertical-align: middle; line-height: 30px; padding-left: 1%">
							<span>服务名称：</span> <span style="color: rgb(22, 154, 219)">${userProdInstVo.serviceName}</span>
							<span style="margin-left: 10px">服务编码：</span> <span
								style="color: rgb(22, 154, 219)">${userProdInstVo.userServIpaasId}</span>
						</div>
						<div class="Open_cache">

							<div class="xiug_cg">
								<ul>
									<li><img src="${_base }/resources/images/xgcg.png"></li>
									<li>修改密码成功</li>
									<li><A onclick="goBack('${parentUrl}', '${userServId }')" href="javascript:;">返回</A></li>
								</ul>
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
