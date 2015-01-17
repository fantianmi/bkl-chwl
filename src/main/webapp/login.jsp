<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
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
    <label for="loginUserName"><i class="iconfont">&#xf0026;</i>&nbsp;&nbsp;手机号</label>
    <input type="text" class="form-control" id="loginUserName" placeholder="手机号">
  </div>
  <div class="form-group">
    <label for="loginPassword"><i class="iconfont">&#xe607;</i>&nbsp;&nbsp;密码</label>
    <input type="password" class="form-control" id="loginPassword" placeholder="登录密码">
  </div>
  <!-- <div class="checkbox">
    <label>
      <a href="#">忘记密码？</a>
    </label>
  </div> -->
  <button onclick="loginSubmit()" class="btn btn-success  btn-block">登录</button><br>
  <button type="button" class="btn btn-default  btn-block" onclick="javascript:location.href='reg.jsp'">注册</button>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="登录";
</script>
<!-- page special -->
</body>
</html>