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
User u=UserUtil.getCurrentUser(request);
ShopService shopServ=new ShopServiceImpl();
List<Shop2Collect> s2cs=shopServ.getCollectList(u.getId());

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:4.5rem " id="content1">
<div class="container nomargin" style="color:#666;padding:2rem;margin-top: 0px !important;">
<!-- order list -->
<div class="content">
      <div class="decoration"></div>
      <%if(s2cs.size()!=0){ %>
      <%for(Shop2Collect s2c:s2cs){ 
      	String images[]=s2c.getImage().split("@");
      %>
		<div class="container no-bottom list_style" onclick="javascript:location.href='shop_detail.jsp?id=<%=s2c.getId()%>'">
		    <div class="recent-post">
		        <div class="dealcard-img"><img src="<%=FrontImage.convertOss(images[0])%>"></div>
		        <div class="dealcard-block-right">
		            <div class="title"><strong><%=StringUtil.subString(s2c.getTitle(),10) %></strong></div>
		            <div class="detail">地址：<%=s2c.getShop_loc() %></div>
		            <div class="pricepanel"><span class="strong-color">立赚</span><strong><%=StringUtil.payBackDoubleToRate(s2c.getCoinRate()) %></strong></div>
		        </div>
		    </div>
		</div>
		<br>
		<div class="decoration"></div>
		<%}
      }else{%>
      <div class="alert alert-info" role="alert">暂无数据</div>
      <%} %>
       <div class="space_noborder"></div>
</div>
</div>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="我的收藏";
</script>
</body>
</html>