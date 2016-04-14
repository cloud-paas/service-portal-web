<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<title>亚信云</title>
  <head>
   <%@ include file="/jsp/common/common.jsp"%>
            <style>
		hr {height:1px;  
			color:gray;  
			background-color:gray;  
			border:none;
		}
	</style>
  </head> 
  <body>    
   <script>
   	$(document).ready(function(){
   		$('a[id^=active_]').each(function(){
   			$(this).css('color', '#949494');
   		});
   		$('#active_help').css('color', '#1699dc');
//    		$('.mune_2').css('padding-left', '1%');
   		
   	});
   </script>
   <style>
   
.chaj ul li p span {
    color: #65c6f1;
    float: left;
    text-align: right;
    width: 154px;
}
   </style>
   <!--导航-->
   <div class="navigation">
		<%@ include file="/jsp/common/header.jsp"%>
		</div>
  <div class="container chanp">
   
  <div class="row chnap_row">
  <div class="col-md-6 left_list" >
      <div class="list_groups">
             <div class="list_groups_none">
            <ul>
             <li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(6,2,this);">
             <a href="javascript:void(0);" style="color:#fff">
             <p id="img2">用户指南</p>
             </a>
             <li class="list_xinx"  id="content2" >
             <p ><A href="${_base }/help/nt"><span style="margin-top:2px;">亚信NT账号登录</span></A></p>
             <p><A href="${_base }/help/mail"><span style="margin-top:2px;">自助注册邮箱登录</span></A></p>
              <p><A href="${_base }/help/paas"><span style="margin-top:2px;">Paas资源申请</span></A></p>
             </li>
             </li>
             </ul>
             
             <ul>
             <li class="biaot" style="background:rgb(22,154,219)" >
             <a href="${_base }/help/FAQ" style="color:#fff">
             <p id="img2">常见问题</p>
             </a>
            
             </li>
             </ul>
             
             <ul>
             <li class="biaot" style="background:rgb(22,154,219)" >
             <a href="${_base }/help/manual" style="color:#fff">
             <p id="img2">使用手册</p>
             </a>
            
             </li>
             </ul>
             
             </div> 
    </div>
  
  </div>
 <div class="col-md-6 right_list">
     
     
     
    <div class="Open_cache">
            <div class="Open_cache_table">
			<ul style="border-bottom:1px #eee">
			<li><a href="javascript:void(0);">常见问题</a></li> 
			</ul>  
        </div> 

    <div class="chaj">
    <ul>
    <li>
    <p><span>通用问题&nbsp;&nbsp;Q:</span></p>
    <p>Paas服务的SDK认证地址参数何如获取</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    
 <ul id="ChildMenu1" class="collapsed">
 <li>
A：登录门户，从用户账号那里查看。</li>
 </ul>
    
    </li>
    <li id="SAAS">
    <p><span>Q:</span></p>
    <p>使用Ipaas的SDK开发的Saas应用部署</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    
  <ul id="ChildMenu2" class="collapsed">
 <li>
<img src="${_base }/resources/images/bj.png"></li>
 </ul>
    
    
    </li>
    <li id="DEVFAQ">
    <p><span>Q:</span></p>
    <p>亚信云平台下的开发、测试、生产环境使用说明</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
     <ul id="ChildMenu1" class="collapsed">
 <li>
    A：亚信云平台Paas服务需针对每套环境各申请一套Ipaasfuwu ,即同一服务（如：DBS）申请3个实例，分别应用到开发、测试、生产环境</li>
    </ul>
    </li>
    <li id="MONITOR">
    <p><span>Q:</span></p>
    <p>异步事务服务能否代替分布式事务</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
 A：异步事务服务不能直接代替两阶段，调用方式不同，需要通过业务设计 ，分离分布式事务中的多个参与者。
 </li></ul>
    </li>
    
    <!-- 配置中心CSS -->
    <li id="CSS1">
    <p><span>配置中心&nbsp;&nbsp;Q:</span></p>
    <p>如何将传统配置信息批量切换到CCS？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：在用户管理控制台提供可视化的界面导入功能，快捷方便切换。
 </li></ul>
    </li>
    <li id="CSS2">
    <p><span>Q:</span></p>
    <p>配置信息变更如何动态生效？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
     <ul id="ChildMenu1" class="collapsed">
 <li>
A：SaaS租户首先实现配置变更事件监听接口，该接口可实时获取配置变化信息；最后租户使用变化信息。
 </li></ul>
    </li>
    
    <li id="MCS1">
    <p><span>缓存中心&nbsp;&nbsp;Q:</span></p>
    <p>多大的数据最适合存储在MCS上？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：MCS支持的Key的最大上限为2GB；支持的Value的最大上限为2GB。但太大的对象，会占用较大带宽，导致较小的QPS，所以通常情况下建议key最大1k、Value的大小在1M以下为宜。
 </li></ul>
    </li>
    <li id="MCS2">
    <p><span>Q:</span></p>
    <p>MCS的数据支持持久化吗？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
     <ul id="ChildMenu1" class="collapsed">
 <li>
A：MCS实例中的数据是存储在内存中的，当出现宕机、机房断电等意外，或是MCS实例在正常升级维护时，内存中的数据均会丢失。因此，不能将MCS作为持久化的数据存储服务使用。
 </li></ul>
    </li>
    <li id="DSS1">
    <p><span>文档存储服务&nbsp;&nbsp;Q:</span></p>
    <p>DSS是不是分布式存储？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>A: DSS是分布式海量小文件存储系统。</li></ul>
    </li>
    <li id="DSS2">
    <p><span>Q:</span></p>
    <p>多大的数据文件适合存储在DSS？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：DSS支持单个文件最大4M，大文件暂时不支持存储。
</li></ul>
    </li>
    <li id="DSS3">
    <p><span>Q:</span></p>
    <p>可以申请多大存储空间？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：DSS支持512M~2048M的空间。
</li></ul>
    </li>
    
    <li id="MDS1">
    <p><span>消息中心&nbsp;&nbsp;Q:</span></p>
    <p>MDS SDK中的发送方法中第三个参数key的含义？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 		<li>A：第三个参数表示消息的唯一标识，在后续消费时依据场景可能会被用到（如对接storm），若消费端不需要则参数值赋null。</li>
 	</ul>
    </li>
    <li id="MDS2">
    <p><span>Q:</span></p>
    <p>MDS SDK 消费端为什么要实现两个接口？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 		<li>A：MDS 消费端设计成多进程、多线程模式，即每个消息分区会有一个线程对应消费，因此一个接口用于真正的消息消费，一个接口用于实例化具体的消费线程。</li>
 	</ul>
    </li>
    <li id="MDS3">
    <p><span>Q:</span></p>
    <p>MDS SDK 消费端是否支持集群模式？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 		<li>MDS SDK 消费端支持高可用和负载均衡，因此即使某个进程挂掉，其他进程会接管。当更多的进程起来时，工作会进行相应的重新分配，重新分配期间不影响消息的消费。</li>
 	</ul>
    </li>
    
    <li id="ATS1">
    <p><span>异步事务服务&nbsp;&nbsp;Q:</span></p>
    <p>异步事务服务能否代替分布式事务？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A:异步事务服务不能直接代替两阶段，调用方式不同，需要通过业务设计 ，分离分布式事务中的多个参与者。

</li></ul>
    </li>
    <li id="ATS2">
    <p><span>Q:</span></p>
    <p>什么情况适用异步事务服务？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：用于系统负载大，模块数量多，每个模块功能复杂。
</li></ul>
    </li>
    
    
    
    
    <li id="RCS1">
    <p><span>实时计算&nbsp;&nbsp;Q:</span></p>
    <p>运行时看不到日志文件？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 		<li>A：因为租户在开发输入类和处理类的时候，没有实现日志文件的标识设置方法。</li>
 	</ul>
    </li>
    <li id="RCS2">
    <p><span>Q:</span></p>
    <p>界面没有展示jar包的输入类和处理类信息？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 		<li>A：jar包的名称没有按规范要求命名或者符合规范但是没有实现流程定义接口方法，详细请参考SDK使用手册。</li>
 	</ul>
    </li>
    
    
    <li id="TXS1">
    <p><span>事务保障服务&nbsp;&nbsp;Q:</span></p>
    <p>什么情况需要使用事务保障服务？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：1.使用超过一个物理数据库，包括使用数据库服务（DBS）；2.使用异步事务服务时必须使用。
</li></ul>
    </li>
    <li id="TXS2">
    <p><span>Q:</span></p>
    <p>事务保障服务是否能保障分布式事务的强一致性，完全避免事务不一致性？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：不可以。事务保障服务保证在发生事务不一致性风险时，能够进行识别和告警。如果此次事务中存在异步事务，则保证此异步事务尽可能送达。
</li></ul>
    </li>
    <li id="TXS3">
    <p><span>Q:</span></p>
    <p>事务保障服务支持几种事务管理机制？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：目前只支持基于Spring的事务控制器，用于替代Spring自带的org.springframework.jdbc.datasource.DataSourceTransactionManager。
</li></ul>
    </li>
    
    <li id="DBS1">
    <p><span>分布式数据库服务&nbsp;&nbsp;Q:</span></p>
    <p>sql执行报错？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：目前SDK只能支持一些常用的标准SQL，对于复杂的SQL不支持，具体的支持的SQL，请参看分布式数据库前台操作工具里的帮助，里面列出了支持的具体的SQL。
</li></ul>
    </li>
    <li id="DBS2">
    <p><span>Q:</span></p>
    <p>数据源初始化失败？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：请确认配置的服务信息正确，包括：用户名、密码、服务ID、SDK认证地址。
</li></ul>
    </li>
    <li id="DBS3">
    <p><span>Q:</span></p>
    <p>刚插入的数据，指定从库读取，查询不到？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：情况一：分布式数据库支持读写分离，但是请不要在同一事务中，写入之后，然后指定从读库进行读取，这时事务还未提交，从库还未同步，因此读取不到。情况二：主库写入操作提交后同步到从库有延迟。
</li></ul>
    </li>
    <li id="DBS4">
    <p><span>Q:</span></p>
    <p>DBS是否出现不一致的情况，例如（事务提交过程中，数据库宕机）？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A: 分布式数据库采取的是弱事务一致性，在特殊情况下可能会出现数据不一致的情况（例如数据库事务提交过程中，数据库宕机）。建议申请分布式数据库服务的时候，勾选分布式事务。
</li></ul>
 </li>
 
<!-- ********************************************************** -->

    <li id="VM1">
    <p><span>虚拟机申请服务&nbsp;&nbsp;Q:</span></p>
    <p>虚拟机申请员工信息加载失败？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：目前虚拟机申请需要用户登录后申请，而登录成功后会更加NT账号查找员工信息；如果非公司内部员工或NT账号非法，就会查找不到员工信息，所以在申请页面会提示员工信息加载失败。
</li></ul>
    </li>
    
        <li id="VM2">
    <p><span>Q:</span></p>
    <p>虚拟机申请时截止日期需要大于当前日期 ？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：是的。虚拟机申请时当前时间为系统当前时间，到期时间（截止日期）时您使用虚拟机到什么时候结束的时间，因此您选择的到期时间（截止日期）需要大于当前日期 。
</li></ul>
    </li>
    
        <li id="VM3">
    <p><span>Q:</span></p>
    <p>一个用户可以申请多个虚拟机服务吗？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：可以的。目前一个用户可以申请多个虚拟机服务(前提是有足够的虚拟机配额)。
</li></ul>
    </li>

<!--***************************************************** -->


    <li id="DES1">
    <p><span>增量数据获取服务&nbsp;&nbsp;Q:</span></p>
    <p>如何使用des服务？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：申请好des服务后，需要将一个dbs服务、mds服务与des服务进行绑定，然后编辑观察表。下载des的sdk，使用像消费mds消息一样的代码，获取des的数据。
</li></ul>
    </li>
    

    <li id="DES2">
    <p><span>Q:</span></p>
    <p>是否支持多个目标数据源？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：是。des将数据封装为java对象。支持使用者将数据再写入多目标源，由使用者来控制。
</li></ul>
    </li>
    <li id="DES3">
    <p><span>Q:</span></p>
    <p>一个des服务可以绑定多个dbs和mds吗？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 <li>
A：不可以，一个des服务仅仅可以绑定一个dbs服务和一个mds服务。
</li></ul>
    </li>
    
    <!-- 搜索服务SES -->
    <li id="SES1">
    <p><span>搜索引擎服务&nbsp;&nbsp;Q:</span></p>
    <p>如何定义文档结构？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 		<li>A：用户可以通过界面，自由配置文档的字段及属性，主要json的格式配置。</li>
 	</ul>
    </li>
    <li id="SES2">
    <p><span>Q:</span></p>
    <p>数据一致性，搜索服务器中的数据实时更新如何做？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 		<li>A：目前，建议业务应用自己来做，我们会提供数据更变的API、SES的SDK。您需要根据数据变更的明细，封装文档结构，插入到搜索服务器。</li>
 	</ul>
    </li>
    <li id="SES3">
    <p><span>Q:</span></p>
    <p>是否支持文档数据来源于不同的数据库？</p>
    <p><img src="${_base }/resources/images/help_q.png"></p>
    <ul id="ChildMenu1" class="collapsed">
 		<li>A：支持文档中的字段，分别来自不同的数据库，可以同时包含DBS、mysql数据库。</li>
 	</ul>
    </li>
    
    
    </ul>
    
    </div>
     </div> 
 
  </div>
</div>

</div>
		
   <div class="row Contact" id="contect">
   
   <div class="Contact_a">
   <ul class="cdd">
   <li class="cont">联系我们</li>
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_a.png"></p>
   <p>${contactMail }</p>
   </li>
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_b.png"></p>
   <p>AIC-TSD-BJ</p>
   </li>
   
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_c.png"></p>
   <p>北京市海淀区西北旺东路10号院东区 亚信大厦</p>
   </li>
   
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_d.png"></p>
   <p>http://www.asiainfo.com</p>
   </li>
   </ul>
   
   <ul class="cdd bdd">
   <li class="cont">客户服务</li>
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_e.png"></p>
   <p>${contactName }</p>
   </li>
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_f.png"></p>
   <p>${contactMobile }</p>
   </li>
   
   <li>
   <p class="lx_ing"><img src="${_base }/resources/images/bz_g.png"></p>
   <p>${contactQQ }</p>
   </li>
  
   </ul>
   
   
   <ul class="cdd bdd">
   <li class="cont">关注我们</li>
   <li><img src="${_base }/resources/images/bz_h.png"></li>
   </ul>
   
   
   <ul class="cdd bdd">
   <li class="cont">我们的位置</li>
   <li><img src="${_base }/resources/images/bz_i.png"></li>
   </ul>
   
   </div>
   </div>
<!--页脚-->

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
</script>
  </body>
</html>
