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
<script type="text/javascript">
//数据库中查找是否重复
function checkpassword(){
	//alert("不为空")
		 var url = "${_base}/audit/checkPs";
	 $.ajax({
			async : false,
			type : "POST",
			url : url,
			dataType : "json", //接受数据格式   
			data : {
				"userPwd" :  $('#oldPs').val(),
				"userEmail": $('#orldUserEmail').val() 
			},
			success : function(data) {
				//alert("DD:"+data.returnFlag)
				 if(data.returnFlag=="0"){ 
				//alert("原始密码不正确！") 
				  $('.warn1').css('display','none')
				  $('.warn11').css('display','inline-block')
				}
				if(data.returnFlag=="1"){ 
					//alert("原始密码正确！") 
					 $('.warn1').css('display','none')
					 $('.warn11').css('display','none')
					}
			} 
		}); 
	//alert("AJAX end")
}

// 原密码校验
  function checkLength1 (value) {
    var length=value;
    if (length.length>18 || length.length<6 ) {
      $('.warn1').css('display','inline-block')
    }else{
    	//alert("else")
    	checkpassword();
      //$('.warn1').css('display','none')
    };
  }
  
  
  
  // 新密码校验
  function checkLength2 (value) {
    var length=value;
    if (length.length>18 || length.length<6 ) {
      $('.warn2').css('display','inline-block')
    }else{
      $('.warn2').css('display','none')
    };
  }
  // 再次输入校验
  function checkLength3 (value) {
   var length=value;
   var length1=$('.new-key-info').val();
   //alert(length)
   //alert(length1)
   if (length!=length1) {
    $('.warn4').css('display','inline-block')
   }else{
    $('.warn4').css('display','none')
    $('.warn3').css('display','none')
   };
  }
  // 确认校验
  function checkForm(){
    $('.must').each(function(){
    	
      if ($(this).val()==null || $(this).val()=='' || $(this).val().length>18 || $(this).val().length<6)  {
        $(this).siblings('.warn5').css('display','inline-block');
      }else{   
    	 checkpassword();
         $(this).siblings('.warn5').css('display','none');
        /* alert($("#orldUserId").val());
        alert($("#oldPs").val());
        alert($("#newPs1").val());
        alert($("#newPs2").val()); */
      };
      
    })
    
    
    if($('.warn11').css('display')=="none" && $('.warn4').css('display')=="none" && $('.warn5').css('display')=="none"){
    	//alert("AJAX")
    	 if($("#newPs1").val()!=null && $("#newPs1").val()!='' && $("#newPs1").val()==$("#newPs2").val() ){
    	  var url = "${_base}/audit/updateUserPs";
        	 $.ajax({
     			async : false,
     			type : "POST",
     			dataType : "json", //接受数据格式   
     			url : url,
     			modal : true,
     			showBusi : false,
     			data : {
     				"userId" : $('#orldUserId').val(),
     				"oldPwd" : $.trim( $('#oldPs').val() ),
     				"newPwd" : $.trim( $('#newPs1').val() ),
     				"userEmail" : $('#orldUserEmail').val()
     			},
    			success : function(data) {
    				//alert("data.resultCode:"+data.resultCode)
     				if(data.resultCode=="000000"){ 
    				alert("密码修改成功") 
    				location.href=getContextPath() +"/audit/toLogin";	
    				//http://localhost:8080/iPaas-Web/audit/toLogin
    				}else{
    					alert("密码修改失败")  	
    				}
     			} 
     			
     		});
    	 }else{
	    		 if($("#newPs1").val()==null && $("#newPs1").val()=='' ){
	    			 $('.warn2').css('display','inline-block');
	    		 }
	    		 if($("#newPs2").val()==null && $("#newPs2").val()=='' ){
	    		 $('.warn3').css('display','inline-block');
	    		 }
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
					
						<div class="wrap-right">
					  		<div class="content-tittle">修改密码</div>
					        <div class="border-line"></div>
					        <ul class="fix-key">
					           <input type="hidden" id="orldUserId" value="${user.userId}" />
					           <input type="hidden" id="orldUserEmail" value="${user.userEmail}" />
					          <li>
					            <span class="last-key">原密码:</span>
					            <input type="password" id="oldPs" class="last-key-info must" onblur="checkLength1(this.value)">
					            <span class="warn warn1 warn5">请输入长度为6~18位的密码</span>
					            <span class="warn warn11 ">原始密码不正确密码</span>
					          </li>
					          <li>
					            <span class="new-key">新密码:</span>
					            <input type="password" id="newPs1"  class="new-key-info must" onblur="checkLength2(this.value)">
					            <span class="warn warn2 warn5">请输入长度为6~18位的密码</span>
					            <span class="warn warn4">两次输入的密码不同，请从新输入</span>
					          </li>
					          <li>
					            <span class="sure-again">再次确认:</span>
					            <input type="password" id="newPs2" class="sure-key-info must" onblur="checkLength3(this.value)">
					            <span class="warn warn3 warn5">请输入长度为6~18位的密码</span>
					            <span class="warn warn4">两次输入的密码不同，请从新输入</span>
					          </li> 
					        </ul>
					        <a href="myAccount"><button class="key-cancel">取消</button></a>
					        <button class="key-sure" onclick="checkForm()">确认</button>	
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