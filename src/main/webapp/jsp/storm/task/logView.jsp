<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
  <head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<%@ include file="/jsp/storm/common/jsp/html_meta.jsp"%>
	<title>日志查看</title>
	<%@ include file="/jsp/storm/common/jsp/html_js.jsp"%>
	<style type="text/css">
	.adaptor_log{
		white-space:nowrap;
		text-overflow:ellipsis;
		-o-text-overflow:ellipsis;
		overflow: hidden;
	}
	</style>
	<script type="text/javascript">
	//获取web根路径
	var rootPath = "${_base}";
	//获取topologyId
	var topologyId = "${topologyId}";
	//当前打开日志数量
	var logsCount = 0;
	//logHeads的宽度
	var logHeadsWidth = 800;//根据样式
	//每个标题头的边缘占用宽度
	var logTitleEageWidth = 42;//根据样式
	//每个叉的宽度
	var forkWidth = 24;//根据样式
	//文档加载完后执行
	$(function(){
		//获取logsHead宽度
		//logHeadsWidth = $("#logHeads").width();
		//获取单个日志标题头的宽度
		//logTitleEageWidth = $("#logHeadDefualt").outerWidth(true) - $("#logHeadDefualt").innerWidth();
		//alert("logTitleEageWidth:"+logTitleEageWidth);
	});
	//触发主机的Select事件时绑定的函数
	function onHostSelect(option){
		//获取选中的主机ip
		var host = $(option).val();
		//展示该主机下的日志文件
		$("#logsList select").css({display:"none"});
		$("#logsList #" + host).css({display:"block"});
	}
	//出发文件select事件的绑定函数
	function onFileSelect(option){
		//获取该value值
		var id = $(option).val();
		if(id==="toSelete"){
			//alert("请选择文件！");
			return false;
		}
		//判断logsCount
		if(logsCount===0)
			$("#logHeadDefualt").css({display:"none"});
		//判断该日志文件是否已经加载
			
		//遍历ul中li的input:hidden标签，
		//设置标志位
		var flag = false;
		$("#logHeads").find("input:hidden").each(function(){
			var headId = $(this).val();
			if(headId===id){
				//如果与该标签的value值相等的话，说明该日志文件已经加载
				//进行显示操作

				//遍历logsBody
				$("#logsBody").find("input:hidden").each(function(){
					if($(this).val()===headId){
						//显示logBody
						var temp = $("#logsBody").children("div").css({display:"none"});
						$("#logsBody").children("div").css({display:"none"});
						$(this).parent().css({display:"block"}).addClass("rizhi_wj_inpu");
						flag = true;
						return true;
					}
				});
				//显示logHead
				$(this).parents("ul:first")
						.children("li")
						.removeClass("riz_tb");
				$(this).parent().addClass("riz_tb");
				return true;
			}
		});
		if(flag === false){
			//否则，通过window.location.href进行加载
			//获取主机及文件名
			var opt = id.split(",");
			var ip = opt[0];
			var file = opt[1];
			//创建logHead
			$("#logHeads li").removeClass("riz_tb");
			$("#logHeads").append('<li class="riz_tb"><input type="hidden" value="'+id+'"><A href="javascript:void(0);" onclick="showLog(this)" ><p>'+file+'</p><p class="x" onclick="closeLog(this,event);" >X</p></A></li>');
			//创建logBody,制定请求资源路径
			$("#logsBody div").css({display:"none"});
			//$("#logsBody").append('<div class="rizhi_wj_inpu"><input type="hidden" value="'+id+'"><iframe  name="host" class="riz_c" src="'+rootPath+'/storm/task/redirectLogView?start=0&hostName='+ip+'&fileName='+file+'&topologyId='+topologyId+'"></iframe></div>');
			$("#logsBody").append('<div class="rizhi_wj_inpu" style="height:314px;"><input type="hidden" value="'+id+'"><iframe  name="host" class="riz_c" src="'+rootPath+'/rcs/lookLog?start=0&hostName='+ip+'&fileName='+file+'&topologyId='+topologyId+'"></iframe></div>');
			//添加计数器
			logsCount++;
		}
		//进行宽度适配
		logsHeadAdaptor();
	}
	//展示日志
	function showLog(node){
		//获取日志id
		var id = $(node).parent().find("input:hidden").val();
		//选中日志头
		$("#logHeads li").removeClass("riz_tb");
		//显示logHead
		$(node).parent().addClass("riz_tb");
		//显示logBody
		$("#logsBody").find("input:hidden").each(function(){
			if($(this).val()===id){
				$("#logsBody").children("div").css({display:"none"});
				$(this).parent().css({display:"block"});
				return true;
			}
		});
		
	}
	//关闭日志
	function closeLog(node,event){
		//取消事件冒泡传播
		if ( event && event.stopPropagation )
			//因此它支持W3C的stopPropagation()方法
			event.stopPropagation(event);
			else
			//否则，我们需要使用IE的方式来取消事件冒泡
			window.event.cancelBubble = true;
		if(logsCount===0){
			alert("当前没有打开的日志文件可关闭！");
			return false;
		}
		//移除当前日志头和日志体
		var flag = confirm("您确定要关闭该日志吗？");
		if(flag===false)
			return false;
		var id = $(node).parents("li:first").children("input:hidden").val();
		$(node).parents("li:first").remove();
		$("#logsBody").find("input:hidden").each(function(){
			if($(this).val()===id){
				$(this).parent().remove();
				//var last = $(this).parents("div#logsBody").children("div:last");
				//last.css({display:"block"}).addClass("rizhi_wj_inpu");
				$("#logsBody").children("div:last").css({display:"block"});
				$("#logHeads li").removeClass("riz_tb").last().addClass("riz_tb");
				return false;				
			}
		});
		//是否为最后一个
		if(--logsCount===0){
			$("#logHeadDefualt").css({display:"inline"}).addClass("riz_tb");
			$("#logBodyDefault").css({display:"block"});
		}
		//
		$("#logHeadDefualt").siblings().each(function(){
			$(this).css({width:"auto"});
			//添加小数点样式
			$(this).find("p:first").css({width:"auto"});
		});
		logsHeadAdaptor();
	}
	//用于日志头的自适应宽度适配器
	function logsHeadAdaptor(){
		//var sz =  $("#logHeads li").size();
		if( logsCount >= 1 ){
			//计算当前总宽度
			var wid = 0;
			$("#logHeadDefualt").siblings().each(function(){
				wid += $(this).outerWidth(true);//包括边距的宽度
			});
			//判断总宽度与现有宽度
			if(wid > logHeadsWidth){
				//设置平均宽度
				var avWid = Math.floor(logHeadsWidth / logsCount);
				var titleWidth = avWid - logTitleEageWidth - forkWidth - 15;
				$("#logHeadDefualt").siblings().each(function(){
					$(this).width(avWid - ($(this).outerWidth(true)-$(this).width()));
					//添加小数点样式
					$(this).find("p:first").addClass("adaptor_log");
					$(this).find("p:first").width(titleWidth);
				});
			}else{
				
			}
		}
	}
	</script>
  </head>
  
  <body>
   <div class="big_k"><!--包含头部 主体-->
 
   <div class="container chanp"><div class="row">  <div class="navigation"><%@ include file="/jsp/common/header.jsp"%></div>
   
  <div class="row chnap_row">
  <jsp:include page="/jsp/common/leftMenu_new.jsp"></jsp:include>
  <div class="col-md-6 right_list">

						<div class="Open_cache">

							<div class="Open_cache_table">
								<ul>
									<li><a href="#">实时计算任务日志</a></li>
								</ul>
							</div>

							<!--我的服务-->
							<div class="fuw_search">
								<ul style="float: left; width: 320px;">
									<li style="font-size: 14px; line-height: 36px; width: auto;">主机列表：</li>
									<li style="width: 200px;"><select name="hosts"
										class="qxh_sele" onchange="onHostSelect(this);">
											<!-- 谷歌浏览器不支持option标签的onclick事件监听，所以在select标签中添加 -->
											<option value="toSelete">请选择</option>
											<c:forEach items="${logsOnHosts}"  var="topologyId"
												varStatus="vs">
												<option value="host${vs.count}">主机_${topologyId.key}</option>
											</c:forEach>
									</select></li>
								</ul>
								<ul style="float: left; width: 320px;">
									<li style="font-size: 14px; line-height: 36px; width: auto;">日志文件列表：</li>
									<li id="logsList" style="width: 200px;"><select
										id="toSelete" class="qxh_sele">
											<option value="toSelete">请先选择要查询的主机</option>
									</select> <c:forEach items="${logsOnHosts}" var="eachHost"
											varStatus="vs">
											<select id="host${vs.count}" onchange="onFileSelect(this);"
												class="qxh_sele" style="display: none;">
												<option value="toSelete">请选择</option>
												<c:forEach items="${eachHost.value}" var="eachLog"
													varStatus="vs">
													<option value="${eachHost.key},${eachLog}"
														onclick="onFileSelect(this);">${eachLog}</option>
												</c:forEach>
											</select>
										</c:forEach></li>
								</ul>
							</div>

							<div class="rizhi_wj">
								<div class="rizhi_wj_table">
									<ul id="logHeads">
										<li id="logHeadDefualt" class="riz_tb"><input
											type="hidden" value="nullLogHead"> <A
											href="javascript:void(0);" onclick="showLog(this)">
												<p>未打开日志</p>
										</A></li>
									</ul>
								</div>
								<div id="logsBody">
									<div id="logBodyDefault" class="rizhi_wj_inpu">
										<input type="hidden" value="nullLogBody">
									</div>
								</div>
								
								<div class="Open_cache_list_tow" style="vertical-align:middle;line-height:30px;padding:20px 0px 0px 75px">
									<a href="${_base}/rcs/toList" style="float:left">
								    	<div class="btn btn-primary">返回</div>
								    </a>
					           </div> 
							</div>
						</div>
					</div>
</div>

</div>
</div>
    <!--底部-->
    <jsp:include page="/jsp/common/footer.jsp"></jsp:include>
  </body>
</html>
