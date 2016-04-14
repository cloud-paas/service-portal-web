<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<title>开通实时计算RCS</title>
<script>
	var openRCSController;
	$(document).ready(function() {
		$("#${list_index}").attr('style', 'margin-top:2px;color:#1699dc');
		$("#navi_tab_product").addClass("chap");
		openRCSController = new $.OpenRCSController();
	});
	
	/*定义页面管理类*/
	(function() {
		$.OpenRCSController = function() {
			this.settings = $.extend(true, {}, $.OpenRCSController.defaults);
			this.init();
		};
		
		jQuery.validator.addMethod("regexp", function(val) {
			return new RegExp("^[A-Za-z0-9_]+$").test(val);
		},"只能输入字母数字和下划线");
		
		$.extend($.OpenRCSController,{
							defaults : {
								USER_SERV_IPAAS_PWD : "#userServIpaasPwd",
								SUBMIT_ID : "#my_submit"
							},
							prototype : {
								init : function() {
									var _this = this;
									_this.addRults();
									_this.bindEvents();
								},
								bindEvents : function() {
									var _this = this;
									$(_this.settings.SUBMIT_ID).bind("click", function() {
										if ($("#myForm").valid()){
														var rcsSelect = $("#rcsSelect").val();
														var userServIpaasPwd = $(_this.settings.USER_SERV_IPAAS_PWD).val();
														$('.waitCover').show();
														$.ajax({async : true,
																	type : "POST",
																	url : "${_base}/rcs/add",
																	modal : true,
																	showBusi : false,
																	data : {
																		rcsSelect : rcsSelect,
																		userServIpaasPwd : userServIpaasPwd
																	},
																	success : function(data) {
																		var json = data;
																		
																		if (json&& json.resultCode =="0000") {
																			location.href = getContextPath() +"/mcs/applyCompleted?prod=RCS&url=/rcs/toOrder&prodType=2";
																			$('.waitCover').hide();
																		} else {
																			alert(json.resultMessage);
																			$('.waitCover').hide();
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
						                	userServIpaasPwd: {
						                		regexp: true,
						                    	required: true,
						                    	rangelength:[6,16]
						                    }
						                },
						                messages:{
						                	userServIpaasPwd:{
						                		required:"请输入服务密码",
						                		rangelength:"密码长度应为6~16个字符"
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
   <!-- 遮盖层 -->
   <div class="waitCover">
		<img  src="${_base }/resources/images/waitPng.png" class="waitPng" >
		<div class="waitTxt">正在加载请稍后...</div>
   </div>
   <div class="big_k"><!--包含头部 主体-->  
   <!--导航-->
   <div class="navigation">
		<%@ include file="/jsp/common/header.jsp"%>
	</div>
  <div class="container chanp">
	 	<div class="row chnap_row">
    <%@ include file="/jsp/common/leftMenu_new.jsp"%>
  <div class="col-md-6 right_list">
			<form id="myForm">
					<div class="Open_cache">
						<div class="Open_cache_table">
							<ul>
								<li><a>开通实时计算RCS</a></li>
							</ul>
						</div>
						<div class="Open_cache_list">
							<div class="Open_cache_list_tow">
							<ul>
											<li class="font-title" style="margin-left:14px">产品名称：</li>
											  <li class="font-title" >实时计算RCS</li> 
										</ul>
								<ul>
									<li class="font-title">请选择类型：</li>
									<li><select id="rcsSelect" class="form-control" name="rcsSelect">
											<c:forEach var="v" items="${list}" varStatus="vs">
												<option value="${v.serviceValue }" <c:if test="${v.serviceValue eq '1'}"> selected</c:if>>${v.serviceOption}</option>
											</c:forEach>
									</select></li>
									</ul>
										<ul>
											<li class="font-title" style="margin-left:14px">服务密码：</li>
											<li><input id="userServIpaasPwd" name="userServIpaasPwd" type="text" class="form-control" aria-describedby="sizing-addon2" /></li>
											<li><label style="color:red;" id="userServIpaasPwd_error"></label></li>
										</ul>
										<ul  style="padding-left:10%">
						          		<li  >
						          			<a id="my_submit" href="#"><div style="margin-top:20px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(121,189,90);line-height:30px;vertical-align:middle;color:#fff">立即开通</div></a>
						          		</li>
							          	</ul>
							</div>
						</div>
					</div>
		    	</form>
				</div>
			</div>
		</div>
	</div>
	
	<%@ include file="/jsp/common/footer_new.jsp"%>
</body>
</html>
