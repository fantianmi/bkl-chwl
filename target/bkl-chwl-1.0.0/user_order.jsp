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
OrderService orderServ=new OrderServiceImpl();
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
    <div class="coin_right_pic"><img src="assets/images/Mascot.png"/></div>
	</div>
</div>

<div class="tableList downborder">
	<div class="detail" style="padding-left: 1rem">结账流水记录</div>
</div>
<div class="space"></div>
<span id="user_order_list">
</span>
<button type="button" class="btn btn-lg btn-default btn-block" id="showmoreBtn" onclick="showMore()">显示更多...</button>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<jsp:include page="updateProfileTimes.jsp"/>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="结账总额";
$("#top_back_button").html("<a class=\"react\" href=\"user_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
</script>
<script type="text/javascript">
var pageNow=1;
var rqurl="/order/getOrderListHTML?random="+Math.round(Math.random()*100);
$.get(rqurl,function(res){
	if(res){
		if(res.ret==0){
			if(res.data["result"]!=null&&res.data["result"]!=""){
				$("#user_order_list").append(res.data["result"]);
				if(!res.data["hasmore"]){
					$("#showmoreBtn").html("没有更多内容了..");
					$("#showmoreBtn").attr("disabled","true"); 
				}
			}else{
				$("#user_order_list").append("<div class=\"alert alert-info\" role=\"alert\">没有消费记录</div>");
				$("#showmoreBtn").html("没有更多内容了..");
				$("#showmoreBtn").attr("disabled","true"); 
			}
		}
	}else{
		swal("错误", "服务器连接不上，请检查您的网络", "error");
	}
});
/* function changeStatus(status){
	rqurl="/order/getOrderListHTML?status="+status+"&random="+Math.round(Math.random()*100);
	$("#statusBtn0").removeClass("active");
	$("#statusBtn1").removeClass("active");
	$("#statusBtn2").removeClass("active");
	$("#statusBtn3").removeClass("active");
	$("#statusBtn"+status).addClass("active");
	$("#showmoreBtn").html("显示更多...");
	$("#showmoreBtn").removeAttr("disabled"); 
	
	$.get(rqurl,function(res){
		if(res){
			if(res.ret==0){
				$("#user_order_list").html(res.data);
			}
		}else{
			swal("错误", "服务器连接不上，请检查您的网络", "error");
		}
	});
} */
function showMore(){
	pageNow++;
	var newurl=rqurl+"&pagenum="+pageNow+"&pagesize=20";
	$.get(newurl,function(res){
		if(res){
			if(res.ret==0){
				if(res.data["result"]!=null&&res.data["result"]!=""){
					$("#user_order_list").append(res.data["result"]);
					if(!res.data["hasmore"]){
						$("#showmoreBtn").html("没有更多内容了..");
						$("#showmoreBtn").attr("disabled","true"); 
					}
				}else{
					$("#user_order_list").append("<div class=\"alert alert-info\" role=\"alert\">没有消费记录</div>");
					$("#showmoreBtn").html("没有更多内容了..");
					$("#showmoreBtn").attr("disabled","true"); 
				}
			}
		}else{
			swal("错误", "服务器连接不上，请检查您的网络", "error");
		}
	});
}
</script>
<style>
#user_order_list a{color:#000;}
.list_left {
width: 30%;
float: left;
padding: 1rem 0rem 1rem 0rem;
font-size: 12px !important;
}
.list_middle {
width: 35%;
float: left;
padding: 1rem 0rem 1rem 0rem;
font-size: 12px !important;
}
.list_right {
width: 25%;
float: left;
padding: 1rem 0rem 1rem 0rem;
font-size: 12px !important;
}
</style>
<jsp:include page="updateProfileTimes.jsp"/>
</body>
</html>