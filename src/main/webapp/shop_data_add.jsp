 <%@page import="com.bkl.chwl.constants.Constants"%>
 <%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
ShopService shopServ=new ShopServiceImpl();
User user = UserUtil.getCurrentUser(request);

AreaService areaServ = new AreaServiceImpl(); 
List<Area> provinces=areaServ.getList(0);
%>
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
</div>
<div class="container nomargin" style="margin: 0rem !important;">
<input type="hidden" id="id" value="<%=user.getId()!=0?user.getId():0%>"/>
<input type="hidden" id="licenceFileName" value="<%=user.getLicenceFileName()!=null?user.getLicenceFileName():""%>"/>
<input type="hidden" id="licenceFileURL" value="<%=StringUtils.defaultIfEmpty(user.getLicenceFileURL(),"-")%>"/>
<div class="fullImage" <%=user.getLicenceFileURL()==null?"style=\"display:none\"":"" %> id="previewuploadImg"><img src="<%=FrontImage.convertOss(user.getLicenceFileURL())%>"></div>
<form action="/uploadFile" method="post" enctype="multipart/form-data" class="dropzone" id="dropzoneForm">
</form>
<div class="form-group">
    <label for="title">营业执照编号</label>
    <input type="text" class="form-control" id="licenceNumber" value="<%=user.getLicenceNumber()!=null?user.getLicenceNumber():""%>" placeholder="营业执照编号">
  </div>

<div class="form-group">
  <label for="recommended_user_id">城市选择</label><br>
   <select id="local" onchange="changeArea(this,this.value)">
   <%=user.getLocal()!=0?"<option value="+user.getLocal()+">默认不动</option>":"<option value=\"0\">请选择省份</option>"%>
    <%
    Area province=new Area();
    for(int i=0;i<provinces.size();i++) {
    	province=provinces.get(i);
    %>
	    <option value="<%=province.getId()%>"><%=province.getTitle() %></option>
	<%} %>
	  </select>
	  <select  id="local2" onchange="changeArea(this,this.value)" onclick="changeArea(this,this.value)">
	  <%=user.getLocal2()!=0?"<option value="+user.getLocal2()+">默认不动</option>":"<option value=\"0\">请选择城市</option>"%>
	  </select>
	  <select  id="local3">
	  <%=user.getLocal3()!=0?"<option value="+user.getLocal3()+">默认不动</option>":"<option value=\"0\">请选择城市</option>"%>
	  </select>
  </div>
  <button class="btn btn-success btn-block btn-lg" onclick="shopDataSubmit()">提交资料</button>
  </div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="审核资料管理";
$("#top_back_button").html("<a class=\"react\" href=\"shop_data.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
$("#top_qr_button").hide();
$("#top_search_button").hide();
</script>
<!-- drop box -->
<script type="text/javascript">
jQuery(function($){
	try {
	  $(".dropzone").dropzone({
	    paramName: "file", // The name that will be used to transfer the file
	    maxFilesize: 2, // MB
	  
		addRemoveLinks : false,
		dictDefaultMessage :"<a class='btn btn-danger btn-block' id='uploadBtn'>上传营业执照</a>'",
		dictResponseError: "<p class='bg-danger absolutePostion'>上传失败，格式错误</p>",
		//change the previewTemplate to use Bootstrap progress bars
		previewTemplate: "<p class='bg-success absolutePostion'>上传成功</p>"
	  });
	} catch(e) {
	  alert('浏览器不支持上传');
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
            $("#licenceFileName").val(uploadFileName);
            $("#licenceFileURL").val(uploadFileURL);
            $("#previewuploadImg").show();
            $("#previewuploadImg").html("<img src=\""+uploadFileURL+"\"/>");
            
        });
    }
};
function shopDataSubmit(){
	var id=$("#id").val();
	var licenceFileName=$("#licenceFileName").val();
	var licenceFileURL=$("#licenceFileURL").val();
	var licenceNumber=$("#licenceNumber").val();
	var local=$("#local").val();
	var local2=$("#local2").val();
	var local3=$("#local3").val();
	if(licenceFileName==null||licenceFileName==""||licenceFileURL==null||licenceFileURL==""||licenceNumber==null||licenceNumber==""||local==0||local2==0||local3==0){
		swal("错误", "请确认表单是否填写完全", "error");
		return;
	}
	var url="/api/user/updateShopData?random="+Math.round(Math.random()*100);
	var params={id:id,licenceFileName:licenceFileName,licenceFileURL:licenceFileURL,licenceNumber:licenceNumber,local:local,local2:local2,local3:local3};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				swal({
                    title: "成功",  
                    text: "提交成功",  
                    type: "success",  
                    showCancelButton: false,  
                    confirmButtonColor: "#A7D5EA",  
                    confirmButtonText: "确认" },
                    function(){  
                         window.location.href="shop_data.jsp";
                    });
			}
		}
	});
}
</script>
<!-- drop box -->

</body>
</html>