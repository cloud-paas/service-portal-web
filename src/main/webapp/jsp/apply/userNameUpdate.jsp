<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<%@ include file="/jsp/common/common.jsp"%>
<style type="text/css">
</style>
<script type="text/javascript">
	$(document).ready(function() {
		$("#list_2").addClass("xuanz");
	});
</script>
<script>
  // 新账户校验
  function checkLength(value){
    var length=value;
    if (length=='' || length==null) {
    	//alert("为空")
      $('.must-txt').css('display','inline-block');
      $('.must-txt2').css('display','none');
    }else{
    	unique();
    }
 }
  
  //数据库中查找是否重复
  function unique(){
	//alert("不为空")
	var result = false;
		 var url = "${_base}/audit/uniqueEmail_update";
 	 $.ajax({
			async : false,
			type : "POST",
			url : url,
			data : {
				"email" : $.trim( $('#newUserName').val()+"@asiainfo.com")
			},
			success : function(data) {
				//alert("DD:"+data)
				 if(data=="true"){ 
				//alert("数据库中没有，可以更改") 
				   $('.must-txt').css('display','none');
				   $('.must-txt2').css('display','none');
				   result= true;
				}else{
					//alert("数据库已存在，不能更改") 
					$('.must-txt').css('display','none');
					 $('.must-txt2').css('display','inline-block');
					 result = false;
				} 
			} 
		}); 
 	 return result;
	//alert("AJAX end")
  }
  
  // 确认校验
  function checkForm () {
    var value=$('.user-name').val();
    if (value==null || value=='') {
       $('.must-txt').css('display','inline-block');
     }else{
    	 unique();
    	// alert($('.must-txt2').css('display'))
    	 if($('.must-txt2').css('display')=="none"){
		// alert("UserId"+$('#orldUserId').val())
    	// alert($('#newUserName').val()+"@asiainfo.com")
    	 var url = "${_base}/audit/updatebyKey";
    	 $.ajax({
 			async : false,
 			type : "POST",
 			url : url,
 			modal : true,
 			showBusi : false,
 			data : {
 				"userId" : $('#orldUserId').val(),
 				"newEmail" : $('#newUserName').val()+"@asiainfo.com",
 				"oldEmail" : $('#orldUserEmail').val()
 			},
			success : function(data) {
 				if(data=="1"){ 
				alert("修改成功") 
				location.href=getContextPath() +"/audit/toLogin";	
				//http://localhost:8080/iPaas-Web/audit/toLogin
				}else{
					alert("修改失败")  	
				}
 			} 
 			
 		});  
    	 }
    	 
     }	  
  }

</script>
</head>
<body>
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
					
			
  				<div class="content-tittle">账户置换</div>
        		<div class="border-line border-line1"></div>
        		
        		<div class="new-user">
        		<div>原账户：
        		<span style="margin-left:15px;">${user.userEmail }</span>
        		<input type="hidden" id="orldUserId" value="${user.userId}" />
        		<input type="hidden" id="orldUserEmail" value="${user.userEmail }" />
        		</div><br><br>
          		<div style="margin-right:15px;">新账户：</div>
          		<input type="text" class="user-name" style="width:202px;font-size:16px;" onblur="checkLength(this.value)" id="newUserName">
          		<span class="mail-add" style="font-size:16px;">@asiainfo.com</span>
          		<span class="must-txt">请输入邮箱地址</span>
          		<span class="must-txt2">账户名重复,不能更改</span>
       			 </div>       
       				 <a href="myAccount"><button class="key-cancel">取消</button></a>
        			<button class="key-sure" onclick="checkForm()">确认</button></a>
  			
					
					</div>
				</div>
			</div>
		</div>
	</div>
	<!--页脚-->
	<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
</body>
</html>