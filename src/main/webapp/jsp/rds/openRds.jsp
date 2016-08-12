<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/jsp/common/common.jsp" %>
    <title>云数据库服务</title>
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

            jQuery.validator.addMethod("rootNameReg", function(val) {
            	var booleanVal =true;
            	if(val=='root' || val=='ROOT'){
            		 booleanVal = false;
            	}
    			return booleanVal;
    		},"超级权限账户不能为默认的root");
            
            jQuery.validator.addMethod("regexpPwd", function(val) {
    			return new RegExp("^[A-Za-z0-9_]+$").test(val);
    		},"只能输入字母数字和下划线");
            
            jQuery.validator.addMethod("dbStoreageReg", function(val) {
    			return new RegExp("^([1-9][0-9]*)$").test(val);
    		},"申请的存储大小不能为0或者为非数字");
            
            jQuery.validator.addMethod("maxConnectNumReg", function(val) {
    			return new RegExp("^([1-9][0-9]*)$").test(val);
    		},"申请的最大连接不能为0或者为非数字");
            
            var configserverregister = $("#configserverregister");
            configserverregister.validate({
            	errorClass: "my-error-class",
                rules: {
                	rootName: {
                		rootNameReg: true,
                        required: true,
                        rangelength:[1,128]
                    },
                    rootPassword: {
                    	regexpName: true,
                        required: true,
                        rangelength:[1,128]
                    },
                    depId: {
                    	regexpName: true,
                        required: true,
                        rangelength:[1,128]
                    },
                    incName: {
                    	regexpName: true,
                        required: true,
                        rangelength:[1,128]
                    },
                    incTag: {
                    	regexpName: true,
                        required: true,
                        rangelength:[1,128]
                    },
                    incLocation: {
                    	regexpName: true,
                        required: true,
                        rangelength:[1,128]
                    },
                    incDescribe: {
                    	regexpName: true,
                        required: true,
                        rangelength:[1,128]
                    },
                    dbStoreage: {
                    	dbStoreageReg: true,
                        required: true,
                        rangelength:[1,128]
                    },
                    maxConnectNum: {
                    	maxConnectNumReg: true,
                        required: true,
                        rangelength:[1,128]
                    },
                },
                messages: {
                	rootName:{
                		required:"请输入高级权限账号",
                		rangelength:"高级权限账号最大长度不超过50"
                	},
                	rootPassword:{
                		required:"请输入高级权限密码",
                		rangelength:"高级权限密码就最大长度不超过50"
                	},
                	depId:{
                		required:"请输入部门名称",
                		rangelength:"部门名称最大长度不超过50"
                	},
                	incName:{
                		required:"请输入实例名称",
                		rangelength:"实例名称最大长度不超过50"
                	},
                	incTag:{
                		required:"请输入实例标签",
                		rangelength:"实例标签最大长度不超过50"
                	},
                	incLocation:{
                		required:"请输入实例位置",
                		rangelength:"实例位置最大长度不超过50"
                	},
                	incDescribe:{
                		required:"请输入实例描述",
                		rangelength:"实例描述最大长度不超过50"
                	},
                	dbStoreage:{
                		required:"请输入存储大小",
                		rangelength:"存储大小最大长度不超过50"
                	},
                	maxConnectNum:{
                		required:"请输入最大连接",
                		rangelength:"最大连接最大长度不超过50"
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
                        url: '${_base}/rds/openRds',
                        dataType: 'json',
                        data: {
                        	rootName: function () {
                                 return $("#rootName").val();
                             },
                             rootPassword: function () {
                                 return $("#rootPassword").val();
                             },
                            depId: function () {
                                return $("#depId").val();
                            },
                            incName: function () {
                                return $("#incName").val();
                            },
                            incTag: function () {
                                return $("#incTag").val();
                            },
                            incLocation: function () {
                                return $("#incLocation").val();
                            },
                            incDescribe: function () {
                                return $("#incDescribe").val();
                            },
                            dbStoreage: function () {
                                return $("#dbStoreage").val();
                            },
                            maxConnectNum: function () {
                                return $("#maxConnectNum").val();
                            },
                            incType: function () {
                                return $("#incType").val();
                            },
                        },
                        success: function (data) {
                            var code = data.code;
                            if ("0000" != code) {
                                $("#errorMessage").text(data.resultMessage);
                            } else {
                            	$('.waitCover').hide();
                            	location.href=getContextPath() +"/mcs/applyCompleted?prod=RDS";
                               // location.href=getContextPath() +"${_base}/mcs/applyCompleted?prod=DBS";//&url=/dbs/toOpenDbs&prodType=3

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
                    <li><a>云数据库服务RDS</a></li>
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
                            <li>云数据库服务RDS</li>
                        </ul>

						<ul>
                            <li class="lef_zi">高级权限账号：</li>
                            <li><input name="rootName" type="text" class="pei_input" id="rootName"/></li>
                        </ul>
						<ul>
                            <li class="lef_zi">高级权限密码：</li>
                            <li><input name="rootPassword" type="text" class="pei_input" id="rootPassword"/></li>
                        </ul>
						<ul>
                            <li class="lef_zi">部门名称：</li>
                            <li><input name="depId" type="text" class="pei_input" id="depId"/></li>
                        </ul>
						<ul>
                            <li class="lef_zi">实例名称：</li>
                            <li><input name="incName" type="text" class="pei_input" id="incName"/></li>
                        </ul>
						<ul>
                            <li class="lef_zi">实例标签：</li>
                            <li><input name="incTag" type="text" class="pei_input" id="incTag"/></li>
                        </ul>
						<ul>
                            <li class="lef_zi">实例位置：</li>
                            <li><input name="incLocation" type="text" class="pei_input" id="incLocation"/></li>
                        </ul>
						<ul>
                            <li class="lef_zi">实例描述：</li>
                            <li><input name="incDescribe" type="text" class="pei_input" id="incDescribe"/></li>
                        </ul>
						<ul>
                            <li class="lef_zi">存储大小：</li>
                            <li><input name="dbStoreage" type="text" class="pei_input" id="dbStoreage"/></li>
                        </ul>
						<ul>
                            <li class="lef_zi">最大连接：</li>
                            <li>
									<input name="maxConnectNum" type="text" class="pei_input" id="maxConnectNum"/>
									<input name="incType" type="hidden"  id="incType" value="1"/>
							</li>
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
