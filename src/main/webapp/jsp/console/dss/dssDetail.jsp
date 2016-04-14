<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
  <head>
<%@ include file="/jsp/common/common.jsp"%>
<script type="text/javascript">    
	var dssController;
	$(document).ready(function(){
		dssController = new $.dssController();
	});	
	var userServId = "${userProdInstVo.userServId}";	
	/*定义页面管理类*/
	(function(){
		$.dssController  = function(){ 
			this.settings = $.extend(true,{},$.dssController.defaults); 
			this.init();
			
		};
		$.extend($.dssController,{
			defaults : { 
						key : "#key",
			     	  SELECT_SUBMIT : "#selectButton",			     	 
			     	  CLEAN_SUBMIT : "#clean_button"
			},
			prototype : {
				init : function(){
					var _this = this;
					_this.addRults();
					_this.bindEvents();				
				},
				bindEvents : function(){
					var _this = this;					
					$(_this.settings.SELECT_SUBMIT).bind("click",function(){
						if ($("#myForm").valid()){	
							var key = $("#key").val();		
							$.ajax({
								async : false,
								type : "POST",
								url : "${_base}/dssConsole/selectDocumentByKey",
								modal : true,
								showBusi : false,
								data : {									
									userServId	: userServId,
									key : key
								},
								success: function(data){
									var json=data
									if(json&&json.resultCode=="000000"){
										$("#doucmentDetail").show();
										$("#doucmentDetail tbody").empty();
										var html = '';
										html += '<tr>';		
											html += '<td class="font_title">文件名称：</td>';
											html += '<td>' + json.documentVo.recordJson.filename + '</td>';
										html += '</tr>';										
										html += '<tr>';		
											html += '<td class="font_title">文件类型：</td>';
											html += '<td>' + json.documentVo.recordJson.contentType + '</td>';
										html += '</tr>';
										html += '<tr>';		
											html += '<td class="font_title">变更时间：</td>';
											html += '<td>' + json.documentVo.recordJson.uploadDate + '</td>';
										html += '</tr>';
									
										html += '<tr>';		
											html += '<td class="font_title">文件描述：</td>';
											html += '<td>' + json.documentVo.recordJson.remark + '</td>';
										html += '</tr>';										
										$("#doucmentDetail tbody").append(html);		
									}else{									
										$("#key_error").text(json.resultMessage);
					                    $(element).css("border-color", "rgb(249, 135, 135)");	
									}
								}
							});
						}							
					});		
					
					$(_this.settings.CLEAN_SUBMIT).bind("click",function(){
						if ($("#myForm").valid()){	
							var key = $("#key").val();		
							$.ajax({
								async : false,
								type : "POST",
								url : "${_base}/dssConsole/clearDocumentByKey",
								modal : true,
								showBusi : false,
								data : {									
									userServId	: userServId,
									key : key
								},
								success: function(data){
									var json=data
									if(json&&json.resultCode=="000000"){
										$("#doucmentDetail").hide();										
										$("#key").val("");
									}else{									
										$("#key_error").text(json.resultMessage);
					                    $(element).css("border-color", "rgb(249, 135, 135)");
									}
								}
							});
						}
							
					});		
				},			
				addRults : function() {				
				    var myForm = $("#myForm");
				    myForm.validate({
		                rules: {
		                	key: {
		                        required: true,
		                        rangelength:[1,128]
		                    }
		                },
		                messages:{
		                	key:{
		                		required:"key不能为空"
		                	}
		                	
		                },
		                success: function (label, element) {
		                    $(element).removeAttr("style");
		                },
		                errorPlacement: function (error, element) {
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
   <%@ include file="/jsp/common/header_console.jsp"%>
      
   <div class="container chanp">
   <%@ include file="/jsp/common/leftMenu_console.jsp"%>
  <div class="row chnap_row">
  
  <div class="col-md-6 right_list">
     <form id="myForm">
     <div class="Open_cache">
        <div class="Open_cache_table">
			<ul>
			<li><a href="#">${userProdInstVo.prodName}</a></li> 
			</ul>  
        </div> 
		<div class="Open_cache_table" style="background:rgb(245,245,245);height:30px;vertical-align:middle ;line-height:30px;padding-left:1%">
			 <span>服务名称：</span>
			 <span style="color:rgb(22,154,219)">${userProdInstVo.serviceName}</span>
			 <span style="margin-left:10px">服务编码：</span>
			 <span style="color:rgb(22,154,219)">${userProdInstVo.userServIpaasId}</span>
		</div> 
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
	          	<div class="Open_cache_list_tow" style="vertical-align:middle;line-height:30px">
					<table>
						<tr><td> <p style="float:left;margin-left:20px;font-size:18px">Key&nbsp;&nbsp;值:</p></td>
						<td>
						<p>	<div class="input-group" style="width:400px;margin-left:10px">
							  <input name="key" id="key" type="text" class="form-control" placeholder="请输入要查询的Key名称">
							  <span class="input-group-btn">
								<button id="selectButton" class="btn btn-default" type="button">查找</button>
							  </span>
							</div>     
						 </p> 
						 </td>
						 <td> 
							<p style="float:left;font-size:18px;color:red;margin-left:10px"><a href="#" title="删除" id="clean_button"><span style="border-radius:16px;background:red;color:#fff;padding:5px 9px">X</span></a></p> 
						</td>
						</tr>
						<tr>						
						<td> </td>
						<td><label style="color:red;" id="key_error"></td>
						</tr>
					</table>	          		
	            
				<div class="Open_cache_list_tow"  style="vertical-align:middle;line-height:30px;padding:30px 0px 0px 100px;">
	          		 <table id="doucmentDetail"  style="display:none">
						<tr>
							<td class='font_title'>文件名称：</td>
							<td>九阴真经</td>
						</tr>
						<tr>
							<td class='font_title'>文件类型：</td>
							<td>pdf</td>
						</tr>
						<tr>
							<td class='font_title'>变更时间：</td>
							<td>2015-04-12</td>
						</tr>
						<tr>
							<td class='font_title' style="text-align:right; vertical-align:top;">文件描述：</td>
							<td style="word-break:break-all; width:400px;">
							  文件描述内容
							</td>
						</tr>
					 </table> 
	           </div>     		
				<div class="Open_cache_list_tow" style="vertical-align:middle;line-height:30px;padding:30px 0px 0px 100px">
	          		   <a href="#" onclick="history.go(-1)"><div style="margin:10px 0px 0px 50px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(230,230,230);line-height:30px;vertical-align:middle;color:#000;font-size:14px;font-weight:800;border:solid 1px rgb(204,204,204)">返回</div></a>
	           </div> 			   
	        </div>  
    	</div>   
     </div> 
 
  </div>
  </form>
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
</script>
  </body>
</html>
