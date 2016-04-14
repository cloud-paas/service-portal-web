// JavaScript Document
	$(function(){
	
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
 
        function highlight()
        {
            clearSelection();//先清空一下上次高亮显示的内容；
            var searchText = $('.key').val();//获取你输入的关键字；
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
    	// cpu背景切换
    	$('.tab_div_a_cpu ul li a').click(function(){
    		alert(11);
    		$(this).addClass('blue-b').parents('li').siblings('li').children('a').removeClass('blue-b')
    	})
    	// 虚拟机类型背景切换
    	$('.tab_div_a_sys3 ul li a').click(function(){
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
    	$('.linux1 li').click(function(){
    		$(this).addClass('blueLi').siblings().removeClass('blueLi');
    	})
    	$('.window1 li').click(function(){
    		$(this).addClass('blueLi').siblings().removeClass('blueLi');
    	})
    	$('.ubuntu1 li').click(function(){
    		$(this).addClass('blueLi').siblings().removeClass('blueLi');
    	})
		// 联通、典型、BGP切换
		$('.BGP').click(function(){
			$('.tr1-1').css('display','none');
			$('.tr2-1').css('display','inline-block');
		})
		$('.liantong').click(function(){
			$('.tr2-1').css('display','none');
			$('.tr1-1').css('display','inline-block');
		})
		$('.dianxin').click(function(){
			$('.tr2-1').css('display','none');
			$('.tr1-1').css('display','inline-block');
		})
		$('.double').click(function(){
			$('.tr2-1').css('display','none');
			$('.tr1-1').css('display','inline-block');
		})

    	// 数据盘进度条
    	new scale('btn0', 'bar0', 'title0'); 
    	new scale1('btn1', 'bar1', 'title1'); 
    	new scale2('btn2', 'bar2', 'title2'); 
		
	})
	function bgp(){
		$('.tr1-1').css('display','none');
		$('.tr2-1').css('display','inline-block');
		$('#net_value2').val('');
	}
	function liantong(){
		$('.tr2-1').css('display','none');
		$('.tr1-1').css('display','inline-block');
	}
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
		$('.caliche').val(pos+10);
		var value=$('.caliche').val();
		var value1=$('.disk-before').text();
		var value2=value1.split("G");
		var value3=parseInt(value2[0]);
		console.log(value)
		console.log(value3)
		if(value>value3){
			$('.disk-before').css('background','url(../resources/images/up-arrow.jpg) no-repeat right 0px')
		}else{
			$('.disk-before').css('background','url(../resources/images/down-arrow.jpg) no-repeat right 8px')
		}
	}
}
function move(){
	var w=0;
	var w =parseInt($('.caliche').val())
	var w1=w*1.36;
	// alert(w+10)
	if (w>10 && w<200) {
		$('#bar0 div').css('width',w1+'px');
		$('#btn0').css('left',w1+'px');
		$('#title0').html(w+'G');
	}else if(w==10){
		$('#bar0 div').css('width','0px');
		$('#btn0').css('left','-2px');
		$('#title0').html('10G');
	}else if(w==200){
		$('#bar0 div').css('width','279px');
		$('#btn0').css('left','279px');
		$('#title0').html('200G');
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
				f.ondrag(m.round(m.max(0, to / max) * 99), to);
				// $('.caliche').val(to)
				b.getSelection ? b.getSelection().removeAllRanges() : g.selection.empty();

			};
			g.onmouseup = new Function('this.onmousemove=null');
		};
	},
	ondrag: function (pos, x) {
		this.step.style.width = Math.max(0, x) + 'px';
		this.title.innerHTML = pos+1+ 'M';
		$('.net-value').val(pos+1);
		var value=$('#net_value1').val();
		var value1=$('#net-before_1').text();
		var value2=value1.split("M");
		var value3=parseInt(value2[0]);
		console.log(value)
		console.log(value3)
		if(value>value3){
			$('#net-before_1').css('background','url(../resources/images/up-arrow.jpg) no-repeat right 0px')
		}else{
			$('#net-before_1').css('background','url(../resources/images/down-arrow.jpg) no-repeat right 8px')
		}
	}
}
function move1(){
	var w=0;
	var w =parseInt($('.net-value').val())
	var w1=w*2.73;
	// alert(w+10)
	if (w>1 && w<100) {
		$('#bar1 div').css('width',w1+'px');
		$('#btn1').css('left',w1+'px');
		$('#title1').html(w+'M');
	}else if(w==1){
		$('#bar1 div').css('width','0px');
		$('#btn1').css('left','-2px');
		$('#title1').html('1M');
	}else if(w==100){
		$('#bar1 div').css('width','279px');
		$('#btn1').css('left','279px');
		$('#title1').html('100M');
	}
};
function move2(){
	var w =$('.company1').val();
	var w1=w*13.65;
	if (w>1 && w<20) {
		$('#bar2 div').css('width',w1+'px');
		$('#btn2').css('left',w1+'px');
		$('#title2').html(w+'M');
	}else if(w==20){
		$('#bar2 div').css('width','279px');
		$('#btn2').css('left','279px');
		$('#title2').html('20M');
	}else if(w==1){
		$('#bar2 div').css('width','0px');
		$('#btn2').css('left','-2px');
		$('#title2').html('1M');
	}
	
	// alert(w)
};
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
	}
}

// 制定按钮点击
function madeBox(){
	$('.content').css('display','none');
	$('.madeBox').css('display','block');
}
function contentBox(){
	$('.madeBox').css('display','none');
	$('.content').css('display','block');
}

	