<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<%
User u=UserUtil.getCurrentUser(request);
/* if(u.getSecret()==null){
	response.sendRedirect("secretSet.jsp");
	return;
}
if(request.getParameter("secretOK")==null||!request.getParameter("secretOK").equals("ok")){
	if(u.getRole()==u.ROLE_NORMAL){
		response.sendRedirect("inputSecret.jsp?subType=1");
		return;
	}else{
		response.sendRedirect("inputSecretShop.jsp?subType=1");
		return;
	}
} */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top_nobutton.jsp"/>
<div class="content" style="margin-top:4.8rem;padding:0rem 1rem 1rem 1rem !important">
	  	<div class="col-xs-6 nopadding"><a class="btn-menu btn-menu-left active" href="javascript:void(0);" id="priCard" onclick="showPriCard();">对私账户</a></div>
	  	<div class="col-xs-6 nopadding"><a class="btn-menu btn-menu-right" href="javascript:void(0);" id="pubCard" onclick="showPubCard();">对公账户</a></div>
</div>
<script>
function showPriCard(){
	$("#bankCardNumLabel").html("对私账户卡号");
	$("#bankCardNum").attr("placeholder","对私账户卡号");
	$("#cardType").val(1);
	$("#priCard").addClass("active");
	$("#pubCard").removeClass("active");
	
}
function showPubCard(){
	$("#bankCardNumLabel").html("对公账户卡号");
	$("#bankCardNum").attr("placeholder","对公账户卡号");
	$("#cardType").val(2);
	$("#priCard").removeClass("active");
	$("#pubCard").addClass("active");
}
</script>

<div class="content" style="padding:0rem 1rem 1rem 1rem !important">
<form action="<%=u.getRole()==u.ROLE_NORMAL?"input_card_info.jsp":"input_card_info_full.jsp" %>" method="post" id="submitCardNum">
	<input type="hidden" name="cardType" id="cardType" value="1">
  <div class="form-group">
    <label for="bankCardNum" id="bankCardNumLabel">对私账户卡号</label>
    <input type="text" class="form-control" id="bankCardNum" name="bankCardNum"  placeholder="<%=u.getRole()==u.ROLE_SHOPER?"对私账户卡号":"银行卡号" %>"  onpaste="return false" >
  </div>
  </form>
  <p style="display: none" id="regNameResult"></p>
<div class="space_noborder"></div>
  <a  class="btn btn-success  btn-block" href="javascript:void(0);" onclick="submitCardNumFull()">下一步</a>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="添加银行卡";

var onkeyupboxFun2 = function (e){
	document.getElementById("bankCardNum").value=document.getElementById("bankCardNum").value.replace(/\D/g,'');
	onkeyupbox2(e);
};
var onclickboxFun2 = function (e){
	document.getElementById("bankCardNum").value=document.getElementById("bankCardNum").value.replace(/\D/g,'');
	onclickbox2(e);
};
var moveclickboxFun2 = function (e){
	document.getElementById("bankCardNum").value=document.getElementById("bankCardNum").value.replace(/\D/g,'');
	moveclickbox2(e);
};
document.getElementById("bankCardNum").onkeyup=onkeyupboxFun2;
document.getElementById("bankCardNum").onfocus=onclickboxFun2;
document.getElementById("bankCardNum").onblur=moveclickboxFun2;

function onkeyupbox2(e){
	var banknumber = document.getElementById("bankCardNum").value;
	banknumber = banknumber.replace(new RegExp(" ","gm"),'');
	banknumber = plusSpace(banknumber);
	document.getElementById("bankCardNum").value = banknumber;
}
function onclickbox2(e){
	var banknumber = document.getElementById("bankCardNum").value;
	if("银行卡账号" == banknumber){
		document.getElementById("bankCardNum").value = "";
	}
}
function moveclickbox2(e){
	document.getElementById("bankCardNum").value = banknumber;
}
function plusSpace(banknumber){
	var length = banknumber.length;
	var newbanknumber = "";
	if(length > 4){
		var size = parseInt(length/4);
		for (var i = 0; i < size; i++) {
			var start = i*4;
			var end = (i+1)*4;
			if((i+1)*4 > length){
				end = length;
			}
			var str = banknumber.substring(start,end);
			newbanknumber += str+" ";
		};
		if(length%4 != 0){
			newbanknumber += banknumber.substring(size*4,length);
		}else{
			var endstr = newbanknumber.substring(newbanknumber.length-1,newbanknumber.length);
			if(endstr == " "){
				newbanknumber = newbanknumber.substring(0,newbanknumber.length-1);
			}
		}
	}else{
		return banknumber;
	}
	return newbanknumber;
}
</script>

</body>
</html>