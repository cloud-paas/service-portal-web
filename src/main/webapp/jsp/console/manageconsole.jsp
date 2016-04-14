<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
  <head>
  <title>缓存中心MCS</title>
<%@ include file="/jsp/common/common.jsp"%>
<style type="text/css">     
/**头部菜单**/ 
.mune_1{
	float:left;  
	width:80%; 
	padding-top:1.8%;  
	text-align:center;	  
}
.mune_1 li{ 
	float:left;  
	list-style:none;
	width:25%;  
	font-size:22px;
	font-weight:800;
	color:#fff;
	padding-bottom:1%;
	cursor:pointer;
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

#table_detail{
	text-align:center
}
#table_detail th{
	text-align:center;
	background:rgb(245,245,245);
	font-size:14px;
}

#table_detail th,#table_detail td{
	padding:10px; 
	border:solid 1px #eee
}
#table_detail a{
	padding:0px 5px 0px 5px;
	color:rgb(22,154,219);
	font-weight:800;
}
 
</style>    
  </head> 
  <body>     
  <div class="big_k"><!--包含头部 主体-->   
   <!--导航-->
   <div class="navigation" style="background:rgb(22,154,219);">
  <div class="head">
				<div style="width: 100%; height: auto">
					<div style="float: left; width: 15%; position: relative; left: 3%">
						<img src="${_base }/resources/images/logo-white.png"
							style="position: relative; margin: 20px 20px 0px 0px">
					</div>
					<div class="mune_1">
						<ul>
							<li>管理控制台</li> 
						</ul>
						<ul style="float:right">
							<li><a href="#" title="返回首页"><img src="${_base }/resources/images/return.png"/></a></li> 
						</ul>
					</div> 
				</div>
			</div>
   </div>
   
   <div class="container chanp"><div class="row"> <div class="navigation"> <%@ include file="/jsp/common/header.jsp"%></div>
   
  <div class="row chnap_row">
  <div class="col-md-6 left_list" >
      <div class="list_groups">
             <div class="list_groups_none">
             <ul>
             <li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(6,2,this);">
             <a href="#" style="color:#fff">
             <p><img src="${_base }/resources/images/icon1.png"></p>
             <p>Paas服务</p>
             <p class="sanjiao"><img src="${_base }/resources/images/b.png" id="img2"></p>
             </a>
             <li class="list_xinx"  id="content2" >
             <p><A href="${_base }/config/showService"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;">配置中心CCS</span></A></p>
             <p><A href="#"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;">分布式数据库服务DBS</span></A></p>
             <p><A href="#"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;">实时计算RCS</span></A></p>
             <p><A href="#"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;">消息中心MDS</span></A></p> 
			 <p><A href="#"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;">缓存中心MCS</span></A></p>
			 <p><A href="#"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;">事务保障服务TXS</span></A></p>
			 <p><A href="#"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;">最终事务一致ATS</span></A></p>
			 <p><A href="#"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;">文档存储服务DSS</span></A></p>
             </li>
             </li>
             </ul>
             
              <ul>
             <li class="biaot" onClick="turnit(6,3,this);">
             <a href="#">
             <p><img src="${_base }/resources/images/icon2.png"></p>
             <p>Iaas</p>
             <p class="sanjiao"><img src="${_base }/resources/images/b.png" id="img3"></p>
             </a>
			 <li class="list_xinx"  id="content3" >
             <p><A href="#"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;">虚拟机</span></A></p>
             <p><A href="#"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;">存储</span></A></p>
             <p><A href="#"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;">物理机</span></A></p> 
             </li> 
             </li>
             </li>
             </ul>  
             </div> 
    </div>
  
  </div>
  <div class="col-md-6 right_list">
     
     <div class="Open_cache">
        <div class="Open_cache_table">
			<ul>
			<li><a href="#">缓存中心MCS</a></li> 
			</ul>  
        </div> 
		<div class="Open_cache_table" style="background:rgb(245,245,245);height:30px;vertical-align:middle;text-align:center;line-height:30px;padding-left:40%">
			 
		</div> 
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
	          	<div class="Open_cache_list_tow">
	          		 <table id="table_detail"  style="width:100%; ">
						<tr>
							<th>服务名称</th>
							<th>IPAAS编码</th>
							<th>产品名称</th>
							<th>总容量（M）</th>
							<th>单文件大小（M）</th>
							<th>使用量</th>
							<th>操作</th> 
						</tr>
						<tr>
							<td>服务名称</td>
							<td>IPAAS编码</td>
							<td>产品名称</td>
							<td>总容量（M）</td>
							<td>单文件大小（M）</td>
							<td>使用量</td>
							<td><a href="../Ipaas/管理控制台－服务列表-详情.html">详情</a>|<a href="#">注销</a>|<a href="#" data-toggle="modal" data-target="#clean_model">格式化</a>|<a href="../Ipaas/管理控制台－服务列表-修改密码.html">修改服务器密码</a></td> 
						</tr>
						<tr>
							<td>服务名称</td>
							<td>IPAAS编码</td>
							<td>产品名称</td>
							<td>总容量（M）</td>
							<td>单文件大小（M）</td>
							<td>使用量</td>
							<td><a href="#">详情</a>|<a href="#">注销</a>|<a href="#" data-toggle="modal" data-target="#clean_model">格式化</a>|<a href="../Ipaas/管理控制台－服务列表-修改密码.html">修改服务器密码</a></td> 
						</tr> 
					 </table>
	           </div>                
	        </div>  
    	</div>   
     </div> 
 
  </div>
</div>

</div>
</div>  
<!-- 清理数据 -->
		<div class="modal fade bs-example-modal-sm" id="clean_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  <div class="modal-dialog">
			<div class="modal-content">
			  <div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				<h4 class="modal-title" id="myModalLabel">全部清理数据</h4>
			  </div>
			  <div class="modal-body">
			       清理数据后将无法修复，您确认此操作吗？
				   <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				<button type="button" class="btn btn-primary">确认</button>
			  </div> 
			</div>
		  </div>
		</div>
<!--页脚-->
<!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include> 
 
  </body>
</html>
