<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
<%@ include file="/jsp/common/common.jsp"%>

<script type="text/javascript">
</script>
  
</head> 
<body>     
  <div class="big_k"><!--包含头部 主体-->   
   <!--导航-->
   <%@ include file="/jsp/common/header_console.jsp"%>
      
   <div class="container chanp">
   <%@ include file="/jsp/common/leftMenu_console.jsp"%>
  <div class="row chnap_row">
  
   <div class="col-md-6 right_list">
     
     <div class="Open_cache">
        <div class="Open_cache_table">
			<ul>
			<li><a href="#">組織管理</a></li> 
			</ul>  
        </div> 
		<div class="Open_cache_table" style="background:rgb(245,245,245);height:30px;vertical-align:middle ;line-height:30px;padding-left:1%">
			  <span>組織ID：</span>
			 <span style="color:rgb(22,154,219)">${orgId}</span>
			 <span style="margin-left:10px">組織编码：</span>
			 <span style="color:rgb(22,154,219)">${orgCode}</span>
		</div> 
     	<div class="Open_cache">  
	     
         <div class="xiug_cg">
         <ul>
         <li><img src="${_base }/resources/images/xgcg.png"></li>
         <li>修改組織信息成功</li>
         <li><A href="${_base}/orgConsole/toOrgConsole" style="">返回</A></li>
         </ul>
         </div>                
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
