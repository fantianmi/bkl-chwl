<%@page import="java.net.URLEncoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="com.km.common.config.Config"%>
 <%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<%
if(request.getParameter("id")==null){
	response.sendRedirect("user_card_list.jsp");
	return;
}
long id=Integer.parseInt(request.getParameter("id"));
BindCardService bindCardServ= new BindCardServiceImpl();
User2BindCard card=bindCardServ.getUser2Card(id);

//String url=MainConfig.getContextPath();   
//url=url.substring(0,url.length()-1);
//url+=request.getRequestURI();    
//if(request.getQueryString()!=null)    
//url+="?"+request.getQueryString(); 
//url=URLEncoder.encode(url);
//if(request.getParameter("secretOK")==null||!request.getParameter("secretOK").equals("ok")){
//	response.sendRedirect("inputSecretShop.jsp?subType=3&forward="+url);
//	return;
//}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top_nobutton.jsp"/>
<div class="content" style="margin-top:5.5rem;padding:0rem 1rem 1rem 1rem !important">
  <div class="form-group">
  	<% 
		List banks = Config.getList("config.cny.withdraw.bank");
	%>
    <label for="bank_o" >卡类型</label><br>
    <select id="bank_o">
    <option value="0">请选择银行</option>
    <%
		for(Object bank:banks) {
			String bankName = new String(bank.toString().getBytes("ISO-8859-1"),"UTF-8");
	%>
		<option value="<%=bankName%>" <%=bankName.equals(card.getBank_o())?"selected=\"selected\"":""%>><%=bankName%></option>
	<%	} %>
    </select>
  </div>
</div>
<div class="space"></div>
<div class="content" style="padding:0rem 1rem 1rem 1rem !important">
  <input type="hidden" id="isdefault" value="<%=card.getIsdefault()%>">
  <input type="hidden" class="form-control" id="bid" value="<%=card.getBid()%>" >
  <input type="hidden" class="form-control" id="uid" value="<%=card.getId()%>" >
 <div class="form-group">
    <label for="bank_account_o">卡号</label>
    <input type="text" class="form-control" id="bank_account_o" value="<%=card.getBank_account_o() %>" placeholder="卡号">
  </div>
 <div class="form-group">
    <label for="bank_deposit_o">开户行</label>
    <input type="text" class="form-control" id="bank_deposit_o" placeholder="请输入您的开户行" value="<%=card.getBank_deposit_o()%>">
  </div>
  <input type="hidden" class="form-control" id="withdrawAccountAddr_bankNumber" value="<%=card.getBank_number_o()%>" placeholder="请输入您的开户行行号" onkeyup="value=value.replace(/[^\0-9\.]/g,'')" onpaste="value=value.replace(/[^\0-9\.]/g,'')" oncontextmenu = "value=value.replace(/[^\0-9\.]/g,'')">
  <div class="form-group">
    <label for="phone_o">手机号</label>
    <input type="text" class="form-control" id="phone_o" placeholder="请输入银行预留手机号"  value="<%=card.getPhone_o()%>">
  </div>
<div class="space_noborder"></div>
  <button  class="btn btn-success  btn-block" onclick="bindCardFullUpdateSubmit()">提交修改</button><br>
  <button  class="btn btn-danger  btn-block" onclick="cardDelete(2)">删除该卡</button><br>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
	document.getElementById("head_title").innerHTML="银行卡信息";
</script>
<!-- drop box -->
<style>
select {
font-size: 1.4rem !important;
width: 60% !important;
padding: .45rem !important;
height: 2.5rem !important;
}
</style>
<!-- drop box -->
</body>
</html>