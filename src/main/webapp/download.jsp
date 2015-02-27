<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String uri="";
if(request.getParameter("downloadUrl")!=null){
	uri=request.getParameter("downloadUrl");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="common_source_head.jsp"/>
</head>
<body>
<jsp:include page="top_nobutton.jsp"/>
<script type="text/javascript">
document.getElementById("head_title").innerHTML="下载";
</script>
<div class="weixin_alert" id="weixin_alert" onclick="hideWeixinAlert();">
<img src="assets/images/weixin_alert.png">
</div>
<script type="text/javascript">
function hideWeixinAlert(){
	$("#weixin_alert").hide();
	return;
}
$(document).ready(function(){
	if(isWeixinBrowser()){
		$("#weixin_alert").show();
	}else{
		window.location.href="<%=uri%>";
	}
});

function isWeixinBrowser(){
    var ua = navigator.userAgent.toLowerCase();
    return (/micromessenger/.test(ua)) ? true : false ;
}
</script>
</body>
</html>