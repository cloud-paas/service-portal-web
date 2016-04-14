<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <%@ include file="/jsp/maintain/common.jsp" %>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <link href="${_base}/resources/css/jsoneditor/jsoneditor.min.css" rel="stylesheet"/>
    <script src="${_base}/resources/js/maintain/config/config_manage.js"></script>
    <script src="${_base}/resources/js/maintain/fileupload/ajaxfileupload.min.js"></script>
    <script src="${_base}/resources/js/maintain/jsoneditor/jsoneditor.min.js"></script>
    <script src="${_base}/resources/js/maintain/jsonmate/json2.js"></script>
    <script>
        var configManager = new configManager();
        $(document).ready(function () {
            configManager.initdataconfig();
        });
    </script>
</head>

<body>
<div class="big_k"><!--包含头部 主体-->
    <div class="herd">
        <div class="wrap">
            <ul class="wrap_left">
                <li>欢迎来到IpaaS</li>
            </ul>
        </div>
    </div>

    <!--导航-->
    <div class="navigation">
        <div class="navigation_A">
            <div class="logo"><img src="${_base}/resources/images/logo.png"></div>
        </div>
    </div>

    <div class="container chanp">
        <div class="row chnap_row xing_zx">
            <div class="col-md-6 right_list">
                <div class="Open_cache">
                    <div class="Open_cache_table xing_zx_tab">
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
                    <div class="fuw_search xing_zx_an">
                        <ul>
                            <li><input name="keyword" id="keyword" type="text" class="search_ch"></li>
                            <li class="open_btn"><a href="javascript:void(0);" onclick="javascript:configManager.searchConfig();">搜索</a></li>
                            <li class="xil_A" style="margin-left:300px;"><A href="javascript:void(0);" class="gy_btn" onclick="javascript:configManager.addConfig();">增加</A></li>
<!--                             <li class="xil"><A href="javascript:void(0);" class="gy_btn" onclick="javascript:configManager.uploadFile();">导入</A></li> -->
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
                    <script id="initDataPartImpl" type="text/x-jsrender">
                        <table width="100%" border="0">
                            <thead>
                            <tr>
                                <td width="20%" style="word-break:break-all;">配置路径</td>
                                <td width="60%" style="word-break:break-all;">配置值</td>
                                <td width="10%" style="word-break:break-all;">操作</td>
                            </tr>
                            </thead>
                            <tbody>
                                <tr class="bjtr">
                                    <td width="20%" style="word-break:break-all;"><a href="javascript:void(0)" onclick="javascript:configManager.gotoReadonlyChild('readonly')">readonly</a></td>
                                    <td width="60%" style="word-break:break-all;">只读节点，用户只能进行只读操作权限</td>
                                    <td width="10%" style="word-break:break-all;"></td>
                                </tr>
                                <tr>
                                    <td width="20%" style="word-break:break-all;"><a href="javascript:void(0)" onclick="javascript:configManager.gotoWritableChild('writable')">writable</a></td>
                                    <td width="60%" style="word-break:break-all;">可读写节点，用户拥有所有操作权限</td>
                                    <td width="10%" style="word-break:break-all;"></td>
                                </tr>
                            </tbody>
                        </table>
                    </script>
                    <script id="datapartTmpl" type="text/x-jsrender">
                        <table width="100%" border="0">
                            <thead>
                                <tr>
                                    <td width="20%" style="word-break:break-all;">配置路径</td>
                                    <td width="60%" style="word-break:break-all;">配置值</td>
                                    <td width="10%" style="word-break:break-all;">操作</td>
                                </tr>
                            </thead>
                            <tbody>
                                {{for resultList}}
                                    <tr data-link="class{:#index%2==0?'':'bjtr'}">
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
                                    <li style="color:green">*可以输入路径，例如在/root/节点下点击新增"a/b/c",就会创建/root/a/b/c路径</li>
                                </ul>
                            </div>
                            <div class="Open_cache_list_tow">
                                <ul>
                                    <li class="lef_zi">节点值：</li>
                                    <div class="liangli" style="width:600px; height:400px;" id="jsonContent"></div>
                                </ul>
                            </div>
                            <div class="Open_cache_list_tow">
                                <ul>
                                    <li class="open_btn"><input name="addConfigBtn" type="button" id="addConfigBtn"  class="open_btn1" value="确定" /><input name="centerConfigBtn" type="button"  class="open_btn1" id="centerConfigBtn" value="取消"/></li>
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
                                <div class="liangli" style="width:600px; height:400px;" id="jsonContent"></div>
                            </ul>
                        </div>
                        <div class="Open_cache_list_tow">
                            <ul>
                                <li class="open_btn">
									<input name="deleteConfigBtn" type="button" id="deleteConfigBtn"  class="open_btn1" value="删除节点" />
									<input name="editConfigBtn" type="button" id="editConfigBtn"  class="open_btn1" value="确定修改" />
									<input name="centerConfigBtn" type="button" id="centerConfigBtn" class="open_btn1"  value="退出编辑"/>
								</li>
                            </ul>
                        </div>
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
                    <script id="loadingDataTmpl" type="text/x-jsrender">
                        <p style=" text-align:center;"><img src="${_base}/resources/images/loading.gif"></p>
                    </script>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="container bott_xinx">
    <p>Copyright©2005-2015 Asiainfo All Rights Reserved </p>
</div>
</body>
</html>
