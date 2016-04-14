<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
  <head>
<%@ include file="/jsp/common/common.jsp"%>

<style>
label.error {
  color: red;
  font-style: italic;
}
</style>
 <script>
	var openOCSController;
	$(document).ready(function(){
		$("#navi_tab_product").addClass("chap");
		openOCSController = new $.OpenOCSController();
		//$("#my_size").find("option[value='${userCacheResultVo.cache_memory}']").attr("selected",true);
		jQuery.validator.addMethod("isEn", function(value, element,param) {
			return this.optional(element) || /^[A-Za-z0-9_-]+$/.test(value);
		 }, "虚拟机名称须输入字母和数字");
		$("#virtalForm").validate({
			onkeyup:false,
			rules: {
				vmName: {
					required:true,
					isEn:true,
					remote:{
						type:"POST",
						url:"validName", 
						data:{
							vmName:function(){return $("#vm_name").val();}
						}
					},
					rangelength:[2,20]
				}
				
		
			},
			 messages: {
				 vmName: {
					 required:"请输虚拟机名称",
					 isEn: jQuery.validator.format("虚拟机名称须输入字母和数字"),
					 remote:jQuery.validator.format("虚拟机名称已使用"),
					 rangelength:jQuery.validator.format("队列名称必须介于 {0}和 {1} 之间的字符串")
				 }
				 
			 }
			
		});
		
	});
	/*定义页面管理类*/
	(function(){
		$.OpenOCSController  = function(){ 
			this.settings = $.extend(true,{},$.OpenOCSController.defaults); 
			this.init();
			
		};
		$.extend($.OpenOCSController,{
			defaults : { 
				XNJ_LI_SYS : "#xnj_li_sys",
				XNJ_LI_CPU : "#xnj_li_cpu",
				XNJ_LI_VMNAME : "#xnj_li_vmname",
				XNJ_LI_NC : "#xnj_li_nc",
				XNJ_LI_YP : "#xnj_li_yp",
				XNJ_LI_BUSI : "#xnj_li_busi",
			     	  SUBMIT_ID : "#my_submit"
			     	   
			},
			prototype : {
				init : function(){
					var _this = this;
					_this.addRults();
					_this.bindEvents();				
				},
				bindEvents : function(){
					var _this = this;					
					$(_this.settings.SUBMIT_ID).bind("click",function(){
						if(!$("#virtalForm").valid()){
							return;
						};
							var my_sys=$(_this.settings.XNJ_LI_SYS).text();
							var my_cpu=$(_this.settings.XNJ_LI_CPU).text();
							var my_vmname=$(_this.settings.XNJ_LI_VMNAME).text();
							var my_nc=$(_this.settings.XNJ_LI_NC).text();
							var my_yp=$(_this.settings.XNJ_LI_YP).text();
							var my_busi=$(_this.settings.XNJ_LI_BUSI).text();
							//if(my_password=="")
								
							$.ajax({
								async : false,
								type : "POST",
								url : "${_base}/iaas/saveVirtalMachineInfo",
								modal : true,
								showBusi : false,
								data : {
									my_sys : my_sys,
									my_cpu	: my_cpu,
									my_vmname : my_vmname,
									my_yp : my_yp,
									my_busi : my_busi,
									my_nc : my_nc
								},
								success: function(data){
									var json=data
									if(json&&json.resultCode=="0000"){
										
										location.href="${_base}/mcs/applyCompleted";
									}else{									
										alert(json.resultMessage);									
									}
								}
							});	
					});										
				},			
				addRults : function() {				
				    var myForm = $("#myForm");
				    myForm.validate({
		                rules: {
		                	my_name: {
		                        required: true,
		                        rangelength:[1,128]
		                    }, 		                  
		                    my_password: {
		                    	required: true,
		                    	rangelength:[6,18]
		                    }
		                },
		                messages:{
		                	my_name:{
		                		required:"服务名称不能为空",
		                		rangelength:"请输入128位以内服务名称"
		                	},
		                	my_password:{
		                		required:"服务密码不能为空",
		                		rangelength:"请输入6~16位服务密码"
		                	}
		                	
		                },
		                success: function (label, element) {
		                    $(element).removeAttr("style");
		                },
		                errorPlacement: function (error, element) {
		                	//error.appendTo($(element+(_error))); 
		                	$("#"+$(element).attr("id")+"_error").text($(error).text());
		                    $(element).css("border-color", "rgb(249, 135, 135)");
		                },
		                submitHandler: function () {
		                	myForm.valid();
		                }
		            }); 
				}
			}
		});
	})(jQuery);
	</script>
	 <script>
   	$(document).ready(function(){
   		$('a[id^=active_]').each(function(){
   			$(this).css('color', '#949494');
   		});
   		$('#active_prod').css('color', '#1699dc');
//    		$('.mune_2').css('padding-left', '1%');
   		$("#list_10").attr('style', 'margin-top:2px;color:#1699dc');
   	});
   </script>
  </head> 
  <body>     
    <div class="big_k"><!--包含头部 主体-->  
   <!--导航-->
   
   
  <div class="big_k"><!--包含头部 主体-->  
   <!--导航-->
   <div class="navigation">
		<%@ include file="/jsp/common/header.jsp"%>
	</div>
  <div class="container chanp">
	 	<div class="row chnap_row">
    <%@ include file="/jsp/common/leftMenu_new.jsp"%>
  <div class="col-md-6 right_list">
     
      <div  class="float_div">
		<p style="border-bottom:solid 1px #eee">当前配置</p>
		 
		<ul style="">
			<li class="float_div_title">虚拟机</li>
			<li id="xnj_li">
				操作系统：<span id="xnj_li_sys">Linux</span></br>
				CPU：<span id="xnj_li_cpu">1核</span></br>
				内存：<span id="xnj_li_nc">512M</span>	</br>
				虚拟机名称：<span id="xnj_li_vmname"></span></br>
				硬盘：<span id="xnj_li_yp"></span></br>
				业务名称：<span id="xnj_li_busi"></span></br>
			</li> 
		</ul> 
		<ul style="padding-left:10%">   
		  <li>
			<a href="#" id="my_submit"><div style="margin-top:20px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(121,189,90);line-height:30px;vertical-align:middle;color:#fff">立即开通</div></a>
		  </li> 
		 </ul> 
	 </div>
	 <div class="Open_cache">
        <div class="Open_cache_table">
        <ul>
        <li><a href="#">Iaas</a></li>
        </ul>
        </div> 
        <div class="Open_cache_list" style="margin-top:0px">  
           <form id="virtalForm">
           <table class="iaas_table" style="border-spacing:0px 10px;border-collapse:separate;"> 
				<tr>
					<td width="3%"  class="iaas_table_title" style="background:rgb(202,202,202);padding:0px 20px 0px 20px;border:solid 1px #eee">虚拟机</td>
					<td width="93%"  style="background:rgb(243,243,243);border:solid 1px #eee">
						<table  style="text-align:center;border-spacing:10px 40px;border-collapse:separate">
							<tr>
								<td width="20%" class="iaas_table_title">操作系统：</td>
								<td width="80%">
									<!--TAB切换-->
									 <div class="tab_div_sys">
									  <div class="tab_div_a_sys">
										   <ul>
											   <li class="qieh hideclass radius_left" id="c1"><A class="radius_left" href="#top_one">		Linux</A></li>
											   <li class="hideclass radius_right" id="c2"><A class="radius_right" href="#top_two" >
											   Windows
											   </A></li>  
										   </ul> 
									  </div> 
									</div>  
								</td>
							</tr>
							<tr>
								<td width="20%" class="iaas_table_title">cpu：</td>
								<td width="80%">
									<!--TAB切换-->
									 <div class="tab_div_cpu">
									  <div class="tab_div_a_cpu">
										   <ul>
											   <li class="qieh hideclass radius_left" id="c1"><A class="radius_left" href="#top_one">		1核</A></li>
											   <li class="hideclass" id="c1"><A class="" href="#top_one">2核</A></li>
											   <li class="hideclass" id="c1"><A class="" href="#top_one">4核</A></li>
											   <li class="hideclass" id="c1"><A class="" href="#top_one">8核</A></li>
											   <li class="hideclass radius_right" id="c2"><a class="radius_right" href="#top_two">
											   16核
											   </a></li>  
										   </ul> 
									  </div> 
									</div>  
								</td>
							</tr>
							<tr>
								<td width="20%" class="iaas_table_title">内存：</td>
								<td width="80%">
									<!--TAB切换-->
									 <div class="tab_div_neicun">
									  <div class="tab_div_a_neicun">
										   <ul>
											   <li class="qieh hideclass radius_left" id="c1"><A class="radius_left" href="#top_one">		512M</A></li>
											   <li class="hideclass" id="c1"><A class="" href="#top_one">1G</A></li>
											   <li class="hideclass" id="c1"><A class="" href="#top_one">2G</A></li>
											   <li class="hideclass" id="c1"><A class="" href="#top_one">4G</A></li>
											   <li class="hideclass radius_right" id="c2"><a class="radius_right" href="#top_two">
											   8G
											   </a></li>  
										   </ul> 
									  </div> 
									</div>  
								</td>
							</tr>
							<tr>
								<td width="20%" class="iaas_table_title">虚机名称：</td>
								<td width="80%">
									<input id="vm_name" name="vmName" type="text" class="form-control"aria-describedby="sizing-addon2" style="border-radius:15px;width:50%" >
								 </td>
							</tr>
							<tr>
								<td width="20%" class="iaas_table_title">数据盘：</td>
								<td width="80%">
									<!--TAB切换-->
									 <div class="tab_div_yp">
									  <div class="tab_div_a_yp">
										  <div class="User_ratings User_grade" id="div_fraction0"> 
											<div class="ratings_bars" style="position: relative;">  
												<div class="scale" id="bar0">
													<div></div>
													<span id="btn0"><span id="title0">0G</span></span>
												</div>
											 	<span style="position: absolute; top: 5px;right: 58px; font-family: Georgia,Times New Roman,Times,serif;font-size: 14px;color: #a0a0a0;">500G</span>
											</div>
										</div>
									  </div> 
									</div>  
								</td>
							</tr>
							<tr>
								<td width="20%" class="iaas_table_title">业务：</td>
								<td width="80%">
									<input id="busi_name" type="text" class="form-control"aria-describedby="sizing-addon2" style="border-radius:15px;width:50%" >
								 </td>
							</tr>
						</table>
					</td>
				</tr>  
		   </table>
		   </form>
        </div>   
     </div> 
 
  </div>
</div>

</div>
</div>  
<!--页脚-->
<%@ include file="/jsp/common/footer_new.jsp"%>
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
 
//虚拟机-操作系统
$(".tab_div_a_sys li").click(function(){ 
	 var this_text = $(this).text();  
	 appendFactory("xnj_li_sys",this_text,",");
	 
	 $(".tab_div_a_sys li").each(function(i){
		$(this).removeClass("qieh"); 
	 })
	$(this).addClass("qieh");
 });
 
 //虚拟机-cpu
 $(".tab_div_a_cpu li").click(function(){
	 var this_text = $(this).text();  
	 appendFactory("xnj_li_cpu",this_text,",");
	 
	 $(".tab_div_a_cpu li").each(function(i){
		$(this).removeClass("qieh");
	 })
	$(this).addClass("qieh");
 }); 

 //虚拟机-内存
 $(".tab_div_a_neicun li").click(function(){
	 var this_text = $(this).text();  
	 appendFactory("xnj_li_nc",this_text,",");
	 
	 $(".tab_div_a_neicun li").each(function(i){
		$(this).removeClass("qieh");
	 })
	$(this).addClass("qieh");
 });
 
 //虚拟机-名称
 $("#vm_name").keyup(function(){
	var this_text = $(this).val(); 
	appendFactory("xnj_li_vmname",this_text,","); 
 });
 
//虚拟机-硬盘
 $(".tab_div_a_yp li").click(function(){
	var this_text = $(this).text(); 
	appendFactory("xnj_li_yp",this_text,","); 
	
	 $(".tab_div_a_yp li").each(function(i){
		$(this).removeClass("qieh");
	 })
	$(this).addClass("qieh");
 });
 
 //虚拟机-业务
 $("#busi_name").keyup(function(){
	var this_text = $(this).val(); 
	appendFactory("xnj_li_busi",this_text,""); 
 }); 
 function appendFactory(id,text,flag){
	 $("#"+id).empty().append(text);
 }
 
 scale = function (btn, bar, title) {
	this.btn = document.getElementById(btn);
	this.bar = document.getElementById(bar);
	this.title = document.getElementById(title);
	this.step = this.bar.getElementsByTagName("DIV")[0];
	this.init();
};

scale.prototype = {
	init: function () {
		var f = this, g = document, b = window, m = Math;
		f.btn.onmousedown = function (e) {
			var x = (e || b.event).clientX;
			var l = this.offsetLeft;
			var max = f.bar.offsetWidth - this.offsetWidth + 10;
			g.onmousemove = function (e) {
				var thisX = (e || b.event).clientX;
				var to = m.min(max, m.max(-2, l + (thisX - x)));
				f.btn.style.left = to + 'px';
				f.ondrag(m.round(m.max(0, to / max) * 500), to);
				b.getSelection ? b.getSelection().removeAllRanges() : g.selection.empty();
			};
			g.onmouseup = new Function('this.onmousemove=null');
		};
	},
	ondrag: function (pos, x) {
		this.step.style.width = Math.max(0, x) + 'px';
		this.title.innerHTML = pos / 1 + 'G';
		appendFactory("xnj_li_yp",pos / 1 + 'G',""); 
	}
}
new scale('btn0', 'bar0', 'title0'); 
</script>
  </body>
</html>
