<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<title>亚信云【VM】</title>
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
        <li><a>云虚拟机（VM）</a></li>
        </ul>
        </div>
        
        <div class="Open_cache_list"> 
          <div class="Open_cache_list_none">
			  <ul style="float:left;width:15%;text-align:right">
				<li><img src="${_base }/resources/images/v3.png"></li>
			  </ul>
			  <ul style="float:left;width:55%;padding-left:3%;line-height:25px">
				<li style="font-size:16px;font-weight:600">简介</li>
				<li style="color:#949494; width:650px;">虚拟机（Virtual Machine）
是依托开源、成熟的Openstack云计算平台以及分布式存储技术，整合了计算、存储、网络、数据中心等IT基础设施资源，提供的安全稳定、快速部署、弹性扩展、管理便捷的计算存储服务。
亚信云主机基于X86构架,可以支持基于X86构架的各种版本的Windows、Linux主机服务，并提供可弹性扩展的超大容量、低成本的弹性存储，适用于文件系统、数据库等不同应用系统的需求
目前已开通了面向亚信内部研发、IT-MIS等业务为支撑目标的北京总部云资源池，未来还将开通面向亚信内部互联网业务、在线运营业务的云资源池。


				</li>
				<li>
					<a href="${_base}/virtualMachine/goVirtualMachineApply"><div style="margin-top:20px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(121,189,90);line-height:30px;vertical-align:middle;color:#fff">立即开通</div></a>
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
				<tr style="height:60%">
					<td>
						<div class="desc_title" style="margin:20px 10px 10px 10px;">弹性计算、存储资源</div>
						<div style="height:80px;margin:0px 10px;">
						弹性计算能力和弹性存储资源，支持CPU、内存、存储资源的弹性扩展	<br>
				                数据安全性，支持系统盘和数据盘基于克隆、快照的备份和恢复；
						</div>
					</td>
					<td>
						<div class="desc_title" style="margin:20px 10px 10px 10px;">高可用性、可靠性</div>
						<div style="height:80px;margin:0px 10px;">
						高可用性，支持主机在不同物理机之间的迁移，实现故障的快速恢复
						高可靠性，基于分布式文件系统的存储服务，支持多数据副本、没有单点故障，支持存储节点掉电、宕机、硬盘故障等容错；
						
						</div>
					</td>
				</tr>
				<tr style="height:40%">
					<td>
						<div class="desc_title" style="margin:20px 10px 10px 10px;">基本（参数）规格</div>
						<div style="height:90px;margin:0px 10px;">
						计算资源规格：单个云虚拟机支持1-16vCPU，1-64GB内存<br>
						云硬盘：磁盘IO性能最大可达128MB/s，单块硬盘最高可支持2TB<br>
						网络：千兆网络，支持绑定浮动的公网IP连接外网</div>
					</td>
					<td>
						<div class="desc_title" style="margin:20px 10px 10px 10px;">支持多操作系统</div>
						<div style="height:90px;margin:0px 10px;">
						操作系统：支持目前主流的操作系统，版本包括：ArchLinux 2014.10, CentOS 6.5, CentOS 7.0, openSUSE 13.1, Ubuntu 12.04, Ubuntu 13.10, Ubuntu 14.04,Redhat linux 5.0, Redhat linux 6.0, Windows Server 2008，Windows Server 2012
						</div>
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
				<ul style="float:left;padding-left:10%;">
				    <li class="desc_title">常见问题</li>
					<li><a href="${_base }/help/FAQ#VM1">虚拟机申请时提示员工信息加载失败？</a></li>
					<li><a href="${_base }/help/FAQ#VM2">虚拟机申请时截止日期需大于当前日期 ？</a></li>
					<li><a href="${_base }/help/FAQ#VM3">一个用户可以申请多个虚拟机服务吗？</a></li>
					<!-- <li class="desc_title">入门指南</li>
					<li><a href="javascript:void(0);" onclick="javascript:downloadFile('PaaS-DES.docx','2')">DES使用说明书</a></li>
					<li>
					 <a>基于服务器虚拟化技术的高效、弹性的计算资源服务可快速部署、即开即用，最大化的提高应用交付效率。</a></li> -->
				</ul>
				<ul style="float:right;padding-left:10%">
					<%-- <li class="desc_title">常见问题</li>
					<li><a href="${_base }/help/FAQ#VM1">虚拟机申请时提示员工信息加载失败？</a></li>
					<li><a href="${_base }/help/FAQ#VM2">虚拟机申请时截止日期需大于当前日期 ？</a></li>
					<li><a href="${_base }/help/FAQ#VM3">一个用户可以申请多个虚拟机服务吗？</a></li> --%>
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
