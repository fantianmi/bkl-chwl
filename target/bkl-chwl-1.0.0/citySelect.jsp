<%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<%
UserService userServ=new UserServiceImpl();
AreaService areaServ=new AreaServiceImpl();

int userNum=userServ.countUser(1);
int shopNum=userServ.countUser(2);
List<Area> areas=areaServ.getList(0);
Map<Long,Area> areaMap=areaServ.areaMap(0);
%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
	<!-- slider -->
	<link href="assets/slider/movie/css/css.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="assets/slider/movie/js/zzsc.js"></script>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content" style="margin-top:6.1rem ">
    <div class="welcome-text">
    	<h5>选择城市</h5>
    	<p style="margin-bottom: 10px;">先选择一级城市，再选择二级城市</p> 
    </div>
    <div class="space_noborder"></div>
    <ul class="city_list">
    <%for(Area a:areas){ %>
    	<a href="javascript:void(0);" onclick="showChildCity(<%=a.getId()%>)"><li><%=StringUtil.subString(a.getTitle(), 4)%></li></a>
    <%} %>
    </ul>
    <div class="space_noborder"></div>
</div>
<div class="space"></div>
<div class="content">
	<div class="welcome-text">
        <p style="margin-bottom: 10px;color:#000">二级城市</p>    
    </div>
	<ul class="city_list" id="secondCityList">
	<div class="alert alert-info" role="alert" style="text-align: center">...</div>
	</ul>
	<div class="space_noborder"></div>
</div>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
$(document).ready(function(){
	$("#secondCityList").html("<div class=\"alert alert-info\" role=\"alert\" style=\"text-align: center\">请先选择一级城市</div>");
});
function showChildCity(reid){
	var url="/area/getAreaHTMLInSelectCityPage?random="+Math.round(Math.random()*100);
	var params={reid:reid};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				$("#secondCityList").html(res.data);
			}
		}else{
			$("#secondCityList").html("<div class=\"alert alert-info\" role=\"alert\" style=\"text-align: center\">服务器连接失败</div>");
		}
	});
}
</script>
<style>
.welcome-text h5 {
}
.container2{
font: 14px/1.5 arial,"Microsoft Yahei","Hiragino Sans GB",sans-serif;
border-top: 1px solid #62528E !important;border-bottom: 1px solid #62528E !important;margin:1rem 1rem;padding: 1rem;font-size: 1.4rem;;height:5rem;
}
.container2 .leftarea{float:left;width:48%;margin-right: 4%;height:2rem;font: 1.4rem/1.5 arial,"Microsoft Yahei","Hiragino Sans GB",sans-serif;}
.container2 .rightarea{float:left;width:48%;height:2rem;font: 1.4rem/1.5 arial,"Microsoft Yahei","Hiragino Sans GB",sans-serif;}
.container2 .number{font-size: 2.0rem;color:#D24955;font-weight: 0 !important;font: 2.5rem/1.5 arial,"Microsoft Yahei","Hiragino Sans GB",sans-serif;}
.copyright{font-size: 1.4rem;}
</style>
</body>
</html>