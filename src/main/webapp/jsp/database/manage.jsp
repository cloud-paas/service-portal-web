<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/jsp/common/common.jsp" %>
    <script src="${_base}/resources/js/common/jquery-migrate/jquery-migrate-1.2.1.js"></script>
    <link href="${_base }/resources/css/jsonmate/jsoneditor.css" rel="stylesheet">
    <script src="${_base}/resources/js/common/fileupload/ajaxfileupload.js"></script>
    <script src="${_base}/resources/js/common/jsonmate/jquery.jsoneditor.min.js"></script>
    <script src="${_base}/resources/js/common/jsonmate/json2.js"></script>
    <script src="${_base}/resources/js/config/config.js"></script>
    <title>配置管理管理页面</title>
    <script>
        var configManager = new configManager();
        $(document).ready(function () {
        	$("#navi_tab_product").addClass("chap");
            configManager.revicemyservice();
            configManager.reviceconfigdata(configManager.currentLevel, "");
        });
    </script>
</head>
<body>
<!-- 头部和导航条 -->
<div class="container chanp"><div class="row">  <div class="navigation"><%@ include file="/jsp/common/header.jsp"%></div></div>
<div class="row chnap_row">
    <div class="col-md-6 left_list">
        <div class="list_groups">
            <div class="list_groups_none">
                <ul>
                    <li class="biaot" onClick="turnit(6,2);">
                        <a href="#">
                            <p><img src="${_base }/resources/images/icon1.png"></p>

                            <p>我的服务</p>

                            <p class="sanjiao"><img src="${_base }/resources/images/b.png" id="img2"></p>
                        </a>
                    <li class="list_xinx" id="myservices">
                    </li>
                    <script id="myserviceTmpl" type="text/x-jsrender">
                            {^{for resultList}}
                                <p><a href="javascript:void(0);" name="service" id="serviceIdtest" onclick="javascript:configManager.setcurrentservice('{{:serviceId}}')" value="{{:serviceId}}"><span><img src="${_base }/resources/images/icon6.png"></span><span style="margin-top:2px;">{{:serviceName}}</span></a></p>
                            {{/for}}


                    </script>
                    </li>
                </ul>
            </div>
        </div>
    </div>
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
                <ul>
                    <li><input name="keyword" type="text" class="search_ch" id="keyword"></li>
                    <li class="open_btn"><a href="javascript:void(0)"
                                            onclick="javascript:configManager.searchConfig();">搜索</a></li>
                    <li class="xil"><A href="javascript:void(0);" class="gy_btn"
                                       onclick="javascript:configManager.addConfig();">新增</A></li>
                    <li class="xil"><A href="javascript:void(0);" class="gy_btn"
                                       onclick="javascript:configManager.delConfig()">删除</A>
                    </li>
                    <li class="xil"><A href="javascript:void(0)" class="gy_btn"
                                       onclick="javascript:configManager.uploadFile();">导入</A></li>
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
                                <td width="20%" style="word-break:break-all;"><a href="javascript:void(0)" onclick="javascript:configManager.gotochild('{{:path}}')">{{:path}}</a></td>
                                <td width="60%" style="word-break:break-all;">{{:data}}</td>
                                <td width="10%" style="word-break:break-all;"><a href="javascript:void(0)" onclick="javascript:configManager.editConfig('{{:path}}')">编辑</a></td>
                             </tr>
                         {{/for}}
                    </tbody>
                 </table>

            </script>
            <script id="addConfigTmpl" type="text/x-jsrender">
                <form id="addConfigForm">
                   <div class="Open_cache_list_tow">
                        <ul>
                            <li class="lef_zi">节点名称：</li>
                            <li id="pathValue"><input name="configpath" type="text" class="pei_input" id="configpath"></li>
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
                            <li class="lef_zi">JSON值：</li>
                            <div style=" width:680px; height:60px; border:1px solid #e9e9e9; overflow:auto;  overflow-x:auto;overflow-y:hide;"  >
                                <textarea id="jsoncontentvalue" style=" width:680px; height:60px;"></textarea>
                            </div>
                        </ul>
                    </div>
                    <div class="Open_cache_list_tow">
                        <ul>
                            <li class="open_btn"><A href="javascript:void(0);" id="addConfigBtn">确定</A><A href="javascript:void(0)" id="centerConfigBtn">取消</A></li>
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
                            <li class="lef_zi">JSON值：</li>
                            <div style=" width:680px; height:60px; float:left; border:1px solid #e9e9e9; overflow:auto;  overflow-x:auto;overflow-y:hide;"  >
                                <textarea id="jsoncontentvalue" style=" width:680px; height:60px;">{{:data}}</textarea>
                            </div>
                        </ul>
                    </div>
                    <div class="Open_cache_list_tow">
                        <ul>
                            <li class="open_btn"><A href="javascript:void(0);" id="editConfigBtn">确定</A><A href="javascript:void(0)" id="centerConfigBtn">退出编辑</A></li>
                        </ul>
                    </div>

            </script>

            <script id="loadingDataTmpl" type="text/x-jsrender">
                <p style=" text-align:center;"><img src="${_base}/resources/images/loading.gif"></p>

            </script>

            <script id="uploadFileTmpl" type="text/x-jsrender">
                <ul>
                    <li class="lef_zi">文件名称：</li>
                    <li><input type="file" name="uploadFile" id="uploadFile" accept=".properties"/></li>
                </ul>
                <ul>
                    <li class="open_btn"><A href="javascript:void(0);" id="uploadFileBtn">上传配置</A><A href="javascript:void(0)" id="centerConfigBtn">取消</A></li>
                </ul>
            </script>

        </div>
    </div>
</div>
</div>
<%@ include file="/jsp/common/footer.jsp" %>
</body>
</html>
