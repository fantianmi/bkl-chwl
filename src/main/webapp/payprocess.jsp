<%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="com.bkl.chwl.vo.*"%>   
<%@page import="java.math.BigDecimal"%>   
<%@page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 OrderService orderServ=new OrderServiceImpl();
 if(request.getParameter("orderId")==null){
	 response.sendRedirect("index.jsp");
	 return;
 }
 String orderId=request.getParameter("orderId"); 
 Tradeorder2Shop order=orderServ.getTradeorder2ShopOrderId(orderId);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1" onclick="hideWeixinAlert();">
<dl class="list"><dd><dl>
   <dt>结账详情</dt>
   <ul>
       <li>订单编号：<%=order.getOrderId() %></li>
       <li>订单价格：<%=order.getPrice() %></li>
       <li>商家名称：<%=order.getSeller()+"-"+order.getShop_title()%></li>
       <li>付款用户：<%=order.getUid()%></li>
       <li>创建时间：<%=order.getCtimeString() %></li>
    </ul>
</dl></dd></dl>
<!-- order area -->
<div style="width:200px"><img src="assets/images/chinapay.jpg"></div>
<button class="btn btn-success btn-block" id="paySubmitBtn" onclick="paySubmit()">银联付款</button>
<!-- order area -->
</div>
<div class="weixin_alert" id="weixin_alert" onclick="hideWeixinAlert();">
<img src="assets/images/weixin_alert.png">
</div>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="确认付款";
$("#top_qr_button").hide();
$("#top_search_button").hide();
$("#top_back_button").html("");
$("#top_logout_button").hide();
function paySubmit(){
	window.location.href="formSubmit.jsp?orderId=<%=orderId%>";	
}

function hideWeixinAlert(){
	$("#weixin_alert").hide();
	return;
}
$(document).ready(function(){
	if(isWeixinBrowser()){
		$("#weixin_alert").show();
		$("#paySubmitBtn").attr("disabled","disabled");
	}
});

function isWeixinBrowser(){
    var ua = navigator.userAgent.toLowerCase();
    return (/micromessenger/.test(ua)) ? true : false ;
}
</script>
</body>
</html>