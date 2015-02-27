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
 String forwardUrl = request.getParameter("forward");
 if (forwardUrl == null) {
 	forwardUrl = "";
 }
 int resetType=1;
 if(request.getParameter("resetType")!=null){
	 resetType=Integer.parseInt(request.getParameter("resetType"));
 }
 String vcode="";
 if(session.getAttribute("msgValidateCode")!=null){
	 vcode=session.getAttribute("msgValidateCode").toString();
 }
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top_nobutton.jsp"/>
<input type="hidden" class="form-control" id="vcode" value="<%=vcode%>">
<input type="hidden" class="form-control" id="resetType" value="<%=resetType%>">
<div class="content" style="margin-top:5.2rem;padding:1rem !important; ">
  <div id="resetPassVcheckArea">
  <div class="form-group">
  <label for="loginUserName"><i class="iconfont">&#xf0026;</i>&nbsp;&nbsp;手机号/商户账号</label>
  <div class="input-group" id="formVcodeInput">
     <input type="text" class="form-control" placeholder="手机号/商户请输入您的商户账号"  size="14" id="regUserName">
     <span class="input-group-btn">
       <button class="btn btn-danger"  id="sendMsgBtn" onclick="sendMsg(this,2);">发送验证码</button>
     </span>
   </div><!-- /input-group -->
   </div>
   <div class="form-group">
    <label for="loginUserName"><i class="iconfont">&#xf0026;</i>&nbsp;&nbsp;收到的验证码</label>
    <input type="text" class="form-control" placeholder="5位验证码" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="5" size="14" id="phone_validate_code">
  </div>
   <button onclick="showResetPassArea()" class="btn btn-success  btn-block">确认</button><br>
  </div>
  <div id="resetPassArea" style="display:none">
   <div class="form-group">
    <label for="regPassword"><i class="iconfont">&#xe607;</i>&nbsp;&nbsp;密码</label>
    <input type="password" class="form-control" id="regPassword" placeholder="大于6位密码">
  </div>
  <p style="display: none" id="regPwdResult"></p>
  <div class="form-group">
    <label for="regRePassword"><i class="iconfont">&#xe607;</i>&nbsp;&nbsp;确认密码</label>
    <input type="password" class="form-control" id="regRePassword" placeholder="请再次输入密码">
  </div>
  <button onclick="forgetPassSubmit()" class="btn btn-success  btn-block">重置密码</button><br>
  <button type="button" class="btn btn-danger  btn-block" onclick="resetPassBack()">上一步</button>
  </div>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="找回密码";
function showResetPassArea(){
	var phone_validate_code=$("#phone_validate_code").val();
	if(phone_validate_code.length<5){
		swal("错误", "请输入正确的验证码", "error");
		return;
	}
	var url="/open/checkMsgValidateCode?random="+Math.round(Math.random()*100);
	var params={msgCode:phone_validate_code};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				$("#resetPassVcheckArea").hide();
				$("#resetPassArea").show();
			}else{
				if(res.ret==620){
					swal("错误", "验证码输入错误", "error");
					return;
				}else if(res.ret==622){
					swal("错误", "验证码没有发送", "error");
					return;
				}else{
					swal("错误", "未知错误，请联系客服人员", "error");
					return;
				}
			}
		}
	});
}
function resetPassBack(){
	$("#resetPassVcheckArea").show();
	$("#resetPassArea").hide();
}
function forgetPassSubmit(){
	var phone_validate_code=$("#phone_validate_code").val();
	var resetType=$("#resetType").val();
	var newPassword=$("#regPassword").val();
	var newPassword2=$("#regRePassword").val();
	var regUserName=$("#regUserName").val();
	if(!checkPassword()&&!checkRePassword()){
		return;
	}
	var url="/open/doResetPassword?random="+Math.round(Math.random()*100);
	params={resetType:resetType,newPassword:newPassword,newPassword2:newPassword2,vcode:phone_validate_code,userName:regUserName};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				swal({
                  title: "成功",  
                  text: "重置密码成功，请牢记您的新密码",  
                  type: "success",  
                  showCancelButton: false,  
                  confirmButtonColor: "#A7D5EA",  
                  confirmButtonText: "确认" },
                  function(){  
                       window.location.href="/login.jsp";
                  });
			}else if(res.ret==622){
				swal("错误", "验证码没有发送", "error");
				return;
			}else if(res.ret==620){
				swal("错误", "验证码错误", "error");
				return;
			}else if(res.ret==903){
				swal("错误", "非法密码", "error");
				return;
			}else if(res.ret==904){
				swal("错误", "两次密码不一致", "error");
				return;
			}
		}
	});
}

</script>
<!-- page special -->
</body>
</html>