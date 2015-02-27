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
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5rem" id="content1">
	<div class="tableList downborder" style="background-color:#F0EFED;color:#FF3556;font-weight:800;font-size:18px;border-bottom-color: #F0EFED">
	<div class="detail" style="padding-left: 1rem;">发展粉丝</div>
	</div>
	<div class="tableList downborder">
	<div class="detail" style="padding-left: 1rem">方式1：好友扫码分享</div>
	</div>
	<div class="space_noborder_xs"></div>
	<div id="qrcode" style="text-align: center"></div>
	<div class="space_noborder_xs"></div>
	<div class="tableList downborder">
	<div class="detail" style="padding-left: 1rem">方式2：复制内容手动分享</div>
	</div>
	<div class="space_noborder_xs"></div>
	<div class="input-group input-group" style="width:90%;margin:0 auto">
	<textarea class="form-control" rows="3" >分享我吧<%=recomendURL%></textarea>
	</div>
	<div class="space_noborder_xs"></div>
	<div class="tableList downborder">
	<div class="detail" style="padding-left: 1rem">方式3：点击按钮分享</div>
	</div>
	<div class="space_noborder_xs"></div>
	<!-- share button -->
	<div class="bdsharebuttonbox" style="padding-left: 1rem">
	<a href="#" class="bds_more" data-cmd="more"></a>
	<a href="#" class="bds_qzone" data-cmd="qzone" title="分享到QQ空间"></a>
	<a href="#" class="bds_tsina" data-cmd="tsina" title="分享到新浪微博"></a>
	<a href="#" class="bds_tqq" data-cmd="tqq" title="分享到腾讯微博"></a>
	<a href="#" class="bds_renren" data-cmd="renren" title="分享到人人网"></a>
	</div>
	<script>
	window._bd_share_config=
	{
			"common":{
				"bdSnsKey":{},
				"bdText" : '功能测试，勿点！',	
				"bdDesc" : '点头付，让您的生活更实惠，注册成为我们的会员，体验意想不到的消费体验！',	
				"bdUrl" : '<%=recomendURL%>', 	
				"bdPic" : 'http://ww1.sinaimg.cn/large/005yyi5Jjw1ennhvaaic9j308c02sdft.jpg',	
				"bdMini":"2",
				"bdMiniList":false,
				"bdStyle":"2",
				"bdSize":"32"
				},
			"share":{},"image":{"viewList":["qzone","tsina","tqq","renren","weixin"],"viewText":"分享到：","viewSize":"16"},
			"selectShare":{"bdContainerClass":null,"bdSelectMiniList":["qzone","tsina","tqq","renren","weixin"]}};
	with(document)0[(getElementsByTagName('head')[0]||body).appendChild(createElement('script')).src='http://bdimg.share.baidu.com/static/api/js/share.js?v=89860593.js?cdnversion='+~(-new Date()/36e5)];</script>
	<!-- share button -->
	</div>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="分享管理";
</script>
<script src="assets/scripts/chwl/user/jquery.qrcode.min.js"></script>
<script type="text/javascript">
jQuery(function(){
jQuery('#qrcode').qrcode("<%=recomendURL%>");
})
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
</body>
</html>