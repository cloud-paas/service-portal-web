<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/jsp/common/common.jsp" %>
    <title>开通配置中心CCS</title>
      <style type="text/css">
		.my-error-class {
			color: #FF0000; /* red */
		}
	</style>
    <script>
        $(document).ready(function () {
    		$("#${list_index}").attr('style', 'margin-top:2px;color:#1699dc');
        	$("#navi_tab_product").addClass("chap");
            $.templates({
                opencmsTmpl: "#opencmsTmpl"

            });

            $.templates.opencmsTmpl.link("#opencms", {})

            var configserverregister = $("#configserverregister");
            
            jQuery.validator.addMethod("regexpName", function(val) {
    			return new RegExp("^[A-Za-z0-9_\u4e00-\u9fa5]+$").test(val);
    		},"请输入合法的服务名称");
            
            jQuery.validator.addMethod("regexpPwd", function(val) {
    			return new RegExp("^[A-Za-z0-9_]+$").test(val);
    		},"只能输入字母数字和下划线");
            
            configserverregister.validate({
            	errorClass: "my-error-class",
                rules: {
                    serviceName: {
                    	regexpName: true,
                        required: true,
                        maxlength: 50,
                    },
                    servicePassword: {
                    	regexpPwd: true,
                    	required: true,
                    	rangelength:[6,16]
                    }
                },
                messages: {
                	serviceName: {
                        required: "请输入服务名称",
                        maxlength: "服务名称最大长度不超过50",
                    },
                    servicePassword: {
                    	required: "请输入服务密码",
                    	rangelength: "密码长度应为{0}~{1}个字符",
                    }
                },
                
                success: function (label, element) {
                    $(element).removeAttr("style");
                    $(label).remove();
                },
                errorPlacement: function (error, element) {
                	$("#"+$(element).attr("id")+"_error").text($(error).text());
                    $(element).css("border-color", "rgb(249, 135, 135)");
                },
                submitHandler: function () {
                    configserverregister.valid();
                }
            });

            $("#registerBtn").click(function () {
                if (configserverregister.valid()) {
                	$('.waitCover').show();
                    $.ajax({
                        type: 'POST',
                        url: '${_base}/ccs/openConfig',
                        dataType: 'json',
                        data: {
                            serviceName: function () {
                                return $("#serviceName").val();
                            },
                            servicePassword: function () {
                                return $("#servicePassword").val();
                            }
                        },
                        success: function (data) {
                            var code = data.code;
                            if ("0000" != code) {
                                $("#errorMessage").text(data.resultMessage);
                                $('.waitCover').hide();
                            } else {
//                                 $.templates({
//                                     opencmsSuccessTmpl: "#opencmsSuccessTmpl"
//                                 });
//                                 $.templates.opencmsSuccessTmpl.link("#opencms", data);
                                location.href=getContextPath() +"/mcs/applyCompleted?prod=CCS";//&url=/ccs/toOpenConfig&prodType=1
                                $('.waitCover').hide();
                            }
                        }
                    });
                } 
            });
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
<!-- 遮盖层 -->
<div class="waitCover">
	<img  src="${_base }/resources/images/waitPng.png" class="waitPng" >
	<div class="waitTxt">正在加载请稍后...</div>
</div>
<!-- 头部和导航条 -->
 <div class="big_k">
<!-- 头部和导航条 -->
<div class="navigation">
		<%@ include file="/jsp/common/header.jsp"%>
	</div>
  <div class="container chanp">
	 	<div class="row chnap_row">
    <%@ include file="/jsp/common/leftMenu_new.jsp"%>
  <div class="col-md-6 right_list">
        <div class="Open_cache">
            <div class="Open_cache_table" id="opencms_tab">
                <ul>
                    <li><a>开通配置中心CCS</a></li>
                </ul>
            </div>
            <div class="Open_cache_list" id="opencms">
            </div>
        </div>
        <script id="opencmsTmpl" type="text/x-jsrender">
            <form id="configserverregister">
				<div class="Open_cache_list">
                    <div class="Open_cache_list_tow">
                        <ul>
                            <li class="lef_zi">产品名称：</li>
                            <li>配置中心CCS</li>
                        </ul>
                        <ul>
                            <li class="lef_zi">服务名称：</li>
                            <li><input name="serviceName" type="text" class="form-control" aria-describedby="sizing-addon2" id="serviceName"/></li>
							<li><label style="color:red;" id="serviceName_error" for="serviceName"></label></li>
                        </ul>
 						<ul>
                            <li class="lef_zi">服务密码：</li>
                            <li><input name="servicePassword" type="text" class="form-control" aria-describedby="sizing-addon2" id="servicePassword"/></li>
							<li><label style="color:red;" id="servicePassword_error" for="servicePassword"></label></li>
                        </ul>
                        <ul>
                            <li class="lef_zi">计算方式：</li>
                            <li>永久期间免费</li>
                        </ul>
                        <ul>
                            <li class="open_btn"><A href="javascript:void(0);" style="margin-top:20px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(121,189,90);line-height:30px;vertical-align:middle;color:#fff" id="registerBtn">立即开通</A></li>
                        </ul>
                    </div>
				</div>
            </form>

        </script>

        <script id="opencmsSuccessTmpl" type="text/x-jsrender">
            <div class="Open_cache">
                <div class="right_biat">
                    <ul>
                        <li class="ocs" style=" font-size:24px;">开通成功</li>
                        <li style=" font-size:16px;">服务号为<span style=" color:#e15009;">{{:data}}</span></li>
                    </ul>
                </div>
            </div>

        </script>
    </div>
</div>
</div>
</div>
<%@ include file="/jsp/common/footer_new.jsp" %>
</body>
</html>
