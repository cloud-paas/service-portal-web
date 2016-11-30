<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<head>
<title>${prodName}</title>
<%@ include file="/jsp/common/common.jsp"%>
<script src="${_base }/resources/js/storm/jquery.form.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// 页面初始化
		queryDssList();	

	});	
	function queryDssList() {
		$.ajax({
					type : "POST",
					url : "${_base}/rdsConsole/queryRdsList",
					dataType : "json",
					data : {
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
							if (msg.resultList.length == 0) {
							
								$("#table_detail tbody").empty();
								var html = '';
								html += '<tr>';		
								html += '<th>产品名称</th>';
								html += '<th>服务名称</th>';
								html += '<th>IPAAS编码</th>';	
								html += '<th>IP地址</th>';								
								html += '<th>端口</th>';
								html += '<th>操作</th>'; 		
								html += '</tr>';
								
								html += '<tr>';		
								html += '<td colspan="7">您查询的数据不存在</td>';								
								html += '</tr>';									
								$('#table_detail tbody').append(html);								
								return;
							}		
							if(indexFlag == '1'){								
								$('#infomatin').hide();
							}else{
								loadData(msg.resultList);
								$('#infomatin').show();
							}
							
						} else {
							//alert("查询不到数据");
							$("#table_detail tbody").empty();
							var html = '';
							html += '<tr>';		
							html += '<th>产品名称</th>';
							html += '<th>服务名称</th>';
							html += '<th>IPAAS编码</th>';	
							html += '<th>IP地址</th>';							
							html += '<th>端口</th>';
							html += '<th>操作</th>'; 		
							html += '</tr>';
							
							html += '<tr>';		
							html += '<td colspan="7">您查询的数据不存在</td>';								
							html += '</tr>';									
							$('#table_detail tbody').append(html);								
							return;
						}
					},
					complete : function(XMLHttpRequest, textStatus) {
						$('.fenye').css('display', 'block');
						$('#loading').shCircleLoader('destroy');
					},
					error : function() {
						report('系统发生异常，数据加载失败，请登陆后重新尝试。');
						$('.fenye').css('display', 'none');
					}
				});

	}
	
	function loadData(obj) {
		if (!!obj && obj.length == 0) {
			$("#table_detail tbody").empty();
			var html = '';
			html += '<tr>';	
			html += '<th>产品名称</th>';
			html += '<th>服务名称</th>';
			html += '<th>IPAAS编码</th>';	
			html += '<th>IP地址</th>';			
			html += '<th>端口</th>';
			html += '<th>操作</th>'; 		
			html += '</tr>';
			
			html += '<tr>';		
			html += '<td colspan="7">您查询的数据不存在</td>';								
			html += '</tr>';									
			$('#table_detail tbody').append(html);								
			return;
		}
		$("#table_detail tbody").empty();
		var html = '';
		html += '<tr>';		
		html += '<th>产品名称</th>';
		html += '<th>服务名称</th>';
		html += '<th>IPAAS编码</th>';	
		html += '<th>IP地址</th>';			
		html += '<th>端口</th>';
		html += '<th>操作</th>'; 			
		html += '</tr>';
		
		$
				.each(
						obj,
						function(n, item) {
							var incIp1 = '';
							var incIp2 = '';
							var incIp3 = '';
							var incPort1= '';
							var incPort2= '';
							var incPort3='';
							if(item.userServBackParamMap !=undefined){
								if(item.userServBackParamMap.incSimList[1] !=undefined){
									incIp1 =item.userServBackParamMap.incSimList[1].incIp 
								}
								if(item.userServBackParamMap.incSimList[2] !=undefined){
									incIp2 =item.userServBackParamMap.incSimList[2].incIp 
								}
								if(item.userServBackParamMap.incSimList[3] !=undefined){
									incIp3 =item.userServBackParamMap.incSimList[3].incIp 
								}
								if(item.userServBackParamMap.incSimList[1] !=undefined){
									incPort1 =item.userServBackParamMap.incSimList[1].incPort 
								}
								if(item.userServBackParamMap.incSimList[2] !=undefined){
									incPort2 =item.userServBackParamMap.incSimList[2].incPort 
								}
								if(item.userServBackParamMap.incSimList[3] !=undefined){
									incPort3 =item.userServBackParamMap.incSimList[3].incPort 
								}
							}
							html += '<tr >';
							// 产品名称
							html += '<td>' + item.prodName + '</td>';
							// 服务名称
							html += '<td >' +item.userServBackParamMap.incSimList[0].incName + '</td>';			
							// IPAAS编码
							html += '<td>' + item.userServIpaasId + '</td>';
							
							// IP地址
							html += '<td> 主：' 
							+ item.userServBackParamMap.incSimList[0].incIp ;
							if(item.userServBackParamMap.incSimList[1] !=undefined){
								html += '<br/>从：'
								+incIp1 
								+'&nbsp;&nbsp;'
								+incIp2
								+'&nbsp;&nbsp;'
								+incIp3
								+'&nbsp;&nbsp;';
							}
							
							html += '</td>';
							
							// 端口
							html += '<td> 主：' 
							+ item.userServBackParamMap.incSimList[0].incPort ;
							if(item.userServBackParamMap.incSimList[1] !=undefined){
								html += '<br/>从：'
								+incPort1 
								+'&nbsp;&nbsp;'
								+incPort2
								+'&nbsp;&nbsp;'
								+incPort3
								+'&nbsp;&nbsp;';
							}						
							html += '</td>';
							
							//操作
							html += '<td style="font-size:14px" align="left">' 
								+'<a onclick="stopRdsContainer('+item.userServBackParamMap.incSimList[0].id+');" style="cursor: pointer;">'+"停用"+'</a>'
								+'<a onclick="starRdsContainer('+item.userServBackParamMap.incSimList[0].id+');" style="cursor: pointer;">'+"启用"+'</a>'
								+'<a onclick="destroyRdsContainer('+item.userServBackParamMap.incSimList[0].id+','+item.userServId+');" style="cursor: pointer;">'+"注销"+'</a>'
								+'<a  href="queryRdsListById?userServId='+item.userServId+'" style="cursor: pointer;">'+"查看"+'</a>'
								+'<a onclick="manageRds(\''+item.userServBackParamMap.incSimList[0].incIp+'\','+item.userServBackParamMap.incSimList[0].incPort
										+',\''+item.userServBackParamMap.incSimList[0].rootName+'\',\''+item.userServBackParamMap.incSimList[0].rootPassword+'\');" style="cursor: pointer;">'+"管理"+'</a>'
								+ '</td>';
							html += '</tr>';
							
							/**
							html += '<td style="font-size:14px" align="left">' 
							+'<a onclick="stopRdsContainer(/g'+item.userServIpaasId+'/g);" style="cursor: pointer;">'+"停用"+'</a>'
							+'<a onclick="starRdsContainer(/g'+item.userServIpaasId+'/g);" style="cursor: pointer;">'+"启用"+'</a>'
							+'<a onclick="destroyRdsContainer(/g'+item.userServIpaasId+'/g,'+item.userServId+');" style="cursor: pointer;">'+"注销"+'</a>'
							+ '</td>';
							*/
							
						});
		$('#table_detail tbody').append(html);		
	}
	
	//停止容器
	function stopRdsContainer(servIpaasId){
		/* alert("停用---"+prodBackPara); */
	    $.ajax({
			 url:getContextPath()+"/rdsConsole/stopRDSContainer",
			 type:"POST",
			 data:{
				 prodBackPara:servIpaasId
			 },
				beforeSend : function() {
					$('#loader').show();
					$('#loader').shCircleLoader({
						// 设置加载颜色
						color : '#F0F0F0'
					});
				},
			 success:function(data){
				 if(data.resultCode=="1"){
					 $('#loader').hide();
					 alert("RDS停止成功");
				 }else{
					 $('#loader').hide();
					 alert("RDS停止失败"+data.resultMsg);
				 }
			 }
		 })   
		 
	 }
	
	//启动容器
	function starRdsContainer(servIpaasId){
		/* alert("启用---"+hiddenServIpaasIdVal); */
		$('#loader').show();
	    $.ajax({
			 url:getContextPath()+"/rdsConsole/startRdsContainer",
			 type:"POST",
			 data:{
				 prodBackPara:servIpaasId
			 },
				beforeSend : function() {
					$('#loader').shCircleLoader({
						// 设置加载颜色
						color : '#F0F0F0'
					});
				},
			 success:function(data){
				 if(data.resultCode=="1"){
					  $('#loader').hide();
					 alert("容器启动成功");
				 }else{
						$('#loader').hide();
					 alert("容器启动失败"+data.resultMsg);
				 }
			 }
		 })   
		 
	 }
	
	function destroyRdsContainer(userServIpaasId,userServId) {
		 if(confirm("确定要注销吗？注销后将删除此服务！")){
				/*  alert("启用---"+hiddenServIpaasIdVal); */
				$('#loader').show();
			    $.ajax({
					 url:getContextPath()+"/rdsConsole/destroyContainer",
					 type:"POST",
					 data:{
						 prodBackPara:userServIpaasId,
						 userServId:userServId
					 },
						beforeSend : function() {
							$('#loader').shCircleLoader({
								// 设置加载颜色
								color : '#F0F0F0'
							});
						},
					 success:function(data){
						 var json=data		
							if(json&&json.resultCode=="1"){		
								alert("注销成功");	
								location.href="${_base}/rdsConsole/toRdsConsole";
							}else{									
								alert("注销失败");	
							}
					 }
				 })    
		 }
	}
	
	function manageRds(ip,port,name,passwd){
		url="${rdsManageUrl}";
		host=ip+":"+port;
		var parames = new Array();
        parames.push({ name: "pma_servername", value: host});
        parames.push({ name: "pma_username", value: name});
        parames.push({ name: "pma_password", value: passwd});

        Post(url, parames);

        return false;
		 
		/*  $.post("http://10.1.245.224:12345/phpmyadmin/index.php",
		  {pma_servername:"10.1.228.202:31316",
         	pma_username:"devrdbusr21",
        	pma_password:"devrdbusr21",
        	server:"1",
        	target:"index.php",
        	token:"def1d9d467a96e7d606663b4508b566f"})  
	      .done(function(data){  
	        document.getElementById("msg").innerHTML = data.name + ' ' + data.gender;  
	      }); */
	   //   var dataJsonVal = {pma_servername:"10.1.228.202:31316",pma_username:"devrdbusr21",pma_password:"devrdbusr21",server:"1",target:"index.php",token:"def1d9d467a96e7d606663b4508b566f"};
	    /*   $("#test").ajaxSubmit({
	    	     type: "post",
	    	     url: "http://10.1.245.224:12345/phpmyadmin/db_structure.php?ajax_request=1&favorite_table=1&sync_favorite_tables=1&token=d882fe305410463592387a9c52fb1151",
	    	     dataType: "json",
	    	     success: function(result){
	    	           //返回提示信息       
	    	           alert(result);
	    	     }
	    	 }); */
		 
		  /* $.ajax({
		            type:"POST",
		            url:"http://10.1.245.224:12345/phpmyadmin/index.php",
		            data:{
		            	pma_servername:"10.1.228.202:31316",
		            	pma_username:"devrdbusr21",
		            	pma_password:"devrdbusr21",
		            	server:"1",
		            	target:"index.php",
		            	token:""},
		            datatype: "html",//"xml", "html", "script", "json", "jsonp", "text".
		            success:function(data){
		            	alert(data);
		               // $("#msg").html(decodeURI(data));          
		            	//window.open("http://10.1.245.224:12345/phpmyadmin/index.php");
		             }      
		         });   */
		  /* 
			  $..ajax({
			      "type":"post",
			      "url":"http://10.1.245.224:12345/phpmyadmin/index.php", 
			      "success":function(rel){
			           if(rel.isSuccess){ 
			                window.open(rel.url,"_blank");
			    }
			      }
			}); 
 */
		  }
	
	/*
     *功能： 模拟form表单的提交
     *参数： URL 跳转地址 PARAMTERS 参数
     *创建时间：20161012
     *创建人： sunhz
     */
     function Post(URL, PARAMTERS) {
         //创建form表单
         var temp_form = document.createElement("form");
         temp_form.action = URL;
         //如需打开新窗口，form的target属性要设置为'_blank'
         temp_form.target = "_blank";
         temp_form.method = "post";
         temp_form.style.display = "none";
         //添加参数
         for (var item in PARAMTERS) {
             var opt = document.createElement("textarea");
             opt.name = PARAMTERS[item].name;
             opt.value = PARAMTERS[item].value;
             temp_form.appendChild(opt);
         }
         document.body.appendChild(temp_form);
         //提交数据
         temp_form.submit();
     }
	 
	
	//获得开通idps发返回值
	function getProdBackParm(servIpaasId){
		servIpaasId=servIpaasId+"";
		 var start = 2;
		 var end = servIpaasId.length-4;
		 var serverId = servIpaasId.substr(start,end);
		 var hiddenServIpaasId= "idps_"+serverId;
		 var hiddenServIpaasIdVal=document.getElementById(hiddenServIpaasId).value;
		 return hiddenServIpaasIdVal;
	}
</script>
  
</head> 
<body>     
  <div class="big_k"><!--包含头部 主体-->   
   <!--导航-->
   <%@ include file="/jsp/common/header_console.jsp"%>
      
   <div class="container chanp">
   <%@ include file="/jsp/common/leftMenu_console.jsp"%>
  <div class="row chnap_row">
  
  <div class="col-md-6 right_list">
     
     <div class="Open_cache" id="infomatin" style="display:none">
        <div class="Open_cache_table">
			<ul>
			<li><a href="#">${prodName}</a></li> 
			</ul>  
        </div> 
		<div class="Open_cache_table" style="background:rgb(245,245,245);height:30px;vertical-align:middle;text-align:center;line-height:30px;padding-left:40%">
		</div> 
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
	          	<div class="Open_cache_list_tow">
	          		 <table id="table_detail"  style="width:100%; ">
						<tr>
							<th>服务名称</th>
							<th>产品名称</th>
							<th>IP地址</th>							
							<th>端口</th>
							<th>操作</th> 
						</tr>						
					 </table>
	           </div>                
	        </div>  
    	</div>   
     </div> 
 	<div id="msg"></div>
 	<form id="test"></form>
  </div>
</div>
<div id="loader"
							style="width: 100px; height: 100px; position: absolute; top: 20%; left: 50%; hite; z-index: 1002; overflow: auto;"></div>
					</div>
</div>
</div>  
<!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
 
  </body>
</html>
