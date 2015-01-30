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
 ShopService shopServ=new ShopServiceImpl();
 Shop shop=shopServ.getByUid(user.getId());
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
<%if(user.getRole()==user.ROLE_SHOPER&&shop.getRegstatus()==shop.REGSTATUS_FALSE){ %>
<div class="alert alert-warning" role="alert"><span class="label label-danger">重要</span>您是商家，请完善【完整资料】中的资料，才能在平台中展示</div>
<%} %>
<%if(shop.getVertifystatus()==shop.VERTIFYSTATUS_FALSE){ %>
<div class="alert alert-warning" role="alert"><span class="label label-danger">重要</span>您的店铺已被管理员禁用，无法在平台继续显示，请联系管理员申诉或重新开通</div>
<%} %>
<div class="container nomargin" style="background-color: #DC3C00;color:#fff;padding:2rem !important;margin-bottom: 0px !important;">
  <p><i class="iconfont">&#xe623;</i>结账总额(￥)<br><br><span class="bigFont" style="color: #fff"><%=FrontUtil.formatRmbDouble(total) %></span></p>
</div>
</div>
<div class="container nomargin" style="color:#666;padding:2rem !important;margin-top: 0rem !important;">
<ul class="profitshow">
<li>当日结账额<br><B><%=FrontUtil.formatRmbDouble(day) %></B></li>
<li>当月结账额<br><B><%=FrontUtil.formatRmbDouble(month) %></B></li>
<li>三个月结账额<br><B><%=FrontUtil.formatRmbDouble(month3) %></B></li>
</ul>
</div>
<div class="space"></div>
<div class="tableList downborder">
<a href="shop_profile.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe628;</i>&nbsp;我的金币数</div><div class="status"><span id="coin_left"></span>&nbsp;&nbsp;<i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="shop_data.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe62f;</i>&nbsp;审核资料</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="shop_info.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe683;</i>&nbsp;完整资料</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="shop_deal_list.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe624;</i>&nbsp;结账详情</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="shop_card_list.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe6b3;</i>&nbsp;我的银行卡</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="bind_mobile.jsp"><div class="detail" style="padding-left: 1rem"><i class="iconfont menuicon">&#xe6b3;</i>&nbsp;绑定手机号</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
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