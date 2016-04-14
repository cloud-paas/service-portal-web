<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<title>亚信云</title>
  <head>
   <%@ include file="/jsp/common/common.jsp"%>

<style type="text/css">     

/**头部菜单**/
.mune_1{
	float:left;  
	width:40%; 
	padding-top:1.8%;  
	text-align:center;	 
}
.mune_1 li{ 
	float:left;  
	list-style:none;
	width:20%;  
	font-size:22px;
	font-weight:800;
	color:#949494;
	padding-bottom:1%;
	cursor:pointer;
}
 .mune_2{
	float:right;  
	width:45%;  
	padding-top:2.5%; 
	text-align:right;
	padding-left:15%
} 
.mune_2 li{ 
	float:left; 
	list-style:none;   
	color:#949494;
	font-weight:600; 
	text-align:center;
	font-size:16px;
	margin-left:3%;
}

/***TAB切换***/
.tab_div{ width:840px; float:left; margin:35px 0 0 25px;}
.tab_div_a{ width:838px; float:left; height:40px;-moz-border-radius: 15px;border-radius: 15px}
.tab_div_a ul{ width:838px; float:left;}
.tab_div_a ul li a{ width:279px; float:left;text-align:center; line-height:39px; font-size:16px; color:#666;border:solid 1px #949494;font-weight:600}
.tab_div_a ul  .qieh a{width:279px; float:left; border-right:1px solid #ebebeb; text-align:center; line-height:39px; font-size:16px; color:#fff;background:rgb(22,154,219);font-weight:600}
.radius_left{
	border-top-left-radius:2em; 
	border-bottom-left-radius:2em;
 
} 
.radius_right{
	border-top-right-radius:2em; 
	border-bottom-right-radius:2em; 
}
 
.tab_div_b{ width:838px; float:left; height:40px}
.tab_div_b ul{ width:100%; float:left;text-align:center;margin:0 auto;}
.tab_div_b li{
	float:left;
	list-style:none;
	width:33%; 
	text-align:center;
}
.cache_pro_table{
	width:100%;
	text-align:center;
}
.cache_pro_table td{
	 border-left:solid 2px rgb(22,154,219);
	 border-bottom:solid 1px #eee;
	 border-top:solid 1px #eee;
	 border-right:solid 1px #eee;
	 background:rgb(243,243,243);
	 text-align:left;
	 line-height:23px;
	 width:335px;
	 height:115px;   
	 padding:10px;
}
.desc_title{
	font-size:14px;
	font-weight:700;
	color:#000; 
}

.cache_pro_help {
	color:#fff
}
.cache_pro_help ,.cache_pro_serv{
	line-height:30px;
	width:100%;
	text-align:center;  
}
.cache_pro_help ul{
	width:50%;
	text-align:left;  
}
.cache_pro_help a{
	color:#949494
}
.cache_pro_serv td{
	width:50%;
}
#warn_1 {   
	position:relative;
	width: 20px; 
	height: 20px; 
	background-color: #efefef; /* Can be set to transparent */ 
	background:rgb(237,51,88);
	border-radius:10px;
	-moz-border-radius:10px; /* 老的 Firefox */;
	text-align:center;
	vertical-align:middle;
	line-height:20px;
	color:#fff;
	font-weight:600;
	margin-top:1%
} 
.font-title{
	font-size:18px;
	font-weight:600;
	color:#000;
	padding-left:1%; 
}

/**页脚**/
.footer {
	position:relative;
	text-align:center;
	margin-top:10px;
	line-height:30px
}
.footer li{
	float: left;
	list-style:none;
	margin: 10px 0px 0px 0px;
	text-align: center;
	position: relative; 
	color:#949494;
	font-weight:800; 
	width:auto;
	
}
.footer span{  
	color:#949494;
	font-weight:800; 
	width:auto;
	
}
</style>  
  </head> 
  <body>  
   <!--导航-->
   <div class="big_k">
   <div class="navigation">
    <%@ include file="/jsp/common/header.jsp"%></div>
   
   <div class="row successful shenq" style="line-height:1px;background:#fff">
      <ul>
		 <li class="cg_no"><img src="${_base }/resources/images/right.png"></li>
	
		<c:if test="${flag==null || flag==''}">	 
				 <li class="desc_title">您已成功申请<%--  ${prod} --%>    ${prodName} </li>
		</c:if>
		<c:if test="${flag=='Update'}">	 
				 <li class="desc_title">您已成功修改<%--  ${prod} --%>    ${prodName} </li>
		</c:if>
		
		 
		 <!-- 自助查询 -->
		 <c:if test="${prod=='IAAS_VIRTAL'||prod=='DES'||prod=='RCS'||prod=='SES'}">
		 	<li>预计 ${dateStr } 完成处理，审核通过后将通过邮箱或<a style="color: #1699dc" href="${_base}/apply/purchaseRecords?prodType=1&currentPage=1">自助查询</a></li>
		
		 	<li></li>
		 </c:if>
		 
		 <c:if test="${prod=='DBS'||prod=='TXS'||prod=='ATS'}">
		 	<li>预计 ${dateStr } 完成处理，审核通过后将通过邮箱或<a style="color: #1699dc" href="${_base}/apply/purchaseRecords?prodType=2&currentPage=1">自助查询</a></li>
		 	<li>如有问题请联系张振宇</li>
		 </c:if>
		 
		 <c:if test="${prod=='CCS'||prod=='MCS'||prod=='MDS'||prod=='DSS'}">
		 	<li>预计 ${dateStr } 完成处理，审核通过后将通过邮箱或<a style="color: #1699dc" href="${_base}/apply/purchaseRecords?prodType=3&currentPage=1">自助查询</a></li>
		 	<li>如有问题请联系张振宇</li>
		 </c:if>
		 

		 
		 <li style="text-align:center">  <!-- 点击按钮 -->

			<c:if  test="${prod=='IAAS_VIRTAL'}"> <!-- 如果是虚拟机，跳到虚拟机申请页面 -->
				<a href="${_base }/virtualMachine/goVirtualMachineApply"><span style="margin-top:20px;-moz-border-radius: 15px;border-radius: 15px;p;background:rgb(251,205,49);padding:5px 20px 5px 20px;color:#fff">继续购买</span></a>
			</c:if> 
			
			<c:if  test="${prod=='RCS'}"> 
				<a href="${_base }/rcs/introduce"><span style="margin-top:20px;-moz-border-radius: 15px;border-radius: 15px;p;background:rgb(251,205,49);padding:5px 20px 5px 20px;color:#fff">继续购买</span></a>
			</c:if>
			
			<c:if  test="${prod=='DES'}"> 
				<a href="${_base }/des/initapply"><span style="margin-top:20px;-moz-border-radius: 15px;border-radius: 15px;p;background:rgb(251,205,49);padding:5px 20px 5px 20px;color:#fff">继续购买</span></a>
			</c:if>
			
			<c:if  test="${prod=='SES'}"> 
				<a href="${_base }/ses/initapply"><span style="margin-top:20px;-moz-border-radius: 15px;border-radius: 15px;p;background:rgb(251,205,49);padding:5px 20px 5px 20px;color:#fff">继续购买</span></a>
			</c:if>
			
			<c:if  test="${prod=='DBS'}"> 
				<a href="${_base }/dbs/introduce"><span style="margin-top:20px;-moz-border-radius: 15px;border-radius: 15px;p;background:rgb(251,205,49);padding:5px 20px 5px 20px;color:#fff">继续购买</span></a>
			</c:if>
			
			<c:if  test="${prod=='TXS'}"> 
				<a href="${_base }/txs/introduce"><span style="margin-top:20px;-moz-border-radius: 15px;border-radius: 15px;p;background:rgb(251,205,49);padding:5px 20px 5px 20px;color:#fff">继续购买</span></a>
			</c:if>
			
			<c:if  test="${prod=='ATS'}"> 
				<a href="${_base }/ats/introduce"><span style="margin-top:20px;-moz-border-radius: 15px;border-radius: 15px;p;background:rgb(251,205,49);padding:5px 20px 5px 20px;color:#fff">继续购买</span></a>
			</c:if>
			
			<c:if  test="${prod=='CCS'}"> 
				<a href="${_base }/ccs/introduce"><span style="margin-top:20px;-moz-border-radius: 15px;border-radius: 15px;p;background:rgb(251,205,49);padding:5px 20px 5px 20px;color:#fff">继续购买</span></a>
			</c:if>
			
			<c:if  test="${prod=='MDS'}"> 
				<a href="${_base }/mds/introduce"><span style="margin-top:20px;-moz-border-radius: 15px;border-radius: 15px;p;background:rgb(251,205,49);padding:5px 20px 5px 20px;color:#fff">继续购买</span></a>
			</c:if>
			
			<c:if  test="${prod=='MCS'}"> 
				<a href="${_base }/mcs/introduce"><span style="margin-top:20px;-moz-border-radius: 15px;border-radius: 15px;p;background:rgb(251,205,49);padding:5px 20px 5px 20px;color:#fff">继续购买</span></a>
			</c:if>
		
			<c:if  test="${prod=='DSS'}"> 
				<a href="${_base }/dss/introduce"><span style="margin-top:20px;-moz-border-radius: 15px;border-radius: 15px;p;background:rgb(251,205,49);padding:5px 20px 5px 20px;color:#fff">继续购买</span></a>
			</c:if>
			
			<!-- //相当于else -->
			<c:if  test="${prod!='IAAS_VIRTAL' && prod!='RCS' && prod!='DES' && prod!='SES' && prod!='DBS' &&  prod!='TXS' && prod!='ATS' && prod!='CCS' && prod!='MDS' && prod!='MCS' && prod!='DSS'}"> 
				<a href="${_base }/virtualMachine/initapply"><span style="margin-top:20px;-moz-border-radius: 15px;border-radius: 15px;p;background:rgb(251,205,49);padding:5px 20px 5px 20px;color:#fff">继续购买</span></a>
			</c:if>
			

			
		 </li>
      </ul>

	  <div>
		
	  </div>
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
