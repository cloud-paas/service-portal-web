<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<script type="text/javascript">
$(document).ready(function(){

	$('#against_apply').click(function(){
			var username = $('#username').val();
			var suggestion = $('#suggestion').val();
			$.ajax({
				type: 'POST',
				url: '${_base}/apply/approveApply',
				dataType: 'json',
				data:{username: username, suggestion:suggestion, checkResult: 2},
				beforeSend: function() {
					$('#loader').shCircleLoader({
						// 设置加载颜色
						color: '#F0F0F0'
					});
				},
				success: function(data){
					if (data.resultCode == '0000') {
						alert('驳回处理成功！');
						location.href = '${_base}/apply/applyAudit';
					} else {
						alert('驳回处理失败！');
					}
				},
				complete: function(){
					$('#loader').shCircleLoader('destroy');
				},
				error: function() {
					alert('系统异常，处理失败，请稍后再试');
				}
			
			});
	});
	
});
  </script>
</head>

<body class="non_bj">

	<div class="pop_up">

		<div class="pop_up_list">
			<ul>
				<li>审核意见</li>
				<li class="puc_c"><A href="#"><img src="images/sq_sh.png"></A></li>
			</ul>
		</div>

		<div class="pop_up_tab">

			<div class="xin_m">
				<ul>
					<li>
						<p class="xm_zi">姓名：</p>
						<p>
							<input name="username" id="username" type="text" class="xm_input">
						</p>
					</li>
					<li>
						<p class="xm_zi">意见：</p>
						<p>
							<textarea name="suggestion" id="suggestion" class="xm_input_c"></textarea>
						</p>
					</li>
				</ul>

				<ul>
					<li class="but_cip"><A href="#" id="against_apply">确定</A><a
						href="#" id="cancel_apply">取消</a></li>
				</ul>

			</div>

		</div>

	</div>
	 <div id="loader" style="width: 100px; height: 100px; position: absolute; top: 20%; left: 45%;hite; z-index:1002; overflow: auto;"></div>
     </div>

</body>
</html>
