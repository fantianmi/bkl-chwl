<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%String page_url = request.getServletPath();%>
<%
boolean profile=false;
boolean tradeorder=false;
boolean fans=false;
boolean user_collect=false;
boolean user_detail=false;
boolean user_withdraw=false;
if (page_url.indexOf("/user_index.jsp") != -1) {
	profile = true;
} else if (page_url.indexOf("/user_order.jsp") != -1){
	tradeorder = true;
} else if (page_url.indexOf("/user_fans_list.jsp") != -1){
	fans = true;
 }else if (page_url.indexOf("/user_collect.jsp") != -1){
	 user_collect = true;
}else if (page_url.indexOf("/user_detail.jsp") != -1){
	user_detail = true;
}else if(page_url.indexOf("/user_withdraw.jsp")!=-1){
	user_withdraw=true;
}
%>
<div class="container nomargin nopadding">
<ul class="menu-list" id="user_index_menu">
<a href="user_index.jsp"><li class="<%=profile?"activeli":""%>">资产</li></a>
<a href='user_order.jsp'><li class="<%=tradeorder?"activeli":""%>" >消费</li></a>
<a href='user_fans_list.jsp'><li class="<%=fans?"activeli":""%>" >粉丝</li></a>
<a href='user_collect.jsp'><li class="<%=user_collect?"activeli":""%>">收藏</li></a>
<a href='user_detail.jsp'><li class="<%=user_detail?"activeli":""%>" >资料</li></a>
<a href='doLottery.jsp'><li>抽奖</li></a>
<a class="" href='user_withdraw.jsp'><li class="<%=user_withdraw?"activeli":""%>" >提现</li></a>
</ul>
</div>
<style>
#user_index_menu{width:100%;height:4rem}
#user_index_menu li{
text-align:center;
font-size:1.2rem;
background-color:#F0EFED;
width:14.28%;height:4rem;
margin:0 !important;
padding: 16px 0px;
box-shadow: 0 0 5px 0 rgba(0,0,0,.2);
     -moz-user-select: none;
}
#user_index_menu li:hover{
background-color:#000;
color:#fff;
}
.activeli{
background-color:#000 !important;
color:#fff;}
</style>