<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

  <div class="col-md-6 left_list" >
    <div class="list_groups">
       <div class="list_groups_none">
	      <ul>
	        <li class="biaot"  style="background:rgb(22,154,219)" onClick="turnit(6,3,this);">
		        <a href="#" style="color:#fff">
			        <p><img src="${_base }/resources/images/icon1.png"></p>
			        <p>计算</p>
			        <p class="sanjiao"><img src="${_base }/resources/images/a.png" id="img3" /></p>
		         </a>
	         </li>
	         <li class="list_xinx"  id="content3" > 
				<!--  <p><A href="${_base }/iaas/applyPhysicalMachine"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;" id="list_9">物理机</span></A></p>-->
				<!--  <p><A href="${_base }/iaas/applyVirtalMachine"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;" id="list_10">虚拟机</span></A></p>-->
				<p><A href="${_base }/virtualMachine/initapply"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;" id="list_11">云虚拟机</span></A></p>
				<p><A href="${_base }/rcs/introduce"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;" id="list_04">实时计算RCS</span></A></p>
				<p><A href="${_base }/des/initapply"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px; " id="list_14">实时增量数据获取服务DES</span></A></p>
				<p><A href="${_base }/ses/initapply"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px; " id="list_15">搜索服务SES</span></A></p>
	        </li>
	     </ul>
	     <ul>
	        <li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(6,2,this);">
		       <a href="#" style="color:#fff">
			      <p><img src="${_base }/resources/images/icon2.png"></p>
			      <p>数据库服务</p>
			      <p class="sanjiao"><img src="${_base }/resources/images/a.png" id="img2"></p>
		       </a>
	        </li>
	        <li class="list_xinx"  id="content2" >
		        <p><A href="${_base }/dbs/introduce"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;" id="list_2">分布式数据库服务DBS</span></A></p>
				<p><A href="${_base }/txs/introduce"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;" id="list_6">事务保障服务TXS</span></A></p>
				<p><A href="${_base }/ats/introduce"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;" id="list_7">最终事务一致ATS</span></A></p>
	        </li>
	    </ul>
        <ul>
	        <li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(6,4,this);">
		        <a href="#" style="color:#fff">
		        <p><img src="${_base }/resources/images/icon3.png"></p>
		        <p>存储</p>
		        <p class="sanjiao"><img src="${_base }/resources/images/a.png" id="img4"></p>
		        </a>
	        </li>
	        <li class="list_xinx"  id="content4" >
		        <p><A href="${_base }/ccs/introduce"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;" id="list_1">配置中心CCS</span></A></p>
		        <p><A href="${_base }/mds/introduce"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;" id="list_4">消息中心MDS</span></A></p> 
				<p><A href="${_base }/mcs/introduce"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;" id="list_5">缓存中心MCS</span></A></p>
				<p><A href="${_base }/dss/introduce"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;" id="list_8">文档存储服务DSS</span></A></p>
				<p><A href="${_base }/idps/introduce"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;" id="list_12">图片服务</span></A></p>
	        </li>
	    </ul>
      </div> 
   </div>
</div>