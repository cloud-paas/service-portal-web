<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<script type="text/javascript">
		$(document).ready(function(){
			$("#navi_tab_contactUs").addClass("chap");
		});
		
	</script>
</head>

<body>
<div class="big_k">
	<!-- 头部和导航条 -->

	
	
    <div class="container-fluid chanp">
   <div class="row"> <%@ include file="/jsp/common/header.jsp"%></div>
   <div class="row">   
  
		   <script>
		   	$(document).ready(function(){
		   		$('a[id^=active_]').each(function(){
		   			$(this).css('color', '#949494');
		   		});
		   		$('#active_help').css('color', '#1699dc');
		   	});
   </script>

			<div class="row chnap_row xing_zx">

				<div class="col-md-6 right_list">

					<div class="Open_cache">

						<div class="lianx_w">
							<ul class="li_x">
								<li>联系人：陈小明</li>
								<li>电话：7474741</li>
								<li>邮箱： chenxm@asiainfo.com</li>
								<li>地址：北京市海淀区西北旺东路10号院东区 亚信大厦</li>
								<li>QQ交流群：8216 6699</li>
							</ul>
							<ul>
								<li><img src="${_base }/resources/images/lxwm.png"></li>
							</ul>
						</div>
					</div>
				</div>
			</div>

		</div>

	
</div>
	<%@ include file="/jsp/common/footer.jsp"%>
</body>
</html>
