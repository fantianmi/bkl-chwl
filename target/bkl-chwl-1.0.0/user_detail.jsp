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
 String url = MainConfig.getContextPath();
 String recomendURL=url+"reg.jsp?r="+u.getId();
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>资料管理</title>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5rem" id="content1">
<div class="tableList downborder" style="height:7rem !important;">
<div class="detail" style="padding-left: 1rem"><div class="menu_list_user" style="margin-top:0rem"><%=u.getMobile() %><br>&nbsp;编号<%=u.getId() %></div></div><div class="status" style="height:7rem;padding:0rem;"><div class="menu_list_headicon" style="float:right"><img src="assets/images/headicon.jpg"></div></div>
</div>
<div class="space"></div>
<div class="tableList downborder">
<a href="info_update.jsp?t=nickname"><div class="detail" style="padding-left: 1rem">昵称</div><div class="status"><%=u.getNick_name()==""?"未设置":u.getNick_name() %><span id="coin_left"></span>&nbsp;&nbsp;<i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="javascript:showQrCode();"><div class="detail" style="padding-left: 1rem">我的二维码</div><div class="status"><i class="iconfont">&#xe6b0;</i><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="resetPass.jsp" ><div class="detail" style="padding-left: 1rem">密码管理</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="tableList downborder">
<a href="user_share.jsp"><div class="detail" style="padding-left: 1rem">分享管理</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="space"></div>
<div class="tableList downborder">
<div class="detail" style="padding-left: 1rem">注册时间</div><div class="status"><%=u.getCtimeString() %></div>
</div>
</div>
<jsp:include page="foot.jsp"/>
<div id="qrCode" style="display:none">
	<div class="container">
		<div class="row">
			<div class="col-xs-12">
				<div id="qrCodeShow"></div>
			</div>
		</div>
		<div class="space_noborder"></div>
		<div class="row">
			<div class="col-xs-12" style="text-align: center">
			<button class="btn btn-success" style="width:256px" onclick="closeQrCode()">关闭</button>
			</div>
		</div>
	</div>
</div>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="个人资料";
$("#top_back_button").html("<a class=\"react\" href=\"user_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>返回</a>");
</script>
<script src="assets/scripts/chwl/user/jquery.qrcode.min.js"></script>
<script type="text/javascript">
jQuery(function(){
	jQuery('#qrCodeShow').qrcode("<%=recomendURL%>");
});
function showQrCode(){
	$("#qrCode").show();
	return;
}
function closeQrCode(){
	$("#qrCode").hide();
	return;
}

</script>
<!-- page special  -->
<script type="text/javascript" src="assets/scripts/chwl/clipboard/ZeroClipboard.js"></script>
<script type="text/javascript"> 
function initClipboard() {
	ZeroClipboard.setMoviePath("ZeroClipboard.swf");
	var clip = new ZeroClipboard.Client();
	clip.setHandCursor(true);
	clip.addEventListener('mouseOver', function() {
		var value = document.getElementById("copied").value;
		clip.setText(value);
	});
	clip.glue("copy");
}
</script>
	<!-- page special  -->
<style>
.menu_list_headicon{
	float:left;
	height:6rem;
	width:6rem;
}
.menu_list_user{height:6rem;padding:1rem;float:left;}
.menu_list_headicon img{width:100% !important;}
.downborder a{color:#000;}
.detail{width:50% !important;padding: .5rem 1rem !important;}
.status{width:50% !important;text-align: right;padding-right: 1rem !important;}
.status .iconfont{color:#ccc;}
.status{color:#666}
.menuicon{font-size:20px;color:#12A0D7}
#qrCodeShow{text-align: center}
#qrCode{position: absolute;top:6.5rem;width:80%;background: rgba(0,0,0,0.9);padding:5rem 0rem 2rem 0rem;box-shadow: 0 1px 10px rgba(0,0,0,.5);-moz-user-select: none;left:10%}
</style>
</body>
</html>