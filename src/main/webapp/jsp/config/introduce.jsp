<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<title>亚信云【CCS】</title>
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
   <script>
   	$(document).ready(function(){
   		$('a[id^=active_]').each(function(){
   			$(this).css('color', '#949494');
   		});
   		$('#active_prod').css('color', '#1699dc');
//    		$('.mune_2').css('padding-left', '1%');
   		
   	});
   </script>
  </head> 
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
        <li><a>配置中心CCS</a></li>
        </ul>
        </div>
        
        <div class="Open_cache_list"> 
          <div class="Open_cache_list_none">
			  <ul style="float:left;width:15%;text-align:right">
				<li><img src="${_base }/resources/images/peizhi.png"></li>
			  </ul>
			  <ul style="float:left;width:55%;padding-left:3%;line-height:25px">
				<li style="font-size:16px;font-weight:600">配置中心CCS</li>
				<li style="color:#949494">配置中心服务（Configuration Center Service）是基于Zookeeper技术实现，采用key-value数据结构，通过树形结构进行分类存储的统一+C5配置服务。CCS能够帮助应用开发者对系统的参数配置信息进行集中管理，可替代传统的配置文件、数据库参数表，且性能高于传统方式。</li>
				<li>
					<a href="${_base}/ccs/toOpenConfig"><div style="margin-top:20px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(121,189,90);line-height:30px;vertical-align:middle;color:#fff">立即开通</div></a>
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
						<div class="desc_title" style="margin:20px 10px 10px 10px;">从此告别繁琐的配置工作，简化部署</div>
						<div style="height:80px;margin:0px 10px;">减少配置文件、实时推送信息变化。</div>
<!-- 						<p class="desc_title">从此告别凌乱的配置，say goodby to 凌乱的配置</p> -->
<!-- 						<p>减少配置文件以及实时推送配置信息给各个系统</p> -->
					</td>
					<td>
						<div class="desc_title" style="margin:20px 10px 10px 10px;">可视化管理</div>
						<div style="height:80px; margin:0px 10px;">以树形结构展现，非常便捷且可分类管理，能够帮助应用开发者对系统的参数配置信息进行集中管理。</div>
<!-- 						<p class="desc_title">便捷实用</p> -->
<!-- 						<p>以树形结构展现，非常便捷且可分类管理，能够帮助应用开发者对系统的参数配置信息进行集中管理，替代传统的配置文件、数据库参数表。</p> -->
					</td>
				</tr>
				<tr style="height:50%">
					<td>
						<div class="desc_title" style="margin:20px 10px 10px 10px;">高可用、高可靠</div>
						<div style="height:80px; margin:0px 10px;">集群模式、多数据副本。</div>
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
					<li><a href="javascript:void(0);" onclick="javascript:downloadFile('PaaS-CCS.docx','2')">CCS使用说明书</a></li>
				</ul>
				<ul style="float:right;padding-left:10%">
					<li class="desc_title">常见问题</li>
					<li><a href="${_base }/help/FAQ#CSS1">如何将传统配置信息批量切换到CCS？</a></li>
					<li><a href="${_base }/help/FAQ#CSS2">配置信息变更如何动态生效？</a></li>
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
								<font style="font-size:25px;font-weight:900;color:red">免费</font><font style="font-size:16px;font-weight:900;color:#000">使用</font></p>
							<p>虚拟机、存储、难点技术均提供无偿服务</p>
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
					</tr>
					-->
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
