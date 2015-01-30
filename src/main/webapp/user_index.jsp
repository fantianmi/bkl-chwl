<%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
 User user = UserUtil.getCurrentUser(request);
 if(user.getOpenid()==null||user.getOpenid()==""){
	 String uri=MainConfig.getContextPath()+"/api/user/bindWeixinOpenId";
	 uri=URLEncoder.encode(uri, "utf-8");
	 String oath="https://open.weixin.qq.com/connect/oauth2/authorize?appid=wxa2a306c8179ab786&redirect_uri="+uri+"&response_type=code&scope=snsapi_base&state=1#wechat_redirect";
	 response.sendRedirect(oath);
	 return;
 }
 CashService cashSer = new CashServiceImpl();
 OrderService orderServ = new OrderServiceImpl();
 double SUMOrder=orderServ.getSUM(user.getId());
 List<Cash> withdraws = cashSer.getLast20WithdrawList(user.getId());
 boolean haswithdraws = (withdraws.size() != 0);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5rem " id="content1">
<%if(user.getRole()==user.ROLE_SHOPER&&user.getVertify()==user.VERTIFY_FALSE){ %>
<div class="alert alert-warning"><span class="label label-danger">重要</span>您是商家，请完善您的资料然后等待平台审核</div>
<%} %>
<div class="space"></div>
<div class="tableList downborder" style="height:8rem !important;">
<a href="user_detail.jsp"><div class="detail" style="padding-left: 1rem;width:80% !important;"><div class="menu_list_headicon"><img src="assets/images/headicon.png"></div><div class="menu_list_user"><%=user.getMobile() %><br>ID: <%=user.getId() %></div></div><div class="status" style="height:8rem;padding:2.5rem;width:20% !important;"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="user_profile.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon" style="color: #FDB300">&#xe628;</i>&nbsp;我的金币数</div><div class="status"><span id="coin_left" style="color:#ED6A00;font-weight: 600;font-size: 18px;"></span>&nbsp;&nbsp;<i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="user_order.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon" style="color: #00AE69">&#xe662;</i>&nbsp;结账总额</div><div class="status" style="color:#ED6A00;font-weight: 600;font-size: 18px;"><%=FrontUtil.formatRmbDouble(SUMOrder) %><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="user_bouns_list.jsp	"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon" style="color: #D39145">&#xe61a;</i>&nbsp;点头钱袋</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="doLottery.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon" style="color: #EA434B">&#xf0139;</i>&nbsp;我要抽奖</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="user_fans_list.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon" style="color: #52BCEE">&#xf00d8;</i>&nbsp;推荐粉丝</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="user_collect.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon" style="color: #565455">&#xe611;</i>&nbsp;我的收藏</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="user_card_list.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon" style="color: #EE8100">&#xe6b3;</i>&nbsp;我的银行卡</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<style>
.detail span{font-weight: 400;color:#DC3C00;font-size: 1.8rem}
</style>
<script type="text/javascript">
document.getElementById("head_title").innerHTML="我的账本";
$("#top_back_button").html("<a class=\"react\" href=\"index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
var url="/api/user/getUserProfile?random="+Math.round(Math.random()*100);
$.get(url,function(res){
	if(res){
		if(res.ret==0){
			 $("#discount_get").html(res.data["discount_get"]);
			 $("#rshoper_get").html(res.data["rshoper_get"]);
			 $("#ruser_get").html(res.data["ruser_get"]);
			 $("#bonus_get").html(res.data["bonus_get"]);
			 $("#lottery_get").html(res.data["lottery_get"]);
			 $("#proxy2_get").html(res.data["proxy2_get"]);
			 $("#proxy_get").html(res.data["proxy_get"]);
		}
	}
});
</script>
<jsp:include page="updateProfileTimes.jsp"/>
<style>
.menu_list_headicon{
	float:left;
	height:6rem;
	width:6rem;
	border-radius:50px;
	overflow: hidden;
}
.menu_list_user{height:6rem;padding:1rem;float:left;}
.menu_list_headicon img{width:100% !important;}
.downborder a{color:#000;}
.detail{width:60% !important;padding: .5rem 1rem !important;}
.status{width:40% !important;text-align: right;padding-right: 1rem !important;}
.status .iconfont{color:#ccc;}
.menuicon{font-size:20px;color:#12A0D7}
</style>
</body>
</html>