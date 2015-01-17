<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="viewport" content="initial-scale=1.0, user-scalable=no" />
	<script src="http://api.map.baidu.com/components?ak=mQO2QyHBKdGM6OX0OwGMyqmr&v=1.0"></script>
	<title>定位事件</title>
	<style type="text/css">
		body, html,#allmap {width: 100%;height: 100%;overflow: hidden;margin:0;}
		#golist {display: none;}
		@media (max-device-width: 800px){#golist{display: block!important;}}
	</style>
</head>
<body>
	<a id="golist" href="add_shop_info.jsp">返回信息管理</a>
    <lbs-map center="106.584052,29.564013" style="height:91%" id="lbsmap"></lbs-map>
</body>
</html>
<script type="text/javascript">
	var lbsGeo = document.createElement('lbs-geo');
	lbsGeo.addEventListener("geofail",function(evt){ //注册事件
		alert("定位失败");
	});
	lbsGeo.addEventListener("geosuccess",function(evt){ //注册
		var addr = evt.detail.coords;
		var x = addr.lng;
		var y = addr.lat;
		alert(x+','+y);
	});
	lbsGeo.setAttribute("enable-modified","true");
	lbsGeo.setAttribute("id","geo");
	document.body.appendChild(lbsGeo);
</script>