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
 User user = UserUtil.getCurrentUser(request);
 CashService cashSer = new CashServiceImpl();
 List<Cash> withdraws = cashSer.getLast20WithdrawList(user.getId());
 boolean haswithdraws = (withdraws.size() != 0);
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:4.5rem " id="content1">
<div class="container nomargin" style="background-color: #DC3C00;color:#fff;padding:2rem !important;margin-bottom: 0px !important;">
  <p><i class="iconfont">&#xe628;</i>金币(￥)<br><br><span class="bigFont" style="color: #fff" id="coin_left"></span></p>
</div>
<div class="space"></div>
<div class="tableList downborder">
<div class="detail" style="padding-left: 1rem">锁定粉丝收益（<span id="ruser_num"></span>）</div><div class="status"><span  style="color:#666" id="other_get"></span></div>
</div>
<div class="tableList downborder">
<!-- <a href="inputSecretShop.jsp?subType=2"><div class="detail" style="padding-left: 1rem">提现记录</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a> -->
<a href="shop_withdraw.jsp"><div class="detail" style="padding-left: 1rem">提现记录</div><div class="status"><i class="iconfont">&#xe6a3;</i></div></a>
</div>
<div class="space"></div>
<!-- <a class="btn btn-success btn-block" href="inputSecretShop.jsp?subType=2">我要提现</a> -->
<a class="btn btn-success btn-block" href="shop_withdraw.jsp">我要提现</a>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<style>
.detail span{font-weight: 400;color:#DC3C00;font-size: 1.8rem}
</style>
<script type="text/javascript">
document.getElementById("head_title").innerHTML="我的金币";
$("#top_back_button").html("<a class=\"react\" href=\"shop_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
$("#top_qr_button").hide();
$("#top_search_button").hide();
var url="/api/user/getUserProfile?random="+Math.round(Math.random()*100);
$.get(url,function(res){
	if(res){
		if(res.ret==0){
			 $("#discount_get").html(res.data["discount_get"]);
			 $("#other_get").html(res.data["other_get"]);
		}
	}
});

var rqurl="/fans/getSellerFansNum?type=1&random="+Math.round(Math.random()*100);
$.get(rqurl,function(res){
	if(res){
		if(res.ret==0){
			$("#ruser_num").html(res.data["total"]);
		}
	}else{
		swal("错误", "服务器连接不上，请检查您的网络", "error");
	}
});
</script>
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
</style>
<jsp:include page="updateProfileTimes.jsp"/>
</body>
</html>