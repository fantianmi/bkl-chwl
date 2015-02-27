<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
 <%
 User u=UserUtil.getCurrentUser(request);
 if(u!=null){
 	if(u.getRole()==u.ROLE_NORMAL){
 		response.sendRedirect("user_index.jsp");
 		return;
 	}else{
 		response.sendRedirect("shop_index.jsp");
 		return;
 	}
 }
 String forwardUrl = request.getParameter("forward");
 if (forwardUrl == null) {
 	forwardUrl = "";
 }
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top_nobutton.jsp"/>
<input type="hidden" id="forwardUrl" value="<%=forwardUrl%>">
<div class="content" style="margin-top:5.2rem;padding:1rem !important; ">
  <p style="display: none" id="loginTips" class="bg-danger"></p>
  <div class="form-group">
    <label for="loginUserName"><i class="iconfont">&#xf0026;</i>&nbsp;&nbsp;账号</label>
    <input type="text" class="form-control" id="loginUserName" placeholder="点粉账号/点商账号">
  </div>
  <div class="form-group">
    <label for="loginPassword"><i class="iconfont">&#xe607;</i>&nbsp;&nbsp;密码</label>
    <input type="password" class="form-control" id="loginPassword" placeholder="登录密码">
  </div>
 <div class="checkbox">
    <label>
      <a href="forgetPass.jsp">忘记密码？</a>
    </label>
  </div>
  <button onclick="loginSubmit()" class="btn btn-success  btn-block">登录</button><br>
  <button type="button" class="btn btn-danger  btn-block" onclick="javascript:location.href='reg.jsp'">注册</button>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="登录";
$("#top_back_button").html("<a class=\"react\" href=\"index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
</script>
<!-- page special -->
</body>
</html>