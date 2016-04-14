<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ include file="/jsp/storm/common/jsp/html_meta.jsp"%>
<title>注册计算任务</title>
<%@ include file="/jsp/storm/common/jsp/html_js.jsp"%>
<style>
</style>
<script type="text/javascript" src="/js/common/storm/jquery.form.js"></script>
<script type="text/javascript">
	$(function() {
    	//验证是哪个submit
    	var btnid="";
    	$(":submit").click(function(e){if(this.id) btnid=this.id;})
		//绑定按钮事件开始
          var url = "";
		  $("#myForm").submit(function (){	
		      var param="";
		      _$_param = $("#my_form").serialize();
		      /** 点击展示按钮的逻辑 **/
	          if(btnid=="show_related"){
	        	var _this = this;
	            url = "${_base}/rcs/showRelatedParam";
	            var file = $("#insertFile").val();
	            /** 判断是否选择里jar包，如果没有选择，不能够展示。**/
	            if ($.trim($("#insertFile").val()) === "") {
	                $.dialog.alert("请先选取jar文件",function(){
		                 $(_this).removeClass("disabled");
		            });
	                return false;
	            }
	            
	            /** 判断文件格式是否为jar**/
	            else if(!/.jar$/.test(file)){
	            	$.dialog.alert("文件格式错误，请重新上传jar格式文件");
	            	return false;
	            }
	            
                $("#myForm").ajaxSubmit({
                    type: "post",
                    url: url+"?"+"myFile="+$("#insertFile").val(),
                    success: function (data) {
                       var jsonData=$.parseJSON(data);
                       var name = jsonData.name; 
                       var workNum = jsonData.workNum;
                       var comments = jsonData.comments;
                       var lSpout = jsonData.lSpout;
                       var lBolt = jsonData.lBolt;
                       //alert(lBolt);
                       $("#name").val(name);
                       $("#numWorkers").val(workNum);
                       $("#comments").val(comments);
                       $("#tbody_spout").html("");
                       $("#tbody_bolt").html("");
  				       $.each(lSpout,function(i,item){
  				    	 var rowStr = "<tr align=\"center\" valign=\"middle\">"
				                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutName\" name=\"spoutName\"  value="+item.spoutName+" style=\"background-color:#eee\" readonly></td>"
				                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutClassName\" name=\"spoutClassName\"  value="+item.spoutClassName+" style=\"background-color:#eee\" readonly></td>"
				                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutThreads\" name=\"spoutThreads\"  value="+item.threads+"><span style=\"color: red;\">*</span></td>"
				                +"</tr>";
  							/* var rowStr = "<tr align=\"center\" valign=\"middle\">"
  				                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutName\" name=\"spoutName\"  value="+item.spoutName+"></td>"
  				                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutClassName\" name=\"spoutClassName\"  value="+item.spoutClassName+"></td>"
  				                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutThreads\" name=\"spoutThreads\"  value="+item.threads+"><span style=\"color: red;\">*</span></td>"
  				                +"<td><button type=\"button\" class=\"btn btn-info btn-sm\" onclick=\"del_tr(this)\">删除</button></td>"
  				                +"</tr>"; */
  				            $("#tbody_spout").append(rowStr);
 				     });
  				       $.each(lBolt,function(i,item){
  				    	 var rowStr = "<tr align=\"center\" valign=\"middle\">"
								+"<td> <input type=\"text\" class=\"jis_ps\" id=\"boltName\" name=\"boltName\"  value="+item.boltName+" style=\"background-color:#eee\" readonly></td>"
								+"<td> <input type=\"text\" class=\"jis_ps\" id=\"boltClassName\" name=\"boltClassName\"  value="+item.boltClassName+" style=\"background-color:#eee\" readonly></td>"
								+"<td> <input type=\"text\" class=\"jis_ps\" id=\"threads\" name=\"threads\"  value="+item.threads+"><span style=\"color: red;\">*</span></td>"
								+"<td> <input type=\"text\" class=\"jis_ps\" id=\"groupingTypes\" name=\"groupingTypes\"  value="+item.groupingTypes+" style=\"background-color:#eee\" readonly></td>"
								+"<td> <input type=\"text\" class=\"jis_ps\" id=\"groupingSpoutOrBlots\" name=\"groupingSpoutOrBlots\"  value="+item.previousId+" style=\"background-color:#eee\" readonly></td>"
								+"</tr>";
  							/* var rowStr = "<tr align=\"center\" valign=\"middle\">"
  								+"<td> <input type=\"text\" class=\"jis_ps\" id=\"boltName\" name=\"boltName\"  value="+item.boltName+"></td>"
  								+"<td> <input type=\"text\" class=\"jis_ps\" id=\"boltClassName\" name=\"boltClassName\"  value="+item.boltClassName+"></td>"
  								+"<td> <input type=\"text\" class=\"jis_ps\" id=\"threads\" name=\"threads\"  value="+item.threads+"><span style=\"color: red;\">*</span></td>"
  								+"<td> <input type=\"text\" class=\"jis_ps\" id=\"groupingTypes\" name=\"groupingTypes\"  value="+item.groupingTypes+"></td>"
  								+"<td> <input type=\"text\" class=\"jis_ps\" id=\"groupingSpoutOrBlots\" name=\"groupingSpoutOrBlots\"  value="+item.previousId+"></td>"
  								+"<td><button type=\"button\" class=\"btn btn-info btn-sm\" onclick=\"del_tr(this)\">删除</button></td>"
  								+"</tr>"; */
  				            $("#tbody_bolt").append(rowStr);
				     });
                       },
                    error: function (msg) {
                      alert("文件展示异常");
                    }
                });}else if(btnid=="insertFile_btn"){
                	url = "${_base}/rcs/uploadFile/uploadJars"; 
                	$("#myForm").ajaxSubmit({
                        type: "post",
                        url: url+"?"+"myFile="+$("#insertFile").val(),
                        success: function (data) {
                            var jsonData=$.parseJSON(data);
                        	//alert(jsonData.fk);
                            if(jsonData.error == "1"){
                            	if(jsonData.errorType=="1"){
                                $.dialog.alert("jar文件大小不能超过10MB");}
                            	else if(jsonData.errorType=="2"){
                                    $.dialog.alert("jar文件格式校验失败，请检查jar文件格式");}
                            	else if(jsonData.errorType=="3"){
                                    $.dialog.alert("上传jar文件内容为空");}
                            	else if(jsonData.errorType=="4"){
                                    $.dialog.alert("系统错误");}
                                return false;
                            }
                            url="${_base}/rcs/registerTask";
                            param="&jarFilePath="+jsonData.fk+"&";
                            param+=_$_param;
                            //alert(param);
                            ajaxSubmit_my(url,param,"注册计算任务成功喽~","${_base}/rcs/toList","insertFile_btn");
                          //  $.post(url,param,function(data){                        	
                         //   	alert("注册成功");
                        //    location.href="${_base}/rcs/toList";});
                        },
                        error: function (msg) {
                            $.dialog.alert("上传jar失败",function(){
                                 $(_this).removeClass("disabled");
                            });
                        }
                    });
                }
	          
                return false;
            });
		
		$("#btn_spout_add").bind("click",function(){
			var rowStr = "<tr align=\"center\" valign=\"middle\">"
                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutName\" name=\"spoutName\"  value=\"\"></td>"
                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutClassName\" name=\"spoutClassName\"  value=\"\"></td>"
                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutThreads\" name=\"spoutThreads\"  value=\"\"><span style=\"color: red;\">*</span></td>"
                +"</tr>";
			/* var rowStr = "<tr align=\"center\" valign=\"middle\">"
                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutName\" name=\"spoutName\"  value=\"\"></td>"
                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutClassName\" name=\"spoutClassName\"  value=\"\"></td>"
                +"<td> <input type=\"text\" class=\"jis_ps\" id=\"spoutThreads\" name=\"spoutThreads\"  value=\"\"><span style=\"color: red;\">*</span></td>"
                +"<td><button type=\"button\" class=\"btn btn-info btn-sm\" onclick=\"del_tr(this)\">删除</button></td>"
                +"</tr>"; */
            $("#tbody_spout").append(rowStr);
		});
		
		$("#btn_bolt_add").bind("click",function(){
			var rowStr = "<tr align=\"center\" valign=\"middle\">"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"boltName\" name=\"boltName\"  value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"boltClassName\" name=\"boltClassName\"  value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"threads\" name=\"threads\"  value=\"\"><span style=\"color: red;\">*</span></td>"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"groupingTypes\" name=\"groupingTypes\"  value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"groupingSpoutOrBlots\" name=\"groupingSpoutOrBlots\"  value=\"\"></td>"
				+"</tr>";
			/* var rowStr = "<tr align=\"center\" valign=\"middle\">"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"boltName\" name=\"boltName\"  value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"boltClassName\" name=\"boltClassName\"  value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"threads\" name=\"threads\"  value=\"\"><span style=\"color: red;\">*</span></td>"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"groupingTypes\" name=\"groupingTypes\"  value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"jis_ps\" id=\"groupingSpoutOrBlots\" name=\"groupingSpoutOrBlots\"  value=\"\"></td>"
				+"<td><button type=\"button\" class=\"btn btn-info btn-sm\" onclick=\"del_tr(this)\">删除</button></td>"
				+"</tr>"; */
            $("#tbody_bolt").append(rowStr);
		});
	});
	
	function del_tr(t){
		$(t).parent().parent().remove();
	}
</script>
</head>
<body>
	<div class="big_k">
		<!--包含头部 主体-->

		<div class="container chanp">
			<div class="row">
				<div class="navigation"><%@ include
						file="/jsp/common/header.jsp"%></div>
				<div class="row chnap_row">
					<%@ include file="/jsp/common/leftMenu_new.jsp"%>
					<div class="col-md-6 right_list">
						<div class="Open_cache">
							<div class="Open_cache_table">
								<ul>
									<li><a href="${_base }/storm/task/toRegisterTask">计算任务注册</a>
									</li>
								</ul>
							</div>
							<!--我的服务-->
							<!--<div class="form-group">
							<label for="mainTitle" class="col-sm-2 control-label"> <span
								style="color: red;">*</span> storm jar包：
							</label>
							<div class="col-sm-10">
								<form  id="fileForm" enctype="multipart/form-data">
									<input type="file" class="form-control" id="insertFile"
										name="myFile" value="" /> <input type="submit" value="展示">
								</form>
							</div>
						</div-->
							<form role="form" id="my_form">
								<div class="bad_main">
									<ul>
										<li class="jis">计算任务名称：</li>
										<li><input id="name" name="name" type="text"
											class="form-control" maxlength="50" readonly></li>
									</ul>
									<ul>
										<li class="jis">Work数量：</li>
										<li><input id="numWorkers" name="numWorkers" type="text"
											class="form-control" readonly></li>
									</ul>
									<ul>
										<li class="jis">集群标识：</li>
										<li>
										  <select class="jzc_input" id="clusterId" name="clusterId">
											 <!-- <option value="1">信控集群111</option>  -->
											 <c:forEach var="v" items="${pageSelectValue.resultList}">
				          					      <option value="${v.clusterType}">信控集群 (${v.comments})</option>
				          					</c:forEach>
										  </select>
										</li>
									</ul>
									
									 <ul>
										<li class="jis">Spout配置：</li>
										<!-- <li><a href="javascript:void(0)" id="btn_spout_add">
												<input name="" type="button" class="js_button" value="增加">
										</a></li> -->
									</ul> 
									<ul>
										<li class="jis">任务说明：</li>
										<li><textarea id="comments" name="comments"
												class="jzc_input_c"></textarea></li>
									</ul>
									<ul>
										<li class="zj_table">
											<table width="100%" border="0">
												<tr align="center" valign="middle">
													<td>Spout名称</td>
													<td>Spout类名</td>
													<td>线程数量</td>
													<!-- <td>操作</td>  -->
												</tr>
												<tbody id="tbody_spout">
													<tr align="center" valign="middle">
														<td><input type="text" class="jis_ps" id="spoutName"
															name="spoutName" value="" readonly></td>
														<td><input type="text" class="jis_ps"
															id="spoutClassName" name="spoutClassName" value="" readonly>
														</td>
														<td><input type="text" class="jis_ps"
															id="spoutThreads" name="spoutThreads" value="">
															<span style="color: red;">*</span>
														</td>
														<!-- 暂时不需要操作功能 -->
														<!--<td>
															<button type="button" class="btn btn-info btn-sm"
																onclick="del_tr(this)">删除</button>
														</td>-->
													</tr>
												</tbody>
											</table>
										</li>
									</ul>
									<ul> 
										<li class="jis">Bolt配置：</li>
										<!-- <li><a href="javascript:void(0)" id="btn_bolt_add"> <input
												name="" type="button" class="js_button" value="增加">
										</a></li> -->
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
													<!-- <td width="10%">操作</td> -->
												</tr>
												<tbody id="tbody_bolt">
													<tr align="center" valign="middle">
														<td><input type="text" class="jis_ps" id="boltName"
															name="boltName" value="" readonly></td>
														<td><input type="text" class="jis_ps"
															id="boltClassName" name="boltClassName" value="" readonly>
														</td>
														<td><input type="text" class="jis_ps" id="threads"
															name="threads" value=""><span style="color: red;">*</span></td>
														<td><input type="text" class="jis_ps"
															id="groupingTypes" name="groupingTypes" value="" readonly>
														</td>
														<td><input type="text" class="jis_ps"
															id="groupingSpoutOrBlots" name="groupingSpoutOrBlots"
															value="" readonly></td>
														<!-- <td>
															<button type="button" class="btn btn-info btn-sm"
																onclick="del_tr(this)">删除</button>
														</td> -->
													</tr>
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
												<!---->
												<div class="form-group">
													<label for="mainTitle" class="col-sm-4 control-label">
														<span style="color: red;">*</span> storm jar包：
													</label>
													<div class="col-sm-8">

														<input type="file" accept=".jar" class="form-control" id="insertFile"
															name="myFile" value="" />
														<button type="submit" class="btn btn-primary"
															id="show_related" style="">展示</button>
														<button type="submit" class="btn btn-primary"
															id="insertFile_btn" style="">创建计算任务</button>
														<button class="btn btn-primary"
															id="return_btn" style="" onclick="history.go(-1)">返回</button>	

													</div>
												</div>
												<!---->

											</div>


										</div>
									</ul>
									<!--<ul>
									<li>
										<button type="submit" class="btn btn-primary"
											id="insertFile_btn" style="">创建计算任务</button>
										<button type="reset" class="btn" id="cz_button">重置</button>
									</li>
								</ul>-->
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!--底部-->
		<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
		<script src="${_base }/resources/js/storm/jquery.form.js"></script>
		<script type="text/javascript">

    $(function(){  

    	
        $("#insertFile_btn").bind("click", function() {
            var _this = this;
            //
            $(_this).addClass("disabled");
            
            var name = $.trim($("#insertFile").val());
            if (name === "") {
                $.dialog.alert("请选取jar文件并点击展示",function(){
                 $(_this).removeClass("disabled");
               });
                return false;
            }
            else if(!/.jar$/.test(name)){
            	$.dialog.alert("文件格式错误，请重新上传jar格式文件");
            	return false;
            }
            
            var filename=$.trim($("#name").val());
            var namerg=/^[A-Za-z0-9\u9fa5_\u9fa5-]+$/;/* 任务名包含数字和字母并支持下划线和横杠  */
            if(filename === ""){
            	$.dialog.alert("任务名不能为空！");
            	return false;
            }else if(!namerg.test(filename)){
            	$.dialog.alert("任务名称不能包含中文！");
            	return false;
            };
            
            var numWorkers = $.trim($("#numWorkers").val());
            var r = /^\+?[1-9][0-9]*$/;
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
            
            var t01 = $("#tbody_spout tr").length;
            if(t01 == 0){
            	$.dialog.alert("spout行数不得为0",function(){
            		$(_this).removeClass("disabled");
            	});
            	return false;
            }
            
            var t02 = $("#tbody_bolt tr").length;
            if(t02 == 0){
            	$.dialog.alert("bolt行数不得为0",function(){
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
            		spoutConfig = "spout线程数量存在空值或不为正整数，请重新配置";
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
            		boltConfig = "bolt线程数量存在空值或不为正整数，请重新配置";
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
            				boltConfig = "spout或bolt参数与任务包不一致，请重新配置！";
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
            
            /* var imgFile = $.trim($("#insertFile").val());
            if (imgFile === "") {
                $.dialog.alert("请选择jar文件",function(){
                 $(_this).removeClass("disabled");
               });
                return false;
            } */

        });
        $("input[readonly]").each(function(i,d){
        	$(d).css("background-color","#eee");
        });
    });
    </script>
</body>
</html>
