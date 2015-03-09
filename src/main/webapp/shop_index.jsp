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
	 String oath="https://open.weixin.qq.com/connect/oauth2/authorize?appid="+MainConfig.getWechatappid()+"&redirect_uri="+uri+"&response_type=code&scope=snsapi_base&state=1#wechat_redirect";
	 response.sendRedirect(oath);
	 return;
 }
 ShopService shopServ=new ShopServiceImpl();
 Shop shop=shopServ.getByUid(user.getId());
 double day=shopServ.getProfileTotal(user.getId(), Tradeorder.STATICS_DAY);
 double day2=shopServ.getSellercoinTotal(user.getId(), Tradeorder.STATICS_DAY);
 double month=shopServ.getProfileTotal(user.getId(), Tradeorder.STATICS_MONTH);
 double month2=shopServ.getSellercoinTotal(user.getId(), Tradeorder.STATICS_MONTH);
 double total=shopServ.getProfileTotal(user.getId(), Tradeorder.STATICS_ALL);
 double total2=shopServ.getSellercoinTotal(user.getId(), Tradeorder.STATICS_ALL);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
<%if(user.getRole()==user.ROLE_SHOPER&&shop.getRegstatus()==shop.REGSTATUS_FALSE){ %>
<div class="alert alert-warning" role="alert"><span class="label label-danger">重要</span>您是商家，请完善【完整资料】中的资料，才能在平台中展示</div>
<%} %>
<%if(shop.getVertifystatus()==shop.VERTIFYSTATUS_FALSE){ %>
<div class="alert alert-warning" role="alert"><span class="label label-danger">重要</span>您的店铺已被管理员禁用，无法在平台继续显示，请联系管理员申诉或重新开通</div>
<%} %>
<%if(shop.getShopstatus()==shop.SHOPSTATUS_HIDE){ %>
<div class="alert alert-warning" role="alert"><span class="label label-danger">重要</span>您已关闭店铺，消费者不会再看到您的店铺</div>
<%} %>

<div class="tableList downborder">
<a href="shop_preview.jsp"><div class="detail" style="padding-left: 1rem;font-size:1.8rem;width:80% !important; font-weight: 800"><%=shop.getTitle() %></div><div class="status" style="width:20% !important"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
</div>
<div class="space"></div>
<div class="container nomargin" style="color:#666;padding:2rem !important;margin-top: 0rem !important;">
<ul class="profitshow">
<li onclick="javascript:window.location.href='shop_deal_list.jsp?staticsType=<%=Tradeorder.STATICS_DAY%>'">当日结账额<br><B><%=FrontUtil.formatRmbDouble(day) %></B></li>
<li onclick="javascript:window.location.href='shop_deal_list.jsp?staticsType=<%=Tradeorder.STATICS_DAY%>'">当日应收额<br><B><%=FrontUtil.formatRmbDouble(day2) %></B></li>
<li onclick="javascript:window.location.href='shop_deal_list.jsp?staticsType=<%=Tradeorder.STATICS_MONTH%>'">当月结账额<br><B><%=FrontUtil.formatRmbDouble(month) %></B></li>
<li onclick="javascript:window.location.href='shop_deal_list.jsp?staticsType=<%=Tradeorder.STATICS_MONTH%>'">当月应收额<br><B><%=FrontUtil.formatRmbDouble(month2) %></B></li>
<li onclick="javascript:window.location.href='shop_deal_list.jsp'">总结账额<br><B><%=FrontUtil.formatRmbDouble(total) %></B></li>
<li onclick="javascript:window.location.href='shop_deal_list.jsp'">总应收额<br><B><%=FrontUtil.formatRmbDouble(total2) %></B></li>
</ul>
</div>
<div class="space"></div>
<div class="tableList downborder">
<a href="shop_deal_list.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe624;</i>&nbsp;结账详情</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="space"></div>
<div class="tableList downborder">
<a href="shop_profile.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe628;</i>&nbsp;我的金币数</div><div class="status"><span id="coin_left"></span>&nbsp;&nbsp;<i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="space"></div>
<div class="tableList downborder">
<a href="shop_data.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe683;</i>&nbsp;审核资料</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="shop_info.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe683;</i>&nbsp;完善资料</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="space"></div>
<div class="tableList downborder">
<a href="bind_mobile.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe705;</i>&nbsp;绑定手机号</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="shop_card_list.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe6b3;</i>&nbsp;我的银行卡</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="space"></div>
<div class="tableList downborder">
<a href="resetPass.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe736;</i>&nbsp;修改密码</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="space"></div>
<div class="tableList downborder">
<a href="shop_download.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe703;</i>&nbsp;下载中心</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<!-- <div class="tableList downborder">
<a href="secretReset.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe736;</i>&nbsp;交易密码</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div> -->
<%-- <div class="space"></div>
<button class="btn btn-danger btn-block" onclick="shopStatusOper(<%=shop.getShopstatus()==1?0:1%>)"><%=shop.getShopstatus()==1?"关闭店铺":"重新打开店铺" %></button> --%>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<style>
.detail span{font-weight: 400;color:#DC3C00;font-size: 1.8rem}
</style>
<script type="text/javascript">
document.getElementById("head_title").innerHTML="点商中心";
$("#top_back_button").html("<a class=\"react\"  style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;width:62px\"><i class=\"iconfont\" style=\"font-size:40px\">&#xe62f;</i></a>");
$("#top_qr_button").hide();
$("#top_search_button").hide();
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