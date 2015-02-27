function redirectCheckBindMobile(){
	var regUserName=$("#regUserName").val();
	var url="/open/getRegMobile?random="+Math.round(Math.random()*100);
	var params={regUserName:regUserName};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				$("#checkRegUserName").hide();
				$("#checkBindMobile").show();
				$("#inputVcodeNum").hide();
				$("#resetPassArea").hide();
				
				$("#regUserMobile").val(res.data);
			}else if(res.ret==609){
				swal("错误", "该账号不存在", "error");
			}else if(res.ret==621){
				swal("错误", "该账号没有绑定手机号", "error");
			}
		}
	});
}
function showInputVcodeNum(){
	var phone_number=$("#phone_number").val();
	var regUserName=$("#regUserName").val();
	var regUserMobile=$("#regUserMobile").val();
	if(regUserMobile!=phone_number){
		swal("错误", "绑定手机号码错误", "error");
		return;
	}
	sendMsg4ResetPass(regUserName);
	$("#checkRegUserName").hide();
	$("#checkBindMobile").hide();
	$("#inputVcodeNum").show();
	$("#resetPassArea").hide();
}

function sendMsg4ResetPass(m){
	var url="/open/resetPassword?random="+Math.round(Math.random()*100);
	var params={userName:m};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				var desc="发送成功，请在输入框中输入验证码";
				swal("成功", desc, "success");
				return;
			}
			if(res.ret==609){
				var desc="用户名不存在";
				swal("失败", desc, "error");
				wait = 1;
				return;
			}
			if(res.ret==621){
				var desc="该账户没有绑定手机号";
				swal("失败", desc, "error");
				wait = 1;
				return;
			}
			if(res.ret==500){
				var desc="请勿频繁发送，2分钟后再发";
				swal("失败", desc, "error");
				return;
			}
		}
	});
}

function showResetPassArea(){
	var phone_validate_code=$("#phone_validate_code").val();
	if(phone_validate_code.length<5){
		swal("错误", "请输入正确的验证码", "error");
		return;
	}
	var userReg=$("#regUserName").val();
	var url="/open/checkMsgValidateCodeFP?random="+Math.round(Math.random()*100);
	var params={msgCode:phone_validate_code,userReg:userReg};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				$("#checkRegUserName").hide();
				$("#checkBindMobile").hide();
				$("#inputVcodeNum").hide();
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
