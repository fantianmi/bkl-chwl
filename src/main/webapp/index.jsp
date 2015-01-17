<%@page import="com.bkl.chwl.vo.UserListEntity"%>
<%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="com.bkl.chwl.vo.*"%>   
<%@page import="java.util.*"%>
<%
UserService userServ=new UserServiceImpl();
int userNum=userServ.countUser(1);
int shopNum=userServ.countUser(2);
User u = UserUtil.getCurrentUser(request);
double consume=0;
double profile=0;
if(u!=null){
	if(u.getRole()==u.ROLE_SHOPER){
		response.sendRedirect("shop_index.jsp");
		return;
	}
	UserListEntity userListEntity=ApiCommon.getRecommendUserList(u.getId(), 1, 1, 100);
	userNum=userListEntity.getTotal();
	UserListEntity userListEntity2=ApiCommon.getRecommendUserList(u.getId(), 1, 2, 100);
	shopNum=userListEntity.getTotal();
	OrderService orderServ=new OrderServiceImpl();
	consume=orderServ.getSUM(u.getId());
	UserProfile userProfile=ApiCommon.getUserProfile(u.getId());
	profile=userProfile.getCoin();
}

%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
	<!-- slider -->
	<link href="assets/slider/movie/css/css.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="assets/slider/movie/js/zzsc.js"></script>
</head>
<body class="drawer drawer-right">
<style>
#searchbar{color:#3B4043; font-size: 20px}
.logo-home{margin: 0 10px 0 0}
.topfont{color:#3B4043; font-size: 14px;}
.circle{border-radius:50px;padding: 3px 10px}
.back{border:1px solid #000;color:#000 !important;padding:1px 1rem;margin:.6rem 1rem;height:3rem !important;line-height: 3rem;border-radius:5px;
}
.back:hover{
color: #fff !important;
background-color: #222222;
border: 1px solid #222222;}

.left_menu_title {
color: #000 !important;
background-color: transparent;
border: 1px solid #000 !important;
}
.left_menu_title:hover {
color: #fff !important;
}
</style>
<!-- Fixed navbar -->
  <div class="container" style="margin-bottom: 0px;background-color: #fff;box-shadow: 0 0 0 rgba(0,0,0,.7) !important; border-color: #fff !important">
    <div class="navbar-header" style="margin:0;width:100%">
    	<div class="nav-wrap-left">
            <%=u!=null?"<a class=\"react back\" href=\"user_index.jsp\">账本</a>":"<a class=\"react back\" href=\"login.jsp\">登录</a>"%>
        </div>
        <div class="nav-wrap-left" style="float: right !important;">
            <%=u!=null?"<a class=\"react back\" href=\"javascript:loginout();\">退出</a>":"<a class=\"react back\" href=\"reg.jsp\">注册</a>"%>
        </div>
    </div>
  </div>
<div class="content" style="margin:0px 0px 15px 0px">
	<div class="index_headicon"><img src="<%=u!=null?"assets/images/headicon.jpg":"assets/images/index_pic.jpg" %>"></div>
	<%if(u!=null){ %>
	<div class="index_user_info" style="text-align: center;"><h5><%=u.getNick_name()!=null&&u.getNick_name()!=""?u.getNick_name():u.getMobile() %><br>编号:<%=u.getId() %></h5></div>
    <div class="index_user_info" style="text-align: center;font-size: 1.4rem">
 	 <div class="left">花了：</div><div class="right">￥<%=FrontUtil.formatRmbDouble(consume) %></div>
   	 <div class="left"> 赚了：</div><div class="right">￥<%=FrontUtil.formatRmbDouble(profile) %></div>
	</div>
	<%}else{ %>
		<div class="index_user_info" style="text-align: center;height:120px !Important"><h5>请点头财神入手机<br>一旦使用，一生爱用<br><br>More Shopping, More Money</h5></div>
	<%} %>   
	<div class="row index_icon">
   	<div class="icon-list"><a href="shop_list.jsp?shop_type=86">丽人</a></div>
   	<div class="icon-list"><a href="shop_list.jsp?shop_type=4">娱乐</a></div>
   	<div class="icon-list"><a href="shop_list.jsp?shop_type=24">电影</a></div>
   	<div class="icon-list"><a href="shop_list.jsp?shop_type=6">酒店</a></div>
   	<div class="icon-list"><a href="shop_list.jsp?shop_type=9">景点</a></div>
   	<div class="icon-list"><a href="shop_list.jsp?shop_type=31">购物</a></div>
   	<div class="icon-list"><a href="shop_list.jsp?shop_type=3">美食</a></div>
   	<div class="icon-list"><a href="shop_list.jsp">全部</a></div>
   	</div>
</div>
<div class="container">
<a class="btn btn-success btn-block btn-lg" onclick="scanQR()" href="javascript:void(0);">扫码支付</a>
</div>
<jsp:include page="foot.jsp"></jsp:include>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>

<style>
.index_headicon{width:100px;height:100px;margin: 0 auto;overflow: hidden;}
.index_headicon img{width:100%;}
.index_icon{margin:0 auto;width:320px;}
.icon-list{
width:80px !important; margin:0 !important;
height:80px;
padding:5px;
}
.icon-list a{
text-align: center;
color:#fff;
background-color: #4D545C !important;
width:70px;
height:70px;
font-size: 16px;
padding:27px 10px;
}
.icon-list a:hover{
border-radius:0px;
text-align: center;
color:#fff;
background-color:#000 !important;
width:70px;
height:70px;
}
body{
background-color: #fff !important;
}
.welcome-text h5 {
color: #fff;
}
.container2{
font: 14px/1.5 arial,"Microsoft Yahei","Hiragino Sans GB",sans-serif;
margin:1rem 0rem;padding: 1rem;font-size: 1.4rem;color:#000;height:5rem;
}
.container2 .leftarea{float:left;width:48%;margin-right: 4%;height:2rem;font: 1.4rem/1.5 arial,"Microsoft Yahei","Hiragino Sans GB",sans-serif; text-align: right}
.container2 .rightarea{float:left;width:48%;height:2rem;font: 1.4rem/1.5 arial,"Microsoft Yahei","Hiragino Sans GB",sans-serif; text-align: left}
.container2 .number{font-size: 2.0rem;color:#D24955;font-weight: 0 !important;font: 2.5rem/1.5 arial,"Microsoft Yahei","Hiragino Sans GB",sans-serif;}
</style>
<!-- wechat -->
<%
String url=MainConfig.getContextPath()+request.getServletPath().substring(1, request.getServletPath().length());
Weixin weixin=WeixinApi.getWeixin();
String timestamp="";
String nonceStr="";
String signatuure="";
if(weixin!=null){
	Map<String,String> sign=Sign.sign(weixin.getTicket(), url);
	timestamp=sign.get("timestamp");
	nonceStr=sign.get("nonceStr");
	signatuure=sign.get("signature");
}
String recommendURL=MainConfig.getContextPath()+"reg.jsp";
if(u!=null){
	recommendURL+="?r="+u.getId();
}

%>
<button style="display: none" id="scanQRCode"></button>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
wx.config({
    debug: true,
    appId: '<%=MainConfig.getWechatappid()%>', // 必填，公众号的唯一标识
    timestamp: <%=timestamp%>, // 必填，生成签名的时间戳
    nonceStr: '<%=nonceStr%>', // 必填，生成签名的随机串
    signature: '<%=signatuure%>',// 必填，签名，见附录1
    jsApiList: [
                'checkJsApi',
                'onMenuShareTimeline',
                'onMenuShareQQ',
                'onMenuShareWeibo',
                'scanQRCode',
              ]
	});
	wx.ready(function () {
		document.querySelector('#scanQRCode').onclick = function () {
		    wx.scanQRCode({
		      desc: 'scanQRCode desc',
		      success: function () { 
		      },
		      cancel: function () { 
		          window.location.href="scanQR.jsp";
		      }
		    });
		  };
		var shareData = {
			    title: '点头财神',
			    desc: '一款线下面对面消费结账APP',
			    link: '<%=recommendURL%>',
			    imgUrl: 'http://mmbiz.qpic.cn/mmbiz/icTdbqWNOwNRt8Qia4lv7k3M9J1SKqKCImxJCt7j9rHYicKDI45jRPBxdzdyREWnk0ia0N5TMnMfth7SdxtzMvVgXg/0'
			  };
		  wx.onMenuShareAppMessage(shareData);
		  wx.onMenuShareTimeline(shareData);
	});

	

	wx.error(function (res) {
	});
</script>
</body>
</html>