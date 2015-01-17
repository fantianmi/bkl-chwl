<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<div class="tableList downborder">
<div class="detail" style="padding-left: 1rem">普通粉丝（<span id="ruser_num"></span>）</div>
</div>

<div class="space"></div>
<div class="tableList downborder">
<div class="detail" style="padding-left: 1rem">商家粉丝（<span id="rshoper_num"></span>）</div>
</div>
<div class="tableList downborder">
<div class="detail" style="padding-left: 1rem">总盈利:<span id="shoperProfileTotal"></span>元</div>
</div>
<div class="container nomargin" style="color:#666;padding:2rem;margin-top: 0px !important;">
<!-- order list -->
<div class="content" style="padding: 10px 0px">
    <div class="container no-bottom" id="user_order_list">
     <!-- order list -->
	</div>
	<button type="button" class="btn btn-lg btn-default btn-block" id="showmoreBtn" onclick="showMore()">显示更多...</button>
<!-- order list -->
</div>
</div>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<jsp:include page="updateProfileTimes.jsp"/>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="推荐粉丝";
</script>
<script type="text/javascript">
var pageNow=1;
var rqurl="/fans/getFansListHTML?type=2&random="+Math.round(Math.random()*100);
$.get(rqurl,function(res){
	if(res){
		if(res.ret==0){
			$("#user_order_list").append(res.data["resHTML"]);
			$("#rshoper_num").html(res.data["total"]);
			$("#shoperProfileTotal").html(res.data["totalProfile"]);
			$("#ruser_num").html(res.data["otherTotal"]);
			if(res.data["resHTML"]==""){
				$("#showmoreBtn").html("没有更多内容了..");
				$("#showmoreBtn").attr("disabled","true"); 
			}
		}
	}else{
		swal("错误", "服务器连接不上，请检查您的网络", "error");
	}
});
function changeType(type){
	rqurl="/fans/getFansListHTML?type="+type+"&random="+Math.round(Math.random()*100);
	$("#typeBtn1").removeClass("active");
	$("#typeBtn2").removeClass("active");
	$("#typeBtn"+type).addClass("active");
	$("#showmoreBtn").html("显示更多...");
	$("#showmoreBtn").removeAttr("disabled"); 
	
	$.get(rqurl,function(res){
		if(res){
			if(res.ret==0){
				$("#user_order_list").html(res.data["resHTML"]);
			}
			if(res.data["resHTML"]==""){
				$("#showmoreBtn").html("没有更多内容了..");
				$("#showmoreBtn").attr("disabled","true"); 
			}
		}else{
			swal("错误", "服务器连接不上，请检查您的网络", "error");
		}
	});
}
function showMore(){
	pageNow++;
	var newurl=rqurl+"&pagenum="+pageNow+"&pagesize=20";
	$.get(newurl,function(res){
		if(res){
			if(res.ret==0){
				if(res.data!=null&&res.data!=""){
					$("#user_order_list").append(res.data["resHTML"]);
				}
				if(res.data["resHTML"]==""){
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
</body>
</html>