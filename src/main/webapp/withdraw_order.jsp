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
 User user=UserUtil.getCurrentUser(request);
 BindCardService cardServ=new BindCardServiceImpl();
 List<User2BindCard> cards=cardServ.getUser2Cards(user.getId());
 if(cards.size()==0) {
	 response.sendRedirect("bind_card.jsp");
	 return;
 }
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>提现</title>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:4.5rem " id="content1">
	<%if(null == user.getBank_account() || null == user.getBank_number()) { %>
	<input type="hidden" id="cnyadd"  value="1"/>			
	<%} %>
	<span id="withdraw_success_tips" class="bg-success" style="font-size: 14px;<%if(request.getParameter("success") == null){%>display:none;<%}%>">提交成功，我们会尽快处理，请耐心等待<%=MainConfig.getFrontSimpleName() %>的人工处理。
			<a class="" href="/withdrawCny.jsp">最新提现信息&gt;&gt;&gt;</a>
	</span>
	<div class="container nomargin" style="background-color: #DC3C00;color:#fff;padding:2rem !important;margin-bottom: 0px !important;">
    <p><i class="iconfont">&#xe628;</i>金币(￥)<br><br><span class="bigFont" style="color: #fff" id="coin_left"></span></p>
	</div>
	<!-- form -->
	<div class="container">
	  <div class="form-group">
	    <label for="exampleInputEmail1">&nbsp;</label>
	    <input type="text" class="form-control"  id="withdrawBalance" name="withdrawBalance"  placeholder="请输入提现金额"/></span>&nbsp;&nbsp;<span class="fred" id="withdrawAmountTips"></span>
	  </div>
	  <div class="form-group">
	    <label for="bankid">&nbsp;</label>
	    <select id="bankid" style="width:100% !important">
	    <option value="0">请选择提现的银行卡</option>
	    <%for(User2BindCard card:cards){%>
	    <option value="<%=card.getBid()%>"><%=card.getBank_o()+"  "+FrontUtil.hiddenNum(card.getBank_account_o())+" "+card.getName() %></option>
	    <%} %>
	    </select>
	  </div>
	  <input type="hidden" id="cnyOutType" name="cnyOutType" value="1"> 
	  <input type="hidden" id="min_withdraw_amount" value="<%=MainConfig.getCashMinWithdrawAmount() %>" />
	  <input type="hidden" id="cash_amount_decimal_precision" value="<%=MainConfig.getCashAmountMinDecimalPrecision() %>" />
	  <input type="hidden" id="userBalance" value="0"/>
	  <input type="hidden"  id="payeeAddr"  value="<%=user.getName() %>" readonly="readonly"/>
	  <button type="button" class="btn btn-success  btn-block" onClick="javascript:submitWithdrawCnyForm();" id="withdrawCnyButton">确认</button>
	</div>
	<!-- form -->
</div>

 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="人民币提现";
</script>
<script type="text/javascript" src="assets/scripts/chwl/account/index.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	queryUserProfile_special();
	setInterval("queryUserProfile()",10000);
});
function queryUserProfile_special(){
	var url="/api/user/getProfile?random="+Math.round(Math.random()*100);
	$.get(url,function(res){
		if(res){
			if(res.ret==0){
				if($("#coin_left")){
					$("#coin_left").html(res.data["coin"]);
				}
				$("#userBalance").val(res.data["coin"]);
			}
		}
	});
}
</script>
</script>
</body>
</html>