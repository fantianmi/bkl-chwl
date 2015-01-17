function modifyPwd(type){
	document.getElementById("pwdType").value=type;
	if(type == 0){
		document.getElementById("messageType").value = 12;
		document.getElementById("pwdTitle").innerHTML="修改登录密码";
		document.getElementById("originPwdTitle").innerHTML="请输入原登录密码：";
		document.getElementById("newPwdTitle").innerHTML="请输入新登录密码：";
		document.getElementById("reNewTitle").innerHTML="请再输入一次密码：";
		document.getElementById("originPwdLi").style.display="";
		document.getElementById("tradePwdTips").style.display="none";
	}else if(type == 1){
//		if(document.getElementById("isEmptyPhone") !=null && document.getElementById("isEmptyPhone").value==1&&document.getElementById("isEmptyAuth") !=null && document.getElementById("isEmptyAuth").value==1){
//			bindAuth();
//			return;
//		}
		document.getElementById("messageType").value = 4;
		document.getElementById("pwdTitle").innerHTML="为了您的帐户安全，请设置交易密码";
		document.getElementById("originPwdTitle").innerHTML="请输入原交易密码：";
		document.getElementById("newPwdTitle").innerHTML="请输入新交易密码：";
		document.getElementById("reNewTitle").innerHTML="请再输入一次密码：";
		document.getElementById("tradePwdTips").style.display="";
		document.getElementById("originPwdLi").style.display="";
		if(document.getElementById("totpCode") !=null){
			document.getElementById("totpCode").value="";
		}
		if(document.getElementById("phoneCode") !=null){
			document.getElementById("phoneCode").value="";
		}
	}else{
		document.getElementById("messageType").value = 4;
		document.getElementById("pwdTitle").innerHTML="为了您的帐户安全，请设置交易密码";
		document.getElementById("newPwdTitle").innerHTML="请输入新交易密码：";
		document.getElementById("reNewTitle").innerHTML="请再输入一次密码：";
		document.getElementById("originPwdLi").style.display="none";
		document.getElementById("tradePwdTips").style.display="none";
	}
	if(document.getElementById("tradePwdTotpCode") !=null){
		document.getElementById("tradePwdTotpCode").value="";
	}
	if(document.getElementById("tradePwdPhoneCode") !=null){
		document.getElementById("tradePwdPhoneCode").value="";
	}
	if(document.getElementById("totpCodeTips") !=null){
		document.getElementById("totpCodeTips").innerHTMl="";
	}
	if(document.getElementById("phoneCodeTips") !=null){
		document.getElementById("phoneCodeTips").innerHTMl="";
	}
	document.getElementById("originPwd").value="";
	document.getElementById("newPwd").value="";
	document.getElementById("reNewPwd").value="";
	document.getElementById("originPwdTips").innerHTML="";
	document.getElementById("newPwdTips").innerHTML="";
	document.getElementById("reNewPwdTips").innerHTML="";
	dialogBoxShadow();
	document.getElementById("modifyPwd").style.display="";
	document.getElementById("newPwd").focus();
}
function sendPassWordMsgCode(){
	var type = document.getElementById("messageType").value;
	sendMsgCode(type);
}
function closePwd(){
	dialogBoxHidden();
	document.getElementById("modifyPwd").style.display="none";
}
function submitPwdForm(){
	var pwdType = document.getElementById("pwdType").value;
	var originPwd = trim(document.getElementById("originPwd").value);
	var newPwd = trim(document.getElementById("newPwd").value);
	var reNewPwd = trim(document.getElementById("reNewPwd").value);
	
	var originPwdTips = isPassword(originPwd);
	var newPwdTips = isPassword(newPwd);
	var reNewPwdTips = isPassword(reNewPwd);
	
	if(pwdType < 2 && originPwdTips!=""){
		document.getElementById("originPwdTips").innerHTML="";
		document.getElementById("originPwdTips").innerHTML=originPwdTips;
		return;
	}else{
		document.getElementById("originPwdTips").innerHTML="";
	}
	 if( newPwdTips!=""){
		document.getElementById("newPwdTips").innerHTML="";
		document.getElementById("newPwdTips").innerHTML=newPwdTips;
		return;
	}else{
		document.getElementById("newPwdTips").innerHTML="";
	}
	if( reNewPwdTips!=""){
		document.getElementById("reNewPwdTips").innerHTML="";
		document.getElementById("reNewPwdTips").innerHTML=reNewPwdTips;
		return;
	}else if(newPwd != reNewPwd){
		document.getElementById("reNewPwdTips").innerHTML="";
		document.getElementById("reNewPwdTips").innerHTML="两次输入密码不相同！";
		document.getElementById("reNewPwd").value = "";
		return;
	}else{
		document.getElementById("reNewPwdTips").innerHTML="";
	}
	var  phoneCode = "";
	var totpCode = "";
//	if(document.getElementById("tradePwdPhoneCode") != null){
//		phoneCode = trim(document.getElementById("tradePwdPhoneCode").value);
//		if(phoneCode == "" || phoneCode.length!=6){
//			document.getElementById("phoneCodeTips").innerHTML="短信验证码输入不合法";
//			return;
//		}else{
//			document.getElementById("phoneCodeTips").innerHTML="&nbsp;";
//		}
//	}
//	if(document.getElementById("tradePwdTotpCode") != null){
//		totpCode = trim(document.getElementById("tradePwdTotpCode").value);
//		if(totpCode == "" || totpCode.length!=6){
//			document.getElementById("totpCodeTips").innerHTML="谷歌验证码输入不合法";
//			return;
//		}else{
//			document.getElementById("totpCodeTips").innerHTML="&nbsp;";
//		}
//	}
//	if(document.getElementById("phoneCodeLi") == null && document.getElementById("totpCodeLi") == null){
//		document.getElementById("messageSpan").innerHTML="您没有绑定手机或谷歌验证暂不允许修改密码。";
//		return;
//	}
	var url = "/api/user/modifyPwd?random="+Math.round(Math.random()*100);
	var param={originPwd:originPwd, newPwd:newPwd, reNewPwd:reNewPwd, pwdType:pwdType};
	jQuery.post(url,param,function(result){
		if(result!=null){
			if(result.ret == 0){
				if(pwdType == 2 && document.getElementById("tradePwdSpan")!=null){
					document.getElementById("tradePwdSpan").innerHTML="<a  href='javascript:void(0);' onclick='javascript:modifyPwd(1);'>修改</a>";
				}
				document.getElementById("originPwdTips").innerHTML="";
				document.getElementById("newPwdTips").innerHTML="";
				document.getElementById("reNewPwdTips").innerHTML="";
				closePwd();
				if(pwdType == 2){
					document.getElementById("modifyResultTips").innerHTML="设置成功";
				}else{
					document.getElementById("modifyResultTips").innerHTML="修改成功";
				}
				setTimeout(function(){document.getElementById("modifyResultTips").innerHTML="";}, 3000); 
			}else if(result.ret == 903){
				document.getElementById("newPwdTips").innerHTML="新密码不合法！";
			 }else if(result.ret == 904){
				 document.getElementById("reNewPwdTips").innerHTML="两次输入密码不相同！";
				 document.getElementById("reNewPwd").value = "";
			 }else if(result.ret == 901){
				 document.getElementById("originPwdTips").innerHTML="请输入密码！";
			 }else if(result.ret == 902){
				 document.getElementById("originPwdTips").innerHTML="原密码不正确！";
				 document.getElementById("originPwd").value = "";
//			 }else if(result.code == -6){
//				 if(result.errorNum == 0){
//					 document.getElementById("totpCodeTips").innerHTML="谷歌验证码错误多次，请2小时后再试！";
//				 }else{
//					 document.getElementById("totpCodeTips").innerHTML="谷歌验证码错误！您还有"+result.errorNum+"次机会";
//					 document.getElementById("tradePwdTotpCode").value = "";
//				 }
//			 }else if(result.code == -7){
//				 document.getElementById("phoneCodeTips").innerHTML="短信验证码错误多次，请2小时后再试！";
//				 if(result.errorNum == 0){
//				 }else{
//					 document.getElementById("phoneCodeTips").innerHTML="短信验证码错误！您还有"+result.errorNum+"次机会";
//					 document.getElementById("tradePwdPhoneCode").value = "";
//				 }
//			 }else if(result.code == -8){
//				 document.getElementById("phoneCodeTips").innerHTML="短信验证码输入错误";
//			 }else if(result.resultCode == -9){
//				 document.getElementById("totpCodeTips").innerHTML="谷歌验证码输入错误";
//			}else if(result.code == -10){
//				if(pwdType == 0){
//				   document.getElementById("newPwdTips").innerHTML="登录密码不允许与交易密码一致";
//				}else if(pwdType == 1 || pwdType == 2){
//					document.getElementById("newPwdTips").innerHTML="交易密码不允许与登录密码一致";
//				}
//			}else if(result.code == -13){
//				document.getElementById("messageSpan").innerHTML="您没有绑定手机或谷歌验证暂不允许修改密码。";
			}
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