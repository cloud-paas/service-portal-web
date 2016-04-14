$("body").ready(
function(){
	$.ajax({
		cache : true,
		type : "POST",
		url : getContextPath() +"/virtualMachine/vmUserLoading",
		data : "User=0",
		dataType : 'json',
		async : true,
		error : function(data) {
			alert("员工信息加载失败！");
		},
		success: function(data){
			var zy= "";
			var yf= "";
			if(data!=null){
				
				obj=eval(data);
			$('#applyUser1').text(data.last_name);////申请人
			$('#applyDepartment1').text(data.org_name);//申请部门
			$('#userPhone1').val(data.mobile);//联系电话
			$('#userEmail1').text(data.email_address);//邮箱地址
			$('#projectName1').text(data.costcenter_name);//成本中心/名称
			$('#costcenter_id1').text(data.costcenter_id);//成本中心ID
			$("#netWbn1").text($('.company').val());
			$("#virtualHard1").text($('.caliche ').val())
			
			$('#applyUser4').text(data.last_name);////申请人
			$('#applyDepartment4').text(data.org_name);//申请部门
			$('#userPhone4').val(data.mobile);//联系电话
			$('#userEmail4').text(data.email_address);//邮箱地址
			$('#projectName4').text(data.costcenter_name);//成本中心/名称
			$('#costcenter_id4').text(data.costcenter_id);//成本中心ID
			$("#virtualHard4").text($('.caliche1 ').val());
			}
		}
		
	
	});
	////////////////////////////////////////////////////////////////////////////////////////////////
	//初始化赋值
	$("#virtualType1").text( $('.rent .tab_div_a_sys li.qieh').text()  );
	$("#netType1").text( $('.rent .tab_div_a_sys2  li.qieh').text() );
	$("#SysTem11").text( $('.rent .tab_div_a_sys1 li.qieh').text() );
	$("#SysTemChild1").text( $('.rent .linux1 li.blue-w  ').text() );
	$("#virtualRam1").text( $('.rent #ul_neicun1 li.qieh ').text() );

	
	$("#virtualType4").text( $('.resaerch .tab_div_a_sys li.qieh').text()  );
	$("#SysTem4").text( $('.resaerch .tab_div_a_sys1 li.qieh').text() );
	$("#SysTemChild4").text( $('.resaerch .linux2 li.blue-w  ').text() );
	$("#virtualRam4").text( $('.resaerch #ul_neicun4 li.qieh ').text() );


	$.ajax({
		cache : true,
		type : "POST",
		url : getContextPath() +"/virtualMachine/vmCPULoading",
		data : "CPUcode=0",
		dataType : 'json',
		async : false,
		success: function(data){
			var zy= "";
			var yf= "";
			var zy_VirtualType= "";
			var yf_VirtualType= "";
			var zy_netType= "";
			
			
			if(data!=null&&data.code=="0000")
			{
			   // 0.0 加载用途说明
				if(data.ZY_ProjectExp!=null){
					var arr= data.ZY_ProjectExp.split(";");	
					var inputLeft = -5;
					var spanLeft = 5;
					var ZY_ProjectExp= "";
					
					 for (var i=0;i < arr.length ;i++){
						 var values = arr[i].split(",");
						 ZY_ProjectExp = ZY_ProjectExp + "<input type='radio' style='width:13px;height:20px;line-height:10px;position:absolute;left:"+inputLeft+"px;top:-1px;' name='function' class='projectExplain1' value='"+values[0]+"'>";
						 ZY_ProjectExp = ZY_ProjectExp +"<span style='position:absolute;left:"+spanLeft+"px;top:1px;width:40px;'>"+values[1]+"</span> ";
						 inputLeft = inputLeft+95;
						 spanLeft = spanLeft+95;
					 }
					$("#ZY_ProjectExp_id").append(ZY_ProjectExp);
			   }
				
				if(data.YF_ProjectExp!=null){
					var arr= data.YF_ProjectExp.split(";");		
					var inputLeft = -5;
					var spanLeft = 5;
					var YF_ProjectExp= "";

					 for (var i=0; i< arr.length ;i++){
						 var values = arr[i].split(",");
						 YF_ProjectExp = YF_ProjectExp + "<input type='radio' style='width:13px;height:20px;line-height:10px;position:absolute;left:"+inputLeft+"px;top:-1px;' name='function2' class='projectExplain4' value='"+values[0]+"'>";
						 YF_ProjectExp = YF_ProjectExp +"<span style='position:absolute;left:"+spanLeft+"px;top:1px;width:40px;'>"+values[1]+"</span> ";
						 inputLeft = inputLeft+95;
						 spanLeft = spanLeft+95;
					 }
					$("#YF_ProjectExp_id").append(YF_ProjectExp);
			   }
				
				
				
			//1.加载cpu	
				if(data.ZY_CPU!=null){
						var arr= data.ZY_CPU.split(";");
						if(arr.length==1){
							zy=zy+"<li class='qieh hideclass radius_left radius_right' id='c1'><A class='radius_left radius_right' href='#top_one' >"+arr[0]+"</A></li>";
						}
						if(arr.length>=2){
							zy=zy+"<li class='qieh hideclass radius_left' id='c1'><A class='radius_left' href='#top_one' >"+arr[0]+"</A></li>";
							 for (var i=1;i< arr.length-1 ;i++){
								 zy=zy+ "<li class='hideclass' id='c1'><A class='' href='#top_one' >"+arr[i]+"</A></li>";
							 }
							zy= zy+"<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two' >"+arr[arr.length-1]+"</a></li>";
						}
						$("#virtualCpu1").text(arr[0]);
						$("#tab_div_ul_cpu1").append(zy);
						ZY_RAM_Loading(arr[0]);
				}
				if(data.YF_CPU!=null){
					var arr2= data.YF_CPU.split(";");
					if(arr.length==1){
						yf=yf+"<li class='qieh hideclass radius_left radius_right' id='c1'><A class='radius_left radius_right' href='#top_one' >"+arr2[0]+"</A></li>";
					}
					if(arr.length>=2){
						yf=yf+"<li class='qieh hideclass radius_left' id='c1'><A class='radius_left' href='#top_one' >"+arr2[0]+"</A></li>";
						 for (var i=1;i< arr2.length-1 ;i++){
							 yf=yf+ "<li class='hideclass' id='c1'><A class='' href='#top_one' >"+arr2[i]+"</A></li>";
						 }
						yf= yf+"<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two' >"+arr2[arr2.length-1]+"</a></li>";
					}
					
					$("#virtualCpu4").text(arr2[0]);
					$("#tab_div_ul_cpu4").append(yf);
					YF_RAM_Loading(arr2[0]);
			    }
				
				//2.加载虚拟机类型
				if(data.ZY_VirtualType!=null){
					var arr3= data.ZY_VirtualType.split(";");
					
					zy_VirtualType=zy_VirtualType+"<li class='qieh hideclass radius_left' id='c1'><a class='radius_left' href='#top_one'>"+arr3[0]+"</a></li>";
					 for (var i=1;i< arr3.length-1 ;i++){
						 zy_VirtualType = zy_VirtualType+ "<li><a href='#top_one'>"+arr3[i]+"</a></li>";
					 }	   
					zy_VirtualType = zy_VirtualType+"<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two' >"+arr3[arr3.length-1]+"</a></li>";
					$("#virtualType1").text(arr3[0]); // arr3[arr3.length-1]
					//alert("3:"+zy_VirtualType);
					$("#tab_div_ul_zy_VirtualType").append(zy_VirtualType);
			     }
				if(data.YF_VirtualType!=null){
					var arr4= data.YF_VirtualType.split(";");
					yf_VirtualType = yf_VirtualType+"<li class='qieh hideclass radius_left' id='c1'><a class='radius_left' href='#top_one'>"+arr4[0]+"</a></li>";
					 for (var i=1;i< arr4.length-1 ;i++){
						 yf_VirtualType = yf_VirtualType+ "<li><a href='#top_one'>"+arr4[i]+"</a></li>";
					 }  
					yf_VirtualType = yf_VirtualType+"<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two' >"+arr4[arr4.length-1]+"</a></li>";
					$("#virtualType4").text(arr4[0]); // arr3[arr3.length-1]
					//alert("4:"+yf_VirtualType);
					$("#tab_div_ul_yf_VirtualType").append(yf_VirtualType);
			     }
				
				//3.租用资源链路类型
				if(data.ZY_NetType!=null){
					var arr5= data.ZY_NetType.split(";");
					zy_netType = zy_netType+"<li class='qieh hideclass radius_left liantong' id='c1'><a class='radius_left' href='#top_one'>"+arr5[0]+"</a></li>";
					 for (var i=1;i< arr5.length-2 ;i++){
						 zy_netType = zy_netType+ "<li class='dianxin'><a href='#top_one'>"+arr5[i]+"</a></li>";
					 }
					zy_netType = zy_netType+ "<li class='double'><a href='#top_one'>"+arr5[i]+"</a></li>";
					zy_netType = zy_netType+"<li class='hideclass radius_right BGP' id='c2'><a class='radius_right gray-border' href='#top_two' >"+arr5[arr5.length-1]+"</a></li>";
					$("#netType1").text(arr5[0]); // arr3[arr3.length-1]
					//alert("5:"+zy_netType);
					$("#zy_NetType").append(zy_netType);
			     }
				

				//$("#virtualRam1").text("1G");//默认1核 内存默认初始值为1G
				//$("#virtualRam4").text("8G");//默认8核 内存默认初始值为8G
		} else{
		 var ss= "<li class='hideclass radius_left' id='c1'><A class='radius_left' href='#top_one' >1核</A></li>"+
						"<li class='qieh hideclass' id='c1'><A class='' href='#top_one' >2核</A></li> "+
						 "<li class='hideclass' id='c1'><A class='' href='#top_one' >4核</A></li>"+
						 "<li class='hideclass' id='c1'><A class='' href='#top_one' >8核</A></li>"+
						"<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two' >12核</a></li>";
				  
		 //alert("01:"+ss)
				  $("#tab_div_ul_cpu1").append(ss);
				  $("#tab_div_ul_cpu4").append(ss);
				  $("#virtualCpu1").text("2核");
				  $("#virtualCpu4").text("2核");
					
				  $("#virtualRam1").text("2G");
				  $("#virtualRam4").text("2G");
					
	       var VirtualType =  "<li class='qieh hideclass radius_left' id='c1'><a class='radius_left' href='#top_one'>WEB服务器</a></li>"+
				  "<li><a href='#top_one'>应用服务器</a></li>"+
				  "<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two' >数据库</a></li>";
	       //alert("02:"+VirtualType)	  
				  $("#tab_div_ul_zy_VirtualType").append(VirtualType);
				  $("#tab_div_ul_yf_VirtualType").append(VirtualType);
				  $("#virtualType1").text("WEB服务器");
				  $("#virtualType4").text("WEB服务器");
				  
			var	zy_netType2 = "<li class='qieh hideclass radius_left liantong' id='c1'><a class='radius_left' href='#top_one'>联通</a></li>"+
				  "<li class='dianxin'><a href='#top_one'>电信</a></li>"+
				  "<li class='double'><a href='#top_one'>联通+电信</a></li>"+
				  "<li class='hideclass radius_right BGP' id='c2'><a class='radius_right gray-border' href='#top_two' >BGP</a></li>";
			//alert("03:"+zy_netType2)	  
			     $("#netType1").text("联通"); // arr3[arr3.length-1]
			     $("#zy_NetType").append(zy_netType2);
					
		 }
			
		
		}
	});
	
	//操作系统
	System();
	SoftLoading("Linux版本");

    
});
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
function System(){
	
	$.ajax({
		cache : true,
		type : "POST",
		url : getContextPath() +"/virtualMachine/vmSystemLoading",
		data : "System=0",
		dataType : 'json',
		async : false,
		success: function(data){
			var zy_SysTem= "";
			var yf_SysTem= "";
			if(data!=null&&data.code=="0000")
			{
				//租用
				if(data.ZY_System!=null){
					$("#rent_system_ul").empty();
					var arr1= data.ZY_System.split(";");
					zy_SysTem = zy_SysTem+"<li class='qieh hideclass radius_left Linux1' id='c1'><a class='radius_left' href='#top_one' onclick='SoftSystemClick(this.innerHTML)'>"+arr1[0]+"</a></li>";
					 for (var i=1;i< arr1.length-1 ;i++){
						 zy_SysTem = zy_SysTem+ "<li class='Window1'><a href='#top_one' onclick='SoftSystemClick(this.innerHTML)'>"+arr1[i]+"</a></li>";
					 }
					zy_SysTem = zy_SysTem+"<li class='hideclass radius_right Ubuntu1' id='c2'><a class='radius_right gray-border' href='#top_two' onclick='SoftSystemClick(this.innerHTML)'>"+arr1[arr1.length-1]+"</a></li>";
					$("#SysTem11").text(arr1[0]); //查出来默认选第一个 SysTem4
					//alert("zy_SysTem:"+zy_SysTem)
					$("#rent_system_ul").append(zy_SysTem);
				}
				if(data.firstSysTemchild1!=null){
					$("#zy_system_child").empty();
					var arr= data.firstSysTemchild1.split(";");
					//alert(arr.length);
					var tree11="<li class='blue-w'>"+arr[0]+"</li>";
					 for (var i=1;i< arr.length ;i++){
						 tree11=tree11+ "<li>"+arr[i]+"</li>";
					 }
					 //alert(tree11);
					$("#SysTemChild1").text(arr[0]);
					$("#zy_system_child").append(tree11);
				}
				
				
				
				
				//研发
				if(data.YF_System!=null){
					$("#resaerch_system_ul").empty();
					var arr2= data.YF_System.split(";");
					yf_SysTem = yf_SysTem +"<li class='qieh hideclass radius_left Linux2' id='c1'><a class='radius_left' href='#top_one' onclick='SoftSystemClick(this.innerHTML)'>"+arr2[0]+"</a></li>";
					 for (var i=1;i< arr2.length-1 ;i++){
						 yf_SysTem = yf_SysTem+ "<li class='Window2'><a href='#top_one' onclick='SoftSystemClick(this.innerHTML)'>"+arr2[i]+"</a></li>";
					 }
					yf_SysTem = yf_SysTem +"<li class='hideclass radius_right Ubuntu2' id='c2'><a class='radius_right gray-border' href='#top_two' onclick='SoftSystemClick(this.innerHTML)'>"+arr2[arr2.length-1]+"</a></li>";
					$("#SysTem4").text(arr2[0]); //查出来默认选第一个 
					//alert("yf_SysTem:"+yf_SysTem)
					$("#resaerch_system_ul").append(yf_SysTem);
				}
				if(data.firstSysTemchild2!=null)
				{
					$("#yf_system_child").empty();
					var arr= data.firstSysTemchild2.split(";");
					//alert(arr.length);
					var tree22="<li class='blue-w'>"+arr[0]+"</li>";
					 for (var i=1;i< arr.length ;i++){
						 tree22 = tree22+ "<li>"+arr[i]+"</li>";
					 }
					//alert(tree22);
					$("#SysTemChild4").text(arr[0]);
					$("#yf_system_child").append(tree22);
				}
				
				
				//$("#SysTemChild1").text("CentOS Linux 5.5 64bit");//默认   Linux版本   下，子版本CentOS Linux 5.5 64bit
				//$("#SysTemChild4").text("CentOS Linux 5.5 64bit");//默认   Window版本  下，子版本CentOS Linux 5.5 64bit
		} else{
			  $("#SysTem11").text("Linux版本");
			  $("#SysTem4").text("Linux版本");
			  $("#SysTemChild1").text("CentOS Linux 5.5 64bit");
			  $("#SysTemChild4").text("CentOS Linux 5.5 64bit");
		
		 }
			
		
		}
	});
}
function SoftSystemClick(SystemCode_V){  //SoftClick
	
	var colodText = $('.nav-right li.cur-li').text();//云类别
	var colod="1"; //默认研发云
	if(colodText=="研发云"){
		colod="1";
		$("#storageSoft1").text("");
		$("#environmentSoft1").text("");
	}
	if(colodText=="华为租用云"){
		colod="2";
		$("#storageSoft4").text("");
		$("#environmentSoft4").text("");
	}
	//alert("colod"+colod);


	var SystemCode =SystemCode_V.trim();
	$.ajax({
		cache : true,
		type : "POST",
		url : getContextPath() +"/virtualMachine/vmSofClick",
		data : {
			SystemCode:SystemCode.trim(),
			Colod:colod
		},//"SystemCode="+SystemCode.trim(),
		dataType : 'json',
		async : false,
		success: function(data){
			var zy_SysTem= "";
			var zy_SysTem2= "";
			var yf_SysTem= "";
			var yf_SysTem2= "";
			if(data!=null&&data.code=="0000")
			{
				if(colod=="2"){
							//租用_______Save_Soft
							if(data.Save_Soft!=null){
								$(".rent #zy_save-soft-content").empty();
								var arr1= data.Save_Soft.split(";");
								
								 for (var i=0;i< arr1.length ;i++){
									 zy_SysTem = zy_SysTem+ "<div class='check-content1'>";
									 zy_SysTem = zy_SysTem+ "<input type='checkbox' name='storageSoft01' id='check-btn01"+i+"'  onclick='softCheck();'>";
									 zy_SysTem = zy_SysTem+ "<div>"+arr1[i]+"</div></div>";
								 }
								//$("#SysTem11").text(arr1[0]); 
								//alert(arr1.length)
								$("#zy_save-soft-content").append(zy_SysTem);
							}
							//租用_______Run_Soft
							if(data.Run_Soft!=null){
								$(".rent #zy_run-soft-content").empty();
								var arr2= data.Run_Soft.split(";");
								 for (var i=0;i< arr2.length ;i++){
									 zy_SysTem2 = zy_SysTem2+ "<div class='check-content1'>";
									 zy_SysTem2 = zy_SysTem2+ "<input type='checkbox' name='storageSoft02' id='check-btn02"+i+"'  onclick='softCheck2();'>";
									 zy_SysTem2 = zy_SysTem2+ "<div>"+arr2[i]+"</div></div>";
								 }
								//alert(arr2.length)
								$("#zy_run-soft-content").append(zy_SysTem2);
							}
				}
				
				
				if(colod=="1"){
							//研发_______Save_Soft
							if(data.Save_Soft!=null){
								$(".resaerch #yf_save-soft-content2").empty();
								var arr3= data.Save_Soft.split(";");
								
								 for (var i=0;i< arr3.length ;i++){
									 yf_SysTem = yf_SysTem+ "<div class='check-content1'>";
									 yf_SysTem = yf_SysTem+ "<input type='checkbox' name='storageSoft04' id='check-btn04"+i+"'  onclick='softCheck4();'>";
									 yf_SysTem = yf_SysTem+ "<div>"+arr3[i]+"</div></div>";
								 }
								//alert(arr3.length)
								$("#yf_save-soft-content2").append(yf_SysTem);
							}
							//研发_______Run_Soft
							if(data.Run_Soft!=null){
								$(".resaerch #yf_run-soft-content2").empty();
								var arr4= data.Run_Soft.split(";");
								
								 for (var i=0;i< arr4.length ;i++){
									 yf_SysTem2 = yf_SysTem2+ "<div class='check-content1'>";
									 yf_SysTem2 = yf_SysTem2+ "<input type='checkbox' name='storageSoft05' id='check-btn05"+i+"'  onclick='softCheck5();'>";
									 yf_SysTem2 = yf_SysTem2+ "<div>"+arr4[i]+"</div></div>";
								 }
								//alert(arr1.length)
								$("#yf_run-soft-content2").append(yf_SysTem2);
							}
				}
				
				
				
		} 

		}
	});

}

function SoftLoading(SystemCode_V){
	
	$("#storageSoft1").text("");
	$("#environmentSoft1").text("");
	$("#storageSoft4").text("");
	$("#environmentSoft4").text("");
	   
	
	var SystemCode ="";
	if(SystemCode_V!=null && SystemCode_V!=undefined && SystemCode_V!=""){
		SystemCode = SystemCode_V;
	}else{
		SystemCode = "Linux版本";
	}

	$.ajax({
		cache : true,
		type : "POST",
		url : getContextPath() +"/virtualMachine/vmSoftLoading",
		data : "SystemCode="+SystemCode.trim(),
		dataType : 'json',
		async : false,
		success: function(data){
			var zy_SysTem= "";
			var zy_SysTem2= "";
			var yf_SysTem= "";
			var yf_SysTem2= "";
			if(data!=null&&data.code=="0000")
			{
				//租用_______Save_Soft
				if(data.ZY_Save_Soft!=null){
					$(".rent #zy_save-soft-content").empty();
					var arr1= data.ZY_Save_Soft.split(";");
					
					 for (var i=0;i< arr1.length ;i++){
						 zy_SysTem = zy_SysTem+ "<div class='check-content1'>";
						 zy_SysTem = zy_SysTem+ "<input type='checkbox' name='storageSoft01' id='check-btn01"+i+"'  onclick='softCheck();'>";
						 zy_SysTem = zy_SysTem+ "<div>"+arr1[i]+"</div></div>";
					 }
					//$("#SysTem11").text(arr1[0]); 
					//alert(arr1.length)
					$("#zy_save-soft-content").append(zy_SysTem);
				}
				//租用_______Run_Soft
				if(data.ZY_Run_Soft!=null){
					$(".rent #zy_run-soft-content").empty();
					var arr2= data.ZY_Run_Soft.split(";");
					 for (var i=0;i< arr2.length ;i++){
						 zy_SysTem2 = zy_SysTem2+ "<div class='check-content1'>";
						 zy_SysTem2 = zy_SysTem2+ "<input type='checkbox' name='storageSoft02' id='check-btn02"+i+"'  onclick='softCheck2();'>";
						 zy_SysTem2 = zy_SysTem2+ "<div>"+arr2[i]+"</div></div>";
					 }
					//alert(arr2.length)
					$("#zy_run-soft-content").append(zy_SysTem2);
				}
				
				
				//研发_______Save_Soft
				if(data.YF_Save_Soft!=null){
					$(".resaerch #yf_save-soft-content2").empty();
					var arr3= data.YF_Save_Soft.split(";");
					
					 for (var i=0;i< arr3.length ;i++){
						 yf_SysTem = yf_SysTem+ "<div class='check-content1'>";
						 yf_SysTem = yf_SysTem+ "<input type='checkbox' name='storageSoft04' id='check-btn04"+i+"'  onclick='softCheck4();'>";
						 yf_SysTem = yf_SysTem+ "<div>"+arr3[i]+"</div></div>";
					 }
					//alert(arr3.length)
					$("#yf_save-soft-content2").append(yf_SysTem);
				}
				//研发_______Run_Soft
				if(data.YF_Run_Soft!=null){
					$(".resaerch #yf_run-soft-content2").empty();
					var arr4= data.YF_Run_Soft.split(";");
					
					 for (var i=0;i< arr4.length ;i++){
						 yf_SysTem2 = yf_SysTem2+ "<div class='check-content1'>";
						 yf_SysTem2 = yf_SysTem2+ "<input type='checkbox' name='storageSoft05' id='check-btn05"+i+"'  onclick='softCheck5();'>";
						 yf_SysTem2 = yf_SysTem2+ "<div>"+arr4[i]+"</div></div>";
					 }
					//alert(arr1.length)
					$("#yf_run-soft-content2").append(yf_SysTem2);
				}
				
		} else{	  
					
		 }

		}
	});
}

//****************************************************************************************
//****************************************************************************************

		$(function(){
			$('.nav-right ul li').eq(0).click(function(){
				$(this).addClass('cur-li').siblings().removeClass('cur-li');
				$('.resaerch').css('display','inline-block');
				$('.rent').css('display','none');
				// $('.chanp').css('height','1980px');
			})
			$('.nav-right ul li').eq(1).click(function(){
				$(this).addClass('cur-li').siblings().removeClass('cur-li');
				$('.resaerch').css('display','none');
				$('.rent').css('display','inline-block');
				// $('.chanp').css('height','1750px');
			})
			
			
			$(window).scroll(function(){
				var h1=$(this).scrollTop();
				var h2=h1+600;
				if (h1<1729 || h1==0) {
					$('.nav-left').css({'position':'fixed','top':'77px'});
					// $(".nav-left").css({"position":"relative"})      //此行代码是为ie6写的  
		            // $(".nav-left").css('top',h1+'px'); 
		             // $(".nav-left").css({"position":"relative"})      //此行代码是为ie6写的  
		          // $(".nav-left").offset({top:(0+h1),left:20});  
					// $('.footer').css('top',h2+'px')
				}
				// else{
				// 	$('.nav-left').css({'position':'absolute','top':'0px'});
				// };
				
			})
			// 鼠标移上哪个哪个tittle变青
			$('.basic-info').mouseover(function(){
				$('.basic-info .left-tittle').css({'color':'#fff','background':'#A9E2FF'})
				$('.project-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.basic-table-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.net-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.system-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.soft-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
			 })
			$('.project').mouseover(function(){
				$('.project-tittle').css({'color':'#fff','background':'#A9E2FF'})
				$('.left-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.basic-table-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.net-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.system-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.soft-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
			 })
			$('.iaas_table').mouseover(function(){
				$('.basic-table-tittle').css({'color':'#fff','background':'#A9E2FF'})
				$('.left-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.project-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.net-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.system-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.soft-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
			 })
			$('.net').mouseover(function(){
				$('.net-tittle1').css({'color':'#fff','background':'#A9E2FF'})
				$('.left-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.project-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.basic-table-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.system-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.soft-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
			 })
			$('.system').mouseover(function(){
				$('.system-tittle').css({'color':'#fff','background':'#A9E2FF'})
				$('.left-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.project-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.basic-table-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.net-tittle1').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.soft-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
			 })
			$('.soft').mouseover(function(){
				$('.soft-tittle').css({'color':'#fff','background':'#A9E2FF'})
				$('.left-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.project-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.basic-table-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.net-tittle1').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.system-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
			 })
		
		
			$(".rent .tab_div_a_sys li").click(function(){ //租用云 虚拟机类型
				$(this).addClass("qieh").siblings().removeClass("qieh"); 
				$("#virtualType1").html($(this).text());
				
			 });
			$(".resaerch .tab_div_a_sys li").click(function(){ //研发云 虚拟机类型
				$(this).addClass("qieh").siblings().removeClass("qieh"); 
				$("#virtualType4").html($(this).text());
				
			 });
			
			$(".tab_div_a_sys2 li").click(function(){ //租用云 链路类型
				$(this).addClass("qieh").siblings().removeClass("qieh"); 
				$("#netType1").html(  jQuery.trim($(this).text())      );
			 });
		
			// 联通、典型、BGP切换
			$('.BGP').click(function(){
				$('.tr1').css('display','none');
				$('.tr2').css('display','inline-block');
				$("#netWbn1").text($('.company1 ').val());
			})
			$('.liantong').click(function(){
				$('.tr2').css('display','none');
				$('.tr1').css('display','inline-block');
				$("#netWbn1").text($('.company ').val());
			})
			$('.dianxin').click(function(){
				$('.tr2').css('display','none');
				$('.tr1').css('display','inline-block');
				$("#netWbn1").text($('.company ').val());
			})
			$('.double').click(function(){
				$('.tr2').css('display','none');
				$('.tr1').css('display','inline-block');
				$("#netWbn1").text($('.company ').val());
			})
			
			
			
			
			
			
			
			
			
			
			
			
			
			// 1.1租用云linux、window、unbutu切换
			/*$('.Linux1').click(function(){
				$('.linux1').css('display','block');
				$('.window1').css('display','none');
				$('.ubuntu1').css('display','none');
				$('.system-mar1').css('margin-bottom','120px');
			})
			$('.Window1').click(function(){
				$('.linux1').css('display','none');
				$('.window1').css('display','block');
				$('.ubuntu1').css('display','none');
				$('.system-mar1').css('margin-bottom','100px');
			})
			$('.Ubuntu1').click(function(){
				$('.linux1').css('display','none');
				$('.window1').css('display','none');
				$('.ubuntu1').css('display','block');
				$('.system-mar1').css('margin-bottom','70px');
			})*/
			
			/*//租用云  操作系统
			$(".rent .tab_div_a_sys1 li").click(function(){ 
				 var this_text = $(this).text();  
				 appendFactory("xnj_li_sys",this_text,",");
				 
				 $(".rent .tab_div_a_sys1 li").each(function(i){
					$(this).removeClass("qieh"); 
				 })
				$(this).addClass("qieh");
				 $("#SysTem11").html(  jQuery.trim($(this).text() )    ); 
			 });*/
			
				
			//1.2租用云 linux、window、unbutu颜色
			/*$('.linux1 li').click(function(){
				$(this).addClass('blueLi').siblings().removeClass('blueLi');
			})
			$('.window1 li').click(function(){
				$(this).addClass('blueLi').siblings().removeClass('blueLi');
			})
			$('.ubuntu1 li').click(function(){
				$(this).addClass('blueLi').siblings().removeClass('blueLi');
			})*/
			
			// 1.3租用云操作系统取值
			/*$('.linux1 li').click(function(){
				$(this).addClass('blue-w').siblings().removeClass('blue-w')
				$("#SysTemChild1").html($(this).text());
			})
			$('.window1 li').click(function(){
				$(this).addClass('blue-w').siblings().removeClass('blue-w')
				$("#SysTemChild1").html($(this).text());
			})
			$('.ubuntu1 li').click(function(){
				$(this).addClass('blue-w').siblings().removeClass('blue-w')
				$("#SysTemChild1").html($(this).text());
			})*/
			
			$('#zy_system_child li').click(function(){
				$(this).addClass('blue-w').siblings().removeClass('blue-w')
				$("#SysTemChild1").html($(this).text());
			})
					
			//一。租用云操作系统数据库交互
			 $('.rent .tab_div_a_sys1 li').click(function(){
			 	$(this).addClass("qieh").siblings().removeClass("qieh");
				$("#SysTem11").html($(this).text().trim());
				/////////查找对应的子系统版本
				var pageSys = $(this).text().trim();
				$.ajax({
					cache : true,
					type : "POST",
					url : getContextPath() +"/virtualMachine/vmClickSystem",
					data : "pageSys="+pageSys+"&sys=ZY_System",
					dataType : 'json',
					async : false,
					success: function(data){
						var tree= "";
						if(data!=null&&data.code=="0000" && data.SysTemChild!=null)
						{
							$("#zy_system_child").empty();
							var arr= data.SysTemChild.split(";");
							//alert(arr.length);
							tree=tree+"<li class='blue-w'>"+arr[0]+"</li>";
							 for (var i=1;i< arr.length ;i++){
								 tree=tree+ "<li>"+arr[i]+"</li>";
							 }
							//alert(tree);
							$("#SysTemChild1").text(arr[0]);
						}else{
							$("#zy_system_child").empty();
						}
						
						$("#zy_system_child").append(tree);
					}
				});
			
							//租用云虚拟机-内存(在function里边写，在外边也要写，负责默认时不起作用)
						$('#zy_system_child li').click(function(){
							$(this).addClass('blue-w').siblings().removeClass('blue-w')
							$("#SysTemChild1").html($(this).text());
						})
			 })
			 
			 //二。研发云操作系统数据库交互
			 $('#yf_system_child li').click(function(){
				$(this).addClass('blue-w').siblings().removeClass('blue-w')
				$("#SysTemChild4").html($(this).text());
			})
			
			 $('.resaerch .tab_div_a_sys1 li').click(function(){
			 	$(this).addClass("qieh").siblings().removeClass("qieh");
				$("#SysTem4").html($(this).text().trim());
				/////////查找对应的子系统版本
				var pageSys = $(this).text().trim();
				$.ajax({
					cache : true,
					type : "POST",
					url : getContextPath() +"/virtualMachine/vmClickSystem",
					data : "pageSys="+pageSys+"&sys=YF_System",
					dataType : 'json',
					async : false,
					success: function(data){
						var tree= "";
						if(data!=null&&data.code=="0000" && data.SysTemChild!=null)
						{
							$("#yf_system_child").empty();
							var arr= data.SysTemChild.split(";");
							//alert(arr.length);
							tree=tree+"<li class='blue-w'>"+arr[0]+"</li>";
							 for (var i=1;i< arr.length ;i++){
								 tree=tree+ "<li>"+arr[i]+"</li>";
							 }
							//alert(tree);
							$("#SysTemChild4").text(arr[0]);
						}else{
							$("#yf_system_child").empty();
						}
						
						$("#yf_system_child").append(tree);
					}
				});
				
							//研发云虚拟机-内存(在function里边写，在外边也要写，负责默认时不起作用)
						$('#yf_system_child li').click(function(){
							$(this).addClass('blue-w').siblings().removeClass('blue-w')
							$("#SysTemChild4").html($(this).text());
						})
			 })
			

		
		
			
			
			
			//研发云操作系统
			/*$(".resaerch .tab_div_a_sys1 li").click(function(){ 
				 var this_text = $(this).text();  
				 appendFactory("xnj_li_sys",this_text,",");
				 
				 $(".resaerch .tab_div_a_sys1 li").each(function(i){
					$(this).removeClass("qieh"); 
				 })
				$(this).addClass("qieh");
				 $("#SysTem4").html( jQuery.trim($(this).text() )    ); 
			 });*/
			
			
			
			
			
			
			// 2.1研发云linux、window、unbutu切换
			/*$('.Linux2').click(function(){
				$('.linux2').css('display','block');
				$('.window2').css('display','none');
				$('.ubuntu2').css('display','none');
				$('.system-mar2').css('margin-bottom','120px');
			})
			$('.Window2').click(function(){
				$('.linux2').css('display','none');
				$('.window2').css('display','block');
				$('.ubuntu2').css('display','none');
				$('.system-mar2').css('margin-bottom','100px');
			})
			$('.Ubuntu2').click(function(){
				$('.linux2').css('display','none');
				$('.window2').css('display','none');
				$('.ubuntu2').css('display','block');
				$('.system-mar2').css('margin-bottom','70px');
			})*/
			//2.2研发云 linux、window、unbutu颜色
			/*$('.linux2 li').click(function(){
				$(this).addClass('blueLi').siblings().removeClass('blueLi');
			})
			$('.window2 li').click(function(){
				$(this).addClass('blueLi').siblings().removeClass('blueLi');
			})
			$('.ubuntu2 li').click(function(){
				$(this).addClass('blueLi').siblings().removeClass('blueLi');
			})*/
		
			// 2.3研发云操作系统取值
			/*$('.linux2 li').click(function(){
				$(this).addClass('blue-w').siblings().removeClass('blue-w')
				$("#SysTemChild4").html($(this).text());
			})
			$('.window2 li').click(function(){
				$(this).addClass('blue-w').siblings().removeClass('blue-w')
				$("#SysTemChild4").html($(this).text());
			})
			$('.ubuntu2 li').click(function(){
				$(this).addClass('blue-w').siblings().removeClass('blue-w')
				$("#SysTemChild4").html($(this).text());
			})*/
			 
			
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			
			 //租用云虚拟机-cpu
			 $('.rent #CPU1 li').click(function(){
			 	$(this).addClass("qieh").siblings().removeClass("qieh");
				$("#virtualCpu1").html($(this).text());
				/////////查找对应的内存
				var pageCpu = $(this).text().trim();
				$.ajax({
					cache : true,
					type : "POST",
					url : getContextPath() +"/virtualMachine/vmClickCPU",
					data : "pageCpu="+pageCpu+"&cpu=ZY_CPU",
					dataType : 'json',
					async : false,
					success: function(data){
						var tree= "";
						if(data!=null&&data.code=="0000" && data.RAM!=null)
						{
							$("#ul_neicun1").empty();
							var arr= data.RAM.split(";");
							//alert(arr.length);
							if(arr.length==1){
								tree=tree+"<li class='qieh hideclass radius_left radius_right' id='c1'><A class='radius_left radius_right' href='#top_one'>"+arr[0]+"</A></li>";
							}else{
								tree=tree+"<li class='qieh hideclass radius_left' id='c1'><A class='radius_left' href='#top_one'>"+arr[0]+"</A></li>";
								 for (var i=1;i< arr.length-1 ;i++){
									 tree=tree+ "<li class='hideclass' id='c1'><A class='' href='#top_one'>"+arr[i]+"</A></li>";
								 }
								tree= tree+ "<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two'>"+arr[arr.length-1]+"</a></li> " ;
							}
							
							//alert(tree);
							$("#virtualRam1").text(arr[0]);
						}else{
							tree="<li class='qieh hideclass radius_left' id='c1'><A class='radius_left' href='#top_one'>1G</A></li>"+
							   "<li class='hideclass' id='c1'><A class='' href='#top_one'>2G</A></li>"+
							   "<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two'>4G</a></li> " ;
							$("#virtualRam1").text("1G");
						}
						$("#ul_neicun1").append(tree);
					}
				});
			
							//租用云虚拟机-内存(在function里边写，在外边也要写，负责默认时不起作用)
						  $('#ul_neicun1 li').click(function(){
							$(this).addClass("qieh").siblings().removeClass("qieh");
							$("#virtualRam1").html($(this).text());
						 })
			 })
			 
			 
			 
			 //研发云虚拟机-cpu
			 $('.resaerch #CPU2 li').click(function(){
			 	$(this).addClass("qieh").siblings().removeClass("qieh");
			 	$("#virtualCpu4").html($(this).text());
			 	/////////对应的内存
				var pageCpu = $(this).text().trim();
				$.ajax({
					cache : true,
					type : "POST",
					url : getContextPath() +"/virtualMachine/vmClickCPU",
					data : "pageCpu="+pageCpu+"&cpu=YF_CPU",
					dataType : 'json',
					async : false,
					success: function(data){
						var tree= "";
						if(data!=null&&data.code=="0000" && data.RAM!=null)
						{
							$("#ul_neicun4").empty();
							var arr= data.RAM.split(";");
							if(arr.length==1){
								 tree=tree+"<li class='qieh hideclass radius_left radius_right' id='c1'><A class='radius_left radius_right' href='#top_one'>"+arr[0]+"</A></li>";
							}
							if(arr.length>=2){
								tree=tree+"<li class='qieh hideclass radius_left' id='c1'><A class='radius_left' href='#top_one'>"+arr[0]+"</A></li>";
								 for (var i=1;i< arr.length-1 ;i++){
									 tree=tree+ "<li class='hideclass' id='c1'><A class='' href='#top_one'>"+arr[i]+"</A></li>";
								 }
								tree= tree+ "<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two'>"+arr[arr.length-1]+"</a></li> " ;
							}
							
							//alert(tree);
							$("#virtualRam4").text(arr[0]);
						}else{
							tree="<li class='qieh hideclass radius_left' id='c1'><A class='radius_left' href='#top_one'>1G</A></li>"+
							   "<li class='hideclass' id='c1'><A class='' href='#top_one'>2G</A></li>"+
							   "<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two'>4G</a></li> " ;
							  $("#virtualRam4").text("1G");
						}
						$("#ul_neicun4").append(tree);
					}
				});
				
							//研发云虚拟机-内存
							  $('#yfneicun2 li').click(function(){//.resaerch 
							 	$(this).addClass("qieh").siblings().removeClass("qieh");
							 	$("#virtualRam4").html($(this).text());
							 })
			 })
		
		
			 //租用云虚拟机-内存
			  $('.rent .neicun1 li').click(function(){
			 	$(this).addClass("qieh").siblings().removeClass("qieh");
				$("#virtualRam1").html($(this).text());
			 })
			 
			 //研发云虚拟机-内存
			  $('#yfneicun2 li').click(function(){//.resaerch 
			 	$(this).addClass("qieh").siblings().removeClass("qieh");
			 	$("#virtualRam4").html($(this).text());
			 })
			 
			  //虚拟机-业务
		 	$("#busi_name").keyup(function(){
				var this_text = $(this).val(); 
				appendFactory("xnj_li_busi",this_text,""); 
		 	}); 
		 	function appendFactory(id,text,flag){
			 	$("#"+id).empty().append(text+flag);
		 	}
			 // 滚动条开始
			new scale('btn0', 'bar0', 'title0'); 	
			new scale1('btn1', 'bar1', 'title1'); 
			new scale2('btn2', 'bar2', 'title2'); 
			new scale3('btn4', 'bar4', 'title4'); 
		 
})
// 滚动条开始

//***********************************************************************************************
//***********************************************************************************************
//***********************************************************************************************
// 租用云下数据盘
scale = function (btn, bar, title) {
	this.btn = document.getElementById(btn);
	this.bar = document.getElementById(bar);
	this.title = document.getElementById(title);
	this.step = this.bar.getElementsByTagName("DIV")[0];
	this.init();
};

scale.prototype = {
	init: function () {
		var f = this, g = document, b = window, m = Math;
		f.btn.onmousedown = function (e) {
			var x = (e || b.event).clientX;
			var l = this.offsetLeft;
			var max = f.bar.offsetWidth - this.offsetWidth;
			g.onmousemove = function (e) {
				var thisX = (e || b.event).clientX;

				var to = m.min(max, m.max(-2, l + (thisX - x)));
				f.btn.style.left = to + 'px';
				f.ondrag(m.round(m.max(0, to / max) * 190), to);
				// $('.caliche').val(to)
				b.getSelection ? b.getSelection().removeAllRanges() : g.selection.empty();

			};
			g.onmouseup = new Function('this.onmousemove=null');
		};
	},
	ondrag: function (pos, x) {
		this.step.style.width = Math.max(0, x) + 'px';
		this.title.innerHTML = pos+10+ 'G';
		$('.caliche').val(pos+10)
		$('#virtualHard1').html(pos+10)
	}
}


// 租用云下公司宽带
scale1 = function (btn, bar, title) {
	this.btn = document.getElementById(btn);
	this.bar = document.getElementById(bar);
	this.title = document.getElementById(title);
	this.step = this.bar.getElementsByTagName("DIV")[0];
	this.init();
};

scale1.prototype = {
	init: function () {
		var f = this, g = document, b = window, m = Math;
		f.btn.onmousedown = function (e) {
			var x = (e || b.event).clientX;
			var l = this.offsetLeft;
			var max = f.bar.offsetWidth - this.offsetWidth;
			g.onmousemove = function (e) {
				var thisX = (e || b.event).clientX;
				var to = m.min(max, m.max(-2, l + (thisX - x)));
				f.btn.style.left = to + 'px';
				f.ondrag(m.round(m.max(0, to / max) * 199), to);
				b.getSelection ? b.getSelection().removeAllRanges() : g.selection.empty();
			};
			g.onmouseup = new Function('this.onmousemove=null');
		};
	},
	ondrag: function (pos, x) {
		this.step.style.width = Math.max(0, x) + 'px';
		this.title.innerHTML = parseInt(pos / 2+1) + 'M';
		$('.company').val(parseInt(pos / 2+1));
		$('#netWbn1').html(parseInt(pos / 2+1))
	}
}

// 租用云下bgp
scale2 = function (btn, bar, title) {
	this.btn = document.getElementById(btn);
	this.bar = document.getElementById(bar);
	this.title = document.getElementById(title);
	this.step = this.bar.getElementsByTagName("DIV")[0];
	this.init();
};

scale2.prototype = {
	init: function () {
		var f = this, g = document, b = window, m = Math;
		f.btn.onmousedown = function (e) {
			var x = (e || b.event).clientX;
			var l = this.offsetLeft;
			var max = f.bar.offsetWidth - this.offsetWidth;
			g.onmousemove = function (e) {
				var thisX = (e || b.event).clientX;
				var to = m.min(max, m.max(-2, l + (thisX - x)));
				f.btn.style.left = to + 'px';
				f.ondrag(m.round(m.max(0, to / max) * 199), to);
				b.getSelection ? b.getSelection().removeAllRanges() : g.selection.empty();
			};
			g.onmouseup = new Function('this.onmousemove=null');
		};
	},
	ondrag: function (pos, x) {
		this.step.style.width = Math.max(0, x) + 'px';
		this.title.innerHTML = parseInt(pos / 10+1) + 'M';
		$('.company1').val(parseInt(pos/10+1));
		$('#netWbn1').html(parseInt(pos/10+1))
	}
}
// 研发云下数据盘
scale3 = function (btn, bar, title) {
	this.btn = document.getElementById(btn);
	this.bar = document.getElementById(bar);
	this.title = document.getElementById(title);
	this.step = this.bar.getElementsByTagName("DIV")[0];
	this.init();
};

scale3.prototype = {
	init: function () {
		var f = this, g = document, b = window, m = Math;
		f.btn.onmousedown = function (e) {
			var x = (e || b.event).clientX;
			var l = this.offsetLeft;
			var max = f.bar.offsetWidth - this.offsetWidth;
			g.onmousemove = function (e) {
				var thisX = (e || b.event).clientX;
				var to = m.min(max, m.max(-2, l + (thisX - x)));
				f.btn.style.left = to + 'px';
				f.ondrag(m.round(m.max(0, to / max) * 199), to);
				b.getSelection ? b.getSelection().removeAllRanges() : g.selection.empty();
			};
			g.onmouseup = new Function('this.onmousemove=null');
		};
	},
	ondrag: function (pos, x) {
		this.step.style.width = Math.max(0, x) + 'px';
		this.title.innerHTML = pos+10+ 'G';
		$('.caliche1').val(pos+10)
		$('#virtualHard4').html(pos+10);
	}
}

//租用云公网数量
function netNumber(){
	var vl = $('#netNumber').val();
	$('#netNum1').html(vl);
}
//租用云其他操作系统
function otherSystem(){
	if($('#otherSys1').val()!=null && $('#otherSys1').val()!=''){
		$('#sys').css('display','inline-block');
	}else{
		$('#sys').css('display','none');
	}
	
	var vl = $('#otherSys1').val();
	$('#SysOtherTem1').html(vl);
}
//研发云其他操作系统
function otherSystem2(){
	if($('#otherSys2').val()!=null && $('#otherSys2').val()!=''){
		$('#sys2').css('display','inline-block');
	}else{
		$('#sys2').css('display','none');
	}
	var vl = $('#otherSys2').val();
	$('#SysOtherTem4').html(vl);
}
//租用云安装软件
function softCheck(){
	//alert("softCheck()")
   var allCheckBoxs=document.getElementsByName("storageSoft01") ;
	
   document.getElementById("storageSoft1").innerHTML="";
   for (var i=0;i<allCheckBoxs.length ;i++)
   { 
       if(allCheckBoxs[i].checked==true){ 
	       var temp = document.getElementById("storageSoft1").innerHTML;
	       var idd = allCheckBoxs[i].id;
	       if(temp==""){
	        document.getElementById("storageSoft1").innerHTML =  $("#"+idd).siblings().text() ; 
	       }else{
	    	   document.getElementById("storageSoft1").innerHTML = temp +" , "+ $("#"+idd).siblings().text() ; 
	       }
	   }
   }     

}
//租用云安装软件
function softCheck2(){
	//alert("softCheck2")
   var allCheckBoxs=document.getElementsByName("storageSoft02") ;
   document.getElementById("environmentSoft1").innerHTML="";
   for (var i=0;i<allCheckBoxs.length ;i++)
   { 
       if(allCheckBoxs[i].checked==true){ 
	       var temp = document.getElementById("environmentSoft1").innerHTML;
	       var idd = allCheckBoxs[i].id;
	       if(temp==""){
	        document.getElementById("environmentSoft1").innerHTML =  $("#"+idd).siblings().text() ; 
	       }else{
	    	   document.getElementById("environmentSoft1").innerHTML = temp +" , "+ $("#"+idd).siblings().text() ; 
	       }
	   }
   }     

}

//研发云安装软件
function softCheck4(){
   var allCheckBoxs=document.getElementsByName("storageSoft04") ;
   document.getElementById("storageSoft4").innerHTML="";
   for (var i=0;i<allCheckBoxs.length ;i++)
   { 
       if(allCheckBoxs[i].checked==true){ 
	       var temp = document.getElementById("storageSoft4").innerHTML;
	       var idd = allCheckBoxs[i].id;
	       if(temp==""){
	        document.getElementById("storageSoft4").innerHTML =  $("#"+idd).siblings().text() ; 
	       }else{
	    	   document.getElementById("storageSoft4").innerHTML = temp +" , "+ $("#"+idd).siblings().text() ; 
	       }
	   }
   }     

}
//研发云安装软件
function softCheck5(){
   var allCheckBoxs=document.getElementsByName("storageSoft05") ;
   document.getElementById("environmentSoft4").innerHTML="";
   for (var i=0;i<allCheckBoxs.length ;i++)
   { 
       if(allCheckBoxs[i].checked==true){ 
	       var temp = document.getElementById("environmentSoft4").innerHTML;
	       var idd = allCheckBoxs[i].id;
	       if(temp==""){
	        document.getElementById("environmentSoft4").innerHTML =  $("#"+idd).siblings().text() ; 
	       }else{
	    	   document.getElementById("environmentSoft4").innerHTML = temp +" , "+ $("#"+idd).siblings().text() ; 
	       }
	   }
   }     

}


// 租用云下数据盘
function move(){
	var w=0;
	var w =parseInt($('.caliche').val())
	var w1=w*1.36;
	if (w>10 && w<=200) {
		
		$('#bar0 div').css('width',w1+'px');
		$('#btn0').css('left',w1+'px');
		$('#title0').html(w+'G');
	
	}else if(w=10){
		$('#bar0 div').css('width','0px');
		$('#btn0').css('left','-2px');
		$('#title0').html('10G');
	}
	
	$('#virtualHard1').text( $('#title0').html().split("G")[0]  );
};


// 租用云下联通电信下
function move1(){
	var w =$('.company').val();
	var w1=w*2.73;
	// var w1=w+28;
	if (w>=1 && w<=100) {
		$('#bar1 div').css('width',w1+'px');
		$('#btn1').css('left',w1+'px');
		$('#title1').html(w+'M');
	}
	
	$('#netWbn1').text( $('#title1').html().split("M")[0]  );
};


// 租用云下 BGP
function move2(){
	var w =$('.company1').val();
	var w1=w*13.65;
	if (w>1 && w<20) {
		$('#bar2 div').css('width',w1+'px');
		$('#btn2').css('left',w1+'px');
		$('#title2').html(w+'M');
	}
	// alert(w)
};
// 研发云下数据盘
function move4(){
	var w =$('.caliche1').val();
	var w1=w*1.36;
	if (w>10 && w<=200) {
		$('#bar4 div').css('width',w1+'px');
		$('#btn4').css('left',w1+'px');
		$('#title4').html(w+'G');
	}else if(w=10){
		$('#bar4 div').css('width','0px');
		$('#btn4').css('left','-2px');
		$('#title4').html('10G');
	}
	$('#virtualHard4').text( $('#title4').html().split("G")[0]  );
};
// 自动获取当前日期
function tick() {
var years,months,days,hours, minutes, seconds;
var intYears,intMonths,intDays,intHours, intMinutes, intSeconds;
var today;
today = new Date(); //系统当前时间
intYears = today.getFullYear(); //得到年份,getFullYear()比getYear()更普适
intMonths = today.getMonth() + 1; //得到月份，要加1
intDays = today.getDate(); //得到日期
intHours = today.getHours(); //得到小时
intMinutes = today.getMinutes(); //得到分钟
intSeconds = today.getSeconds(); //得到秒钟
years = intYears + "-";
if(intMonths < 10 ){
months = "0" + intMonths +"-";
} else {
months = intMonths +"-";
}
if(intDays < 10 ){
days = "0" + intDays +" ";
} else {
days = intDays + " ";
}
if (intHours == 0) {
hours = "00:";
} else if (intHours < 10) {
hours = "0" + intHours+":";
} else {
hours = intHours + ":";
}
if (intMinutes < 10) {
minutes = "0"+intMinutes+":";
} else {
minutes = intMinutes+":";
}
if (intSeconds < 10) {
seconds = "0"+intSeconds+" ";
} else {
seconds = intSeconds+" ";
}
timeString = years+months+days
Clock.innerHTML = timeString;
Clock4.innerHTML = timeString;
window.setTimeout("tick();", 1000);
}
window.onload = tick;

//租用云虚拟机-cpu 用于初始化加载
function ZY_RAM_Loading(pageCpuT ){
//alert("ZY_RAM_Loading"+pageCpuT)
	var pageCpu = pageCpuT.trim();
	$.ajax({
		cache : true,
		type : "POST",
		url : getContextPath() +"/virtualMachine/vmClickCPU",
		data : "pageCpu="+pageCpu+"&cpu=ZY_CPU",
		dataType : 'json',
		async : false,
		success: function(data){
			var tree= "";
			if(data!=null&&data.code=="0000" && data.RAM!=null)
			{
				$("#ul_neicun1").empty();
				var arr= data.RAM.split(";");
				if(arr.length==1){
					tree=tree+"<li class='qieh hideclass radius_left radius_right' id='c1'><A class='radius_left radius_right' href='#top_one'>"+arr[0]+"</A></li>";
				}else{
					tree=tree+"<li class='qieh hideclass radius_left' id='c1'><A class='radius_left' href='#top_one'>"+arr[0]+"</A></li>";
					 for (var i=1;i< arr.length-1 ;i++){
						 tree=tree+ "<li class='hideclass' id='c1'><A class='' href='#top_one'>"+arr[i]+"</A></li>";
					 }
					tree= tree+ "<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two'>"+arr[arr.length-1]+"</a></li> " ;
				}							
				$("#virtualRam1").text(arr[0]);
			}else{
				tree="<li class='qieh hideclass radius_left' id='c1'><A class='radius_left' href='#top_one'>1G</A></li>"+
				   "<li class='hideclass' id='c1'><A class='' href='#top_one'>2G</A></li>"+
				   "<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two'>4G</a></li> " ;
				$("#virtualRam1").text("1G");
			}
			$("#ul_neicun1").append(tree);
		}
	});
}

//研发云虚拟机-cpu  用于初始化加载
function YF_RAM_Loading(pageCpuT ){
	//alert("YF_RAM_Loading"+pageCpuT)
	var pageCpu = pageCpuT.trim();
	$.ajax({
		cache : true,
		type : "POST",
		url : getContextPath() +"/virtualMachine/vmClickCPU",
		data : "pageCpu="+pageCpu+"&cpu=YF_CPU",
		dataType : 'json',
		async : false,
		success: function(data){
			var tree= "";
			if(data!=null&&data.code=="0000" && data.RAM!=null)
			{
				$("#ul_neicun4").empty();
				var arr= data.RAM.split(";");
				if(arr.length==1){
					 tree=tree+"<li class='qieh hideclass radius_left radius_right' id='c1'><A class='radius_left radius_right' href='#top_one'>"+arr[0]+"</A></li>";
				}
				if(arr.length>=2){
					tree=tree+"<li class='qieh hideclass radius_left' id='c1'><A class='radius_left' href='#top_one'>"+arr[0]+"</A></li>";
					 for (var i=1;i< arr.length-1 ;i++){
						 tree=tree+ "<li class='hideclass' id='c1'><A class='' href='#top_one'>"+arr[i]+"</A></li>";
					 }
					tree= tree+ "<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two'>"+arr[arr.length-1]+"</a></li> " ;
				}
				
				//alert(tree);
				$("#virtualRam4").text(arr[0]);
			}else{
				tree="<li class='qieh hideclass radius_left' id='c1'><A class='radius_left' href='#top_one'>1G</A></li>"+
				   "<li class='hideclass' id='c1'><A class='' href='#top_one'>2G</A></li>"+
				   "<li class='hideclass radius_right' id='c2'><a class='radius_right gray-border' href='#top_two'>4G</a></li> " ;
				  $("#virtualRam4").text("1G");
			}
			$("#ul_neicun4").append(tree);
		}
	});

}
