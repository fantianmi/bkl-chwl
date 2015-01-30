
function submitUserinfoForm(){
	 var nickName = document.getElementById("nikeName").value;
	 nickName = nickName.replace(/^\s*(.*?)[\s\n]*$/g,'$1');
	 if(nickName.length > 20){
		 okcoinAlert("昵称不能超过20个字符");
		 return;
	 }
	 var okcoin = nickName.toLowerCase().indexOf("okcoin"); 
	 if(okcoin!=-1){
		 okcoinAlert("昵称不能包含特殊字符");
		 return;
	 }
	 document.getElementById("userinfoForm").submit();
}

var fowTime = 5;
function resetPassword(){
	var regu = /^[0-9]{6}$/;
    var re = new RegExp(regu);
	var validateCodeType = 0;
	var  phoneCode = 0;
	var totpCode = 0;
	var oldPassword=$("#oldPassword").val();
	var newPassword = document.getElementById("newPassword").value;
	var newPassword2 = document.getElementById("newPassword2").value;
	var userId = document.getElementById("userId").value;
	var msg = isPassword(oldPassword);
	if(msg != ""){
		document.getElementById("msg0").innerHTML=msg;
		return ;
	}else{
		document.getElementById("msg0").innerHTML="";
	}
	msg = isPassword(newPassword);
	if(msg != ""){
		document.getElementById("msg1").innerHTML=msg;
		return ;
	}else{
		document.getElementById("msg1").innerHTML="";
	}
	if(newPassword != newPassword2){
		document.getElementById("msg2").innerHTML="两次密码输入不一致";
		document.getElementById("newPassword2").value = "";
		return ;
	}else{
		document.getElementById("msg2").innerHTML="";
	}
	var url = "/api/user/modifyPwd?random="+Math.round(Math.random()*100);
	var param={originPwd:oldPassword,newPwd:newPassword,newPassword2:newPassword2,uid:userId};
	jQuery.post(url,param,function(result){
		if(result.ret == 0){
			swal({
                title: "成功",  
                text: "修改密码成功，请牢记您的新密码",  
                type: "success",  
                showCancelButton: false,  
                confirmButtonColor: "#A7D5EA",  
                confirmButtonText: "确认" },
                function(){  
                     window.location.href="/user_detail.jsp";
                });
		} else if(result.ret == 904){
			document.getElementById("msg2").innerHTML="两次密码输入不一致";
			document.getElementById("newPassword2").value = "";
		} else if(result.ret == 905){
			document.getElementById("msg1").innerHTML="登录密码不允许与交易密码一致";
			document.getElementById("newPassword").value = "";
			document.getElementById("newPassword2").value = "";
		} else if(result.ret == 611){
			document.getElementById("msg0").innerHTML="密码没有设置";
		}else if(result.ret == 901){
			document.getElementById("msg0").innerHTML="原密码没有输入";
		}else if(result.ret == 902){
			document.getElementById("msg0").innerHTML="原密码输入错误";
		}else if(result.ret == 903){
			document.getElementById("msg0").innerHTML="新密码需不小于6位";
		}
	});
}

function isPassword(pwd){
	var desc = "";
	if(pwd == ""){
		desc="请输入密码！";
	}else if(pwd.length <6){
		desc="密码长度不能小于6！";
	}else if(pwd.length>16){
		desc="密码长度不能大于16！";
	}
	return desc;
}
var secs = 121;
function sendMsg(){
	var type = document.getElementById("messageType").value;
	var url = "/user/sendMsg.do?random="+Math.round(Math.random()*100);
	var param = {type:type};
	jQuery.post(url,param,function(data){
		if(data == 0){
			document.getElementById("msgCodeBtn").disabled = true;
			 for(var num=1;num<=secs;num++) {
				  window.setTimeout("updateNumber(" + num + ")", num * 1000);
			  }
		}else if(data == -2){
			document.getElementById("phoneCodeTips").innerHTML="您没有绑定手机";
		}else if(data == -3){
			document.getElementById("phoneCodeTips").innerHTML="短信验证码错误多次，请2小时后再试！";
		}else if(data == -1){
			okcoinAlert("请求超时");
		}
	});
}
function updateNumber(num){
	if (num == secs) {
		document.getElementById("msgCodeBtn").value="发送验证码";
		document.getElementById("msgCodeBtn").disabled = false;
	} else {
		var printnr = secs - num;
		document.getElementById("msgCodeBtn").value= printnr +"秒后可重发";
	}
}

function queryEmail(){
	var email = document.getElementById("uemail").value;
	if(!checkEmail(email)){
		document.getElementById("emailMsg").innerHTML = "邮箱格式不正确";
		return;
	}else{
		document.getElementById("emailMsg").innerHTML = "&nbsp;";
	}
	var url = "/open/resetPassword?random="+Math.round(Math.random()*100);
	var param = {email:email};
	jQuery.post(url,param,function(result){
		if(result.ret == 0){
			window.location.href = "/confirmResetPassword.jsp";
		} else if(result.ret == 607){
			document.getElementById("emailMsg").innerHTML = "邮箱格式不正确";
		} else if(result.ret == 609){
			document.getElementById("emailMsg").innerHTML = "帐户不存在";
		} else if(result.ret == 610){
			document.getElementById("emailMsg").innerHTML = "邮件发送失败请重新点击发送";
		}
	});
}

function showChangeConfigure(){
	document.getElementById("changeConfigure").style.display="";
	dialogBoxShadow(false);
	addMoveEvent("dialog_title_configure","dialog_content_configure");
}

function closeChangeConfigure(){
	dialogBoxHidden();
	document.getElementById("changeConfigure").style.display="none";
}
function configureSubmit(){
	var changeTotpCode = 0;
	var changePhoneCode = 0;
	var regu = /^[0-9]{6}$/;
    var re = new RegExp(regu);
    var desc = "";
	if(document.getElementById("configureTotpCode")!= null ){
		changeTotpCode = document.getElementById("configureTotpCode").value;
		if (!re.test(changeTotpCode)) {
	    	desc='谷歌验证码不合法';	
	    }
		if(desc!=""){
			document.getElementById("configureTotpCodeTips").innerHTML="";
			document.getElementById("configureTotpCodeTips").innerHTML=desc;
			return;
		}else{
			document.getElementById("configureTotpCodeTips").innerHTML="&nbsp;";
		}
	}
	if(document.getElementById("configurePhoneCode")!= null ){
		changePhoneCode = document.getElementById("configurePhoneCode").value;
	    if (!re.test(changePhoneCode)) {
	    	desc='短信验证码不合法';	
	    }
		if(desc!=""){
			document.getElementById("configurePhoneCodeTips").innerHTML="";
			document.getElementById("configurePhoneCodeTips").innerHTML=desc;
			return;
		}else{
			document.getElementById("configurePhoneCodeTips").innerHTML="&nbsp;";
		}
	}
	var url = "/user/openTradePwd.do?random="+Math.round(Math.random()*100);
	var param={totpCode:changeTotpCode,phoneCode:changePhoneCode};
	jQuery.post(url,param,function(data){
		var result = eval('(' + data + ')');
		if(result!=null){
			 if(result.resultCode == -11){
				 document.getElementById("configureTotpCodeTips").innerHTML="谷歌验证码不合法";
			 }else if(result.resultCode == -12){
				 document.getElementById("configurePhoneCodeTips").innerHTML="短信验证码不合法";
			 }else if(result.resultCode == -8){
				 if(result.errorNum == 0){
					 document.getElementById("configureTotpCodeTips").innerHTML="谷歌验证码错误多次，请2小时后再试！";
				 }else{
					 document.getElementById("configureTotpCodeTips").innerHTML="谷歌验证码错误！您还有"+result.errorNum+"次机会";
					 document.getElementById("configureTotpCode").value = "";
				 }
			 }else if(result.resultCode == -9){
				 if(result.errorNum == 0){
					 document.getElementById("configurePhoneCodeTips").innerHTML="短信验证码错误多次，请2小时后再试！";
				 }else{
					 document.getElementById("configurePhoneCodeTips").innerHTML="短信验证码错误！您还有"+result.errorNum+"次机会";
					 document.getElementById("configurePhoneCode").value = "";
				 }
			 }else if(result.resultCode == 0){
				 closeChangeConfigure();
				 var callback={okBack:function(){window.location.href= document.getElementById("coinMainUrl").value+"/security.do";},noBack:function(){window.location.href= document.getElementById("coinMainUrl").value+"/security.do";}};
					okcoinAlert("修改成功！",null,callback);
			 }
		}
	});
}

function openConfigure(){
	if(confirm("确定关闭交易密码交易时免输吗？")){
		var url = "/user/openTradePwd.do?random="+Math.round(Math.random()*100);
		jQuery.post(url,null,function(data){
			var result = eval('(' + data + ')');
			if(result!=null){
				if(result.resultCode == 0){
					 closeChangeConfigure();
					 var callback={okBack:function(){window.location.href= document.getElementById("coinMainUrl").value+"/security.do";},noBack:function(){window.location.href= document.getElementById("coinMainUrl").value+"/security.do";}};
						okcoinAlert("修改成功！",null,callback);
				 }
			}
		});
	}
}

function validateIdentity(){
	var realName = document.getElementById("realName").value;
	var identityType = document.getElementById("identityType").value;
	var identityNo = document.getElementById("identityNo").value;
	var identityPhoto = "";
	if(document.getElementById("identityPhoto")) {
		identityPhoto = document.getElementById("identityPhoto").value;
	}
	if(realName == ""){
		document.getElementById("errorMessage").innerHTML = "请填写姓名";
		return;
	}else{
		document.getElementById("errorMessage").innerHTML = "&nbsp;";
	}
	var realName2 = document.getElementById("realName2").value;
	if(realName != realName2){
		document.getElementById("errorMessage").innerHTML = "两次输入的姓名不一致";
		return;
	}else{
		document.getElementById("errorMessage").innerHTML = "&nbsp;";
	}
	if(identityNo == ""){
		document.getElementById("errorMessage").innerHTML = "请填写证件号码";
		return;
	}else{
		document.getElementById("errorMessage").innerHTML = "&nbsp;";
	}
	if(identityType == 0){
		var isIDCard = /(^\d{15}$)|(^\d{18}$)|(^\d{17}(\d|X|x)$)/;
		var re = new RegExp(isIDCard);
		if (!re.test(identityNo)) {
			document.getElementById("errorMessage").innerHTML = "请填写正确身份证号码";	
	    	return;
	    }
	}else{
		if(identityNo.length <= 5){
			document.getElementById("errorMessage").innerHTML = "证件号码不合法";	
	    	return;
		}
	}
	if(document.getElementById("identityPhoto") && identityPhoto == ""){
		document.getElementById("errorMessage").innerHTML = "请上传证件图片";
		return;
	}else{
		document.getElementById("errorMessage").innerHTML = "&nbsp;";
	}
	document.getElementById("validateIdentityForm").submit();
}

function checkRealName(){
	var realName = document.getElementById("realName").value;
	var realName2 = document.getElementById("realName2").value;
	if(realName != realName2){
		document.getElementById("errorMessage").innerHTML = "两次输入的姓名不一致";
	}
}
