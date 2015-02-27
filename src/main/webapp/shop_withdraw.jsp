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
 CashService cashSer = new CashServiceImpl();
 List<Cash> withdraws = cashSer.getLast20WithdrawList(user.getId());
 boolean haswithdraws = (withdraws.size() != 0);
 BindCardService cardServ=new BindCardServiceImpl();
 List<User2BindCard> cards=cardServ.getUser2Cards(user.getId());
 if(cards.size()==0) {
	 response.sendRedirect("shop_card_list.jsp");
	 return;
 }
/*  if(user.getSecret()==null){
	response.sendRedirect("secretSet.jsp");
	return;
}
if(request.getParameter("secretOK")==null||!request.getParameter("secretOK").equals("ok")){
	response.sendRedirect("inputSecretShop.jsp?subType=2");
	return;
} */
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:4.5rem;padding:0 .5rem !important"" id="content1">
<%if(null == user.getBank_account() || null == user.getBank_number()) { %>
	<input type="hidden" id="cnyadd"  value="1"/>			
	<%} %>
	<span id="withdraw_success_tips" class="bg-success" style="font-size: 14px;<%if(request.getParameter("success") == null){%>display:none;<%}%>">提交成功，我们会尽快处理，请耐心等待<%=MainConfig.getFrontSimpleName() %>的人工处理。
			<a class="" href="/withdrawCny.jsp">最新提现信息&gt;&gt;&gt;</a>
	</span>
</div>
<div class="container nomargin" style="background-color: #DC3C00;color:#fff;padding:2rem !important;margin-bottom: 0px !important;">
   <p><i class="iconfont">&#xe628;</i>金币(￥)<br><br><span class="bigFont" style="color: #fff" id="coin_left"></span></p>
   <!-- span -->
</div>
<div class="container" style="margin: 10px 0">
<div class="input-group">
  <span class="input-group-addon">提现金额</span>
  <input type="text" class="form-control"  id="withdrawBalance" name="withdrawBalance"  placeholder="请输入提现金额" onkeyup="value=value.replace(/[^0-9]/g,'')" onpaste="value=value.replace(/[^0-9]/g,'')" oncontextmenu = "value=value.replace(/[^0-9]/g,'')"/>
</div>
<div class="space_noborder"></div>
<div class="input-group" >
  <span class="input-group-addon">提现卡片</span>
  <select id="bankid" style="width:100% !important;height:3rem !important">
    <option value="0">请选择提现的银行卡</option>
    <%for(User2BindCard card:cards){%>
    <option value="<%=card.getBid()%>"><%=card.getBank_o()+"  "+FrontUtil.hiddenNum(card.getBank_account_o())+" "+card.getName() %></option>
    <%} %>
    </select>
</div>
<div class="space_noborder"></div>
  <input type="hidden" id="cnyOutType" name="cnyOutType" value="1"> 
  <input type="hidden" id="max_withdraw_amount" value="<%=MainConfig.getCashMaxWithdrawAmount() %>" />
  <input type="hidden" id="min_withdraw_amount" value="<%=MainConfig.getCashMinWithdrawAmount() %>" />
  <input type="hidden" id="cash_amount_decimal_precision" value="<%=MainConfig.getCashAmountMinDecimalPrecision() %>" />
  <input type="hidden" id="userBalance" value="0"/>
  <input type="hidden"  id="payeeAddr"  value="<%=user.getName() %>" readonly="readonly"/>
  <button type="button" class="btn btn-success  btn-block" onClick="javascript:submitWithdrawCnyForm();" id="withdrawCnyButton">申请提现</button>
</div>
<div class="space"></div>
<!-- form -->
<div class="tableList downborder">
<div class="detail">最近一个月提现记录</div>
</div>
<%for (Cash withdraw : withdraws) { %>
<div class="tableList downborder">
<div class="detail" style=><span><%=withdraw.getCtimeString() %></span><span>提现</span><span><%=FrontUtil.formatDouble(withdraw.getAmount()) %>元</span></div><div class="status"><span>
<%if (withdraw.getStatus() == 0) {%>
正在处理
<% }%>
<%if (withdraw.getStatus() == 1) {%>
取现成功
<% }%>
<%if (withdraw.getStatus() == 2) {%>
已拒绝
<% }%>
</span>
</div>
</div>
<%} %>
<%if (!haswithdraws) {%>
<div class="tableList downborder">
<div class="detail">暂无提现记录</div>
</div>
 <%} %> 
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script src="assets/scripts/chwl/account/index.js"		type="text/javascript"></script>
<style>
.downborder .detail{padding-left:5px;}
</style>
<script type="text/javascript">
document.getElementById("head_title").innerHTML="金币提现";
$("#top_back_button").html("<a class=\"react\" href=\"shop_profile.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
$("#top_qr_button").hide();
$("#top_search_button").hide();
</script>
<jsp:include page="updateProfileTimes.jsp"/>
</body>
</html>