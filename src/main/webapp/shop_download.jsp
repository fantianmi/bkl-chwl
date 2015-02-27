<%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem" id="content1">
 </div>
<div class="tableList downborder">
<a href="download.jsp?downloadUrl=<%=URLEncoder.encode("doc/点头付商家协议.docx") %>"  target="_blank"><div class="detail" style="padding-left: 1rem">&nbsp;点头付商家协议下载</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<!-- <div class="tableList downborder">
<a href="secretReset.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe736;</i>&nbsp;交易密码</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div> -->
<%-- <div class="space"></div>
<button class="btn btn-danger btn-block" onclick="shopStatusOper(<%=shop.getShopstatus()==1?0:1%>)"><%=shop.getShopstatus()==1?"关闭店铺":"重新打开店铺" %></button> --%>

 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<style>
.detail span{font-weight: 400;color:#DC3C00;font-size: 1.8rem}
</style>
<script type="text/javascript">
document.getElementById("head_title").innerHTML="下载中心";
$("#top_qr_button").hide();
$("#top_search_button").hide();
</script>
<style>
.menu_list_headicon{
	float:left;
	height:6rem;
	width:6rem;
}
.menu_list_user{height:6rem;padding:1rem;float:left;}
.menu_list_headicon img{width:100% !important;}
.downborder a{color:#000;}
.detail{width:60% !important;padding: .5rem 1rem !important;}
.status{width:40% !important;text-align: right;padding-right: 1rem !important;}
.status .iconfont{color:#ccc;}
.menuicon{font-size:20px;color:#12A0D7}
</style>
<jsp:include page="updateProfileTimes.jsp"/>
</body>
</html>