<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html lang="zh-cn">
  <head>    
    <%@ include file="/jsp/common/common.jsp"%>
    
    <link href="${_base }/resources/css/bootstrap.min.css" rel="stylesheet">
    <link href="${_base }/resources/css/virtual.css" rel="stylesheet">
    <script type="text/javascript" src="${_base }/resources/bower_components/jquery/dist/jquery-1.10.2.js"></script>
<style type="text/css">
	.date{background: url(${_base }/resources/images/date.png) no-repeat right center;}
	
	/* .inform-success,.inform-fault{width: 460px;height: 205px;background: #fff;box-shadow: 0 0 5px 1px #ccc;position: relative;}
	.ok{position: absolute;left: 50%;top: 37px;margin-left:-15px;}
	.inform-success h3,.inform-fault h3{color: #333;position: absolute;left: 191px;top:70px;}
	.sure{color: #fff;background:#169ADB;border: 1px solid #056A9E;left: 177px;width: 110px;height: 35px;text-align:center;line-height: 35px;font-weight: bold;font-size: 16px;position: absolute;top: 137px;}
	.div_overlay{display:none;position: fixed;width: 100%;height:100%;z-index:1010;-moz-opacity: 0.0; opacity:.00;filter: alpha(opacity=0);background-color: black;}
	.info-line1 .other-system1,.info-line1 .other-system2{width:350px;} */
</style>

 </head> 
  <body>  
  
    <div class="big_k"><!--包含头部 主体-->  
   <!--导航-->
	   <div class="navigation">
	 		<%@ include file="/jsp/common/header.jsp"%>
	   </div>
	   <div class="row successful shenq" style="line-height:1px;background:#fff">
	      <ul>
			 <li class="cg_no"><img src="${_base}/resources/images/right.png"></li>
			 <li class="desc_title">您已修改虚拟机服务</li>
			 <li>预计${dateStr}完成处理，审核通过后将通过邮箱或<a href="${_base}/apply/purchaseRecords?prodType=1&currentPage=1" style="color:#179ADE">自助查询</a></li>
			 <li>如有问题请联系 18888888888</li>
			  
	      </ul>
       </div>
	</div>
<!--页脚-->
<!-- 	<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include> 
 -->
  </body>
</html>
  
