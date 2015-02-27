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
	 String oath="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+MainConfig.getWechatappid()+"&redirect_uri="+uri+"&response_type=code&scope=snsapi_base&state=1#wechat_redirect";
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
if(shop.getShopstatus()==shop.SHOPSTATUS_HIDE){
	response.sendRedirect("index.jsp");
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

BindCardService bindCardServ=new BindCardServiceImpl();
List<User2BindCard> cards=bindCardServ.getUser2Cards(user.getId());
if(cards.size()==0){
	response.sendRedirect("user_card_list.jsp");
	return;
}
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
    <input type="text" class="form-control" id="price" placeholder="输入金额" onkeyup="checkNum(this)" onpaste="checkNum(this)" oncontextmenu = "checkNum(this)">
  </div>
  <div class="input-group" >
  <span class="input-group-addon">付款卡片</span>
  <select id="bank_account_o" style="width:100% !important;height:3rem !important">
    <option value="0">请选择付款的银行卡</option>
    <%for(User2BindCard card:cards){%>
    <option value="<%=card.getBank_account_o()%>"><%=card.getBank_o()+"  "+FrontUtil.hiddenNum(card.getBank_account_o())+" "+card.getName() %></option>
    <%} %>
    </select>
</div>
<br>
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
function checkNum(obj) {  
    //检查是否是非数字值  
    if (isNaN(obj.value)) {  
        obj.value = "";  
    }  
    if (obj != null) {  
        //检查小数点后是否对于两位
        if (obj.value.toString().split(".").length > 1 && obj.value.toString().split(".")[1].length > 2) {  
            alert("小数点后不能多于两位！");  
            obj.value = "";  
        }  
    }  
}
</script>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="付款";
</script>
</body>
</html>