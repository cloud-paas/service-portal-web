//获取contextpath
//function getContextPath() {
//	//获取当前网址，如： http://localhost:8080/payweb/inedx.jsp
//    var curWwwPath=window.document.location.href;
//    alert(curWwwPath);
//	var pathName = document.location.pathname;
//	alert(pathName);
//	var index = pathName.substr(1).indexOf("/");
//	alert(index);
//	var result = pathName.substr(0, index + 1);
//	alert(result);
//	return result;
//}

/**
 * @author renfeng
 * 
 * js获取项目根路径 如： http://localhost:8080/payweb
 * 
 * @returns object
 */
function getContextPath(){
    //获取当前网址，如： http://localhost:8080/payweb/inedx.jsp
    var curWwwPath=window.document.location.href;
    //获取主机地址之后的目录，如： payweb/inedx.jsp
    var pathName=window.document.location.pathname;
    var pos=curWwwPath.indexOf(pathName);
    //获取主机地址，如： http://localhost:8080
    var localhostPaht=curWwwPath.substring(0,pos);
    //获取带"/"的项目名，如：/payweb
    var projectName=pathName.substring(0,pathName.substr(1).indexOf('/')+1);
    if(projectName=='/iPaas-Portal'){
    	return localhostPaht+projectName;
    }
    return localhostPaht;
}

// 发送POST请求 PARAMS 参数数组 {a:aValue, b:bValue}
function postRequest(URL, PARAMS) {
	var temp = document.createElement("form");
	temp.action = URL;
	temp.method = "post";
	temp.style.display = "none";
	for ( var x in PARAMS) {
		var opt = document.createElement("textarea");
		opt.name = x;
		opt.value = PARAMS[x];
		temp.appendChild(opt);
	}
	document.body.appendChild(temp);
	temp.submit();
	return temp;
}

$(function() {
	window.Modal = function() {
		var reg = new RegExp("\\[([^\\[\\]]*?)\\]", 'igm');
		var alr = $("#ycf-alert");
		var ahtml = alr.html();
		var _alert = function(options) {
			alr.html(ahtml); // 复原
			alr.find('.ok').removeClass('btn-success').addClass('btn-primary');
			alr.find('.cancel').hide();
			_dialog(options);
			return {
				on : function(callback) {
					if (callback && callback instanceof Function) {
						alr.find('.ok').click(function() {
							callback(true)
						});
					}
				}
			};
		};
		var _confirm = function(options) {
			alr.html(ahtml); // 复原
			alr.find('.ok').removeClass('btn-primary').addClass('btn-success');
			alr.find('.cancel').show();
			_dialog(options);
			return {
				on : function(callback) {
					if (callback && callback instanceof Function) {
						alr.find('.ok').click(function() {
							callback(true)
						});
						alr.find('.cancel').click(function() {
							callback(false)
						});
					}
				}
			};
		};
		var _dialog = function(options) {
			var ops = {
				msg : "提示内容",
				title : "操作提示",
				btnok : "确定",
				btncl : "取消"
			};
			$.extend(ops, options);
			console.log(alr);
			var html = alr.html().replace(reg, function(node, key) {
				return {
					Title : ops.title,
					Message : ops.msg,
					BtnOk : ops.btnok,
					BtnCancel : ops.btncl
				}[key];
			});
			alr.html(html);
			alr.modal({
				width : 500,
				backdrop : 'static'
			});
		}
		return {
			alert : _alert,
			confirm : _confirm
		}
	}();
});