<%@page import="java.net.URLEncoder"%>
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
 BindCardService cardServ=new BindCardServiceImpl();
 List<User2BindCard> cards=cardServ.getUser2Cards(user.getId());
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
</div>
<%if(cards.size()!=0){ 
for(User2BindCard card:cards){
	String forward="update_card_info.jsp?id="+card.getBid();
	//String forward="inputSecretShop.jsp?subType=3&forward="; 
	//String uri="update_card_info.jsp?id="+card.getBid();
	//forward+=URLEncoder.encode(uri); 
%>
<div class="tableList downborder card_list_div">
<a href="<%=forward %>" class="card_list"><div class="detail" style="padding-left: 1rem;width:100% !important;"><i class="iconfont">&#xe610;</i>&nbsp;&nbsp;<%=card.getBank_o()+"&nbsp;&nbsp;&nbsp;"+FrontUtil.hiddenNum(card.getBank_account_o()) %></div></a>
</div>
<%}}else{%>
<div class="tableList downborder card_list_div">
	<a href="#" class="card_list"><div class="detail" style="padding-left: 1rem"><i class="iconfont">&#xe610;</i>&nbsp;&nbsp;没有银行卡，请添加</div><div class="status"></div></a>
</div>
<%} %>
<div class="tableList downborder " style="background-color: #F0EFED">
<!-- <a href="inputSecret.jsp?subType=1" style="color:#666"><div class="detail" style="padding-left: 1rem"><i class="iconfont">&#xe64c;</i>&nbsp;&nbsp;添加银行卡</div></a> -->
<a href="input_card_num.jsp" style="color:#666"><div class="detail" style="padding-left: 1rem;color:#000"><div class="menu_icon"><img src="assets/images/iconfont-tianjia.png"></div>&nbsp;&nbsp;<div class="menu_title">添加银行卡</div></div></a>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="我的银行卡";
$("#top_back_button").html("<a class=\"react\" href=\"user_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
</script>
<style>
.card_list{color:#fff}
.card_list .status{color:ccc}
.card_list_div{background-color: #5DB755;border-radius:4px;margin:0px 1px;}
.card_list_div:hover{background-color: #70d268;}
</style>
<jsp:include page="updateProfileTimes.jsp"/>
</body>
</html>