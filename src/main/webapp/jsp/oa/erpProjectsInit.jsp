<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<html >
<head>
<%@ include file="/jsp/common/common.jsp"%>
	<title>Document</title>
	<style type="text/css">
		.box{width: 644px;height: 325px;background: #fff;border-radius: 3px;}
		.box-tittle{height: 60px;line-height: 60px;text-align: center;font-size: 20px;font-weight: bold;font-size: "微软雅黑"}
		.tittle{font-size: 16px;margin-left: 30px;}
		.search-input{width: 150px;height: 27px;border: 1px solid #ccc;border-radius: 3px;margin-top:30px;margin-left: 20px;}
		.search-btn{width: 90px;height: 29px;font-size:16px;background: #179ADE;color: #fff;border-radius: 3px;border: 0 none;margin-left: 20px;}
		.table-box{width: 590px;border-bottom: 1px solid #ccc;border-right: 1px solid #ccc;margin-bottom: 20px;margin-top: 30px;margin-left: 20px;}
		.table-box td{border-top: 1px solid #ccc;border-left: 1px solid #ccc;}
		.table-box tr{height: 30px;}
		.page{margin-left: 200px;color: #179ADE;}
		.page li{float: left;list-style: none;margin-right: 10px;}

		/*.table-box{}*/
	</style>
	
	<script src="${_base }/resources/js/common/prod_param_transfer.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		paging(1,"");
	});
	
	function paging(page,erpProjectCode) {	
		var erpProjectCode =$("#search-input-val").val();
		$.ajax({
					type : "POST",
					url : "${_base}/oa/queryerpProjectsList",
					dataType : "json",
					data : {
						page : page,
						erpProjectCode : erpProjectCode
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
						if (msg.resultCode == '000000') {
							if (msg.pageResult.resultList.length == 0) {
								$("#table_detail tbody").empty();
								var html = '';
								html += '<tr>';
									html += '<th>选择</th>';
									html += '<th>项目编码</th>';
									html += '<th>项目名称</th>';
								html += '</tr>';
								html += '<tr>';		
									html += '<td colspan="7">没有匹配的项目信息!</td>';								
								html += '</tr>';
								$('#table_detail').append(html)
								$('.fenye').css('display', 'none');
								return;
							}else{
									var options = {
										bootstrapMajorVersion : 3,
										currentPage : msg.pageResult.currentPage,//当前页面
										numberOfPages : 3,//一页显示几个按钮（在ul里面生成5个li）
										totalPages : msg.pageResult.totalPages//总页数
										}
									loadData(msg.pageResult.resultList);
									$('.fenye').css('display', 'block');
									$('#pageUl').bootstrapPaginator(options);
								}
						} else {
							$("#table_detail tbody").empty();
							var html = '';
							html += '<tr>';
								html += '<th>选择</th>';
								html += '<th>项目编码</th>';
								html += '<th>项目名称</th>';
							html += '</tr>';
							html += '<tr>';		
								html += '<td colspan="7">查询项目信息异常</td>';								
							html += '</tr>';
							$('#table_detail').append(html)
							$('.fenye').css('display', 'none');
							return;
						}
					},
					complete : function(XMLHttpRequest, textStatus) {						
						$('#loading').shCircleLoader('destroy');
					}
				});
	}
	
	//点击查询
	function pagingQuery(pageV,erpProjectCodeV){
		var page = pageV;
		var erpProjectCode = erpProjectCodeV;
		if(erpProjectCode==null ||erpProjectCode==undefined ||erpProjectCode==""){
			erpProjectCode=$("#search-input-val").val();
		}	
		paging(page,erpProjectCode);	
	}
	
	function loadData(obj) {
		if (!!obj && obj.length == 0) {
			$("#table_detail tbody").empty();
			var html = '';
			html += '<tr>';
				html += '<th>选择</th>';
				html += '<th>项目编码</th>';
				html += '<th>项目名称</th>';
			html += '</tr>';
			html += '<tr>';		
				html += '<td colspan="7">没有匹配的项目信息</td>';								
			html += '</tr>';
			$('#table_detail').append(html);
			$('.fenye').css('display', 'none');
			return;
		}
		$("#table_detail tbody").empty();
		var html = '';
		html += '<tr>';
			html += '<th>选择</th>';
			html += '<th>项目编码</th>';
			html += '<th>项目名称</th>';
		html += '</tr>';
		$.each(obj,function(n, item) {
				html += '<tr>';
					// 复选框
					html += '<td>';
							html += '<input  type="radio" name="projectRadio"  id="projectRadio"  style="height:10px;" onclick=checkRadioValue("'+ item.erpProjectCode+'","'+ item.erpProjectName+'"); >';
					html += '</td>';
					
					html += '<td >' + item.erpProjectCode    +'</td>';
					html += '<td >' + item.erpProjectName	+ '</td>';	
				html += '</tr>';
				
		});
		$('#table_detail tbody').append(html);		
	}
	
	function checkRadioValue(erpProjectCode,erpProjectName) {		
		$('#checkRadioValue').val(erpProjectCode+"_"+erpProjectName);					
	}
	
	function confirm(){
		
		var projectRadio = $("#checkRadioValue").val(); 
		if(projectRadio==""){
			$('#error_message').text("选择一个项目");
			return ;
		}
		arrs  = projectRadio.split("_");
		if($(window.parent.document).find("#isProject1").prop('checked')){			
			$(window.parent.document).find("#alertBox1").css('display','none');
			$(window.parent.document).find("#alertBox").css('display','none');
			$(window.parent.document).find("#costcenter_id1").text(arrs[0]);
			$(window.parent.document).find("#projectName1").text(arrs[1]);
			$(window.parent.document).find("#isProject2").attr("checked", false);
		}
		if($(window.parent.document).find("#isProject2").prop('checked')){			
			$(window.parent.document).find("#alertBox2").css('display','none');
			$(window.parent.document).find("#alertBox").css('display','none');
			$(window.parent.document).find("#costcenter_id4").text(arrs[0]);
			$(window.parent.document).find("#projectName4").text(arrs[1]);
			$(window.parent.document).find("#isProject1").attr("checked", false);
		}		
	}
	
</script>	
</head>
<body>
	<div class="box">
		<input type="hidden" name="checkRadioValue" id="checkRadioValue"></input>
		<span class="tittle">项目编码：</span>
		<input type="text" id="search-input-val" class="search-input">
		<button class="search-btn" onclick="pagingQuery(1,'')">查询</button>	
		<button class="search-btn" id="confirmButton" onclick="confirm()">确认</button>	
		<span id="error_message" style="margin-left:20px; font-size:14px; color:#F00;"></span>
		<table class="table-box"  id="table_detail" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<th>选择</th>
				<th>项目编码</th>
				<th>项目名称</th>
			</tr>			
			<tr>				
				<td></td>
				<td></td>
				<td></td>
			</tr>
		</table>
		<div  style="float:center;margin-top:-20px;">
	           <nav class="fenye" style="height:60px;">
							<span style="font-size: 14px;">
								<ul class="pagination" id="pageUl" style="width:350px;float:center">
								</ul>
							</span>							
			  </nav> 
		</div>
	</div>
</body>
</html>