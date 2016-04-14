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
		.Iaas-step{clear: both; overflow: hidden;padding-bottom:20px;}
		.Iaas-step li{float:left;margin-right:3px;}
		.li-img{margin-top:30px;}
		.Iaas-content li{float:left;font-size:16px;color:#5e5e5e;font-weight:bold;}
		.Iaas-li0{margin:0px 85px 0px 13px;}
		.Iaas-li1{margin-right:92px;}
		.Iaas-li2{margin-right:81px;}
		.Iaas-li3{margin-right:83px;}
		.Iaas-li4{margin-right:69px;}
		.Iaas-content{width:910px;height:30px;}
		.Iaas-tick{color:#7b7b7b;font-size:12px;clear:both;over-flow:hidden;margin-top:0px;width:910px;}
		.tick1-top{height:20px;width:1px;border-right:1px solid #333;margin-left:40px;margin-bottom:10px;}
		.tick2-top{height:20px;width:1px;border-right:1px solid #333;margin-left:70px;margin-bottom:10px;}
		.tick1{margin-left:153px;float:left;}
		.tick2{float:left;margin-left:490px;}
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
              <p><A href="${_base }/help/nt"><span style="margin-top:2px;">亚信邮箱登录</span></A></p>
             <p class="xuanz"><A href="${_base }/help/mail"><span style="margin-top:2px;">Iaas资源申请流程</span></A></p>
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
        <div class="Open_cache_table" style="margin-bottom:50px;">
			<ul style="border-bottom:1px #eee">
			<li><a href="#">Iaas资源申请</a></li> 
			</ul>  
        </div> 
    
    <ul class="Iaas-step">
    	<li><img  src="${_base }/resources/images/Iaas1.jpg"></li>
    	<li class="li-img"><img  src="${_base }/resources/images/Iaas7.jpg"></li>
    	<li><img  src="${_base }/resources/images/Iaas2.jpg"></li>
    	<li class="li-img"><img  src="${_base }/resources/images/Iaas7.jpg"></li>
    	<li><img  src="${_base }/resources/images/Iaas3.jpg"></li>
    	<li class="li-img"><img  src="${_base }/resources/images/Iaas7.jpg"></li>
    	<li><img  src="${_base }/resources/images/Iaas4.jpg"></li>
    	<li class="li-img"><img  src="${_base }/resources/images/Iaas7.jpg"></li>
    	<li><img  src="${_base }/resources/images/Iaas5.jpg"></li>
    	<li class="li-img"><img  src="${_base }/resources/images/Iaas7.jpg"></li>
    	<li><img  src="${_base }/resources/images/Iaas6.jpg"></li>
    </ul>
    <ul class="Iaas-content">
    	<li class="Iaas-li0">资源申请</li>
    	<li class="Iaas-li1">资源审批</li>
    	<li class="Iaas-li2">制定方案</li>
    	<li class="Iaas-li3">申请人确认</li>
    	<li class="Iaas-li4">资源开通</li>
    	<li class="Iaas-li5">查看虚拟机信息</li>
    </ul>
    <div class="Iaas-tick">
    	<div class="tick1">
    		<div class="tick1-top"></div>
    		<div class="tick1-bottom">部门领导线下审批</div>
    		<div class="tick1-bottom" style="margin-left:6px;">管理员线上审批</div>
    	</div>
    	<div class="tick2">
    		<div class="tick2-top"></div>
    		<div class="tick1-bottom">在用户控制台查询申请的Iaas</div>
    		<div class="tick1-bottom" >资源的IP、用户名、密码信息</div>
    	</div>
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
