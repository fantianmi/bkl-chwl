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
<span id="order_list_area">
</span>
<button type="button" class="btn btn-lg btn-default btn-block" id="showmoreBtn" onclick="showMore()">显示更多...</button>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="结账详情";
$("#top_back_button").html("<a class=\"react\" href=\"user_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
$("#top_qr_button").hide();
$("#top_search_button").hide();
</script>
<script type="text/javascript">
var pageNow=1;
var rqurl="/shop/getOrderListHTML?<%=request.getParameter("staticsType")!=null?"staticsType="+request.getParameter("staticsType")+"&":""%>random="+Math.round(Math.random()*100);
$.get(rqurl,function(res){
	if(res){
		if(res.ret==0){
			$("#order_list_area").append(res.data["resStr"]);
		}
		if(!res.data["hasNext"]){
			$("#order_list_area").append("<div class=\"alert alert-info\" role=\"alert\">暂无结账记录</div>");
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
<style>
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
</body>
</html>