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
<%
ShopService shopServ=new ShopServiceImpl();
User user = UserUtil.getCurrentUser(request);
if(user.getVertify()==user.VERTIFY_FALSE){
	response.sendRedirect("user_index.jsp");
	return;
}
Shop shop=shopServ.getByUid(user.getId());
if(shop==null){
	response.sendRedirect("add_shop_info.jsp");
	return;
}
String imageStr=shop.getImage();
String images[] = imageStr.split("@");
String payUrl=MainConfig.getContextPath()+"confirm_order.jsp?result="+shop.getId();
%>
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
<div class="content">
	<div id="tab-one">
	<ul class="gallery" id="shop_pic_list">
	<%for(int i=1;i<images.length;i++){
			String imageURL=images[i];		
		%>
            <li>
            	<a class="swipebox" href="<%=imageURL%>" title="<%=shop.getTitle()%>">
                	<img class="image-decoration" src="<%=imageURL%>" alt="<%=shop.getTitle()%>">
                </a>
            </li>
      <%} %>
            <!-- <li>
            	<a href="addpic.jsp">
                	<img class="image-decoration" src="assets/images/ui/add-icon.png">
                </a>
            </li> -->
        </ul>
	</div>
</div>
</div>
<div class="space"></div>
<div class="container nomargin" style="margin: 0rem !important;">
<div class="tableList downborder">
<div class="detail">客服电话：<span>400-1568-848</span></div>
</div>
<div class="tableList downborder">
<div class="detail"><%=StringUtil.subString(shop.getTitle(), 10) %></div><div class="status">店铺名</div>
</div>
<div class="tableList downborder">
<div class="detail"><%=StringUtil.subString(shop.getShop_loc(), 8) %></div><div class="status">地址</div>
</div>
<div class="tableList downborder">
<div class="detail">返利<%=StringUtil.doubleToRate(shop.getCoinRate()) %></div><div class="status">返利</div>
</div>
<div class="tableList downborder">
<div class="detail"><%=StringUtil.subString(shop.getShop_tel(), 13) %></div><div class="status">联系方式</div>
</div>
<div class="tableList downborder">
<div class="detail"><%=StringUtil.subString(shop.getDetail(), 8) %></div><div class="status">详情</div>
</div>
<div class="tableList downborder">
<button onclick="location.href='add_shop_info.jsp'" class="btn btn-danger btn-block">修改店铺资料信息</button>
</div>
</div>
<div class="space"></div>
 <div class="container" style="padding: 10px !important">
 <div id="qrcode" style="text-align: center"></div>
 <h4 style="text-align: center">我的支付编号：<%=shop.getId()%></h4>
 <p>支付编号是用户创建订单时需要输入的商家编号</p>
 </div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="管理店铺";
$("#top_back_button").html("<a class=\"react\" href=\"user_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>返回</a>");
$("#top_qr_button").hide();
$("#top_search_button").hide();
</script>
<script src="assets/scripts/chwl/user/jquery.qrcode.min.js"></script>
<script type="text/javascript">
jQuery(function(){
jQuery('#qrcode').qrcode("<%=payUrl%>");
})
</script>
</body>
</html>