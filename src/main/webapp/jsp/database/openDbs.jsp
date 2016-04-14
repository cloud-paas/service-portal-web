<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/jsp/common/common.jsp" %>
    <title>开通分布式数据库服务</title>
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

            jQuery.validator.addMethod("regexpName", function(val) {
    			return new RegExp("^[A-Za-z0-9_\u4e00-\u9fa5]+$").test(val);
    		},"请输入合法的服务名称");
            
            jQuery.validator.addMethod("regexpPwd", function(val) {
    			return new RegExp("^[A-Za-z0-9_]+$").test(val);
    		},"只能输入字母数字和下划线");
            
            jQuery.validator.addMethod("regexpNum", function(val) {
    			return new RegExp("^([1-9][0-9]*)$").test(val);
    		},"申请的主库数量不能为0");
            
            var configserverregister = $("#configserverregister");
            configserverregister.validate({
            	errorClass: "my-error-class",
                rules: {
                	masterNum: {
                        required: true,
                        digits:true,
                		regexpNum:true,
                    },
                    servicePassword: {
                    	regexpPwd: true,
                    	required: true,
                    	rangelength:[6,16]
                    },
                    my_name: {
                    	regexpName: true,
                        required: true,
                        rangelength:[1,128]
                    }
                },
                messages: {
                	masterNum: {
                		required: "请输入申请的主库数量",
                        digits:"申请的主库数量必须为整数",
                	},
                	servicePassword: {
                    	required: "请输入服务密码",
                    	rangelength: "密码长度应为6~16个字符",
                    },
                    my_name:{
                		required:"请输入服务名称",
                		rangelength:"服务名称最大长度不超过50"
                	}
                },
                success: function (label, element) {
                    $(element).removeAttr("style");
                },
//                 errorPlacement: function (error, element) {
//                     $(element).css("border-color", "rgb(249, 135, 135)");
//                 },
                submitHandler: function () {
                    configserverregister.valid();
                }
            });

            $("#registerBtn").click(function () {
                if (configserverregister.valid()) {
                	$('.waitCover').show();
                    $.ajax({
                        type: 'POST',
                        url: '${_base}/dbs/openDbs',
                        dataType: 'json',
                        data: {
                        	masterNum: function () {
                                return $("#masterNum").val();
                            },
                            needDistributeTrans: function () {
                                return $("#needDistributeTrans").is(':checked');
                            },
                            servicePassword: function () {
                                return $("#servicePassword").val();
                            },
                            my_name: function () {
                                return $("#my_name").val();
                            },
                            isMysqlProxy: function () {
                                return $("#isMysqlProxy").is(':checked');
                            },
                            isAutoSwitch: function () {
                                return $("#isAutoSwitch").is(':checked');
                            },
                        },
                        success: function (data) {
                            var code = data.code;
                            if ("0000" != code) {
                                $("#errorMessage").text(data.resultMessage);
                            } else {
                            	$('.waitCover').hide();
                            	location.href=getContextPath() +"/mcs/applyCompleted?prod=DBS";
                               // location.href=getContextPath() +"${_base}/mcs/applyCompleted?prod=DBS";//&url=/dbs/toOpenDbs&prodType=3

                            }
                        }
                    });
                } 
            });
            var index = 1;
            $("#isMysqlProxy").click(function () {               
                 var isMysqlProxy =  $("#isMysqlProxy").is(':checked');                
                 if(isMysqlProxy){
                	 $("#isAutoSwitch").removeAttr("disabled");   
                	 $("#isAutoSwitchSpan").attr('style', 'color:');
                 }else{
                	 index = 1;
                	 $("#isAutoSwitch").removeAttr("checked");  
                	 $("#isAutoSwitch").attr({"disabled":"disabled"});
                	 $("#isAutoSwitchSpan").attr('style', 'color:#CDC5BF');
                 }
                            
            });
           
            $("#isAutoSwitch").click(function () {
                if(index%2 ==0){
               	 $("#isAutoSwitch").removeAttr("checked"); 
               	index = index+1;
                }else{
                	index = index+1;
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
                    <li><a>开通分布式数据库服务DBS</a></li>
                </ul>
            </div>
            <div class="Open_cache_list" id="opencms">
            </div>
        </div>
        <script id="opencmsTmpl" type="text/x-jsrender">
            <form id="configserverregister">

                    <div class="Open_cache_list_tow">
                        <ul>
                            <li class="lef_zi">产品名称：</li>
                            <li>分布式数据库服务DBS</li>
                        </ul>
					<ul>
			          <li class="lef_zi">服务名称：</li>
			          <li><input id="my_name" name="my_name" type="text"  class="pei_input"></li>
		          	</ul>
                        <ul>
                            <li class="lef_zi">主库数量：</li>
                            <li><input name="masterNum" id="masterNum" type="text" class="pei_input" id="masterNum"/></li>
							
                        </ul>
 						<ul>
                            <li class="lef_zi">服务密码：</li>
                            <li><input name="servicePassword" type="text" class="pei_input" id="servicePassword"/></li>
                        </ul>
						<ul style="margin-top:10px;">							
                            <li class="lef_zi" ><input name="needDistributeTrans" type="checkbox" id="needDistributeTrans" style="background-color:#1699dc;" ></li>
							<li >开启分布式事务</li>
                        </ul>
						<ul style="margin-top:10px">							
                            <li class="lef_zi"><input name="isMysqlProxy" type="checkbox" id="isMysqlProxy" ></li>
							<li >是否读写分离</li>
                        </ul>
						<ul style="margin-top:10px;margin-left:180px;width:450px;">							
                            <li class="lef_zi" style="margin-top:2px;width:10px;"><input name="isAutoSwitch" type="radio" id="isAutoSwitch" disabled="disabled"></li>
							<li ><span id="isAutoSwitchSpan" style="color:#CDC5BF">是否主从自动切换（风险点：故障时有n秒钟数据存在丢失风险）</span></li>
                        </ul>
                        <ul>
                            <li class="open_btn"><A href="javascript:void(0);" id="registerBtn">立即开通</A></li>
                        </ul>
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
<%@ include file="/jsp/common/footer.jsp" %>
</body>
</html>
