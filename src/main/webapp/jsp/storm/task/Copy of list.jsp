<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<%@ include file="/jsp/storm/common/jsp/html_meta.jsp"%>
<title>查询</title>
<%@ include file="/jsp/storm/common/jsp/html_js.jsp"%>
<script type="text/javascript">
	function search(p){
		var url = "${_base}/storm/task/toList?page="+p+"&searchName="+encodeURI(encodeURI($("#searchName").val()));
		location.href=url;
	}
	$(function(){
	});
</script>
</head>
<body>
    <jsp:include page="/jsp/common/header.jsp"></jsp:include>
    <div class="row chnap_row">
        <%@ include file="/jsp/common/leftMenu.jsp"%>
        <div class="col-md-6 right_list">
            <div class="row" style="margin-top: 10px;">
                <div class="col-md-12">
                    <form class="form-inline">
                        <div class="form-group">
                            <div class="input-group">
                                <input type="text" class="form-control" id="searchName" placeholder="" style="width: 400px;">
                            </div>
                        </div>
                        <button type="button" class="btn btn-primary" id="btn_search">查询</button>
                        <button type="button" class="btn btn-info"
                            onclick="location.href='${_base}/storm/task/toRegisterTask'"
                        >注册</button>
                        <button type="button" class="btn btn-primary btn-sm" name="btn_start" id="btn_start"
                        >启动</button>
                        <button type="button" class="btn btn-danger btn-sm" name="btn_stop" id="btn_stop"
                        >停止</button>
                        <button type="button" class="btn btn-warning btn-sm" name="btn_cancel" id="btn_cancel"
                        >注销</button>
                        <button type="button" class="btn btn-info btn-sm" name="btn_edit" id="btn_edit"  taskId="${v.id }">编辑</button>
                    </form>
                </div>
            </div>
            <div class="row" style="margin-top: 10px;">
                <div class="col-md-12">
                    <table class="table table-striped" style="word-break: break-all; word-wrap: break-word;">
                        <tr>
                            <td>选择</td>
                            <td width="100">任务名称</td>
                            <td>集群</td>
                            <td>work数量</td>
                            <td>注册时间</td>
                            <td>注销时间</td>
                            <td width="100">任务说明</td>
                            <td>状态</td>
                        </tr>
                        <c:forEach var="v" items="${pagingResult.resultList}" varStatus="vs">
                            <tr>
                                <td><input type="radio" name="taskId" value="${v.id }" ${vs.first?'checked':'' }/></td>
                                <td name="subText" subSize="10">${v.name}</td>
                                <td>${v.clusterId}</td>
                                <td>${v.numWorkers}</td>
                                <td>
                                    <fmt:formatDate value="${v.registerDt}" type="both" pattern="yyyy-MM-dd HH:mm:ss" />
                                </td>
                                <td>${v.cancelDt}</td>
                                <td name="subText" subSize="10">${v.comments}</td>
                                <td>
                                    <c:if test="${v.status eq '-1'}">已注销</c:if>
                                    <c:if test="${v.status eq '0'}">已注册</c:if>
                                    <c:if test="${v.status eq '1'}">正在运行</c:if>
                                    <c:if test="${v.status eq '2'}">已停止</c:if>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                    <jsp:include page="/jsp/storm/common/jsp/page.jsp"></jsp:include>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/jsp/common/footer.jsp"></jsp:include>
    <script type="text/javascript">
		$(function() {
			$("button[name='btn_start']").bind("click", function() {
				$(this).addClass("disabled");
				var url = "${_base}/storm/task/operTask?operType=start&id=" + $("input[name='taskId']:checked").val();
				var param = "";
				ajaxSubmitAsync_my(url, param, "启动实时任务成功喽~", "${_base}/storm/task/toList", "btn_start");
			});
			$("button[name='btn_stop']").bind("click", function() {
				$(this).addClass("disabled");
				var url = "${_base}/storm/task/operTask?operType=stop&id=" + $("input[name='taskId']:checked").val();
				var param = "";
				ajaxSubmitAsync_my(url, param, "停止实时任务成功喽~", "${_base}/storm/task/toList", "btn_stop");
			});
			$("button[name='btn_cancel']").bind("click", function() {
				$(this).addClass("disabled");
				var url = "${_base}/storm/task/operTask?operType=cancel&id=" + $("input[name='taskId']:checked").val();
				var param = "";
				ajaxSubmitAsync_my(url, param, "注销实时任务成功喽~", "${_base}/storm/task/toList", "btn_cancel");
			});
			$("#btn_search").bind("click", function() {
				search(1);
			});
		});
	</script>
</body>
</html>