<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<div class="list_groups">
	<div class="list_groups_none">
		<ul>
			<li class="biaot" style="background: rgb(22, 154, 219)"
				onClick="turnit(6,2,this);"><a href="#" style="color: #fff">
					<p>用户中心</p>
			</a></li>
			<li class="list_xinx" id="content2">
				<p id="list_1">
					<A href="${_base}/apply/purchaseRecords?prodType=1&currentPage=1"><span
						style="margin-top: 2px;">我的申请</span></A>
				</p>
				<p id="list_3">
					<A href="${_base}/schemeConfirm/schemeConfirmList?currentpage=1&pageSize=2"><span
						style="margin-top: 2px;">方案确认</span></A>
				</p>
				<p id="list_0">
					<A href="${_base}/mds/messageDisplay"><span
						style="margin-top: 2px;">消息中心</span></A>
				</p>
				<p id="list_2">
					<A href="${_base}/apply/myAccount"><span
						style="margin-top: 2px;">账户管理</span></A>
				</p>
			</li>
		</ul>
	</div>
</div>