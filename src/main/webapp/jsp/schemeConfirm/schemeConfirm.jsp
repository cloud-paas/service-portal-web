<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width; initial-scale=0.7;  user-scalable=0;" />
<%@ include file="/jsp/common/common.jsp"%>
<script src="${_base }/resources/js/common/commonUtils.js"></script>
<script src="${_base }/resources/js/common/prod_param_transfer.js"></script>

<style type="text/css">
#table_detail_1,#table_detail_2,#table_detail_3 {
	text-align: center
}

#table_detail_1 th,#table_detail_2 th，,#table_detail_3 th {
	text-align: center;
	background: rgb(245, 245, 245);
	font-size: 14px;
}

#table_detail_1 th,#table_detail_1 td,#table_detail_2 th,#table_detail_2 td,#table_detail_3 th,#table_detail_3 td
	{
	padding: 10px;
	border: solid 1px #eee
}

#table_detail_1 a,#table_detail_2 a,#table_detail_3 a {
	padding: 0px 5px 0px 5px;
	color: rgb(22, 154, 219);
	font-weight: 800;
}

#sq_js1 a {
   text-decoration: none;
}

.inform-success,.inform-fault{width: 460px;height: 205px;background: #fff;box-shadow: 0 0 5px 1px #ccc;position: relative;}
.ok{position: absolute;left: 50%;top: 37px;margin-left:-15px;}
.inform-success h4,.inform-fault h4{color: #333;position: absolute;left: 191px;top:70px;}
.sure{color: #fff;background:#169ADB;border: 1px solid #056A9E;left: 177px;width: 110px;height: 35px;text-align:center;line-height: 35px;font-weight: bold;font-size: 16px;position: absolute;top: 137px;}
.div_overlay{display:none;position: fixed;width: 100%;height:100%;z-index:1010;-moz-opacity: 0.0; opacity:.00;filter: alpha(opacity=0);background-color: black;}

 </style>
<script type="text/javascript">
	$(document).ready(function() {

		// 页面初始化
		$("#list_3").addClass("xuanz");
		
		$("#sq_js1").find("li").click(function(){
			$("#sq_js1").find("li").removeClass("ahov");
			$(this).addClass("ahov");
		});
		
		var options = {
				bootstrapMajorVersion : 3,
				currentPage : "${currentpage}",//当前页面
				numberOfPages : 10,//一页显示几个按钮
				totalPages : "${totalPages}"
			//总页数
			}
		if(${totalPages}>0){
			$('#pageUl').bootstrapPaginator(options);
		}
			
		 
	});
	
	function pasreEnDate(dateStr) {  
		try {  
			if (dateStr && dateStr.trim().length<7) {  
				return;  
			}  
			var mm_end=dateStr.indexOf(" ");
			var dd_end=dateStr.indexOf(", ", mm_end);
			var yy_end=dateStr.indexOf(" ", dd_end+2);
			var hh_end=dateStr.indexOf(":", yy_end);
			var min_end=dateStr.indexOf(":", hh_end+1);
			var second_end=dateStr.indexOf(" ", min_end+1);
			var mm = dateStr.substring(0, mm_end);  
			var dd = dateStr.substring(mm_end+1, dd_end);  
			var yy = dateStr.substring(dd_end+1, yy_end);  
			var hh = dateStr.substring(yy_end+1, hh_end);
			var min = dateStr.substring(hh_end+1, min_end);
			var ss = dateStr.substring(min_end+1, second_end);
			mm = mm.toUpperCase();  
			var em = new Array("JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC");  
	        switch (mm) {  
		          case em[0]:  
		            mm = 1;  
		            break;  
		          case em[1]:  
		            mm = 2;  
		            break;  
		          case em[2]:  
		            mm = 3;  
		            break;  
		          case em[3]:  
		            mm = 4;  
		            break;  
		          case em[4]:  
		            mm = 5;  
		            break;  
		          case em[5]:  
		            mm = 6;  
		            break;  
		          case em[6]:  
		            mm = 7;  
		            break;  
		          case em[7]:  
		            mm = 8;  
		            break;  
		          case em[8]:  
		            mm = 9;  
		            break;  
		          case em[9]:  
		            mm = 10;  
		            break;  
		          case em[10]:  
		            mm = 11;  
		            break;  
		          case em[11]:  
		            mm = 12;  
		            break;  
	        }  
			return yy+"-"+mm+"-"+dd+" "+hh+":"+min+":"+ss;
		} 
		catch (e) {  
			return "";  
		}  
	}
	
	function parseDate(dateStr){
		var date = dateStr.split(".");
		return date[0];
	}
	
	function pasreOrderDetailId(orderDetailId){
		/* alert(orderDetailId);
		alert(parseInt(orderDetailId));
		 */
		try{
			
			var oidValue = parseInt(orderDetailId);
			return oidValue;
			
		}catch(e){
		}
		
		return orderDetailId;
	}
	
	function parseOpenStatus(status){
		if (status == "1" | status == "") {
			return "待开通";
		}
		else if (status == "2"){
			return "已开通";
		}else{
			return status;
		}
	}
	
	function pasreOrderCheckResult(result){
		
		if (result == "1"){
			return "审核通过";
		}
		else if (result == "2"){
			return "审核不通过";
		}else if(result == "") {
			return "待审核";
		}
		
}
	
	
/* 	function prodParamTransfer(dataStr){
		
		var str="";
		
		var kh_end=dataStr.indexOf("}");
		var data = dataStr.substring(1, kh_end);  
		
		var result=data.split(",");
		for(var i=0;i<result.length;i++){
			str+=result[i]+"</br>";
		}
	
		 return str;
		 
	} */
	
	// 参数转换，将英文转化为中文
	function prodParamTransfer(obj) {
		try {
			obj = eval('(' + obj + ')');
			var tar = '[';
			$.each(obj, function(key, value) {
				if (key && key != 'userId') {
					if (key != 'prodCluster') {
						tar += valTransfer(prod_param, key) + "：";
					}
					var val = obj[key];
					if (key == 'prodCluster') {
				          tar += prod_param['prodCluster_val'][parseInt(val)-1];
				     } else {
						tar += valTransfer(prod_param, val) ;
						if (key == 'capacity' || key == 'singleFileSize'||key=='sesMem') {
							tar += 'M';
						}
				   }
					//tar += "，";
					tar += "，";
				}
			});
			if (tar.substring(tar.length - 1) == '，') {
				tar = tar.substring(0, tar.length - 1);
			}
			tar += ']';
			tar = tar.replace('[','').replace(']','');
//			if (tar.length > 27) {
//				tar = tar.substring(0, 27)+'...';
//			}
//			console.log(tar.length);
		
			
			//翻译后，对参数进行按逗号分隔，以冒号对齐
			var str=tar.split("，");
			var returnstr="";
			for(var i =0; i<str.length;i++){
				returnstr+=str[i]+"</br>";
			}
			
			return returnstr;
		} catch (e) {
			return "";
		}
	}
	
	function ISargee(flag,id){
		orderDetailId = pasreOrderDetailId(id);
		$.ajax({
			type : "POST",
			url : getContextPath() + "/schemeConfirm/schemeSubmit",
			data : {
				isAgree : flag,
				orderDetailId:orderDetailId
			},
			dataType:"json",
			success : function(dataObj) {
				if(dataObj.responseCode=="000000"){
					$("#fadeshow").show(); 
					$("#success").show();
					
					/* alert("操作成功！"); */
				}else if(dataObj.responseCode=="999999"){
					$("#fadeshow").show(); 
					$("#fault").show();
					
					/* alert("操作失败！"); */
				}
			}
		});
	}
	
	function getSure(){
		location.href="${_base}/schemeConfirm/schemeConfirmList?currentpage=1&pageSize=2";
	}
	
</script>
</head>
<body>
	<div id="fadeshow" class="div_overlay"></div> 
	<div id="success" class="inform-success" style="display: none;left:550px; top:200px;position:fixed; z-index:1011;_position:absolute;">
    	<img src="${_base }/resources/images/yes.jpg" class="ok" >
    	<h4 style="left:170px;padding:10px;">方案确认成功！</h4>
		<button id="confirm_success" class="sure" onclick="getSure();">知道了</button>
    </div>
    <div id="fault" class="inform-fault"  style="display: none;left:450px; top:200px;position:fixed; z-index:1011;_position:absolute;">
    	<img src="${_base }/resources/images/no.jpg" class="ok">
    	<h4 style="left:170px;padding:10px;">方案确认失败！</h4>
		<button id="confirm_fault"  class="sure"  onclick="getSure();">知道了</button>
    </div>

	<div class="big_k">
		<!--包含头部 主体-->
		<!--导航-->
		<div class="navigation">
			<%@ include file="/jsp/common/header.jsp"%>
		</div>
		<div class="container chanp">
			<div class="row chnap_row">
				<div class="col-md-6 left_list">
					<%@include file="/jsp/apply/userCenterList.jsp"%>
				</div>
				<div class="col-md-6 right_list">
					<div class="Open_cache">
						<div class="Open_cache_table">
							<ul style="border-bottom: 1px #eee">
								<li><a href="${_base}/schemeConfirm/schemeConfirmList?currentpage=1&pageSize=2">方案确认</a></li>
							</ul>
						</div>
			
						<div id="sq_js1">
							<div class="schemeConfirm">
								<div class="Open_cache_list" style="margin: 0">
									<div class="Open_cache_list_tow">
										<table id="table_detail_1" style="width: 100%;">
										 <tr>
												<th width='10%' id="orderDetailId">订单号</th>
												<th width='12%' id="prodName">资源名称</th>
												<th width='28%' id="prodParam">资源信息</th>
												<th width='12%' id="orderAppDate">申请时间</th>
												<th width='12%' id="openResult">开通状态</th>
												<th width='12%' id="OrderCheckResult">审核状态</th>
												<th width='15%'>操作</th>
											</tr>
													<c:forEach var="v" items="${list}">
													<tr>
														<td >
															<script>
														   		document.write(pasreOrderDetailId('${v.orderDetailId}'));
															</script>
														</td>
														<td>${v.prodByname}</td>
														<td style="text-align: left;">
															<script>
																document.write(prodParamZh('${v.prodParamZh}'));
															</script>
														</td>
														<td>
															<script>document.write(parseDate('${v.orderAppDate}'))</script>
														</td>
														<td>
															<script>document.write(parseOpenStatus('${v.openStatus}'))</script>
														</td>
														<td>
															<script>document.write(pasreOrderCheckResult('${v.orderCheckResult}'));</script>
														</td>
														<td><a href="javascript:;" onmousedown="ISargee(1,'${v.orderDetailId}')">通过</a><a href="javascript:;" onmousedown="ISargee(0,'${v.orderDetailId}')">不通过</a></td>
													</tr>
												</c:forEach>
										</table>
					<nav class="fenye">
							<span style="font-size: 14px;">
								<ul class="pagination" id="pageUl">
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
	</div>
	<!--页脚-->
	<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
	<script>
function paging(p) {
	 location.href="${_base}/schemeConfirm/schemeConfirmList?pageSize=2&currentpage="+p;
}
</script>
</body>
</html>