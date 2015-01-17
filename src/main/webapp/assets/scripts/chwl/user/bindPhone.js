/**
 * 绑定手机号
 */
function showValidatePhone(type){
	dialogBoxShadow(false);
	if(type == 1){
		document.getElementById("newValidatePhoneDiv").style.display = "";
		addMoveEvent("dialog_title_phone","dialog_content_phone");
		document.getElementById("validatePhone").style.display="";
	}else{
		callbackEnter(submitValidatePhoneForm);
		addMoveEvent("dialog_title_phone","dialog_content_phone");
		document.getElementById("oldValidatePhoneDiv").style.display = "";
		document.getElementById("validatePhone").style.display="";
		document.getElementById("validatePhoneNumber").focus();
		document.getElementById("validatePhoneNumber").value="";
		document.getElementById("validatePhoneCode").value="";
		document.getElementById("infoTips").innerHTML="";
	}
}

function closeValidatePhone(){
	dialogBoxHidden();
	document.getElementById("validatePhone").style.display="none";
}

function submitValidatePhone(){
	var phone = document.getElementById("validatePhoneNumber").value;
	var desc='';
	//验证手机号
	if(phone.indexOf(" ")>-1){
		desc='手机号包含空格!';
	}else {
		if(phone==''){
				desc='请您输入手机号!'; 	
			}
		else if(!checkMobile(phone)){ 
				desc='手机号格式不正确';	
		}
	}
	if(desc!=""){
		document.getElementById("infoTips").innerHTML="";
		document.getElementById("infoTips").innerHTML=desc;
		return;
	}else{
		document.getElementById("infoTips").innerHTML="&nbsp;";
	}
	
	var url = "/user/sendValidateCode.do?random="+Math.round(Math.random()*100);
	var param={phone:phone};
	jQuery.post(url,param,function(data){
		 if(data == 0){
			 document.getElementById("infoTips").innerHTML="";
			 document.getElementById("validatePhoneNumber").disabled="true";
			 document.getElementById("msgCodeBindBtn").disabled = true;
			  for(num=1;num<=secs;num++) {
				  window.setTimeout("updateNumberBind(" + num + ")", num * 1000);
			   }
		 }else if(data == -2){
			 desc='手机号格式不正确';	
			 document.getElementById("infoTips").innerHTML=desc;
		 }else if(data == -3){
			 desc='该手机号已存在';
			 document.getElementById("infoTips").innerHTML=desc;
		 }else if(data == -4){
			 desc='  ';
			 document.getElementById("infoTips").innerHTML=desc;
		 }
	});
}

function submitValidatePhoneForm(){
	var phone = document.getElementById("validatePhoneNumber").value;
	var code = document.getElementById("validatePhoneCode").value;
	var totpCode = 0;
	var desc='';
	if(phone.indexOf(" ")>-1){
		desc='手机号包含空格!';
	}else {
		if(phone==''){
				desc='请您输入手机号!'; 	
			}
		else if(!checkMobile(phone)){ 
				desc='手机号格式不正确';	
		}
	}
	if(code.indexOf(" ")>-1 || code.length !=6){
		desc='手机验证码不合法';	
	}
	if(document.getElementById("totpCode") != null){
		totpCode = document.getElementById("totpCode").value;
		if(totpCode.indexOf(" ")>-1 || totpCode.length !=6){
			desc='谷歌验证码不合法';	
		}
	}
	if(desc!=""){
		document.getElementById("infoTips").innerHTML="";
		document.getElementById("infoTips").innerHTML=desc;
		return;
	}else{
		document.getElementById("infoTips").innerHTML="&nbsp;";
	}
	
	var url = "/user/validatePhone.do?random="+Math.round(Math.random()*100);
	var param={phone:phone,code:code,totpCode:totpCode};
	jQuery.post(url,param,function(data){
		var result = eval('(' + data + ')');
		if(result!=null){
			if(result.resultCode == 0){
				 document.getElementById("infoTips").innerHTML="";
				 if(document.getElementById("userPhoneSpan")!=null){
					 document.getElementById("userPhoneSpan").innerHTML=phone;
				 }
				 if(document.getElementById("isEmptyPhone") !=null ){
					 document.getElementById("isEmptyPhone").value="0";
				 }
				 closeValidatePhone();
				 var callback={okBack:function(){window.location.href= document.getElementById("coinMainUrl").value+"/security.do";},noBack:function(){window.location.href= document.getElementById("coinMainUrl").value+"/security.do";}};
				 okcoinAlert("手机号绑定成功！", null, callback);
			 }else if(result.resultCode == -5){
				 document.getElementById("infoTips").innerHTML="已经绑定过手机";
			 }else if(result.resultCode == -6){
				 document.getElementById("infoTips").innerHTML="手机号不合法";
			 }else if(result.resultCode == -7){
				 document.getElementById("infoTips").innerHTML="手机号已被绑定";
			 }else if(result.resultCode == -9){
				 if(result.errorNum == 0){
					 document.getElementById("infoTips").innerHTML="手机验证码错误多次，请2小时后再试！";
				 }else{
					 document.getElementById("infoTips").innerHTML="手机验证码错误！您还有"+result.errorNum+"次机会";
					 document.getElementById("validatePhoneCode").value = "";
				 }
			 }else if(result.resultCode == -11){
				 document.getElementById("infoTips").innerHTML="谷歌验证码不合法";
			 }else if(result.resultCode == -8){
				 if(result.errorNum == 0){
					 document.getElementById("infoTips").innerHTML="谷歌验证码错误多次，请2小时后再试！";
				 }else{
					 document.getElementById("infoTips").innerHTML="谷歌验证码错误！您还有"+result.errorNum+"次机会";
					 document.getElementById("totpCode").value = "";
				 }
			 }else if(result.resultCode == -12){
				 document.getElementById("infoTips").innerHTML="短信验证码格式不正确";
			 }
		}
	});
}

function updateNumberBind(num) {
	if (num == secs) {
		document.getElementById("msgCodeBindBtn").value="发送验证码";
		document.getElementById("msgCodeBindBtn").disabled = false;
		if(document.getElementById("validatePhoneNumber")!=null){
			document.getElementById("validatePhoneNumber").disabled = false;
		}
	} else {
		var printnr = secs - num;
		document.getElementById("msgCodeBindBtn").value=printnr +"秒后可重发";
	}
}

/**
 * 绑定google authenticator
 */
function showBindAuthenticator(){
	var url = "/user/googleAuth.do?random="+Math.round(Math.random()*100);
	var param=null;
	document.getElementById("googleInfoTips").innerHTML="";
	document.getElementById("bindAuthenticatorValidateTotpCode").value = "";
	if( document.getElementById("bindAuthenticatorPhoneCode") != null ){
		document.getElementById("bindAuthenticatorPhoneCode").value = "";
	}
	jQuery.post(url,param,function(data){
		var result = eval('(' + data + ')');
		if(result!=null){
			if(result.resultCode == 0){
				document.getElementById("bindAuthenticator").style.display="";
				dialogBoxShadow(false);
				addMoveEvent("dialog_title_google","dialog_content_google");
				if(navigator.userAgent.indexOf("MSIE")>0) { 
					jQuery('#qrcode').qrcode({text:result.qecode,width:"150",height:"150",render:"table"}); 
				} else{
					jQuery('#qrcode').qrcode({text:result.qecode,width:"150",height:"150"}); 
				}
				document.getElementById("totpKey").value = result.totpKey;
				document.getElementById("bindAuthenticatorValidateTotpCode").focus();
				callbackEnter(submitValidateAuthenticatorForm);
			}
		}
	});
}

function closeBindAuthenticator(){
	dialogBoxHidden();
	if(document.getElementById("validateTotpCode") != null){
		document.getElementById("validateTotpCode").value="";
	}
	document.getElementById("qrcode").innerHTML="";
	document.getElementById("bindAuthenticator").style.display="none";
}

function securitySendMsg(){
	var type = document.getElementById("messageType").value;
	sendMsgCode(type);
}

function submitValidateAuthenticatorForm(){
	if(document.getElementById("bindAuthenticatorValidateTotpCode") == null){
		return;
	}
	var code = document.getElementById("bindAuthenticatorValidateTotpCode").value;
	var totpKey = document.getElementById("totpKey").value;
	var phoneCode = 0;
	var desc='';
	if( document.getElementById("bindAuthenticatorPhoneCode") != null ){
		phoneCode = document.getElementById("bindAuthenticatorPhoneCode").value;
		if(phoneCode.indexOf(" ")>-1 || phoneCode.length !=6){
			desc='手机验证码不合法';	
		}
	}
	if(code.indexOf(" ")>-1 || code.length !=6){
		desc='谷歌验证码不合法';	
	}
	if(desc!=""){
		document.getElementById("googleInfoTips").innerHTML="";
		document.getElementById("googleInfoTips").innerHTML=desc;
		return;
	}else{
		document.getElementById("googleInfoTips").innerHTML="&nbsp;";
	}
	
	var url = "/user/validateAuthenticator.do?random="+Math.round(Math.random()*100);
	var param={code:code,totpKey:totpKey,phoneCode:phoneCode};
	jQuery.post(url,param,function(data){
		var result = eval('(' + data + ')');
		if(result!=null){
			if(result.resultCode == 0){
				closeBindAuthenticator();
				var callback={okBack:function(){window.location.href= document.getElementById("coinMainUrl").value+"/security.do";},noBack:function(){window.location.href= document.getElementById("coinMainUrl").value+"/security.do";}};
				okcoinAlert("设备添加成功！",null,callback);
			 }else if(result.resultCode == -11){
				 document.getElementById("googleInfoTips").innerHTML="谷歌验证码不合法";
			 }else if(result.resultCode == -12){
				 document.getElementById("changeTotpCodeTips").innerHTML="短信验证码不合法";
			 }else if(result.resultCode == -3){
				 if(result.errorNum == 0){
					 document.getElementById("googleInfoTips").innerHTML="谷歌验证码错误多次，请2小时后再试！";
				 }else{
					 document.getElementById("googleInfoTips").innerHTML="谷歌验证码错误！您还有"+result.errorNum+"次机会";
					 document.getElementById("bindAuthenticatorValidateTotpCode").value = "";
				 }
			 }else if(result.resultCode == -9){
				 if(result.errorNum == 0){
					 document.getElementById("googleInfoTips").innerHTML="短信验证码错误多次，请2小时后再试！";
				 }else{
					 document.getElementById("googleInfoTips").innerHTML="短信验证码错误！您还有"+result.errorNum+"次机会";
					 document.getElementById("bindAuthenticatorPhoneCode").value = "";
				 }
			 }
		}
	});
}
/**
 * 修改身份验证类型
 * authType 0:手机 1:google
 * bindType 1:手机不为空 2:key不为空 3:都不空
 */
function changeAuthenticator(authType,bindType,obj){
	document.getElementById("messageType").value = 5;
	document.getElementById("changeAuthCode").onkeydown = function (e){
		callbackEnter(submitChangeAuthForm);
	};
	document.getElementById("submitBtn").onclick = submitChangeAuthForm;
	document.getElementById("changeAuthenticator").style.display="";
	dialogBoxShadow(false);
	document.getElementById("changeAuthCode").value = "";
	document.getElementById("changeAuthTips").innerHTML = "";
	addMoveEvent("dialog_title_auth","dialog_content_auth");
	if(authType == 0 && bindType ==1){
		closeChangeAuthenticator();
		okcoinAlert("暂未添加谷歌身份认证，不能开启手机短信验证",null,null);
		return false;
	}else if(authType == 1 && bindType ==2){
		closeChangeAuthenticator();
		okcoinAlert("暂未添加手机短信验证，不能开启谷歌身份认证",null,null);
		return false;
	}else{
		if(authType ==0){
			document.getElementById("changeAuthMsg").style.display="";
		}else{
			document.getElementById("changeAuthMsg").style.display="none";
		}
	}
	document.getElementById("msgSpan").innerHTML = "更改安全中心设置";
}
function closeChangeAuthenticator(){
	dialogBoxHidden();
	document.getElementById("changeAuthenticator").style.display="none";
}
function submitChangeAuthForm(){
	var changeTotpCode = 0;
	var changePhoneCode = 0;
	var desc='';
	var operationType = document.getElementById("operationType").value;
	var validateCodeType = document.getElementById("validateCodeType").value;
	var regu = /^[0-9]{6}$/;
    var re = new RegExp(regu);
	if(document.getElementById("changeTotpCode")!= null &&( validateCodeType == 2 || operationType == 1)){
		changeTotpCode = document.getElementById("changeTotpCode").value;
		if (!re.test(changeTotpCode)) {
	    	desc='谷歌验证码不合法';	
	    }
		if(desc!=""){
			document.getElementById("changeTotpCodeTips").innerHTML="";
			document.getElementById("changeTotpCodeTips").innerHTML=desc;
			return;
		}else{
			document.getElementById("changeTotpCodeTips").innerHTML="&nbsp;";
		}
	}
	if(document.getElementById("changePhoneCode")!= null  && operationType != 1 && document.getElementById("phoneCodeLi").style.display == "block"){
		changePhoneCode = document.getElementById("changePhoneCode").value;
	    if (!re.test(changePhoneCode)) {
	    	desc='短信验证码不合法';	
	    }
		if(desc!=""){
			document.getElementById("changePhoneCodeTips").innerHTML="";
			document.getElementById("changePhoneCodeTips").innerHTML=desc;
			return;
		}else{
			document.getElementById("changePhoneCodeTips").innerHTML="&nbsp;";
		}
	}
	var url = "/user/changeValidateCode.do?random="+Math.round(Math.random()*100);
	var param={totpCode:changeTotpCode,phoneCode:changePhoneCode,operationType:operationType,validateCodeType:validateCodeType};
	jQuery.post(url,param,function(data){
		var result = eval('(' + data + ')');
		if(result!=null){
			if(result.resultCode == 0){
				if(document.getElementById("changeTotpCode")!= null){
					document.getElementById("changeTotpCode").value="";
				}
				if(document.getElementById("changePhoneCode")!= null){
					document.getElementById("changePhoneCode").value="";
				}
				closeChangeAuthenticator();
				var callback={okBack:function(){window.location.href= document.getElementById("coinMainUrl").value+"/security.do";},noBack:function(){window.location.href= document.getElementById("coinMainUrl").value+"/security.do";}};
				okcoinAlert("验证修改成功！",null,callback);
			 }else if(result.resultCode == -2){
				 document.getElementById("changeTotpCodeTips").innerHTML="谷歌验证码不合法";
			 }else if(result.resultCode == -3){
				 document.getElementById("changePhoneCodeTips").innerHTML="短信验证码不合法";
			 }else if(result.resultCode == -4){
				 document.getElementById("changeTotpCodeTips").innerHTML="未绑定谷歌";
			 }else if(result.resultCode == -5 ){
				 document.getElementById("changeTotpCodeTips").innerHTML="未开启短信验证，不允许关闭谷歌！";
			 }else if(result.resultCode == -6 ){
				 document.getElementById("changePhoneCodeTips").innerHTML="未绑定手机";
			 }else if(result.resultCode == -7){
				 document.getElementById("changePhoneCodeTips").innerHTML="未开启谷歌 不允许关闭手机";
			 }else if(result.resultCode == -8){
				 if(result.errorNum == 0){
					document.getElementById("changeTotpCodeTips").innerHTML="谷歌验证码错误多次，请2小时后再试！";
				}else{
					document.getElementById("changeTotpCodeTips").innerHTML="谷歌验证码错误！您还有"+result.errorNum+"次机会";
					document.getElementById("changeTotpCode").value = "";
				}
			 }else if(result.resultCode == -9){
				 if(result.errorNum == 0){
						document.getElementById("changePhoneCodeTips").innerHTML="短信验证码错误多次，请2小时后再试！";
				}else{
					document.getElementById("changePhoneCodeTips").innerHTML="短信验证码错误！您还有"+result.errorNum+"次机会";
					document.getElementById("changePhoneCode").value = "";
				}
			 }else if(result.resultCode == -11){
				 document.getElementById("changeTotpCodeTips").innerHTML="谷歌验证码格式不正确";
			 }else if(result.resultCode == -12){
				 document.getElementById("changePhoneCodeTips").innerHTML="短信验证码格式不正确";
			 }
		}
	});
}

function submitCode(){
	var totpCode = 0;
	var phoneCode = 0;
	var desc='';
	var isEmptyPhone = document.getElementById("isEmptyPhone").value;
	if(isEmptyPhone == 1 && document.getElementById("totpCodeLi")!= null){
		totpCode = document.getElementById("changeTotpCode").value;
		if(totpCode.indexOf(" ")>-1 || totpCode.length !=6){
			desc='谷歌验证码不合法';	
		}
		if(desc!=""){
			document.getElementById("changeTotpCodeTips").innerHTML="";
			document.getElementById("changeTotpCodeTips").innerHTML=desc;
			return;
		}else{
			document.getElementById("changeTotpCodeTips").innerHTML="&nbsp;";
		}
	}
	if(isEmptyPhone == 0 && document.getElementById("phoneCodeLi")!= null){
		phoneCode = document.getElementById("changePhoneCode").value;
		if(phoneCode.indexOf(" ")>-1 || phoneCode.length !=6){
			desc='短信验证码不合法';	
		}
		if(desc!=""){
			document.getElementById("changePhoneCodeTips").innerHTML="";
			document.getElementById("changePhoneCodeTips").innerHTML=desc;
			return;
		}else{
			document.getElementById("changePhoneCodeTips").innerHTML="&nbsp;";
		}
	}
	var url = "/user/getGoogleTotpKey.do?random="+Math.round(Math.random()*100);
	var param={totpCode:totpCode,phoneCode:phoneCode};
	jQuery.post(url,param,function(data){
		var result = eval('(' + data + ')');
		if(result!=null){
			 if(result.resultCode == -11){
				 document.getElementById("changeTotpCodeTips").innerHTML="谷歌验证码不合法";
			 }else if(result.resultCode == -12){
				 document.getElementById("changePhoneCodeTips").innerHTML="短信验证码不合法";
			 }else if(result.resultCode == -8){
				 if(result.errorNum == 0){
					 document.getElementById("changeTotpCodeTips").innerHTML="谷歌验证码错误多次，请2小时后再试！";
				 }else{
					 document.getElementById("changeTotpCodeTips").innerHTML="谷歌验证码错误！您还有"+result.errorNum+"次机会";
					 document.getElementById("changeTotpCode").value = "";
				 }
			 }else if(result.resultCode == -9){
				 if(result.errorNum == 0){
					 document.getElementById("changePhoneCodeTips").innerHTML="短信验证码错误多次，请2小时后再试！";
				 }else{
					 document.getElementById("changePhoneCodeTips").innerHTML="短信验证码错误！您还有"+result.errorNum+"次机会";
					 document.getElementById("changePhoneCode").value = "";
				 }
			 }else if(result.resultCode == 0){
				dialogBoxHidden();
				document.getElementById("changeAuthenticator").style.display = "none";
				if(result.resultCode == 0){
					document.getElementById("bindAuthenticator").style.display="";
					dialogBoxShadow(false);
					addMoveEvent("dialog_title_google","dialog_content_google");
					if(navigator.userAgent.indexOf("MSIE")>0) { 
						jQuery('#qrcode').qrcode({text:result.qecode,width:"150",height:"150",render:"table"}); 
					} else{
						jQuery('#qrcode').qrcode({text:result.qecode,width:"150",height:"150"}); 
					}
					document.getElementById("totpKey").value = result.totpKey;
					document.getElementById("titleSpan").innerHTML = "谷歌身份验证器";
					document.getElementById("authright").innerHTML = "";
					document.getElementById("authleft").style.textAlign =  "center";
					document.getElementById("dialog_content_google").style.width =  "250px";
					document.getElementById("bindAuthenticator").focus();
					callbackEnter(submitValidateAuthenticatorForm);
				}
			 }
		}
	});
}

function showTotpKey(authenticatorType){
	document.getElementById("submitBtn").onclick = submitCode;
	document.getElementById("messageType").value = 8;
	if(authenticatorType == 0){
		document.getElementById("changeAuthMsg").style.display="";
	}
	document.getElementById("changeAuthenticator").style.display="";
	dialogBoxShadow(false);
	var isEmptyPhone = document.getElementById("isEmptyPhone").value; 
	if(isEmptyPhone == 0){
		if(document.getElementById("phoneCodeLi")!= null){
			document.getElementById("phoneCodeLi").style.display = "block";
		}
		if(document.getElementById("totpCodeLi")!= null){
			document.getElementById("totpCodeLi").style.display = "none";
		}
	}else{
		if(document.getElementById("phoneCodeLi")!= null){
			document.getElementById("phoneCodeLi").style.display = "none";
		}
		if(document.getElementById("totpCodeLi")!= null){
			document.getElementById("totpCodeLi").style.display = "block";
		}
	}
	if(document.getElementById("msgSpan") != null){
		document.getElementById("msgSpan").innerHTML = "查看谷歌认证密钥";
	}
	if(document.getElementById("messageType") != null){
		document.getElementById("messageType").value = 8;
	}
	addMoveEvent("dialog_title_auth","dialog_content_auth");
}
//validateCodeType 1:谷歌 2:短信
//operationType 1:登录 2:提现
//type 1:手机 2:谷歌 3:全部开启
//bindType 1:手机 2:谷歌 3:全部绑定
function changeValidateCode(validateCodeType,operationType,type,bindType){
	document.getElementById("submitBtn").onclick = submitChangeAuthForm;
	if(document.getElementById("messageType") != null){
		document.getElementById("messageType").value = 10;
	}
	if(operationType == 2){
		if(type == 1 && validateCodeType == 1 ){//开启的谷歌 点谷歌 没有绑定手机
			okcoinAlert("暂未开启手机，不能关闭谷歌验证码",null,null);
			return ;
		}
		if(type == 2 && validateCodeType == 2 ){//开启的短信 点短信 没有绑定谷歌
			okcoinAlert("暂未开启谷歌验证，不能关闭短信验证码",null,null);
			return ;
		}
		if((bindType != 1 && bindType != 3)  && validateCodeType == 2){//未绑定手机开启手机
			okcoinAlert("暂未绑定手机，不能开启短信验证码",null,null);
			return ;
		}
		if((bindType != 2 && bindType != 3)  && validateCodeType == 1){//未绑定谷歌开启谷歌
			okcoinAlert("暂未添加谷歌认证，不能开启谷歌验证码",null,null);
			return ;
		}
	}else if(operationType == 1){
		if(bindType != 2 && bindType != 3  ){//未绑定谷歌开启谷歌
			okcoinAlert("暂未添加谷歌认证，不能开启谷歌验证码",null,null);
			return ;
		}
	}
	document.getElementById("changeAuthenticator").style.display="";
	dialogBoxShadow(false);
	if(document.getElementById("changeTotpCode")!= null){
		document.getElementById("changeTotpCode").value = "";
		document.getElementById("changeTotpCodeTips").innerHTML = "";
	}
	if(document.getElementById("changePhoneCode")!= null){
		document.getElementById("changePhoneCode").value = "";
		document.getElementById("changePhoneCodeTips").innerHTML = "";
	}
	addMoveEvent("dialog_title_auth","dialog_content_auth");
	document.getElementById("operationType").value = operationType;
	document.getElementById("validateCodeType").value = validateCodeType;
	if(validateCodeType == 1){
		if(document.getElementById("phoneCodeLi")!= null){
			document.getElementById("phoneCodeLi").style.display = "none";
		}
		if(document.getElementById("totpCodeLi")!= null){
			document.getElementById("totpCodeLi").style.display = "block";
		}
	}
	if(operationType == 2){
		if(validateCodeType == 1){
			if(document.getElementById("phoneCodeLi")!= null){
				document.getElementById("phoneCodeLi").style.display = "block";
			}
			if(document.getElementById("totpCodeLi")!= null){
				document.getElementById("totpCodeLi").style.display = "none";
			}
		}else if(validateCodeType == 2){
			if(document.getElementById("totpCodeLi")!= null){
				document.getElementById("totpCodeLi").style.display = "block";
			}
			if(document.getElementById("phoneCodeLi")!= null){
				if(type == 3){
					document.getElementById("phoneCodeLi").style.display = "block";
				}else{
					document.getElementById("phoneCodeLi").style.display = "none";
				}
			}
		}
	}
	
	var str ="";
	if(operationType == 1 ){
		str = "更改登录谷歌验证";
		if(document.getElementById("totpCodeLi")!= null){
			document.getElementById("totpCodeLi").style.display = "block";
		}
		if(document.getElementById("phoneCodeLi")!= null){
			document.getElementById("phoneCodeLi").style.display = "none";
		}
	}else{
		str = "更改双重验证方式";
	}
	document.getElementById("msgSpan").innerHTML = str;
}

function getCode(){
	var totpCode = 0;
	if(document.getElementById("userTotpCode") != null){
		totpCode = document.getElementById("userTotpCode").value;
	}
	var url = "/user/getValidateCode.do?totpCode="+totpCode+"&random="+Math.round(Math.random()*100);
	jQuery.post(url,function(data){
		if(data > 0){
			document.getElementById("resultCode").innerHTML= 'ok'+data;
		}else{
			document.getElementById("msgInfo").innerHTML="验证码不正确！";
			
		}
	});
}
