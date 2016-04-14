<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<script type="text/javascript">
	var pageNo ="${pagingResult.currentPage}";
	var pageCount = "${pagingResult.totalPages}";
	$(document).ready(function() {
		var currentPage=pageNo;
		var totalPage=pageCount;
		var tag = "";
		var cc=9;
		if (totalPage <= cc) {
			for (var i = 1; i <= totalPage; i++) {
				tag += "<li><a href='javascript:void(0);' id='page_" + i +"'>" + i+ "</a></li>";
			}
		} else {
			if (currentPage <= parseInt(cc/2)+1) {
				for (var i = 1; i <= cc; i++) {
					tag += "<li><a href='javascript:void(0);'  id='page_"+ i +"'>" + i+ "</a></li>";
				}
			} else if (currentPage > (totalPage - parseInt(cc/2))) {
				var start = totalPage - (cc-1);
				for (var i = start; i <= totalPage; i++) {
					tag += "<li><a href='javascript:void(0);' id='page_"+i+"'>" + i+ "</a></li>";
				}
			} else {
				var start = currentPage - parseInt(cc/2);
				var end = parseInt(currentPage) + parseInt(cc/2);
				if (totalPage < end) {
					end = totalPage;
				}
				for (var i = start; i <= end; i++) {
					tag += "<li><a href='javascript:void(0);' id='page_"+i+"'>" + i+ "</a></li>";
				}
			}
		}
		$("#pi_last").parent().before($(tag));
		//当前页样式
		$("#page_" + currentPage).parent().addClass("active");
		if(currentPage==1){
			if(currentPage==totalPage){
				
			}else{
				$("#pi_last").parent().before($("<li><a href='javascript:void(0);' id='pi_next'>下一页</a></li>"));
			}
		}else{
			$("#pi_first").parent().after($("<li><a href='javascript:void(0);' id='pi_pre'>上一页</a></li>"));
			if(currentPage==totalPage){
				
			}else{
				$("#pi_last").parent().before($("<li><a href='javascript:void(0);' id='pi_next'>下一页</a></li>"));
			}
		}
		//
		$("#pi_first").bind("click", function() {
			if (currentPage == 1) {
				return;
			}
			search(1);
		});
		$("#pi_last").bind("click", function() {
			if (currentPage == totalPage) {
				return;
			}
			search(totalPage);
		});
		$("#pi_pre").bind("click", function() {
			if (currentPage <=1) {
				return;
			}
			search(parseInt(currentPage)-1);
		});
		$("#pi_next").bind("click", function() {
			if (currentPage == totalPage) {
				return;
			}
			search(parseInt(currentPage)+1);
		});
		var pages = $("a[id^='page_']");
		if (null != pages && pages != "") {
			var length = pages.length;
			for (var i = 0; i < length; i++) {
				$(pages[i]).click(
						function() {
							var id = $(this).attr("id");
							var pageIndex = id.substring(id
									.lastIndexOf("_") + 1,
									id.length);
							search(pageIndex);
						});
			}
		}
		//currentPage
		if(currentPage==1){
			$("#pi_pre").parent().addClass("disabled");
			$("#pi_first").parent().addClass("disabled");
			$("#pi_pre").parent().bind("click",function(){
				return false;
			});
			$("#pi_first").parent().bind("click",function(){
				return false;
			});
		}
		if(currentPage==totalPage){
			$("#pi_next").parent().addClass("disabled");
			$("#pi_last").parent().addClass("disabled");
			$("#pi_next").parent().bind("click",function(){
				return false;
			});
			$("#pi_last").parent().bind("click",function(){
				return false;
			});
		}
	});
</script>
<div class="paging_f">
	<c:choose>
		<c:when test="${pagingResult.totalCount<=0 }">
			<div style="text-align: center;">
				<span>未找到相关记录</span>
			</div>
		</c:when>
		<c:otherwise>
			<ul class="" style="">
				<li><a id="pi_first" href="javascript:void(0);">首页</a></li>
				<li><a id="pi_last" href="javascript:void(0);">末页</a></li>
			</ul>
		</c:otherwise>
	</c:choose>
</div>

<!-- 
<div style="padding:10px;">
	<small>系统为您找到了${pagingResult.totalPages}页、${pagingResult.totalCount}个结果</small>
</div>
-->
<!--分页结束 -->
