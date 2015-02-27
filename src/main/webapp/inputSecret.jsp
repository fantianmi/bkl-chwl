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
if(u.getSecret()==""||u.getSecret()==null){
	 response.sendRedirect("secretSet.jsp");
	 return;
}
//subType为提交类型，1为绑定银行卡，2为提现
int subType=1;
if(request.getParameter("subType")!=null){
	subType=Integer.parseInt(request.getParameter("subType"));
}
String forward="";
if(subType==3){
	forward=request.getParameter("forward");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top_nobutton.jsp"/>
<div class="content" style="margin-top:5.5rem;padding:0rem 1rem 1rem 1rem !important">
<form action="" method="post" id="submitSecretOk">
    <input type="hidden" class="form-control" id="forward"  value="<%=forward%>">
    <input type="hidden" class="form-control" id="subType" name="1"  value="<%=subType%>">
    <input type="hidden" class="form-control" id="secretOK" name="secretOK"  value="">
  <div class="form-group">
    <label for="regUserName">请输入交易密码</label>
    <input type="password" class="form-control" id="secret" name="secret"  placeholder="安全校验，请输入交易密码"  onpaste="return false" >
  </div>
  </form>
<div class="space_noborder"></div>
  <a  class="btn btn-success  btn-block" href="javascript:void(0);" onclick="submitToInputCardNum()">确认</a>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="身份校验";
</script>

</body>
</html>