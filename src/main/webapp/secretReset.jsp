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
 if(u.getSecret()==""||u.getSecret()==null){
	 response.sendRedirect("secretSet.jsp");
	 return;
 }
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
	<div class="container nomargin" style="padding: .5rem !important;">
    <input type="hidden" class="form-control" id="userId" value="<%=u.getId()%>">
  <div class="form-group">
    <label for="newPassword"><i class="iconfont">&#xe607;</i>&nbsp;&nbsp;原交易密码&nbsp;&nbsp;&nbsp;&nbsp;<span><a href="forgetSecret.jsp?resetType=2" style="color:red;width: 40px">忘记交易密码？</a></span></label>
    <input type="password" class="form-control" id="oldPassword" placeholder="请输入原交易密码">
  </div>
  <p id="msg0" style="color:red"></p>
  <div class="form-group">
    <label for="newPassword"><i class="iconfont">&#xe607;</i>&nbsp;&nbsp;新交易密码</label>
    <input type="password" class="form-control" id="newPassword" placeholder="不能与登录密码相同，不小于6位">
  </div>
  <p id="msg1" style="color:red"></p>
  <div class="form-group">
    <label for="newPassword2"><i class="iconfont">&#xe607;</i>&nbsp;&nbsp;再次输入交易密码</label>
    <input type="password" class="form-control" id="newPassword2" placeholder="再次输入">
  </div>
  <p id="msg2" style="color:red"></p>
  <button onclick="resetSecret()" class="btn btn-danger btn-block">确认修改</button><br>
	</div>
</div>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<script type="text/javascript" src="assets/scripts/chwl/user/index.js"></script>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="交易密码";
$("#top_qr_button").hide();
$("#top_search_button").hide();
</script>
</body>
</html>