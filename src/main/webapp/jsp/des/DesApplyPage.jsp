<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
 
<!DOCTYPE html>
<html lang="zh-cn">
  <head>
<%@ include file="/jsp/common/common.jsp"%>
  </head> 
<script type="text/javascript">
$(document).ready(function(){
	$("#${list_index}").attr('style', 'margin-top:2px;color:#1699dc');
	$("#navi_tab_product").addClass("chap");
	//openOCSController = new $.OpenOCSController();
	//$("#my_size").find("option[value='${userCacheResultVo.cache_memory}']").attr("selected",true);
});
</script>
<script>
   	$(document).ready(function(){
   		$('a[id^=active_]').each(function(){
   			$(this).css('color', '#949494');
   		});
   		$('#active_prod').css('color', '#1699dc');
//    		$('.mune_2').css('padding-left', '1%');
   		
});
</script>

  <body>   
  <!-- 遮盖层   -->
  <div class="waitCover" >
	 <img  src="${_base }/resources/images/waitPng.png" class="waitPng" >
	 <div class="waitTxt">正在加载请稍后...</div>
  </div>
  <div class="big_k"><!--包含头部 主体-->   
   <!--导航-->
   <div class="navigation">
 		<%@ include file="/jsp/common/header.jsp"%>
   </div>
   
   <div class="container chanp">
   
  <div class="row chnap_row">
 	 <%@ include file="/jsp/common/leftMenu_new.jsp"%>
  <div class="col-md-6 right_list">
     
     <div class="Open_cache">
        <div class="Open_cache_table">
			<ul style="border-bottom:1px #eee">
			<li><a href="#">实时增量数据获取服务</a></li> 
			</ul>  
        </div>  
          <form id="myForm">
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
	          	<div class="Open_cache_list_tow">
	          		 <ul>
			          <li class="font-title">产品名称：</li>
			          <li class="font-title">实时增量数据获取服务</li> 
		          	</ul>
	         		<ul>
			          <li class="font-title">服务名称：</li>
			          <li><input id="my_name" type="text" class="form-control must"aria-describedby="sizing-addon2" onblur="limitName(this.value)"></li>
			          <li><label class="check-must check-name" style="display:none; color:red">* 必填项</label></li>
		          	</ul>
	         		<ul>
			          <li class="font-title">服务密码：</li>
			          <li><input id="my_password" type="text" class="form-control must"aria-describedby="sizing-addon2" onblur="limitPassword(this.value)"></li>
			          <li><label class="check-must check-password" style="display:none;color:red;">* 长度为6-16位字符</label></li>
		          	</ul>
					<ul>
			          <li class="font-title">计算方式：</li>
			          <li class="font-title">永久免费</li> 
		          	</ul>
					<ul style="padding-left:10%">   
			          <li style="position:relative;">
						<div style="margin-top:20px;text-align:center;-moz-border-radius: 15px;border-radius: 15px;width:130px;height:30px;background:rgb(121,189,90);line-height:30px;vertical-align:middle;color:#fff;cursor:pointer;" onclick="applyDes()">立即开通</div>
					 	<span class="warning" style="color:red;position:absolute;top:23px;left:170px;width:120px;display:none;">* 红色区域必填项</span>
					 	
					  </li> 
		          	</ul> 
	           </div>                
	        </div>  
    	</div>  
    	</form> 
     </div> 
 
  </div>
</div>

</div>
</div>  
<!--页脚-->
			 
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include> 
  </body>
</html>
<script type="text/javascript">
//用户名
function limitName(value){
	var name=value;
	if(name=='' || name==null){
		$('.check-name').css('display','inline-block');
	}else{
		$('.check-name').css('display','none');
	}
}
//密码
function limitPassword(value){
	var password=value;
	if(password.length<=5 || password.length>=17){
		$('.check-password').css('display','inline-block');
	}else if(password=='' || password==null){
		$('.pass-check').css('border','1px solid red')			
	}else if(password.length<=16 || password.length>=6){
		$('.check-password').css('display','none');
	}
}
function checkLength(){
	var pwd=$('#my_password').val();
	var flag3=true;
	if(pwd.length<=5 || pwd.length>=17){
		flag3=false;
	}
	return flag3;
}

	function checkData () {
		var flag1=true;
		$('.must').each(function(){
			if ($(this).val()==null || $(this).val()=='') {
				$(this).parent('li').siblings().children('label').css('display','inline-block');
				$('.warning').css('display','inline-block');
				flag1=false;
			}	
		})
		return flag1;
	}

	function applyDes(){
		if(!checkData()){
			return;
		};//非空校验
		if(!checkLength()){
			return;
		};//非空校验
		$('.waitCover').show();
		$('.warning').css('display','none');
		var myserviceName=$('#my_name').val();
		var myservicePwd=$('#my_password').val();
		
		$.ajax({
			async:true,
			type:"POST",
			url : "${_base}/des/desApply",
			data:{
				serviceName: myserviceName,
				serivcePwd:	 myservicePwd
				
			},
			success: function(data){
			 	
				
				 //alert(data.message);
				 
				if(data!=null&&data.code=="0000")
				{
					$('.waitCover').hide();
					location.href=getContextPath() +"/mcs/applyCompleted?prod=DES";	//&url=/des/DesApplyPage&prodType=1

				}else{					
					alert(data.message);
					$('.waitCover').hide();
				}
			}
			
		})
	}
</script>
