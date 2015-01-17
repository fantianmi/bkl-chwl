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

AreaService areaServ = new AreaServiceImpl(); 
TypeService typeServ=new TypeServiceImpl();
List<Area> provinces=areaServ.getList(0);
if(user.getRole()!=user.ROLE_SHOPER){
	response.sendRedirect("user_index.jsp");
	return;
}
List<Type> types=typeServ.getList(0);
String zuobiao="106.558231,29.572504";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>管理店铺</title>
	<jsp:include page="common_source_head.jsp"/>
	<!-- page special -->
	<script type="text/javascript" src="assets/scripts/chwl/shop.js"></script>
	<!-- page special -->
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<jsp:include page="right_menu.jsp"/>
<div class="space"></div>
<div class="container nomargin" style="margin: 0rem !important; padding: 0rem 1rem !important">
<div class="tableList downborder">
<div class="detail">客服电话：<span>400-1568-848</span></div>
</div>
<!-- form area -->
  <div class="form-group">
  <label for="recommended_user_id">城市选择</label><br>
	</div>
   <div class="form-group">
    <button onclick="addShopSubmit()" class="btn btn-success btn-block">确认提交</button>
  </div>
 </div>
<!-- form area -->
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="管理店铺";
</script>
<!-- drop box -->
<script type="text/javascript">
var uploadImageNum=0;
jQuery(function($){
	try {
	  $(".dropzone").dropzone({
	    paramName: "file", // The name that will be used to transfer the file
	    maxFilesize: 100, // MB
	  
		addRemoveLinks : false,
		dictDefaultMessage :"<a class='btn btn-danger btn-block' id='uploadBtn'>上传图片</a>'",
		dictResponseError: "<p class='bg-danger absolutePostion'>上传失败，格式错误</p>",
		//change the previewTemplate to use Bootstrap progress bars
		previewTemplate: "<p class='bg-success absolutePostion'>上传成功</p>"
	  });
	} catch(e) {
	  alert('Dropzone.js does not support older browsers!');
	}
	
});
Dropzone.options.dropzoneForm = {
    init: function () {
        this.on("complete", function (data) {                
            var res = eval('(' + data.xhr.responseText + ')');
            var data = new Array();
            data=res.data;
            var requestFileName=data[0]["requestFileName"];
            var uploadFileURL=data[0]["uploadFileURL"];
            var uploadFileName=data[0]["uploadFileName"];
            var imageValue=$("#image").val();
            imageValue+=uploadFileURL+"@";
            $("#image").val(imageValue);
            uploadImageNum++;
            if(uploadImageNum==9){
            	$("#uploadBtn").hide();
            }
            $("#uploadImgList").append("<li><img class='image-decoration' src='"+uploadFileURL+"'></li>");
        });
    }
};
function resetImage(){
	$("#image").val("@");
	$("#resetImgBtn").hide();
	$("#dropzoneArea").show();
	$("#uploadImgList").html("");
}
</script>
<!-- drop box -->
</body>
</html>