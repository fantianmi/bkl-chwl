<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>上传图片</title>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<jsp:include page="right_menu.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
	<div class="container nomargin" style="padding: .5rem !important;">
	<form role="form">
	<div class="form-group">
	    <label for="exampleInputFile">&nbsp;&nbsp;格式jpg</label>
	    <input type="file" id="exampleInputFile">
	    <p class="help-block">点击按钮选择图片</p>
	  </div>
  <button type="submit" class="btn btn-danger btn-block">确认</button><br>
</form>
</div>
</div>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="上传图片";
</script>
</body>
</html>