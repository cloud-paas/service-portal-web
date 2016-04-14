<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width; initial-scale=0.7;  user-scalable=0;" />
<%@ include file="/jsp/common/common.jsp"%>
<script src="js/daoh_js/jquery-1.9.1.min.js"></script>
<script src="${_base }/resources/js/common/commonUtils.js"></script>
<script src="${_base }/resources/js/common/prod_param_transfer.js"></script>
<style type="text/css">
.alertBox{width:800px;height:400px;background: #fff;box-shadow: #999 0px 0px 22px;position:fixed;left:55%;top:55%;margin-left:-400px;margin-top:-200px;z-index:10;}
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
.box-cover{position:absolute;left:0px;top:0px;z-index:2;display:none;}
.closeBtn{position:absolute;right:8px;top:6px;cursor:pointer;background:url(../resources/images/x1.png) no-repeat;width:16px;height:16px;}
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#list_1").addClass("xuanz");
		var w=$('.big_k').width();
		var h=$('.big_k').height();
		$('.box-cover').css({'width':w+'px','height':h+'px'})
		
		$("#sq_js1").find("li").click(function(){
			$("#sq_js1").find("li").removeClass("ahov");
			$(this).addClass("ahov");
			
		});
		var totalpage =${totalpage};
		if(totalpage!=0){
		var options = {
				bootstrapMajorVersion : 3,
				currentPage : "${currentpage}",//当前页面
				numberOfPages : 10,//一页显示几个按钮
				totalPages : "${totalpage}"
			//总页数
			}
			$('#pageUl').bootstrapPaginator(options);
		}
		
		//根据type 锁定样式
		var prodtype=$("input[name='prodtype']").val();
		
		
	});
	
	function pasreOpenStatus(obj){
		
		if (obj == "1" | obj == "") {
			return "待开通";
		}
		else if (obj == "2"){
			return "已开通";
		}else{
			return obj;
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
	
</script>
</head>
<body>
<div class="box-cover"></div>
<input type="hidden" name ="prodtype" value="${type}">
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
								<li><a href="${_base}/apply/purchaseRecords?prodType=1&currentPage=1">我的申请</a></li>
							</ul>
						</div>
			<!-- 存储 -->
						<div id="sq_js1">
							<div class="application">
								<ul><!-- //  1计算   2 数据库服务  3存储  -->
									<li <c:if test="${type==1}">class="ahov"</c:if>><A href="javascript:;"
										onmousedown="changeTableType(1,1)">计算</A></li>
									<li <c:if test="${type==2}">class="ahov"</c:if>><A href="javascript:;"
										onmousedown="changeTableType(2,1)">数据库服务</A></li>
									<li  <c:if test="${type==3}">class="ahov"</c:if>><A href="javascript:;"
										onmousedown="changeTableType(3,1)">存储</A></li>
								</ul>
							</div>
							<div class="Open_cache">
								<div class="Open_cache_list" style="margin: 0">
									<div class="Open_cache_list_tow">
										<table id="table_detail_1" style="width: 100%;">
											<tr>
												<th width='10%'>订单号</th>
												<th width='11%'>服务类型</th>
												<th width='28%'>产品信息</th>
												<th width='14%'>申请时间</th>
												<th width='12%'>开通状态</th>
												<th width='12%'>审核状态</th>
												
												<c:if test="${type==1}"><!-- type==2 -->
													<th width='13%'>操作</th>
												</c:if>
											</tr>
											<c:forEach var="sonList" items="${list}">
												<c:forEach var="v" items="${sonList }">
													<tr>
														<td>${v.orderDetailId }</td>
														<td>
															<script>
																document.write(prodTypeTransfer('${v.prodType}'));
															</script>
														</td>
														<td style="text-align: left;">
															${v.prodNameStr}</br>
															 <script>
																document.write(prodParamZh('${v.prodParamZh}'));
															</script> 
															<c:if test="${type==1}">  <!-- type==2 -->
																<c:if test="${v.prodByname=='IAAS_VIRTAL'}">
																</br>
																虚拟机数量：${v.vmNumber}
																</c:if>
															</c:if>
														</td>
														<td>${fn:substring(v.orderAppDate, 0, 19)}</td>
														<td>
															<script>
														   		document.write(pasreOpenStatus('${v.openStatus}'));
															</script>
														</td>
														<td>
														   	<script>
														   		document.write(pasreOrderCheckResult('${v.orderCheckResult}'));
															</script>
														</td>
														<c:if test="${type==1}"><!--  type==2 -->
															<td>
															<c:if test="${v.prodByname=='IAAS_VIRTAL'}">
																<a href="javascript:void(0)" onclick="openOaDiv(${v.orderDetailId},'${v.oaCheckUrl}');">审批查看</a><br><br>
																<c:if test="${v.orderStatus==10}">
																	<a style="cursor:pointer" href="${_base }/virtualMachineModify/initModify?orderDetailId=${v.orderDetailId}">申请修改</a>
																</c:if>
															</c:if>
															</td>
														</c:if>
													</tr>
												</c:forEach>
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
				<div class="alertBox" style="display:none">
<!-- 					<span style="position:absolute;right:10px;top:10px;cursor:pointer" onclick="closeBox()"><font color="red">关闭</font></span> -->
<!-- 					<iframe name="right" id="rightMain" src="" frameborder="no" scrolling="auto" width="100%" height="100%" allowtransparency="true"></iframe> -->
					<span class="closeBtn"  onclick="closeBox()"></span>
					<iframe name="right" id="rightMain" src="" frameborder="no" scrolling="no" width="100%" height="100%" allowtransparency="true"></iframe>
				</div>
			</div>
		</div>
	</div>
	<!--页脚-->
	<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
	
<script>
	function paging(p) {
		var prodtype=$("input[name='prodtype']").val();
	 	 location.href="${_base}/apply/purchaseRecords?prodType="+prodtype+"&currentPage="+p;
	
	}
	function closeBox(){
		$('.alertBox').css('display','none');
		$('.box-cover').css('display','none');
	}
</script>
</body>
</html>