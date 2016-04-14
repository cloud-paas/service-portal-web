<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
  <head>
<%@ include file="/jsp/common/common.jsp"%>
 <script>
   	$(document).ready(function(){
   		$('a[id^=active_]').each(function(){
   			$(this).css('color', '#949494');
   		});
   		$('#active_prod').css('color', '#1699dc');
//    		$('.mune_2').css('padding-left', '1%');
   		$("#list_11").attr('style', 'margin-top:2px;color:#1699dc');
   	});
   </script>
 <script>
	var openOCSController;
	$(document).ready(function(){
		$("#navi_tab_product").addClass("chap");
		openOCSController = new $.OpenOCSController();
		//$("#my_size").find("option[value='${userCacheResultVo.cache_memory}']").attr("selected",true);
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
							var my_sys=$(_this.settings.XNJ_LI_SYS).text();
							var my_yp=$(_this.settings.XNJ_LI_YP).text();
							var my_busi=$(_this.settings.XNJ_LI_BUSI).text();
							//if(my_password=="")
							if(my_yp==""){
								
								alert("还未选择硬盘大小");
								return ;
							}
							if(my_busi==""){
								
								alert("请选择挂载虚拟机");
								return ;
							}
							
							
							$.ajax({
								async : false,
								type : "POST",
								url : "${_base}/iaas/saveMemoryInfo",
								modal : true,
								showBusi : false,
								data : {
									my_sys : my_sys,
									my_yp : my_yp,
									my_busi : my_busi
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
  
     
      <div  class="float_div">
		<p style="border-bottom:solid 1px #eee">当前配置</p>
		 
		<ul style="">
			<li class="float_div_title">虚拟机</li>
			<li id="xnj_li">
				存储标签：<span id="xnj_li_sys">磁盘阵列</span></br>
				容量：<span id="xnj_li_yp"></span></br>
				挂载虚拟机：<span id="xnj_li_busi"></span></br>
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
           <table class="iaas_table" style="border-spacing:0px 10px;border-collapse:separate;"> 
				 <tr> 
					<td width="3%" class="iaas_table_title" style="background:rgb(202,202,202);padding:0px 20px 0px 20px;;border:solid 1px #eee">存储</td>
					<td style="background:rgb(243,243,243);border:solid 1px #eee">
						<table style="text-align:center;border-spacing:10px 40px;border-collapse:separate">
							<tr>
								<td width="20%" class="iaas_table_title">存储标签：</td>
								<td width="80%">
									<!--TAB切换-->
									 <div class="tab_div_cunchu">
									  <div class="tab_div_a_cpu">
										   <ul>
											   <li class="qieh hideclass radius_left" id="c1" ><A class="radius_left" style="width:120px;" href="javascript:void(0);">磁盘阵列</A></li>
											   <li class="hideclass" id="c2"><A class="" href="javascript:void(0);" style="width:120px;">分布式存储</A></li>
											   <li class="hideclass radius_right" id="c3"><A class="radius_right" href="javascript:void(0);" style="width:120px;">本地磁盘</A></li>  
										   </ul> 
									  </div> 
									</div>  
								</td>
							</tr>
							<tr>
								<td width="20%" class="iaas_table_title">容量(G)：</td>
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
								<td width="20%" class="iaas_table_title">选择挂载虚拟机：</td>
								<td width="80%" class="iaas_table_title" style="text-align:left">
									<select id="machineName"  name="machineName" class="form-control" style="width: 64%">
					          			<option ></option>
					          			<c:forEach items="${optionList }" var="optionVo">
					          				<option >${optionVo.userServParamMap.machineName }</option>
					          			</c:forEach>
			          				</select>
								 </td>
							</tr>
						</table> 
					</td>
				</tr> 
		   </table>
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
$(".tab_div_a_cpu li").click(function(){ 
	 var this_text = $(this).text();  
	 appendFactory("xnj_li_sys",this_text,",");
	 
	 $(".tab_div_a_cunchu li").each(function(i){
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
 
 $("#machineName").change(function(){
	 var this_text = $(this).val(); 
	 appendFactory("xnj_li_busi",this_text,""); 
 })
 
 
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
			var max = f.bar.offsetWidth - this.offsetWidth  + 10;
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
