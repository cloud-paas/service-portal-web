/**
 * ajax post提交
 * url 必须提供不可为空 提交的url
 * param 必须提供可以为空 提交的url参数
 * successMsg 非必须 成功之后展示的信息
 * toUrl 非必须 成功之后跳转的url
 * btId 非必须 响应之前需要防止重复提交 disable的按钮id
 */
function ajaxSubmit_my(url,param,successMsg,toUrl,btId) {
	var tips = $.dialog.tips('稍等片刻...', 6, 'loading.gif');
	$.ajax({
		async : false,
		type : "POST",
		url : url,
		modal : true,
		showBusi : false,
		data : param,
		success : function(data) {
			tips.close();
			var jsonData=$.parseJSON(data);
			if(jsonData.RES_RESULT==="SUCCESS"){
				if(successMsg){
					if(toUrl){
						$.dialog.tips(successMsg+',~正在跳转...',2, 'loading.gif',function(){
							location.href=toUrl;
						});
					}else{
						$.dialog.tips(successMsg,2, 'loading.gif',function(){
						});
					}
				}else{
					if(toUrl){
						location.href=toUrl;
					}
				}
			}else if(jsonData.RES_RESULT==="FAILED"){
				$.dialog.tips(jsonData.RES_MSG,2, 'loading.gif',function(){
				});
				$("#"+btId).removeClass("disabled");
			}else{
				$.dialog.tips(jsonData.RES_MSG,2, 'loading.gif',function(){
				});
				$("#"+btId).removeClass("disabled");
			}
			return false;
		}
	});
	return false;
}
/**
 * ajax post提交
 * url 必须提供不可为空 提交的url
 * param 必须提供可以为空 提交的url参数
 * successMsg 非必须 成功之后展示的信息
 * toUrl 非必须 成功之后跳转的url
 * btId 非必须 响应之前需要防止重复提交 disable的按钮id
 */
function ajaxSubmitAsync_my(url,param,successMsg,toUrl,btId) {
	var tips = $.dialog.tips('稍等片刻...', 30, 'loading.gif');
	$.ajax({
		async : true,
		type : "POST",
		url : url,
		modal : true,
		showBusi : false,
		data : param,
		success : function(data) {
			tips.close();
			var jsonData=$.parseJSON(data);
			if(jsonData.RES_RESULT==="SUCCESS"){
				if(successMsg){
					if(toUrl){
						$.dialog.tips(successMsg+',~正在跳转...',2, 'loading.gif',function(){
							location.href=toUrl;
						});
					}else{
						$.dialog.tips(successMsg,2, 'loading.gif',function(){
						});
					}
				}else{
					if(toUrl){
						location.href=toUrl;
					}
				}
			}else if(jsonData.RES_RESULT==="FAILED"){
				$.dialog.tips(jsonData.RES_MSG,2, 'loading.gif',function(){
				});
				$("#"+btId).removeClass("disabled");
			}else{
				$.dialog.tips(jsonData.RES_MSG,2, 'loading.gif',function(){
				});
				$("#"+btId).removeClass("disabled");
			}
			return false;
		}
	});
	return false;
}
/**
 * ajax get获取DIV
 * url 必须提供不可为空 提交的url
 * param 必须提供可以为空 提交的url参数
 * sourceDivId 必须提供不可为空 加载div的容器ID
 */
function ajaxGetDiv_my(url,param,sourceDivId) {
	var tips = $.dialog.tips('~正在努力加载...', 6, 'loading.gif');
	$.ajax({
		async : false,
		type : "GET",
		url : url,
		modal : true,
		showBusi : false,
		data : param,
		success : function(data) {
			$("#"+sourceDivId).html(data);
			tips.close();
			return false;
		}
	});
	return false;
}
/**
 * 全选
 */
function select_all(d,checkboxName){
	if($(d).is(":checked")){
		$("input[name='"+checkboxName+"']").attr("checked",true);
	}else{
		$("input[name='"+checkboxName+"']").attr("checked",false);
	}
}
/**
 * 反选
 */
function deselect_all(checkboxName){
	$("input[name='"+checkboxName+"']").each(function(i,d){
		if($(d).is(":checked")){
			$(d).attr("checked",false);
		}else{
			$(d).attr("checked",true);
		}
	});
}
/**
 * 链接跳转
 */
function locationGo(url){
	location.href=url;
	return false;
}
/**
 * 写cookies
 */
function setCookie(name,value)
{
    var Days = 30;
    var exp = new Date();
    exp.setTime(exp.getTime() + Days*24*60*60*1000);
    document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}
/**
 * 读取cookies
 */
function getCookie(name)
{
    var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
 
    if(arr=document.cookie.match(reg))
 
        return unescape(arr[2]);
    else
        return null;
}
/**
 * 删除cookies
 */
function delCookie(name)
{
    var exp = new Date();
    exp.setTime(exp.getTime() - 1);
    var cval=getCookie(name);
    if(cval!=null)
        document.cookie= name + "="+cval+";expires="+exp.toGMTString();
} 
function subText(){
	$("td[name='subText']").each(function(i,d){
		var subSize = parseInt($(d).attr("subSize"));
		var text = $(d).text();
		if(text.length > subSize){
			$(d).text(text.substring(0,subSize));
			$(d).attr("title",text);
		}
	});
}
$(function(){
	subText();
});