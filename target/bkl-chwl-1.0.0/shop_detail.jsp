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
if(request.getParameter("id")==null){
	response.sendRedirect("shop_list.jsp");
	return;
}
long id=Long.valueOf(request.getParameter("id"));
Shop shop=shopServ.get(id);
if(shop==null){
	response.sendRedirect("shop_list.jsp");
	return;
}
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
			<%for(int i=1;i<images.length;i++){
			String imageURL=images[i];		
		%>
            	<li data-transition="fade" data-slotamount="10" data-masterspeed="300">
					<!--  BACKGROUND IMAGE -->
					<img src="<%=imageURL%>" alt="" />
				</li>
      <%} %>
			</ul>
		</div>
</div>
<ul class="shop_detail_list">
    <li><a href="javascript:addCollect(<%=shop.getId()%>)" id="addCollectLink"  <%=isCollect?"onclick='return false'":"" %>><span id="collect_text"><%=isCollect?"已":"" %>收藏</span>(<span id="collectNum"><%=shop.getShop_collect()%></span>)</a></li>
    <li><a href="shop_map.jsp?id=<%=shop.getId() %>">点击导航</a></li>
    <li>立省<%=StringUtil.payBackDoubleToRate(shop.getCoinRate()) %></li>
    <li><a href="tel:<%=shop.getShop_tel()%>">拨打电话</a></li>
</ul>  
<div class="container">
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
<div class="decoration"></div>
<div class="container">
     <div class="blog-post">
         <div class="post-content" style="font-size: 14px">
         <p><i class="iconfont" style="font-size:20px">&#xe67f;</i>&nbsp;&nbsp;<%=shop.getShop_loc() %></p>
         </div>
     </div>
 </div>
 
 <div class="space_noborder"></div>
 <!-- nav -->
<nav class="navbar navbar-fixed-bottom" role="navigation" id="cate_nav_bar_foot" style="z-index:999 !important;background: rgba(255,255,255,0.8);box-shadow: 0 1px 10px rgba(0,0,0,.5);-moz-user-select: none;">
<button type="button" class="btn btn-lg btn-danger btn-block noradius" onclick="window.location.href='confirm_order.jsp?result=<%=shop.getId()%>'">支付</button>
 </nav>
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
document.getElementById("head_title").innerHTML="<%=StringUtil.subString(shop.getTitle(), 4)%>...";
function addLike(sid){
	var url="/shop/addLike?random="+Math.round(Math.random()*100);
	var params={sid:sid};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				var like=new Number($("#likeNum").text());
				like++;
				$("#likeNum").html(like);
				$("#addLikeLink").attr("onclick","return false");
				$("#like_text").html("已赞");
			}if(res.ret==-1){
				swal({
                 title: "抱歉",  
                 text: "请登录后再点赞",  
                 type: "error",  
                 showCancelButton: true,  
                 confirmButtonColor: "#A7D5EA",  
                 confirmButtonText: "确认" },
                 function(){  
                      window.location.href="/login.jsp";
                 });
			}
		}
	});
}
function addCollect(sid){  
	var url="/shop/addCollect?random="+Math.round(Math.random()*100);
	var params={sid:sid};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				var like=new Number($("#collectNum").text());
				like++;
				$("#collectNum").html(like);
				$("#addCollectLink").attr("onclick","return false");
				$("#collect_text").html("已收藏");
			}if(res.ret==-1){
				swal({
                 title: "抱歉",  
                 text: "登录后才可以进行此操作",  
                 type: "error",  
                 showCancelButton: true,  
                 confirmButtonColor: "#A7D5EA",  
                 confirmButtonText: "确认" },
                 function(){  
                      window.location.href="/login.jsp";
                 });
			}
		}
	});
}
</script>
<script src="assets/scripts/chwl/user/jquery.qrcode.min.js"></script>
<script type="text/javascript">
jQuery(function(){
jQuery('#qrcode').qrcode("<%=payUrl%>");
})
</script>
</body>
</html>