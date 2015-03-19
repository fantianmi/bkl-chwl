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
 if(u!=null){
 	if(u.getRole()==u.ROLE_NORMAL){
 		response.sendRedirect("user_index.jsp");
 		return;
 	}else{
 		response.sendRedirect("shop_index.jsp");
 		return;
 	}
 }
 String forwardUrl = request.getParameter("forward");
 if (forwardUrl == null) {
 	forwardUrl = "";
 }
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
	<script src="assets/scripts/chwl/forgetPass.js"></script>
</head>
<body class="drawer drawer-right">
<jsp:include page="top_nobutton.jsp"/>
<div class="content" style="margin-top:5.2rem;padding:1rem !important; ">
  <div id="checkRegUserName">
	  	<label for="regUserName"><i class="iconfont">&#xf0026;</i>&nbsp;&nbsp;找回账号</label>
     	<input type="text" class="form-control" placeholder="请输入您的点粉账号或点商账号"  size="14" id="regUserName">
	   <br>
	   <button class="btn btn-success btn-block" onclick="redirectCheckBindMobile()">下一步</button>
   </div>
  <div id="checkBindMobile">
    <input type="hidden" id="regUserMobile">
    <label for="loginUserName"><i class="iconfont">&#xf0026;</i>&nbsp;&nbsp;请输入绑定的手机号码</label>
    <input type="text" class="form-control" placeholder="请输入绑定的手机号码" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="11" size="14" id="phone_number">
   <br>
   <button onclick="showInputVcodeNum()" class="btn btn-success  btn-block">下一步</button><br>
  </div>
  
  <div id="inputVcodeNum">
	    <label for="loginUserName"><i class="iconfont">&#xf0026;</i>&nbsp;&nbsp;收到的验证码</label>
	    <input type="text" class="form-control" placeholder="5位验证码" onkeyup="this.value=this.value.replace(/\D/g,'')"  onafterpaste="this.value=this.value.replace(/\D/g,'')" maxlength="5" size="14" id="phone_validate_code">
	   <br>
	   <button onclick="showResetPassArea()" class="btn btn-success  btn-block">下一步</button><br>
  </div>
  
  <div id="resetPassArea" style="display:none">
   <div class="form-group">
    <label for="regPassword"><i class="iconfont">&#xe607;</i>&nbsp;&nbsp;密码</label>
    <input type="password" class="form-control" id="regPassword" placeholder="大于6位密码" onblur="checkPassword()">
    <p id="regPassword_error" class="error_msg"></p>
  </div>
  <p style="display: none" id="regPwdResult"></p>
  <div class="form-group">
    <label for="regRePassword"><i class="iconfont">&#xe607;</i>&nbsp;&nbsp;确认密码</label>
    <input type="password" class="form-control" id="regRePassword" placeholder="请再次输入密码" onblur="checkRePassword()">
    <p id="regRePassword_error" class="error_msg"></p>
  </div>
  <button onclick="forgetPassSubmit()" class="btn btn-success  btn-block">重置密码</button><br>
  </div>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="找回密码";
$("#checkRegUserName").show();
$("#checkBindMobile").hide();
$("#inputVcodeNum").hide();
$("#resetPassArea").hide();
function forgetPassSubmit(){
	var phone_validate_code=$("#phone_validate_code").val();
	var newPassword=$("#regPassword").val();
	var newPassword2=$("#regRePassword").val();
	var regUserName=$("#regUserName").val();
	if(!checkPassword()&&!checkRePassword()){
		return;
	}
	var url="/open/doResetPassword?random="+Math.round(Math.random()*100);
	params={newPassword:newPassword,newPassword2:newPassword2,vcode:phone_validate_code,userName:regUserName};
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