<%@page import="com.alibaba.dubbo.common.utils.StringUtils"%>
<%@page import="com.ai.paas.ipaas.system.constants.ConstantsForSession"%>
<%@page import="com.ai.paas.ipaas.user.vo.UserInfoVo"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
	HttpSession Session = request.getSession();
	UserInfoVo userInfo = (UserInfoVo) Session
			.getAttribute(ConstantsForSession.LoginSession.USER_INFO);
	if (userInfo != null
			&& !StringUtils.isBlank(userInfo.getUserName())) {
		String userName = userInfo.getUserName();
		request.setAttribute("userName", userName);
	}
	String baseLocation = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
	if(baseLocation==null || "".equals(baseLocation)){
		request.setAttribute("_base", basePath);
	}else{
		request.setAttribute("_base", baseLocation);
	}
%>
<script type="text/javascript">
	var userName = "${userName}";
	var _base = "${_base}";
	$(document).ready(function() {
		//鼠标经过事件
		$('.product').mouseover(function(){
			$('.product-box').css('display','inline-block')
		})
		$('.product-box').mouseover(function(){
			$('.product-box').css('display','inline-block')
		}).mouseout(function(){
			$('.product-box').css('display','none');
		})
		
		if (userName != "") {
			var userName1 = userName;
			if (userName.length > 5) {
				userName1 = userName.substr(0, 5) + "...";
			}
			$("#welcomeInfo").text("");
			var html = "<span style='color:#a8a8a8' title='"+userName+"'>"
					+ userName1
					+ "</span><span style='color:#a8a8a8'>您好，欢迎来到亚信云</span>";
			$("#welcomeInfo").append(html);
			$("#PleaseLogin").addClass("hidden");
			$("#signout").show();
			$("#pleaseRegiste").addClass("hidden");
		} else {
			//$("#welcomeInfo").text("");
			$("#signout").addClass("hidden");
		}
	});
	
</script>
<title>亚信云</title>
<div class="head" style="position:relative;"> 
	<div style="width: 100%; height: auto">
		<div style="float: left; width: 15%; position: relative; left: 3%">
			<img src="${_base }/resources/images/aiyun.png"
				style="position: relative; margin: 20px 20px 0px 0px" width="120">
		</div>
		<div class="mune_daoh">
			<ul>
				<li><a id="active_index" href="${_base }"
					style="color: #1699dc">首页</a></li>
				<li class="product"><a id="active_prod" href="${_base }/virtualMachine/initapply" style="color: #7d7d7d">产品</a></li>
				<%-- href="${_base }/ccs/introduce" --%>
				<li><a id="active_download"
					href="${_base}/jsp/user/sdkSelect.jsp" style="color: #7d7d7d">下载</a></li>
				<li><a id="active_help"
					href="${_base}/help/center" style="color: #7d7d7d">帮助中心</a></li>
			</ul>
		</div>
		<div class="product-box">
			<ul class="js-ul">
				<li class="common-li-tittle">计算</li>
				<!--  <li><a href="${_base }/iaas/applyPhysicalMachine">物理机</a></li>-->
				<!--  <li><a href="${_base }/iaas/applyVirtalMachine">虚拟机</a></li>   -->
				<li><a href="${_base }/virtualMachine/initapply">云虚拟机</a></li>
				<li><a href="${_base }/rcs/introduce">实时计算RCS</a></li>
				<li><a href="${_base }/des/initapply">实时增量数据获取服务DES</a></li>
				<li><a href="${_base }/ses/initapply">搜索服务SES</a></li>
			</ul>
			<ul class="data-ul">
				<li class="common-li-tittle">数据库服务</li>
				<li><a href="${_base }/dbs/introduce">分布式数据库DBS服务</a></li>
				<li><a href="${_base }/txs/introduce">事务保障服务TXS</a></li>
				<li><a href="${_base }/ats/introduce">最终事务一致ATS</a></li>
				<li><a href="${_base }/rds/introduce">云数据库服务RDS</a></li>
			</ul>
			<ul class="save-ul">
				<li class="common-li-tittle">存储</li>
				<li><a href="${_base }/ccs/introduce">配置中心CSS</a></li>
				<li><a href="${_base }/mcs/introduce">缓存中心MCS</a></li>
				<li><a href="${_base }/mds/introduce">消息中心MDS</a></li>
				<li><a href="${_base }/dss/introduce">文档存储服务DSS</a></li>
				<li><a href="${_base }/idps/introduce">图片服务IDPS</a></li>
	        </li>
			</ul>
		</div>
		<div class="mune_xinxi">
			<ul>
				<li id="welcomeInfo" style="color: #a8a8a8">欢迎来到亚信云！</li>
				<li id="PleaseLogin"><a href="${_base }/audit/toLogin"
					style="color: #a8a8a8">登录</a></li>
				<li id="signout"><a href="${_base }/audit/toSignOut"
					style="color: #a8a8a8">退出</a></li>
				<li id="pleaseRegiste"><a href="${_base }/audit/toRegister"
					style="color: #a8a8a8">注册</a></li>
				<li><A href="${_base }/apply/purchaseRecords?prodType=1&currentPage=1"
					style="color: #a8a8a8">用户中心</A></li>
				<li><A href="${_base }/dssConsole/toConsole"
					style="color: #a8a8a8">管理控制台</A></li>
			</ul>
		</div>
	</div>
</div>
<style>

.product-box{width: 631px;height: 279px;background: #fff;border: 1px solid #ccc;box-shadow: 0px 2px 10px #ccc;position: absolute;left: 60px;top: 78px;padding-top: 30px;display: none;z-index:100;}
.product-box ul{float: left;}
.product-box a{color: #999;font-size: 15px;font-family: "黑体";letter-spacing:1px;}
.product-box a:hover{color: #1699DD}
.product-box .common-li-tittle{font-size: 18px;color: #333;font-weight: bold;margin-bottom: 20px;}
.product-box li{margin-bottom: 10px;}
.js-ul{margin-left: 40px;}
.data-ul{margin-left: 30px;}
.save-ul{margin-left: 39px;}
</style>

