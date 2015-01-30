<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
<div class="container nomargin nopadding">
<ul class="menu-list">
<li onclick="showbounsList(this,0)" class="bounsBtn active"><img src="assets/images/Happy bags.png"></li>
<li onclick="showbounsList(this,1)" class="bounsBtn"><img src="assets/images/Health bag.png"></li>
<li onclick="showbounsList(this,2)"class="bounsBtn"><img src="assets/images/Happy bags1.png"></li>
</ul>
</div>
<div class="container nomargin" style="color:#666;padding:2rem;margin-top: 0px !important;">
<!-- order list -->
<div class="content" style="padding: 10px 0px">
    <div class="container no-bottom bounsArea" id="smallbouns_area">
     <!-- order list -->
	</div>
    <div class="container no-bottom bounsArea" id="middlebouns_area" style="display: none;">
     <!-- order list -->
	</div>
    <div class="container no-bottom bounsArea" id="bigbouns_area" style="display: none;">
     <!-- order list -->
	</div>
<!-- order list -->
</div>
</div>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="点头钱袋";
$("document").ready(function(){
	 loadBounsData();
	 $(self).addClass("active");
});
function loadBounsData(){
	var bounsURL="/bouns/getBounsListHTML?random="+Math.round(Math.random()*100);
	jQuery.get(bounsURL,function(res){
		if(res){
			if(res.ret==0){
				if(res.data["sbounHTML"]!=""){
					$("#smallbouns_area").html(res.data["sbounHTML"]);
				}else{
					$("#smallbouns_area").html("<div class=\"alert alert-info\" role=\"alert\">暂无钱包</div>");
				}
				if(res.data["mbounHTML"]!=""){
					$("#middlebouns_area").html(res.data["mbounHTML"]);
				}else{
					$("#middlebouns_area").html("<div class=\"alert alert-info\" role=\"alert\">暂无钱包</div>");
				}
				if(res.data["bbounHTML"]!=""){
					$("#bigbouns_area").html(res.data["bbounHTML"]);
				}else{
					$("#bigbouns_area").html("<div class=\"alert alert-info\" role=\"alert\">暂无钱包</div>");
				}
			}
		}
	});
}
function showbounsList(self,type){
	$(".bounsBtn").removeClass("active");
	$(self).addClass("active");
	$(".bounsArea").hide();
	if(type==0){ $("#smallbouns_area").show(); return;}
	if(type==1){ $("#middlebouns_area").show(); return;}
	if(type==2){ $("#bigbouns_area").show(); return;}
}
function openbouns(self,id,type){
	var openbunsURL="/bouns/openBouns?random="+Math.round(Math.random()*100);
	var params={id:id,type:type};
	$.post(openbunsURL,params,function(res){
		if(res){
			if(res.ret==0){
				$(self).attr("disabled",true); 
				$(self).html("已领取");
				swal({
                  title: "操作成功",  
                  text: res.data,  
                  type: "success",  
                  showCancelButton: false,  
                  confirmButtonColor: "#A7D5EA",  
                  confirmButtonText: "确认" },
                  function(){  
                	  loadBounsData();
                  });
			}
		}
	});
}
</script>
</body>
</html>