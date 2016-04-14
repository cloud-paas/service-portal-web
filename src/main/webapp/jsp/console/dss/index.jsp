<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
<%@ include file="/jsp/common/common.jsp"%>
  <body>  
   <!--导航-->
   <%@ include file="/jsp/common/header_console.jsp"%>
   
   <div class="row help shenq" >
   
    <div class="wsq_fist">
    <ul>
    <li><img src="${_base }/resources/images/wsq_1.png"></li>
    <li>您还没有申请任何云产品服务哟！</li>
    </ul>
    </div>
    
    <div class="wsq_fist wsq_fist1">
    <ul>
    <li>为您推荐开通</li>
    </ul>
    </div>
    
     <div class="wsq_tow">
     <ul>
     <a href="${_base }/ccs/introduce">
     <li><img src="${_base }/resources/images/wsq_07.png"></li>
     <li>配置中心CCS</li></a>
     </ul>
     <ul>
     <a href="${_base }/rcs/introduce">
     <li><img src="${_base }/resources/images/wsq_10.png"></li>
     <li>实时计算RCS</li></a>
     </ul>
     <ul>
     <a href="${_base }/mds/introduce">
     <li><img src="${_base }/resources/images/wsq_13.png"></li>
     <li>消息中心MDS</li></a>
     </ul>
     <ul>
     <a href="${_base }/mcs/introduce">
     <li><img src="${_base }/resources/images/wsq_15.png"></li>
     <li>缓存中心MCS</li></a>
     </ul>
     <ul class="w_mor">
     <li><a href="${_base }/ccs/introduce">更多>></a></li>
     </ul>
     
     </div>
     
       
       
	  <div>
		
	  </div>
   </div>
    <!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include> 
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
