<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/jsp/common/common.jsp"%>
<title>首页</title>

</head>
<body>
	<jsp:include page="/jsp/common/header.jsp"></jsp:include>

	<div class="container ips_banner">

		<div class="flexslider">
			<ul class="slides">
				<li><img src="${_base }/resources/images/01.png" usemap="#Map">
					<map name="Map">
						<area shape="rect" coords="147,167,322,211"
							href="${_base}/audit/toRegister" style="outline: none;">
					</map></li>
				<li
					style="background: url(${_base }/resources/images/02.png) 50% 0 no-repeat;"></li>
			</ul>
		</div>

	</div>

	<!--掩藏掉滚动
		<div class="container ips_gund">
			<div class="ips_gund_shj">
				<div class="chnap_icon">
					<img src="${_base }/resources/images/lab.png">
				</div>
				<div id="elem" style="overflow: hidden; height: 30px;">
					<div class="chnap_wenz">
						<ul id="elem1">
							<li>．<a href="#">[3-30] OSS域名绑定备案规则变更 </a></li>
							<li>．<a href="#">[3-30] 3月31日采云间升级公告</a></li>
							<li>．<a href="#">[3-27] 4月ECS和VPC升级公告 </a></li>
						</ul>
						<ul id="elem2">
							<li>．<a href="#">[3-30] OSS域名绑定备案规则变更 </a></li>
							<li>．<a href="#">[3-30] 3月31日采云间升级公告</a></li>
							<li>．<a href="#">[3-27] 4月ECS和VPC升级公告 </a></li>
						</ul>
					</div>
				</div>
			</div>

		</div>-->

	<div class="container chanp"><div class="row"> <%@ include file="/jsp/common/header.jsp"%></div>

		<div class="row chnap_index">

			<div class="index_main">
				<!--<div class="cent_jz">
						<img src="${_base }/resources/images/jt_yy.png">
					</div>-->
				<div class="index_main_none">
					<ul>
						<li class="cp_li" style="font-size:18px;color:#f16e34;">我们的产品</li>

					</ul>
				</div>

				<div class="index_main_icon">
					<ul class="bud">
						<li><img src="${_base }/resources/images/in_icon1.png"></li>
						<li class="cu">分布式数据库服务DBS</li>
						<li>Database Service</li>
						<li><A href="${_base }/dbs/introduce" class="yi">立即开通</A></li>
					</ul>
					<ul>
						<li><img src="${_base }/resources/images/in_icon2.png"></li>
						<li class="cu">实时计算RCS</li>
						<li>Realtime Calculation Service</li>
						<li><A href="${_base }/rcs/introduce" class="er">立即开通</A></li>
					</ul>
					<ul>
						<li><img src="${_base }/resources/images/in_icon3.png"></li>
						<li class="cu">消息中心MDS</li>
						<li>Message Delivery Service</li>
						<li><A href="${_base}/mds/introduce" class="san">立即开通</A></li>
					</ul>
					<ul>
						<li><img src="${_base }/resources/images/in_icon4.png"></li>
						<li class="cu">缓存中心MCS</li>
						<li>Memory Cache Service</li>
						<li><A href="${_base }/mcs/introduce" class="si">立即开通</A></li>
					</ul>
				</div>

				<div class="index_main_none">
					<ul>
						<li class="cp_li" style="font-size:18px;color:#f16e34;">我们的客户</li>
						<li class="xian"></li>
					</ul>
				</div>

				<div class="index_main_kehu">
					<ul class="bud">
						<%-- <li><A href="#"><img
								src="${_base }/resources/images/in_icon7.png"></A></li> --%>
							<li><img
								src="${_base }/resources/images/in_icon7.png"></li>	
					</ul>
					<ul>
						<li><img
								src="${_base }/resources/images/in_icon8.png"></li>
					</ul>
					<ul>
						<li><img
								src="${_base }/resources/images/in_icon9.png"></li>
					</ul>
				</div>
			</div>
		</div>
	</div>


	<jsp:include page="/jsp/common/footer.jsp"></jsp:include>

	<script type="text/javascript">
		$(document).ready(function(){
			$('.flexslider').flexslider({
				directionNav : true,
				pauseOnAction : false
			});
		});
		$("#navi_tab_index").addClass("chap");
	</script>
</body>
</html>