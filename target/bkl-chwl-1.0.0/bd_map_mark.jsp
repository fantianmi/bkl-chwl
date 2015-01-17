 <%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<script src="assets/scripts/jquery.min.js"	 type="text/javascript"></script>	
	<script src="http://api.map.baidu.com/components?ak=wGG6mbDmPutcOrlNIcFxNeAU&v=1.0"></script>
	<style type="text/css">
		body, html,#allmap {width: 100%;height:100%;overflow: hidden;margin:0;}
		#golist {display: none;}
		@media (max-device-width: 800px){#golist{display: block!important;}}
		#successBtn{width: 100%;height:40px;border: 1px solid #D9534F;background-color: #D9534F;color:#fff;font-size: 16px;}
		#successBtn:disable{width: 100%;height:40px;border: 1px solid #ccc;background-color: #ccc;color:#fff;font-size: 16px;}
		#successBtn:hover{border: 1 solid #CA3B37;background-color: #CA3B37;}
	</style>
</head>
<body>
<button class="btn btn-danger btn-block" id="successBtn" onclick="successSubmit();">等待定位</button>
<lbs-map city="重庆" style="height:91%" id="lbsmap"></lbs-map>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="地图定位";
</script>
<script type="text/javascript">
	var url="add_shop_info.jsp?random="+Math.round(Math.random()*100);
	var newurl="add_shop_info.jsp?random="+Math.round(Math.random()*100);
	var lbsGeo = document.createElement('lbs-geo');
	lbsGeo.addEventListener("geofail",function(evt){ //注册事件
		swal("抱歉", "定位失败，请手动选择", "error");
	});
	lbsGeo.addEventListener("geosuccess",function(evt){ //注册
		var addr = evt.detail.coords;
		var x = addr.lng;
		var y = addr.lat;
		newurl=url+"&x="+x+"&y="+y;
		$("#successBtn").attr("disabled","");
		$("#successBtn").html("定位成功，返回");
	});
	lbsGeo.setAttribute("enable-modified","true");
	lbsGeo.setAttribute("id","geo");
	document.body.appendChild(lbsGeo);
	function successSubmit(){
		window.location.href=newurl;
	}
</script>
<!-- sweet alert -->
<link rel="stylesheet" type="text/css" href="assets/sweetalert/css/sweet-alert.css">
<script src="assets/sweetalert/js/sweet-alert.min.js"></script>
<!-- sweet alert -->
</body>
</html>
