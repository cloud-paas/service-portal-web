<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<title>申请审核</title>
<%@ include file="/jsp/common/common.jsp"%>
<script src="${_base }/resources/js/common/prod_param_transfer.js"></script>
<style type="text/css">

/**
       * Checkbox Five
       */
.checkboxFive {
	width: 20px;
	margin: 10% 50%;
	position: relative;
}

/**
       * Create the box for the checkbox
       */
.checkboxFive label {
	cursor: pointer;
	position: absolute;
	width: 20px;
	height: 20px;
	top: 0;
	left: 0;
	background: #eee;
	border: 1px solid #ddd;
}

/**
       * Display the tick inside the checkbox
       */
.checkboxFive label:after {
	opacity: 0.0;
	content: '';
	position: absolute;
	width: 12px;
	height: 7px;
	background: transparent;
	top: 5px;
	left: 4px;
	border: 2px solid #333;
	border-top: none;
	border-right: none;
	-webkit-transform: rotate(-45deg);
	-moz-transform: rotate(-45deg);
	-o-transform: rotate(-45deg);
	-ms-transform: rotate(-45deg);
	transform: rotate(-45deg);
}

/**
       * Create the hover event of the tick
       */
.checkboxFive label:hover::after {
	opacity: 0.0;
}

/**
       * Create the checkbox state for the tick
       */
.checkboxFive input[type=checkbox]:checked+label:after {
	opacity: 1;
}

.fuw_table table tbody tr:nth-child(even) {
	background: #ffffff;
}

.fuw_table table tbody tr:nth-child(odd) {
	background: #f2f2f2;
}

.fuw_table table tbody tr:hover {
	background: #e15009;
}
</style>
<script>
	$(function() {
		
		$("#navi_tab_product").addClass("chap");
		$(".hideclass").click(function() {
			$(".hideclass").removeClass("qieh");
			$(this).addClass("qieh");
			var id = $(this).attr("id");
			$(".youis").hide();
			$("#t" + id).fadeIn("slow");
		})

	});
</script>
<script type="text/javascript">
	/**
	 * 时间对象的格式化
	 */
	Date.prototype.format = function(format) {
		/*
		 * format="yyyy-MM-dd hh:mm:ss";
		 */
		var o = {
			"M+" : this.getMonth() + 1,
			"d+" : this.getDate(),
			"h+" : this.getHours(),
			"m+" : this.getMinutes(),
			"s+" : this.getSeconds(),
			"q+" : Math.floor((this.getMonth() + 3) / 3),
			"S" : this.getMilliseconds()
		}

		if (/(y+)/.test(format)) {
			format = format.replace(RegExp.$1, (this.getFullYear() + "")
					.substr(4 - RegExp.$1.length));
		}

		for ( var k in o) {
			if (new RegExp("(" + k + ")").test(format)) {
				format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k]
						: ("00" + o[k]).substr(("" + o[k]).length));
			}
		}
		return format;
	}

	function _format(dateStr) {
		var date = new Date(dateStr);
		return date.format('yyyy-MM-dd hh:mm:ss');
	}
</script>
<script type="text/javascript">
	$(document).ready(function() {
		// 页面初始化
		paging(1);

		$('#audit_approve').click(function() {
			var current_page = $('ul li.active a').text();
			var orderDetailIdList = [];
			$('input[id^="checkboxFiveInput"]').each(function() {
				if ($(this).is(':checked')) {
					orderDetailIdList.push($(this).val());
				}
			});
			if (orderDetailIdList.length == 0) {
				report('尚未选中任何订单，请选择一个');
				return;
			}
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
						paging(current_page);
					} else {
						var msg = data.resultMessage;
						if (!msg) {
							msg = '系统异常';
						}
						report('审核失败:' + msg);
					}
				},
				complete : function() {
					$('#loader').shCircleLoader('destroy');
				},
				error : function() {
					report('系统发生异常，开通失败，请稍后再试');
				}

			});
		});

		// 弹出不同意对话框
		$('#audit_against').click(function() {
			
			var orderDetailIdList = [];
			$('input[id^="checkboxFiveInput"]').each(function() {
				if ($(this).is(':checked')) {
					orderDetailIdList.push($(this).val());
				}
			});
			if (orderDetailIdList.length == 0) {
				report('尚未选中任何订单，请选择一个');
				return;
			}
			$('#suggestion').val('');
			$('#suggestionLabel').text('');
			$('#myModal').modal();
			
		});

		$('#against_apply').click(function() {
// 			if (against_popup.valid()) {
				var suggestion = $('#suggestion').val();
				if (!suggestion) {
					$('#suggestionLabel').text('您的意见很宝贵额。');
					return;
				}
				if (suggestion.length > 200) {
					$('#suggestionLabel').text('意见字数不能超过200字哦。');
					return;
				}
				var current_page = $('ul li.active a').text();
				var orderDetailIdList = [];
				$('input[id^="checkboxFiveInput"]').each(function() {
					if ($(this).is(':checked')) {
						orderDetailIdList.push($(this).val());
					}
				});
				if (orderDetailIdList.length == 0) {
					report('尚未选中任何订单，请选择一个');
					return;
				}
				$.ajax({
					type : 'POST',
					url : '${_base}/apply/approveApply',
					dataType : 'json',
					data : {
						orderDetailIdList : orderDetailIdList.join(','),
						suggestion : suggestion,
						checkResult : 2
					},
					beforeSend : function() {
// 						$('#against_apply').prop('disabled', 'true');
// 						alert($('#against_apply').val());
					},
					success : function(data) {
						if (data.resultCode == '000000') {
							paging(current_page);
						} else {
							report('驳回处理失败:' + data.resultMessage);
						}
					},
					complete : function() {
						//$('#loader').shCircleLoader('destroy');
// 						$('#against_apply').prop('disabled', 'false');
// 						$('#against_apply').val('确定');
						$('#myModal').modal('hide');
					},
					error : function() {
						report('系统异常，处理失败，请稍后再试');
						$('#myModal').modal('hide');
					}
	
				});
// 			}
		});
		

	});

	function report(msg) {
		$('#report_content').text(msg);
		$('#report_dialog').modal();
	}
	function paging(page) {
		$
				.ajax({
					type : "POST",
					url : "${_base}/apply/queryApplyAuditList",
					dataType : "json",
					data : {
						page : page
					},
					beforeSend : function(XMLHttpRequest) {
						$('.fenye').css('display', 'none');
						$("#apply_list_table tbody").empty();
						$('#loading').shCircleLoader({
							// 设置加载颜色
							color : '#F0F0F0'
						});
					},
					success : function(msg) {
						if (msg.resultCode == '000000') {
							if (msg.pageResult.resultList.length == 0) {
								$("#apply_list_table tbody").empty();
								$('#apply_list_table')
										.html(
												'<div style="margin-left: 40%;margin-top: 5%;">您查询的数据不存在</div>');
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
							//alert("查询不到数据");
							$("#apply_list_table tbody").empty();
							$('#apply_list_table')
									.html(
											'<div style="margin-left: 40%;margin-top: 5%;">您查询的数据不存在</div>');
						}
					},
					complete : function(XMLHttpRequest, textStatus) {
						$('.fenye').css('display', 'block');
						$('#loading').shCircleLoader('destroy');
					},
					error : function() {
						report('系统发生异常，数据加载失败，请登陆后重新尝试。');
						$('.fenye').css('display', 'none');
					}
				});

	}

	function loadData(obj) {
		if (!!obj && obj.length == 0) {
			$("#apply_list_table tbody").empty();
			$('#apply_list_table')
					.html(
							'<div style="margin-left: 40%;margin-top: 5%;">您查询的数据不存在</div>');
			return;
		}
		$("#apply_list_table tbody").empty();
		var html = '';
		html += '<tr class="bjtr">';
		html += '<td style="width:10%;"></td>';
		html += '<td style="width:40%;">产品信息</td>';
		html += '<td>申请部门</td>';
		html += '<td>申请人联系方式</td>';
		html += '<td>审核状态</td>';
		html += '<td>申请时间</td>';
		html += '</tr>';
		$
				.each(
						obj,
						function(n, item) {
							html += '<tr style="height:50px;" title="'+prodParamTransfer(item.prodParam)+'">';
							// 复选框
							html += '<td>';
							html += '<div class="checkboxFive">';
							html += '<input type="checkbox" value="'+ item.orderDetailId +'" id="checkboxFiveInput_'+item.orderDetailId+'" name="" />';
							html += '<label for="checkboxFiveInput_'+item.orderDetailId+'"></label>';
							html += '</div>';
							html += '</td>';
							// 產品信息
							html += '<td style="text-align:left;"><h5>' 
									+ prodNameTransfer(item.prodByname)+'（'+item.prodByname+'）'
									+ '</h5>'
									+ '<span title='+prodParamTransfer(item.prodParam)+'>'+subs(prodParamTransfer(item.prodParam)) +'</span>'
									+ '</td>';
									
							// 组织信息
							html += '<td>' + item.userOrgName + '</td>';
							// 用户信息
							html += '<td>' + item.userPhoneNum + '<br/>'
									+ item.userEmail + '</td>';
							// 状态
							html += '<td>'
									+ stateTransfer(item.orderCheckStatus)
									+ '</td>';
							// 申请时间
							html += '<td>' + _format(item.orderAppDate)
									+ '</td>';
							html += '</tr>';
						});
		$('#apply_list_table tbody').append(html);
		$('#apply_list_table').find('tr').bind('click', function() {
			var $checkbox = $(this).find('input[id^="checkboxFiveInput"]')[0];
			$($checkbox).prop('checked', !$($checkbox).is(':checked'));
		});
	}
</script>
</head>

<body>
	<div class="big_k">
		<!-- 头部和导航条 -->
		
		<div class="container chanp"><div class="row"> <%@ include file="/jsp/common/header.jsp"%></div>

			<div class="row chnap_row">
				<%@ include file="/jsp/common/leftMenu.jsp"%>
				<div class="col-md-6 right_list">

					<div class="Open_cache">

						<div class="Open_cache_table">
							<ul>
								<li><a href="#">服务申请审核</a></li>
							</ul>
						</div>

						<!--我的服务-->
						<div class="fuw_search">
							<ul>

								<li class="xil" style="float: right;"><A href="#"
									id="audit_approve" class="gy_btn">通过</A><A href="#"
									id="audit_against" class="gy_btn">不通过</A></li>
							</ul>
						</div>
						<!-- 审核意见 -->
						<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
							aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="pop_up" id="against_popup">

									<div class="pop_up_list">
										<ul>
											<li>审核意见</li>
											<li class="puc_c"><A href="#" data-dismiss="modal"><img
													src="${_base }/resources/images/sq_sh.png"></A></li>
										</ul>
									</div>

									<div class="pop_up_tab">
										<div class="xin_m">
											<ul>
												<li>
													<p class="xm_zi">审核结果：</p>
													<p>不通过</p>
												</li>
												<li>
													<p class="xm_zi">审核意见：</p>
													<p>
														<textarea name="suggestion" id="suggestion"
															class="xm_input_c"></textarea>
													</p>
													
												</li>
												<li>
													<p class="xm_zi">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>
													<p style="margin-left:100;color: #FF0000;"><label id="suggestionLabel"></label></p>
												</li>
											</ul>

											<ul>
												<li class="but_cip"><A href="#" id="against_apply">确定</A><a
													href="#" id="cancel_apply" data-dismiss="modal">取消</a></li>
											</ul>

										</div>

									</div>

								</div>
							</div>

						</div>
						<!-- 审核意见结束 -->
						<div class="fuw_table">

							<table width="100%" border="0" id="apply_list_table">
								<tr class="bjtr">
									<td>产品信息</td>
									<td>申请部门</td>
									<td>申请人联系方式</td>
									<td>申请时间</td>
								</tr>

							</table>

						</div>
						<nav class="fenye">
							<span style="font-size: 14px;">
								<ul class="pagination" id="pageUl">
								</ul>
							</span>
						</nav>
						<div id="loading"
							style="width: 100px; height: 100px; position: absolute; top: 20%; left: 50%; hite; z-index: 1002; overflow: auto;"></div>

						<div id="loader"
							style="width: 100px; height: 100px; position: absolute; top: 20%; left: 50%; hite; z-index: 1002; overflow: auto;"></div>
					</div>
					<div class="right_yousi">



						<div class="right_yousi_table">
							<ul>
								<li class="qieh hideclass" id="c1"><A
									href="javascript:void(0)">我们的优势</A></li>
								<li class="hideclass" id="c2"><A href="javascript:void(0)">产品功能</A></li>
								<li class="hideclass" id="c3"><A href="javascript:void(0)">产品帮助</A></li>
							</ul>
						</div>

						<div class="youis" id="tc1">
							<div class="youis_none">
								<p>
									<a name="C1">我们的优势</a>
								</p>
							</div>
							<div class="row yousi_tow">
								<div class="col-md-4 for4">
									<ul>
										<li><img src="${_base }/resources/images/icon7.png"></li>
										<li class="icon_7img">便捷</li>
										<li>服务开箱即用</li>
										<li>容量弹性伸缩</li>
										<li>配置变更不中断服务</li>
									</ul>
								</div>
								<div class="col-md-4 for4">
									<ul>
										<li><img src="${_base }/resources/images/icon8.png"></li>
										<li class="icon_7img">可靠便捷</li>
										<li>分布式集群及负载均衡设计</li>
										<li>硬件故障自动恢复</li>
										<li>硬件故障自动恢复</li>
									</ul>
								</div>
								<div class="col-md-4 for4">
									<ul>
										<li><img src="${_base }/resources/images/icon9.png"></li>
										<li class="icon_7img">快速</li>
										<li>提供用户身份认证及IP地址白名单</li>
										<li>双重安全控制，限定阿里云内网访</li>
										<li>问使得数据更安全。</li>
									</ul>
								</div>
							</div>


						</div>

						<div id="tc2" class="youis" style="display: none">
							<div class="youis_none">
								<p>
									<a name="C2">产品功能</a>
								</p>
							</div>
							<div class="chanp_biat">
								<ul>
									<li class="tisheng">提升应用和网站性能的利器：亚信云CCS</li>
									<li>加速你的世界！</li>
								</ul>
							</div>

							<div class="chanp_tow">
								<ul>
									<li class="red">热点数据访问</li>
									<li>实现热点数据的高速缓存，与数据库搭配能大幅提高应用的响应速度，极大缓解后端存储的压力。</li>
								</ul>
								<ul>
									<li class="red">兼容常用协议</li>
									<li>支持Key-Value的数据结构，兼容Memcached协议的客户端都可使用OCS服务。</li>
								</ul>
								<ul>
									<li class="red">安全机制</li>
									<li>提供用户身份认证及IP地址白名单双重安全控制，限定阿里云内网访问使得数据更安全。</li>
								</ul>
								<ul>
									<li class="red">监控与调整</li>
									<li>实支持Key-Value的数据结构，兼容Memcached协议的客户端都可使用OCS服务。</li>
								</ul>


							</div>

						</div>

						<div id="tc3" class="youis" style="display: none">
							<div class="youis_none">
								<p>
									<a name="C3">产品帮助</a>
								</p>
							</div>


							<div class="chanp_tow">
								<ul>
									<li class="pos">产品介绍</li>
									<li><A href="#">产品简介</A></li>
									<li><A href="#">适用场景</A></li>
									<li><A href="#">服务条款</A></li>
								</ul>
								<ul>
									<li class="pos"><A href="#">操作指南</li>
									<li><A href="#">代码示例</A></li>
									<li><A href="#">协议支持</A></li>
								</ul>
								<ul class="chul">
									<li class="pos">常见问题</li>
									<li><A href="#">多大的数据最适合存储在OCS上？</A></li>
									<li><A href="#">OCS的数据支持持久化吗？</A></li>
									<li><A href="#">OCS和本地Memcached的区别是什么？</A></li>
								</ul>
							</div>



						</div>

					</div>



				</div>
			</div>
		</div>
	</div>

	<!-- 对话框div -->
	<div class="modal fade" id="report_dialog" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="pop_up_dialog">
				<div class="pop_up_list_dialog">
					<ul>
						<li>系统提示</li>
						<li class="puc_c"><A href="#" data-dismiss="modal"
							style="margin-left: 240px;"><img
								src="${_base }/resources/images/sq_sh.png"></A></li>
					</ul>
				</div>
				<div class="pop_up_tab_dialog">
					<div class="xin_m">
						<ul>
							<li>
								<p id="report_content">系统出现异常，请联系管理员</p>
							</li>
						</ul>
						<ul>
							<li class="but_cip"><A href="#" data-dismiss="modal"
								style="margin-left: 100px;">确定</A></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 对话框div结束 -->
	<%@ include file="/jsp/common/footer.jsp"%>
</body>
</html>
