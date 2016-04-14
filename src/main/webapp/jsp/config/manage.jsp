<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/jsp/common/common.jsp" %>
    <script src="${_base}/resources/js/common/jquery-migrate/jquery-migrate-1.2.1.js"></script>
    <link href="${_base}/resources/css/jsoneditor/jsoneditor.min.css" rel="stylesheet"/>
    <script src="${_base}/resources/js/common/fileupload/ajaxfileupload.js"></script>
    <script src="${_base}/resources/js/common/jsoneditor/jsoneditor.min.js"></script>
    <script src="${_base}/resources/js/common/jsonmate/json2.js"></script>
    <script src="${_base}/resources/js/config/config.js"></script>
    <title>配置管理管理页面</title>
	<script>
		var configManager = new configManager();
		$(document).ready(function() {
			configManager.gotoroot("/",1);
		});
	</script>
</head>
<body>
<!-- 头部和导航条 -->
  <div class="big_k"><!--包含头部 主体-->   
   <!--导航-->
   <%@ include file="/jsp/common/header_console.jsp"%>
      
   <div class="container chanp">
   <%@ include file="/jsp/common/leftMenu_console.jsp"%>
<div class="row chnap_row">
    <div class="col-md-6 right_list">
        <div class="Open_cache">
            <div class="Open_cache_table">
                <ul>
                    <li><a href="javascript:void(0);">我的配置</a></li>
                </ul>
            </div>
            <div class="Open_cache_list" id="errormessage" style="display:none;">
                <div class="Open_cache_list_none">
                    <p><img src="${_base}/resources/images/error_icon11.png"></p>

                    <p style=" margin-top:2px;" id="errortext"></p>
                </div>
            </div>
            <div class="Open_cache_list" id="successmessage" style="display:none;">
                <div class="Open_cache_list_none">
                    <p><img src="${_base}/resources/images/icon10.png"></p>
                    <p style=" margin-top:2px;" id="successtext"></p>
                </div>
            </div>
            <!--我的服务-->
            <div class="fuw_search">
                <ul style="margin-left:200px"> 
<!--                     <li><input name="keyword" type="text" class="search_ch" id="keyword"></li> -->
<!--                     <li class="open_btn"><a href="javascript:void(0)" -->
<!--                                             onclick="javascript:configManager.searchConfig();">搜索</a></li> -->
                    <li class="xil"><A href="javascript:void(0);" class="gy_btn"
                                       onclick="javascript:configManager.addConfig();">新增</A></li>
                    <li class="xil"><A href="javascript:void(0);" class="gy_btn"
                                       onclick="javascript:configManager.delConfig()">删除</A>
                    </li>
                    <li class="xil"><A href="javascript:void(0)" class="gy_btn"
                                       onclick="javascript:configManager.uploadFile();">导入</A></li>
                    <li class="xil"><a href="#" class="gy_btn" onclick=""
                    				   data-toggle="modal" data-target="#cancle_model">导出</a></li>
                </ul>
            </div>
            <div class="guan">
                <ul id="navMenu">
                    <li><A href="javascript:void(0);"
                           onclick="javascript:configManager.gotoroot('/',1);">/&nbsp;Root </A>/
                    </li>
                    <li><A href="javascript:void(0);" onclick="javascript:configManager.addConfig();">+</A></li>
                </ul>
            </div>
            <div id="datapart">
            </div>
            <div class="modal fade bs-example-modal-sm" id="cancle_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  			<div class="modal-dialog">
						<div class="modal-content">
			  				<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								<h4 class="modal-title" id="myModalLabel">导出配置文件</h4>
			  				</div>
			  				<div class="modal-body">		      			 	
			      			 	<ul>该导出功能将导出该用户下的所有配置信息！</ul>
			      			 	<ul>
			      			 		<button type="button" style="margin-left:400px" class="btn btn-default" data-dismiss="modal" id = "cancle_back">取消</button>
			      			 		<a href="${_base }/config/download" class="btn btn-primary" onclick="configManager.download()">确认</a>
			      			 	</ul>								
			  				</div> 
						</div>
		  			</div>
				</div>
            <script id="datapartTmpl" type="text/x-jsrender">
                <table width="100%" border="0">
                    <thead>
                        <tr class="bjtr">
                            <td width="10%" style="word-break:break-all;"><input type="checkbox" onclick="javascript:configManager.checkAll(this)"/></td>
                            <td width="20%" style="word-break:break-all;">配置路径</td>
                            <td width="60%" style="word-break:break-all;">配置值</td>
                            <td width="10%" style="word-break:break-all;">操作</td>
                        </tr>
                    </thead>
                    <tbody>
                        {^{for resultList}}
                            <tr data-link="class{:#index%2==0?'':'bjtr'}">
                                <td width="10%" style="word-break:break-all;"><input type="checkbox" name="selectFlag" value="{{:path}}"/></td>
                                <td width="20%" style="word-break:break-all;"><a href="javascript:void(0)" style="color:#5dace4" onclick="javascript:configManager.gotochild('{{:path}}')">{{:path}}</a></td>
                                <td width="60%" style="word-break:break-all;">{{:data}}</td>
                                <td width="10%" style="word-break:break-all;"><a href="javascript:void(0)" style="color:#5dace4" onclick="javascript:configManager.editConfig('{{:path}}')">编辑</a></td>
                             </tr>
                         {{/for}}
                    </tbody>
                 </table>		                
            </script>
                        <div class="Open_cache_list" id="errormessage" style="display:none;">
                <div class="Open_cache_list_none">
                    <p><img src="${_base}/resources/images/error_icon11.png"></p>

                    <p style=" margin-top:2px;" id="errortext"></p>
                </div>
            </div>
            <script id="addConfigTmpl" type="text/x-jsrender">
                <form id="addConfigForm">
                   <div class="Open_cache_list_tow">
                        <ul>
                            <li class="lef_zi">节点名称：</li>
                            <li id="pathValue"><input name="configpath" type="text" class="pei_input" id="configpath"></li>
                        	<li id="errorLabel" style="dispaly:none" ><p id="pathErrorTest" style="color:red"></p></li>
						</ul>						
                    </div>
                    <div class="Open_cache_list_tow">
                        <ul>
                            <li class="lef_zi">节点值：</li>
                            <div style=" width:680px; height:300px; border:1px solid #e9e9e9; overflow:auto;  overflow-x:auto;"  class="json-editor" id="jsonContent">
                            </div>
                        </ul>
                    </div>
                    <div class="Open_cache_list_tow">
                        <ul>
                            <li class="open_btn" ><A href="javascript:void(0);" class="gy_btn"  id="addConfigBtn">确定</A><A href="javascript:void(0)" class="gy_btn" id="centerConfigBtn">取消</A></li>
                        </ul>
                    </div>
                </form>
            </script>
            <script id="editConfigTmpl" type="text/x-jsrender">
                    <div class="Open_cache_list_tow">
                        <ul>
                            <li class="lef_zi">节点名称：</li>
                            <li id="pathValue">{{:path}}</li>
                        </ul>
                    </div>
                    <div class="Open_cache_list_tow">
                        <ul>
                            <li class="lef_zi">节点值：</li>
                            <div style=" width:680px; height:300px; border:1px solid #e9e9e9; overflow:auto;  overflow-x:auto;"  class="json-editor" id="jsonContent">
                            </div>
                        </ul>
                    </div>
                    <div class="Open_cache_list_tow">
                        <ul>
                            <li class="open_btn"><A href="javascript:void(0);" class="gy_btn" id="editConfigBtn">确定</A><A href="javascript:void(0)" class="gy_btn" id="centerConfigBtn">退出编辑</A></li>
                        </ul>
                    </div>
            </script>

            <script id="loadingDataTmpl" type="text/x-jsrender">
                <p style=" text-align:center;"><img src="${_base}/resources/images/loading.gif"></p>
            </script>

            <script id="uploadFileTmpl" type="text/x-jsrender">
                <ul>
					<li class="lef_zi">主意事项：</li>             
                    <li>只能上传以.properites结尾的文件</li>
                </ul>
                <ul>
                    <li class="lef_zi">文件名称：</li>
                    <li><input type="file" name="uploadFile" id="uploadFile" accept=".properties"/></li>
                </ul>
                <ul>
                    <li class="open_btn"><A href="javascript:void(0);" id="uploadFileBtn">上传配置</A><A href="javascript:void(0)" id="centerConfigBtn">取消</A></li>
                </ul>
            </script>
            
           <script id="download" type="text/x-jsrender">
			    <table width="100%" border="0">
                    <thead>
                        <tr class="bjtr">
                            <td width="10%" style="word-break:break-all;"><input type="checkbox" onclick="javascript:configManager.checkAll(this)"/></td>
                            <td width="20%" style="word-break:break-all;">配置路径</td>
                            <td width="60%" style="word-break:break-all;">配置值</td>
                            <td width="10%" style="word-break:break-all;">操作</td>
                        </tr>
                    </thead>
                    <tbody>
                        {^{for resultList}}
                            <tr data-link="class{:#index%2==0?'':'bjtr'}">
                                <td width="10%" style="word-break:break-all;"><input type="checkbox" name="selectFlag" value="{{:path}}"/></td>
                                <td width="20%" style="word-break:break-all;"><a href="javascript:void(0)" style="color:#5dace4" onclick="javascript:configManager.gotochild('{{:path}}')">{{:path}}</a></td>
                                <td width="60%" style="word-break:break-all;">{{:data}}</td>
                                <td width="10%" style="word-break:break-all;"><a href="javascript:void(0)" style="color:#5dace4" onclick="javascript:configManager.editConfig('{{:path}}')">编辑</a></td>
                             </tr>
                         {{/for}}
                    </tbody>
                 </table>
               <div class="modal fade bs-example-modal-sm" id="cancle_model" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		  			<div class="modal-dialog">
						<div class="modal-content">
			  				<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
								<h4 class="modal-title" id="myModalLabel">导出配置文件</h4>
			  				</div>
			  				<div class="modal-body">
			      			 	你确定要导出所有的配置文件吗？
				   				<button type="button" class="btn btn-default" data-dismiss="modal" id = "cancle_back">取消</button>
								<button type="button" class="btn btn-primary" onclick="configManager.cancle()">确认</button>
			  				</div> 
						</div>
		  			</div>
				</div>
         	</script>
            
        </div>
    </div>
</div>
</div>
</div>
<!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
</body>
</html>
