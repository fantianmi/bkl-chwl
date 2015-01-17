<%@page import="com.bkl.chwl.utils.StringUtil"%>
<%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.km.common.utils.*"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="com.bkl.chwl.vo.*"%>   
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top_nobutton.jsp"/>
<jsp:include page="right_menu.jsp"/>
<div class="content" style="margin-top:8.2rem;padding: 0rem 1rem 1rem 1rem !important; ">
<div class="alert alert-info" role="alert">输入商家编号确认商家，或者输入商家名称找到商家进行支付<br>
<span class="label label-danger">小提示</span>如果您是以公众号形式打开，您也可以关闭微网站，点击公众平台下方扫码扫描商家二维码进行支付</div>
<div class="row">
  <div class="col-lg-12">
    <div class="input-group  input-group-lg">
      <input type="text" class="form-control from-lg" id="keywords" placeholder="商家编号/商家名称">
      <span class="input-group-btn">
        <button class="btn btn-danger" type="button" onclick="searchSubmit()">确认</button>
      </span>
    </div><!-- /input-group -->
  </div>
</div><!-- /.row -->
</div>
<div class="space"></div>
<div class="tableList downborder" id="msg" style="display:none;"><div class="detail" style="padding-left:1rem">请选择商家进行支付</div></div>
<span id="searchShopList">
</span>
<button type="button" class="btn btn-lg btn-default btn-block noradius" id="searchShowmoreBtn" onclick="searchShowMore()" style="display: none">显示更多...</button>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<style>
.downborder:hover{background-color: #F0EFED;}
</style>
<script type="text/javascript">
document.getElementById("head_title").innerHTML="商家确认";
</script>
<!-- page special -->
<style>
.container2{width:100%;}
</style>
<script type="text/javascript">
var searchPageNow=1;
function searchSubmit(){
	var keywords=$("#keywords").val();
	if(keywords==""||keywords==null){
		swal("错误", "请输入编号/商家名", "error");
		return;
	}
	var url="/shop/getShopForConfirm?random="+Math.round(Math.random()*100);
	var params={searchKey:"id,title,detail",searchText:keywords};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				if(res.data!=""&&res.data!=null){
					$("#searchShopList").html(res.data);
					$("#searchShowmoreBtn").show();
					$("#msg").show();
				}else{
					$("#searchShowmoreBtn").html("没有更多内容了..");
					$("#searchShowmoreBtn").attr("disabled","disabled"); 
				}
			}
		}else{
			swal("错误", "服务器连接不上，请检查您的网络", "error");
		}
	});
}
function searchShowMore(){
	searchPageNow++;
	var keywords=$("#keywords").val();
	var url="/shop/getShopForConfirm?random="+Math.round(Math.random()*100);
	var newUrl=url+"&pagesize=20&pagenum="+searchPageNow;
	var params={searchKey:"id,title,detail",searchText:keywords};
	$.get(newUrl,function(res){
		if(res){
			if(res.ret==0){
				if(res.data!=null&&res.data!=""){
					$("#searchShopList").append(res.data);
				}else{
					$("#searchShowmoreBtn").html("没有更多内容了..");
					$("#searchShowmoreBtn").attr("disabled","disabled"); 
				}
			}
		}else{
			swal("错误", "服务器连接不上，请检查您的网络", "error");
		}
	});
}
</script>
<!-- page special -->
</body>
</html>