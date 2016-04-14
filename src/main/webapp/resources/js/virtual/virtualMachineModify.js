
/*$("body").ready(
function(){
	//初始化赋值
	$("#virtualType1").text( $('.rent .tab_div_a_sys li.qieh').text()  );
	$("#netType1").text( $('.rent .tab_div_a_sys2  li.qieh').text() );
	$("#SysTem11").text( $('.rent .tab_div_a_sys1 li.qieh').text() );
	$("#SysTemChild1").text( $('.rent .linux1 li.blue-w  ').text() );
	
	$("#virtualType4").text( $('.resaerch .tab_div_a_sys li.qieh').text()  );
	$("#SysTem4").text( $('.resaerch .tab_div_a_sys1 li.qieh').text() );
	$("#SysTemChild4").text( $('.resaerch .linux2 li.blue-w  ').text() );



	//////////
    ////////////////////////////////////////////
});*/
//****************************************************************************************

		$(function(){
			
			//租用云操作系统
			$(".rent .tab_div_a_sys1 li").click(function(){ 
				 var this_text = $(this).text();  
				 appendFactory("xnj_li_sys",this_text,",");
				 
				 $(".rent .tab_div_a_sys1 li").each(function(i){
					$(this).removeClass("qieh"); 
				 })
				$(this).addClass("qieh");
				 $("#SysTem11").html(  jQuery.trim($(this).text() )    ); 
			 });
			//研发云操作系统
			$(".resaerch .tab_div_a_sys1 li").click(function(){ 
				 var this_text = $(this).text();  
				 appendFactory("xnj_li_sys",this_text,",");
				 
				 $(".resaerch .tab_div_a_sys1 li").each(function(i){
					$(this).removeClass("qieh"); 
				 })
				$(this).addClass("qieh");
				 $("#SysTem4").html( jQuery.trim($(this).text() )    ); 
			 });
			
			
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
				$('.basic-deploy').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.net-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.system-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.soft-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
			 })
			$('.project').mouseover(function(){
				$('.project-tittle').css({'color':'#fff','background':'#A9E2FF'})
				$('.left-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.basic-deploy').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.net-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.system-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.soft-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
			 })
			$('.iaas_table').mouseover(function(){
				$('.basic-deploy').css({'color':'#fff','background':'#A9E2FF'})
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
				$('.basic-deploy').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.system-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.soft-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
			 })
			$('.system').mouseover(function(){
				$('.system-tittle').css({'color':'#fff','background':'#A9E2FF'})
				$('.left-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.project-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.basic-deploy').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.net-tittle1').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.soft-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
			 })
			$('.soft').mouseover(function(){
				$('.soft-tittle').css({'color':'#fff','background':'#A9E2FF'})
				$('.left-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.project-tittle').css({'color':'#b8b8b8','background':'#f2f2f2'})
				$('.basic-deploy').css({'color':'#b8b8b8','background':'#f2f2f2'})
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
			})
			$('.liantong').click(function(){
				$('.tr2').css('display','none');
				$('.tr1').css('display','inline-block');
			})
			$('.dianxin').click(function(){
				$('.tr2').css('display','none');
				$('.tr1').css('display','inline-block');
			})
			$('.double').click(function(){
				$('.tr2').css('display','none');
				$('.tr1').css('display','inline-block');
			})
			// 租用云linux、window、unbutu切换
			$('.Linux1').click(function(){
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
			})
			
			//租用云 linux、window、unbutu颜色
			$('.linux1 li').click(function(){
				$(this).addClass('blueLi').siblings().removeClass('blueLi');
			})
			$('.window1 li').click(function(){
				$(this).addClass('blueLi').siblings().removeClass('blueLi');
			})
			$('.ubuntu1 li').click(function(){
				$(this).addClass('blueLi').siblings().removeClass('blueLi');
			})
			
			// 研发云linux、window、unbutu切换
			$('.Linux2').click(function(){
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
			})
			//研发云 linux、window、unbutu颜色
			$('.linux2 li').click(function(){
				$(this).addClass('blueLi').siblings().removeClass('blueLi');
			})
			$('.window2 li').click(function(){
				$(this).addClass('blueLi').siblings().removeClass('blueLi');
			})
			$('.ubuntu2 li').click(function(){
				$(this).addClass('blueLi').siblings().removeClass('blueLi');
			})
		
			
			// 租用云操作系统取值
			$('.linux1 li').click(function(){
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
			})
			
			// 研发云操作系统取值
			$('.linux2 li').click(function(){
				$(this).addClass('blue-w').siblings().removeClass('blue-w')
				$("#SysTemChild4").text($(this).text());
			})
			$('.window2 li').click(function(){
				$(this).addClass('blue-w').siblings().removeClass('blue-w')
				$("#SysTemChild4").text($(this).text());
			})
			$('.ubuntu2 li').click(function(){
				$(this).addClass('blue-w').siblings().removeClass('blue-w')
				$("#SysTemChild4").text($(this).text());
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
			searchOrder();
			$(".rent .tab_div_a_sys ul li").click(function(){
				$(this).addClass('qieh').siblings('li').removeClass('qieh');
				$('#virtualType1').text($(this).children('a').text());
			})
			
			$('#tab_div_ul_cpu1 li a ').click(function(){
				$(this).parent('li').addClass("qieh");
				$(this).parent('li').siblings('li').removeClass('qieh');
				changememory($(this).text());
				$("#virtualCpu1").text($(this).text());
				$("#virtualRam1").text($('#ul_neicun1 .qieh a').text());
			});
			$('#tab_div_ul_cpu4 li a ').click(function(){
				$(this).parent('li').addClass("qieh");
				$(this).parent('li').siblings('li').removeClass('qieh');
				changememory($(this).text());
				$("#virtualCpu4").text($(this).text());
				$("#virtualRam4").text($('#yfneicun2 .qieh a').text());
			});
			//租用云虚拟机-内存
			  $('#ul_neicun1 li ').click(function(){
				 
			 	$(this).addClass("qieh").siblings().removeClass("qieh");
				$("#virtualRam1").text($(this).children().text());
			 })
			 
			 	 //研发云虚拟机-内存
			  $('#yfneicun2 li').click(function(){//.resaerch 
			 	$(this).addClass("qieh").siblings().removeClass("qieh");
			 	$("#virtualRam4").text($(this).text());
			 })
			 
			 $('.tab_div_a_sys2 ul li').click(function(){
				 $(this).addClass('qieh').siblings('li').removeClass('qieh');
				 $("#netType1").text($(this).children('a').text());
			 })
			 $('.tab_div_a_sys ul li').click(function(){
				 $(this).addClass('qieh').siblings('li').removeClass('qieh');
				 $("#virtualType4").text($(this).children('a').text());
			 });
			 
			 $('.system1 li').click(function(){
				  
				 $(this).addClass('qieh').siblings('li').removeClass('qieh');
				 $("#SysTem11").text($(this).text());
				 $("#SysTemChild1").text("");
				 $("#storageSoft1").text("");
				 $("#environmentSoft1").text("");
				 
				 if($(this).text()=="Linux版本"){
					 $('.linux1').css('display','block');
					 $('.window1').css('display','none');
					 $('.ubuntu1').css('display','none');
					 $('.window1 li').removeClass('blue-w');
					 $('.ubuntu1 li').removeClass('blue-w');
					 
				 }else if($(this).text()=="Window版本"){
					 $('.linux1').css('display','none');
					 $('.window1').css('display','block');
					 $('.ubuntu1').css('display','none');
					 $('.linux1 li').removeClass('blue-w');
					 $('.ubuntu1 li').removeClass('blue-w');
				 }else if($(this).text()=="Ubuntu"){
					 $('.linux1').css('display','none');
					 $('.window1').css('display','none');
					 $('.ubuntu1').css('display','block');
					 $('.linux1 li').removeClass('blue-w');
					 $('.window1 li').removeClass('blue-w');
				 }
			 })
			  $('.system2 li').click(function(){
				  
				 $(this).addClass('qieh').siblings('li').removeClass('qieh');
				 $("#SysTem4").text($(this).text());
				 $("#SysTemChild4").text("");
				 $("#storageSoft4").text("");
				 $("#environmentSoft4").text("");
				 if($(this).text()=="Linux版本"){
					 $('.linux2').css('display','block');
					 $('.window2').css('display','none');
					 $('.ubuntu2').css('display','none');
					 $('.window2 li').removeClass('blue-w');
					 $('.ubuntu2 li').removeClass('blue-w');
					 
				 }else if($(this).text()=="Window版本"){
					 $('.linux2').css('display','none');
					 $('.window2').css('display','block');
					 $('.ubuntu2').css('display','none');
					 $('.linux2 li').removeClass('blue-w');
					 $('.ubuntu2 li').removeClass('blue-w');
				 }else if($(this).text()=="Ubuntu"){
					 $('.linux2').css('display','none');
					 $('.window2').css('display','none');
					 $('.ubuntu2').css('display','block');
					 $('.linux2 li').removeClass('blue-w');
					 $('.window2 li').removeClass('blue-w');
				 }
				 
			 })
			 
			 $('.linux1 li').click(function(){
				 $(this).addClass('blue-w').siblings('li').removeClass('blue-w');
				 $("#SysTemChild1").text($(this).text());
			 })
			 $('.window1 li').click(function(){
				 $(this).addClass('blue-w').siblings('li').removeClass('blue-w');
				 $("#SysTemChild1").text($(this).text());
			 })
			 $('.ubuntu1 li ').click(function(){
				 $(this).addClass('blue-w').siblings('li').removeClass('blue-w');
				 $("#SysTemChild1").text($(this).text());
			 })
			 
			  $('.linux2 li').click(function(){
				 $(this).addClass('blue-w').siblings('li').removeClass('blue-w');
				 $("#SysTemChild4").text($(this).text());
			 })
			 $('.window2 li').click(function(){
				 
				 $(this).addClass('blue-w').siblings('li').removeClass('blue-w');
				 $("#SysTemChild4").text($(this).text());
			 })
			 $('.ubuntu2 li ').click(function(){
				 $(this).addClass('blue-w').siblings('li').removeClass('blue-w');
				 $("#SysTemChild4").text($(this).text());
			 })
			 
			
		 
})
// 滚动条开始

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
		this.title.innerHTML = pos+1+ 'G';
		$('.caliche1').val(pos+1)
		$('#virtualHard4').html(pos+1);
	}
}

//租用云公网数量
function netNumber(){
	var vl = $('#netNumber').val();
	$('#netNum1').html(vl);
}
//租用云其他操作系统
function otherSystem(){
	var vl = $('#otherSys1').val();
	$('#SysOtherTem1').html(vl);
}
//研发云其他操作系统
function otherSystem2(){
	var vl = $('#otherSys2').val();
	$('#SysOtherTem4').html(vl);
}
//租用云安装软件
function softCheck(){
   var allCheckBoxs=document.getElementsByName("storageSoft1") ;
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
   var allCheckBoxs=document.getElementsByName("storageSoft2") ;
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
   var allCheckBoxs=document.getElementsByName("storageSoft4") ;
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
   var allCheckBoxs=document.getElementsByName("storageSoft5") ;
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
	if (w>10 && w<200) {	
		$('#bar0 div').css('width',w1+'px');
		$('#btn0').css('left',w1+'px');
		$('#title0').html(w+'G');
		$("#virtualHard1").text($('.caliche').val());
	}else if(w==10){
		$('#bar0 div').css('width','0px');
		$('#btn0').css('left','-2px');
		$('#title0').html('10G');
		$("#virtualHard1").text('10');
	}else if(w==200){
		$('#bar0 div').css('width','279px');
		$('#btn0').css('left','279px');
		$('#title0').html('200G');
		$("#virtualHard1").text('200');
	}
};


// 租用云下联通电信下
function move1(){
	var w =$('.company').val();
	var w1=w*2.73;
	// var w1=w+28;
	if (w>1 && w<100) {
		$('#bar1 div').css('width',w1+'px');
		$('#btn1').css('left',w1+'px');
		$('#title1').html(w+'M');
		$('#netWbn1').text(w);
	}else if(w==1){
		$('#bar1 div').css('width','0px');
		$('#btn1').css('left','-2px');
		$('#title1').html('1M');
		$('#netWbn1').text(w);
	}else if(w==100){
		$('#bar1 div').css('width','279px');
		$('#btn1').css('left','279px');
		$('#title1').html('100M');
		$('#netWbn1').text(w);
	}
};


// 租用云下 BGP
function move2(){
	var w =$('.company1').val();
	var w1=w*13.65;
	if (w>1 && w<20) {
		$('#bar2 div').css('width',w1+'px');
		$('#btn2').css('left',w1+'px');
		$('#title2').html(w+'M');
		$('#netWbn1').text(w);
	}else if(w==1){
		$('#bar2 div').css('width','0px');
		$('#btn2').css('left','-2px');
		$('#title2').html('1M');
		$('#netWbn1').text(w);
	}else if(w==20){
		$('#bar2 div').css('width','279px');
		$('#btn2').css('left','279px');
		$('#title2').html('20M');
		$('#netWbn1').text(w);
	}
	// alert(w)
};
// 研发云下数据盘
function move4(){
	var w =$('.caliche1').val();
	var w1=w*1.36;
	if (w>10 && w<200) {
		$('#bar4 div').css('width',w1+'px');
		$('#btn4').css('left',w1+'px');
		$('#title4').html(w+'G');
		$("#virtualHard4").text(w);
	}else if(w==10){
		$('#bar4 div').css('width','0px');
		$('#btn4').css('left','-2px');
		$('#title4').html('10G');
		$("#virtualHard4").text(w);
	}else if(w==200){
		$('#bar4 div').css('width','279px');
		$('#btn4').css('left','279px');
		$('#title4').html('200G');
		$("#virtualHard4").text(w);
	}
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
/*Clock.innerHTML = timeString;
Clock4.innerHTML = timeString;*/
window.setTimeout("tick();", 1000);
}
window.onload = tick;

function searchOrder() {
	var orderDetailId=$("#orderDetailId").val();
	$.ajax({
		async:false,
		type:"POST",
		url:getContextPath()+"/formulate/searchDetail",
		data:{
			orderDetailId:orderDetailId
		},
		success:function(data){
			if(data.resultCode=="999999")
			{
				//alert(data.resultMsg)
				$('.zy-warning').html(data.resultMsg);
			}else{
				 
				$("#cloud_id").val(data.belongCloud);
				 if(data.belongCloud=="2"){
					$("#zysign").addClass("cur-li");
					$('.rent').css('display','inline-block');
					$('.resaerch').css('display','none');
					$("#applyUser1").text(data.applicant);
					$("#applyDepartment1").text(data.applicantDept);
					$("#userPhone1").val(data.applicantTel);
					$("#userEmail1").text(data.applicantEmail);
					$("#applyReason1").val(data.applicantReason);
					if(data.isProject=='Y'){
//						alert("ok");
//						 $("#isProject1").prop('checked')=true;
						 $("#isProject1").attr("checked", true);
					 }
					$("#projectName1").text(data.costCenterName);
					$("#costcenter_id1").text(data.costCenterCode);
					$("#projectNum1").val(data.userMaxNumbers);
					$("#projectCount1").val(data.concurrentNumbers);
					 
					if(data.useType=="1")
					{
						 
						$("input[name='function']").eq(0).attr("checked","checked");
						$("input[name='function']").eq(1).removeAttr("checked");
						$("input[name='function']").eq(2).removeAttr("checked");
						$("input[name='function']").eq(3).removeAttr("checked");

					}else if(data.useType=="2"){ 
						$("input[name='function']").eq(1).attr("checked","checked");
						$("input[name='function']").eq(0).removeAttr("checked");
						$("input[name='function']").eq(2).removeAttr("checked");
						$("input[name='function']").eq(3).removeAttr("checked");
					}else if(data.useType=="3"){
						 
						$("input[name='function']").eq(2).attr("checked","checked");
						$("input[name='function']").eq(0).removeAttr("checked");
						$("input[name='function']").eq(1).removeAttr("checked");
						$("input[name='function']").eq(3).removeAttr("checked");
					}else if(data.useType=="4"){
						$("input[name='function']").eq(3).attr("checked","checked");
						$("input[name='function']").eq(0).removeAttr("checked");
						$("input[name='function']").eq(1).removeAttr("checked");
						$("input[name='function']").eq(2).removeAttr("checked");
					}
					 
					$("#projectNot1").val(data.applyDesc);
					 
					$("#Clock").text(data.orderAppDate.substr(0,10));
					
					$("#projectEndTime1").val(data.expirationDate.substr(0,10));
					var object=JSON.parse(data.prodParam);
					var vmTypearr=initVmtype(data.belongCloud);
					if(vmTypearr!=null&&vmTypearr!=undefined){
						var type="";
						for(var i=0;i<vmTypearr.length;i++){
							if(object.virtualType==vmTypearr[i]){
								if(i==0){
									type+="<li class=\" hideclass radius_left qieh\" id=\"c1\"><a class=\"radius_left\" href=\"#top_one\">"+vmTypearr[i]+"</a></li>"
								}else if(i==vmTypearr.length-1){
									type+="<li class=\"hideclass radius_right qieh\" id=\"c2\"><a class=\"radius_right gray-border\" href=\"#top_two\" >"+vmTypearr[i]+"</a></li> ";
								}else{
									type+=" <li class=\"qieh\"><a href=\"#top_one\">"+vmTypearr[i]+"</a></li>";
								}
							}else{
								if(i==0){
									type+="<li class=\" hideclass radius_left \" id=\"c1\"><a class=\"radius_left\" href=\"#top_one\">"+vmTypearr[i]+"</a></li>"
								}else if(i==vmTypearr.length-1){
									type+="<li class=\"hideclass radius_right \" id=\"c2\"><a class=\"radius_right gray-border\" href=\"#top_two\" >"+vmTypearr[i]+"</a></li> ";
								}else{
									type+=" <li ><a href=\"#top_one\">"+vmTypearr[i]+"</a></li>";
								}
							}
						}
						$(".rent .tab_div_a_sys ul").append(type);
					}else{
						//alert("加载失败");
						$('.zy-warning').html("虚拟机类型加载失败!");
					}
					
					//租用云虚拟机数量
					$("#zy_v-num-countW").val(data.vmNumber);
					$("#zy_v-num-countU").text(data.vmNumber);
					
				
					
					
					var cpudata=loadcpu(data.belongCloud);
					 
					var arr=cpudata.split(";");
					var cpu="";
					$("#tab_div_ul_cpu1").empty();
					if(arr!=null&&arr.length>0)
					{
						
						for(var i=0;i< arr.length ;i++)
						{
							
							if(arr[i]==object.cpu)
							{
								if(i==0)
								{
									cpu+="<li class='hideclass radius_left qieh' id='"+"c"+i+"'><A class='radius_left  ' href='#top_one' >"+arr[i]+"</A></li>"
								}else if(i==arr.length-1)
								{
									cpu+="<li class='hideclass radius_right qieh ' id='"+"c"+i+"'><a class='radius_right gray-border' href='#top_two' >"+arr[i]+"</a></li> "
								}else{
									cpu+="<li class='hideclass qieh' id='"+"c"+i+"'><A   href='#top_one'>"+arr[i]+"</A></li>"
								}
								
							}else{
								if(i==0)
								{
									cpu+="<li class='hideclass radius_left ' id='"+"c"+i+"'><A class='radius_left' href='#top_one' >"+arr[i]+"</A></li>"
								}else if(i==arr.length-1)
								{
									cpu+="<li class='hideclass radius_right ' id='"+"c"+i+"'><a class='radius_right gray-border' href='#top_two' >"+arr[i]+"</a></li> "
								}else{
									cpu+="<li class='hideclass ' id='"+"c"+i+"'><A  href='#top_one' >"+arr[i]+"</A></li>"
								}
							}
							 
							
						}
						$('#tab_div_ul_cpu1').append(cpu);
								
					}else{
						//alert("加载失败");
						$('.zy-warning').html("cpu加载失败!");
					}
					
					
					var mem=loadmemory(data.belongCloud,object.cpu);
					var memarr=mem.split(";");
					$("#virtualRam1").text(object.virtualRam);
					var memory="";
					$("#ul_neicun1").empty();
					for(var i=0;i<memarr.length;i++)
					{
						if(memarr[i]==object.virtualRam){
							if(i==0){
								memory+="<li class=' hideclass radius_left qieh' id='"+"m"+i+"'><A class='radius_left ' href='#top_one'>"+memarr[i]+"</A></li>"
							}else if(i==memarr.length-1){
								memory+="<li class='hideclass radius_right qieh' id='"+"m"+i+"'><A class='radius_right gray-border' href='#top_one'>"+memarr[i]+"</A></li>"
							}else{
								memory+="<li class='hideclass qieh' id='"+"m"+i+"'><a   href='#top_two'>"+memarr[i]+"</a></li>"
							}
						}else{
							if(i==0){
								memory+="<li class=' hideclass radius_left' id='"+"m"+i+"'><A class='radius_left ' href='#top_one'>"+memarr[i]+"</A></li>"
							}else if(i==memarr.length-1){
								memory+="<li class='hideclass radius_right' id='"+"m"+i+"'><A class='radius_right gray-border' href='#top_one'>"+memarr[i]+"</A></li>"
							}else{
								memory+="<li class='hideclass' id='"+"m"+i+"'><a href='#top_two'>"+memarr[i]+"</a></li>"
							}
						}	
					}
					$('#ul_neicun1').append(memory);
					
					$("#virtualHard1").text(object.virtualHard);
					$(".caliche").val(object.virtualHard);
					var len=object.virtualHard*1.36;
					$('#btn0').css('left',len+"px");
					$('#bar0 div').css('width',len+"px");
					$('#title0').text(object.virtualHard+'G');
					
					
					var netSource=initNetSource(data.belongCloud);
					var netSourcearr=netSource.split(";");
					 
					if(netSourcearr!=null&&netSourcearr!=undefined){
						var net="";
						for(var i=0;i<netSourcearr.length;i++){
							 
							if($.trim(object.netType)==netSourcearr[i]){
								
								if(netSourcearr[i]=="BGP"){
									if(i==0){
										net+="<li class=\"qieh hideclass radius_left BGP\" id=\"c1\" onclick=\"bgp()\"><a class=\"radius_left\" href=\"#top_one\" >"+netSourcearr[i]+"</a></li>";
									}else if(i==netSourcearr.length-1){
										net+=" <li class=\"qieh hideclass radius_right BGP \" id=\"c2\" onclick=\"bgp()\"><a class=\"radius_right gray-border\" href=\"#top_two\" >"+netSourcearr[i]+"</a></li> ";
									}else{
										net+="<li class=\"qieh BGP \" onclick=\"bgp()\"><a href=\"#top_one\">"+netSourcearr[i]+"</a></li>";
									}
								}else{
									if(i==0){
										 
										net+="<li class=\"qieh hideclass radius_left liantong\" id=\"c1\" onclick=\"liantong()\"><a class=\"radius_left\" href=\"#top_one\">"+netSourcearr[i]+"</a></li>";
									}else if(i==netSourcearr.length-1){
										net+=" <li class=\"qieh hideclass radius_right liantong \" id=\"c2\" onclick=\"liantong()\"><a class=\"radius_right gray-border\" href=\"#top_two\" >"+netSourcearr[i]+"</a></li> ";
									}else{
										net+="<li class=\"qieh liantong \" onclick=\"liantong()\"><a href=\"#top_one\">"+netSourcearr[i]+"</a></li>";
									}
								}
								
							}else{
								if(netSourcearr[i]=="BGP"){
									if(i==0){
										net+="<li class=\" hideclass radius_left BGP\" id=\"c1\" onclick=\"bgp()\"><a class=\"radius_left\" href=\"#top_one\">"+netSourcearr[i]+"</a></li>";
									}else if(i==netSourcearr.length-1){
										net+=" <li class=\" hideclass radius_right BGP \" id=\"c2\" onclick=\"bgp()\"><a class=\"radius_right gray-border\" href=\"#top_two\" >"+netSourcearr[i]+"</a></li> ";
									}else{
										net+="<li class=\" BGP \" onclick=\"bgp()\"><a href=\"#top_one\">"+netSourcearr[i]+"</a></li>";
									}
								}else{
									if(i==0){
										net+="<li class=\"hideclass radius_left liantong\" id=\"c1\" onclick=\"liantong()\"><a class=\"radius_left\" href=\"#top_one\">"+netSourcearr[i]+"</a></li>";
									}else if(i==netSourcearr.length-1){
										net+=" <li class=\"hideclass radius_right liantong \" id=\"c2\" onclick=\"liantong()\"><a class=\"radius_right gray-border\" href=\"#top_two\" >"+netSourcearr[i]+"</a></li> ";
									}else{
										net+="<li class=\" liantong \" onclick=\"liantong()\"><a href=\"#top_one\">"+netSourcearr[i]+"</a></li>";
									}
								}
							}
						}
						$('.tab_div_a_sys2 ul ').append(net);
					}else{
						//alert("加载失败！");
						$('.zy-warning').html("链路类型加载失败!");
					}
					

					if(object.netType=="BGP"){
						$(".rent .tr2").css('display', 'block');
						$(".rent .tr1").css('display','none');
						$('.company1').val(object.netBandW);
						$("#netWbn1").text(object.netBandW);
						var len2=object.netBandW*13.75;
						$('#btn2').css('left',len1+"px");
						$('#bar2 div').css('width',len1+"px");
						$('#title2').text(object.netBandW+'M');
						
					}else{
						$('.rent .tr1').css('display','block');
						$('.rent .tr2').css('display','none');
						$(".company").val(object.netBandW);
						$("#netWbn1").text(object.netBandW);
						var len1=object.netBandW*2.73;
						$('#btn1').css('left',len1+"px");
						$('#bar1 div').css('width',len1+"px");
						$('#title1').text(object.netBandW+'M');
					}
					
					
					
					$("#netNumber").val(object.netNum);
					$("#netNum1").text(object.netNum);
					
					initOperateSystem(data.belongCloud);
		    		$("#SysTemChild1").text(object.SysTemChild);
		    		if(object.SysTem=="Linux版本"){
						
						$('.linux1').css('display','inline-block');
			    		$('.window1').css('display','none');
			    		$('.ubuntu1').css('display','none');
			    		$('.Linux1 ').addClass('qieh');
			    		$('.linux1').find('li').each(function (){
			    			if($(this).text().trim()==object.SysTemChild)
			    			{
			    				$(this).addClass('blue-w');
			    			}
			    		})
					}else if(object.SysTem=="Window版本"){
						
						$('.linux1').css('display','none');
			    		$('.window1').css('display','inline-block');
			    		$('.ubuntu1').css('display','none');
			    		$(".Window1 ").addClass('qieh');
			    		$('.window1').find('li').each(function (){
			    			 
			    			if($(this).text().trim()==object.SysTemChild)
			    			{
			    				 
			    				$(this).addClass('blue-w');
			    			}
			    		})
					}else if(object.SysTem="Ubuntu"){
						$('.linux1').css('display','none');
			    		$('.window1').css('display','none');
			    		$('.ubuntu1').css('display','inline-block');
			    		$('.Ubuntu1').addClass('qieh');
			    		$('.ubuntu1').find('li').each(function (){
			    			if($(this).text().trim()==object.SysTemChild)
			    			{
			    				 
			    				$(this).addClass('blue-w');
			    			}
			    		})
					}
		    		$("#otherSys1").val(object.SysOtherTem);
		    		$("#SysOtherTem1").text(object.SysOtherTem);
		    		$("#storageSoft1").text(object.storageSoft);
		    		$("#environmentSoft1").text(object.environmentSoft);
		    		
		    		initsoftware(data.belongCloud,object.SysTem,data.prodParam);
		    		
		    		
		    		 
		    		
		    		
		    		
		    		
		    		$("#otherExplain1").text(data.applicantDesc);
		    		
		    		//初始化赋值
		    		$("#virtualType1").text( $('.rent .tab_div_a_sys li.qieh').text()  );
		    		$("#virtualCpu1").text(object.cpu)
		    		$("#netType1").text( $('.rent .tab_div_a_sys2  li.qieh').text() );
		    		$("#SysTem11").text( $('.rent .tab_div_a_sys1 li.qieh').text() );
		    		 
		    		
		    	 
					
				 }else if(data.belongCloud="1")
				 {
					 $("#yfsign").addClass("cur-li");
					 $('.resaerch').css('display','inline-block');
					 $('.rent').css('display','none');
					 $("#applyUser4").text(data.applicant);
					 $("#applyDepartment4").text(data.applicantDept);
					 $("#userPhone4").val(data.applicantTel);
					 $("#userEmail4").text(data.applicantEmail);
					 $("#applyReason4").val(data.applicantReason);
					 if(data.isProject=='Y'){
//						 $("#isProject2").prop('checked')=true;
						 $("#isProject2").attr("checked", true);
					 }
					 $("#projectName4").text(data.costCenterName);
					 $("#costcenter_id4").text(data.costCenterCode);
					 $("#projectNum4").val(data.userMaxNumbers);
					 $("#projectCount4").val(data.concurrentNumbers);
					 if(data.useType=="1")
					 {
							document.getElementById('develop_sign1').checked=true;

					 }else if(data.useType=="2"){ 
							document.getElementById('test_sign1').checked=true;
					 }else if(data.useType=="3"){
						 	document.getElementById('produce_sign1').checked=true;
					 }else if(data.userType="4"){
						 	document.getElementById('other_sign1').checked=true;
					 }
					 $("#projectNot4").val(data.applyDesc);
					 $("#Clock4").text(data.orderAppDate.substr(0,10));
						$("#projectEndTime4").val(data.expirationDate.substr(0,10));
						var object=JSON.parse(data.prodParam);
						$(".tab_div_a_sys ul li").removeClass("qieh");
						$("#virtualType4").text(object.virtualType);
						
						var vmTypearr=initVmtype(data.belongCloud);
						if(vmTypearr!=null&&vmTypearr!=undefined){
							var type="";
							for(var i=0;i<vmTypearr.length;i++){
								if(object.virtualType==vmTypearr[i]){
									if(i==0){
										type+="<li class=\" hideclass radius_left qieh\" id=\"c1\"><a class=\"radius_left\" href=\"#top_one\">"+vmTypearr[i]+"</a></li>"
									}else if(i==vmTypearr.length-1){
										type+="<li class=\"hideclass radius_right qieh\" id=\"c2\"><a class=\"radius_right gray-border\" href=\"#top_two\" >"+vmTypearr[i]+"</a></li> ";
									}else{
										type+=" <li class=\"qieh\"><a href=\"#top_one\">"+vmTypearr[i]+"</a></li>";
									}
								}else{
									if(i==0){
										type+="<li class=\" hideclass radius_left \" id=\"c1\"><a class=\"radius_left\" href=\"#top_one\">"+vmTypearr[i]+"</a></li>"
									}else if(i==vmTypearr.length-1){
										type+="<li class=\"hideclass radius_right \" id=\"c2\"><a class=\"radius_right gray-border\" href=\"#top_two\" >"+vmTypearr[i]+"</a></li> ";
									}else{
										type+=" <li ><a href=\"#top_one\">"+vmTypearr[i]+"</a></li>";
									}
								}
							}
							$(".resaerch .tab_div_a_sys ul").append(type);
						}else{
							//alert("加载失败");
							$('.yf-warning').html("虚拟机类型加载失败!");
						}
						
						
						//研发虚拟机数量
						$("#yf_v-num-countW").val(data.vmNumber);
						$("#yf_v-num-countU").text(data.vmNumber);
					 
						var cpudata=loadcpu(data.belongCloud);
						var arr=cpudata.split(";");
						var cpu="";
						$("#tab_div_ul_cpu4").empty();
						$("#virtualCpu4").text(object.cpu);
						if(arr!=null&&arr.length>0)
						{
							
							for(var i=0;i< arr.length ;i++)
							{
								
								if(arr[i]==object.cpu)
								{
									if(i==0)
									{
										cpu+="<li class='hideclass radius_left qieh' id='"+"c"+i+"'><A class='radius_left  ' href='#top_one' >"+arr[i]+"</A></li>"
									}else if(i==arr.length-1)
									{
										cpu+="<li class='hideclass radius_right qieh ' id='"+"c"+i+"'><a class='radius_right gray-border' href='#top_two' >"+arr[i]+"</a></li> "
									}else{
										cpu+="<li class='hideclass qieh' id='"+"c"+i+"'><A   href='#top_one'>"+arr[i]+"</A></li>"
									}
									
								}else{
									if(i==0)
									{
										cpu+="<li class='hideclass radius_left ' id='"+"c"+i+"'><A class='radius_left' href='#top_one' >"+arr[i]+"</A></li>"
									}else if(i==arr.length-1)
									{
										cpu+="<li class='hideclass radius_right ' id='"+"c"+i+"'><a class='radius_right gray-border' href='#top_two' >"+arr[i]+"</a></li> "
									}else{
										cpu+="<li class='hideclass ' id='"+"c"+i+"'><A  href='#top_one' >"+arr[i]+"</A></li>"
									}
								}
								 
								
							}
							$('#tab_div_ul_cpu4').append(cpu);
							
									
						}else{
							$('.yf-warning').html("cpu加载失败!");
							//alert("加载失败");
						}
						var mem=loadmemory(data.belongCloud,object.cpu);
						var memarr=mem.split(";");
						 
						var memory="";
						$("#virtualRam4").text(object.virtualRam);
						$("#ul_neicun4").empty();
						for(var i=0;i<memarr.length;i++)
						{
							if(memarr[i]==object.virtualRam){
								if(i==0){
									memory+="<li class=' hideclass radius_left qieh' id='"+"m"+i+"'><A class='radius_left ' href='#top_one'>"+memarr[i]+"</A></li>"
								}else if(i==memarr.length-1){
									memory+="<li class='hideclass radius_right qieh' id='"+"m"+i+"'><A class='radius_right gray-border' href='#top_one'>"+memarr[i]+"</A></li>"
								}else{
									memory+="<li class='hideclass qieh' id='"+"m"+i+"'><a   href='#top_two'>"+memarr[i]+"</a></li>"
								}
							}else{
								if(i==0){
									memory+="<li class=' hideclass radius_left' id='"+"m"+i+"'><A class='radius_left ' href='#top_one'>"+memarr[i]+"</A></li>"
								}else if(i==memarr.length-1){
									memory+="<li class='hideclass radius_right' id='"+"m"+i+"'><A class='radius_right gray-border' href='#top_one'>"+memarr[i]+"</A></li>"
								}else{
									memory+="<li class='hideclass' id='"+"m"+i+"'><a href='#top_two'>"+memarr[i]+"</a></li>"
								}
							}	
						}
						$('#ul_neicun4').append(memory);
						$(".caliche1").val(object.virtualHard);
						$("#virtualHard4").text(object.virtualHard)
						var len=object.virtualHard*1.36;
						$('#btn4').css('left',len+"px");
						$('#bar4 div').css('width',len+"px");
						$('#title4').text(object.virtualHard+'G');

						$(".tab_div_a_sys1 ul li").removeClass('qieh');
						$('.linux2 li').removeClass('blue-w');
			    		$('.window2 li').removeClass('blue-w');
			    		$('.ubuntu2 li').removeClass('blue-w');
						
			    		initOperateSystem(data.belongCloud);
			    		$("#SysTem4").text(object.SysTem);
			    		$("#SysTemChild4").text(object.SysTemChild);
			    		if(object.SysTem.trim()=="Linux版本"){
							 
							$('.linux2').css('display','inline-block');
				    		$('.window2').css('display','none');
				    		$('.ubuntu2').css('display','none');
				    		$('.Linux1 ').addClass('qieh');
				    		$('.linux2').find('li').each(function (){
				    			if($(this).text().trim()==object.SysTemChild)
				    			{
				    				$(this).addClass('blue-w');
				    			}
				    		})
						}else if(object.SysTem.trim()=="Window版本"){
							
							$('.linux2').css('display','none');
				    		$('.window2').css('display','inline-block');
				    		$('.ubuntu2').css('display','none');
				    		$(".Window1 ").addClass('qieh');
				    		$('.window2').find('li').each(function (){
				    			 
				    			if($(this).text().trim()==object.SysTemChild)
				    			{
				    				 
				    				$(this).addClass('blue-w');
				    			}
				    		})
						}else if(object.SysTem.trim()="Ubuntu"){
							$('.linux2').css('display','none');
				    		$('.window2').css('display','none');
				    		$('.ubuntu2').css('display','inline-block');
				    		$('.Ubuntu1').addClass('qieh');
				    		$('.ubuntu2').find('li').each(function (){
				    			if($(this).text().trim()==object.SysTemChild)
				    			{
				    				 
				    				$(this).addClass('blue-w');
				    			}
				    		})
						}
			    		$("#otherSys2").val(object.SysOtherTem);
			    		$("#SysOtherTem4").text(object.SysOtherTem);
			    		var storarr=object.storageSoft.split(",");
			    		$("#storageSoft4").text(object.storageSoft);
			    		initsoftware(data.belongCloud, object.SysTem.trim(), data.prodParam )
			    		$("#environmentSoft4").text(object.environmentSoft);
			    		
			    					    		
			    		$("#otherExplain2").val(data.applicantDesc);
			    		
			    		
						
						
						
					 
					 
					 
				 }
			}
		}
	})
	
}

function loadcpu(belongCloud){
	var cloudid=belongCloud;
	 result='';
	$.ajax({
		async:false,
		type:"POST",
		url:getContextPath()+"/formulate/loadcpu",
		data:{
			belongCloud:cloudid
		},
		
		success: function(data){
			 
				result=data.cpu; 
			
			
		}
		
		
	})
	 
	return result;
	
}

function loadmemory(cpu,cpuNum)
{
	var cloudid=cpu;
	var cpunum=cpuNum;
	result='';
	$.ajax({
		async:false,
		type:"POST",
		url:getContextPath()+"/formulate/loadMemory",
		data:{
			cpu:cloudid,
			cpuNum:cpunum
		},
		success: function(data){
			
			result=data.memory; 
		}
	})
	return result;
}



function changememory(cpuNum)
{
	 
	var cpunum=cpuNum;
	var cloudid=$('#cloud_id').val();
 
	
	$.ajax({
		async:false,
		type:"POST",
		url:getContextPath()+"/formulate/loadMemory",
		data:{
			cpu:cloudid,
			cpuNum:cpunum
		},
		success: function(data){
			 
			if(data.memory!=null&&data.memory!=undefined&&data.memory!="")
			{
				 
				var arr=data.memory.split(";");
				 
				var memory="";
				 
				if(cloudid==2)
				{
					$('#ul_neicun1').empty();
				}else if(cloudid==1){
					$('#ul_neicun4').empty();
				}
				
				for(var i=0;i<arr.length;i++)
				{
						if(i==0){
							memory+="<li class=' hideclass radius_left qieh' id='"+"m"+i+"'><A class='radius_left ' href='#top_one'>"+arr[i]+"</A></li>"
						}else if(i==arr.length-1){
							memory+="<li class='hideclass radius_right ' id='"+"m"+i+"'><A class='radius_right gray-border' href='#top_one'>"+arr[i]+"</A></li>"
						}else{
							memory+="<li class='hideclass ' id='"+"m"+i+"'><a   href='#top_two'>"+arr[i]+"</a></li>"
						}
						
				}
				
				if(cloudid==2)
				{
					
					$('#ul_neicun1').append(memory);
				}else if(cloudid==1){
					$('#ul_neicun4').append(memory);
				}
					
			}
			$('#ul_neicun1  li a').click(function(){
				$(this).parent('li').addClass('qieh');
				$(this).parent('li').siblings('li').removeClass('qieh');
				$("#virtualRam1").text($(this).text()); 
			})
			$('#ul_neicun4  li a').click(function(){
				$(this).parent('li').addClass('qieh');
				$(this).parent('li').siblings('li').removeClass('qieh');
				$("#virtualRam4").text($(this).text()); 
			})
	
		}
	})
	

}

function initVmtype(belongCloud) {
	var cloudid=belongCloud;
	var result;
	$.ajax({
		type:"POST",
		async:false,
		url:getContextPath()+"/formulate/loadVmtype",
		data:{
			belongCloud:cloudid
		},
		success:function(data){
			if(data.VmType!=""||data.VmType!=undefined||data.VmType!=null){
				
				var arr=data.VmType.split(";");
			 
				result=arr;
			}else{
				//alert("缓存请求失败!");
				$(".zy-warning").text("虚拟机类型缓存请求失败!");
			}
		}
		
	});
	return result;
}

function initNetSource(belongCloud){
	var cloudid=belongCloud;
	var result;
	$.ajax({
		async:false,
		type:"POST",
		url:getContextPath()+"/formulate/loadNetSource",
		data:{
			belongCloud:cloudid
		},
		success:function(data){
			if(data.NetSource!=""||data.NetSource!=undefined||data.NetSource!=null){
				 result=data.NetSource;
			}else{
				alert("请求缓存失败！");		
			}
		}
	});
	return result;
}

function initOperateSystem(belongCloud){
	var cloudid=belongCloud;
	var result;
	$.ajax({
		async:false,
		type:"POST",
		url:getContextPath()+"/formulate/loadOperateSystem",
		data:{
			belongCloud:cloudid
		},
		success:function(data){
			if(data.operatesystem!=""||data.operatesystem!=null||data.operatesystem!=undefined){
				var sysarr=data.operatesystem;
				var sys="";
				 
				for(var i=0;i<sysarr.length;i++)
				{
					if(sysarr[i].code=="Linux版本"){
						sys+="<li class=\"hideclass radius_left Linux1 \" id=\"c1\"><a class=\"radius_left\" href=\"#top_one\" onclick=\"initsoftware("+cloudid+",this.innerHTML)\">"+sysarr[i].code+"</a></li>";
						initsystemchild(sysarr[i],cloudid);
					}else if(sysarr[i].code=="Window版本"){
						sys+="<li class=\"Window1\"><a href=\"#top_one\" onclick=\"initsoftware("+cloudid+",this.innerHTML)\">"+sysarr[i].code+"</a></li>";
						initsystemchild(sysarr[i],cloudid);
					}else if(sysarr[i].code=="Ubuntu"){
						sys+="<li class=\"hideclass radius_right Ubuntu1\" id=\"c2\"><a class=\"radius_right gray-border\" href=\"#top_two\" onclick=\"initsoftware("+cloudid+",this.innerHTML)\">"+sysarr[i].code+"</a></li>";
						initsystemchild(sysarr[i],cloudid);
					}
				}
				if(cloudid==2){
					$('.system1').append(sys);
				}else if(cloudid==1){
					$('.system2').append(sys);
				}
			}
		}
	})
}
function initsystemchild(sysarr,belongCloud){
	var sys=sysarr;
	var childarr=sysarr.value.split(";");
	var signclass="";
	if(sysarr.code=="Linux版本"){
		if(belongCloud==2){
			signclass="linux1";
		}else{
			signclass="linux2";
		}
		
	}else if(sysarr.code=="Window版本"){
		if(belongCloud==2){
			signclass="window1";
		}else{
			signclass="window2";
		}
		
	}else if(sysarr.code=="Ubuntu"){
		if(belongCloud==2){
			signclass="ubuntu1";
		}else{
			signclass="ubuntu2";
		}
		
	}
	var child=""
	for(var i=0;i<childarr.length;i++)
	{
		child+="<li>"+childarr[i]+"</li>";
	}
	$('.'+signclass).append(child);
}

function initsoftware(belongCloud,system,prodPram){
	var cloudid=belongCloud;
	var systemcode=system;
	var prodpram="";
	prodpram=prodPram;
	var result=new Array();
	
	$.ajax({
		 async:false,
		 type:"POST",
		 url:getContextPath()+"/formulate/loadSoftware",
		 data:{
			 belongCloud:cloudid,
			 SystemCode:systemcode
			 
		 },
		 success:function(data){
			 if(data.runSys!=null&&data.runSys!=""&&data.runSys!=undefined&&data.storeSys!=null&&data.storeSys!=""&&data.storeSys!=undefined){
				 
				 var run=data.runSys.split(";");
				 var store=data.storeSys.split(";");
				 var sto="";
				 var run1="" ;
				 if(cloudid==2){
					 $('.rent  .save-soft-content').empty();
					 $('.rent .run-soft-content').empty();
					 for(var i=0;i<store.length;i++){
							sto+="<div class='check-content"+i+"'>";
		 					sto+="<input type=\"checkbox\" name=\"storageSoft1\" class='check-btn"+i+"' id='check-btn"+i+"'  onclick=\"softCheck()\">";
		 					sto+="<div>"+store[i]+"</div>";
		 					sto+="</div>"	
						 }
					 
					 for(var j=0;j<run.length;j++){
						 var num=store.length+j;
						 run1+="<div class='check-content"+num+"'>";
						 run1+="<input type=\"checkbox\" name=\"storageSoft2\" class='check-btn"+num+"' id='check-btn"+num+"' onclick=\"softCheck2();\" >";
						 run1+="<span>"+run[j]+"</span>";
						 run1+="</div>";
					 }
					 $('.rent  .save-soft-content').append(sto);
					 $('.rent .run-soft-content').append(run1);
				 }else if(cloudid==1){
					 $('.resaerch  .save-soft-content').empty();
			    	 $('.resaerch .run-soft-content').empty();
					 for(var i=0;i<store.length;i++){
						 	sto+="<div class='check-content"+i+"'>";
	    					sto+="<input type=\"checkbox\" name=\"storageSoft4\" class='check-btn"+i+"' id='check-btn"+i+"'  onclick=\"softCheck4()\">";
	    					sto+="<div>"+store[i]+"</div>";
	    					sto+="</div>"	
					 }
					 for(var j=0;j<run.length;j++){
						 var num=store.length+j;
						 run1+="<div class='check-content"+num+"'>";
						 run1+="<input type=\"checkbox\" name=\"storageSoft5\" class='check-btn"+num+"' id='check-btn"+num+"' onclick=\"softCheck5();\" >";
						 run1+="<span>"+run[j]+"</span>";
						 run1+="</div>";
					 }
					 $('.resaerch  .save-soft-content').append(sto);
			    	 $('.resaerch .run-soft-content').append(run1);
					 
					 
					 
				 }
				 result[0]=store;
				 result[1]=run;
				
				 
				 
				 
				 
				 
			 }else{
				 alert("缓存加载失败");
			 }
		 }
	})
	 
	if(prodpram!=""&&prodpram!=undefined&&prodpram!=null){
		 
		var object=JSON.parse(prodpram);
		var storarr=object.storageSoft.split(",");
		var storeparam=result[0];
		var runparam=result[1];
		
		for(var j=0;j<storeparam.length;j++){
			for(var i=0;i<storarr.length;i++)
			{
				if(storarr[i].trim()==storeparam[j]){
					document.getElementById('check-btn'+j).checked=true;
				} 
			}
		}
		
		var sysarr=object.environmentSoft.split(","); 
		for(var i=0;i<runparam.length;i++){
			for(var j=0;j<sysarr.length;j++){
				
				var num=storeparam.length+i;
				
				if(sysarr[j].trim()==runparam[i]){
					document.getElementById('check-btn'+num).checked=true;
				} 
			}
		}
		
	}
	 
	
}

function zyCloudModify() {
	 var phone=$("#userPhone1").val();
	 var sign=checknumber(phone);
	 if(sign==false){
		 $('.zy-warning').html("您输入的联系电话格式有误请重新输入");
		 $('#userPhone1').css('border','1px solid red')
		 return false;
	 }
	 if($('.time1').html()>$('.time1-1').val()){
			//alert('截止日期需大于当前日期');
		 $('.zy-warning').html('截止日期需大于当前日期')
			return false;
		}
	 if( $('#applyReason1').val()==''){
			//alert("请填写申请原因");
		 $('.zy-warning').html("请填写申请原因")
		 $('#applyReason1').css('border','1px solid red')
			return false;
	 }
	 if($('#projectNum1').val()==''){
		   //alert('请输入用户数');
		 $('.zy-warning').html("请输入用户数")
		  $('#projectNum1').css('border','1px solid red')
		   return false;
	 }
	 if($('#projectCount1').val()=='') {
			//alert("请填写访问量");
		 $('.zy-warning').html("请填写访问量")
		 $('#projectCount1').css('border','1px solid red')
			return false;
		}
	 var b=document.getElementsByName('function');
	 if(b[0].checked=="false"&&b[1].checked=='false'){
			//alert("请填写用途说明");
			 $('.zy-warning').html("请填写用途说明")
			return false;
	 }
	 if( $('#projectNot1').val()=='') {
			//alert("请填写业务描述");
		 $('.zy-warning').html("请填写业务描述")
		 $('#projectNot1').css('border','1px solid red')
			return false;
	 }
	   
	 if( $('#projectEndTime1').val()=='') {
			//alert("请填写结束时间");
		 $('.zy-warning').html("请填写结束时间")
		 $('#projectEndTime1').css('border','1px solid red')
			return false;
	 }
	 if($('.v-num1').val()==''){
		 $('.v-num1').css('border','1px solid red')
		 $('.zy-warning').html("请填写虚拟机数量")
		 	return false;
	 }
	 if($('#virtualType1').text()==''||$('#virtualCpu1').text()==''||$('#virtualRam1').text()==''||$('#virtualHard1').text()==''){
//		 	alert('请填写基本配置');
		 $('.zy-warning').html("请填写基本配置")
		 	return false;
	 }
	 if($('#netNumber').val()>$('#zy_v-num-countW').val()){
		 $('.zy-warning').html("公网数量需小于虚拟机数量")
		 	return false;
	 }
	 if($(netType1).text()==''||$(netWbn1).text()==''||$(netNum1).text()==''){
		 	//alert('请选择网络资源');
		 $('.zy-warning').html("请选择网络资源")
		 	return false;
	 }
	 if (  $('#SysTem11').text()=='' || $('#SysTemChild1').text()=='' ) {
		 $('.zy-warning').html("请选择操作系统")	
		 //alert("请选择操作系统");
			return false;
	 }
	 if ($('#storageSoft1').text()=='' || $('#environmentSoft1').text()=='') {
			//alert("请选择安装软件");
			 $('.zy-warning').html("请选择安装软件")
			return false;
	 }
	 
	var isProject;
	if($("#isProject1").prop('checked')){
		isProject='Y';
	}else{
		isProject='N';
	}
	 $.ajax({
		 type:"POST",
	 	 url:getContextPath()+"/virtualMachineModify/Cloudmodify",
	 	 data:{
	 		 	orderDetailId: $("#orderDetailId").val(),
	 		 	belongCloud: $('#cloud_id').val(),
	 		 	applicantTel: $('#userPhone1').val(),
	 		 	applicantReason: $('#applyReason1').val(),
	 		 	costCenterName: $('#projectName1').text(),
	 		 	costCenterCode: $('#costcenter_id1').text(),
	 		 	userMaxNumbers:	$('#projectNum1').val(),
	 		 	concurrentNumbers: $('#projectCount1').val(),
	 		 	useType: $('input[name = "function"]:checked').val(),//用途说明
	 		 	applyDesc: $('#projectNot1').val(),
	 		 	expirationDate:$('#projectEndTime1').val(),
	 		 	virtualType:$('#virtualType1').text().trim(),
	 		 	vmNumber:$('#zy_v-num-countU').text().trim(), // 虚拟机数量
	 		 	virtualCpu :$('#virtualCpu1').text().trim(),//CPU
				virtualRam :$('#virtualRam1').text().trim(),//内存
				virtualHard :$('#virtualHard1').text().trim(),//数据盘
				netType :$('#netType1').text().trim(),//链路类型
				netBandW :$('#netWbn1').text().trim(),//公司宽带
				netNum :$('#netNum1').text().trim(),//公网数量
				//操作系统
				SysTem: $('#SysTem11').text().trim(),//操作系统
				SysTemChild :$('#SysTemChild1').text().trim(),//操作系统版本
				SysOtherTem :$('#SysOtherTem1').text(),//其他操作系统
				//安装软件
				storageSoft : $('#storageSoft1').text().trim(),//存储软件
				environmentSoft :$('#environmentSoft1').text(),//运行环境软件
				applicantDesc  :$('#otherExplain1').val(),//其他补充说明
				isProject:isProject
	 		
	 	 },
	 	 success: function(data){
	 		 //var object=JSON.parse(data);
	 		 if(data.responseCode=='000000'){
	 			// alert('租用云修改成功');
	 			location.href=getContextPath()+"/mcs/applyCompleted?prod=IAAS_VIRTAL&flag=Update";  //&url=virtualMachine/goVirtualMachineApply
	 		 }else{
	 			 //alert('租用云修改失败');
	 			$('.zy-warning').text(data.responseMsg);
	 		 }
	 	 },
	 	 error : function(data) {
			//alert("请求失败！")
	 		$('.zy-warning').html("请求失败！");
			}
	 })
}


function yfCloudMofify(){
	 var phone=$("#userPhone4").val();
	 var sign=checknumber(phone);
	 if(sign==false){
		 $('.yf-warning').html("您输入的联系电话格式有误请重新输入");
		 $('#userPhone4').css('border','1px solid red')
		 return false;
	 }
	 if($('.time2').html()>$('.time2-1').val()){
			//alert('截止日期需大于当前日期');
			 $('.yf-warning').html("截止日期需大于当前日期");
			return false;
		}
	 if( $('#applyReason4').val()==''){
			//alert("请填写申请原因");
		 $('.yf-warning').html("请填写申请原因");
		 $('#applyReason4').css('border','1px solid red')
			return false;
	 }
	 if($('#projectNum4').val()==''){
		   //alert('请输入用户数');
		   $('.yf-warning').html("请输入用户数");
		   $('#projectNum4').css('border','1px solid red')
		   return false;
	 }
	 if($('#projectCount4').val()=='') {
			//alert("请填写访问量");
		 $('.yf-warning').html("请填写访问量");
		 $('#projectCount4').css('border','1px solid red')
			return false;
		}
	 var b=document.getElementsByName('function2');
	 if(b[0].checked=="false"&&b[1].checked=='false'){
			//alert("请填写用途说明");	
		 $('.yf-warning').html("请填写用途说明");
			return false;
	 }
	 if( $('#projectNot4').val()=='') {
			//alert("请填写业务描述");
		 $('.yf-warning').html("请填写业务描述");
		 $('#projectNot4').css('border','1px solid red')
			return false;
	 }
	   
	 if( $('#projectEndTime4').val()=='') {
		 $('.yf-warning').html("请填写结束时间");	
		 $('#projectEndTime4').css('border','1px solid red')
		 //alert("请填写结束时间");
			return false;
	 }
	 if($('#virtualType4').text()==''||$('#virtualCpu4').text()==''||$('#virtualRam4').text()==''||$('#virtualHard4').text()==''){
		 	//alert('请填写基本配置');
		 	$('.yf-warning').html("请填写基本配置");	
		 	return false;
	 }
	 if($('.v-num2').val()==''){
		 $('.yf-warning').html("请输入虚拟机数量");	
		 $('.v-num2').css('border','1px solid red')
		 	return false;
	 }
	 if (  $('#SysTem4').text()=='' || $('#SysTemChild4').text()=='' ) {
			//alert("请选择操作系统");
			$('.yf-warning').html("请选择操作系统");
			return false;
	 }
	 if ($('#storageSoft4').text()=='' || $('#environmentSoft4').text()=='') {
			//alert("请选择安装软件");
			$('.yf-warning').html("请选择安装软件");
			return false;
	 }
	 var isProject;
	 if($("#isProject2").prop('checked')){
		isProject='Y';
	 }else{
		isProject='N';
	 }
	 $.ajax({
		 type:"POST",
	 	 url:getContextPath()+"/virtualMachineModify/Cloudmodify",
	 	 data:{
	 		orderDetailId: $("#orderDetailId").val(),
 		 	belongCloud: $('#cloud_id').val(),
 		 	applicantTel: $('#userPhone4').val(),
 		 	applicantReason: $('#applyReason4').val(),
 		 	costCenterName: $('#projectName4').text(),
 		 	costCenterCode: $('#costcenter_id4').text(),
 		 	userMaxNumbers:	$('#projectNum4').val(),
 		 	concurrentNumbers: $('#projectCount4').val(),
 		 	useType: $('input[name = "function2"]:checked').val(),//用途说明
 		 	applyDesc: $('#projectNot4').val(),
 		 	expirationDate:$('#projectEndTime4').val(),
 		 	virtualType:$('#virtualType4').text().trim(),  
 		 	vmNumber:$('#yf_v-num-countU').text().trim(), // 虚拟机数量  
 		 	virtualCpu :$('#virtualCpu4').text().trim(),//CPU    
			virtualRam :$('#virtualRam4').text().trim(),//内存
			virtualHard :$('#virtualHard4').text().trim(),//数据盘
			//操作系统
			SysTem: $('#SysTem4').text().trim(),//操作系统
			SysTemChild :$('#SysTemChild4').text().trim(),//操作系统版本
			SysOtherTem :$('#SysOtherTem4').text(),//其他操作系统
			//安装软件
			storageSoft : $('#storageSoft4').text().trim(),//存储软件
			environmentSoft :$('#environmentSoft4').text().trim(),//运行环境软件
			applicantDesc  :$('#otherExplain2').val(),//其他补充说明
			isProject:isProject
			
	 	 },
	 	 success: function(data){
	 		// alert("success  data"+data.responseCode);
//	 		var object=JSON.parse(data);
//	 		alert("success object"+object.responseCode);
	 		 if(data.responseCode=="999999"){
	 			// alert('研发云修改失败');
	 			$('.yf-warning').text(data.responseMsg);
	 			
	 		 }else{
	 			 //alert('研发云修改成功');
	 			location.href=getContextPath()+"/mcs/applyCompleted?prod=IAAS_VIRTAL&flag=Update"; //&url=virtualMachine/goVirtualMachineApply?prod=IAAS_VIRTAL&url=virtualMachine/goVirtualMachineApply
	 		 }
	 	 },
	 	 error : function(data) {
	 		 //alert("error"+object.responseCode)
				//alert("请求失败！")
				$('.yf-warning').html("请求失败！");
				}
	 })
}

function checknumber(value){
	var phone = value;
	var reg = /^0?(13|15|17|18|14)[0-9]{9}$/;
	if(phone.length != 11 || reg.test(phone) == false){
		 return false;
		
	}else{
		 return true;
		
	}	
}

function bgp(){
	 $('.tr2').css('display','inline-block');
	 $('.tr1').css('display','none');
	 $('#netWbn1').text($(".company1").val());
}

function liantong(){
	$('.tr1').css('display','inline-block');
	$('.tr2').css('display','none');
	$('#netWbn1').text($(".company").val());
}


//租用手机
function checkMobile(value){
	if(value!=''){
		$('#userPhone1').css('border','1px solid #ccc')
	}
}
//租用申请原因
function checkReason1(){
	if($('#applyReason1').val()!=''){
		$('#applyReason1').css('border','1px solid #ccc')
	}
}
//租用用户数
function checkUsernum1(value){
	if(value!=null){
		$('#projectNum1').css('border','1px solid #ccc')
	}
}
//租用并发访问量
function checkVisitum1(value){
	if(value!=null){
		$('#projectCount1').css('border','1px solid #ccc')
	}
}
//租用业务描述
function checkBusiness1(){
	if($('#projectNot1').val()!=''){
		$('#projectNot1').css('border','1px solid #ccc')
	}
}
//租用到期时间
function timeCheck1(value){
	if(value!=null || value!=''){
		$('#projectEndTime1').css('border','1px solid #ccc')
	}
}
//租用虚拟机数量
function checkNum1(value){
	if($('.v-num1').val()!=''){
		$('.v-num1').css('border','1px solid #ccc');
		$('#zy_v-num-countU').text(value);
		
	}
	
	
}
//租用公网数量
function checkNetnumber(value){
	if(value!=''){
		$('#netNumber').css('border','1px solid #ccc')
	}
}



//研发手机
function checkMobile2(value){
	if(value!=''){
		$('#userPhone4').css('border','1px solid #ccc')
	}
}
//研发申请原因
function checkReason2(){
	if($('#applyReason4').val()!=''){
		$('#applyReason4').css('border','1px solid #ccc')
	}
}
//研发用户数
function checkUserum2(value){
	if(value!=null){
		$('#projectNum4').css('border','1px solid #ccc')
	}
}
//研发并发访问量
function checkVisitum2(value){
	if(value!=null){
		$('#projectCount4').css('border','1px solid #ccc')
	}
}
//研发业务描述
function checkBusiness2(){
	if($('#projectNot4').val()!=''){
		$('#projectNot4').css('border','1px solid #ccc')
	}
}
//研发到期时间
function timeCheck2(value){
	if(value!=null || value!=''){
		$('#projectEndTime4').css('border','1px solid #ccc')
	}
	
}
//研发虚拟机数量
function checkNum2(value){
	if($('.v-num2').val()!=''){
		$('.v-num2').css('border','1px solid #ccc');
		$('#yf_v-num-countU').text(value);
	}
	
	
}