<%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 String id="";
 if(request.getParameter("orderId")==null){
	 response.sendRedirect("user_order.jsp");
	 return;
 }
 id=request.getParameter("orderId");
 OrderService orderServ = new OrderServiceImpl();
 Tradeorder2Shop t2s=orderServ.getTradeorder2ShopOrderId(id);
 String images[]=t2s.getShop_image().split("@");
 
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>订单详情</title>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.1rem " id="content1">
<div class="container nomargin" style="background-color: #ffffff;color:#666;padding:2rem;margin-top: 0px !important;">
<!-- order list -->
<div class="content" style="padding: 10px 0px">
    <div class="container no-bottom">
        <div class="container no-bottom list_style" onclick="javascript:location.href='shop_detail.jsp?id=<%=t2s.getShop_id()%>'">
        <div class="recent-post">
                <div class="dealcard-img"><img src="<%=images[1] %>" alt="img"></div>
                <div class="dealcard-block-right">
                <div class="title"><strong><%=t2s.getShop_title() %></strong></div>
                <div class="detail"><%=t2s.getShop_detail() %></div>
                <div class="pricepanel">
			            <strong><%=t2s.getShop_price() %></strong><span class="strong-color">元</span>
			                <del><%=t2s.getShop_oprice() %>元</del>
			        </div>
               </div>
        </div>
     </div>
     <br>
</div>
<!-- order list -->
</div>
</div>
<div class="space"></div>
<div class="content" style="padding: 10px 0px">
<dl class="list coupons"><dd><dl>
     <dt><%=t2s.getStatusString() %>
     </dt>
 </dl></dd></dl>
 </div>
 <div class="space"></div>
 <!-- content -->
<div class="content" style="padding: 10px 0px">
<dl class="list"><dd><dl>
    <dt>订单详情</dt>
    <ul>
        <li>订单编号：<%=t2s.getOrderId() %></li>
        <li>下单时间：<%=t2s.getCtimeString() %></li>
        <li>订单总额：<%=t2s.getPrice() %>元</li>
        <li>银行结算：<%=t2s.getBankprice() %>元</li>
        <li>订单类型：<%=t2s.getTypeString()%></li>
    </ul>
</dl></dd></dl>
 </div>
 <!-- content -->
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="订单详情";
$("#top_back_button").html("<a class=\"react\" href=\"user_order.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>返回</a>");
</script>
</body>
</html>