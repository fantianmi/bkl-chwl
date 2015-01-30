<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<%
String uri="http://www.bkltech.com.cn:12000/reg.jsp?r=1000";
uri=URLEncoder.encode(uri, "utf-8");
String oath="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxa2a306c8179ab786&redirect_uri="+uri+"&response_type=code&scope=snsapi_base&state=w1#wechat_redirect";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<a href="<%=oath%>">go</a>
</body>
</html>