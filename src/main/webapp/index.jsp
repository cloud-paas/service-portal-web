<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html class="fsvs demo">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>亚信云首页</title>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<!-- <meta name="viewport" content="width=device-width; initial-scale=0.6; maximum-scale=10; user-scalable=1;" /> -->
<link rel="shortcut icon" href="favicon.ico" />
<link href="resources/css/bootstrap.min.css" rel="stylesheet"/>
<!--按钮抖动 shake.css -->
<link href="resources/css/shake.css" rel="stylesheet"/>
<link href="resources/css/background.css" rel="stylesheet" />
<link href="resources/css/css.css" rel="stylesheet">
<script type="text/javascript" src="resources/js/index/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="resources/js/index/bootstrap.min.js"></script>  
<script type="text/javascript" src="resources/js/index/fsvs.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#${list_index}").attr('style', 'margin-top:2px;color:#1699dc');
	});
</script>
<style type="text/css">  
 
.brand li{
	display: block;
	float: left;
	margin: 10px auto;
	text-align: center;
	position: relative; 
	color:#fff;
	font-weight:800; 
} 
.brand .info{
	display: none;  
	color: #369242; 
}
 
 
 



.btn_td .btn_td2{ 
	filter:alpha(opacity=50);
	-moz-opacity:0.5;
	-khtml-opacity: 0.5;
	opacity: 0.5; 
}
 
.index_top{
	width:100%;
	height:43%;
	text-align:center; 
	vertical-align:center;  
}
.index_top li{ 
	float:left;
	list-style:none; 
	text-align:center;
}
 
 
/**旋转图片**/
 .character360 {
	width: 197px;
	height: 365px;
	margin: 40px auto 0 auto;
	background: no-repeat url("resources/images/top_round_little.png") center center; 
 
}
 
@-webkit-keyframes rotate{
from{-webkit-transform:rotate(0deg)}
to{-webkit-transform:rotate(360deg)}
}
@-moz-keyframes rotate{
from{-moz-transform:rotate(0deg)}
to{-moz-transform:rotate(360deg)}
}
@-ms-keyframes rotate{
from{-ms-transform:rotate(0deg)}
to{-ms-transform:rotate(360deg)}
}
@-o-keyframes rotate{
from{-o-transform:rotate(0deg)}
to{-o-transform:rotate(360deg)}
}  
.character360 { 
	animation: 19.5s linear 0s normal none infinite rotate;
	-webkit-animation:19.5s linear 0s normal none infinite rotate;  
}
.footer {
	position:relative;
	text-align:center;
 
}
.footer li{
	float: left;
	list-style:none;
	margin: 10px 20px 0px 0px;
	text-align: center;
	position: relative; 
	color:#fff;
	font-weight:800; 
	width:auto;
	
}
.footer a{  
	color:#fff;
	font-weight:800; 
	width:auto;
	font-size:14px;
	
}

/**翻转按钮**/
/** 大屏幕（大桌面显示器，大于等于 1400px） **/
@media (min-width: 1500px) { 
	.img1{
		width:200px;
		height:200px; 
	}
	.brand li{
		width:250px;
		height:250px;
	}
	.info{
		width:250px;
		height:250px;
	}
	.more_ul{
		left:15%;
	}
	.brand li{
		margin: 10px 30px 0 0;
	}
	.character360 {
		height:365px;
	}
}

/** 专门针对苹果屏幕（桌面显示器，大于等于 992px） **/
@media (min-width: 1400px) and (max-width: 1499px){ 
	.img1{
		width:150px;
		height:150px;  
	}
	.brand li{
		width:200px;
		height:200px;
	}
	.info{
		width:200px;
		height:200px;
	}
	.more_ul{
		left:19%;
	}
	.brand li{
		margin: 10px 30px 0 0;
	}
	.character360 {
		height:365px;
		width: 227px;
		background: no-repeat url("resources/images/top-round.png") center center; 
	}

}

/** 大中等屏幕（桌面显示器，大于等于 992px） **/
@media (min-width: 1200px) and (max-width: 1399px){ 
	.img1{
		width:150px;
		height:150px;  
	}
	.brand li{
		width:200px;
		height:200px;
	}
	.info{
		width:200px;
		height:200px;
	}
	.more_ul{
		left:19%;
	}
	.brand li{
		margin: 10px 16px 0 0;
	}
	.character360 {
		height:305px;
	}
}


/** 中等屏幕（桌面显示器，大于等于 992px） **/
@media (min-width: 992px) and (max-width: 1199px){ 
	.img1{
		width:150px;
		height:150px;  
	}
	.brand li{
		width:180px;
		height:180px;
	}
	.info{
		width:180px;
		height:180px;
	}
	.more_ul{
		left:25%;
	}
}

/** 小屏幕（平板，大于等于 768px） **/
@media (min-width: 768px) and (max-width: 991px) { 
	.img1{
		width:110px;
		height:110px; 
	}
	.brand li{
		width:110px;
		height:110px;
	}
	.info{
		width:110px;
		height:110px;
	}
	.more_ul{
		left:20%;
	}
 }
 .hidden{display:none;}
</style>
</head>
<body >     
<!--  <div id="head_a" style="width:100%;MARGIN-RIGHT:auto;MARGIN-LEFT:auto;position:relative;height:70px;z-index:10;background:#fff;border-bottom:solid 3px #eee"> -->
 <div id="head_a" style="width:100% ;position:fixed;height:78px;z-index:10;background:#fff;border-bottom:solid 3px #eee">
				<jsp:include page="/jsp/common/header.jsp"></jsp:include>  

</div>
 <div id="fsvs-body"> 

	<!--首页一-->
	<div class="slide" id="fsvs-initial-setup">
		<div style="height: 100%; background-image: url(resources/images/body.png); background-position: center center;
			position: relative; background-repeat: no-repeat; overflow: none; background-size:cover">
			<!--上部菜单-->
		 
			<!--中部-->
			<div class="index_top">
				<ul style="margin: 0 auto; text-align: center; width: 100%">
					<li style="margin: 0 auto; width: 100%; position: relative;">
						<img src="resources/images/white_yun.png"
						style="position: absolute; left: 49%; top: 53%" /> <!--滚动图片-->
						<div class="character360"></div> <img src="resources/images/zhuanyeyun.png"
						style="position: absolute; left: 60%; top: 50%" />
					</li>
				</ul>
			</div>
			<div style="width: 100%; color: #fff; font-weight: 900; font-size: 25px; margin-top: 1%"
				align="center">核心产品</div>
			<!--下部-产品选项-->
			<div style="height: 40%; width: 100%; text-align: center; position: absolute;font-size:16px">
				<div id="vertical" class="brand vertical" align="center">
					<ul class="more_ul" style="text-align: center; position: absolute;">
					
						<li>
							<a href="${_base }/virtualMachine/initapply" class="yi">
								<img class="img1" src="${_base }/resources/images/v1.png" /> 
								<img class="info" alt="" src="${_base }/resources/images/v2.png" />
							</a>
							<br/>
							云虚拟机VM
						</li>
					
						<li>
							<a href="${_base }/dbs/introduce" class="yi">
								<img class="img1" src="${_base }/resources/images/pro1_a.png" /> 
								<img class="info" alt="" src="${_base }/resources/images/pro1_b.png" />
							</a>
							<br/>
							分布式数据库服务DBS
						</li>
						<%-- <li>
							<a href="${_base }/rcs/introduce" class="yi">
								<img class="img1" src="${_base }/resources/images/pro2_a.png" /> 
								<img class="info" alt="" src="${_base }/resources/images/pro2_b.png" />
							</a>
							<br/>
							实时计算RCS
						</li> --%>
						<li>
							<a href="${_base }/mds/introduce" class="yi">
								<img class="img1" src="${_base }/resources/images/pro3_a.png" /> 
								<img class="info" alt="" src="${_base }/resources/images/pro3_b.png" />
							</a>
							<br/>
								消息中心MDS
						</li>
						<li>
							<a href="${_base }/mcs/introduce" class="yi">
								<img class="img1" src="${_base }/resources/images/pro4_a.png" /> 
								<img class="info" alt="" src="${_base }/resources/images/pro4_b.png" />
							</a>
							<br/>
								缓存中心MCS
						</li>
						<li style=" position:absolute; right:-140px; top:146px;">
							<a href="${_base }/ccs/introduce">
								<img src="${_base }/resources/images/moreNotHover.png"  width=40% height=20% />
							</a>
						</li>
					</ul>
				</div>
			</div>
			<!--切换按钮-->
			<div style="width: 100%; position: fixed; bottom: 0px;" align="center">
				<div class="btn_td"
						style="width: 5%; height: 5%;  text-align: center;">
						<a href="javascript:void(0);" class="yi"><img class="shake shake-vertical" src="resources/images/down.png" width="40" height="18"
							style="padding-top: 10%"></a>
					</div>
			</div>
		</div>
	</div>
	
	<!--首页二-->
	<div class="slide" >
			<div
				style="height: 768px; background-image: url(resources/images/body2.png); background-position: center center; position: relative; background-repeat: no-repeat; text-align:center;background-size:cover;">
				<!--上部菜单--> 
				<div id="head_b" style="width:100% ">
		 
				</div>
				<!--中部-->
				<div style="width:100%;height:75%">
				<ul style="margin: 0 auto; text-align: center; width: 100%;position: relative;padding-top:120px">
					 <p style="position:absolute;left:46%;top:45%;font-size:40px;font-weight:800">小伙伴<p>
					 <li><img src="resources/images/xuanzhuan.png"/></li> 
				</ul>
				</div>  
				<!--页脚-->
				<div class="footer"
					style="width: 100%; height: auto; text-align: center; margin: 0 auto;background:none;">
				
					<div style="width: 100%;margin-top:50px;">
						<span><A href="${_base }/help/center">入门指南</A></span>
						 <span><A href="${_base }/help/FAQ">常见问题</A></span>
						 <span><A href="${_base }/help/center#contect">联系我们</a> </span>
						 <span><a href="${_base }/ccs/introduce">产品</a></span>
						<div>
							<div style="width: 100%; text-align: center">
								<span style="color:#fff;font-size:14px;">Copyright©2005-2015 亚信科技（中国）有限公司 All Rights Reserved</span>
							</div>
						</div>
					</div>
				</div>
				
			</div> 
			
			<!--切换按钮-->
				<div style="width: 100%; position: fixed; bottom:0px;" align="center">
					<div class="btn_td2"
							style="width: 5%; height: 5%;  text-align: center; ">
							<a href="javascript:void(0);" class="yi"><img class="hidden shake shake-vertical" src="resources/images/top1.png" width="40" height="18"
								style="padding-top: 10%"></a>
						</div>
						
				</div>
		</div>  
	</div>
	</div>
<script type="text/javascript">
//品牌翻转
var turn = function(target,time,opts){
	target.find('li').hover(function(){  
		$(this).css("color","rgb(0,117,176)");
		$(this).find('.img1').stop().animate(opts[0],time,function(){
			$(this).hide().next().show();
			$(this).next().animate(opts[2],time);
			
		});
	},function(){
		$(this).css("color","rgb(255,255,255)");
		$(this).find('.info').animate(opts[0],time,function(){
			$(this).hide().prev().show();
			$(this).prev().animate(opts[1],time);
		});
	});
}
var w = $(".img1").width();
var ww = $(".info").width();
var verticalOpts = [{'width':0},{'width':w},{'width':ww,'margin-left':'-15px','margin-top':'-15px'}];
turn($('#vertical'),100,verticalOpts);
 
$(".mune_1 li").each(function(){
		$(this).hover(function(){
			$(this).attr("style","border-bottom:solid 2px rgb(57,150,207);color:rgb(57,150,207)")
		},function(){ 
			$(this).attr("style","border-bottom:solid 2px #fff;color:#949494")
		});
}); 
 
$(".two li").each(function(){
		$(this).hover(function(){
			$(this).attr("style","border-bottom:solid 2px rgb(120,189,90);color:rgb(120,189,90)")
		},function(){ 
			$(this).attr("style","border-bottom:solid 2px #fff;color:#949494")
		});
}); 
$(document).ready(function(){
	if($(".btn_td2").is(":hidden")){
		alert(1);
	       $(".btn_td").show();
	}else if($(".btn_td").is(":hidden")){
		alert(2);
	      $(".btn_td2").hide();  
	}
	$("#more").hover(function(){
		$("#more").html("<img src=\"resources\/images\/moreHover.png\"  width=20% height=10% />");
	},function(){
		$("#more").html("<img src=\"resources\/images\/moreNotHover.png\"  width=20% height=10% />");
	});
});
</script>
</div>
</body>
</html>
 
