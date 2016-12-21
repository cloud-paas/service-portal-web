<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@page import="com.alibaba.dubbo.common.utils.StringUtils"%>
<%@page import="com.ai.paas.ipaas.system.constants.ConstantsForSession"%>
<%@page import="com.ai.paas.ipaas.user.vo.UserInfoVo"%>
<%  
if (userInfo != null&& !StringUtils.isBlank(userInfo.getUserName())) {
	String userId = userInfo.getUserId();
	request.setAttribute("userId", userId);
	//String indexFlag = request.getAttribute("indexFlag");
}
%>
<script type="text/javascript">
var indexFlag = "${indexFlag}";
var parentUrl = "${parentUrl}";
var productType = "${productType}";


	$(document).ready(function() {
		var userId = "${userId}";
		// 页面初始化
		 $.ajax({
			type : "POST",
			url : "${_base}/dssConsole/queryLeftMenuList",
			dataType : "json",
			data : {
				userId : userId
			},			
			success : function(msg) {
				if (msg.resultCode == '000000') {
					if (msg.resultList.length == 0) {					
						$("#content2").empty();
						$("#content3").empty();
						$("#content4").empty();	
						return;
					}							
					loadleftMenu(msg.resultList);
					
					
				} else {
					$("#content2").empty();
					$("#content3").empty();
					$("#content4").empty();	
					return;
				}
			},
			complete : function(XMLHttpRequest, textStatus) {
				$('.fenye').css('display', 'block');
				$('#loading').shCircleLoader('destroy');
			},
			error : function() {
				report('系统发生异常，数据加载失败，请登陆后重新尝试。');
				$('.fenye').css('display', 'none');
			}
		});
		
	});	
	
	function loadleftMenu(obj) {
		if (!!obj && obj.length == 0) {
			$("#content2").empty();
			$("#content3").empty();	
			$("#content4").empty();	
			return;							
		}
		$("#content2").empty();
		$("#content3").empty();	
		$("#content4").empty();	
		var content2html = '';
		var content3html = '';
		var content4html = '';
		for(var i in obj){		
				if(obj[i].prodType=='1'){															
					content2html += '<p ><A href="${_base}'+ obj[i].consoleUrl +'"  id="leftmenu_'+ i +'_1" onclick=changeUrl("'+ obj[i].consoleUrl +'");><span id="spanleftmenu_'+ i +'" style="margin-top:2px;">'+obj[i].prodName+'</span></A></p>';
				}
				if(obj[i].prodType=='2'){
					content3html += '<p ><A href="${_base}'+ obj[i].consoleUrl +'"  id="leftmenu_'+ i +'_2" onclick=changeUrl("'+ obj[i].consoleUrl +'");><span id="spanleftmenu_'+ i +'" style="margin-top:2px;">'+obj[i].prodName+'</span></A></p>';
				}						
				if(obj[i].prodType=='3'){
					content4html += '<p ><A href="${_base}'+ obj[i].consoleUrl +'"  id="leftmenu_'+ i +'_3" onclick=changeUrl("'+ obj[i].consoleUrl +'");><span id="spanleftmenu_'+ i +'" style="margin-top:2px;">'+obj[i].prodName+'</span></A></p>';
				}				
		}
		$('#content2').append(content2html);	
		$('#content3').append(content3html);
		$('#content4').append(content4html);
		if(indexFlag == '1'){
			$("#leftmenu_0_1").click();
		}
		$('a[id^="leftmenu_"]').each(function() {
			var url=$(this).attr('href');			
			if( url == location.pathname){
				$(this).attr('style', 'margin-top:2px;color:#1699dc');
				var id = $(this).attr('id');
				var prox = id.substr(id.length-1,id.length);
			}
			if( url == parentUrl){
				$(this).attr('style', 'margin-top:2px;color:#1699dc');
			}
		});
	}
	
	function changeUrl(consoleUrl) {
		location.href="${_base}"+consoleUrl;
	}
	
	
	</script>
<div class="col-md-6 left_list" >
      <div class="list_groups">
             <div class="list_groups_none">             
             
             <ul>
             	<li class="biaot" style="background:rgb(22,154,219)"   onClick="turnit(4,3,this);">
             		<a href="#" style="color:#fff">
             		  <p><img src="${_base }/resources/images/icon1.png" style="margin-top:5px;"></p>
             		  <p ><!-- IaaS服务 -->计算服务</p>
             		  <p class="sanjiao"><img src="${_base }/resources/images/a.png" id="img3" style="margin-top:7px;"></p>
             		 </a>
             	</li>
			     <li class="list_xinx"  id="content3" ></li> 
             </ul>               
             
             <ul>
             	<li class="biaot" style="background:rgb(22,154,219)"   onClick="turnit(4,4,this);">
             		<a href="#" style="color:#fff"> 
             		  <p><img src="${_base }/resources/images/icon2.png" style="margin-top:5px;"></p>
             		  <p ><!-- IaaS服务 -->数据库服务</p>
             		  <p class="sanjiao"><img src="${_base }/resources/images/a.png" id="img4" style="margin-top:7px;"></p>
             		</a>
                </li>
			     <li class="list_xinx"  id="content4" ></li> 
             </ul>  
             
             <ul>
             	<li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(4,2,this);">
				<!-- <a href="#" style="color:#fff" ><p id="img2">PaaS服务</p> </a> -->             	
             	<a href="#" style="color:#fff">
            	  <p><img src="${_base }/resources/images/icon3.png" style="margin-top:7px;"></p>
             	  <p><!-- PaaS服务 -->存储服务</p>
           	      <p class="sanjiao"><img src="${_base }/resources/images/a.png" id="img2" style="margin-top:7px;"></p>
               </a>
             	
             	</li>
                <li class="list_xinx"  id="content2" ></li>
             </ul>
             
             <ul>
             	<li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(4,2,this);">
             	<a href="#" style="color:#fff">
            	  <p><img src="${_base }/resources/images/icon3.png" style="margin-top:7px;"></p>
             	  <p>运维配置管理</p>
           	      <p class="sanjiao"><img src="${_base }/resources/images/a.png" id="img2" style="margin-top:7px;"></p>
               </a>
             	
             	</li>
                <li class="list_xinx"  id="content5" >
                <p ><A href="${_base }/jsp/maintain/main.jsp?userId=${userId}"  id="leftmenu_16_1" onclick=changeUrl("${_base }/jsp/maintain/main.jsp?userId=${userId}");><span id="spanleftmenu_16" style="margin-top:2px;">配置管理详情</span></A></p>
                </li>
             </ul>
                         
             
             </div> 
    </div>
  
  </div>