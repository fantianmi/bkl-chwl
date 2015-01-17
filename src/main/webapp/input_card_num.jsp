<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top_nobutton.jsp"/>
<div class="content" style="margin-top:5.5rem;padding:0rem 1rem 1rem 1rem !important">
<form action="input_card_info.jsp" method="post" id="submitCardNum">
  <div class="form-group">
    <label for="regUserName">卡号</label>
    <input type="text" class="form-control" id="bankCardNum" name="bankCardNum"  placeholder="无需网银/免手续费" >
  </div>
  </form>
  <p style="display: none" id="regNameResult"></p>
<div class="space_noborder"></div>
  <a  class="btn btn-success  btn-block" href="javascript:void(0);" onclick="submitCardNum()">下一步</a>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="添加银行卡";

var onkeyupboxFun2 = function (e){
	onkeyupbox2(e);
};
var onclickboxFun2 = function (e){
	onclickbox2(e);
};
var moveclickboxFun2 = function (e){
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
function submitCardNum(){
	var cardnum=$("#bankCardNum").val();
	if(trim(cardnum).length<16){
		swal("错误", "请确认填入正确的卡号", "error");
		return;
	}
	$("#submitCardNum").submit();
}
</script>

</body>
</html>