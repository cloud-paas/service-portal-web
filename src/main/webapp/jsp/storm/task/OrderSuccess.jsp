<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="form" uri="/spring-form" %>
<!DOCTYPE html>
<html lang="zh-cn">
 <head>
<%@ include file="/jsp/storm/common/jsp/html_meta.jsp"%>
<title>RCS开通</title>
<%@ include file="/jsp/storm/common/jsp/html_js.jsp"%>
  </head>
  <body>
   
   <div class="herd">  
    <div class="wrap">
    <ul class="wrap_left">
   <li>欢迎来到IpaaS，</li>
   <li><a href="#">请登录</a></li>
   <li><a href="#"  style="border-right:0px;">注册</a></li>
   </ul>
    <ul class="wrap_right">  
   <li><A href="#">用户中心</A></li>
   <li><A href="#"  style="border-right:0px;">管理控制台</A></li>
   </ul>
    </div>
   </div>
   
   <!--导航-->
   <div class="navigation">
   <div class="navigation_A">
   <div class="logo"><img src="${_base }/resources/images/logo.png"></div>
   <div class="navigation_list">
   <ul>
   <li><a href="#">首页</a></li>
   <li class="chap"><a href="#">产品</a>
   <div class="bi" style="display: none;">
   <ul>
                       <li>
                       <p class="gm_js_yew"><A href="#">弹性计算</A></p>
                       <p><A href="#">云服务器ECS</A></p>
                       <p><A href="#">负载均衡SLB</A></p>
                       <p><A href="#">弹性伸缩服务ESS</A></p>
                       <p><A href="#">转有网络VFC</A></p>
                       </li>
                       <li>
                       <p class="gm_js_yew"><A href="#">数据存储</A></p>
                       <p><A href="#">开放缓存服务OCS</A></p>
                       <p><A href="#">配置中心</A></p>
                       <p><A href="#">消息服务</A></p>
                       <p><A href="#">实时计算中心</A></p>
                       </li>
                       
                       <li>
                       <p class="gm_js_yew"><A href="#">存储与CDN</A></p>
                       <p><A href="#">开放存储服务OSS</A></p>
                       <p><A href="#">内容分发网络CDN</A></p>
                       <p><A href="#">开放归档服务OAS</A></p>
                       <p><A href="#">键值存储KVStore</A></p>
                      </li>
                       <li>
                       <p class="gm_js_yew"><A href="#">大规模计算</A></p>
                       <p><A href="#">开放数据处理服务ODPS</A></p>
                       <p><A href="#">采云间 DPC</A></p>
                       <p><A href="#">分析数据库服务 ADS</A></p>
                       <p><A href="#">云道 CDP</A></p>
                      </li>
                       <li class="noborder">
                       <p class="gm_js_yew"><A href="#">云盾高级版</A></p>
                       <p><A href="#">DDoS高防IP</A></p>
                       <p><A href="#">云监控</A></p>
                      </li>
                       
                       
            </ul>
   </div>
   
   </li>
   <li><a href="#">下载中心</a></li>
   <li><a href="#">联系我们</a></li>  		    		 		     		 	
   </ul>
   </div>
   
   </div>
   </div>
   
   <div class="row successful shenq" >
      <ul>
      <li class="cg_no"><img src="${_base }/resources/images/xl.png">您已申请成功</li>
     <li>预计2015年5月1日完成处理，审核通过后，将会邮件通知或者<a href="#">自助查询</a>，如有问题</li>
     <li>请联系张磊！<A href="${_base }/storm/toOrder" class="jx_gm">继续购买>></A></li>
      </ul>
     
   </div>
   
<!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
   
   
  </body>
</html>