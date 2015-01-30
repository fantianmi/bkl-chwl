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
Map<Long,Area> areaMap=areaServ.areaMap();
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
String ossBaseurl=MainConfig.getOssBaseurl();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
	<!-- page special -->
	<script type="text/javascript" src="assets/scripts/chwl/shop.js?v=10.0"></script>
	<!-- page special -->
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
<input type="hidden" id="id" value="<%=shop!=null?shop.getId():0%>"/>
<input type="hidden" id="uid" value="<%=shop!=null?shop.getUid():user.getId()%>"/>
<input type="hidden" id="image" value="<%=shop!=null?shop.getImage():""%>"/>
</div>
<div class="container nomargin" style="margin: 0rem !important; padding: 0rem 1rem !important">
<!-- form area -->
<div class="form-group">
    <label for="title">商户全称</label>
    <input type="text" class="form-control" id="title" value="<%=shop!=null?shop.getTitle():""%>">
  </div>
<div class="form-group">
    <label for="detail">商家介绍（200字以内） 还可以输入<span id="validNum" style="color:red">200</span>字</td></label>
    <textarea class="form-control" rows="3" id="detail" maxlength='140' onKeyDown="checkLength()" onKeyUp="checkLength()" onPaste="checkLength()"><%=shop!=null?shop.getDetail():""%></textarea>
  </div>
  <div class="form-group">
    <label for="shop_map">百度坐标 （请在商铺实际经营地点定位，以便消费者精准导航）</label><span id="map_status" style="color:red"></span><span id="reDoLBS"><button class="btn btn-danger btn-xs" onclick="doLBS()">定位</button></span>
    <input type="text" class="form-control" id="shop_map"  value="<%=zuobiao%>" readonly>
  </div>
  <%
  Long local1=Long.valueOf(user.getLocal());
  Long local2=Long.valueOf(user.getLocal2());
  Long local3=Long.valueOf(user.getLocal3());
  
  String local1Name=areaMap.get(local1)!=null?areaMap.get(local1).getTitle():"";
  String local2Name=areaMap.get(local2)!=null?areaMap.get(local2).getTitle():"";
  String local3Name=areaMap.get(local3)!=null?areaMap.get(local3).getTitle():"";
  String locString=local1Name+local2Name+local3Name;
  %>
  <div class="form-group">
    <label for="shop_loc">详细地址</label>
    <input type="text" class="form-control" id="shop_loc"  value="<%=shop.getShop_loc()!=null&&shop.getShop_loc()!=""?shop.getShop_loc():locString%>">
  </div>
  <div class="form-group">
    <label for="shop_tel">联系电话</label>
    <input type="text" class="form-control" id="shop_tel"  value="<%=shop.getShop_tel()!=null&&shop.getShop_tel()!=""?shop.getShop_tel():user.getMobile2()%>" onkeyup="value=value.replace(/[^0-9]/g,'')" onpaste="value=value.replace(/[^0-9]/g,'')" oncontextmenu = "value=value.replace(/[^0-9]/g,'')">
  </div>
   <input type="hidden" class="form-control" id="price" value="<%=shop!=null?shop.getPrice():1%>" onkeyup="value=value.replace(/[^\0-9\.]/g,'')" onpaste="value=value.replace(/[^\0-9\.]/g,'')" oncontextmenu = "value=value.replace(/[^\0-9\.]/g,'')">
   <input type="hidden" class="form-control" id="oprice" value="<%=shop!=null?shop.getOprice():1%>" onkeyup="value=value.replace(/[^\0-9\.]/g,'')" onpaste="value=value.replace(/[^\0-9\.]/g,'')" oncontextmenu = "value=value.replace(/[^\0-9\.]/g,'')">
    <label for="coinRate">消费返利（50%≥输入数字（必须为整数)≥10%）</label>
  <div class="input-group">
    <input type="text" class="form-control" id="coinRate"  value="<%=shop.getCoinRate()!=0?(int)(shop.getCoinRate()*100):10%>" onkeyup="checkfanli()" onpaste="checkfanli()" oncontextmenu = "checkfanli()">
    <span class="input-group-addon">%</span>
  </div><br>
  <div class="form-group">
  <label for="recommended_user_id">城市选择</label><br>
    <select id="local" onchange="changeArea(this,this.value)">
    <%=shop.getLocal()!=0?"<option value="+shop.getLocal()+">默认不动</option>":"<option value=\"0\">请选择省份</option>"%>
	    <%
	    Area province=new Area();
	    for(int i=0;i<provinces.size();i++) {
	    	province=provinces.get(i);
	    %>
		    <option value="<%=province.getId()%>"><%=province.getTitle() %></option>
		<%} %>
		  </select>
		  <select  id="local2" onchange="changeArea(this,this.value)" onclick="changeArea(this,this.value)">
		  <%=shop.getLocal2()!=0?"<option value="+shop.getLocal2()+">默认不动</option>":"<option value=\"0\">请选择城市</option>"%>
		  </select>
		  <select  id="local3">
		  <%=shop.getLocal3()!=0?"<option value="+shop.getLocal3()+">默认不动</option>":"<option value=\"0\">请选择地区</option>"%>
		  </select>
	  </div>
	  <div class="form-group">
	    <label for="recommended_user_id">类别选择</label><br>
	    <select id="shop_type" onchange="changeType(this,this.value)">
	    <%=shop.getShop_type()!=0?"<option value="+shop.getShop_type()+">默认不动</option>":"<option value=\"0\">请选择类别</option>"%>
		    <%
		    Type shop_type=new Type();
		    for(int i=0;i<types.size();i++) {
		    	shop_type=types.get(i);
		    %>
			    <option value="<%=shop_type.getId()%>"><%=shop_type.getName()%></option>
			<%} %>
			  </select>
			  <select  id="shop_type2" >
			  <%=shop.getShop_type2()!=0?"<option value="+shop.getShop_type2()+">默认不动</option>":"<option value=\"0\">请选择子类别</option>"%>
			  </select>
	  </div>
	   <div class="form-group">
	  </div>
	  </div>
<div class="space"></div>
<div class="content">
	<div id="tab-one">
	<ul class="gallery">
			<span id="uploadImgList">
			<%
			if(shop!=null){
				String image[]=shop.getImage().split("@");
				for(int i=0;i<image.length;i++){
					%>
					<li><img class='image-decoration' src="<%=ossBaseurl+image[i]%>"></li>
					<%
				}
			}
			%>
            </span>
        </ul>
	</div>
</div>
<%if(shop.getImage()!=null&&!shop.getImage().equals("")){ %>
<button onclick="resetImage()" class="btn btn-danger btn-block" id="resetImgBtn">重新上传</button>
<span id="dropzoneArea" style="display: none">
<form action="/uploadFile" method="post" enctype="multipart/form-data" class="dropzone" id="dropzoneForm">
</form>
</span>
<%}else{ %>
仅限3张（商铺门头、店内实景、主打商品）；每张不超过5M
<form action="/uploadFile" method="post" enctype="multipart/form-data" class="dropzone" id="dropzoneForm">
</form>
<%} %>
<div class="space"></div>
<button onclick="addShopSubmit()" class="btn btn-success btn-block">确认提交</button>
<!-- form area -->
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript" src="http://api.map.baidu.com/api?v=2.0&ak=wGG6mbDmPutcOrlNIcFxNeAU"></script>
<script type="text/javascript">
document.getElementById("head_title").innerHTML="完整资料";
$("#top_back_button").html("<a class=\"react\" href=\"shop_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
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
	    acceptedFiles:"image/*",
	    maxFilesize: 5, // MB
		addRemoveLinks : false,
		dictMaxFilesExceeded:"请上传小于5M的图片",
		dictInvalidFileType:"请上传格式为jpg的图片",
		dictFileTooBig:"请上传小于5M的图片",
		dictDefaultMessage :"<a class='btn btn-danger btn-block' id='uploadBtn'>上传图片</a>'",
		dictResponseError: "<p class='bg-danger absolutePostion'>上传失败，格式错误</p>",
		//change the previewTemplate to use Bootstrap progress bars
		previewTemplate: "<div class=\"bg-danger absolutePostion\"><span data-dz-errormessage></span></div>"
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
            if(uploadImageNum==3){
            	$("#uploadBtn").hide();
            }
            $("#uploadImgList").append("<li><img class='image-decoration' src='"+uploadFileURL+"'></li>");
        });
    }
};
function resetImage(){
	$("#image").val("");
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
function checkfanli(){
	document.getElementById("coinRate").value=document.getElementById("coinRate").value.replace(/[^0-9]/g,'');
	if(document.getElementById("coinRate").value>50){
		swal("错误", "返利请输入10`50之间的数字", "error");
		document.getElementById("coinRate").value=50;
		return
	}
}

function checkLength(){
    var value = document.getElementById("detail").value;
    if(value.length>200){
        document.getElementById("detail").value=document.getElementById("detail").value.substr(0, 200);
    }else{
        document.getElementById("validNum").innerHTML = 200 - value.length;
    }
}
</script>
<style>
.bg-danger{background-color: #000;color:#fff;}
.bg-danger span{color:#fff}
</style>
<!-- drop box -->
</body>
</html>