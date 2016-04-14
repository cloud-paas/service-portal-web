<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/storm/common/jsp/html_meta.jsp"%>
<title>demo</title>
<%@ include file="/jsp/storm/common/jsp/html_js.jsp"%>
<style>
</style>
<script type="text/javascript">
	$(function() {
		var url = "${_base}/storm/demo/add";
		var param = "";
		ajaxSubmit_my(url, param, "成功", "", "")
	});
</script>
</head>
<body>
    <c:forEach items="${stormDemoVos }" var="v" varStatus="vs">
    ${v.demoName }
</c:forEach>
    <div class="row">
        <div class="col-md-12">
            <form id='myForm' enctype='multipart/form-data'>
                <div class="form-group">
                    <div>
                        <input type="file" id="insertFile" name="insertFile" value="" />
                        <button type="submit" class="btn btn-primary btn-xs" id="insertFile_btn">上传图片</button>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <script src="${_base }/resources/js/storm/jquery.form.js"></script>
    <script type="text/javascript">
    $(function(){
        $("#insertFile_btn").bind("click", function() {
            var _this = this;
            //
            $(_this).addClass("disabled");
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
                        url="";
                        param="&fk="+jsonData.fk;
                        alert(param);
                        //ajaxSubmit_my(url,param,"上传jar成功喽~","<my:url base='${_base}' url='/_root_my/content/images/toMain'/>","fbgj_button");
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
