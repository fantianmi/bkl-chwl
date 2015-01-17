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
ShopService shopServ=new ShopServiceImpl();
AreaService areaServ=new AreaServiceImpl();
if(request.getParameter("id")==null){
	response.sendRedirect("shop_list.jsp");
	return;
}
long id=Long.valueOf(request.getParameter("id"));
Shop shop=shopServ.get(id);
if(shop==null){
	response.sendRedirect("shop_list.jsp");
	return;
}
Area area=areaServ.get(shop.getLocal2());
%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<script src="http://api.map.baidu.com/components?ak=mQO2QyHBKdGM6OX0OwGMyqmr&v=1.0"></script>
	<title>地图导航</title>
	<style type="text/css">
		body, html,#allmap {width: 100%;height: 95%;margin:0;}
		#golist {display: none;}
		@media (max-device-width: 800px){#golist{display: block!important;}}
		#successBtn{width: 100%;height:40px;border: 1px solid #3D474A;background-color: #3D474A;color:#fff;font-size: 16px;}
		#successBtn:disable{width: 100%;height:40px;border: 1px solid #ccc;background-color: #ccc;color:#fff;font-size: 16px;}
		#successBtn:hover{border: 1 solid #000;background-color: #000;}
	</style>
</head>
<body>
	<button class="btn btn-danger btn-block" id="successBtn" onclick="history.back()">返回到商铺</button>
    <lbs-map width="100px" style="height:100%" center="<%=shop.getShop_map() %>">
    	<lbs-poi name="<%=shop.getTitle() %>" location="<%=shop.getShop_map() %>" addr="<%=shop.getShop_loc() %>" ></lbs-poi>
    </lbs-map>
</body>
</html>