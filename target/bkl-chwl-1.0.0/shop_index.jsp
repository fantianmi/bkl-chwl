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
 User user = UserUtil.getCurrentUser(request);
 ShopService shopServ=new ShopServiceImpl();
 double total=shopServ.getProfileTotal(user.getId(), Tradeorder.STATICS_ALL);
 double day=shopServ.getProfileTotal(user.getId(), Tradeorder.STATICS_DAY);
 double month=shopServ.getProfileTotal(user.getId(), Tradeorder.STATICS_MONTH);
 double month3=shopServ.getProfileTotal(user.getId(), Tradeorder.STATICS_3MONTH);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:4.5rem " id="content1">
<%if(user.getRole()==user.ROLE_SHOPER&&user.getVertify()==user.VERTIFY_FALSE){ %>
<div class="alert alert-warning" role="alert"><span class="label label-danger">重要</span>您是商家，请完善您的资料然后等待平台审核</div>
<%} %>
<div class="container nomargin" style="background-color: #DC3C00;color:#fff;padding:2rem !important;margin-bottom: 0px !important;">
  <p><i class="iconfont">&#xe623;</i>销售总额(￥)<br><br><span class="bigFont" style="color: #fff"><%=FrontUtil.formatRmbDouble(total) %></span></p>
</div>
</div>
<div class="container nomargin" style="color:#666;padding:2rem !important;margin-top: 0rem !important;">
<ul class="profitshow">
<li>24小时销售额<br><B><%=FrontUtil.formatRmbDouble(day) %></B></li>
<li>月销售额<br><B><%=FrontUtil.formatRmbDouble(month) %></B></li>
<li>三个月销售额<br><B><%=FrontUtil.formatRmbDouble(month3) %></B></li>
</ul>
</div>
<div class="space"></div>
<div class="tableList downborder">
<a href="shop_profile.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe628;</i>&nbsp;我的金币数</div><div class="status"><span id="coin_left"></span>&nbsp;&nbsp;<i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="shop_data.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe62f;</i>&nbsp;审核资料管理</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="shop_info.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe683;</i>&nbsp;展示店铺管理</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="shop_deal_list.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe624;</i>&nbsp;销售订单详情</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="user_card_list.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe6b3;</i>&nbsp;我的银行卡</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<style>
.detail span{font-weight: 400;color:#DC3C00;font-size: 1.8rem}
</style>
<script type="text/javascript">
document.getElementById("head_title").innerHTML="商家中心";
$("#top_back_button").html("<a class=\"react\"  style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;width:62px\"><i class=\"iconfont\" style=\"font-size:50px\">&#xe62f;</i></a>");
$("#top_qr_button").hide();
$("#top_search_button").hide();
var url="/api/user/getUserProfile?random="+Math.round(Math.random()*100);
$.get(url,function(res){
	if(res){
		if(res.ret==0){
			 $("#discount_get").html(res.data["discount_get"]);
			 $("#rshoper_get").html(res.data["rshoper_get"]);
			 $("#ruser_get").html(res.data["ruser_get"]);
			 $("#other_get").html(res.data["other_get"]);
			 $("#proxy2_get").html(res.data["proxy2_get"]);
			 $("#proxy_get").html(res.data["proxy_get"]);
		}
	}
});
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