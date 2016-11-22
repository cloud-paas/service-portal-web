<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.ai.paas.ipaas.storm.sys.utils.StringUtils"%>
<%@page import="com.ai.paas.ipaas.system.constants.ConstantsForSession"%>
<%@page import="com.ai.paas.ipaas.user.vo.UserInfoVo"%>
<%
   
HttpSession Session = request.getSession();
UserInfoVo userInfo = (UserInfoVo) Session.getAttribute(ConstantsForSession.LoginSession.USER_INFO);
if (userInfo != null&& !StringUtils.isBlank(userInfo.getUserName())) {
	String userName = userInfo.getUserName();
	request.setAttribute("userName", userName);
}
String baseLocation = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
request.setAttribute("basePath", basePath);
request.setAttribute("_base", basePath);

%>
<head>
<%@ include file="/jsp/common/common.jsp"%>
<script src="${_base }/resources/js/common/prod_param_transfer.js"></script>
<script type="text/javascript">
var userName = "${userName}";
var _base = "${_base}";
var basePath = "${basePath}"
var html;
	$(document).ready(function() {
			if (userName != "") {
				$("#loginName").text("");
				$("#loginName").append(userName);
			}		
			queryOrgList();	 
		});
			
	
	function queryOrgList() {
		$.ajax({
					type : "POST",
					url : "${_base}/orgConsole/queryOrgList",
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
							$("#table_detail tbody").empty();
							html = '';
							html += '<tr>';
							html += '<th>组织编码</th>';
							html += '<th>组织名称</th>';																							
							html += '<th>组织状态</th>'; 
							html += '<th>操作</th>'; 	
							html += '</tr>';
							
							if (msg.resultList.length ==0) {								
								html += '<tr>';		
								html += '<td colspan="7">目前还没有组织，请添加~</td>';								
								html += '</tr>';									
								$('#table_detail tbody').append(html);								
								return;
							}
							loadData(msg.resultList);
						} else {
							//alert("查询不到数据");
							$("#table_detail tbody").empty();
							html = '';
							html += '<tr>';
							html += '<th>组织编码</th>';
							html += '<th>组织名称</th>';																							
							html += '<th>组织状态</th>'; 
							html += '<th>操作</th>'; 	
							html += '</tr>';
							
							html += '<tr>';		
							html += '<td colspan="7">查询异常</td>';								
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
						$("#errorMessage").text("");					
						$("#errorMessage").append('系统发生异常，数据加载失败，请登陆后重新尝试！');
						$("#errorMessageDia").show();
						$('.fenye').css('display', 'none');
					}
				});
	}
	
	function loadData(obj) {
		$.each(
				obj,
				function(n, item) {
					html += '<tr >';	
					// 组织编码
					html += '<td>' + item.orgCode + '</td>';
					// 组织名称
					html += '<td >' +item.orgName + '</td>';									
					// 组织狀態
					if (item.orgStatus == 1) {
						html += '<td>' + "有效" + '</td>';
					} else {
						html += '<td>' + "无效" + '</td>';
					}
					//操作
					html += '<td>' 
							+'<a href="#" onclick=modifyOrg("'+ item.orgId +'"); >修改组织</a>'
							+'|<a href="#" onclick=deleteOrg("'+ item.orgId + '","'+item.orgName+'"); >刪除组织</a>'
							+ '</td>';	
					html += '</tr>';
				});		
		$('#table_detail tbody').append(html);	
	}
	
	function changeHref() 
	{   var base = "${_base}";
	    var basePath = "${basePath}";
		if(base==null || ""==base ){
			location.href = basePath;
		}else{
			location.href = base;
		}
	}

	function modifyOrg(orgId) {
		var parentUrl = location.pathname;
		location.href="${_base}/orgConsole/toModifyOrg?orgId="+orgId;
	}
  
    function deleteOrg(orgId,orgName) {
    	var remainMsg='确定要对组织【'+orgName+'】做刪除操作吗？';
    	Modal.confirm({msg:remainMsg}).on(function(e){
    		if(e){
    			$.ajax({
        			async:false,
        			type:"POST",
        			url:"${_base}/orgConsole/deleteOrgnize",
        			dataType:'json',
        			data:{
        				orgId:orgId
        			},
        			success:function(msg){
        				if(msg.resultCode=='000000'){
        					Modal.alert({
        						msg:'组织【'+orgName+'】刪除成功!'
        					}).on(queryOrgList());
        					
        				}else if(msg.resultCode=='999999'){
        					Modal.alert({
        						msg:'组织【'+orgName+'】刪除失败!'
        					})
        				}
        			}
        			
        		})
    		}
    		
    	}) ;
	}
</script>  
  </head> 
  <body>  
  <!-- 遮盖层   -->
  <div class="waitCover" >
	 <img  src="${_base }/resources/images/waitPng.png" class="waitPng" >
	 <div class="waitTxt">正在加载请稍后...</div>
  </div>   
  <div class="big_k"><!--包含头部 主体-->   
   <!--导航-->
   <div class="navigation" style="background:rgb(22,154,219); height:70px">
  <div class="head">
				<div style="width: 100%; height: auto">
					<div style="float: left; width: 13%; position: relative; left: 3%">
						<img src="${_base }/resources/images/logo-white2.png"
							style="position: relative; margin: 20px 20px 0px 0px;height:35px">
					</div>
					<div class="mune_lan"  style="padding-top:1.5%;">
						<ul>
                        <li  class="yon_wnz" style="margin-left:20px;font-size:20px;margin-top:0px;" ><a href="#" onclick="changeHref()" title="返回首页"><img style="height:30px;padding-bottom:5px"  src="${_base }/resources/images/return.png"/></a></li> 
						<li class="yon_wnz"   style="padding-bottom:5px;margin-left:40px;font-size:20px;">服务申请审核</li> 
						</ul>
						<ul style="float:right">
							<li id="loginName" class="yonhz"></li>   
						</ul>
					</div> 
				</div>
			</div>
   </div>
   
   <div class="container chanp">
   
  <div class="row chnap_row">
  <div class="col-md-6 left_list" >
      <div class="list_groups">
          <div class="list_groups_none">
             
            <ul>
              <li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(6,2,this);">
               <a href="#" style="color:#fff">
                <p  id="img2">服务申请审核</p>
               </a>
              </li>
              <li class="list_xinx"  id="content2" >
                <p class="xuanz"><A href="${_base }/apply/applyAudit"><span style="margin-top:2px;">服务申请审核</span></A></p>        
              </li>
            </ul>             
            <ul>
             <li class="biaot" style="background:rgb(22,154,219)"  onClick="turnit(6,1,this);">
               <a href="#" style="color:#fff">
                 <p  id="img2">组织管理</p>
               </a>
             </li>
             <li class="list_xinx"  id="content3" >
                <p class="xuanz"><A href="${_base }/orgConsole/toOrgConsole"><span style="margin-top:2px;">组织管理</span></A></p>
             </li>
            </ul>
          </div> 
    </div>
  
  </div>
  <div class="col-md-6 right_list">     
     <div class="Open_cache">
        <div class="Open_cache_table">
			<ul style="border-bottom:1px #eee">
			<li><a href="#">组织管理</a></li> 
			</ul>  
        </div> 
         <div class="fuw_search">
      <ul>
     
      <li class="xil" style=" float:right;">
      	<A href="${_base }/jsp/console/org/orgAdd.jsp"  id="org_add"  style="padding:5px 25px 5px 25px; float:left; background:#78bd5a; border-radius:20px; margin-left:20px; text-align:center; color:#fff; font-size:14px;border:1px solid #78bd5a;">&nbsp;&nbsp;组织新增&nbsp;&nbsp;</A>
      </li>
      </ul>
      </div>        
		
     	<div class="Open_cache">  
	        <div class="Open_cache_list" style="margin:0"> 
	          	<div class="Open_cache_list_tow">
	          		  <table id="table_detail"  style="width:100%; ">
						<tr>
							<th>组织编码</th>
							<th>组织名称</th>
							<th>组织状态</th>
							<th>操作</th>
						</tr>												
					 </table>
	           </div>
	           <div  style="float:center;margin:0 auto;">
	           <nav class="fenye">
				 <span style="font-size: 14px;">
						<ul class="pagination" id="pageUl" style="width:600px;float:center">
						</ul>
				 </span>									
			  </nav> 
			  </div>               
	        </div>  
    	</div>   
     </div>  
  </div>
</div>

</div>
</div> 

<!--页脚-->
<jsp:include page="/jsp/common/footer_new.jsp"></jsp:include>
 
  </body>
</html>
