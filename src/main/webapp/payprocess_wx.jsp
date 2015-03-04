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
 OrderService orderServ=new OrderServiceImpl();
 if(request.getParameter("orderId")==null){
	 response.sendRedirect("index.jsp");
	 return;
 }
 String orderId=request.getParameter("orderId"); 
 Tradeorder2Shop order=orderServ.getTradeorder2ShopOrderId(orderId);
 String uri=MainConfig.getContextPath();
 User u=UserUtil.getCurrentUser(request);
 String openid="";
 if(u.getOpenid()!=null&&u.getOpenid()!=""){
	 openid=u.getOpenid();
 }
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1" onclick="hideWeixinAlert();">
<input type="hidden" name="openid" id="openid" value="<%=openid%>"/>
<dl class="list"><dd><dl>
   <dt>结账详情</dt>
   <ul>
       <li>订单编号：<span id=orderid><%=order.getOrderId() %></span></li>
       <li>订单价格：<span id="total_fee"><%=order.getPrice() %></span></li>
       <li>商家名称：<%=order.getSeller()+"-"+order.getShop_title()%></li>
       <li>付款用户：<%=order.getUid()%></li>
       <li>创建时间：<%=order.getCtimeString() %></li>
    </ul>
</dl></dd></dl>
<!-- order area -->
<div style="width:200px"><img src="assets/images/wxpay.jpg"></div>
<button class="btn btn-success btn-block" id="paySubmitBtn" onclick="paySubmit()">微信支付</button>
<!-- order area -->
</div>
<div class="weixin_alert" id="weixin_alert" onclick="hideWeixinAlert();">
<img src="assets/images/weixin_alert.png">
</div>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="确认付款";
$("#top_qr_button").hide();
$("#top_search_button").hide();
$("#top_back_button").html("");
$("#top_logout_button").hide();
</script>
<script>
var uri='<%=uri%>';
 function getParamValue(name)
 {
   try {
     return(
       location.search.match(new RegExp("[\?&]"+name+"=[^&#]*"))[0].split("=")[1]
     );
   } catch (ex) {
     return(null);
   }
 }
 void(function getOpenId(){
   if (!getParamValue("openid"))
   {
     var thisUrl = location.href;
     location.href=uri+"get-openid.api?redir="+encodeURIComponent(thisUrl);
   }
   else
   {
     document.getElementById("openid").value = getParamValue("openid");  
   }
 })();

 function buybuybuy()
 {
   var ajax = new XMLHttpRequest();
   ajax.open(
     "POST",
     uri+"jsapi-signer.api",
     false
   );
   ajax.setRequestHeader("Content-type","application/x-www-form-urlencoded");
   ajax.send(
     "body="+document.getElementById("body").value
     +"&total_fee="+document.getElementById("total_fee").value
     +"&openid="+document.getElementById("openid").value
     +"&orderid="+$("#orderid").html()
   );
   var gbwcpr = JSON.parse(ajax.responseText);
   WeixinJSBridge.invoke(
     'getBrandWCPayRequest',
     gbwcpr,
     function(res){
       alert(res.err_msg);
       if(res.err_msg == "get_brand_wcpay_request:ok" )
         {
           window.location.href="paysuccess.jsp?orderId="+$("#orderid").html();
         }
       // 使用以上方式判断前端返回,微信团队郑重提示：res.err_msg 将在用户支付成功后返回 ok，但幵丌保证它绝对可靠。
     }
   );
 }
     
</script>
</body>
</html>