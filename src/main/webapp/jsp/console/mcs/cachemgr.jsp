<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<script src="${_base }/resources/js/common/commonUtils.js"></script>
<script src="${_base }/resources/js/user/mcs_console.js"></script>
<style type="text/css">
/**头部菜单**/
.mune_1 {
	float: left;
	width: 80%;
	padding-top: 1.8%;
	text-align: center;
}

.mune_1 li {
	float: left;
	list-style: none;
	width: 25%;
	font-size: 22px;
	font-weight: 800;
	color: #fff;
	padding-bottom: 1%;
	cursor: pointer;
}
/**页脚**/
.footer {
	position: relative;
	text-align: center;
	margin-top: 10px;
	line-height: 30px
}

.footer li {
	float: left;
	list-style: none;
	margin: 10px 0px 0px 0px;
	text-align: center;
	position: relative;
	color: #949494;
	font-weight: 800;
	width: auto;
}

.footer span {
	color: #949494;
	font-weight: 800;
	width: auto;
}

#table_detail_mcs {
	text-align: center
}

#table_detail_mcs th {
	text-align: center;
	background: rgb(245, 245, 245);
	font-size: 14px;
}

#table_detail_mcs th,#table_detail_mcs td {
	padding: 10px;
	border: solid 1px #eee
}

#table_detail_mcs a {
	padding: 0px 5px 0px 5px;
	color: rgb(22, 154, 219);
	font-weight: 800;
}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		// 页面初始化
		queryMcsList();
	});
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
								<li><a>${prodName}</a></li>
							</ul>
						</div>
						<div class="Open_cache_table"
							style="background: rgb(245, 245, 245); height: 30px; vertical-align: middle; text-align: center; line-height: 30px; padding-left: 40%">

						</div>
						<div class="Open_cache">
							<div class="Open_cache_list" style="margin: 0">
								<div class="Open_cache_list_tow">
									<table id="table_detail_mcs" style="width: 100%;">
										<tr>
											<th>服务名称</th>
											<th>IPAAS编码</th>
											<th>总容量（M）</th>
											<th>集群模式</th>
											<th>操作</th>
										</tr>
									</table>
								</div>
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