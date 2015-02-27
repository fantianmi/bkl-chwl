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

String imageStr=shop.getImage();
String images[] = imageStr.split("@");
User u=UserUtil.getCurrentUser(request);

boolean isCollect=false;
boolean isLike=false;
if(u!=null){
	if(shopServ.isLike(u.getId(), shop.getId())){
		isLike=true;
	}
	if(shopServ.isCollect(u.getId(), shop.getId())){
		isCollect=true;
	}
		
}
String payUrl=MainConfig.getContextPath()+"confirm_order.jsp?result="+shop.getId();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="common_source_head.jsp"/>
<link rel="stylesheet" type="text/css" href="assets/slider/shop_slider/css/main.css" id="main-css">
<script type="text/javascript" src="assets/slider/shop_slider/js/jquery.min.js"></script>
<script type="text/javascript" src="assets/slider/shop_slider/js/rev-setting-1.js"></script>
<script type="text/javascript" src="assets/slider/shop_slider/rs-plugin/js/jquery.themepunch.revolution.min.js"></script>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="fullwidthbanner-container" style="margin-top:5.1rem">
		<div id="revolution-slider">
			<ul>
			<%for(int i=0;i<images.length;i++){
			String imageURL=images[i];		
		%>
            	<li data-transition="fade" data-slotamount="10" data-masterspeed="300">
					<!--  BACKGROUND IMAGE -->
					<img src="<%=FrontImage.convertOss(imageURL)%>" alt="" />
				</li>
      <%} %>
			</ul>
		</div>
</div>
<ul class="shop_detail_list" style="margin-bottom: 0px;">
    <li><a href="javascript:addCollect(<%=shop.getId()%>)" id="addCollectLink"  <%=isCollect?"onclick='return false'":"" %>><i class="iconfont" style="color:#EA4647 ">&#xe611;</i><span id="collect_text"><%=isCollect?"已":"" %>收藏</span>(<span id="collectNum"><%=shop.getShop_collect()%></span>)</a></li>
    <li><a href="shop_map.jsp?id=<%=shop.getId() %>"><i class="iconfont" style="color:#4FB2EB">&#xe67f;</i>点击导航</a></li>
    <li><i class="iconfont" style="color:#D79632">&#xe628;</i>立赚<%=StringUtil.payBackDoubleToRate(shop.getCoinRate()) %></li>
    <li><a href="tel:<%=shop.getShop_tel()%>" ><i class="iconfont" style="color:#04A768">&#xe652;</i>拨打电话</a></li>
</ul>  
<div class="container" style="background-color: #F0EFED">
     <div class="blog-post">
         <div class="post-content">
             <h3><%=shop.getTitle()%></h3>     
             <p><%=shop.getDetail()%></p>
         </div>
         <div class="post-details">
             <div class="clear"></div>
         </div>
     </div>
 </div>
<div class="container">
     <div class="blog-post">
         <div class="post-content" style="font-size: 14px">
         <p><i class="iconfont" style="font-size:20px;color:#FF3556">&#xe67f;</i><span style="font-size: 16px;font-weight: 800;color:#666;">地址</span>&nbsp;&nbsp;<%=shop.getShop_loc() %></p>
         </div>
     </div>
 </div>
 
 <div class="space_noborder"></div>
 <!-- nav -->
 <div class="space"></div>
 <div class="container" style="padding: 10px !important">
 <div id="qrcode" style="text-align: center"></div>
 <h4 style="text-align: center">商家编号：<%=shop.getId()%></h4>
 </div>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="点商预览";
$("#top_back_button").html("<a class=\"react\" href=\"shop_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
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