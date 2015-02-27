<%@page import="com.bkl.chwl.utils.StringUtil"%>
<%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.km.common.utils.*"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="com.bkl.chwl.vo.*"%>   
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="common_source_head.jsp"/>
<%
request.setCharacterEncoding("utf-8");

String citySelectStrFromPage=request.getParameter("local2");
String citySelectNameStrFromPage=request.getParameter("cityName");

if(citySelectStrFromPage!=null&&citySelectNameStrFromPage!=null){
	CookieUtil.removeCookie("citySelect", response);
	CookieUtil.addCookie("citySelect", citySelectStrFromPage, response);
	CookieUtil.removeCookie("citySelectName", response);
	CookieUtil.addCookie("citySelectName", citySelectNameStrFromPage, response);
	response.sendRedirect("shop_list.jsp");
	return;
}
String citySelectStr=CookieUtil.getCookie("citySelect", request);

if(citySelectStr==null){//开始定位（没有保存过Cookie）
	String ip=RequestUtil.getRemoteAddress(request);
	BdMapRes bdMapRes=BdMapUtil.getLocation(ip);
	BdContent bdContent=bdMapRes.getContent();
	
	if(bdContent==null){//百度定位失败
		response.sendRedirect("citySelect.jsp");
		return;
	}
	
	BdAddress_detail bdAddress_detail=bdContent.getAddress_detail();
	AreaService areasServ=new AreaServiceImpl();
	Area a=areasServ.getSecond(bdAddress_detail.getCity());
		if(a==null){
			request.getRequestDispatcher("citySelect.jsp").forward(request, response);
			return;
		}else{//定位成功
			CookieUtil.removeCookie("citySelect", response);
			CookieUtil.removeCookie("citySelectName", response);
			CookieUtil.addCookie("citySelect", String.valueOf(a.getId()), response);
			CookieUtil.addCookie("citySelectName", a.getTitle(), response);
			response.sendRedirect("shop_list.jsp");
			return;
		}
}
long citySelect=Long.valueOf(citySelectStr);
TypeService typeServ=new TypeServiceImpl();
AreaService areaServ=new AreaServiceImpl();
List<Area> areas=areaServ.getList(citySelect);
List<Type> types=typeServ.getList(0);

String cityName=java.net.URLDecoder.decode(CookieUtil.getCookie("citySelectName", request),"UTF-8");
cityName=StringUtil.subString(cityName, 4);
%>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<!-- nav -->
<nav class="navbar navbar-default navbar-fixed-top" role="navigation" id="cate_nav_bar" >
	 <div class="btn-group btn-group-justified" style="box-shadow: 0 1px 10px rgba(0,0,0,.5);-moz-user-select: none;">
		   <div class="btn-group">
			  <button type="button" class="btn btn-default dropdown-toggle noradius" data-toggle="dropdown" style="border:none">
			    <span id="areaTitle">商区</span>
			    <span class="caret"></span>
			  </button>
			  <ul class="dropdown-menu" role="menu" style="height:30rem;overflow: scroll;">
			    <li><a href="javascript:getAreaData(0,'全部')">全部</a></li>
			  <%for(Area a:areas){ %>
			    <li><a href="javascript:getAreaData(<%=a.getId()%>,'<%=StringUtil.subString(a.getTitle(),4)%>')"><%=StringUtil.subString(a.getTitle(),4)%></a></li>
			   <%} %>
			  </ul>
			</div>
		   <div class="btn-group">
			  <button type="button" class="btn btn-default dropdown-toggle noradius" data-toggle="dropdown" style="border-bottom:none;;border-top:none">
			    <span id="typeTitle">分类</span>
			    <span class="caret"></span>
			  </button>
			  <ul class="dropdown-menu" role="menu" >
			    <li><a href="javascript:getTypeData(0,'全部')">全部</a></li>
			  <%for(Type type:types){ %>
			    <li><a href="javascript:getTypeData(<%=type.getId()%>,'<%=type.getName() %>')"><%=type.getName() %></a></li>
			   <%} %>
			  </ul>
			</div>
		   <div class="btn-group">
			  <button type="button" class="btn btn-default dropdown-toggle noradius" data-toggle="dropdown" style="border: none;">
			   <span id="sortTitle"> 排序</span>
			    <span class="caret"></span>
			  </button>
			  <ul class="dropdown-menu" role="menu" >
			    <li><a href="javascript:getSortData(1,'默认')">默认</a></li>
			    <li><a href="javascript:getSortData(1,'时间')">时间</a></li>
			    <li><a href="javascript:getSortData(5,'立赚')">立赚</a></li>
			  </ul>
			</div>
	 </div>
 </nav>
 <!-- nav -->
<!-- nav -->
<nav class="navbar navbar-fixed-bottom navbar-inverse" role="navigation" id="cate_nav_bar_foot" style="z-index:999 !important;background: rgba(255, 53, 86,0.8);" >
<div class="left-area"><!-- <a href="user_detail.jsp" class="btn btn-default noradius">推广粉丝</a> --></div>
<div class="right-area"><span class="btn btn-default noradius" style="background-color:#FF3556;color:#fff"><%=cityName%></span>&nbsp;&nbsp;<a href="citySelect.jsp" class="btn btn-default bg-touming noradius">切换城市</a></div>
 </nav>
 <!-- nav -->
<div class="content" style="margin-top:9.2rem ">
      <span id="shopList">
       </span>
       <button type="button" class="btn btn-lg btn-default btn-block noradius" id="showmoreBtn" onclick="showMore()">显示更多...</button>
       <div class="space_noborder"></div>
</div>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<script type="text/javascript">
document.getElementById("head_title").innerHTML="店铺列表";
$("#top_back_button").html("<a class=\"react\" href=\"index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
</script>
<!-- page special -->
<script type="text/javascript">

var type=0;
<%
if(request.getParameter("shop_type")!=null){
Type type=typeServ.get(Integer.parseInt(request.getParameter("shop_type")));
%>
type=<%=Integer.parseInt(request.getParameter("shop_type"))%>;
$("#typeTitle").html('<%=type.getName()%>');
<%}%>
var area=0;
var local2=<%=citySelect%>;
var url="/shop/getShopPageHTML?local2="+local2+"&random="+Math.round(Math.random()*100);
var sort=0;
var pageNow=1;
$("document").ready(function(){
	loadData(url);
});
function getTypeData(id,name){
	type=id;
	var newurl=url+"&local3="+area+"&type="+type+"&sort="+sort;
	$("#typeTitle").html(name);
	loadData(newurl);
	pageNow=1;
}
function getAreaData(id,name){
	area=id;
	var newurl=url+"&local3="+area+"&type="+type+"&sort="+sort;
	$("#areaTitle").html(name);
	loadData(newurl);
	pageNow=1;
}
function getSortData(id,name){
	sort=id;
	var newurl=url+"&local3="+area+"&type="+type+"&sort="+sort;
	$("#sortTitle").html(name);
	loadData(newurl);
	pageNow=1;
}
function showMore(){
	pageNow++;
	var newurl=url+"&local3="+area+"&type="+type+"&sort="+sort+"&pagenum="+pageNow+"&pagesize=20";
	$.get(newurl,function(res){
		if(res){
			if(res.ret==0){
				if(res.data!=null&&res.data!=""){
					$("#shopList").append(res.data);
				}else{
					$("#showmoreBtn").html("没有更多内容了..");
					$("#showmoreBtn").attr("disabled","disabled"); 
				}
			}
		}else{
			swal("错误", "服务器连接不上，请检查您的网络", "error");
		}
	});
}

function loadData(url){
	var newurl=url+"&local3="+area+"&type="+type+"&sort="+sort+"&pagenum="+pageNow+"&pagesize=20";
	$.get(newurl,function(res){
		if(res){
			if(res.ret==0){
				if(res.data!=""){
					$("#shopList").html(res.data);
				}else{
					$("#shopList").html("<div class='alert alert-info'>暂无店铺</div>");
					$("#showmoreBtn").html("没有更多内容了..");
					$("#showmoreBtn").attr("disabled","disabled"); 
				}
			}
		}else{
			swal("错误", "服务器连接不上，请检查您的网络", "error");
		}
	});
}
</script>
<!-- page special -->
</body>
</html>