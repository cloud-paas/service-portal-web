

var old_obj_sel;
function turnit(ss,ii,obj){  
	
   $(".biaot").css("background","rgb(234,234,234)"); 
   $(".biaot a").css("color","#000"); 
 //循环判断，ss为总列表数,ii为当前列
 for (i=0;i<=ss;i++){
   //错误过滤，当i=1至ss中有一项以上出错，自动过滤
  try{
   //当i=ii时展开目录数，否则关闭
   if (i==ii){
	   //判断i列的目录数是否展开，没有就展开，否则关闭
	    if (window.eval("content"+i).style.display=="none"){
			window.eval("content"+i).style.display="";
	        window.eval("img"+i).src="images/a.png";
			$(obj).css("background","rgb(22,154,219)"); 
			$(obj).find('a').css("color","#fff"); 
	    }else{
	     window.eval("content"+i).style.display="none"; 
	        window.eval("img"+i).src="images/b.png";
	    }
   }else{
	   window.eval("content"+i).style.display="none"; 
       window.eval("img"+i).src="images/b.png";
   }
  }catch(e){}
 }
}

    