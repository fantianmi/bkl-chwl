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
ShopService shopServ=new ShopServiceImpl();
User user = UserUtil.getCurrentUser(request);
if(user.getVertify()==user.VERTIFY_FALSE){
	response.sendRedirect("shop_index.jsp");
	return;
}
Shop shop=shopServ.getByUid(user.getId());
AreaService areaServ = new AreaServiceImpl(); 
TypeService typeServ=new TypeServiceImpl();
List<Area> provinces=areaServ.getList(0);
if(user.getRole()!=user.ROLE_SHOPER){
	response.sendRedirect("index.jsp");
	return;
}
List<Type> types=typeServ.getList(0);
String zuobiao="";
if(shop!=null){
	zuobiao=shop.getShop_map();
}
if(request.getParameter("x")!=null&&request.getParameter("y")!=null){
	zuobiao=request.getParameter("x")+","+request.getParameter("y");
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
	<!-- page special -->
	<script type="text/javascript" src="assets/scripts/chwl/shop.js"></script>
	<!-- page special -->
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
<input type="hidden" id="id" value="<%=shop!=null?shop.getId():0%>"/>
<input type="hidden" id="uid" value="<%=shop!=null?shop.getUid():user.getId()%>"/>
<input type="hidden" id="image" value="<%=shop!=null?shop.getImage():"@"%>"/>
<div class="content">
	<div id="tab-one">
	<ul class="gallery">
			<span id="uploadImgList">
			<%
			if(shop!=null){
				String image[]=shop.getImage().split("@");
				for(int i=1;i<image.length;i++){
					%>
					<li><img class='image-decoration' src="<%=image[i]%>"></li>
					<%
				}
			}
			%>
            </span>
        </ul>
	</div>
</div>
<%if(shop!=null){ %>
<button onclick="resetImage()" class="btn btn-danger btn-block" id="resetImgBtn">重新上传</button>
<span id="dropzoneArea" style="display: none">
<form action="/uploadFile" method="post" enctype="multipart/form-data" class="dropzone" id="dropzoneForm">
</form>
</span>
<%}else{ %>
<form action="/uploadFile" method="post" enctype="multipart/form-data" class="dropzone" id="dropzoneForm">
</form>
<%} %>
</div>
<div class="space"></div>
<div class="container nomargin" style="margin: 0rem !important; padding: 0rem 1rem !important">
<div class="tableList downborder">
<div class="detail">客服电话：<span>400-1568-848</span></div>
</div>
<!-- form area -->
<div class="form-group">
    <label for="title">店铺名</label>
    <input type="text" class="form-control" id="title" value="<%=shop!=null?shop.getTitle():""%>">
  </div>
<div class="form-group">
    <label for="detail">详细介绍（200字以内）</label>
    <textarea class="form-control" rows="3" id="detail"><%=shop!=null?shop.getDetail():""%></textarea>
  </div>
  <div class="form-group">
    <label for="shop_map">百度坐标</label><span id="map_status" style="color:red"></span><span id="reDoLBS"><button class="btn btn-danger btn-xs" onclick="doLBS()">定位</button></span>
    <input type="text" class="form-control" id="shop_map"  value="<%=zuobiao%>" readonly>
  </div>
  <div class="form-group">
    <label for="shop_loc">详细地址</label>
    <input type="text" class="form-control" id="shop_loc"  value="<%=shop!=null?shop.getShop_loc():""%>">
  </div>
  <div class="form-group">
    <label for="shop_tel">联系电话</label>
    <input type="text" class="form-control" id="shop_tel"  value="<%=shop!=null?shop.getShop_tel():""%>" onkeyup="value=value.replace(/[^0-9]/g,'')" onpaste="value=value.replace(/[^0-9]/g,'')" oncontextmenu = "value=value.replace(/[^0-9]/g,'')">
  </div>
   <input type="hidden" class="form-control" id="price" value="<%=shop!=null?shop.getPrice():1%>" onkeyup="value=value.replace(/[^\0-9\.]/g,'')" onpaste="value=value.replace(/[^\0-9\.]/g,'')" oncontextmenu = "value=value.replace(/[^\0-9\.]/g,'')">
   <input type="hidden" class="form-control" id="oprice" value="<%=shop!=null?shop.getOprice():1%>" onkeyup="value=value.replace(/[^\0-9\.]/g,'')" onpaste="value=value.replace(/[^\0-9\.]/g,'')" oncontextmenu = "value=value.replace(/[^\0-9\.]/g,'')">
  <div class="form-group">
    <label for="coinRate">消费返利（如0.3表示消费收入的30%让利）</label><br>
    <select  id="coinRate" >
    <%=shop!=null?"<option value="+shop.getCoinRate()+">"+shop.getCoinRate()+"</option>":""%>
    <option value="0.1">0.1</option>
    <option value="0.15">0.15</option>
    <option value="0.2">0.2</option>
    <option value="0.25">0.25</option>
    <option value="0.3">0.3</option>
    <option value="0.35">0.35</option>
    <option value="0.4">0.4</option>
    <option value="0.45">0.45</option>
    <option value="0.5">0.5</option>
    <option value="0.55">0.55</option>
    <option value="0.6">0.6</option>
    <option value="0.65">0.65</option>
    <option value="0.7">0.7</option>
    <option value="0.75">0.75</option>
    <option value="0.8">0.8</option>
    <option value="0.85">0.85</option>
    <option value="0.9">0.9</option>
    <option value="0.95">0.95</option>
    <option value="1">1</option>
    </select>
  </div>
  <div class="form-group">
  <label for="recommended_user_id">城市选择</label><br>
    <select id="local" onchange="changeArea(this,this.value)">
    <%=shop!=null?"<option value="+shop.getLocal()+">默认不动</option>":"<option value=\"0\">请选择省份</option>"%>
	    <%
	    Area province=new Area();
	    for(int i=0;i<provinces.size();i++) {
	    	province=provinces.get(i);
	    %>
		    <option value="<%=province.getId()%>"><%=province.getTitle() %></option>
		<%} %>
		  </select>
		  <select  id="local2" onchange="changeArea(this,this.value)" onclick="changeArea(this,this.value)">
		  <%=shop!=null?"<option value="+shop.getLocal2()+">默认不动</option>":"<option value=\"0\">请选择城市</option>"%>
		  </select>
		  <select  id="local3">
		  <%=shop!=null?"<option value="+shop.getLocal3()+">默认不动</option>":"<option value=\"0\">请选择地区</option>"%>
		  </select>
	  </div>
	  <div class="form-group">
	    <label for="recommended_user_id">类别选择</label><br>
	    <select id="shop_type" onchange="changeType(this,this.value)">
	    <%=shop!=null?"<option value="+shop.getLocal3()+">默认不动</option>":"<option value=\"0\">请选择类别</option>"%>
		    <%
		    Type shop_type=new Type();
		    for(int i=0;i<types.size();i++) {
		    	shop_type=types.get(i);
		    %>
			    <option value="<%=shop_type.getId()%>"><%=shop_type.getName()%></option>
			<%} %>
			  </select>
			  <select  id="shop_type2" >
			  <%=shop!=null?"<option value="+shop.getLocal3()+">默认不动</option>":"<option value=\"0\">请选择子类别</option>"%>
			  </select>
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
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=wGG6mbDmPutcOrlNIcFxNeAU"></script>
<script type="text/javascript">
document.getElementById("head_title").innerHTML="管理店铺";
$("#top_back_button").html("<a class=\"react\" href=\"shop_info.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>返回</a>");
$("#top_qr_button").hide();
$("#top_search_button").hide();
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

// 百度地图API功能
var map=$("#shop_map").val();
if(map==null||map==""){
	doLBS();
}
function doLBS(){
	$("#map_status").html("(定位中...)");
	var point = new BMap.Point(116.331398,39.897445);
	var geolocation = new BMap.Geolocation();
	geolocation.getCurrentPosition(function(r){
		if(this.getStatus() == BMAP_STATUS_SUCCESS){
			var mk = new BMap.Marker(r.point);
			$("#shop_map").val(r.point.lng+','+r.point.lat);
			$("#map_status").html("(定位成功)");
			/* alert('您的位置：'+r.point.lng+','+r.point.lat); */
		}
		else {
			alert('failed'+this.getStatus());
		}        
	},{enableHighAccuracy: true})
}
</script>
<!-- drop box -->
</body>
</html>