<%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="com.bkl.chwl.vo.*"%>   
<%@page import="java.math.BigDecimal"%>   
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String shopId=request.getParameter("result");
String shopName="石桥铺乡村菜";
String orderId=request.getParameter("orderId");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
<div class="info">
<img src="assets/images/ui/paysuccess.png">
</div>
</div>
<div class="content" style="text-align: center;padding: 2rem;margin-bottom: 2rem;">
<a href="user_order_detail.jsp?orderId=<%=orderId %>" class="btn btn-danger">查看结账详情</a>&nbsp;&nbsp;<a href="shop_list.jsp" class="btn btn-info">返回继续购买</a>&nbsp;&nbsp;
<a href="doLottery.jsp" class="btn btn-danger">进入抽奖</a>
</div>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script>
document.getElementById("shopName").value="<%=shopName%>";
</script>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="绑定成功";
var url="/order/settleOrder?orderId=<%=orderId%>&random="+Math.round(Math.random()*100);
$.get(url,function(res){
});
</script>
</body>
</html>