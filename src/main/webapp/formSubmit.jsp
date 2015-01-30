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
<%@page import="com.unionpay.acp.pay.*"%>
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
<%=Form06_6_2_f.getForm(orderId,order.getBankprice())%>