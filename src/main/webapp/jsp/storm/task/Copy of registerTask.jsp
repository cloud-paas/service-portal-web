<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/storm/common/jsp/html_meta.jsp"%>
<title>注册计算任务</title>
<%@ include file="/jsp/storm/common/jsp/html_js.jsp"%>
<style>
</style>
<script type="text/javascript">
	$(function() {
		/* var url = "${_base}/storm/demo/add";
		var param = "";
		ajaxSubmit_my(url, param, "成功", "", "") */
		//绑定按钮事件开始
		$("#btn_spout_add").bind("click",function(){
			var rowStr = "<tr>"
                +"<td> <input type=\"text\" class=\"form-control\" id=\"spoutName\" name=\"spoutName\" placeholder=\"Spout名称\" value=\"\"></td>"
                +"<td> <input type=\"text\" class=\"form-control\" id=\"spoutClassName\" name=\"spoutClassName\" placeholder=\"Spout类名\" value=\"\"></td>"
                +"<td> <input type=\"text\" class=\"form-control\" id=\"spoutThreads\" name=\"spoutThreads\" placeholder=\"线程数量\" value=\"\"></td>"
                +"<td><button type=\"button\" class=\"btn btn-danger btn-sm\" onclick=\"del_tr(this)\">删除</button></td>"
                +"</tr>";
            $("#tbody_spout").append(rowStr);
		});
		$("#btn_bolt_add").bind("click",function(){
			var rowStr = "<tr>"
				+"<td> <input type=\"text\" class=\"form-control\" id=\"boltName\" name=\"boltName\" placeholder=\"Bolt名称\" value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"form-control\" id=\"boltClassName\" name=\"boltClassName\" placeholder=\"Bolt类名\" value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"form-control\" id=\"threads\" name=\"threads\" placeholder=\"线程数量\" value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"form-control\" id=\"groupingTypes\" name=\"groupingTypes\" placeholder=\"grouping类型，多个，逗号分隔\" value=\"\"></td>"
				+"<td> <input type=\"text\" class=\"form-control\" id=\"groupingSpoutOrBlots\" name=\"groupingSpoutOrBlots\" placeholder=\"grouping源头，多个，逗号分隔\" value=\"\"></td>"
				+"<td><button type=\"button\" class=\"btn btn-danger btn-sm\" onclick=\"del_tr(this)\">删除</button></td>"
				+"</tr>";
            $("#tbody_bolt").append(rowStr);
		});
	});
	//
	function del_tr(t){
		$(t).parent().parent().remove();
	}
</script>
</head>
<body>
    <jsp:include page="/jsp/common/header.jsp"></jsp:include>
    <div class="row chnap_row">
        <%@ include file="/jsp/common/leftMenu.jsp"%>
        <div class="col-md-6 right_list">
            <form role="form" id="my_form">
                <div class="row" style="margin-top: 10px;">
                    <div class="col-md-6">
                        <div class="panel panel-warning">
                            <div class="panel-heading">计算任务信息：</div>
                            <div class="panel-body">
                                <div class="form-group">
                                    <label for="name">计算任务名称</label>
                                    <input type="text" class="form-control" id="name" name="name" placeholder="计算任务名称"
                                        value="" maxlength="50"
                                    >
                                </div>
                                <div class="form-group">
                                    <label for="clusterId">所属集群</label>
                                    <select class="form-control" id="clusterId" name="clusterId">
                                        <option value="1">信控集群</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="numWorkers">work数量</label>
                                    <input type="text" class="form-control" id="numWorkers" name="numWorkers"
                                        placeholder="work数量" value="" maxlength="5"
                                    >
                                </div>
                                <div class="form-group">
                                    <label for="comments">集群说明</label>
                                    <textarea rows="10" cols="10" class="form-control" id="comments" name="comments"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="panel panel-warning">
                            <div class="panel-heading">Spout配置：</div>
                            <div class="panel-body">
                                <div>
                                    <button type="button" class="btn btn-primary btn-sm" id="btn_spout_add">新增</button>
                                </div>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <td width="20%">Spout名称</td>
                                            <td>Spout类名</td>
                                            <td width="20%">线程数量</td>
                                            <td width="10%">操作</td>
                                        </tr>
                                    </thead>
                                    <tbody id="tbody_spout">
                                        <tr>
                                            <td>
                                                <input type="text" class="form-control" id="spoutName" name="spoutName"
                                                    placeholder="Spout名称" value=""
                                                >
                                            </td>
                                            <td>
                                                <input type="text" class="form-control" id="spoutClassName"
                                                    name="spoutClassName" placeholder="Spout类名" value=""
                                                >
                                            </td>
                                            <td>
                                                <input type="text" class="form-control" id="spoutThreads"
                                                    name="spoutThreads" placeholder="线程数量" value=""
                                                >
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-danger btn-sm"
                                                    onclick="del_tr(this)"
                                                >删除</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
                        <div class="panel panel-warning" style="margin-top: 10px;">
                            <div class="panel-heading">Bolt配置：</div>
                            <div class="panel-body">
                                <div>
                                    <button type="button" class="btn btn-primary btn-sm" id="btn_bolt_add">新增</button>
                                </div>
                                <table class="table table-striped">
                                    <thead>
                                        <tr>
                                            <td width="20%">Bolt名称</td>
                                            <td>Bolt类名</td>
                                            <td width="20%">线程数量</td>
                                            <td>grouping类型</td>
                                            <td>grouping源头</td>
                                            <td width="10%">操作</td>
                                        </tr>
                                    </thead>
                                    <tbody id="tbody_bolt">
                                        <tr>
                                            <td>
                                                <input type="text" class="form-control" id="boltName" name="boltName"
                                                    placeholder="Bolt名称" value=""
                                                >
                                            </td>
                                            <td>
                                                <input type="text" class="form-control" id="boltClassName"
                                                    name="boltClassName" placeholder="Bolt类名" value=""
                                                >
                                            </td>
                                            <td>
                                                <input type="text" class="form-control" id="threads" name="threads"
                                                    placeholder="线程数量" value=""
                                                >
                                            </td>
                                            <td>
                                                <input type="text" class="form-control" id="groupingTypes"
                                                    name="groupingTypes" placeholder="grouping类型，多个，逗号分隔" value=""
                                                >
                                            </td>
                                            <td>
                                                <input type="text" class="form-control" id="groupingSpoutOrBlots"
                                                    name="groupingSpoutOrBlots" placeholder="grouping源头，多个，逗号分隔"
                                                    value=""
                                                >
                                            </td>
                                            <td>
                                                <button type="button" class="btn btn-danger btn-sm"
                                                    onclick="del_tr(this)"
                                                >删除</button>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <form id='myForm' enctype='multipart/form-data' class="form-horizontal">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label for="mainTitle" class="col-sm-2 control-label">
                                <span style="color: red;">*</span>
                                storm jar包：
                            </label>
                            <div class="col-sm-10">
                                <input type="file" class="form-control" id="insertFile" name="insertFile" value="" />
                            </div>
                        </div>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-md-4"></div>
                    <div class="col-md-4">
                        <div class="btn-group">
                            <button type="submit" class="btn btn-primary" id="insertFile_btn" style="">创建计算任务</button>
                            <button type="reset" class="btn" id="cz_button">重置</button>
                        </div>
                    </div>
                    <div class="col-md-4"></div>
                </div>
            </form>
        </div>
    </div>
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
            			alert(d);
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
            //
            $("#myForm").submit(function () {
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
                        url="${_base}/storm/task/registerTask";
                        param="&jarFilePath="+jsonData.fk+"&";
                        param+=_$_param;
                        //alert(param);
                        ajaxSubmit_my(url,param,"注册计算任务成功喽~","${_base}/storm/task/toList","insertFile_btn");
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
