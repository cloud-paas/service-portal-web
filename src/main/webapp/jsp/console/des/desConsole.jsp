<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="zh-cn">
  <head>
    <%@ include file="/jsp/common/common.jsp"%>
   <link href="${_base }/resources/css/DES.css" rel="stylesheet">
   <script src="${_base }/resources/js/desConsole/DES.js"></script>
   <style>
   		.turnRight{width: 37px;height: 22px;background: url(${_base }/resources/images/turnRight.jpg) no-repeat;position: absolute;left: 330px;top: 128px;border: 0 none;}
.turnLeft{width: 39px;height: 24px;background: url(${_base }/resources/images/turnLeft.jpg) no-repeat;position: absolute;left: 329px;top: 173px;border: 0 none;}
   </style>
  </head> 
  
  
  <body>     
 <div class="big_k"><!--包含头部 主体-->   
   <!--导航-->
   <%@ include file="/jsp/common/header_console.jsp"%>
      
   <div class="container chanp">
   <%@ include file="/jsp/common/leftMenu_console.jsp"%>
  <div class="row chnap_row">
  
  <div class="col-md-6 right_list">
     <div class="content-tittle">实时增量数据获取服务DES</div>
			<div class="content-line"></div>
			<!-- DES表 -->
			<table border="0"  class="DES-table">
				<tr style="background:#f5f5f5">
					<td class="list-one">IPAAS ID</td>
					<td class="list-two">服务名称</td>
					<td class="list-three">绑定内容</td>
					<td class="list-four">编辑</td>
				</tr>
				
			</table>
			<!-- 绑定提示盒子开始 -->
			<div class="alertBox">							
				<label class="DBS-service">DBS服务:</label>
				<select class="DBS-service-txt">
					 
				</select>
				<label class="MDS-service">MDS服务:</label>
				<select class="MDS-service-txt" >	
					 
				</select>		
				<input id="signDes" type="hidden">	
				<button class="bind" onclick="bind()">绑定</button>
				<button class="cancel" onclick="cancel()">取消</button>
			</div>
			<!-- 绑定提示盒子结束 -->


			<!-- MDS服务密码弹窗开始 -->
			<div class="MDS-passwordBox">
				<div class="MDS-content1-tittle">DBS服务：</div>
				<input class="MDS-content1" readonly>
				<div class="MDS-content2-tittle">MDS服务：</div>
				<input class="MDS-content2" readonly>
				<input class="des_content" type="hidden">
				
				<label class="MDS-tittle">MDS服务密码:</label>
				<input type="text" class="MDS-txt">
				<button class="sure" onclick="validateMDS()">确定</button>
				<button class="cancel" onclick="cancel2()" >取消</button>
			</div>
			<!-- MDS服务密码弹窗结束 -->


			<!-- 绑定成功弹窗开始 -->
			<div class="bind-success">
				<img src="${_base }/resources/images/ok.jpg" class="bind-pic">
				<div class="bind-txt">已成功绑定</div>
				<div class="bind-edit" onclick="beforeTable()"><u style="cursor:pointer;">编辑观察表</u></div>
				<input type="hidden" id="bdes" >
				<input type="hidden" id="bdbs" >
				<input type="hidden" id="bmds" >
				<button class="bind-cancel" onclick="cancel1()">关闭</button>
			</div>
			<!-- 绑定成功弹窗结束 -->

			<!-- 编辑观察表提示盒子开始 -->
			<div class="editBox">
				<div class="edit-inform">编辑观察表</div>
				<div class="bind-no">未绑定:</div>
				<div class="edit-left">
					<ul class="turnUl" id="unboundTables">
						
					</ul>
				</div>
				<button class="turnRight"></button>
				<button class="turnLeft"></button>
				<div class="bind-yes">绑定:</div>
				<div class="edit-right">
					<ul class="turnUl" id="boundTables">
						
					</ul>
				</div>
				<input type="hidden" id="fdes">
				<input type="hidden" id="fdbs">
				<input type="button" class="editSure" value="确定" onclick="filterTable()">
				<input type="button" class="editCancel" value="取消" onclick="editNone()">
			</div>
			<!-- 编辑观察表提示盒子结束 -->
            
			 
			 
			 
			 
			 
			 
			 
		
     
    
 
  </div>
</div>

</div>
</div>  
    
   
    
    <!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
</body>
<script type="text/javascript">
	$(document).ready(function() {
		// 页面初始化
	
		queryDesList();	
	
	});	
  function queryDesList(){
		
		 
		$.ajax({
			type:"POST",
			url:"${_base}/desConsole/queryDesList",
			dataType:"json",
			data:{},
			success: function(data){
				 
				if(data.resultCode=="999999")
				{
					//alert(data.resultMessage);
					Modal.alert({
  						msg : data.resultMessage
  					});
					
				}else { 
					loadData(data.desList);
				}
			}
		})
	}
  
  function loadData(obj) {
		
		 
		$(".DES-table").empty();
		if(obj!=null&&obj.length!=0)
		{
			var html='';
			html+="<tr style=\"background:#f5f5f5\">";
			html+="<td class=\"list-one\">IPAAS ID</td>";
			html+="<td class=\"list-two\">服务名称</td>";
			html+="<td class=\"list-three\">绑定内容</td>";
			html+="<td class=\"list-four\">编辑</td>";
			html+="</tr>"
		 
			$.each(obj,function(n,item){
			 	//console.log(item.serviceId);
				html+="<tr>";
				html+="<td class=\"list-one\">"+item.serviceId+"</td>";
				html+="<td class=\"list-two\">"+item.serviceName+"</td>";
				if(item.dbsServiceId!=null&&item.dbsServiceId!="")
				{
					//html+="<td class=\"list-three\">"+limitLEngth(item.dbsServiceId,item.mdsServiceId,item.boundTables)+"</td>";
					html+="<td class=\"list-three\" class='"+"section"+n+"' onmouseover=\"checkValue1('"+n+"')\" onmouseout=\"checkValue2('"+n+"')\" style=\"position:relative;\"><span style=\"margin-right:15px;\">DBS服务:"+item.dbsServiceId+"</span><span style=\"margin-right:15px;\" >MDS服务:"+item.mdsServiceId+"</span><span class='"+"liu"+n+"'>"+limitLEngth(item.boundTables)+"</span><div class='"+"all"+n+"' style=\"background:#fff;width:408px;word-break:break-all;display:none;top:0px;z-index:2;border:1px solid #ccc;border-radius:3px;position:absolute;left:0px;\">DBS服务:"+item.dbsServiceId+" "+"MDS服务:"+item.mdsServiceId+" "+"绑定的参数表:"+item.boundTables+"</div></td>";
					html+="<td class=\"list-four\"><a href=\"#\" onclick=\"desUnbind('"+item.serviceId+"','"+item.dbsServiceId+"','"+item.mdsServiceId+"')\">解绑</a>/<a href=\"#\" onclick=\"searchTable('"+item.serviceId+"','"+item.dbsServiceId+"','"+item.mdsServiceId+"')\"> 编辑观察表</a></td>";
				}else{
					html+="<td class=\"list-three\"></td>";
					html+="<td class=\"list-four\"><a href=\"#\" onclick=\"getdesBindParam('"+item.serviceId+"')\">绑定</a></td>";
				}
				
				html+="</tr>"
			});
			$(".DES-table").append(html);
		}else{
				
				Modal.alert({
						msg : 'DES服务未开通无法进行绑定!'
					});
		}
	}
  
  	function validateMDS()
  	{
  		
  		var pwd=$(".MDS-txt").val();
  		var mdsid=$(".MDS-content2").val();
  		var dbsid=$(".MDS-content1").val();
  		var serviceId=$(".des_content").val();
  		$.ajax({
  			type:"POST",
  			url:"${_base}/desConsole/validateMDS",	
  			data:{
  				password: pwd,
  				mdsService: mdsid
  			},
  			success:  function(data){
  				if(data.returnFlag=="0")
  				{
  					//alert(data.returnMessage);
  					Modal.alert({
						msg :  data.returnMessage
					});
  					
  				}else{
  						//alert("认证成功");
  						Modal.alert({
  							msg : "MDS密码认证成功"
  						});
  				 		desBind(serviceId,dbsid,mdsid,pwd);
  				}
  			}
  		})
  	}
  	function desBind(serviceId,dbsid,mdsid,pwd)
  	{
  		 
  		 
  		var desService=serviceId;
  		var mdsService=mdsid;
  		var dbsService=dbsid;
  		var password= pwd;
  		$.ajax({
  			type:"POST",
  			url:"${_base}/desConsole/desBind",
  			data:{
  				desServiceId: desService,
  				mdsServiceId: mdsService,
  				dbsServiceId: dbsService,
  				mdsPassword: pwd
  			},
  			success: function(data){
  				if(data.resultCode=="999999")
  				{
  					//alert("绑定失败");
  					Modal.alert({
							msg : "绑定失败！"
						});
  				}else{
  					$(".MDS-txt").val("");
  					$('.MDS-passwordBox').css('display','none');
  					$("#bdes").val(desService);
  					$("#bmds").val(mdsService);
  					$("#bdbs").val(dbsService);
  					 $('.bind-success').css('display','block');
  					
  					}
  			}

  		})
  	}
  	function getdesBindParam(serviceId)
  	{
  		var myServiceId=serviceId;
  		
  		$.ajax({
  			type:"POST",
  			url:"${_base}/desConsole/getBindParam",
  			data:{
  					
  			},
  			success: function(data){
  				 
  				 
				if(data.resultCode=="999999")
				{
					//alert(data.resultMessage);
					Modal.alert({
						msg : data.resultMessage
					});
					
				}else { 
						 
					 $(".DBS-service-txt").empty();
					 $(".MDS-service-txt").empty();
					 var dbs='';
					 var mds='';	
					 var dbslist=data.dbsList;
					 var mdslist=data.mdsList;
					 $.each(dbslist,function(n,item){
						 
						 dbs+='<option>'+item+'</option>';
					 });
					 $.each(mdslist,function(n,item1){
						  
						 mds+='<option>'+item1+'</option>';
					 });

					 $(".DBS-service-txt").append(dbs);
					 $(".MDS-service-txt").append(mds);
					 $("#signDes").val(myServiceId);
					 $('.alertBox').css('display','block');
					 
				}
			
  			}
  		})
  	}
  	
  	function bind(){
  		var dbsServiceId=$(".DBS-service-txt").val();
  		var mdsServiceId=$(".MDS-service-txt").val();
  		var desServiceId=$("#signDes").val();
  		$(".MDS-content1").empty();
  		$(".MDS-content2").empty();
  		$(".MDS-content1").val(dbsServiceId);
  		$(".MDS-content2").val(mdsServiceId);
  		$(".des_content").val(desServiceId);
  		 $('.alertBox').css('display','none');
  		$('.MDS-passwordBox').css('display','block');
  		 
  		 
  	}
  	function searchTable(desService,dbsService,mdsService){
  		var myserviceId=desService;
  		var mydbs=dbsService;
  		var	mymds=mdsService;
  		$.ajax({
  			type:"POST",
  			url:"${_base}/desConsole/getTableInfo",
  			data:{
  				serviceId:myserviceId
  			},
  			success: function(data){
  				if(data.resultCode=="999999")
  				{
  					//alert(data.resultMessage);
  					Modal.alert({
						msg : data.resultMessage
					});
  					
  				}else{
  				
  						var unbound='';
  						var bound='';
  						$("#unboundTables").empty();
  						$("#boundTables").empty();
  						$.each(data.unboundTable,function(n,item){
  							unbound+="<li onclick=\"addEvent('"+"l"+n+"')\" class='"+"l"+n+"'>"+item+"</li>";
  						})
  						$.each(data.boundTable,function(n,item){
  							bound+="<li onclick=\"addEvent('"+"r"+n+"')\"  class='"+"r"+n+"'>"+item+"</li>";
  						})
  						$("#unboundTables").append(unbound) ;
  						$("#boundTables").append(bound) ;
  						 $('.bind-success').css('display','none');
  						 $("#fdes").val(myserviceId);
  						 $("#fdbs").val(mydbs);
  						 
  						$(".editBox").css('display','block');
  						
  					}
  			}
  		})
  	}
  	
  	function desUnbind(serviceId,dbsServiceId,mdsServiceId)
  	{
  		var my_des=serviceId;
  		var my_dbs=dbsServiceId;
  		var my_mds=mdsServiceId;
  		$.ajax({
  			type:"POST",
  			url:"${_base}/desConsole/desUnbind",
  			data:{
  				serviceId:	my_des,
  				dbsServiceId:	my_dbs,
  				mdsServiceId:	my_mds
  			},
  			success: function(data){
  				if(data.resultCode=="999999")
  				{
  					//alert("DES解绑失败!");	
  					Modal.alert({
  						msg : "DES解绑失败!"
  					});
  				}else{
  					//alert("DES解绑成功!");
  					Modal.alert({
  						msg : "DES解绑成功!"
  					});
  					queryDesList();	
  				}
  			}
  		})
  	}
  	
  	function filterTable()
  	{
  		var tableArray=new Array();
  		var num=$("#boundTables li").length;
  		//console.log(num);
  		for(var i=0;i<num;i++)
  		{
  			tableArray[i]=$("#boundTables  li").eq(i).html();
  		}
  		
  		var my_des=$("#fdes").val();
  		var my_dbs=$("#fdbs").val();
  		var jsondata={
  				"serviceId":	my_des,
  				"dbsServiceId":	my_dbs,
  				"tables":  tableArray
  		}
  		var data1=JSON.stringify(jsondata);	
  		//alert(data1);
  		$.ajax({
  			type:"POST",
  			url:"${_base}/desConsole/filterTable",
  			data: "jsondata="+data1,
  			dataType: "JSON",
  			success: function(data)
  			{
  				if(data.resultCode=="999999")
  				{
  					//alert("设置观察表失败！");
  					Modal.alert({
  						msg : "设置观察表失败！"
  					});
  				}else{
  					//alert("设置观察表成功");
  					Modal.alert({
  						msg : "设置观察表成功!"
  					});
  					
  					$(".editBox").css('display','none');
  					queryDesList();	
  				}
  			}
  		})
  		 
  	}
  	function beforeTable(){
  		 
  		var des=$("#bdes").val();
  		var dbs=$("#bdbs").val();
  		var mds=$("#bmds").val();
  		
  		searchTable(des,dbs,mds);
  	}
  	function cancel(){
  		$(".DBS-service-txt").empty();
  		$(".MDS-service-txt").empty();
  		$("#signDes").val("");
  		$('.alertBox').css('display','none');
  		
  	}
  	
  	function cancel1(){
  		$("#bdes").val("");
  		$("#bdbs").val("");
  		$("#bmds").val("");
  		$('.bind-success').css('display','none');
  		queryDesList();	
  	}
  	function cancel2(){
  		$(".MDS-content1").val("");
  		$(".MDS-content2").val("");
  		$(".des_content").val("");
  		$(".MDS-txt").val("");
  		$('.MDS-passwordBox').css('display','none');
  		
  		
  	}
  	function editNone(){
  		$('.editBox').css('display','none');
  		$('.edit-right turnUl ').empty();
  		$('.edit-left turnUl ').empty();
  		$('#fdes').val("");
  		$('#fdbs').val("");
  		
  	}
  	
  	function limitLEngth(tables){

  		var tarray=tables;
  		//console.log(tarray);
  		
  		if(tarray==null||tarray.length==0)
  		{
  			var str="";
  		}else{
  			var str="绑定的参数表:"+tarray;
  		}
  		
  		var strtmp=str.substr(0,6);
  		var maxlength=6;
  		if(str.length>maxlength){
  			return strtmp+"...";
  		}else{
  			return str;
  		}
  	}
  	function checkValue1(n){
  		if($('.liu'+n+'').html()==null || $('.liu'+n+'').html()==''){
  			$('.all'+n+'').css('display','none');
  		}else{
  			$('.all'+n+'').css('display','inline-block');
  		}
  		

  	}
  	function checkValue2(n){
  		$('.all'+n+'').css('display','none');

  	}
  	
  	
  	
  </script>
 
</html>
