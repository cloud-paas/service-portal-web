<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/jsp/common/common.jsp"%>
<title>用户中心</title>
<!-- <style>
.hidden {
	display: none;
}
</style> -->
<link href="${_base}/resources/js/common/jsonmate/jsoneditor.css" rel="stylesheet"/>
<style>
        body {
          padding: 0 70px;
        }
        #json {
          margin: 10px 10px 10px 32px;
          width: 50%;
          min-height: 70px;
        }
        h1 {
          font-family: Arial;
          color: #EBBC6E;
          text-align: center;
          text-shadow: 1px 1px 1px black;
          border-bottom: 1px solid gray;
          padding-bottom: 50px;
          width: 500px;
          margin: 20px auto;
        }
        h1 img {
          float: left;
        }
        h1 b {
          color: black;
          font-weight: normal;
          display: block;
          font-size: 12px;
          text-shadow: none;
        }

        #legend {
          display: inline;
          margin-left: 30px;
        }
        #legend h2 {
           display: inline;
           font-size: 18px;
           margin-right: 20px;
        }
        #legend a {
          color: white;
          margin-right: 20px;
        }
        #legend span {
          padding: 2px 4px;
          -webkit-border-radius: 5px;
          -moz-border-radius: 5px;
          border-radius: 5px;
          color: white;
          font-weight: bold;
          text-shadow: 1px 1px 1px black;
          background-color: black;
        }
        #legend .string  { background-color: #009408; }
        #legend .array   { background-color: #2D5B89; }
        #legend .object  { background-color: #E17000; }
        #legend .number  { background-color: #497B8D; }
        #legend .boolean { background-color: #B1C639; }
        #legend .null    { background-color: #B1C639; }

        #expander {
          cursor: pointer;
          margin-right: 20px;
        }

        #footer {
          font-size: 13px;
        }

        #rest {
          margin: 20px 0 20px 30px;
        }
        #rest label {
          font-weight: bold;
        }
        #rest-callback {
          width: 70px;
        }
        #rest-url {
          width: 700px;
        }
        label[for="json"] {
          margin-left: 30px;
          display: block;
        }
        #json-note {
          margin-left: 30px;
          font-size: 12px;
        }

        .addthis_toolbox {
          position: relative;
          top: -10px;
          margin-left: 30px;
        }

        #disqus_thread {
          margin-top: 50px;
          padding-top: 20px;
          padding-bottom: 20px;
          border-top: 1px solid gray;
          border-bottom: 1px solid gray;
        }

    </style>
</head>
<body>
	<div class="big_k">
		<jsp:include page="/jsp/common/header.jsp"></jsp:include>
		<div class="row help shenq">
			<form id="registerF">
				<div class="zc_xinxi">


					<div id="editor" class="json-editor"></div>

					<label for="json">Or paste JSON directly here:</label>
					<p id="json-note">Note that you can edit your JSON directly in
						the textarea below. The JSON viewer will get updated when you
						leave the field.</p>
					<textarea id="json" style="width: 600px;"></textarea>
					<input  type="hidden" id="serviceId" name="serviceId"  value="${serviceId }">
					<div class="Open_cache_list">
	          			<div class="Open_cache_list_tow">
					<ul>
			          <li class="font-title" style="width:60px;">服务ID：</li>
			          <li><input name="serviceId"  id= "serviceId" type="text" value="${serviceId }" class="form-control"></input></li>
			          <li><label style="color:red;" id="queueName_error" for="queueName"></label></li>
		          </ul>
		          
					<ul  style="padding-left:10%">
	          		<li id="message_save_li" >
	          			<a id="mapping_save_btn" href="javascript:void(0);"><div style="margin-top:20px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(121,189,90);line-height:30px;vertical-align:middle;color:#fff">保存</div></a>
	          		</li>
		          	</ul>
					</div></div>
				</div>
			</form>

		</div>

	</div>
	<!--页脚-->
	<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
    <script src="${_base}/resources/js/common/jsonmate/json2.js"></script>
    <script src="${_base}/resources/js/common/jsonmate/jquery.jsoneditor.js"></script>
    <script src="${_base}/resources/js/common/jsonmate/jsoneditor.js"></script>
	<script type="text/javascript">
		var SESMappingController;
		$(function() {
			SESMappingController = new $.SESMappingController();
			$(".head").wrap(document.createElement("div")).closest("div")
					.addClass("navigation");
		});
		
		/*定义页面管理类*/
		(function(){
			$.SESMappingController  = function(){ 
				this.settings = $.extend(true,{},$.SESMappingController.defaults); 
				this.init();
				
			};
			$.extend($.SESMappingController,{
				defaults : {
						MAPPING_SAVE_BTN:"#mapping_save_btn"
				},
				prototype : {
					init : function(){
						var _this = this;
						_this.addRults();
						_this.bindEvents();				
					},
					bindEvents : function(){
						var _this = this;
						$(_this.settings.MAPPING_SAVE_BTN).bind("click",function(){
							$.ajax({
		                        type: 'POST',
		                        url: '${_base}/ses/saveMapping',
		                        dataType: 'json',
		                        data: {
		                            serviceId: function () {
		                                return $("#serviceId").val();
		                            },
		                            mapping: function () {
		                                return $("#json").val();
		                            }
		                        },
		                        success: function (data) {
		                            var code = data.code;
		                            if ("0000" != code) {
		                                $("#errorMessage").text(data.resultMessage);
		                            } else {
		                                alert("Mapping 创建成功！");
		                            }
		                        }
		                    });
						});
					},			
					addRults : function() {				
						
					}
				}
			});
		})(jQuery);
		
	</script>
</body>
</html>