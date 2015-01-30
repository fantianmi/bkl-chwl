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
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
com.bkl.chwl.entity.User user=UserUtil.getCurrentUser(request);
if(user.getOpenid()==null||user.getOpenid()==""){
	String uri=MainConfig.getContextPath()+"/api/user/bindWeixinOpenId";
	 uri=URLEncoder.encode(uri, "utf-8");
	 String oath="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxa2a306c8179ab786&redirect_uri="+uri+"&response_type=code&scope=snsapi_base&state=1#wechat_redirect";
	 response.sendRedirect("uri");
	 return;
}
if(request.getParameter("result")==null){
	response.sendRedirect("scanQR.jsp");
	return;
}
String shopId=request.getParameter("result");
ShopService shopServ=new ShopServiceImpl();
long id=Long.valueOf(shopId);
Shop shop=shopServ.get(id);
if(shop==null){
	response.sendRedirect("scanQR.jsp");
	return;
}
String shopName=shop.getTitle();
int type=2;
if(shop.getCoinRate()>0){
	type=1;
}
com.bkl.chwl.entity.User u=UserUtil.getCurrentUser(request);
double coin=ApiCommon.getUserCoin(u.getId());
double coinRate=shop.getCoinRate();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
	<div class="container nomargin" style="padding: .5rem !important;">
	<input type="hidden" name="payway" id="payway" value="1">
	<input type="hidden" name="seller" id="seller" value="<%=shop.getUid()%>">
	<input type="hidden" name="coin" id="coin" value="<%=coin%>">
	<input type="hidden" name="coinRate" id="coinRate" value="<%=coinRate%>">
	<input type="hidden" name="type" id="type" value="<%=type%>">
  <div class="form-group">
    <input type="text" class="form-control" id="shopName" readonly="readonly">
  </div>
  <div class="form-group">
    <label for="price"><i class="iconfont">&#xe63a;</i>&nbsp;&nbsp;结账金额</label>
    <input type="text" class="form-control" id="price" placeholder="输入金额" onkeyup="value=value.replace(/[^0-9]/g,'')" onpaste="value=value.replace(/[^0-9]/g,'')" oncontextmenu = "value=value.replace(/[^0-9]/g,'')">
  </div>
 <%--  <div class="form-group">
    <label for="price"><i class="iconfont">&#xe610;</i>&nbsp;&nbsp;结账方式</label>
    <button id="yinlianBtn" class="btn btn-default active btn-xs" onclick="changePayWay(1)">银联结账</button>
    <button id="yueBtn" class="btn btn-default btn-xs" onclick="changePayWay(2)">余额结账（金币：<%=coin%>）</button>
  </div> --%>
  <p class="bg-danger" style="display: none" id="payNote"></p>
  	<button onclick="orderSubmit()" class="btn btn-danger btn-block">付款</button><br>
	</div>
</div>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script>
document.getElementById("shopName").value="<%=shopName%>";
function changePayWay(way){
	$("#payway").val(way);
	if(way==1){
		$("#yinlianBtn").addClass("active");
		$("#yueBtn").removeClass("active");
	}else{
		$("#yinlianBtn").removeClass("active");
		$("#yueBtn").addClass("active");
	}
}
</script>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="付款";
</script>
</body>
</html>