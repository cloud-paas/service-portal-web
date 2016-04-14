<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/storm/common/jsp/html_meta.jsp"%>
<title>编辑计算任务</title>
<%@ include file="/jsp/storm/common/jsp/html_js.jsp"%>
<style>
</style>
<script type="text/javascript">
	$(function() {
		/* var url = "${_base}/storm/demo/add";
		var param = "";
		ajaxSubmit_my(url, param, "成功", "", "") */
		//初始化编辑页面数据
		var url="${_base}/storm/task/toEditTask";
		//绑定按钮事件开始
		$("#btn_spout_add").bind("click",function(){
			var rowStr = "<tr align=\"center\" valign=\"middle\">"
                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutName\" name=\"spoutName\"  value=\"\"></td>"
                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutClassName\" name=\"spoutClassName\"  value=\"\"></td>"
                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutThreads\" name=\"spoutThreads\"  value=\"\"></td>"
                +"<td><button type=\"button\" class=\"btn btn-info btn-sm\" onclick=\"del_tr(this)\">删除</button></td>"
                +"</tr>";
            $("#tbody_spout").append(rowStr);
		});
		$("#btn_bolt_add").bind("click",function(){
			var rowStr = "<tr align=\"center\" valign=\"middle\">"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"boltName\" name=\"boltName\"  value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"boltClassName\" name=\"boltClassName\"  value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"threads\" name=\"threads\"  value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"groupingTypes\" name=\"groupingTypes\"  value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"groupingSpoutOrBlots\" name=\"groupingSpoutOrBlots\"  value=\"\"></td>"
				+"<td><button type=\"button\" class=\"btn btn-info btn-sm\" onclick=\"del_tr(this)\">删除</button></td>"
				+"</tr>";
            $("#tbody_bolt").append(rowStr);
		});
	});
	//
	function del_tr(t){
		$(t).parent().parent().remove();
	}
	function init(id){
		
		
	}
	
</script>
</head>
<body>
	<div class="big_k">
		<!--包含头部 主体-->
		<jsp:include page="/jsp/common/header.jsp"></jsp:include>
		<div class="container chanp"><div class="row"> <div class="navigation"> <%@ include file="/jsp/common/header.jsp"%></div>
			<div class="row chnap_row">
				<%@ include file="/jsp/common/leftMenu.jsp"%>
				<div class="col-md-6 right_list">
					<div class="Open_cache">
						<div class="Open_cache_table">
							<ul>
								<li><a href="${_base }/storm/task/toEditTask">计算任务编辑</a>
								</li>
							</ul>
						</div>
						<!--我的服务-->
						<form role="form" id="my_form">
							<div class="bad_main">
								<ul>
									<li class="jis">计算任务名称：</li>
									<li><input id="name" name="name"
										value="${stormTaskInfo.name}" type="text" class="jzc_input"
										maxlength="50" readonly="readonly" ></li>
								</ul>
								<ul>
									<li class="jis">Work数量：</li>
									<li><input id="numWorkers" name="numWorkers"
										value="${stormTaskInfo.numWorkers}" type="text"
										class="jzc_input"></li>
								</ul>
								<ul>
									<li class="jis">集群标识：</li>
									<li><select class="jzc_input" id="clusterId"
										name="clusterId">
											<option value="1">信控集群</option>
									</select></li>
								</ul>
								<ul>
									<li class="jis">Spout配置：</li>
									<li><a href="javascript:void(0)" id="btn_spout_add"> <input
											name="" type="button" class="js_button" value="增加">
									</a></li>
								</ul>
								<ul>
									<li class="jis">任务说明：</li>
									<li><textarea id="comments" name="comments"
											class="jzc_input_c">${stormTaskInfo.comments}</textarea></li>
								</ul>
								<ul>
									<li class="zj_table">
										<table width="100%" border="0">
											<tr align="center" valign="middle">
												<td>Spout名称</td>
												<td>Spout类名</td>
												<td>线程数量</td>
												<td>操作</td>
											</tr>
											<tbody id="tbody_spout">
												<c:forEach var="v" items="${taskSpoutResult}" varStatus="vs">
													<tr align="center" valign="middle">
														<td><input type="text" class="jis_ps" id="spoutName"
															name="spoutName" value="${v.spoutName}"></td>
														<td><input type="text" class="jis_ps"
															id="spoutClassName" name="spoutClassName"
															value="${v.spoutClassName}"></td>
														<td><input type="text" class="jis_ps"
															id="spoutThreads" name="spoutThreads"
															value="${v.threads}"></td>
														<td>
															<button type="button" class="btn btn-info btn-sm"
																onclick="del_tr(this)">删除</button>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</li>
								</ul>
								<ul>
									<li class="jis">Bolt配置：</li>
									<li><a href="javascript:void(0)" id="btn_bolt_add"> <input
											name="" type="button" class="js_button" value="增加">
									</a></li>
								</ul>
								<ul class="c_tb">
									<li class="zj_table">
										<table width="100%" border="0">
											<tr align="center" valign="middle">
												<td width="20%">Bolt名称</td>
												<td>Bolt类名</td>
												<td width="20%">线程数量</td>
												<td>grouping类型</td>
												<td>grouping源头</td>
												<td width="10%">操作</td>
											</tr>
											<tbody id="tbody_bolt">
												<c:forEach var="v1" items="${taskBoltResult}"
													varStatus="vs1">
													<tr align="center" valign="middle">
														<td><input type="text" class="jis_ps" id="boltName"
															name="boltName" value="${v1.boltName}"></td>
														<td><input type="text" class="jis_ps"
															id="boltClassName" name="boltClassName"
															value="${v1.boltClassName}"></td>
														<td><input type="text" class="jis_ps" id="threads"
															name="threads" value="${v1.threads}"></td>
														<td><input type="text" class="jis_ps"
															id="groupingTypes" name="groupingTypes"
															value="${v1.groupingTypes}"></td>
														<td><input type="text" class="jis_ps"
															id="groupingSpoutOrBlots" name="groupingSpoutOrBlots"
															value="${v1.groupingSpoutOrBlots}"></td>
														<td>
															<button type="button" class="btn btn-info btn-sm"
																onclick="del_tr(this)">删除</button>
														</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</li>
								</ul>
							</div>
						</form>
						<div class="shi_jbun">
							<form id='myForm' enctype='multipart/form-data'
								class="form-horizontal">
								<ul style="width: 500px;">
									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<label for="mainTitle" class="col-sm-2 control-label">
													<span style="color: red;">*</span> storm jar包：
												</label>
												<div class="col-sm-10">
													<input type="file" class="form-control" id="insertFile"
														name="insertFile" value="${stormTaskInfo.jarFilePath}" />
												</div>
											</div>
										</div>
									</div>
								</ul>
								<ul>
									<li>
										<button type="submit" class="btn btn-primary"
											id="insertFile_btn" style="">编辑计算任务</button>
										<button type="reset" class="btn" id="cz_button">重置</button>
									</li>
								</ul>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--底部-->
	<jsp:include page="/jsp/common/footer.jsp"></jsp:include>
	<script src="${_base }/resources/js/storm/jquery.form.js"></script>
	<script type="text/javascript">
    $(function(){
        $("#insertFile_btn").bind("click", function() {
            var _this = this;
            //
            $(_this).addClass("disabled");
            
            var name = $.trim($("#name").val());
            if (name === "") {
                $.dialog.alert("请输入计算任务名称",function(){
                 $(_this).removeClass("disabled");
               });
                return false;
            }
            
            var numWorkers = $.trim($("#numWorkers").val());
            var r = /^\+?[1-9][0-9]*$/;　　//正整数
            if (numWorkers === "") {
                $.dialog.alert("请输入work数量",function(){
                 $(_this).removeClass("disabled");
               	});
                return false;
            }else if(!r.test(numWorkers)){
            	$.dialog.alert("work数量必须为数字",function(){
                	$(_this).removeClass("disabled");
              	});
                return false;
            }
            
            var spoutConfig = "";
            var spoutNames = "";
            $("input[name='spoutName']").each(function(i,d){
            	if($.trim($(d).val()) == ""){
            		spoutConfig = "spout名称存在空值，请重新配置";
            		$(d).focus();
            		return false;
            	}else{
            		spoutNames = spoutNames+$.trim($(d).val())+",";
            	}	
            });
            if(spoutConfig != ""){
            	$.dialog.alert(spoutConfig,function(){
                	$(_this).removeClass("disabled");
              	});
                return false;
            }
            $("input[name='spoutClassName']").each(function(i,d){
            	if($.trim($(d).val()) == ""){
            		spoutConfig = "spout类名存在空值，请重新配置";
            		$(d).focus();
            		return false;
            	}	
            });
            if(spoutConfig != ""){
            	$.dialog.alert(spoutConfig,function(){
                	$(_this).removeClass("disabled");
              	});
                return false;
            }
            $("input[name='spoutThreads']").each(function(i,d){
            	if($.trim($(d).val()) == "" || !r.test($.trim($(d).val()))){
            		spoutConfig = "spout线程数量存在空值或不为整数，请重新配置";
            		$(d).focus();
            		return false;
            	}	
            });
            if(spoutConfig != ""){
            	$.dialog.alert(spoutConfig,function(){
                	$(_this).removeClass("disabled");
              	});
                return false;
            }
            
            var boltConfig = "";
            var boltNames = "";
            $("input[name='boltName']").each(function(i,d){
            	if($.trim($(d).val()) == ""){
            		boltConfig = "bolt名称存在空值，请重新配置";
            		$(d).focus();
            		return false;
            	}else{
            		boltNames = boltNames+$.trim($(d).val())+",";
            	}		
            });
            if(boltConfig != ""){
            	$.dialog.alert(boltConfig,function(){
                	$(_this).removeClass("disabled");
              	});
                return false;
            }
            $("input[name='boltClassName']").each(function(i,d){
            	if($.trim($(d).val()) == ""){
            		boltConfig = "bolt类名存在空值，请重新配置";
            		$(d).focus();
            		return false;
            	}	
            });
            if(boltConfig != ""){
            	$.dialog.alert(boltConfig,function(){
                	$(_this).removeClass("disabled");
              	});
                return false;
            }
            $("input[name='threads']").each(function(i,d){
            	if($.trim($(d).val()) == "" || !r.test($.trim($(d).val()))){
            		boltConfig = "bolt线程数量存在空值或不为整数，请重新配置";
            		$(d).focus();
            		return false;
            	}	
            });
            if(boltConfig != ""){
            	$.dialog.alert(boltConfig,function(){
                	$(_this).removeClass("disabled");
              	});
                return false;
            }
            $("input[name='groupingTypes']").each(function(i,d){
            	if($.trim($(d).val()) == ""){
            		boltConfig = "grouping类型存在空值，请重新配置";
            		$(d).focus();
            		return false;
            	}	
            });
            if(boltConfig != ""){
            	$.dialog.alert(boltConfig,function(){
                	$(_this).removeClass("disabled");
              	});
                return false;
            }
            $("input[name='groupingSpoutOrBlots']").each(function(i,d){
            	if($.trim($(d).val()) == ""){
            		boltConfig = "grouping源头存在空值，请重新配置";
            		$(d).focus();
            		return false;
            	}else{
            		var groupingSpoutOrBlotsValue = $.trim($(d).val());
            		var groupingSpoutOrBlotsArray = groupingSpoutOrBlotsValue.split(",");
            		$.each(groupingSpoutOrBlotsArray,function(i,d){
            			if(spoutNames.indexOf(d)==-1&&boltNames.indexOf(d)==-1){
            				boltConfig = "grouping源头有不存在的spout或bolt，请重新配置";
                    		$(d).focus();
                    		return false;
            			}
            		});
            	}	
            });
            if(boltConfig != ""){
            	$.dialog.alert(boltConfig,function(){
                	$(_this).removeClass("disabled");
              	});
                return false;
            }
            
            var imgFile = $.trim($("#insertFile").val());
            if (imgFile === "") {
                $.dialog.alert("请选择jar文件",function(){
                $(_this).removeClass("disabled");
               });
                return false;
            }
            
            var url="${_base}/storm/uploadFile/uploadJar";
            var param="";
            //
            _$_param = $("#my_form").serialize();
            //alert(_$_param);
            //
            $("#myForm").submit(function () {
            	/*
               var id = "&id="+"${stormTaskInfo.id}"+"&";
               url="${_base}/storm/task/editTask";
               param="&jarFilePath='6666'&";
               param+=_$_param;
               param+=id;
               alert(param);
               ajaxSubmit_my(url,param,"编辑计算任务成功喽~","${_base}/storm/task/toEditTask","insertFile_btn");
               */

                $("#myForm").ajaxSubmit({
                    type: "post",
                    url: url+"?mainFolderKey=UPLOAD_FILE_PATH_CONTENT_INDEX_IMG&"+param,
                    success: function (data) {
                        var jsonData=$.parseJSON(data);
                        if(jsonData.error == "1"){
                            $.dialog.alert(jsonData.message,function(){
                                 $(_this).removeClass("disabled");
                            });
                            return false;
                        }
                        url="${_base}/storm/task/editTask";
                        param="&jarFilePath="+jsonData.fk+"&";
                        param+=_$_param;
                        //alert("1:"+param);
                        var id = "&id="+"${stormTaskInfo.id}"+"&";
                        //param="&jarFilePath='6666'&";
                        param+=id;
                        //alert("2:"+param);
                        ajaxSubmit_my(url,param,"编辑计算任务成功喽~","${_base}/storm/task/toEditTask","insertFile_btn");
                        //location.href="${_base}/storm/task/toEditTask?id="+"${stormTaskInfo.id}";
                        //location.href="${_base}/storm/task/toList";
                        $.dialog.tips('编辑计算任务成功喽~~正在跳转...',2, 'loading.gif',function(){
							location.href="${_base}/storm/task/toList";
						});
                    },
                    error: function (msg) {
                        $.dialog.alert("上传jar失败",function(){
                             $(_this).removeClass("disabled");
                        });
                    }
                });
                return false;
                
            });
        });
    });
    </script>
</body>
</html>
