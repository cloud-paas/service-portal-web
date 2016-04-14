<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%@ include file="/jsp/storm/common/jsp/html_meta.jsp"%>
<title>查询</title>
<%@ include file="/jsp/storm/common/jsp/html_js.jsp"%>
<script type="text/javascript">
	function search(p) {
		var url = "${_base}/rcs/toList?page=" + p + "&searchName="
				+ encodeURI(encodeURI($("#searchName").val()));
		location.href = url;
	}
	$(function() {
		$.each($("tr[name='data_tr']"), function(i, d) {
			$(d).bind("click", function() {
				$(this).find("input[name='taskId']")[0].checked = true;
			});
		});
	});
</script>

<style type="text/css">
/**头部菜单**/
.mune_1 {
	float: left;
	width: 80%;
	padding-top: 1.8%;
	text-align: center;
}

.mune_1 li {
	float: left;
	list-style: none;
	width: 25%;
	font-size: 22px;
	font-weight: 800;
	color: #fff;
	padding-bottom: 1%;
	cursor: pointer;
}
/**页脚**/
.footer {
	position: relative;
	text-align: center;
	margin-top: 10px;
	line-height: 30px
}

.footer li {
	float: left;
	list-style: none;
	margin: 10px 0px 0px 0px;
	text-align: center;
	position: relative;
	color: #949494;
	font-weight: 800;
	width: auto;
}

.footer span {
	color: #949494;
	font-weight: 800;
	width: auto;
}

#table_detail_mcs {
	text-align: center
}

#table_detail_mcs th {
	text-align: center;
	background: rgb(245, 245, 245);
	font-size: 14px;
}

#table_detail_mcs th,#table_detail_mcs td {
	padding: 10px;
	border: solid 1px #eee
}

#table_detail_mcs a {
	padding: 0px 5px 0px 5px;
	color: rgb(22, 154, 219);
	font-weight: 800;
}
</style>

</head>
<body>
	<div class="big_k">
		<!--包含头部 主体-->
		<%@ include file="/jsp/common/header_console.jsp"%>
		<div class="container chanp">
			<%@ include file="/jsp/common/leftMenu_console.jsp"%>		
				<div class="row chnap_row">
					
					<div class="col-md-6 right_list">
						<div class="Open_cache">
							<div class="Open_cache_table">
								<ul>
									<li><a href="${_base }/rcs/toList">实时计算RCS</a></li>
								</ul>
							</div>
							<!--我的服务-->
							<div class="fuw_search">
								<ul>
									<li><input id="searchName" name="searchName" type="text"
										class="search_ch" style="width: 200px;"></li>
									<li class="open_btn"><a href="javascript:void(0)"
										id="btn_search">搜索</a></li>
									<li class="open_btn"><A href="${_base}/rcs/toRegisterTask"
										class="gy_btn">新建</A></li>
									<li class="open_btn"><A href="javascript:void(0)"
										class="gy_btn" id="btn_start">启动</A></li>
									<li class="open_btn"><A href="javascript:void(0)"
										class="gy_btn" id="btn_stop">停止</A></li>
									<!--<li class="open_btn">
                                    <A href="javascript:void(0)" class="gy_btn" id="btn_cancel">注销</A>
                                </li> -->
									<!-- <li class="open_btn">
                                    <A href="javascript:void(0)" class="gy_btn" id="btn_edit">编辑</A>
                                </li> -->
									<li class="open_btn"><A href="javascript:void(0)"
										class="gy_btn" id="btn_log">日志</A></li>
								</ul>
							</div>
							<div class="fuw_table">
								<table width="100%" border="0">
									<tr class="bjtr">
										<td>选择</td>
										<td>计算任务名称</td>
										<td>集群标识</td>
										<td>注册时间</td>
										<td>注销时间</td>
										<td>work数量</td>
										<td>状态</td>
									</tr>
									<c:forEach var="v" items="${pagingResult.resultList}"
										varStatus="vs">
										<tr name="data_tr">
											<td><input type="radio" name="taskId"
												taskName="${v.name}" taskStatus="${v.status}"
												value="${v.id }" ${vs.first?'checked':'' } /></td>
											<td name="subText" subSize="14">${v.name}</td>
											<td>${v.clusterName}</td>
											<td><fmt:formatDate value="${v.registerDt}" type="both"
													pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td><fmt:formatDate value="${v.cancelDt}" type="both"
													pattern="yyyy-MM-dd HH:mm:ss" /></td>
											<td>${v.numWorkers}</td>
											<td><c:if test="${v.status eq '-1'}">已注销</c:if> <c:if
													test="${v.status eq '0'}">已注册</c:if> <c:if
													test="${v.status eq '1'}">正在运行</c:if> <c:if
													test="${v.status eq '2'}">已停止</c:if></td>
										</tr>
									</c:forEach>
								</table>
							</div>
							<nav class="fenye"> <jsp:include
								page="/jsp/storm/common/jsp/page.jsp"></jsp:include> </nav>
						</div>
					</div>
				</div>

</div>
		</div>
		<!--底部-->
		<%@ include file="/jsp/common/footer_new.jsp"%>
		<script type="text/javascript">
			$(function() {
				$("#btn_start")
						.bind(
								"click",
								function() {
									var status = $(
											"input[name='taskId']:checked")
											.attr("taskStatus");
									if (status == '0' || status == '2') {
										/** 已注册 or 已停止 **/
										$(this).addClass("disabled");
										var url = "${_base}/rcs/operTask?operType=start&id="
												+ $(
														"input[name='taskId']:checked")
														.val();
										var param = "";
										ajaxSubmitAsync_my(url, param,
												"启动实时任务成功喽~",
												"${_base}/rcs/toList",
												"btn_start");
									} else {
										alert("只可启动状态是“已停止”和“已注册”的计算任务！");
									}
								});
				$("#btn_stop")
						.bind(
								"click",
								function() {
									var status = $(
											"input[name='taskId']:checked")
											.attr("taskStatus");
									if (status == '1') {
										/** 正在运行 **/
										$(this).addClass("disabled");
										var url = "${_base}/rcs/operTask?operType=stop&id="
												+ $(
														"input[name='taskId']:checked")
														.val();
										var param = "";
										ajaxSubmitAsync_my(url, param,
												"停止实时任务成功喽~",
												"${_base}/rcs/toList",
												"btn_stop");
									} else {
										alert("只可停止“正在运行”状态的计算任务！");
									}
								});
				$("#btn_cancel")
						.bind(
								"click",
								function() {
									var status = $(
											"input[name='taskId']:checked")
											.attr("taskStatus");
									if (status != '-1') {
										/** 非注销状态 **/
										$(this).addClass("disabled");
										var url = "${_base}/rcs/operTask?operType=cancel&id="
												+ $(
														"input[name='taskId']:checked")
														.val();
										var param = "";
										ajaxSubmitAsync_my(url, param,
												"注销实时任务成功喽~",
												"${_base}/rcs/toList",
												"btn_cancel");
									} else {
										alert("所选计算任务已经注销！");
									}
								});
				$("#btn_edit").bind(
						"click",
						function() {
							$(this).addClass("disabled");
							var url = "${_base}/rcs/toEditTask?id="
									+ $("input[name='taskId']:checked").val();
							location.href = url;
						});
				$("#btn_log").bind(
						"click",
						function() {
							$(this).addClass("disabled");
							var url = "${_base}/rcs/toLookLog?topologyId="
									+ $("input[name='taskId']:checked").attr(
											"taskName");
							//var url = "${_base}/rcs/toLookLog?topologyId=" + $("input[name='taskId']:checked").attr("taskName") + "_"+ $("input[name='taskId']:checked").val();
							location.href = url;
						});
				$("#btn_search").bind("click", function() {
					search(1);
				});
			});
		</script>
</body>
</html>