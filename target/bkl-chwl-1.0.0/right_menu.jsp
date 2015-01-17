<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.km.common.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
boolean islogin = UserUtil.islogin(request);
User user = null;
if (islogin) {
	  user = UserUtil.getCurrentUser(request);
}
String forwardUrl = request.getParameter("forward");
if (forwardUrl == null) {
	forwardUrl = "";
}
%>	
<div class="drawer-toggle drawer-hamberger" style="top:0px;z-index:2000;padding: 6px 10px"><div class="left_menu_title"><%=user!=null?"菜单":"登录" %></div></div>
<div class="drawer-main drawer-default" style="z-index: 2000;">
  <nav class="drawer-nav" role="navigation">
  	<%if(islogin){ %>
    <div class="drawer-brand">
      <a href="#">欢迎，<%=user.getName()!=""?user.getName():user.getMobile() %></a>
    </div>
    <p class="btn btn-info " style="width:80%; margin-left: 10%;margin-bottom: 10px;font-size: 30px" onclick="scanQR()"><i class="iconfont lg" style="color:#fff">&#xe6fb;</i>支付</p>
    
    <p class="drawer-nav-title">引导</p>
    <ul class="drawer-nav-list">
      <li style="border-top: .1rem solid #000;"><a href="index.jsp">首页</a></li>
    </ul>
    <%if(user.getRole()==user.ROLE_NORMAL){ %>
    <p class="drawer-nav-title">用户中心</p>
    <ul class="drawer-nav-list">
      <li style="border-top: .1rem solid #000;"><a href="user_index.jsp">资产情况</a></li>
      <li><a href="user_bouns_list.jsp">钱袋查看</a></li>
      <li><a href="user_order.jsp">消费查看</a></li>
      <li><a href="user_fans_list.jsp">粉丝查看</a></li>
      <li><a href="user_detail.jsp">资料管理</a></li>
      <li><a href="user_collect.jsp">我的收藏</a></li>
    </ul>
    <%} %>
    <%if(user.getRole()==user.ROLE_SHOPER){ %>
	    <p class="drawer-nav-title">商家中心</p>
	    <ul class="drawer-nav-list">
	      <li style="border-top: .1rem solid #000;"><a href="shop_index.jsp">商家首页</a></li>
	      <%if(user.getVertify()==user.VERTIFY_TRUE){ %>
	      <li style="border-top: .1rem solid #000;"><a href="shop_info.jsp">管理店铺</a></li>
	      <li><a href="shop_deal_list.jsp">交易记录</a></li>
	      <%} %>
	    </ul>
    <%}%>
    <p class="btn btn-danger " style="width:80%;margin-left: 10%" onclick="loginout()">退出登录</p>
    <p class="drawer-nav-title">&nbsp;</p>
    <%}else{ %>
    <p class="drawer-nav-title">您还没有登录~</p>
    <ul class="drawer-nav-list">
      <li style="border-top: .1rem solid #000;"><a href="login.jsp">马上登录</a></li>
      <li><a href="reg.jsp">马上注册</a></li>
    </ul>
    <%} %>
  </nav>
</div>
<style>
.left_menu_title{
color:#fff;
font-size:1.2rem;
padding:1.4rem 1rem;
background-color: transparent;
height:4rem;
border-radius:5px;
border:1px solid #ccc;
transition: color 2s, background-color 2s,border 2s, transform 2s;
-moz-transition: color 2s, background-color 2s,border 2s, -moz-transform 2s;
-webkit-transition: color 2s, background-color 2s,border 2s, -webkit-transform 2s;
-o-transition: color 2s, background-color 2s,border 2s,-o-transform 2s;
}
.left_menu_title:hover{
color: #ccc;
background-color: #222222;
border:1px solid #222222;
}
</style>
