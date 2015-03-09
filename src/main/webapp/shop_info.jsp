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
if(shop.getRegstatus()==shop.REGSTATUS_FALSE){
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
	<%for(int i=0;i<images.length;i++){
			String imageURL=images[i];		
		%>
            <li>
            	<a class="swipebox" href="<%=FrontImage.convertOss(imageURL)%>" title="<%=shop.getTitle()%>">
                	<img class="image-decoration" src="<%=FrontImage.convertOss(imageURL)%>" alt="<%=shop.getTitle()%>">
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
<div class="detail">商户全称&nbsp;-&nbsp;<span><%=StringUtil.subString(shop.getTitle(), 10) %></span></div>
</div>
<div class="tableList downborder">
<div class="detail">地址&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;<span><%=StringUtil.subString(shop.getShop_loc(), 8) %></span></div>
</div>
<div class="tableList downborder">
<div class="detail">返利&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;<span><%=StringUtil.doubleToRate(shop.getCoinRate()) %></span></div>
</div>
<div class="tableList downborder">
<div class="detail">联系方式&nbsp;-&nbsp;<span><%=StringUtil.subString(shop.getShop_tel(), 13) %></span></div>
</div>
<div class="tableList downborder">
<div class="detail">商家介绍&nbsp;-&nbsp;<span><%=StringUtil.subString(shop.getDetail(), 8) +"..."%></span></div>
</div>
<div class="tableList downborder">
<button onclick="location.href='add_shop_info.jsp'" class="btn btn-danger btn-block">修改店铺资料信息</button>
</div>
</div>
<div class="space"></div>
 <div class="container" style="padding: 10px !important">
 <div id="qrcode" style="text-align: center"></div>
 <h4 style="text-align: center">我的结账编号：<%=shop.getId()%></h4>
 </div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="完整资料";
$("#top_back_button").html("<a class=\"react\" href=\"user_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
$("#top_qr_button").hide();
$("#top_search_button").hide();
</script>
<script src="assets/scripts/chwl/user/jquery.qrcode.min.js"></script>
<script type="text/javascript">
jQuery(function(){
jQuery('#qrcode').qrcode("<%=payUrl%>");
})
</script>
<style>
.detail{width:100% !important}
</style>
</body>
</html>