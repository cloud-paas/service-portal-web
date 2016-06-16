function configManager() {
    this.currentPath = "/";
    this.currentLevel = 1;
    this.currentserviceId = "";
    this.pagetimeout;
    //constant variables
    this.rootpathvalue = "/";
    this.rootlevelvalue = 1;
    this.editor;
}

/**************************************************进入根节点，孩子节点，当行链接跳转*******************************************/
configManager.prototype.gotoroot = function (parentPath, level) {
    this.reviceconfigdata(parentPath, "");
    this.clearnavmenuhtml(level);
    this.currentPath = parentPath;
    this.currentLevel = level;
}
configManager.prototype.gotochild = function (path) {
    var pathValue = this.appendpathvalue(path);
    this.autoincreatecurrentlevel();
    this.reviceconfigdata(pathValue, "");
    this.appendnavhtml(pathValue, path);
    this.currentPath = pathValue;  
}
configManager.prototype.gotolevel = function (parentPath, level) {
    this.reviceconfigdata(parentPath, "");
    this.clearnavmenuhtml(level);
    this.setcurrentpath(parentPath);
    this.currentLevel = level;
}

/**************************************************页面查询，显示节点信息*******************************************/
configManager.prototype.reviceconfigdata = function (path, keyword) {
    clearTimeout(this.pagetimeout);
    //$("#keyword").val("");
    var userIdVal = $("#userId").val();
    var serviceIdVal = $("#serviceId").val();
    this.loaddatacontent();
    var dataVals = {
        path: path,
        keyword: keyword,
        userId:userIdVal,
        serviceId:serviceIdVal
    };
    $.ajax({
        type: 'POST',
        url: _base + '/config/children/all',
        dataType: 'json',
        contentType: "application/json; charset=utf-8",
        data: JSON.stringify(dataVals),
        success: function (data) {
			if (keyword != '' && keyword != null) {
				var dataCache = new Array();
				$.each(data.data, function(n, value) {
					if (value.path.indexOf(keyword) != -1) {
						dataCache.push(value);
					}
				});
				data.data = dataCache;
			}	
            this.printconfig(data);
        }.bind(this)
    });
}

configManager.prototype.printconfig = function (data) {
    $.templates({
        datapartTmpl: "#datapartTmpl"
    });
    var result = this.formatvalue(data.data, []);
    $.templates.datapartTmpl.link("#datapart", result);
    $("#datapart").removeClass();
    $("#datapart").addClass("fuw_table");
}

configManager.prototype.formatvalue = function (data, defaultvalue) {
    var result;
    if (data != null) {
        result = {
            resultList: data
        }
    } else {
        result = {
            resultList: defaultvalue
        }
    }
    return result;
}

/**************************************************    增加    *******************************************/
//初始化增加配置值面板
configManager.prototype.initaddconfigvalue = function() {
	var container = document.getElementById('jsonContent');
	var options = {
		mode : 'text',
		modes : [ 'text', 'tree', 'view' ], // allowed modes
		onError : function(err) {
			configManager.showerrormessage("输入的值必须是JSON格式的数据");
		}
	};
	var addEditor = new JSONEditor(container, options);
	addEditor.set({});
	this.editor = addEditor;
	return addEditor;
};
configManager.prototype.addConfig = function () {
    this.printaddcontent();
    var addConfigForm = this.validateAddConfig("addConfigForm");
    var editor = this.initaddconfigvalue();

    $("#addConfigBtn").click(function () {
        if (addConfigForm.valid()) {
            this.postaddconfigrequest($("#configpath").val(),editor);
        }
    }.bind(this));
    this.bindeventforcenterbtn("centerConfigBtn");
}
configManager.prototype.postaddconfigrequest = function (path, editor) {
	var userIdVal = $("#userId").val();
    var serviceIdVal = $("#serviceId").val();
    var pathValue = this.appendpathvalue(path);
    //处理jsoneditor中获得的值=================================start
    var modeVal = editor.getMode();
    var dataValue = '';
    var text = ''
    if('text'===modeVal){
    	dataValue = $(".jsoneditor-text").val();
    	text =dataValue;
    }else{
    	dataValue = editor.get();
    	text =JSON.stringify(dataValue);
    }
    //处理jsoneditor中获得的值=================================end
	var data = {
		path : pathValue,
		data : text,
        userId:userIdVal,
        serviceId:serviceIdVal
	};
    $.ajax({
        type: 'POST',
        url: _base + '/config/custom/add',
        dataType: 'json',
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.resultCode == "000000") {
                this.reviceconfigdata(this.currentPath, "");
            } else {
                this.showerrormessage(data.resultMessage);
            }
        }.bind(this)
    });
}
configManager.prototype.printaddcontent = function () {
    $.templates({
        addConfigTmpl: "#addConfigTmpl"
    });
    $.templates.addConfigTmpl.link("#datapart", {});
    $("#datapart").removeClass();
    $("#datapart").addClass("Open_cache_list_tow");
}

configManager.prototype.validateAddConfig = function (formName) {
    var addConfigForm = $("#" + formName);
    addConfigForm.validate({
        rules: {
            configpath: {
                required: true
            }
        },
        messages:{
        	 configpath: {
                 required: "节点路径不可为空！！！"
             }
        },
        success: function (label, element) {
            $(element).removeAttr("style");
        },
        errorPlacement: function (error, element) {
            $(element).css("border-color", "rgb(249, 135, 135)");
            var errorMsg = $(error).text();
            configManager.showError(errorMsg);
        },
        submitHandler: function () {
            configserverregister.valid();
        }
    });
    return addConfigForm;
}

/**************************************************     修改   *******************************************/
configManager.prototype.appendjsonview = function(data) {
	try {
		var container = document.getElementById('jsonContent');
		var options = {
			mode : 'text',
			modes : [ 'text', 'tree', 'view' ], // allowed modes
			onError : function(err) {
				configManager.showerrormessage("输入的值必须是JSON格式的数据");
			}
		};
		var addEditor = new JSONEditor(container, options);
		var json;
		if(data!=''&&data!=undefined&&data!=null){
			try{	
				json = JSON.parse(data);
				addEditor.set(json);
			}catch(e){
				json = data;
			$(".jsoneditor-text").val(json);
			}
		}else{
			json = {};
			$(".jsoneditor-text").val(json);
		}
		return addEditor;
	} catch (ex) {
	}
};
configManager.prototype.editConfig = function (path) {
    var pathValue = this.appendpathvalue(path);
    var userIdVal = $("#userId").val();
    var serviceIdVal = $("#serviceId").val();
    var data = {
        path: pathValue,
        userId:userIdVal,
        serviceId:serviceIdVal
    };
    $.ajax({
        type: 'POST',
        url: _base + '/config/custom/get',
        dataType: 'json',
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            this.printdetailcontent(data,pathValue);
            var editor = this.appendjsonview(data.data);
            //this.bindeventforjsoncontentvalue();
            this.bindeventforcenterbtn("centerConfigBtn");
            $("#editConfigBtn").click(function () {
                this.modifyconfig(editor);
            }.bind(this));
        }.bind(this)
    });
}

configManager.prototype.modifyconfig = function (editor) {
	var userIdVal = $("#userId").val();
    var serviceIdVal = $("#serviceId").val();
    var pathValue = $("#pathValue").text();
    //处理jsoneditor中获得的值=================================start
    var modeVal = editor.getMode();
    var dataValue = '';
    var text = ''
    if('text'===modeVal){
    	dataValue = $(".jsoneditor-text").val();
    	text =dataValue;
    }else{
    	dataValue = editor.get();
    	text =JSON.stringify(dataValue);
    }
    //处理jsoneditor中获得的值=================================end
	var data = {
		path : pathValue,
		data : text,
        userId:userIdVal,
        serviceId:serviceIdVal
	};
    $.ajax({
        type: 'POST',
        url: _base + '/config/custom/modify',
        dataType: 'json',
        data: JSON.stringify(data),
        contentType: "application/json; charset=utf-8",
        success: function (data) {
            if (data.resultCode == "000000") {
                this.reviceconfigdata(this.currentPath, "");
            } else {
                this.showerrormessage(data.resultMessage);
            }
        }.bind(this)
    });
}

configManager.prototype.printdetailcontent = function (data,pathValue) {
    $.templates({
        editConfigTmpl: "#editConfigTmpl"
    });
	var result = {
		path : pathValue,
		data : data
	};
    $.templates.editConfigTmpl.link("#datapart", result);
    $("#datapart").removeClass();
    $("#datapart").addClass("Open_cache_list_tow");
}

//configManager.prototype.appendjsonview = function (data) {
//    try {
//    	var json;
//    	if(data==null||data==undefined||data==''){
//    		json = {};
//    	}else{  		
//    		json = JSON.parse(data);
//    	}
//        var opt = {
//            change: function (data) {
//                $("#jsoncontentvalue").val(JSON.stringify(data));
//            }
//        };
//        $('#jsonContent').jsonEditor(json, opt);
//    } catch (ex) {
//        $('#jsonContent').empty();
//    }
//}

/**************************************************     删除   *******************************************/
configManager.prototype.delConfig = function () {
    var arrObject = this.getallcheckpath()
    if (confirm("确定删除配置？(删除之后,无法恢复)")) {
        $.ajax({
            type: 'POST',
            url: _base + '/config/custom/deleteBatch',
            dataType: 'json',
            data: JSON.stringify(arrObject),
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                if (data.resultCode == "000000") {
                    this.reviceconfigdata(this.currentPath, "");
                    this.showsuccessmessage("批量删除成功");
                } else {
                    this.showerrormessage(data.resultMessage);
                }
            }.bind(this)
        });
    }
}
configManager.prototype.getallcheckpath = function () {
    var arrObject = new Array();
    var userIdVal = $("#userId").val();
    var serviceIdVal = $("#serviceId").val();
    $("input[name='selectFlag']:checkbox").each(function () {
        if (this.checked) {
            var pathValue = configManager.appendpathvalue($(this).val());
            var path = {
                path: pathValue,
                userId:userIdVal,
                serviceId:serviceIdVal
            }
            arrObject.push(path);
        }
    }).bind(configManager);
    return arrObject;
}
/**************************************************     批量导入   *******************************************/
configManager.prototype.uploadFile = function () {
    this.printuploadfile();
    $("#uploadFileBtn").click(function () {
    	var userIdVal = $("#userId").val();
        var serviceIdVal = $("#serviceId").val();
    	var userId = userIdVal + ","+serviceIdVal;
        $.ajaxFileUpload
        ({
                url: _base + '/config/custom/upload/' + userId,
                secureuri: false,
                fileElementId: 'uploadFile',
                success: function (data) {
                    var jsondata = JSON.parse(data.body.innerText);
                    if (jsondata.resultCode == "000000") {
                    	this.reviceconfigdata(this.currentPath, "");
                        this.showsuccessmessage("上传文件成功");
                    } else if(jsondata.resultCode == "666666"){
                    	this.showerrormessage("只支持以.property结尾的文件");
                    }else {
                        this.showerrormessage(jsondata.resultMessage);
                    }
                }.bind(this),
                error: function (data) {
                    this.showerrormessage("上传文件成功,请回退查看。");
                }.bind(this)
            }
        )
    }.bind(this));
    this.bindeventforcenterbtn("centerConfigBtn");
}

configManager.prototype.printuploadfile = function () {
    $.templates({
        uploadFileTmpl: "#uploadFileTmpl"
    });
    $.templates.uploadFileTmpl.link("#datapart", {});
    $("#datapart").removeClass();
    $("#datapart").addClass("Open_cache_list_tow");
}

/**************************************************************************************************************/

configManager.prototype.loaddatacontent = function () {
    $.templates({
        loadingDataTmpl: "#loadingDataTmpl"
    });
    $.templates.loadingDataTmpl.link("#datapart", {});

    $("#datapart").removeClass();
    $("#datapart").addClass("fuw_table");
}

configManager.prototype.appendpathvalue = function (path) {
    var pathvalue = this.currentPath + path;
    if (this.currentPath != this.rootpathvalue) {
        pathvalue = this.currentPath + "/" + path;
    }
    return pathvalue;
}

configManager.prototype.autoincreatecurrentlevel = function () {
    this.currentLevel++;
}

configManager.prototype.setcurrentpath = function (path) {
    this.currentPath = path;
}

configManager.prototype.setcurrentservice = function (serviceId){
	this.currentserviceId = serviceId;
}

configManager.prototype.appendnavhtml = function (parentPath, pathName) {
    $("#navMenu li").eq(-1).before("<li><A href=\"javascript:void(0);\" onclick=\"javascript:configManager.gotolevel('" + parentPath + "'," + this.currentLevel + ")\">" + pathName + "</A>/</li>");
}

configManager.prototype.clearnavmenuhtml = function (level) {
    var index = $("#navMenu li").size();
    while (index != level + 1) {
        $("#navMenu li").eq(-2).remove();
        index = $("#navMenu li").size();
    }
}

configManager.prototype.checkAll = function (element) {
    if (element.checked) {
        $("input[name='selectFlag']:checkbox").each(function () {
            $(this).prop("checked", true);
        })
    } else {
        $("input[name='selectFlag']:checkbox").each(function () {
            $(this).prop("checked", false);
        })
    }
}

configManager.prototype.searchConfig = function () {
    var keyword = $("#keyword").val();
    this.reviceconfigdata(this.currentPath, keyword);
}

configManager.prototype.bindeventforcenterbtn = function (elementId) {
    $("#" + elementId).click(function () {
        this.reviceconfigdata(this.currentPath, "");
    }.bind(this));
}

/****************************************************download 所有配置信息*******************************************/
configManager.prototype.download = function () {
	$("#cancle_back").click();
}

/*****************************************************************************************************************/
configManager.prototype.showError = function (message) {
    $("#pathErrorTest").text(message);
    $("#errorLabel").show();
    this.pagetimeout = window.setTimeout(function () {
        $("#errorLabel").hide();
        window.clearTimeout(this.pagetimeout);
    }, 4 * 1000)
}

configManager.prototype.showerrormessage = function (message) {
    $("#errortext").text(message);
    $("#errormessage").show();
    this.pagetimeout = window.setTimeout(function () {
        $("#errormessage").hide();
        window.clearTimeout(this.pagetimeout);
    }, 4 * 1000)
}

configManager.prototype.showsuccessmessage = function (message) {
    $("#successtext").text(message);
    $("#successmessage").show();
    this.pagetimeout = window.setTimeout(function () {
        $("#successmessage").hide();
        window.clearTimeout(this.pagetimeout);
    }, 4 * 1000)
}