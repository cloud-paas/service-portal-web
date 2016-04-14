<%@page import="com.ai.paas.ipaas.storm.sys.utils.StringUtils"%>
<%@page import="com.ai.paas.ipaas.system.constants.ConstantsForSession"%>
<%@page import="com.ai.paas.ipaas.user.vo.UserInfoVo"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%
   
HttpSession Session = request.getSession();
UserInfoVo userInfo = (UserInfoVo) Session.getAttribute(ConstantsForSession.LoginSession.USER_INFO);
if (userInfo != null&& !StringUtils.isBlank(userInfo.getUserName())) {
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
	$(document)
			.ready(
					function() {
						if (userName != "") {
							$("#userName").text("");
							$("#userName").append(userName);
						} 
					});
	
	
	function changeHref() {
		alert(1);
		
	}
</script>
<title>亚信云用户控制台</title>
 <div class="navigation" style="background:rgb(22,154,219);height:70px">
  <div class="head">
               <input type="hidden" name="userServId" id="userServId"/>
				<div style="width: 100%; height: auto">
					<div style="float: left; width: 13%; position: relative; left: 1%">
						<img src="${_base }/resources/images/logo-white2.png"
							style="position: relative; margin: 18px 20px 0px 0px;height:35px">
					</div>
					<div class="mune_lan" style="padding-top:1.5%;">
						<ul>
                        <li class="yon_wnz"  style="margin-left:20px;font-size:20px;margin-top:0px;"><a href="${_base }"  title="返回首页"><img style="height:30px;padding-bottom:5px" src="${_base }/resources/images/return.png"/></a></li> 
						<li class="yon_wnz"  style="padding-bottom:5px;margin-left:50px;font-size:20px;">管理控制台</li> 
						</ul>
						<ul style="float:right">
							<li id="userName" class="yonhz"></li>  
						</ul>
					</div> 
				</div>
			</div>
   </div>
 
   