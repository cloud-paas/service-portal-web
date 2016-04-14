<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<script src="${_base }/resources/js/common/commonUtils.js"></script>
<script src="${_base }/resources/js/user/mcs_console.js"></script>
</head>
<body>
	<div class="big_k">
		<!--包含头部 主体-->
		<!--导航-->
		<%@ include file="/jsp/common/header_console.jsp"%>
		<div class="container chanp">
			<%@ include file="/jsp/common/leftMenu_console.jsp"%>
			<div class="row chnap_row">

				<div class="col-md-6 right_list">

					<div class="Open_cache">
						<div class="Open_cache_table">
							<ul>
								<li><a href="javascript:;">${userProdInstVo.prodName}</a></li>
							</ul>
						</div>
						<div class="Open_cache_table"
							style="background: rgb(245, 245, 245); height: 30px; vertical-align: middle; line-height: 30px; padding-left: 1%">
							<span>服务名称：</span> <span style="color: rgb(22, 154, 219)">${userProdInstVo.serviceName}</span>
							<span style="margin-left: 10px">服务编码：</span> <span
								style="color: rgb(22, 154, 219)">${userProdInstVo.userServIpaasId}</span>
						</div>
						<div class="Open_cache">
							<div class="Open_cache_list" style="margin-top:30px ">
								<div class="Open_cache_list_tow"
									style="vertical-align: middle; line-height: 30px;position:relative;">
									
												<p style="float: left; margin-left: 20px; font-size: 18px;margin-top:50px;">Key&nbsp;值&nbsp;:</p>
											
												
												<div class="input-group"
													style="width: 400px; margin-left: 10px;float:left;position:relative">
													<span style="position:absolute;left:-75px;top:0px;font-size:18px;">类&nbsp;型&nbsp;:</span> 
													<select id="selectType" style="position:absolute;left:1px;top:2px;font-size:18px;" name="selectType" onchange="selectTypeChange(this.value)">
														<c:forEach items="${typelist}" var="type">
															<option value="${type.serviceValue}">${type.serviceOption}</option>
														</c:forEach>
													</select> 
													<input type="text" class="form-control" id="keyQuery" placeholder="请输入要查询的Mcs Key名称" style="margin-bottom:10px;width:60%;margin-top:50px;"> 														
													<input type="text" class="form-control" id="mapfiledname" placeholder="请输入要查询的Map fileds名称" style="width:60%;display:none">
														
														<span
														class="input-group-btn" style="position:absolute;left:250px;top:58px;">
														<button class="btn btn-default" type="button" style="margin-left:5px;margin-top:-12px;"onclick="operatServ('${userProdInstVo.userId}', '${userProdInstVo.userServId}','/mcs/manage/get', '${userProdInstVo.userServIpaasId}', '', '', '${userProdInstVo.serviceName }', '')">查找</button>
													</span>
												</div>
												
											
												<p
													style="float: left;font-size: 18px; color: red; margin-left: -70px;margin-top:50px">
													<a href="javascript:;" title="删除" onclick="operatServ('${userProdInstVo.userId}', '${userProdInstVo.userServId}','/mcs/manage/del', '${userProdInstVo.userServIpaasId}', '', '', '${userProdInstVo.serviceName }', '删除')"><span
														style="border-radius: 16px; background: red; color: #fff; padding: 5px 9px">X</span></a>
												</p>
										
									<div class="Open_cache_list_tow"
										style="vertical-align: middle; line-height: 30px; padding: 30px 0px 0px 100px">
										<table id="keyMgrResult">
											
										</table>
									</div>
									<div class="Open_cache_list_tow"
										style="vertical-align: middle; line-height: 30px; padding: 30px 0px 0px 100px">
										<a href="${_base}/mcsConsole/toMcsConsole"><div
												style="margin: 10px 0px 0px 50px; text-align: center; -moz-border-radius: 15px; border-radius: 15px; width: 130px; height: 30px; background: rgb(230, 230, 230); line-height: 30px; vertical-align: middle; color: #000; font-size: 14px; font-weight: 800; border: solid 1px rgb(204, 204, 204)">返回</div></a>
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
</body>
</html>