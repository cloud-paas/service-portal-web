<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
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
  <div class="container chanp">
   
  <div class="row chnap_row">
  <div class="col-md-6 left_list" >
      <div class="list_groups">
             <div class="list_groups_none">
            <ul>
             <li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(6,2,this);">
             <a href="#" style="color:#fff">
             <p id="img2">用户指南</p>
             </a>
             <li class="list_xinx"  id="content2" >
             <p ><A href="${_base }/help/nt"><span style="margin-top:2px;">亚信NT账号登录</span></A></p>
             <p><A href="${_base }/help/mail"><span style="margin-top:2px;">自助注册邮箱登录</span></A></p>
              <p><A href="${_base }/help/paas"><span style="margin-top:2px;">Paas资源申请</span></A></p>
             </li>
             </li>
             </ul>
             
             <ul>
             <li class="biaot" style="background:rgb(22,154,219)" >
             <a href="${_base }/help/FAQ" style="color:#fff">
             <p id="img2">常见问题</p>
             </a>
            
             </li>
             </ul>
             
             <ul>
             <li class="biaot" style="background:rgb(22,154,219)" >
             <a href="${_base }/help/manual" style="color:#fff">
             <p id="img2">使用手册</p>
             </a>
            
             </li>
             </ul>
             
             </div> 
    </div>
  
  </div>
 <div class="col-md-6 right_list">
     
    <div class="Open_cache">
            <div class="Open_cache_table">
			<ul style="border-bottom:1px #eee">
			<li><a href="#">使用手册</a></li> 
			</ul>  
        </div> 
 
    <div class="download">
    	 <ul>
    	 
    	 <c:choose>
			<c:when test="${fileList != null }">
				<c:forEach var="file" items="${fileList}">
				<li><span>&bull;</span><a href="${_base}/audit/download?fileId=${file}&type=${type}">${file}</a></li>
			</c:forEach>
			
			</c:when>
			<c:otherwise>
				<li>暂无数据</li>
			</c:otherwise>
		</c:choose>

        </ul>
    
    </div>
     </div> 
 
  </div>
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
</script>
  </body>
</html>
