// JavaScript Document
	$(function(){
		
		var w=$('.content').width();
//		var h=$('.content').height();
		var h=1000;
		$('.coverBox').css({'width':w+'px','height':h+'px'})
		
		$('.catelogy li').click(function(){
			$(this).addClass('li-cloud').siblings().removeClass('li-cloud');
		})
		$('.catelogy li').eq(0).click(function(){
			$('#belongCloud_V').val('1');
			querytickets(1);
		})
		$('.catelogy li').eq(2).click(function(){
			$('#belongCloud_V').val('2')
			querytickets(1);
		})
		$('.catelogy li').eq(1).click(function(){
			$('#belongCloud_V').val('')
			querytickets(1);
		})
	// 时间排序顺序降序
		var flag=true;
		$('.time-turn').click(function(){
			if (flag) {
				$(this).addClass('turn-up');
				flag=false;
			}else{
				$(this).removeClass('turn-up');
				flag=true;
			};
		})
		// 搜索关键字
		$('.key').focus(function(){
			if ($(this).val()=='请输入关键字') {
				$(this).val('')
			};
		})
		$('.key').blur(function(){
			if ($(this).val()=='') {
				$(this).val('请输入关键字')
			};
		})
		// 搜索关键字
		$('.search-txt').click(highlight);//点击search时，执行highlight函数；
        // $('#clear').click(clearSelection);//点击clear按钮时，执行clearSelection函数；
		//alert("3");
		highlight();
       
        
		clearSelection();
      
    	// cpu背景切换
    	$('.tab_div_a_cpu ul li a').click(function(){
    		$(this).addClass('blue-b').parents('li').siblings('li').children('a').removeClass('blue-b')
    	})
    	// 内存背景切换
    	$('.tab_div_a_neicun ul li a').click(function(){
    		$(this).addClass('blue-b').parents('li').siblings('li').children('a').removeClass('blue-b')
    	})
    	// 链路类型背景切换
    	$('.net ul li a').click(function(){
    		$(this).addClass('blue-b').parents('li').siblings('li').children('a').removeClass('blue-b')
    	})
    	// 操作系统点击切换值
    	$('.Linux1').click(function(){
    		$('.linux1').css('display','inline-block');
    		$('.window1').css('display','none');
    		$('.ubuntu1').css('display','none');
    	})
    	$('.Window1').click(function(){
    		$('.linux1').css('display','none')
    		$('.window1').css('display','inline-block')
    		$('.ubuntu1').css('display','none')
    	})
    	$('.Ubuntu1').click(function(){
    		$('.linux1').css('display','none')
    		$('.window1').css('display','none')
    		$('.ubuntu1').css('display','inline-block')
    	})
    	// 操作系统下li背景
    	//alert("5");
    	$('.linux1 li').click(function(){
    		$(this).addClass('blueLi').siblings().removeClass('blueLi');
    	})
    	$('.window1 li').click(function(){
    		$(this).addClass('blueLi').siblings().removeClass('blueLi');
    	})
    	$('.ubuntu1 li').click(function(){
    		$(this).addClass('blueLi').siblings().removeClass('blueLi');
    	})
    	
    	
    	function highlight()
	        {
	            clearSelection();//先清空一下上次高亮显示的内容；
	            var searchText = $('#key').val();//获取你输入的关键字；
	            var regExp = new RegExp(searchText, 'g');//创建正则表达式，g表示全局的，如果不用g，则查找到第一个就不会继续向下查找了；
	            $('.guzhang-txt').each(function()//遍历文章；
	            {
	                var html = $(this).html();
	                var newHtml = html.replace(regExp, '<span class="highlight">'+searchText+'</span>');//将找到的关键字替换，加上highlight属性；
	 
	                $(this).html(newHtml);//更新文章；
	            });
	        }
    	
	        function clearSelection()
	        {
	            $('.guzhang-txt').each(function()//遍历
	            {
	                $(this).find('.highlight').each(function()//找到所有highlight属性的元素；
	                {
	                    $(this).replaceWith($(this).html());//将他们的属性去掉；
	                });
	            });
	        }

	    //beging*****************************************************
	      var page = $('#kkpage_temp_value').val();
		       // alert("page0:"+page)
		   if(page!=null && page!=undefined && page!=""){
			  // alert("page11:"+page)
		        	querytickets(page); //用于 开通录入，确认安装的跳转页面初始化加载查询
		   }else{
		      querytickets(1); // 用于三和一页面初始化查询
		   }
		   $('#kkpage_temp_value').val("");  // temp 用完之后将其置空。
		//end*****************************************************
		        
    	// 数据盘进度条
//    	new scale('btn0', 'bar0', 'title0'); 
//    	new scale1('btn1', 'bar1', 'title1'); 
    	
	})
	

//****************************************************************************************************

// 数据盘进度条开始
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
	}
}
function move(){
	var w=0;
	var w =parseInt($('.caliche').val())
	var w1=w*1.36;
	// alert(w+10)
	if (w>=10 && w<=200) {
		
		$('#bar0 div').css('width',w1+'px');
		$('#btn0').css('left',w1+'px');
		$('#title0').html(w+'G');
	}
};
// 本地进度条结束
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
				f.ondrag(m.round(m.max(0, to / max) * 90), to);
				// $('.caliche').val(to)
				b.getSelection ? b.getSelection().removeAllRanges() : g.selection.empty();

			};
			g.onmouseup = new Function('this.onmousemove=null');
		};
	},
	ondrag: function (pos, x) {
		this.step.style.width = Math.max(0, x) + 'px';
		this.title.innerHTML = pos+10+ 'M';
		$('.net-value').val(pos+10)
	}
}
function move1(){
	var w=0;
	var w =parseInt($('.net-value').val())
	var w1=w*2.73;
	// alert(w+10)
	if (w>=10 && w<=100) {
		
		$('#bar1 div').css('width',w1+'px');
		$('#btn1').css('left',w1+'px');
		$('#title1').html(w+'G');
	}
};



function madeBox1(OrderDetailId,OrderWoId,url,status,cloudid,vmnumber,netBand,sysTem){
	var kkpage =$("#kkpager .pageBtnWrap .curr").text();
	//alert("kkpage:"+kkpage);
	
	var operateId=$('#operateID').val();
	var url=getContextPath() +"/input/openInit";
	var param={DetailId:OrderDetailId,WoId:OrderWoId,operate_id:operateId,belongCloud:cloudid,Vmnumber:vmnumber,NetBand:netBand,SysTem:sysTem,kkpage:kkpage};
	
	postRequest(url,param);
}


function contentBox(){
	$('.madeBox').css('display','none');
	$('.content').css('display','block');
}


/**
 * 集成方案页面查询
 */
function querytickets(pageNum){
	
	var operateID=$('#operateID').val();
	var belongCloud_V=$("#belongCloud_V").val(); // 归属平台	  1研发云   2租用云 
	 
	var flagT=1;
	if(!flag){
		flagT = 2;
	}
	var jsondata1={
		"belongCloud" : belongCloud_V,  
		"currentPage": pageNum,
		"PageSize": "3",
		"sortFlag": flagT,//排序标志
		"applicant": $("#selectUserName").val(),//报告人
		"applicantTel": $("#selectUserPhone").val(),//手机号
		"applicantDept": $("#selectUserDepartment").val(),//部门信息
		"applyDesc": $("#selectKey").val(),  //关键字查询
		"appDateStart":$("#registerDateStart").val(),
		"appDateEnd":$("#registerDateEnd").val()
	}
	 
	var jsondata=JSON.stringify(jsondata1);
	$.ajax({
		   		cache: true,
				type:"POST",
				url: getContextPath() +"/vmQuery/vmOrderDetailQuery",
				data: "jsondata="+jsondata,	
				dataType: 'json',
				async: true,
				error: function(data){
					$("#content-info").empty();
				},
				success: function(data){
					var orderInfo="";
					var totalCount=0;
					var totalPage=0;
					var currentPage=0;
					var PageSize=0;
					if(data.msg){
						orderInfo+="<div class=\"info\">";
						orderInfo+=" <h2>"+data.msg+"</h2>";
						orderInfo+="</div>";
					}else{
						totalCount=data.totalCount;
                        totalPage=data.totalPage;
                        currentPage=data.currentPage;
                        PageSize=data.PageSize;
                        obj=eval(data);
                        if(obj.list!=null&&obj.list!=undefined&&obj.list!=""){
                            $.each(obj.list,function(i,a){
                            	var obj1 = eval("("+a.prodParam+")");
                                orderInfo+="<li class=\"info\">";
                                orderInfo+="<div class=\"fault-num\">"+a.orderDetailId+"</div>";
                                orderInfo+="<ul class=\"info-top\">";
                                orderInfo+="<li>";
                                orderInfo+="<span class=\"report-tittle gray\">报告人:</span>";
                                orderInfo+="<span class=\"report-info\">"+a.applicant+"</span>";
                                orderInfo+="</li>";
                                orderInfo+="<li>";
                                orderInfo+="<span class=\"contact gray\">联系方式：</span>";
                                orderInfo+="<span class=\"contact-info\">"+a.applicantTel+"</span>";
                                orderInfo+="</li>";
                                orderInfo+="<li>";
                                orderInfo+="<span class=\"work gray\">部门：</span>";
                                orderInfo+="<span class=\"work-info\">"+a.applicantDept+"</span>";
                                orderInfo+="</li>";
                                orderInfo+="<li>";
                                orderInfo+="<span class=\"gray\">时间：</span>";
                                orderInfo+="<span>"+limitTimelength(a.orderAppDate)+"</span>";
                                orderInfo+="</li>";
                                orderInfo+="</ul>";
                                orderInfo+="<ul class=\"info-middle\">";
                                orderInfo+="<span class=\"business gray\">业务描述:</span>";
                                orderInfo+="<li>";
                                orderInfo+="<div class=\"business-txt\">"+limitLength(a.applyDesc)+"</div>";
                                orderInfo+="</li>";
                                orderInfo+="</ul>";
                                orderInfo+="<ul class=\"info-center\">";
                                orderInfo+="<li>";
                                orderInfo+="<span class=\"user-num gray\">用户量：</span>";
                                orderInfo+="<span class=\"user-info\">"+a.userMaxNumbers+"</span>";
                                orderInfo+="</li>";
                                orderInfo+="<li>";
                                orderInfo+="<span class=\"visit gray\">并发访问量：</span>";
                                orderInfo+="<span class=\"visit-info\">"+a.concurrentNumbers+"</span>";
                                orderInfo+="</li>";
                                orderInfo+="<li>";
                                orderInfo+="<span class=\"virtual gray\" style=\"color:#399;\">虚拟机数量：</span>";
                            	 if(obj1.vmNumber==null ||obj1.vmNumber==undefined || obj1.vmNumber==''){
                                	orderInfo+="<span class=\"virtual-num\" style=\"color:#399; font-weight:900;\" >"+a.vmNumber+"</span>";
                                 }else{
                                	orderInfo+="<span class=\"virtual-num\" style=\"color:#399; font-weight:900;\" >"+obj1.vmNumber+"</span>";
                                 }
                                
                                orderInfo+="</li>";
                                
                                //beging归属平台
                                orderInfo+="<li>";
                                orderInfo+="<span class=\"visit gray\">归属平台：</span>";
                                if(a.belongCloud!=null && a.belongCloud!=undefined && a.belongCloud=="1" ){// 归属平台	  1研发云   2租用云
                                	orderInfo+="<span class=\"visit-info\">研发云</span>";
                                }
                                if(a.belongCloud!=null && a.belongCloud!=undefined && a.belongCloud=="2" ){// 归属平台	  1研发云   2租用云
                                	orderInfo+="<span class=\"visit-info\">华为租用云</span>";
                                }
                                orderInfo+="</li>";
                              //end归属平台
                                orderInfo+="</ul>";
                                orderInfo+="<div class=\"dot-line\"></div>";
                                orderInfo+="<ul class=\"deploy\">";
                                orderInfo+="<li>";
                                orderInfo+="<span class=\"deploy-tittle\">配置</span>";                
                                orderInfo+="</li>";
                                
                                //var obj2 = array2.parseJSON(); //由JSON字符串转换为JSON对象
                               
                                orderInfo+="<li class=\"float-li1\">";
                                orderInfo+="<span class=\"cpu gray\">CPU：</span>";
                                orderInfo+="<span class=\"cpu-info\">"+obj1.cpu+"</span>";
                                orderInfo+="</li>";
                                orderInfo+="<li class=\"float-li2\">";
                                orderInfo+="<span class=\"machine gray\">虚拟机类型：</span>";
                                orderInfo+="<span class=\"machine-info\">"+obj1.virtualType+"</span>";
                                orderInfo+="</li>";
                                
                                //租用云有链路类型
                                 if(a.belongCloud!=null && a.belongCloud!=undefined && a.belongCloud=="2" ){// 归属平台	  1研发云   2租用云
                                	 
	                                orderInfo+="<li class=\"float-li3\">";
                                	orderInfo+="<span class=\"link-type gray\">链路类型：</span>";
	                                orderInfo+="<span class=\"link-info\">"+obj1.netType+"</span>";
	                                orderInfo+="</li>"
	                                orderInfo+="<li class=\"float-li4\">";
	                                orderInfo+="<span class=\"net-num gray\">公网数量：</span>";
	                                orderInfo+="<span class=\"net-info\">"+obj1.netNum+"个</span>";
	                                orderInfo+="</li>";
	                               
                                 }
                                orderInfo+="</ul>";
                                orderInfo+="<ul class=\"deploy1\">";
                                orderInfo+="<li class=\"float-li5\">";
                                orderInfo+="<span class=\"memory gray\">内存：</span>";
                                orderInfo+="<span class=\"memory-info\">"+obj1.virtualRam+"</span>";
                                orderInfo+="</li>";
                                orderInfo+="<li class=\"float-li6\">";
                                orderInfo+="<span class=\"disk gray\">数据盘容量：</span>";
                                orderInfo+="<span class=\"disk-info\">"+obj1.virtualHard+"G</span>";
                                orderInfo+="</li>";
                                orderInfo+="<li class=\"float-li8\">";
                                orderInfo+="<span class=\"operate gray\">操作系统：</span>";
                                orderInfo+="<span class=\"operate-info\">"+obj1.SysTemChild+"</span>";
                                orderInfo+="</li>";
                                if(a.belongCloud!=null && a.belongCloud!=undefined && a.belongCloud=="2" ){// 归属平台	  1研发云   2租用云
                                	orderInfo+="<li class=\"float-li7\">";
	                                orderInfo+="<span class=\"company1-net gray\">公网宽带：</span>";
	                                orderInfo+="<span class=\"companyNet-info\">"+obj1.netBandW+"M</span>";
	                                orderInfo+="</li>";
                                 }
                                
                                
                                orderInfo+="</ul>";
                                orderInfo+="<ul class=\"deploy2\">";
                                orderInfo+="<li>";
                                orderInfo+="<span class=\"soft gray\">安装软件：</span>"
                                orderInfo+="<span class=\"soft-info\">"+"存储软件: "+obj1.storageSoft+"</span>"
                                orderInfo+="</li>";
                                orderInfo+="<li class=\"mar-l\">";
                                orderInfo+="<span class=\"soft-info1\">"+"运行环境软件: "+obj1.environmentSoft+"</span>";
                                orderInfo+="</li>";
                                orderInfo+="</ul>";
                               
                                orderInfo+="<input type=\"button\" class=\"follow-btn\" onclick=\"queryOrderWo('"+a.orderDetailId+"')\">";
                               
                                orderInfo+="</li>";
                            });
                        }else{
                            $("#kkpager").empty();//分页查询
                        }
					}
                    $("#content-info").empty();
                    $("#content-info").append(orderInfo);
                    //高光
                    highlight();
                    $("#kkpager").empty();
                    //生成分页控件（每次查询初始化页数）
                    kkpager.init({
                        pno: currentPage,
                        total: totalPage,
                        totalRecords:totalCount,
                        mode : 'click',
                        click: function(n){
                            kkpager.selectPage(n);
                            querytickets(n);
                            return true;
                        }
                    });
                    kkpager.generPageHtml();
                    if(totalCount==null||totalCount==0){
                        $("#kkpager").empty();
                    };
				}
	});

}
/**
 * 跟踪查询盒子
 * @param orderDetailId
 */
function queryOrderWo(orderDetailId){
	$('#follwQuery').css('display','block');
	$('.coverBox').css('display','block');
	
	var jsondata1={
		"orderDetailId":orderDetailId	
	}
	var jsondata=JSON.stringify(jsondata1);
	$.ajax({
		  	cache:true,
		  	type: "POST",
		  	url: getContextPath()+"/vmQuery/vmOrderWoQuery",
			data: "jsondata="+jsondata,
			dataType:'json',
			async:true,
			error: function(data){
				var stepinfo="";
				 stepinfo+="<div class=\"step\">";
				 stepinfo+="<h2>没有工单信息！</h2>";
				 stepinfo+="</div>";
				 stepinfo+="<input type=\"button\" value=\"取消\" onclick=\"closeOrderWo();\" class=\"check-regret\">";
				 $("#follwQuery").empty();
				 $("#follwQuery").append(stepinfo);
			},
			success: function(data){
				 var stepinfo="";
//					 list=eval(data.list);
					 $.each(data.list,function(i,a){
						 stepinfo+="<div class=\"step\">";
						 if(a.woStatus==0){
						 	stepinfo+="<span class=\"step-time-year\">"+subTime(a.woCreateDate)+"</span>"
						 	if(i==0){
								 stepinfo+="<span class=\"step-dot\"></span>";
							}else{
								stepinfo+="<span class=\"step-graydot\"></span>";
							}
						 	stepinfo+="<span class=\"step-close\">"+"待处理"+"</span>";
						 	if(a.operateId==undefined || a.operateId=='undefined' || a.operateId==null || a.operateId==''){
						 		stepinfo+="<span class=\"step-name\">OA审批系统</span>";
						 	}else{
						 		stepinfo+="<span class=\"step-name\">"+ a.operateId+"</span>";
						 	}
							stepinfo+="<span class=\"step-content\"></span>";
						}else if(a.woStatus==1){
							stepinfo+="<span class=\"step-time-year\">"+subTime(a.woCreateDate)+"</span>"
							if(i==0){
								stepinfo+="<span class=\"step-dot\"></span>";
							}else{
								stepinfo+="<span class=\"step-graydot\"></span>";
							}
							stepinfo+="<span class=\"step-close\">"+transeWoResult(a.woResult)+"</span>";
							if(a.operateId==undefined || a.operateId=='undefined' || a.operateId==null || a.operateId==''){
						 		stepinfo+="<span class=\"step-name\">OA审批系统</span>";
						 	}else{
						 		stepinfo+="<span class=\"step-name\">"+ a.operateId+"</span>";
						 	}
						}
						 stepinfo+="</div>"
						 if(i==data.list.length-1){

						 }else{
							 stepinfo+="<div class=\"step-rote\"></div>";
						 }
					 });
					 stepinfo+="<input type=\"button\" value=\"取消\" onclick=\"closeOrderWo();\" class=\"check-regret\">";
					 $("#follwQuery").append(stepinfo);
			}
	});

}
/**
 * 处理记录取消按钮点击
 */
function closeOrderWo(){
	$('#follwQuery').css('display','none');
	$('.coverBox').css('display','none');
	$("#follwQuery").empty();
}
/**
 * 时间截取
 * @param time
 * @returns
 */
function subTime(time){
	return time.substr(0,19);
}
/**
 * 处理结果翻译
 * @param woResult
 */
function transeWoResult(woResult){
	if(woResult==1){
		return "OA审核通过";
	}else if(woResult==2){
		return "OA审核不通过";
	}else if(woResult==3){
		return "运维已制定集成方案";
	}else if(woResult==4){
		return "用户已同意集成方案";
	}else if(woResult==5){
		return "用户不同意集成方案";
	}else if(woResult==6){
		return "已录入开通信息";
	}else if(woResult==7){
		return "已录入安装软件信息";
	}else if(woResult==8){
		return "虚拟机申请修改完成";
	}
}
/**
 * 按时间排序顺序降序排序
 */
var flag=true;
function timeSort(){
	if(flag){
		$(".time-turn").addClass("turn-up");
		flag=false;
		querytickets(1);
	}else{
		$(".time-turn").removeClass("turn-up");
		flag=true;
		querytickets(1);
		}
}


/**
 * 输入关键字查询
 */
function KeySearch(){
	 
	querytickets(1);
	highlight();
}

function highlight()
{
    clearSelection();//先清空一下上次高亮显示的内容；
    var searchText = $('#key').val();//获取你输入的关键字；
    var regExp = new RegExp(searchText, 'g');//创建正则表达式，g表示全局的，如果不用g，则查找到第一个就不会继续向下查找了；
    $('.business-txt').each(function()//遍历文章；
    {
        var html = $(this).html();
        var newHtml = html.replace(regExp, '<span class="highlight">'+searchText+'</span>');//将找到的关键字替换，加上highlight属性；
        $(this).html(newHtml);//更新文章；
    });
}

function clearSelection()
{
    $('.business-txt').each(function()//遍历
    {
        $(this).find('.highlight').each(function()//找到所有highlight属性的元素；
        {
            $(this).replaceWith($(this).html());//将他们的属性去掉；
        });
    });
}

function postRequest(url,params) {
	var temp=document.createElement("form");
	/*debugger;*/
	temp.action=url;
	temp.method="POST";
	temp.style.display="none";
	for(var x in params)
	{
		var opt=document.createElement("input");
		opt.name=x;
		opt.value=params[x];
		temp.appendChild(opt);
	}
	document.body.appendChild(temp);
	temp.submit();
	return temp;
}
function limitLength(str){
	var strtmp=str.substr(0,113);
	var maxlength=113;
	if(str.length>maxlength){
		return strtmp+"...";
	}else{
		return str;
	}
}
function limitTimelength(str){
	var strtmp=str.substr(0,19);
	var maxlength=19;
	if(str.length>maxlength){
		return strtmp;
	}else{
		return str;
	}
}
