<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$("#${list_index}").attr('style', 'margin-top:2px;color:#1699dc');
	});
</script>
<title>亚信云【MDS】</title>
</head>

<body>
<div class="big_k">
<!-- 头部和导航条 -->
<div class="navigation">
		<%@ include file="/jsp/common/header.jsp"%>
	</div>
  <div class="container chanp">
	 	<div class="row chnap_row">
	<%@ include file="/jsp/common/leftMenu.jsp"%>  



<script>
$(function(){
	$("#navi_tab_product").addClass("chap");
	$(".hideclass").click(function(){
		$(".hideclass").removeClass("qieh");
		$(this).addClass("qieh");
		var id=$(this).attr("id");
		$(".youis").hide();
		$("#t"+id).fadeIn("slow");
	})
	
});

</script>

<div class="col-md-6 right_list">
     
     <div class="right_biat">
     <ul>
     <li class="ocs"><img src="${_base }/resources/images/f_icon_04.png">事务保障服务中心TSC</li>
     <li style=" text-align:left;">事务保障服务中心(Tansaction Service Center，简称TSC)是一种高效、可靠、安全、便捷、可弹性扩展的分布式消息队列服务。MDS能够帮助应用开发者在他们应用的分布式组件上自由的传递数据，构建松耦合系统。</li>
     <li class="butn"><a href="${_base}/tsc/addMessage">立即开通</a></li>
     </ul>
     
     </div>
  
  <div class="right_yousi">
    
 
     
   <div class="right_yousi_table">
   <ul>
   <li class="qieh hideclass" id="c1"><A  href="javascript:void(0)">我们的优势</A></li>
   <li class="hideclass" id="c2"><A href="javascript:void(0)" >产品功能</A></li>
   <li class="hideclass" id="c3"><A href="javascript:void(0)" >产品帮助</A></li>
   </ul>
    </div>
    
    <div id="tc1" class="youis">
    <div class="youis_none" ><p><a name="C1">我们的优势</a></p></div>
    <div class="row yousi_tow">
    <div class="col-md-4 for4">
    <ul>
    <li><img src="${_base }/resources/images/icon7.png"></li>
    <li class="icon_7img">简单易用</li>
    <li>您无需自行搭建消息队列服务，免运维</li>
    <li>我们提供标准的HTTP RESTful接口</li>
    <li>简单易用，对平台无依赖</li>
    </ul>
    </div>
    
    <div class="col-md-4 for4">
    <ul>
    <li><img src="${_base }/resources/images/icon7.png"></li>
    <li class="icon_7img">安全防护</li>
    <li>数据三重备份，可靠性达99.9999999%</li>
    <li>可以做到Always Writable</li>
    <li>可以做到Always Writable</li>
    </ul>
    </div>
    <div class="col-md-4 for4">
    <ul>
    <li><img src="${_base }/resources/images/icon8.png"></li>
    <li class="icon_7img">安全防护</li>
    <li>多层次安全防护和防DDoS攻击</li>
    <li>多用户隔离机制</li>
    </ul>
    </div>
    <div class="col-md-4 for4">
    <ul>
    <li><img src="${_base }/resources/images/icon9.png"></li>
    <li class="icon_7img">大规模高性能</li>
    <li>列数量及队列存储容量可扩展性强</li>
    <li>系统规模自动扩展，对用户完全透明</li>
    </ul>
    </div>
    </div>
    
    
    </div>
  
    <div id="tc2" class="youis" style="display:none ">
    <div class="youis_none" ><p> <a name="C2">产品功能</a></p></div>
     <div class="chanp_biat">
     <ul>
     <li class="tisheng">MQS帮您轻松实现海量消息数据传递</li>
     <li>消息通讯，轻松搞定</li>
     </ul>
     </div>
     
     <div class="chanp_tow">
     <ul>
     <li class="red">易用且不失扩展性</li>
     <li>提供遵照RESTful标准的API访问接口，您无需担心任何兼容性题； 可以和其他阿里云服务结合使用，例如ECS、RDS、和OSS，从而让您的应用程序更可 靠、可扩展性更强。</li>
     </ul>
      <ul>
     <li class="red">丰富的队列属性配置</li>
     <li>我们提供了丰富的队列属性配置选项，您可以进行队列属性的个 性化配置来满足不同的应用场景，支持：普通队列、延迟队列、优先级队列等多种队列模式。</li>
     </ul>
      <ul>
     <li class="red">支持并发访问</li>
     <li>支持多个生产者和消费者并发访问同一个消息队列，并能确保某条消息 在取出之后的特定时间段内，无法被其他消费者获得。</li>
     </ul>
      <ul>
     <li class="red">消息投递保障及访问控制</li>
     <li>在消息有效期内，确保消息至少能被成功消费一次。接入阿 里云账号体系，用户间资源隔离，确保您队列中的消息不会被非法获取。</li>
     </ul>
     
     
     </div>
    
    </div>
    
    <div id="tc3"  class="youis" style="display:none ">
     <div class="youis_none">
       <p><a name="C3">产品帮助</a></p></div>
     
     
     <div class="chanp_tow">
     <ul>
     <li  class="pos">操作指南</li>
     <li><A href="#">MQS基本概念</A></li>
     <li><A href="#">MQS快速上手</A></li>
     </ul>
      <ul>
      <li  class="pos"><A href="#">资料中心</li>
     <li><A href="#">API手册</A></li>
     <li><A href="#">Java SDK开发包</A></li>
     <li><A href="#">Python SDK开发包</A></li>
     <li><A href="#">其它SDK开发包</A></li>
     </ul>
      <ul class="chul" >
     <li class="pos">常见问题</li>
     <li><A href="#">热点问题</A></li>
     </ul>
      </div>
     
    </div>
    </div>
    </div>
    </div>
</div>
</div>
<!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>

</body>
</html>
