// 绑定
function blind(){
	$('.alertBox').css('display','block');
	$('.alertBox input').val('');
}
// 弹窗取消
function boxNone(){
	$('.alertBox').css('display','none');
	$('.alertBox input').val('');
}
// 确定添加数据
var num=0;
function addData(){
	num++;
	var oDiv='<div class="tContent-data" id="'+num+'"><span class="num mar"><input type="checkbox" class="checkbox"> 1</span><span class="tDBS mar">DBS</span><span class="tMDS mar1">MDS</span><span class="tDES mar">DES</span><span class="tTable blue mar" onclick="editSee()">编辑观察表</span><span class="operate blue mar" onclick="deleteTable('+num+')">删除</span></div>'

	$('.table-content').append(oDiv);
	$('.alertBox').css('display','none');
	$('.alertBox input').val('');
}
// 删除键
function deleteTable(num){
	$('#'+num+'').remove();
}

function addEditData(){
	num++;
	var oDiv='<div class="tContent-data" id="'+num+'"><span class="num mar"><input type="checkbox" class="checkbox"> 1</span><span class="tDBS mar">DBS</span><span class="tMDS mar1">MDS</span><span class="tDES mar">DES</span><span class="tTable blue">table1 table2</span><span class="operate blue mar" onclick="deleteTable('+num+')">删除</span></div>'

	$('.table-content').append(oDiv);
	$('.editBox').css('display','none');
}


// 取消
function editSee(){
	$('.editBox').css('display','block');
}
var lNum = -1;
var rNum = -1;
function addEvent(n){
	// $(this).addClass('act').siblings().removeClass('act');
	// 获取左右
	$("."+n+"").addClass('act').siblings().removeClass('act');
	var parentIndex = $("."+n+"").parent().index('body .turnUl');
	if(parentIndex==0){
		lNum=$("."+n+"").index('.turnUl:eq(0) li');
	}else{
		rNum=$("."+n+"").index('.turnUl:eq(1) li');
	}
}

/*function beforeTable(){
	var des=$("#bdes").val();
	var dbs=$("#bdbs").val();
	var mds=$("#bmds").val();
	alert(1);
	searchTable(des,dbs,mds);
}*/



$(function(){
	// 获取index
	
	// 绑定事件
	//$('.turnUl li').click(addEvent);
	$('.turnRight').click(function(){
		var oBj = $('.turnUl:eq(0) li').eq(lNum);
		$('.turnUl li').removeClass('act');
		// oBj.removeClass('act');
		if(lNum!=-1){
			$('.turnUl:eq(1)').append(oBj);
		}else{
			alert('请选择');
		}
		lNum=-1;
	});
	$('.turnLeft').click(function(){
		var oBj = $('.turnUl:eq(1) li').eq(rNum);
		$('.turnUl li').removeClass('act');
		// oBj.removeClass('act');
		if(rNum!=-1){
			$('.turnUl:eq(0)').append(oBj);
		}else{
			alert('请选择');
		}
		rNum=-1;
	});

	
	
})


 






















// var no1=0;
// var value2=null;
// function turnLeft(){
// 	alert(value2)
// 	// $('.edit-left ul').remove();
// 	// if (value2!=null) {
// 	// 	// no1++;
// 	// 	// $('.value'+no1+'').remove();
// 	// 	alert(1)
// 	// 	// $('.li'+no1+'').html(value2);

// 	// }
// }
// function clearData(no){
// 	no1++;
// 	if (no==no1) {
// 		var value2=$('.value'+no1+'').html();
// 		alert(value2)
// 	};
// }
