<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<title>亚信云【DBS】</title>
  <head>
   <%@ include file="/jsp/common/common.jsp"%>
         <style>
		hr {height:1px;  
			color:gray;  
			background-color:gray;  
			border:none;
		}
	</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#${list_index}").attr('style', 'margin-top:2px;color:#1699dc');
	});
</script>
	
  </head> 
   <script>
   	$(document).ready(function(){
   		$('a[id^=active_]').each(function(){
   			$(this).css('color', '#949494');
   		});
   		$('#active_prod').css('color', '#1699dc');
//    		$('.mune_2').css('padding-left', '1%');
   		
   	});
   </script>
  <body>    
  <div class="big_k"><!--包含头部 主体-->  
   <!--导航-->
   
   <div class="navigation">
		<%@ include file="/jsp/common/header.jsp"%>
	</div>
  <div class="container chanp">
	 	<div class="row chnap_row">
    <%@ include file="/jsp/common/leftMenu_new.jsp"%>
  <div class="col-md-6 right_list">
     
     <div class="Open_cache">
        <div class="Open_cache_table">
        <ul>
        <li><a>分布式数据库服务DBS</a></li>
        </ul>
        </div>
        
        <div class="Open_cache_list"> 
          <div class="Open_cache_list_none">
			  <ul style="float:left;width:15%;text-align:right">
				<li><img src="${_base }/resources/images/database.png"></li>
			  </ul>
			  <ul style="float:left;width:55%;padding-left:3%;line-height:25px">
				<li style="font-size:16px;font-weight:600">简介</li>
				<li style="color:#949494">分布式数据库服务（DATABASE Service）是基于Mysql技术实现，通过多个Mysql单实例（非Mysql Cluster）构成的一种水平拆分、可平滑扩缩容、读写分离的分布式数据库服务。</li>
				<li>
					<a href="${_base}/dbs/toOpenDbs"><div style="margin-top:20px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(121,189,90);line-height:30px;vertical-align:middle;color:#fff">立即开通</div></a>
				</li>
			  </ul>
			   
          </div> 
		<!--TAB切换-->
		 <div class="tab_div" >
		  <div class="tab_div_a">
			   <ul>
				   <li class="qieh hideclass radius_left" id="c1" onclick="changeOrder('tab_div1')"><A class="radius_left" href="javascript:void(0)">产品功能</A></li>
				   <li class="hideclass radius_center" id="c2" onclick="changeOrder('tab_div2')"><A class="radius_center" href="javascript:void(0)" >产品帮助</A></li>
				   <li class="hideclass radius_right" id="c3" onclick="changeOrder('tab_div3')"><A class="radius_right" href="javascript:void(0)" >服务体系</A></li>
			   </ul>
		  </div> 
		</div>   
		<!--1--> 
		 <div id="tab_div">
		 <div class="tab_div" id="tab_div1">
		  <div class="tab_div_b">
			   <ul>
				   <li style="width:40%;"><hr/></li>
				   <li style="width:20%;padding-top:5px;">
						<div style="margin-left:10%;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(22,154,219);line-height:30px;vertical-align:middle;color:#fff;font-size:16px">产品功能</div></li>
				   <li style="width:40%;"><hr/></li>
			   </ul> 
		  </div> 
		  <div class="cache_pro_table" style="table-layout:fixed;clear:both;">
			<table style="width:100%;height:100%;border-collapse:separate;border-spacing:10px 20px">
				<tr style="height:50%">
					<td>
						<div class="desc_title" style="margin:20px 10px 10px 10px;">支持海量数据的分片</div>
						<div style="height:80px;margin:0px 10px;">DBS底层自动实现对表的分片，保证每个片上的数据分布均匀，减轻每台数据库的读写压力，提升整体读写性能。</div>
					</td>
					<td>
						<div class="desc_title" style="margin:20px 10px 10px 10px;">数据的自动路由</div>
						<div style="height:80px;margin:0px 10px;">在分片的基础上，实现对数据读写的自动路由，并且对应用是透明的，应用不需要关心数据底层的物理分布，对应用就像操作一张表一样。</div>
					</td>
				</tr>
				<tr style="height:50%">
					<td>
						<div class="desc_title" style="margin:20px 10px 10px 10px;">主从复制</div>
						<div style="height:80px;margin:0px 10px;">对于每一个分库节点都有一主一从，系统自动实现对数据的主从复制。</div>
					</td>
					<td>
						<div class="desc_title" style="margin:20px 10px 10px 10px;">读写分离</div>
						<div style="height:80px;margin:0px 10px;">基于主从复制，支持对表的读写分离，只需简单设计是只读模式，读操作默认会在从库上执行。</div>
					</td>
				</tr>
				<tr style="height:50%">
					<td>
						<div class="desc_title" style="margin:20px 10px 10px 10px;">高可用</div>
						<div style="height:80px;margin:0px 10px;">基于主从复制，会对主库和从库进行监控，并在主库或者从库发生宕机的时候，系统自动进行主从切换，保证系统的稳定性。</div>
					</td>
					<td>
						<div class="desc_title" style="margin:20px 10px 10px 10px;">简单易用</div>
						<div style="height:80px;margin:0px 10px;">对于应用层只需要像配置普通的数据源一样，配置一个DBS的数据源，就可以使用。</div>
					</td>
				</tr>
			</table>
		  </div>
		</div>   
		<!--2--> 
		 <div class="tab_div" id="tab_div2">
		  <div class="tab_div_b">
			   <ul>
				   <li style="width:40%;"><hr/></li>
				   <li style="width:20%;padding-top:5px;">
						<div style="margin-left:10%;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(22,154,219);line-height:30px;vertical-align:middle;color:#fff;font-size:16px">产品帮助</div></li>
				   <li style="width:40%;"><hr/></li>
			   </ul>
		  </div> 
		  <div class="cache_pro_help">
				<ul style="float:left;padding-left:20%;">
					<li class="desc_title">入门指南</li>
					<li><a href="javascript:void(0);" onclick="javascript:downloadFile('PaaS-DBS.docx','2')">DBS使用说明书</a></li>
				</ul>
				<ul style="float:right;padding-left:10%">
					<li class="desc_title">常见问题</li>
					<li><a href="${_base }/help/FAQ#DBS1">sql执行报错？</a></li>
					<li><a href="${_base }/help/FAQ#DBS2">数据源初始化失败？</a></li>
					<li><a href="${_base }/help/FAQ#DBS3">刚插入的数据，指定从库读取，查询不到？</a></li>
					<li><a href="${_base }/help/FAQ#DBS4">DBS是否出现不一致的情况，例如（事务提交过程中，数据库宕机）？</a></li>
					
				</ul>
		  </div>
		</div>  
		<!--3-->   
		 <div class="tab_div" id="tab_div3">
		  <div class="tab_div_b">
			   <ul>
				   <li style="width:40%;"><hr/></li>
				   <li style="width:20%;padding-top:5px;">
						<div style="margin-left:10%;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(22,154,219);line-height:30px;vertical-align:middle;color:#fff;font-size:16px">服务体系</div></li>
				   <li style="width:40%;"><hr/></li>
			   </ul>
		  </div> 
		
		<div class="cache_pro_serv" style="table-layout:fixed;clear:both;">
				<table style="width:90%">
					<tr style="height:100px;">
						<td style="text-align:right;padding-right:110px">
							<img src="${_base }/resources/images/free.png"/>
						</td>
						<td style="text-align:left;line-height:30px">
							<p>
								<font style="font-size:25px;font-weight:900;color:red">免费</font>
								<font style="font-size:16px;font-weight:900;color:#000">使用</font></p>
							<p>虚拟机、存储、难点技术均提供无偿服务。</p>
						</td>	
					</tr>
					 <!-- 
					 <tr style="height:200px;">
						<td style="text-align:right;padding-right:110px">
							<img src="${_base }/resources/images/private.png"/>
						</td>
						<td style="text-align:left;line-height:30px">
							<p>
								<font style="font-size:16px;font-weight:900;color:#000">私人</font>
								<font style="font-size:25px;font-weight:900;color:rgb(38,162,222)">定制</font>
								<font style="font-size:16px;font-weight:900;color:#000">服务</font></p>											
														<p>您只需说明Saas应用的业务需求，专业的集成哥、<br/>
							技术大拿为您分析，提供集成、核心技术方案。</p>
						</td>	
					</tr> -->
					<tr style="height:100px;">
						<td style="text-align:right;padding-right:110px">
							<img src="${_base }/resources/images/study.png"/>
						</td>
						<td style="text-align:left;line-height:30px">
							<p>
								<font style="font-size:35px;font-weight:900;color:rgb(119,189,88)">0</font><font style="font-size:16px;font-weight:900;color:#000">障碍沟通、学习</font></p>
							<p>小伙伴们face to face交流。</p>
						</td>	
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
 
 function changeOrder(ele){
	 $("#"+ele).insertBefore($("#tab_div").children(":first"));
 }
 
 function downloadFile(fileId,type){
	 var url ="${_base}/audit/download?fileId="+fileId+"&type="+type;
	 url = encodeURI(encodeURI(url));
	 window.location.href=url;
	 
 }
</script>
  </body>
</html>
