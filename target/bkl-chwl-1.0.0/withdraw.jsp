<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>提现</title>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<jsp:include page="right_menu.jsp"/>
<div class="content nopadding" style="margin-top:4.5rem " id="content1">
	<div class="container nomargin" style="background-color: #DC3C00;color:#fff;padding:2rem !important;margin-bottom: 0px !important;">
	  <p><i class="iconfont">&#xe628;</i>金币(￥)<br><br><span class="bigFont" style="color: #fff">10,352.03</span></p>
	</div>
	<div class="container">
	<form role="form">
	  <div class="form-group">
	    <label for="exampleInputEmail1">&nbsp;</label>
	    <input type="text" class="form-control" id="exampleInputEmail1" placeholder="请输入提现金额">
	  </div>
	  <button type="button" class="btn btn-success  btn-block" onclick="javascript:location.href='reg.jsp'">确认</button>
	</form>
	</div>
</div>

 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="人民币提现";
</script>
</body>
</html>