<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>用户中心</title>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<jsp:include page="right_menu.jsp"/>
<div class="content nopadding" style="margin-top:6.1rem " id="content1">
<jsp:include page="user_panel_menu.jsp"></jsp:include>
<div class="container nomargin" style="background-color: #DC3C00;color:#fff;padding:2rem !important;margin-bottom: 0px !important;">
  <p><i class="iconfont">&#xe628;</i>金币(￥)<br><br><span class="bigFont" style="color: #fff">10,352.03</span></p>
</div>
<div class="container nomargin nopadding">
<ul class="menu-list">
<li><button class="btn btn-default active" onclick="javascript:location.href='user_index.jsp'">普通粉丝</button></li>
<li><button class="btn btn-default" onclick="javascript:location.href='user_order.jsp'">商家粉丝</button></li>
</ul>
</div>
<div class="container nomargin" style="background-color: #F8F8F8;color:#666;padding:2rem;margin-top: 0px !important;">
<!-- order list -->
<div class="content" style="padding: 10px 0px">
    <div class="container no-bottom">
      <div class="container no-bottom list_style_user" onclick="javascript:location.href='user_order_detail.jsp'">
        <div class="recent-post">
                <div class="dealcard-img-user"><img src="assets/images/test/1.jpg" alt="img" class="img-circle"></div>
                <div class="dealcard-block-right-user">
                <div class="title"><strong>&nbsp;</strong></div>
                <div class="detail">
                <strong>fantianmi</strong>
                注册时间：2014-11-3
                </div>
               </div>
        </div>
     </div>
     <br>
     <div class="decoration"></div>
     <!-- order list -->
     <br>
</div>
<!-- order list -->
</div>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="粉丝列表";
</script>
</body>
</html>