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
User user=UserUtil.getCurrentUser(request);
if(user.getVertify()==user.VERTIFY_FALSE){
	response.sendRedirect("shop_index.jsp");
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
<div class="content nopadding" style="margin-top:5rem " id="content1">
<div class="tableList downborder">
<div class="detail">客服电话：<span>400-1568-848</span></div>
</div>
<span id="order_list_area">

</span>
<button type="button" class="btn btn-lg btn-default btn-block" id="showmoreBtn" onclick="showMore()">显示更多...</button>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="订单查看";
$("#top_back_button").html("<a class=\"react\" href=\"user_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>返回</a>");
$("#top_qr_button").hide();
$("#top_search_button").hide();
</script>
<script type="text/javascript">
var pageNow=1;
var rqurl="/shop/getOrderListHTML?random="+Math.round(Math.random()*100);
$.get(rqurl,function(res){
	if(res){
		if(res.ret==0){
			$("#order_list_area").append(res.data["resStr"]);
		}
		if(!res.data["hasNext"]){
			$("#showmoreBtn").html("没有更多内容了..");
			$("#showmoreBtn").attr("disabled","true"); 
		}
	}else{
		swal("错误", "服务器连接不上，请检查您的网络", "error");
	}
});
function showMore(){
	pageNow++;
	var newurl=rqurl+"&pagenum="+pageNow+"&pagesize=20";
	$.get(newurl,function(res){
		if(res){
			if(res.ret==0){
				$("#order_list_area").append(res.data["resStr"]);
			}
			if(!res.data["hasNext"]){
				$("#showmoreBtn").html("没有更多内容了..");
				$("#showmoreBtn").attr("disabled","true"); 
			}
		}else{
			swal("错误", "服务器连接不上，请检查您的网络", "error");
		}
	});
}
</script>

</body>
</html>