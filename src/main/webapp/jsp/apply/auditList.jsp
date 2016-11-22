<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.ai.paas.ipaas.storm.sys.utils.StringUtils"%>
<%@page import="com.ai.paas.ipaas.system.constants.ConstantsForSession"%>
<%@page import="com.ai.paas.ipaas.user.vo.UserInfoVo"%>
<%
   
HttpSession Session = request.getSession();
UserInfoVo userInfo = (UserInfoVo) Session.getAttribute(ConstantsForSession.LoginSession.USER_INFO);
if (userInfo != null&& !StringUtils.isBlank(userInfo.getUserName())) {
	String userName = userInfo.getUserName();
	request.setAttribute("userName", userName);
}
String baseLocation = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
request.setAttribute("basePath", basePath);
request.setAttribute("_base", basePath);

%>
<head>
<%@ include file="/jsp/common/common.jsp"%>
<script src="${_base }/resources/js/common/prod_param_transfer.js"></script>
<script type="text/javascript">
var userName = "${userName}";
var _base = "${_base}";
var basePath = "${basePath}"
	$(document).ready(function() {
			if (userName != "") {
				$("#loginName").text("");
				$("#loginName").append(userName);
			}
			
			paging(1);
			
			$('#audit_through').click(function() {
				var orderDetailIdList = [];
				var prodTypeList = [];
				$('input[id^="checkboxFiveInput"]').each(function() {
					if ($(this).is(':checked')) {
						orderDetailIdList.push($(this).val());
						prodTypeList.push($("#prodType_"+$(this).val()).val());
					}
				});
				if (orderDetailIdList.length == 0) {
					$("#errorMessage").text("");					
					$("#errorMessage").append('尚未选中任何订单，请至少选择一个！');
					$("#errorMessageDia").show();
					return;
				}
				var indexOf = prodTypeList.indexOf('2');						
					$("#audit_through").attr({"disabled":"disabled"});
					$("#audit_dismissed").attr({"disabled":"disabled"});
					$('.waitCover').show();
					$.ajax({
						type : 'POST',
						url : '${_base}/apply/approveApply',
						dataType : 'json',
						data : {
							orderDetailIdList : orderDetailIdList.join(','),
							checkResult : 1
						},
						beforeSend : function() {
							$('#loader').shCircleLoader({
							// 设置加载颜色
								color : '#F0F0F0'
							});
						},
						success : function(data) {
							if (data.resultCode == '000000') {
								// 重新加载当前页数据
								paging(1);
								$('.waitCover').hide();
							} else {
								$("#errorMessage").text("");					
								$("#errorMessage").append(data.resultMessage);
								$("#errorMessageDia").show();
								$('.waitCover').hide();
							}
						},
						complete : function() {
							$('#loader').shCircleLoader('destroy');
							$('.waitCover').hide();
						},
						error : function() {
							$("#errorMessage").text("");					
							$("#errorMessage").append('系统发生异常，开通失败，请稍后再试！');
							$("#errorMessageDia").show();
							$('.waitCover').hide();
						}

					});
				
			}); 
			
			// 弹出不通过对话框
			$('#audit_dismissed').click(function() {				
				var orderDetailIdList = [];
				$('input[id^="checkboxFiveInput"]').each(function() {
					if ($(this).is(':checked')) {
						orderDetailIdList.push($(this).val());
					}
				});
				if (orderDetailIdList.length == 0) {
					$("#errorMessage").text("");					
					$("#errorMessage").append('尚未选中任何订单，请至少选择一个！');
					$("#errorMessageDia").show();
					return;
				}  
				$('#suggestion').val('');
				$('#suggestionLabel').text('');
				$('#myModal').modal();				
			});
			
			$('#dismissedSure').click(function() {
					var suggestion = $('#suggestion').val();
					if (!suggestion) {
						$('#suggestionLabel').text('审核意见为必填项！');
						return;
					}
					if (suggestion.length > 150) {
						$('#suggestionLabel').text('意见字数不能超过150字。');
						return;
					}
					var orderDetailIdList = [];
					$('input[id^="checkboxFiveInput"]').each(function() {
						if ($(this).is(':checked')) {
							orderDetailIdList.push($(this).val());
						}
					});
					if (orderDetailIdList.length == 0) {
						$("#errorMessage").text("");					
						$("#errorMessage").append('尚未选中任何订单，请至少选择一个！');
						$("#errorMessageDia").show();
						return;
					}
					$("#dismissedSure").attr({"disabled":"disabled"});
					$("#cancel_apply").attr({"disabled":"disabled"});
					$.ajax({
						type : 'POST',
						url : '${_base}/apply/approveApply',
						dataType : 'json',
						data : {
							orderDetailIdList : orderDetailIdList.join(','),
							suggestion : suggestion,
							checkResult : 2
						},
						success : function(data) {
							if (data.resultCode == '000000') {
								paging(1);
							} else {
								$("#errorMessage").text("");					
								$("#errorMessage").append(data.resultMessage);
								$("#errorMessageDia").show();
							}
						},
						complete : function() {
							$('#myModal').modal('hide');
						},
						error : function() {
							$("#errorMessage").text("");					
							$("#errorMessage").append('系统异常，处理失败，请稍后再试！');
							$("#errorMessageDia").show();
							$('#myModal').modal('hide');
						}
		
					});
			});			
			
			$('#iaasAudit').click(function() {
				var ip = $('#ip').val();
				var userName = $('#userName').val();
				var pwd = $('#pwd').val();
				var errorFlag = false;
				if (!ip) {
					errorFlag = true;
					$('#ipErrorLabel').text('必填项');
				}
				if (!userName) {
					errorFlag = true;
					$('#userNameErrorLabel').text('必填项');
				}
				if (!pwd) {
					errorFlag = true;
					$('#pwdErrorLabel').text('必填项');
				}
				if(errorFlag){
					return;
				}	
				var orderDetailIdList = [];
				$('input[id^="checkboxFiveInput"]').each(function() {
					if ($(this).is(':checked')) {
						orderDetailIdList.push($(this).val());
					}
				});
				if (orderDetailIdList.length == 0) {
					$("#errorMessage").text("");					
					$("#errorMessage").append('尚未选中任何订单，请至少选择一个！');
					$("#errorMessageDia").show();
					return;
				}
			 	$("#iaasAudit").attr({"disabled":"disabled"});
				$("#iaasAuditCancle").attr({"disabled":"disabled"}); 
				$.ajax({
					type : 'POST',
					url : '${_base}/apply/iaasAudit',
					dataType : 'json',
					data : {
						orderDetailIdList : orderDetailIdList.join(','),
						ip : ip,
						userName : userName,
						pwd : pwd,
						checkResult : 1
					},
					success : function(data) {
						if (data.resultCode == '000000') {
							paging(1);
						} else {
							$("#errorMessage").text("");					
							$("#errorMessage").append(data.resultMessage);
							$("#errorMessageDia").show();
							
						}
					},
					complete : function() {
						$('#iaasModal').modal('hide');
					},
					error : function() {
						$("#errorMessage").text("");					
						$("#errorMessage").append('系统异常，处理失败，请稍后再试！');
						$("#errorMessageDia").show();
						$('#iaasModal').modal('hide');
					}	
				});
 
		});
			
		$("#ip").click(function(){					 
			$("#ipErrorLabel").text("");
		});
		$("#userName").click(function(){					
			$("#userNameErrorLabel").text("");
		});
		$("#pwd").click(function(){
			$("#pwdErrorLabel").text("");
		});
		
		
		$('#errorMessageDia').draggable({ containment: '.big_k', scroll: false });
		//({ containment: '#containment-wrapper', scroll: false });//
			
	});
	
	function paging(page) {
		disabledCancle();
		$.ajax({
					type : "POST",
					url : "${_base}/apply/queryApplyAuditList",
					dataType : "json",
					data : {
						page : page
					},
					beforeSend : function(XMLHttpRequest) {
						$('.fenye').css('display', 'none');
						$("#table_detail tbody").empty();
						$('#loading').shCircleLoader({
							// 设置加载颜色
							color : '#F0F0F0'
						});
					},
					success : function(msg) {
						if (msg.resultCode == '0000') {
							if (msg.pageResult.resultList.length == 0) {
								$("#table_detail tbody").empty();
								var html = '';
								html += '<tr>';
									html += '<th>申请单号</th>';
									html += '<th>类型</th>';
									html += '<th>产品信息</th>';
									html += '<th>申请部门</th>';
									html += '<th>申请联系方式</th>';
									html += '<th>审核状态</th>';
									html += '<th>申请时间</th>';
								html += '</tr>';
								html += '<tr>';		
									html += '<td colspan="7">没有需要审核的申请单</td>';								
								html += '</tr>';
								$('#table_detail').append(html)
								return;
							}
							var options = {
								bootstrapMajorVersion : 3,
								currentPage : msg.pageResult.currentPage,//当前页面
								numberOfPages : 10,//一页显示几个按钮（在ul里面生成5个li）
								totalPages : msg.pageResult.totalPages
							//总页数
							}
							loadData(msg.pageResult.resultList);
							$('#pageUl').bootstrapPaginator(options);
						} else {
							$("#table_detail tbody").empty();
							var html = '';
							html += '<tr>';
								html += '<th>申请单号</th>';
								html += '<th>类型</th>';
								html += '<th>产品信息</th>';
								html += '<th>申请部门</th>';
								html += '<th>申请联系方式</th>';
								html += '<th>审核状态</th>';
								html += '<th>申请时间</th>';
							html += '</tr>';
							html += '<tr>';		
								html += '<td colspan="7">查询申请单异常</td>';								
							html += '</tr>';
							$('#table_detail').append(html)
							return;
						}
					},
					complete : function(XMLHttpRequest, textStatus) {
						$('.fenye').css('display', 'block');
						$('#loading').shCircleLoader('destroy');
					},
					error : function() {
						$("#errorMessage").text("");					
						$("#errorMessage").append('系统发生异常，数据加载失败，请登陆后重新尝试！');
						$("#errorMessageDia").show();
						$('.fenye').css('display', 'none');
					}
				});
	}
	
	function loadData(obj) {
		if (!!obj && obj.length == 0) {
			$("#table_detail tbody").empty();
			var html = '';
			html += '<tr>';
				html += '<th>申请单号</th>';
				html += '<th>类型</th>';
				html += '<th>产品信息</th>';
				html += '<th>申请部门</th>';
				html += '<th>申请联系方式</th>';
				html += '<th>审核状态</th>';
				html += '<th>申请时间</th>';
			html += '</tr>';
			html += '<tr>';		
				html += '<td colspan="7">没有需要审核的申请单</td>';								
			html += '</tr>';
			$('#table_detail').append(html)
			return;
		}
		$("#table_detail tbody").empty();
		var html = '';
		html += '<tr>';
			html += '<th>申请单号</th>';
			html += '<th>类型</th>';
			html += '<th>产品信息</th>';
			html += '<th>申请部门</th>';
			html += '<th>申请联系方式</th>';
			html += '<th>审核状态</th>';
			html += '<th>申请时间</th>';
		html += '</tr>';
		$.each(obj,function(n, item) {
				html += '<tr>';
					// 复选框
					html += '<td width="8%">';
						html += '<table width="100%" border="0">';
							html += '<tr>';
								html += ' <td width="47%" align="right" style=" border:none;">';
										html += '<input  type="checkbox" value="'+ item.orderDetailId +'" id="checkboxFiveInput_'+item.orderDetailId+'" onclick=checkIaas("'+ item.prodType+'","'+ item.orderDetailId+'"); >';
										html += '<input  type="hidden"   value="'+ item.prodType +'" id="prodType_'+item.orderDetailId+'"  >';
										html += '<input  type="hidden"   value="'+ item.prodId +'" id="prodId_'+item.orderDetailId+'"  >';
								html +='</td>';
								html += '<td width="53%" align="left" style=" border:none;">'+item.orderDetailId+'</td>';
							html += '</tr>';
						html += '</table>';
					html += '</td>';
					
					html += '<td width="8%">'+operateTypeTransfer(item.operateType)+'</td>';
					
					html += '<td width="28%">';
						html += '<table width="100%" border="0">';
							html += '<tr>';
								html += '<td style=" border:none;">'+prodNameTransfer(item.prodByname)+'</td>';
							html += '</tr>';
							
							html += '<tr>';
								html += '<td  style=" border:none;">'+prodParamTransfer(item.prodParam) +'</td>';
							html += '</tr>';
						html += '</table>';
					html += '</td>';
					
					
					
					html += '<td width="12%">'+item.userOrgName+'</td>';
					
					html += '<td width="15%">';
						html += '<table width="100%" border="0">';
							html += '<tr>';
								html += '<td style=" border:none;">'+item.userPhoneNum+'</td>';
							html += '</tr>';
							html += '<tr>';
								html += '<td  style=" border:none;">'+item.userEmail+'</td>';
							html += '</tr>';
						html += '</table>';
					html += '</td>';
					
					html += '<td width="12%">'+stateTransfer(item.orderCheckStatus)+'</td>';
					html += '<td width="20%">' + _format(item.orderAppDate)	+ '</td>';	
				html += '</tr>';
				
		});
		$('#table_detail tbody').append(html);		
	}
	var iassFlag = false;
	function checkIaas(prodType,orderDetailId) {
		var orderDetailIdList = [];
		var prodTypeList = [];
		$('input[id^="checkboxFiveInput"]').each(function() {
			if ($(this).is(':checked')) {				
				orderDetailIdList.push($(this).val());				
				prodTypeList.push($("#prodType_"+$(this).val()).val());
			}
		});
		
	}
	function _format(dateStr) {
		var date = new Date(dateStr);
		var fmt = 'yyyy-MM-dd hh:mm:ss';
		var o = {
		        "M+": date.getMonth() + 1, //月份 
		        "d+": date.getDate(), //日 
		        "h+": date.getHours(), //小时 
		        "m+": date.getMinutes(), //分 
		        "s+": date.getSeconds(), //秒 
		        "q+": Math.floor((date.getMonth() + 3) / 3), //季度 
		        "S": date.getMilliseconds() //毫秒 
		    };
		if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (date.getFullYear() + "").substr(4 - RegExp.$1.length));
	    for (var k in o)
	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
		return fmt;
	}
	
	function hideErrorMessageDia() {
		$("#errorMessage").text("");					
		$("#errorMessageDia").hide();
		disabledCancle();	
		var current_page = $('ul li.active a').text();
		paging(current_page);
		
	}
	
	function disabledCancle() {		
		$("#audit_through").removeAttr("disabled");
		$("#audit_dismissed").removeAttr("disabled");
		$("#dismissedSure").removeAttr("disabled");
		$("#cancel_apply").removeAttr("disabled");		
		$("#iaasAudit").removeAttr("disabled");
		$("#iaasAuditCancle").removeAttr("disabled");		
	}
	
function words_deal() 
{ 
	var curLength=$("#suggestion").val().length; 
	if(curLength>150){ 
		var num=$("#suggestion").val().substr(0,150); 
		$("#suggestion").val(num); 
		$("#textCount").text('审核意见最多150个字！您已经输入150字');
		$("#textCount").attr("style","color: #FF0000;");
		
	} 
	else{ 
		var limitNum = 150 - curLength;
		var limitstr = "您还可以输入"+limitNum+"个字";
		$("#textCount").text(limitstr); 
		$("#textCount").css("color", "");
	} 
} 

function changeHref() 
{   var base = "${_base}";
    var basePath = "${basePath}";
	if(base==null || ""==base ){
		location.href = basePath;
	}else{
		location.href = base;
	}
		
}

</script>  
  </head> 
  <body>  
  <!-- 遮盖层   -->
  <div class="waitCover" >
	 <img  src="${_base }/resources/images/waitPng.png" class="waitPng" >
	 <div class="waitTxt">正在加载请稍后...</div>
  </div>   
  <div class="big_k"><!--包含头部 主体-->   
   <!--导航-->
   <div class="navigation" style="background:rgb(22,154,219); height:70px">
  <div class="head">
				<div style="width: 100%; height: auto">
					<div style="float: left; width: 13%; position: relative; left: 3%">
						<img src="${_base }/resources/images/logo-white2.png"
							style="position: relative; margin: 20px 20px 0px 0px;height:35px">
					</div>
					<div class="mune_lan"  style="padding-top:1.5%;">
						<ul>
                        <li  class="yon_wnz" style="margin-left:20px;font-size:20px;margin-top:0px;" ><a href="#" onclick="changeHref()" title="返回首页"><img style="height:30px;padding-bottom:5px"  src="${_base }/resources/images/return.png"/></a></li> 
						<li class="yon_wnz"   style="padding-bottom:5px;margin-left:40px;font-size:20px;">服务申请审核</li> 
						</ul>
						<ul style="float:right">
							<li id="loginName" class="yonhz"></li>   
						</ul>
					</div> 
				</div>
			</div>
   </div>
   
   <div class="container chanp">
   
  <div class="row chnap_row">
  <div class="col-md-6 left_list" >
      <div class="list_groups">
             <div class="list_groups_none">
              <ul>
             <li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(6,2,this);">
             <a href="#" style="color:#fff">
             <p  id="img2">服务申请审核</p>
             </a>
             </li>
             <li class="list_xinx"  id="content2" >
             <p class="xuanz"><A href="${_base }/apply/applyAudit"><span style="margin-top:2px;">服务申请审核</span></A></p>
             </li>
             </ul>
             <ul>
             <li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(6,3,this);">
             <a href="#" style="color:#fff">
             <p  id="img2">组织管理</p>
             </a>
             </li>
             <li class="list_xinx"  id="content3" >
             <p class="xuanz"><A href="${_base }/orgConsole/toOrgConsole"><span style="margin-top:2px;">组织管理</span></A></p>
             </li>       
             </ul>
             </div> 
    </div>
  
  </div>
  <div class="col-md-6 right_list">     
     <div class="Open_cache">
        <div class="Open_cache_table">
			<ul style="border-bottom:1px #eee">
			<li><a href="#">服务申请审核</a></li> 
			</ul>  
        </div> 
         <div class="fuw_search">
      <ul>
     
      <li class="xil" style=" float:right;">
      	<A href="#"  id="audit_through"  style="padding:5px 25px 5px 25px; float:left; background:#78bd5a; border-radius:20px; margin-left:20px; text-align:center; color:#fff; font-size:14px;border:1px solid #78bd5a;">&nbsp;&nbsp;通过&nbsp;&nbsp;</A>
      	<A href="#" id="audit_dismissed" style="padding:5px 25px 5px 25px; float:left; background:#f5f5f5; border-radius:20px; margin-left:20px; text-align:center; color:#78bd5a; font-size:14px; border:1px solid #78bd5a;" >不通过</A>
      </li>
      </ul>
      </div>        
		
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
	          	<div class="Open_cache_list_tow">
	          		  <table id="table_detail"  style="width:100%; ">
						<tr>
							<th>编码</th>
							<th>产品信息</th>
							<th>申请部门</th>
							<th>申请联系方式</th>
							<th>审核状态</th>
							<th>申请时间</th>
						</tr>												
					 </table>
	           </div>
	           <div  style="float:center;margin:0 auto;">
	           <nav class="fenye">
							<span style="font-size: 14px;">
								<ul class="pagination" id="pageUl" style="width:600px;float:center">
								</ul>
							</span>
							
			  </nav> 
			  </div>               
	        </div>  
    	</div>   
     </div>  
  </div>
</div>

</div>
</div> 

<div class="modal fade" id="myModal" tabindex="-1" role="dialog"	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">	
		<div class="pop_up">   
   			<div class="pop_up_list">
   				<ul>
   					<li style="margin-left: 15px;"><h4 style="margin: 10px,10px,0px,0px; float:left; " id="myModalLabel">提示</h4></li>
   				</ul>
   			</div>   
    		<div class="pop_up_tab">      
      			<div class="xin_m">
      				<ul>
       					<li  style="margin-top:10px"><p class="xm_zi">开通结果：</p>	<p>未通过</p>	</li>
      					<li style="margin-top:10px"><p class="xm_zi">审核意见：</p>	</li>
      					<li style="margin-top:0px;"><textarea name="suggestion" id="suggestion" class="sheh_input" onkeyup="words_deal();" ></textarea></li>
     					<li style="float:right; margin:0px;"> 
     						<p style="float:right; font-size:12px; color:#999;"><span id="textCount">最多150个字</span></p>
     						<p style="margin-left:15px;color: #FF0000;"><label id="suggestionLabel"></label></p>
     					</li>      					
      				</ul>      
     				<ul>
     					<li class="but_cip"><A href="#" id="dismissedSure" style="margin-left:120px;padding:6px 20px 6px 20px;">确定</A><a href="#" class="cipqux"  id="cancel_apply" data-dismiss="modal" style="float:right;padding:6px 20px 6px 20px;">取消</a></li>
     				</ul>     
      			</div>
    		</div>   
   		</div>			
	</div>
</div> 

<div class="modal fade" id="iaasModal" tabindex="-1" role="dialog"	aria-labelledby="iaasModalLabel" aria-hidden="true">
	<div class="modal-dialog">	
		<div class="pop_up">   
   			<div class="pop_up_list">
   				<ul>
   					<li style="margin-left: 15px;"><h4 style="margin: 10px,10px,0px,0px; float:left; " id="myModalLabel">提示</h4></li>
   				</ul>
   			</div>   
    		<div class="pop_up_tab">
      			<div class="xin_m">
      				<ul>
      					<li> <p class="xm_zi">开通结果：</p> <p>通过</p></li>
      					<li> <p class="xm_zi">IP：</p><p><input name="ip" id="ip"  type="text" class="xm_input"></p> <p style="margin-left:10px;color: #FF0000;"><label id="ipErrorLabel"></label></p></li>
      					<li> <p class="xm_zi">用户名：</p> <p><input name="userName" id="userName" type="text" class="xm_input"></p> <p style="margin-left:10px;color: #FF0000;"><label id="userNameErrorLabel"></label></p></li>
       					<li> <p class="xm_zi">密码：</p> <p><input name="pwd" id="pwd" type="text" class="xm_input"></p>  <p style="margin-left:10px;color: #FF0000;"><label id="pwdErrorLabel"></label></p></li>
     				</ul>      
     				<ul>
     					<li class="but_cip"  ><A href="#" id="iaasAudit" style="margin-left:67px;padding:6px 20px 6px 20px;">确定</A><a href="#" class="cipqux" id ="iaasAuditCancle"  style="padding:6px 20px 6px 20px;" data-dismiss="modal">取消</a></li>
     				</ul>     
      			</div>
    		</div>   
   		</div>
	</div>
</div> 
<div id="errorMessageDia" class="modal-dialog" role="dialog" style="top: 30%;left: 45%;position:absolute; width:450px;display:none;">
			
			<div id="errorMessageDiv" class="pop_up"  style="width:450px;cursor: move;">   
   			<div class="pop_up_list">
   				<ul>
   					<li style="margin-left: 15px;"><h4 style="margin: 10px,10px,0px,0px; float:left; " id="myModalLabel">提示</h4></li>
   				</ul>
   			</div>   
    		<div class="pop_up_tab">
      			<div class="xin_m" style="margin-left:10px">
      				<ul style="width:430px">
       					<li style="width:430px"> <span aria-hidden="true" id="errorMessage">错误提示</span> </li>
     				</ul>      
     				<ul>
     					<li class="but_cip"  ><A href="#" id="iaasAudit" style="margin-left:160px;padding:6px 20px 6px 20px;" onclick="hideErrorMessageDia()">确定</A></li>
     				</ul>     
      			</div>
    		</div>   
   		</div>
</div>
<!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
 
  </body>
</html>
