
function cancelBtcWithdraw(transferId, type){
	if(!confirm('确定撤销提现么？')){
		return;
	}
	var url = "/api/transfer/cancelBtcWithdraw?random="+Math.round(Math.random()*100);
	var param={id:transferId};
	jQuery.post(url,param,function(result){
		if(result && result.ret == 0){
			document.getElementById("wiithdrawBtcStatus"+transferId).innerHTML="已撤销";
			window.location.href = "/withdrawBtc.jsp";
		}
	});
}
/**
 * 提交btc提现表单
 */
function submitWithdrawBtcForm(){
	var withdrawAddr = trim(document.getElementById("withdrawAddr").value);
	var withdrawAmount = parseFloat(document.getElementById("withdrawAmount").value);
	
	var tradePwd = trim(document.getElementById("tradePwd").value);
	var  totpCode = 0;
	var  phoneCode = 0;
	
	var taskBalance = parseFloat(document.getElementById("taskBalance").value);
	var symbol = document.getElementById("symbol").value;
	
	var minAmout = document.getElementById("mini_recharge_amount").value;
	var coin_amount_decimal_precision = document.getElementById("coin_amount_decimal_precision").value;
	coin_amount_unit = getNumberByDecimalPrecision(coin_amount_decimal_precision);
	
	
	if(document.getElementById("userBalance")!=null && document.getElementById("userBalance").value - withdrawAmount < 0){
		alertTipsSpan("您的余额不足！");
		return;
	}else{
		clearTipsSpan();
	}
	if(withdrawAddr == ""){
		alertTipsSpan("请设置提现地址");
		return;
	}else{
		clearTipsSpan();
	}
    var reg = new RegExp("^[0-9]+\.{0,1}[0-9]{0,8}$");
    if(!reg.test(withdrawAmount) ){
    	alertTipsSpan("请输入提现金额");
		return;
    }else{
		clearTipsSpan();
	}
    if(withdrawAmount<minAmout || isNaN(withdrawAmount)){
    	alertTipsSpan("最小提现金额为" + minAmout + "个");
    	return;
    }
    if (isExceedPrecision(withdrawAmount,coin_amount_decimal_precision)) {
    	alertTipsSpan("最小提现单位为" + coin_amount_unit + "元");
    	return;
    }
    /*
	if(withdrawAmount < 0.01 && taskBalance == 0){
		alertTipsSpan("最小提现金额为：0.01"+(symbol==1?"LTC":"BTC"));
		return;
	}else{
		clearTipsSpan();
	}
	*/
	if(tradePwd == ""){
		alertTipsSpan("请输入交易密码");
		return;
	}else{
		clearTipsSpan();
	}

	var url = "/api/transfer/saveBtcWithdraw?random="+Math.round(Math.random()*100);
	var param={amount:withdrawAmount,tradePwd:tradePwd};
	jQuery.post(url,param,function(result){
		if(result){
			if(result.ret == 0){
				document.getElementById("withdrawBtcButton").disabled="true";
				window.location.href="/withdrawBtc.jsp?symbol="+symbol+"&success"
			}
			if(result.ret == 602){
				alertTipsSpan("交易密码错误！");
			}
			if(result.ret == 603){
				alertTipsSpan("账户出现安全隐患已被冻结，请尽快联系客服处理");
			}
			if(result.ret == 604){
				alertTipsSpan("未设置交易密码！");
			}
			if(result.ret == 605){
				alertTipsSpan("交易密码不正确！您还有"+result.errorNum+"次机会");
			}
			if(result.ret == 704){
				alertTipsSpan("您的余额不足！");
			}

//			 if(result.resultCode == -1){
//				 alertTipsSpan("最小提现金额为：0.01"+(symbol==1?"LTC":"BTC"));
//			 }else if(result.resultCode == -2){
//				 if(result.errorNum == 0){
//					 alertTipsSpan("交易密码错误多次，请2小时后再试！");
//				 }else{
//					 alertTipsSpan("交易密码不正确！您还有"+result.errorNum+"次机会");
//				 }
//			 }else if(result.resultCode == -3){
//				 alertTipsSpan("提现地址不能为空！");
//			 }else if(result.resultCode == -4){
//				 alertTipsSpan("您的余额不足！");
//			 }else if(result.resultCode == -5){
//				 alertTipsSpan("您的提现金额已超过今日提现限额，请重新输入");
//			 }else if(result.resultCode == -7){
//				 alertTipsSpan("交易密码错误多次，请2小时后再试！");
//			 }else if(result.resultCode == -8){
//				 if(result.errorNum == 0){
//					 alertTipsSpan("谷歌验证码错误多次，请2小时后再试！");
//				 }else{
//					 alertTipsSpan("谷歌验证码错误！您还有"+result.errorNum+"次机会");
//				 }
//			 }else if(result.resultCode == -9){
//				 if(result.errorNum == 0){
//					 alertTipsSpan("短信验证码错误多次，请2小时后再试！");
//				 }else{
//					 alertTipsSpan("短信验证码错误！您还有"+result.errorNum+"次机会");
//				 }
//			 }else if(result.resultCode == -10){
//				 modifyPwd(2);
//			 }else if(result.resultCode == -11){
//				 alertTipsSpan("谷歌验证码格式不正确");
//			 }else if(result.resultCode == -12){
//				 alertTipsSpan("短信验证码格式不正确");
//			 }else if(result.resultCode == 0){
//				 document.getElementById("withdrawBtcButton").disabled="true";
//				 window.location.href="/withdrawBtc.do?symbol="+symbol+"&success";
//			 }else if(result.resultCode == -13){
//				 document.getElementById("modifyResultTips").innerHTML= "您没有绑定手机或谷歌验证，请去<a href='/security.do'>安全中心</a>绑定手机或谷歌验证后提现。";
//			 }else if(result.resultCode == 2){
//				 alertTipsSpan("账户出现安全隐患已被冻结，请尽快联系客服处理");
//			 }else if(result.resultCode == 3){
//				 dialogBoxShadow(false);
//				 document.getElementById("emailAlert").style.display = "";
//				 document.getElementById("emailSuc").style.display = "";
//				 document.getElementById("emailError").style.display = "none";
//			 }else if(result.resultCode == 4){
//				 dialogBoxShadow(false);
//				 document.getElementById("emailAlert").style.display = "";
//				 document.getElementById("emailSuc").style.display = "none";
//				 document.getElementById("emailError").style.display = "";
//			 }
		}
	});	
}

function closeEmailAlert(){
	var symbol = document.getElementById("symbol").value;
	dialogBoxHidden();
	document.getElementById("emailAlert").style.display = "none";
	window.location.href="/withdrawBtc.do?symbol="+symbol+"&success";
}

function clearTipsSpan(){
	document.getElementById("modifyResultTips").innerHTML="&nbsp;";
}

function alertTipsSpan(tips){
	document.getElementById("modifyResultTips").innerHTML=tips;
}

/**
 * 鼠标点击显示
 */
function onclickbox(e){
	var banknumber = document.getElementById("withdrawAccountAddr").value;
	document.getElementById("displayBankNumberAddr").innerHTML = banknumber;
	if("银行卡账号" == banknumber){
		document.getElementById("withdrawAccountAddr").value = "";
	}
	if(document.getElementById("outType") != null){
		var type = document.getElementById("outType").value;
		if(type == 1)
			document.getElementById("displayBankNumberAddr").style.display="";
	}
}

function moveclickbox(e){
	var banknumber = document.getElementById("displayBankNumberAddr").innerHTML;
	document.getElementById("withdrawAccountAddr").value = banknumber;
	document.getElementById("displayBankNumberAddr").style.display="none";
	if(banknumber == ""){
		document.getElementById("withdrawAccountAddr").value = "银行卡账号";
	}
}

function onkeyupbox(e){
	var banknumber = document.getElementById("withdrawAccountAddr").value;
	banknumber = banknumber.replace(new RegExp(" ","gm"),'');
	banknumber = plusSpace(banknumber);
	document.getElementById("displayBankNumberAddr").innerHTML = banknumber;
	document.getElementById("withdrawAccountAddr").value = banknumber;
}

function onclickbox2(e){
	var banknumber = document.getElementById("withdrawAccountAddr2").value;
	document.getElementById("displayBankNumberAddr2").innerHTML = banknumber;
	if("银行卡账号" == banknumber){
		document.getElementById("withdrawAccountAddr2").value = "";
	}
	if(document.getElementById("outType") != null){
		var type = document.getElementById("outType").value;
		if(type == 1)
			document.getElementById("displayBankNumberAddr2").style.display="";
	}
}

function moveclickbox2(e){
	var banknumber = document.getElementById("displayBankNumberAddr2").innerHTML;
	document.getElementById("withdrawAccountAddr2").value = banknumber;
	document.getElementById("displayBankNumberAddr2").style.display="none";
	if(banknumber == ""){
		document.getElementById("withdrawAccountAddr2").value = "银行卡账号";
	}
}

function onkeyupbox2(e){
	var banknumber = document.getElementById("withdrawAccountAddr2").value;
	banknumber = banknumber.replace(new RegExp(" ","gm"),'');
	banknumber = plusSpace(banknumber);
	document.getElementById("displayBankNumberAddr2").innerHTML = banknumber;
	document.getElementById("withdrawAccountAddr2").value = banknumber;
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

/**
 * 提交cny提现表单
 */
function submitWithdrawCnyForm(){
	document.getElementById("withdraw_success_tips").style.display="none";
//	var tradePwd = trim(document.getElementById("tradePwd").value);
	var withdrawBalance = trim(document.getElementById("withdrawBalance").value);
	var cnyOutType = parseFloat(document.getElementById("cnyOutType").value);
	var min_withdraw_amount = document.getElementById("min_withdraw_amount").value;
	var max_withdraw_amount = document.getElementById("max_withdraw_amount").value;
	var cash_amount_decimal_precision = document.getElementById("cash_amount_decimal_precision").value;
	cash_amount_unit = getNumberByDecimalPrecision(cash_amount_decimal_precision);
	var  totpCode = 0;
	var  phoneCode = 0;
	if(document.getElementById("coin_left")!=null && document.getElementById("coin_left").value==0){
		swal("错误", "您的余额不足！", "error");
		return;
	}
    var reg = new RegExp("^[0-9]+\.{0,1}[0-9]{0,8}$");
    if(!reg.test(withdrawBalance) ){
    	swal("错误", "请输入提现金额", "error");
		return;
    }
    if(withdrawBalance>document.getElementById("coin_left").value){
    	swal("错误", "余额不足", "error");
		return;
    }
    if(withdrawBalance<0){
    	swal("错误", "请输入大于0的数字", "error");
    	return;
    }
	if(withdrawBalance - min_withdraw_amount < 0){
		swal("错误", " 最小提现金额为：￥" + min_withdraw_amount, "error");
		return;
	}
	if(max_withdraw_amount-withdrawBalance< 0){
		swal("错误", " 最大提现金额为：￥" + max_withdraw_amount, "error");
		return;
	}
	
    if (isExceedPrecision(withdrawBalance,cash_amount_decimal_precision)) {
    	swal("错误","最小提现单位为" + cash_amount_unit + "元","", "error");
    	return;
    }
    var bankid=$("#bankid").val();
    if(bankid==0){
    	swal("错误", "请选择提现银行卡", "error");
    	return;
    }
//	var regType = new RegExp("^[0-9]*$");
//	if(!regType.test(cnyOutType) ){
//		swal("错误", "请输入提现金额", "error");
//		alertTipsSpan("请选择提现方式");
//		return;
//	}else{
//		clearTipsSpan();
//	}
//	if(tradePwd == ""  || tradePwd.length>200){
//		alertTipsSpan("请输入交易密码");
//		return;
//	}else{
//		clearTipsSpan();
//	}
//	if(document.getElementById("withdrawTotpCode") != null){
//		totpCode = trim(document.getElementById("withdrawTotpCode").value);
//		if(totpCode == "" || totpCode.length!=6){
//			alertTipsSpan("请输入谷歌验证码");
//			return;
//		}else{
//			document.getElementById("modifyResultTips").innerHTML="&nbsp;";
//		}
//	}
//	if(document.getElementById("withdrawPhoneCode") != null){
//		phoneCode = trim(document.getElementById("withdrawPhoneCode").value);
//		if(phoneCode == "" || phoneCode.length!=6){
//			alertTipsSpan("请输入短信验证码");
//			return;
//		}else{
//			document.getElementById("modifyResultTips").innerHTML="&nbsp;";
//		}
//	}
//	if(document.getElementById("withdrawTotpCode") == null && document.getElementById("withdrawPhoneCode") == null){
//		document.getElementById("modifyResultTips").innerHTML= "您没有绑定手机或谷歌验证，请去<a href='/security.do'>安全中心</a>绑定手机或谷歌验证后提现。";
//		return;
//	}
	
	var url = "/api/cash/saveWithdraw?random="+Math.round(Math.random()*100);
	var param={amount:withdrawBalance,name:jQuery("#payeeAddr").val(),cnyOutType:cnyOutType,bankid:bankid};
	jQuery.post(url,param,function(data){
		 if(data.ret == 711){
			 swal("错误", "最小提现金额为：" + min_withdraw_amount + "元", "error");
		 }else if(data.ret == 704){
			 swal("错误", "取现金额大于用户可用现金", "error");
		 }else if(data.ret == -3){
			 swal("错误", "账户名称不能为空！", "error");
		 }else if(data.ret == -7){
			 swal("错误", "您的提现金额已超过今日提现限额，请重新输入", "error");
		 }else if(data.ret == 0){
			 document.getElementById("withdrawCnyButton").disabled="true";
			 swal({
             title: "成功",  
             text: "提现申请成功，等待审核",  
             type: "success",  
             showCancelButton: false,  
             confirmButtonColor: "#A7D5EA",  
             confirmButtonText: "确认" },
             function(){  
                  window.location.href="/user_index.jsp";
             });
		 }else if(data.ret == -14){
			 swal("错误", "提现姓名与实名姓名不符", "error");
		 }else if(data.ret == 602){
			 //alertTipsSpan("交易密码不正确！您还有"+data.errorNum+"次机会");
			 swal("错误", "交易密码不正确！", "error");
		 }else if(data.ret == 603){
			 swal("错误", "帐户被冻结", "error");
		 }else if(data.ret == 604){
			 swal("错误","未设置交易密码", "error");
		 }else if(data.ret == 605){
			 swal("错误","密码连续出错", "error");
		 }else {
			 swal("错误","未知错误，请联系客服！", "error");
		 }
	});	
}

/**
 * 验证提现金额
 */
function withdrawAmountBlur(type){
	var withdrawAmount = 0;
	var symbol = 0;
	if(type == 0){
		symbol = document.getElementById("symbol").value;
		withdrawAmount = parseFloat(document.getElementById("withdrawAmount").value);
	}else{
		withdrawAmount = parseFloat(document.getElementById("withdrawBalance").value);
	}
	if(document.getElementById("userBalance")!=null && document.getElementById("userBalance").value==0){
		alertTipsSpan("您的余额不足！");
		return;
	}else{
		clearTipsSpan();
	}
	var reg = new RegExp("^[0-9]+\.{0,1}[0-9]{0,8}$");
    if(!reg.test(withdrawAmount) ){
    	alertTipsSpan("请输入提现金额");
		return;
    }else{
    	clearTipsSpan();
	}
    var url = "/account/withdrawAmountBlur.do?random="+Math.round(Math.random()*100);
	var param={type:type,withdrawAmount:withdrawAmount,symbol:symbol};
	jQuery.post(url,param,function(data){
		if(data == -1){
			alertTipsSpan("最小提现金额为："+(symbol==0?"0.01BTC":"0.1LTC"));
		}else if(data == -2){
			alertTipsSpan("您的提现金额已超过今日提现限额，请重新输入");
		}else if(data == -3){
			alertTipsSpan("最小提现金额为：100元");
		}else if(data == -4){
			alertTipsSpan("您的提现金额已超过今日提现限额，请重新输入");
		}else if(data == -5){
			alertTipsSpan("您的余额不足！");
		}else if(data == 2){
			 alertTipsSpan("账户出现安全隐患已被冻结，请尽快联系客服处理");
		 }
	});
}
/**
 * 修改比特币提现地址
 */
function modifyWithdrawBtcAddr(){
// 先取消手机验证
//	if(document.getElementById("isEmptyPhone") !=null && document.getElementById("isEmptyPhone").value==1&&document.getElementById("isEmptyAuth") !=null && document.getElementById("isEmptyAuth").value==1){
//		bindAuth();
//		return;
//	}
	dialogBoxShadow(false);
	addMoveEvent("dialog_title_btcaddr","dialog_content_btcaddr");
	document.getElementById("withdrawBtcAddrDiv").style.display="";
	document.getElementById("withdrawBtcAddr").focus();
	document.getElementById("withdrawBtcAddrTips").innerHTML="";
	document.getElementById("withdrawBtcAddr").value="";
	if(document.getElementById("withdrawBtcAddrCode") != null){
		document.getElementById("withdrawBtcAddrCode").value="";
	}
	document.getElementById("withdrawBtcAddr").focus();
	callbackEnter(submitWithdrawBtcAddrForm);
}

function closeWithdrawBtcAddr(){
	dialogBoxHidden();
	document.getElementById("withdrawBtcAddrDiv").style.display="none";
}

function submitWithdrawBtcAddrForm(){
	var withdrawAddr = trim(document.getElementById("withdrawBtcAddr").value);
	var  withdrawBtcAddrTotpCode = 0;
	var  withdrawBtcAddrPhoneCode = 0;
	var symbol = document.getElementById("symbol").value;
	if(withdrawAddr == ""){
		document.getElementById("withdrawBtcAddrTips").innerHTML="请设置提现地址";
		return;
	}else{
		document.getElementById("withdrawBtcAddrTips").innerHTML="";
	}
	if(document.getElementById("withdrawBtcAddrTotpCode") != null){
		withdrawBtcAddrTotpCode = trim(document.getElementById("withdrawBtcAddrTotpCode").value);
		if(withdrawBtcAddrTotpCode == "" || withdrawBtcAddrTotpCode.length!=6){
			document.getElementById("withdrawBtcAddrTips").innerHTML="谷歌验证码格式不正确";
			document.getElementById("withdrawBtcAddrTotpCode").value = "";
			return;
		}else{
			document.getElementById("withdrawBtcAddrTips").innerHTML="";
		}
	}
	if(document.getElementById("withdrawBtcAddrPhoneCode") != null){
		withdrawBtcAddrPhoneCode = trim(document.getElementById("withdrawBtcAddrPhoneCode").value);
		if(withdrawBtcAddrPhoneCode == "" || withdrawBtcAddrPhoneCode.length!=6){
			document.getElementById("withdrawBtcAddrTips").innerHTML="短信验证码格式不正确";
			document.getElementById("withdrawBtcAddrPhoneCode").value = "";
			return;
		}else{
			document.getElementById("withdrawBtcAddrTips").innerHTML="";
		}
	}
	var url = "/api/user/modifyCoinWithdrawAddr?random="+Math.round(Math.random()*100);
	var param={addr:withdrawAddr,type:1};
	jQuery.post(url,param,function(result){
		if(result.ret == 0) {
			 closeWithdrawBtcAddr();
			 document.getElementById("withdrawAddr").value=withdrawAddr;
			 document.getElementById("withdrawAddrSpan").innerHTML=result.data.addr+"&nbsp;&nbsp;<a href='javascript:void(0);' onclick='javascript:modifyWithdrawBtcAddr();'>修改</a>";
		}
//		var result = eval('(' + data + ')');
//		if(result!=null){
//			 if(result.resultCode == -1){
//				 document.getElementById("withdrawBtcAddrTips").innerHTML="请设置提现地址";
//			 }else if(result.resultCode == -2){
//				 if(result.errorNum == 0){
//					 document.getElementById("withdrawBtcAddrTips").innerHTML="谷歌验证码错误多次，请2小时后再试！";
//				 }else{
//					 document.getElementById("withdrawBtcAddrTips").innerHTML="谷歌验证码错误！您还有"+result.errorNum+"次机会";
//					 document.getElementById("withdrawBtcAddrTotpCode").value = "";
//				 }
//			 }else if(result.resultCode == -3){
//				 if(result.errorNum == 0){
//					 document.getElementById("withdrawBtcAddrTips").innerHTML="短信验证码错误多次，请2小时后再试！";
//				 }else{
//					 document.getElementById("withdrawBtcAddrTips").innerHTML="短信验证码错误！您还有"+result.errorNum+"次机会";
//					 document.getElementById("withdrawBtcAddrPhoneCode").value = "";
//				 }
//			 }else if(result.resultCode == 0){
//				 closeWithdrawBtcAddr();
//				 document.getElementById("withdrawAddr").value=withdrawAddr;
//				 document.getElementById("withdrawAddrSpan").innerHTML=result.address+"&nbsp;&nbsp;<a href='javascript:void(0);' onclick='javascript:modifyWithdrawBtcAddr();'>修改</a>";
//			 }else if(result.resultCode == -5){
//				 document.getElementById("withdrawBtcAddrTips").innerHTML="短信验证码输入错误";
//				 document.getElementById("withdrawBtcAddrPhoneCode").value = "";
//			 }else if(result.resultCode == -6){
//				 document.getElementById("withdrawBtcAddrTips").innerHTML="谷歌验证码输入错误";
//				 document.getElementById("withdrawBtcAddrTotpCode").value = "";
//			 }
//		}
	 });
}

function cancelWithdrawCny(outId){
	if(confirm('确定撤销提现么？')){
		var url = "/api/cash/cancelWithdraw?random="+Math.round(Math.random()*100);
		var param={id:outId};
		jQuery.post(url,param,function(data){
			window.location.href="/withdrawCny.jsp";
		 });
	}
}

function checkPayee(payee){
	payee = payee.replace(new RegExp("　","gm"),'');
	payee = payee.replace(/^\s+|\s+$/g,"");
	var re = new RegExp();   
	re = /^[0-9]/; 
	if (re.test(payee)) {
		document.getElementById("addrMsgSpan").innerHTML="收款人姓名不合法";
		return ;
    }else{
    	document.getElementById("addrMsgSpan").innerHTML="&nbsp;";
	}
}

function showUpadteAddress(outType,addressType){
	if(document.getElementById("anthtrade").value==0){
		bindAuth();
		return;
	}
	if(outType == 2){
		document.getElementById("openBankTypeAddrLi").style.display = "none";
		document.getElementById("cnyAccountAddr").innerHTML = "财付通账户:";
		document.getElementById("displayBankNumberAddr").style.display = "none";
		document.getElementById("withdrawAccountAddr").value = "";
		document.getElementById("withdrawAccountAddr").onkeyup=null;
		document.getElementById("withdrawAccountAddr").onfocus=null;
		document.getElementById("withdrawAccountAddr").onblur=null;
		document.getElementById("displayBankNumberAddr2").style.display = "none";
		document.getElementById("withdrawAccountAddr2").value = "";
		document.getElementById("withdrawAccountAddr2").onkeyup=null;
		document.getElementById("withdrawAccountAddr2").onfocus=null;
		document.getElementById("withdrawAccountAddr2").onblur=null;
		document.getElementById("cnyAccountAddr2").innerHTML="请再次输入财付通账户:";
		
	}else{
		document.getElementById("openBankTypeAddrLi").style.display = "";
		var onkeyupboxFun = function (e){
			onkeyupbox(e);
		};
		var onclickboxFun = function (e){
			onclickbox(e);
		};
		var moveclickboxFun = function (e){
			moveclickbox(e);
		};
		var onkeyupboxFun2 = function (e){
			onkeyupbox2(e);
		};
		var onclickboxFun2 = function (e){
			onclickbox2(e);
		};
		var moveclickboxFun2 = function (e){
			moveclickbox2(e);
		};
		document.getElementById("withdrawAccountAddr").onkeyup=onkeyupboxFun;
		document.getElementById("withdrawAccountAddr").onfocus=onclickboxFun;
		document.getElementById("withdrawAccountAddr").onblur=moveclickboxFun;
		document.getElementById("cnyAccountAddr").innerHTML = "银行卡账户:";
		document.getElementById("withdrawAccountAddr").value = "请输入银行卡号";
		document.getElementById("withdrawAccountAddr2").onkeyup=onkeyupboxFun2;
		document.getElementById("withdrawAccountAddr2").onfocus=onclickboxFun2;
		document.getElementById("withdrawAccountAddr2").onblur=moveclickboxFun2;
		document.getElementById("withdrawAccountAddr2").value = "请输入银行卡号";
		document.getElementById("cnyAccountAddr2").innerHTML="请再次输入银行卡账号:";
	}
	dialogBoxShadow(false);
	addMoveEvent("dialog_title_CnyAddress","dialog_content_CnyAddress");
	document.getElementById("withdrawCnyAddress").style.display="";
	document.getElementById("outType").value=outType;
	document.getElementById("addressType").value=addressType;
	if(document.getElementById("addressPhoneCode") != null){
		document.getElementById("addressPhoneCode").value="";
	}
	if(document.getElementById("addressTotpCode") != null){
		document.getElementById("addressTotpCode").value="";
	}
	document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
	
}

function closeAddress(){
	dialogBoxHidden();
	document.getElementById("withdrawCnyAddress").style.display="none";
}
var secs = 121;
function sendWithdrawCnyAddressMsgCode(type){
	
	var url = "/user/sendMsg.do?random="+Math.round(Math.random()*100);
	var param = {type:type};
	jQuery.post(url,param,function(data){
		if(data == 0){
			document.getElementById("WithdrawCnyAddressMsgCodeBtn").disabled = true;
			 for(var num=1;num<=secs;num++) {
				  window.setTimeout("updateCnyAddrNumber(" + num + ")", num * 1000);
			  }
		}else if(data == -2){
			document.getElementById("addrMsgSpan").innerHTML="您没有绑定手机";
		}else if(data == -3){
			document.getElementById("addrMsgSpan").innerHTML="短信验证码错误多次，请2小时后再试！";
		}else if(data == -1){
			document.getElementById("addrMsgSpan").innerHTML="验证码获取超时，请稍后再试。";
		}
	});
}
function updateCnyAddrNumber(num){
	if (num == secs) {
		document.getElementById("WithdrawCnyAddressMsgCodeBtn").value="发送验证码";
		document.getElementById("WithdrawCnyAddressMsgCodeBtn").disabled = false;
	} else {
		var printnr = secs - num;
		document.getElementById("WithdrawCnyAddressMsgCodeBtn").value= printnr +"秒后可重发";
	}
}
function submitWithdrawCnyAddress(type){
//	var cnyOutType = parseFloat(document.getElementById("cnyOutType").value);
	var openBankTypeAddr = document.getElementById("openBankTypeAddr").value;
	var withdrawAccount = trim(document.getElementById("withdrawAccountAddr").value);
	var payeeAddr = trim(document.getElementById("payeeAddr").value);
	var totpCode = 0;
	var phoneCode = 0;
	var type =  document.getElementById("addressType").value;
//	var regType = new RegExp("^[0-9]*$");
//	if(!regType.test(cnyOutType) ){
//		document.getElementById("addrMsgSpan").innerHTML = "请选择提现方式";
//		return;
//	}else{
//		document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
//	}
//	if(cnyOutType == 1 && openBankTypeAddr == -1){
//		document.getElementById("addrMsgSpan").innerHTML = "请选择银行类型";
//		return;
//	}else{
//		document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
//	}
	if(withdrawAccount == "" || withdrawAccount.length>200 || withdrawAccount == "银行卡账号"){
		document.getElementById("addrMsgSpan").innerHTML = "请输入提现帐户";
		return;
	}else{
		document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
	}
	var withdrawAccount2 = trim(document.getElementById("withdrawAccountAddr2").value);
	if(withdrawAccount != withdrawAccount2){
		document.getElementById("addrMsgSpan").innerHTML = "两次输入的帐户不一致";
		return;
	}else{
		document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
	}
	var withdrawAccount_bankNumber = trim(document.getElementById("withdrawAccountAddr_bankNumber").value);
	if(withdrawAccount_bankNumber == "" || withdrawAccount_bankNumber.length>200){
		document.getElementById("addrMsgSpan").innerHTML = "请输入提现银行卡行号";
		return;
	}else{
		document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
	}
	var withdrawAccount2_bankNumber = trim(document.getElementById("withdrawAccountAddr2_bankNumber").value);
	if(withdrawAccount_bankNumber != withdrawAccount2_bankNumber){
		document.getElementById("addrMsgSpan").innerHTML = "两次输入的银行卡行号不一致";
		return;
	}else{
		document.getElementById("addrMsgSpan").innerHTML = "&nbsp;";
	}
	
//	var withdrawAccount_mobile = trim(document.getElementById("withdrawAccountMobile").value);
//	if (!checkMobile(withdrawAccount_mobile)) {
//		document.getElementById("addrMsgSpan").innerHTML = "请输入合法的手机号码";
//		return;
//	}
	
	
//	if(document.getElementById("addressTotpCode") != null){
//		totpCode = trim(document.getElementById("addressTotpCode").value);
//		if(totpCode == "" || totpCode.length!=6){
//			document.getElementById("addrMsgSpan").innerHTML="谷歌验证码格式不正确";
//			document.getElementById("addressTotpCode").value = "";
//			return;
//		}else{
//			document.getElementById("addrMsgSpan").innerHTML="&nbsp;";
//		}
//	}
//	if(document.getElementById("addressPhoneCode") != null){
//		phoneCode = trim(document.getElementById("addressPhoneCode").value);
//		if(phoneCode == "" || phoneCode.length!=6){
//			document.getElementById("addrMsgSpan").innerHTML="短信验证码格式不正确";
//			document.getElementById("addressPhoneCode").value = "";
//			return;
//		}else{
//			document.getElementById("addrMsgSpan").innerHTML="&nbsp;";
//		}
//	}
	//closeAddress();
//	jQuery("#cnyadd").remove();
	var url = "/api/user/modifyRmbWithdrawAddr?random="+Math.round(Math.random()*100);
	var param={bank_account:withdrawAccount,bank_number:withdrawAccount_bankNumber,bank:openBankTypeAddr,name:payeeAddr};
	jQuery.post(url,param,function(result){
		if(result.ret == 0) {
		swal({
            title: "成功",  
            text: "绑定银行卡成功",  
            type: "success",  
            showCancelButton: false,  
            confirmButtonColor: "#A7D5EA",  
            confirmButtonText: "确认" },
            function(){  
                 window.location.href="/user_detail.jsp";
            });
//			window.location.href="/withdrawCny.jsp?outCnyType="+cnyOutType;
		}
	});
	/*
	var url = "/user/updateOutAddress.do?random="+Math.round(Math.random()*100);
	var param={type:type,cnyOutType:cnyOutType,account:withdrawAccount,openBankType:openBankTypeAddr,totpCode:totpCode,phoneCode:phoneCode};
	jQuery.post(url,param,function(data){
		var result = eval('(' + data + ')');
		if(result!=null){
			 if(result.resultCode == -1){
				 
			 }else if(result.resultCode == -2){
				 document.getElementById("addrMsgSpan").innerHTML="请输入提现帐户";
			 }else if(result.resultCode == -3){
				 document.getElementById("addrMsgSpan").innerHTML="请选择银行类型";
			 }else if(result.resultCode == -4){
				 document.getElementById("addrMsgSpan").innerHTML="请输入收款人姓名";
			 }else if(result.resultCode == -5){
				 document.getElementById("addrMsgSpan").innerHTML="您没有绑定谷歌或者手机不允许操作";
			 }else if(result.resultCode == -6){
				 document.getElementById("addrMsgSpan").innerHTML="您已经存在提现地址，不允许再次添加";
			 }else if(result.resultCode == -7){
				 document.getElementById("addrMsgSpan").innerHTML="您没保存提现地址，不能修改";
			 }else if(result.resultCode == -8){
				 if(result.errorNum == 0){
					 document.getElementById("addrMsgSpan").innerHTML="谷歌验证码错误多次，请2小时后再试！";
				 }else{
					 document.getElementById("addrMsgSpan").innerHTML="谷歌验证码错误！您还有"+result.errorNum+"次机会";
				 }
			 }else if(result.resultCode == -9){
				 if(result.errorNum == 0){
					 document.getElementById("addrMsgSpan").innerHTML="短信验证码错误多次，请2小时后再试！";
				 }else{
					 document.getElementById("addrMsgSpan").innerHTML="短信验证码错误！您还有"+result.errorNum+"次机会";
				 }
			 }else if(result.resultCode == -10){
				 document.getElementById("addrMsgSpan").innerHTML="操作失败，请刷新页面重试";
			 }else if(result.resultCode == -11){
				 document.getElementById("addrMsgSpan").innerHTML="谷歌验证码格式不正确";
			 }else if(result.resultCode == -12){
				 document.getElementById("addrMsgSpan").innerHTML="短信验证码格式不正确";
			 }else if(result.resultCode == 0){
				 window.location.href="/withdrawCny.jsp?outCnyType="+cnyOutType;
			 }else if(result.resultCode == -13){
				 document.getElementById("addrMsgSpan").innerHTML= "您没有绑定手机或谷歌验证，请去<a href='/security.do'>安全中心</a>绑定手机或谷歌验证后提现。";
			 }else if(result.resultCode == 2){
				 document.getElementById("addrMsgSpan").innerHTML="账户出现安全隐患已被冻结，请尽快联系客服。";
			 }
		}
	});	
	*/
}

function sendEmail(id,symbol){
	var url = "/account/sendEmail.do?random="+Math.round(Math.random()*100);
	var param = {id:id,symbol:symbol};
	jQuery.post(url,param,function(data){
		if(data == 0){
			dialogBoxShadow(false);
			 document.getElementById("emailAlert").style.display = "";
			 document.getElementById("emailSuc").style.display = "";
			 document.getElementById("emailError").style.display = "none";
		}else if(data == -2){
			dialogBoxShadow(false);
			document.getElementById("emailAlert").style.display = "";
			document.getElementById("emailSuc").style.display = "none";
			document.getElementById("emailError").style.display = "";
		}else if(data == -4){
			okcoinAlert("请求过于频繁，请30分钟后重试。", null, null, "");
		}
	});
}