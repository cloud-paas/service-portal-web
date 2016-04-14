<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-cn">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>亚信云</title>
  <head>
   <%@ include file="/jsp/common/common.jsp"%>
            <style>
		hr {height:1px;  
			color:gray;  
			background-color:gray;  
			border:none;
		}
	</style>
  </head> 
  <body>    
   <script>
   	$(document).ready(function(){
   		$('a[id^=active_]').each(function(){
   			$(this).css('color', '#949494');
   		});
   		$('#active_help').css('color', '#1699dc');
//    		$('.mune_2').css('padding-left', '1%');
   		
   	});
   </script>
   <!--导航-->
   <div class="navigation">
		<%@ include file="/jsp/common/header.jsp"%>
		</div>
  <div class="row help shenq" >
       
        <div class="help_fist" id="guide">
       <p style="color: #3e3e3e;font-size: 18x;font-weight:bold;">入门指南</p>
       </div>
       
       <div class="help_xinxi">
       <a href="${_base }/help/nt">
	       <ul style="margin-left:0px;">
	       <li class="ntimg" style="left: 130px;"><img src="${_base }/resources/images/222.png"></li>
	       <li style="color: #3e3e3e;font-size: 17px;">亚信邮箱登录</li>
	       </ul>
       </a>
       <a href="${_base }/help/mail">
       <ul>
       <li class="ntimg" style="left: 130px;"><img src="${_base }/resources/images/11.png"></li>
       <li style="color: #3e3e3e;font-size: 17px;">Iaas资源申请流程</li>
       </ul>
       </a>
       <a href="${_base }/help/paas">
       <ul>
       <li class="ntimg" style="left: 130px;"><img src="${_base }/resources/images/help_d.png"></li>
       <li style="color: #3e3e3e;font-size: 17px;">Paas服务申请流程</li>
       </ul>
       </a>
       </div>
       
       
       <div class="help_fist"  id="FAQ">
       <p style="color: #3e3e3e;font-size: 18x;font-weight:bold;">常见问题</p>
       </div>
       
        <div class="chanj_w" style="position: relative;">
        <ul>
        <li>
        <p class="chan_wen"><span>Q：</span><a href="${_base }/help/FAQ" style="color: #555555;font-size: 16px;">Paas服务的SDK认证地址参数何如获取</a></p>
        <p><a href="${_base }/help/FAQ"><img src="${_base }/resources/images/help_q.png"></a></p>
        </li>
        <li>
        <p class="chan_wen"><span>Q：</span><a href="${_base }/help/FAQ#SAAS" style="color: #555555;font-size: 16px;">使用Paas的SDK开发的Saas应用部署</a></p>
        <p><a href="${_base }/help/FAQ#SAAS"><img src="${_base }/resources/images/help_q.png"></a></p>
        </li>
        <li>
        <p class="chan_wen"><span>Q：</span><a href="${_base }/help/FAQ#DEVFAQ" style="color: #555555;font-size: 16px;">亚信云平台下开发、测试、生产环境使用说明</a></p>
        <p><a href="${_base }/help/FAQ#DEVFAQ"><img src="${_base }/resources/images/help_q.png"></a></p>
        </li>
        <li>
        <p class="chan_wen"><span>Q：</span><a href="${_base }/help/FAQ#MONITOR" style="color: #555555;font-size: 16px;">异步事务服务能否代替分布式事务</a></p>
        <p><a href="${_base }/help/FAQ#MONITOR"><img src="${_base }/resources/images/help_q.png"></a></p>
        </li>
        </ul>
         <p style="font-size: 18px; position: absolute; left: 868px; top:135px;"><span><a href="${_base }/help/FAQ" style="color: #169adc;">更多>></a></span></p>
        </div>
       
       
       <div class="help_fist">
       <p style="color: #3e3e3e;font-size: 18x;font-weight:bold;">使用手册</p>
       </div>
       <div class="help_list">

       
        
        <div class="help_list_wot">
        <ul>
        <c:choose>
			<c:when test="${fileList != null }">
				<c:forEach var="file" items="${fileList}">
				<li><span>&bull;</span><a style="color: #555555;font-size: 16px;" href="javascript:void(0)" onclick="javascript:downloadFile('${file}','${ type}')">${file}</a></li>
			</c:forEach>
			
			</c:when>
			<c:otherwise>
				<li style="color: #555555;font-size: 16px;">暂无数据</li>
			</c:otherwise>
		</c:choose>
        </ul>
        </div>
        </div>
	  <div>
	  </div>
   </div>
   <div class="row Contact" id="contect">
   
   <div class="Contact_a">
   <ul class="cdd">
   <li class="cont">联系我们</li>
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_a.png"></p>
   <p>${contactMail }</p>
   </li>
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_b.png"></p>
   <p>AIC-TSD-BJ</p>
   </li>
   
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_c.png"></p>
   <p>北京市海淀区西北旺东路10号院东区 亚信大厦</p>
   </li>
   
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_d.png"></p>
   <p>http://www.asiainfo.com</p>
   </li>
   </ul>
   
   <ul class="cdd bdd">
   <li class="cont">客户服务</li>
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_e.png"></p>
   <p>${contactName }</p>
   </li>
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_f.png"></p>
   <p>${contactMobile }</p>
   </li>
   
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_g.png"></p>
   <p>${contactQQ }</p>
   </li>
  
   </ul>
   
   
   <ul class="cdd bdd">
   <li class="cont">关注我们</li>
   <li><img src="${_base }/resources/images/bz_h.png"></li>
   </ul>
   
   
   <ul class="cdd bdd">
   <li class="cont">我们的位置</li>
   <li><img src="${_base }/resources/images/bz_i.png"></li>
   </ul>
   
   </div>
   </div>
<!--页脚-->

<script type="text/javascript"> 
$(".mune_1 li").each(function(){
		$(this).hover(function(){
			$(this).attr("style","border-bottom:solid 2px rgb(57,150,207);color:rgb(57,150,207)")
		},function(){ 
			$(this).attr("style","border-bottom:solid 2px #fff;color:#949494")
		});
}); 
 
$(".two li").each(function(){
		$(this).hover(function(){
			$(this).attr("style","border-bottom:solid 2px rgb(120,189,90);color:rgb(120,189,90)")
		},function(){ 
			$(this).attr("style","border-bottom:solid 2px #fff;color:#949494")
		});
}); 
 
 $(".tab_div_a li").click(function(){
	 $(".tab_div_a li").each(function(i){
		$(this).removeClass("qieh");
	 })
	$(this).addClass("qieh");
 });
 
 
 function downloadFile(fileId,type){
	 var url ="${_base}/audit/download?fileId="+fileId+"&type="+type;
	 url = encodeURI(encodeURI(url));
	 window.location.href=url;
	 
 }
</script>
  </body>
</html>
