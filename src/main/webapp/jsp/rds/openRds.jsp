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
            
            jQuery.validator.addMethod("cpuInfoReg", function(val) {
    			return new RegExp("^([1-9][0-9]*)$").test(val);
    		},"申请的CPU数量不能为0或者为非数字");
            
            jQuery.validator.addMethod("createSlaverNumReg", function(val) {
    			return new RegExp("^([0]|([1-9][0-9]*)*)$").test(val);
    		},"申请的从库数量不能为非数字");
            
            jQuery.validator.addMethod("intStorageReg", function(val) {
    			return new RegExp("^([1-9][0-9]*)$").test(val);
    		},"申请的内存大小不能为0或者为非数字");
            
            jQuery.validator.addMethod("netBandwidthReg", function(val) {
    			return new RegExp("^([1-9][0-9]*)$").test(val);
    		},"申请的网络带宽不能为0或者为非数字");
            
            jQuery.validator.addMethod("maxConnectNumReg", function(val) {
    			return new RegExp("^([1-9][0-9]*)$").test(val);
    		},"申请的最大连接不能为0或者为非数字");
            
            jQuery.validator.addMethod("regexpName", function(val) {
    			return new RegExp("^[A-Za-z0-9_\u4e00-\u9fa5]+$").test(val);
    		},"请输入合法的数据");
            
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
                    	regexpPwd: true,
                        required: true,
                        rangelength:[1,128]
                    },
                    incName: {
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
                    cpuInfo: {
                    	cpuInfoReg: true,
                        required: true,
                        rangelength:[1,128]
                    },
                    createSlaverNum: {
                    	createSlaverNumReg: true,
                        required: true,
                        rangelength:[1,128]
                    },
                    intStorage: {
                    	intStorageReg: true,
                        required: true,
                        rangelength:[1,128]
                    },
                    netBandwidth: {
                    	netBandwidthReg: true,
                        required: true,
                        rangelength:[1,128]
                    },
                     whiteList: {
                    	regexpName: false,
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
                	incName:{
                		required:"请输入实例名称",
                		rangelength:"实例名称最大长度不超过50"
                	},
                	incDescribe:{
                		required:"请输入实例描述",
                		rangelength:"实例描述最大长度不超过50"
                	},
                	dbStoreage:{
                		required:"请输入存储大小",
                		rangelength:"存储大小最大长度不超过50"
                	},
                	whiteList:{
                		required:"请输入IP白名单",
                		rangelength:"IP白名单最大长度不超过50"
                	},
                	cpuInfo:{
                		required:"请输入CPU数量",
                		rangelength:"CPU数量最大长度不超过50"
                	},
                	createSlaverNum:{
                		required:"请输入从库数量",
                		rangelength:"从库数量最大长度不超过50"
                	},
                	intStorage:{
                		required:"请输入内存大小",
                		rangelength:"内存大小最大长度不超过50"
                	},
                	netBandwidth:{
                		required:"请输入网络带宽",
                		rangelength:"网络带宽最大长度不超过50"
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
                            whiteList: function () {
                                return $("#whiteList").val();
                            },
                            cpuInfo: function () {
                                return $("#cpuInfo").val();
                            },
                            netBandwidth: function () {
                                return $("#netBandwidth").val();
                            },
                            sqlAudit: function () {
                                return $("#sqlAudit").val();
                            },
                            syncStrategy: function () {
                                return $("#syncStrategy").val();
                            },
                            createSlaverNum: function () {
                                return $("#createSlaverNum").val();
                            },
                            intStorage: function () {
                                return $("#intStorage").val();
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
                            <li class="lef_zi">实例名称：</li>
                            <li><input name="incName" type="text" class="pei_input" id="incName"/></li>
                        </ul>
						<ul>
                            <li class="lef_zi">实例描述：</li>
                            <li><input name="incDescribe" type="text" class="pei_input" id="incDescribe"/></li>
                        </ul>
						<ul>
                            <li class="lef_zi">存储大小：</li>
                            <li><input name="dbStoreage" type="text" class="pei_input" id="dbStoreage"/>GB</li>
                        </ul>
						<ul>
                            <li class="lef_zi">最大连接：</li>
                            <li>
									<input name="maxConnectNum" type="text" class="pei_input" id="maxConnectNum"/>个
									<input name="incType" type="hidden"  id="incType" value="1"/>
									<input name="depId" type="hidden" class="pei_input" id="depId"/>
									<input name="incLocation" type="hidden" class="pei_input" id="incLocation"/>
									<input name="incTag" type="hidden" class="pei_input" id="incTag"/>
							</li>
                        </ul>
						<ul>
                            <li class="lef_zi">IP白名单：</li>
                            <li><input name="whiteList" type="text" class="pei_input" id="whiteList"/>ip逗号分割：192.168.10.11,%.%.%.%</li>
                        </ul>
						<ul>
                            <li class="lef_zi">CPU数量：</li>
                            <li><input name="cpuInfo" type="text" class="pei_input" id="cpuInfo"/>个</li>
                        </ul>
						<ul>
                            <li class="lef_zi">网络带宽：</li>
                            <li><input name="netBandwidth" type="text" class="pei_input" id="netBandwidth"/>MB</li>
                        </ul>
						<ul>
                            <li class="lef_zi">sql审计：</li>
                            <li>
									<select id="sqlAudit" name="sqlAudit"  class="ch_select">
										<option value="off">关闭</option>
										<option value="on">打开</option>
								</select>
							</li>
                        </ul>
						<ul>
                            <li class="lef_zi">同步方式：</li>
                            <li>
								<select id="syncStrategy" name="syncStrategy"  class="ch_select">
										<option value="asynchronous">异步</option>
										<option value="semisynchronous">半同步</option>
								</select>
							</li>
                        </ul>
					    <ul>
                            <li class="lef_zi">从库数量：</li>
                            <li><input name="createSlaverNum" type="text" class="pei_input" id="createSlaverNum"/>个</li>
                        </ul>
					   <ul>
                            <li class="lef_zi">内存大小：</li>
                            <li><input name="intStorage" type="text" class="pei_input" id="intStorage"/>GB</li>
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
