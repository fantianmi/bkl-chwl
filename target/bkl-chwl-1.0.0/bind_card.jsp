<%@page import="com.km.common.config.Config"%>
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
 User u=UserUtil.getCurrentUser(request);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>绑定银行卡</title>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<jsp:include page="right_menu.jsp"/>
<div class="content nopadding" style="margin-top:6.1rem " id="content1">
<div class="container">
<span style="color:red;" id="addrMsgSpan">&nbsp;</span>
<input id="outType" type="hidden" /> 
<input id="addressType" type="hidden" /> 
  <div class="form-group">
    <label for="bank_account"><i class="iconfont">&#xf0026;</i>&nbsp;&nbsp;银行</label>
    <% 
		List banks = Config.getList("config.cny.withdraw.bank");
	%>
    <select id="openBankTypeAddr" name="openBankType" style="height: 22px;" >
			<option value="-1">请选择银行类型</option>
			<%
				for(Object bank:banks) {
					String bankName = new String(bank.toString().getBytes("ISO-8859-1"),"UTF-8");
			%>
			<option value="<%=bankName%>"><%=bankName%> </option>
			<%	} %>
	</select>
  </div>
  <p id="addrMsgSpan"></p>
  <div class="form-group">
    <label for="withdrawAccountAddr"><i class="iconfont">&#xf0026;</i>&nbsp;&nbsp;账号</label>
    <input type="text" class="form-control" id="withdrawAccountAddr" name="withdrawAccount" placeholder="账号" oncopy="return false;" onpaste="return false" >
  </div>
  <div class="form-group">
    <label for="withdrawAccountAddr2"><i class="iconfont">&#xf0026;</i>&nbsp;&nbsp;再次输入账号</label>
    <input type="text" class="form-control"  id="withdrawAccountAddr2" style="color:grey;" maxlength="30" width="50px" onpaste="return false" oncopy="return false;"/>
  </div>
  <div class="form-group">
    <label for="payeeAddr"></label>
    <a href="https://www.hebbank.com/corporbank/otherBankQueryWeb.do" target="blank" style="margin-left:0px;color:red">银行卡开户行行号查询</a>
  </div>
  <div class="form-group">
    <label for="withdrawAccountAddr_bankNumber"><i class="iconfont">&#xf0026;</i>&nbsp;&nbsp;银行卡开户行行号</label>
    <input type="text" class="form-control"  id="withdrawAccountAddr_bankNumber" name="withdrawAccount" style="color:grey;" maxlength="30" width="50px" oncopy="return false;" onpaste="return false" />
  </div>
  <div class="form-group">
    <label for="withdrawAccountAddr2_bankNumber"><i class="iconfont">&#xf0026;</i>&nbsp;&nbsp;请再次输入银行卡开户行行号</label>
    <input type="text" class="form-control"  id="withdrawAccountAddr2_bankNumber" style="color:grey;" maxlength="30" width="50px" onpaste="return false" oncopy="return false;"/>
  </div>
  <div class="form-group">
    <label for="payeeAddr"><i class="iconfont">&#xf0026;</i>&nbsp;&nbsp;收款人姓名</label>
    <input type="text" class="form-control" id="payeeAddr" name="payee" value="<%=u.getName() %>"/>
  </div>
  <button type="button" class="btn btn-success  btn-block" onclick="submitWithdrawCnyAddress()">确认绑定</button>
</div>
</div>
<script type="text/javascript" src="assets/scripts/chwl/account/index.js?rand=20140503b"></script>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="绑定银行卡";
</script>
</body>
</html>