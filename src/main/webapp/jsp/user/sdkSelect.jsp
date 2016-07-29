<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/jsp/common/common.jsp"%>
<title>下载中心</title>
</head>
<script type="text/javascript">
var message ='${message}'; 
if(message){
	alert("文件不存在！");
	window.location.href = "${_base}/jsp/user/sdkSelect.jsp";
}

$(function(){
	$("#navi_tab_download").addClass("chap");//头部高亮显示“下载中心”
});
</script>
<body>
<div class="big_k">
	 <div class="navigation">
		<%@ include file="/jsp/common/header.jsp"%>
	</div>
	 <div class="container chanp">
	 	<div class="row chnap_row">
	 		<div class="col-md-6 left_list" >
	 			<div class="list_groups">
	 				<div class="list_groups_none">
	 					<ul>
	 						<li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(6,2,this);">
					             <a href="${_base}/jsp/user/sdkSelect.jsp" style="color:#fff">
					             <p id="img2">下载</p>
					             </a>
					         </li>
				             <li class="list_xinx"  id="content2" >				             	
					             <p class="xuanz"><A href="${_base}/jsp/user/sdkSelect.jsp"><span style="margin-top:2px;">SDK下载</span></A></p>
					             <p><A href="${_base}/audit/toDownloadPage?type=2"><span style="margin-top:2px;">文档下载</span></A></p
				             </li>
	 					</ul>
	 				</div>
	 			</div>
	 		</div>
	 	
		 	<div class="col-md-6 right_list">
		 		<div class="Open_cache_table">
		 			<ul style="border-bottom:1px #eee">
						<li>
							<c:if test="${type == 1}">
							<a href="#">SDK下载</a>
							</c:if>
							<c:if test="${type == 2}">
							<a href="#">文档下载</a>
							</c:if>
						</li>
					</ul>
		 		</div>
		 		<!-- <form action="downloadCenter.jsp" mgethod="post" name="form1" > -->
		 		  <table width="60%" border="0" bordercolor="#FFFFFF">
		 		  <tr bordercolor="#004080">
                   <td width="30%"><div align="left">
		 		    <input type="checkbox" id="all" onclick="checkAll()"> 全选所有服务的SDK</div></td></tr>
		 		   <tr bordercolor="#004080">
                   <td width="8%"><div align="left"><input type="checkbox" name="pro" id="ccs"> 配置中心CCS </div></td></tr>
                   <tr bordercolor="#004080">
                   <td width="8%"><div align="left"><input type="checkbox" name="pro" id="mcs"> 缓存中心MCS </div></td></tr>
                   <tr bordercolor="#004080">
                   <td width="8%"><div align="left"><input type="checkbox" name="pro" id="mds"> 消息中心MDS </div></td></tr>
                   <tr bordercolor="#004080">
                   <td width="8%"><div align="left"><input type="checkbox" name="pro" id="dss"> 文档存储服务DSS </div></td></tr>
                   <tr bordercolor="#004080">
                   <td width="8%"><div align="left"><input type="checkbox" name="pro" id="ses"> 搜索服务SES </div></td></tr>
                   <tr bordercolor="#004080">
                   <td width="8%"><div align="left"><input type="checkbox" name="pro" id="idps"> 图片服务IDPS </div></td></tr>
                   <tr bordercolor="#004080">
                   <td width="8%"><div align="left"><input type="checkbox" name="pro" id="txs"> 事务保障服务TXS </div></td></tr>
                   <tr bordercolor="#004080">
                   <td width="8%"><div align="left"><input type="checkbox" name="pro" id="dbs"> 分布式数据库服务DBS </div></td></tr>
                   <tr bordercolor="#004080">
                   <td width="8%"><div align="left"><input type="checkbox" name="pro" id="rcs"> 实时计算RCS </div></td></tr>
                   </table>
                   <br><br>
                   <table width="30%" border="0" bordercolor="#FFFFFF">
                   
                    <li class="xil" style=" float:center;">
      	              <A href="#"  id="sdk_submit"  style="padding:5px 25px 5px 25px; float:left; background:#78bd5a; border-radius:20px; margin-left:20px; text-align:center; color:#fff; font-size:14px;border:1px solid #78bd5a;">&nbsp;&nbsp;提交&nbsp;&nbsp;</A>
      	              <A href="#" id="sdk_cancle" style="padding:5px 25px 5px 25px; float:left; background:#f5f5f5; border-radius:20px; margin-left:20px; text-align:center; color:#78bd5a; font-size:14px; border:1px solid #78bd5a;" >取消</A>
                    </li>
                     </table>
                 <!-- </form> -->   
                </div>
		 	</div>
	 </div>
</div>
	   <script>
	   	$(document).ready(function(){
	   		$('a[id^=active_]').each(function(){
	   			$(this).css('color', '#949494');
	   		});
	   		$('#active_download').css('color', '#1699dc');
	   		
	   		$('#sdk_cancle').click(function() {
	   			alert("sdk_cancle");
	   			document.getElementById("all").checked=false;
	   			var aa=document.getElementsByName("pro");
	   			for(i=0;i<aa.length;i++){
	   				aa[i].checked=false;
	   			}		
	   		});
	   		
	   		$('#sdk_submit').click(function() {
	   			alert("sdk_submit");
	   			var sdkList = [];
	   			sdkList.push("uac");
	   			if(document.getElementById("ccs").checked==true){
	   				sdkList.push("ccs");
	   			}
	   			if(document.getElementById("mcs").checked==true){
	   				sdkList.push("mcs");
	   			}
	   			if(document.getElementById("mds").checked==true){
	   				sdkList.push("mds");
	   			}
	   			if(document.getElementById("dss").checked==true){
	   				sdkList.push("dss");
	   			}
	   			if(document.getElementById("ses").checked==true){
	   				sdkList.push("ses");
	   			}
	   			if(document.getElementById("idps").checked==true){
	   				sdkList.push("idps");
	   			}
	   			if(document.getElementById("txs").checked==true){
	   				sdkList.push("txs");
	   			}
	   			if(document.getElementById("dbs").checked==true){
	   				sdkList.push("dbs");
	   			}
	   			if(document.getElementById("rcs").checked==true){
	   				sdkList.push("rcs");
	   			}
	   			
	   			if (sdkList.length == 1) {
	   				$("#errorMessage").text("");					
	   				$("#errorMessage").append('尚未选中任何服务，请至少选择一个！');
	   				$("#errorMessageDia").show();
	   				return;
	   			}					
	   				$("#sdk_submit").attr({"disabled":"disabled"});
	   				$("#sdk_cancle").attr({"disabled":"disabled"});
	   				$('.waitCover').show();
	   				$.ajax({
	   					type : 'POST',
	   					url : '${_base}/audit/tosdkLoading?',
	   					dataType : 'json',
	   					data : {
	   						sdkList : sdkList.join(','),
	   						checkResult : 1
	   					},
	   					beforeSend : function() {
	   						$('#loader').shCircleLoader({
	   						// 设置加载颜色
	   							color : '#F0F0F0'
	   						});
	   					},
	   					success : function(data) {
	   						if (data && data.resultCode == "000000") {
	   							location.href="${_base}/audit/toDownloadPage?type=1";
	   						} else {
	   							location.href="${_base}/jsp/user/sdkSelect.jsp";
	   							alert("請重新選擇SDK下載項！~");
	   						}
	   					},
	   					complete : function() {
	   						$('#loader').shCircleLoader('destroy');
	   						$('.waitCover').hide();
	   					},
	   					error : function() {
	   						$("#errorMessage").text("");					
	   						$("#errorMessage").append('系统发生异常,下载失败,请稍后再试！');
	   						$("#errorMessageDia").show();
	   						$('.waitCover').hide();
	   					}
	   				});
	   			});
	   	});
	   	
	   	function downloadFile(fileId,type){
	   	 var url ="${_base}/audit/download?fileId="+fileId+"&type="+type;
	   	 url = encodeURI(encodeURI(url));
	   	 window.location.href=url;
	    }
	   	
	   	function checkAll(){
	   		var aa=document.getElementsByName("pro");
	   		for(i=0;i<aa.length;i++){
	   			if(document.getElementById("all").checked==true){
	   				aa[i].checked=true; 
	   			}else{
	   				aa[i].checked=false;
	   			}
	   		}
	   	}  
	   </script>
		<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
</body>
</html> 