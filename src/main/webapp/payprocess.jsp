<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%String orderId=request.getParameter("orderId"); %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>订单号29292 232元</title>
</head>
<body>
此处为银行支付页面，跳转到银行界面
<a href="paysuccess.jsp?orderId=<%=orderId%>">支付成功，点此跳转</a>
</body>
</html>