<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<title>OCS详情</title>
</head>

<body>
<div class="big_k">
<!-- 头部和导航条 -->
<div class="container chanp"><div class="row">  <div class="navigation"><%@ include file="/jsp/common/header.jsp"%></div>
   
<div class="row chnap_row">
	<%@ include file="/jsp/common/leftMenu.jsp"%>  
   <div class="col-md-6 right_list">
     
     <div class="right_biat">
     <ul>
     <li class="ocs">Cache1106</li>
     <li>内存大小为2G，目前已使用1.6G</li>
     <li class="butn"><a href="">清除所有key</a> &nbsp;&nbsp;&nbsp;&nbsp;<a href="">注销该服务</a></li>
     </ul>
     
     </div>
  
  <div class="right_yousi">
    
 
     
    
    <div class="youis">
    <div class="youis_none" ><p><a name="C1">我们的优势</a></p></div>
    <div class="row yousi_tow">
    <div class="col-md-4 for4">
    <ul>
    <li><img src="${_base }/resources/images/icon7.png"></li>
    <li class="icon_7img">便捷</li>
    <li>服务开箱即用</li>
    <li>容量弹性伸缩</li>
    <li>配置变更不中断服务</li>
    </ul>
    </div>
    <div class="col-md-4 for4">
    <ul>
    <li><img src="${_base }/resources/images/icon8.png"></li>
    <li class="icon_7img">可靠便捷</li>
    <li>分布式集群及负载均衡设计</li>
    <li>硬件故障自动恢复</li>
    <li>硬件故障自动恢复</li>
    </ul>
    </div>
    <div class="col-md-4 for4">
    <ul>
    <li><img src="${_base }/resources/images/icon9.png"></li>
    <li class="icon_7img">快速</li>
    <li>提供用户身份认证及IP地址白名单</li>
    <li>双重安全控制，限定阿里云内网访</li>
    <li>问使得数据更安全。</li>
    </ul>
    </div>
    </div>
    
    
    </div>
  
    <div class="youis">
    <div class="youis_none" ><p> <a name="C2">产品功能</a></p></div>
     <div class="chanp_biat">
     <ul>
     <li class="tisheng">提升应用和网站性能的利器：阿里云OCS</li>
     <li>加速你的世界！</li>
     </ul>
     </div>
     
     <div class="chanp_tow">
     <ul>
     <li class="red">热点数据访问</li>
     <li>实现热点数据的高速缓存，与数据库搭配能大幅提高应用的响应速度，极大缓解后端存储的压力。</li>
     </ul>
      <ul>
     <li class="red">兼容常用协议</li>
     <li>支持Key-Value的数据结构，兼容Memcached协议的客户端都可使用OCS服务。</li>
     </ul>
      <ul>
     <li class="red">安全机制</li>
     <li>提供用户身份认证及IP地址白名单双重安全控制，限定阿里云内网访问使得数据更安全。</li>
     </ul>
      <ul>
     <li class="red">监控与调整</li>
     <li>实支持Key-Value的数据结构，兼容Memcached协议的客户端都可使用OCS服务。</li>
     </ul>
     
     
     </div>
    
    </div>
    
    <div class="youis">
     <div class="youis_none">
       <p><a name="C3">产品帮助</a></p></div>
     
     
     <div class="chanp_tow">
     <ul>
     <li  class="pos">产品介绍</li>
     <li><A href="#">产品简介</A></li>
     <li><A href="#">适用场景</A></li>
     <li><A href="#">服务条款</A></li>
     </ul>
      <ul>
      <li  class="pos"><A href="#">操作指南</li>
     <li><A href="#">代码示例</A></li>
     <li><A href="#">协议支持</A></li>
     </ul>
      <ul class="chul" >
     <li class="pos">常见问题</li>
     <li><A href="#">多大的数据最适合存储在OCS上？</A></li>
     <li><A href="#">OCS的数据支持持久化吗？</A></li>
     <li><A href="#">OCS和本地Memcached的区别是什么？</A></li>
     </ul>
      </div>
     
    
    
    </div>
  
</div>
   

  
  </div>
</div>
</div>
</div>
<%@ include file="/jsp/common/footer.jsp"%>

</body>
</html>
