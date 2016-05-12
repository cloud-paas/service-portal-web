function configManager() {
	this.currentPath = "/";
	this.currentLevel = 1;
	this.pagetimeout;
	// 1 -- readyonly
	// 2 -- writable
	this.currentFlag;
	//constant variables
	this.rootpathvalue = "/";
	this.rootlevelvalue = 1;
	//editor variables;
	this.editor;
}

/**************************************************进入根节点，孩子节点，当行链接跳转*******************************************/
//进入root级别
configManager.prototype.gotoroot = function(parentPath, level) {
	this.clearnavmenuhtml(level);
	this.currentLevel = level;
	this.initdataconfig();
	this.flags = 0;
};
//进入子页面
configManager.prototype.gotochild = function(path) {
	var pathValue = this.appendpathvalue(path);
	this.autoincreatecurrentlevel();
	this.reviceconfigdata(pathValue, "");
	this.appendnavhtml(pathValue, path);
	this.currentPath = pathValue;
};
//进入只读子路径页面
configManager.prototype.gotoReadonlyChild = function(path) {
	var pathValue = this.appendpathvalue(path);
	this.currentFlag = 1;
	this.autoincreatecurrentlevel();
	this.reviceconfigdata("/", "");
	this.appendnavhtml(pathValue, path);
};
//进入可写子路径页面
configManager.prototype.gotoWritableChild = function(path) {
	var pathValue = this.appendpathvalue(path);
	this.currentFlag = 2;
	this.autoincreatecurrentlevel();
	this.reviceconfigdata("/", "");
	this.appendnavhtml(pathValue, path);
};
//进入当行的下一级别
configManager.prototype.gotolevel = function(parentPath, level) {
	if (level == 2) {
		parentPath = "/";
	}
	this.reviceconfigdata(parentPath, "");
	this.clearnavmenuhtml(level);
	this.setcurrentpath(parentPath);
	this.currentLevel = level;
};

/**************************************************    显示数据     *******************************************/
//接收配置数据
configManager.prototype.reviceconfigdata = function(path, keyword) {
	clearTimeout(this.pagetimeout);
	$("#keyword").val("");
	this.loaddatacontent();
	var data = {
		path : path,
		keyword : keyword,
		flags : this.currentFlag
	};
	$.ajax({
		type : 'POST',
		url : _base + '/config/maintain/listSubPath',
		data : data,
		dataType : 'json',
		success : function(data) {
			if (data.resultCode == "000000") {
				if (keyword != '' && keyword != null) {
					var dataCache = new Array();
					$.each(data.data, function(n, value) {
						if (value.path.indexOf(keyword) != -1) {
							dataCache.push(value);
						}
					});
					data.data = dataCache;
				}
				configManager.printconfig(data);
			} else {
				configManager.showerrormessage(data.resultMessage);
			}
		}
	});
};
//格式化数据的形式
configManager.prototype.formatvalue = function(data, defaultvalue) {
	var result;
	if (data != null) {
		result = {
			resultList : data
		};
	} else {
		result = {
			resultList : defaultvalue
		};
	}
	return result;
};
//显示配置HTML页面
configManager.prototype.printconfig = function(data) {
	$.templates({
		datapartTmpl : "#datapartTmpl"
	});
	var result = this.formatvalue(data.data, []);
	$.templates.datapartTmpl.link("#datapart", result);
	$("#datapart").removeClass();
	$("#datapart").addClass("fuw_table xing_zx_lis");
};

/**************************************************    增加     *******************************************/
//初始化增加配置值
configManager.prototype.initaddconfigvalue = function() {
	var container = document.getElementById('jsonContent');
	var options = {
		mode : 'text',
		modes : [ 'text', 'tree', 'view' ,'code'], // allowed modes
		onError : function(err) {
			configManager.showerrormessage("输入的值必须是JSON格式的数据");
		}
	};
	var addEditor = new JSONEditor(container, options);
	addEditor.set({});
	this.editor = addEditor;
	return addEditor;
};
//增加配置
configManager.prototype.addConfig = function() {
	this.printaddcontent();
	var addConfigForm = this.validateAddConfig("addConfigForm");
	var editor = this.initaddconfigvalue();
	$("#addConfigBtn").click(function() {
		if (addConfigForm.valid()) {
			/*try {
				var dataValue = editor.get();
				var text = JSON.stringify(dataValue);
				console.log(text);
			} catch (exception) {
				this.showerrormessage("必须输入JSON格式数据的值");
				return false;
			}*/
			this.postaddconfigrequest($("#configpath").val(), editor);
		}
	}.bind(this));
	this.bindeventforcenterbtn("centerConfigBtn");
};
//增加配置请求
configManager.prototype.postaddconfigrequest = function(path, editor) {
	var indexchar = path.substr(0, 1);
	var subPathValue = path;
	if (indexchar == "/")
		subPathValue = subPathValue.substr(1);
	var pathValue = this.appendpathvalue(subPathValue);
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
		flags : this.currentFlag
	};
	$.ajax({
		type : 'POST',
		url : _base + '/config/maintain/add',
		dataType : 'json',
		data : data,
		success : function(data) {
			if (data.resultCode == "000000") {
				this.reviceconfigdata(this.currentPath, "");
			} else {
				this.showerrormessage(data.desc);
			}
		}.bind(this)
	});
};
//验证增加配置
configManager.prototype.validateAddConfig = function(formName) {
	var addConfigForm = $("#" + formName);
	addConfigForm.validate({
		rules : {
			configpath : {
				required : true
			}
		},
		success : function(label, element) {
			$(element).removeAttr("style");
		},
		errorPlacement : function(error, element) {
			$(element).css("border-color", "rgb(249, 135, 135)");
		},
		submitHandler : function() {
			configserverregister.valid();
		}
	});
	return addConfigForm;
};
//弹出增加节点路径
configManager.prototype.printaddcontent = function() {
	$.templates({
		addConfigTmpl : "#addConfigTmpl"
	});
	$.templates.addConfigTmpl.link("#datapart", {});
	$("#datapart").removeClass();
	$("#datapart").addClass("Open_cache_list_tow");
};
/**************************************************    删除     *******************************************/
//删除配置
configManager.prototype.delConfig = function(pathValue) {
	var data = {
			path : pathValue,
			flags : this.currentFlag
		};
	$.ajax({
		type : 'POST',
		url : _base + '/config/maintain/delete',
		dataType : 'json',
		data : data,
		success : function(data) {
			if (data.resultCode == "000000") {
				this.reviceconfigdata(this.currentPath, "");
			} else {
				configManager.showerrormessage(data.resultMessage);
			}
		}.bind(this)
	});
};
//绑定删除按钮事件
configManager.prototype.bindDeleteEventBtn = function(elementId,pathValue) {
	$("#" + elementId).click(function() {
		this.delConfig(pathValue);
	}.bind(this));
};
/**************************************************    修改     *******************************************/
//编辑配置
configManager.prototype.editConfig = function(path) {
	var pathValue = this.appendpathvalue(path);
	var data = {
		path : pathValue,
		flags : this.currentFlag
	};
	$.ajax({
		type : 'POST',
		url : _base + '/config/maintain/get',
		dataType : 'json',
		data : data,
		success : function(data) {
			this.printdetailcontent(data.data, pathValue);
			var editorEditor = this.appendjsonview(data.data);
			this.bindeventforjsoncontentvalue();
			this.bindeventforcenterbtn("centerConfigBtn");
			this.bindDeleteEventBtn("deleteConfigBtn",pathValue);
			$("#editConfigBtn").click(function() {
				try {
					var json = JSON.stringify(editorEditor.get());
				} catch (exception) {
					this.showerrormessage("输入的值必须是JSON格式的数据");
					return;
				}
				this.modifyconfig(editorEditor);
			}.bind(this));
		}.bind(this)
	});
};
//修改配置
configManager.prototype.modifyconfig = function(editorEditor) {
	var pathValue = $("#pathValue").text();
	var pathData = editorEditor.get();
	var text = JSON.stringify(pathData);
	var data = {
		path : pathValue,
		flags : this.currentFlag,
		data : text
	};
	$.ajax({
		type : 'POST',
		url : _base + '/config/maintain/modify',
		dataType : 'json',
		data : data,
		success : function(data) {
			if (data.resultCode == "000000") {
				this.reviceconfigdata(this.currentPath, "");
			} else {
				this.showerrormessage(data.resultMessage);
			}
		}.bind(this)
	});
};
configManager.prototype.appendjsonview = function(data) {
	try {
		var json;
		if(data!=''&&data!=undefined&&data!=null){
			try{
				json = JSON.parse(data);
			}catch(e){
				var resultData = data.replace(/'/g,"\"");
				try{
					json = JSON.parse(resultData);
				}catch(e){
					json = resultData;
				}	
			}			
		}else{
			json = {};		
		}
		var container = document.getElementById('jsonContent');
		var options = {
			mode : 'text',
			modes : [ 'text', 'tree', 'view','code' ], // allowed modes
			error : function(err) {
				configManager.showerrormessage("输入的值必须是JSON格式的数据");
			}
		};
		var addEditor = new JSONEditor(container, options);
		addEditor.set(json);
		return addEditor;
	} catch (ex) {
	}
};
configManager.prototype.bindeventforjsoncontentvalue = function() {
	var opt = {
		change : function(data) {
			try {
				$("#jsoncontentvalue").val(JSON.stringify(data));
			} catch (ex) {
			}
		}
	};
	$("#jsoncontentvalue").bind('input propertychange', function() {
		try {
			$('#jsonContent').jsonEditor(JSON.parse($(this).val()), opt);
		} catch (ex) {
			//Do nothing
			$('#jsonContent').empty();
		}
	});
};
//编辑的时候显示详细内容页面
configManager.prototype.printdetailcontent = function(data, pathValue) {
	$.templates({
		editConfigTmpl : "#editConfigTmpl"
	});
	var result = {
		path : pathValue,
		data : data
	};
	$.templates.editConfigTmpl.link("#datapart", result);
	$("#datapart").removeClass();
	$("#datapart").addClass("Open_cache_list_tow");
};
/*****************************************************     导航变化    ******************************************/
//自动增加当前级别
configManager.prototype.autoincreatecurrentlevel = function() {
	this.currentLevel++;
};
//增加导航html页面
configManager.prototype.appendnavhtml = function(parentPath, pathName) {
	$("#navMenu li")
			.eq(-1)
			.before(
					"<li><A href=\"javascript:void(0);\" onclick=\"javascript:configManager.gotolevel('"
							+ parentPath
							+ "',"
							+ this.currentLevel
							+ ")\">"
							+ pathName + "</A>/</li>");
};

//删除导航级别
configManager.prototype.clearnavmenuhtml = function(level) {
	var index = $("#navMenu li").size();
	while (index != level + 1) {
		$("#navMenu li").eq(-2).remove();
		index = $("#navMenu li").size();
	}
};
/**************************************************************************************************************/
//初始化数据配置
configManager.prototype.initdataconfig = function() {
	$.templates({
		initDataPartImpl : "#initDataPartImpl"
	});
	$.templates.initDataPartImpl.link("#datapart", {});
	$("#datapart").removeClass();
	$("#datapart").addClass("fuw_table xing_zx_lis");
};
//加载等待页面
configManager.prototype.loaddatacontent = function() {
	$.templates({
		loadingDataTmpl : "#loadingDataTmpl"
	});
	$.templates.loadingDataTmpl.link("#datapart", {});
	$("#datapart").removeClass();
	$("#datapart").addClass("fuw_table xing_zx_lis");
};
//得到当前路径
configManager.prototype.appendpathvalue = function(path) {
	var pathvalue = this.currentPath + path;
	if (this.currentPath != this.rootpathvalue) {
		pathvalue = this.currentPath + "/" + path;
	}
	return pathvalue;
};
//设置当前路径
configManager.prototype.setcurrentpath = function(path) {
	this.currentPath = path;
};
//查询方法
configManager.prototype.searchConfig = function() {
	var keyword = $("#keyword").val();
	this.reviceconfigdata(this.currentPath, keyword);
};
// 取消按钮返回事件
configManager.prototype.bindeventforcenterbtn = function(elementId) {
	$("#" + elementId).click(function() {
		this.reviceconfigdata(this.currentPath, "");
	}.bind(this));
};
/***********************************************展示成功，展示失败信息************************************************/

//展示错误信息
configManager.prototype.showerrormessage = function(message) {
	$("#errortext").text(message);
	$("#errormessage").show();
	this.pagetimeout = window.setTimeout(function() {
		$("#errormessage").hide();
		window.clearTimeout(this.pagetimeout);
	}, 2 * 1000);
};

//展示成功信息
configManager.prototype.showsuccessmessage = function(message) {
	$("#successtext").text(message);
	$("#successmessage").show();
	this.pagetimeout = window.setTimeout(function() {
		$("#successmessage").hide();
		window.clearTimeout(this.pagetimeout);
	}, 2 * 1000);
};
