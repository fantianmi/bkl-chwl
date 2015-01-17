function buyPlanTurnoverValue(){
	var type = document.getElementById("buyType");
	var amount = document.getElementById("buyAmount");
	var cnyPrice = document.getElementById("buyCnyPrice");
	var turnoverin = document.getElementById("buyTurnoverin");
	var bitTips = document.getElementById("buyBtcTips");
	var feeTips = document.getElementById("buyFeeTips");
	var feeTipsValue = document.getElementById("buyFeeTipsValue");
	tradeTurnoverValue(type,amount,cnyPrice,turnoverin,feeTips,feeTipsValue,bitTips);
}

function sellPlanTurnoverValue(){
	var type = document.getElementById("sellType");
	var amount = document.getElementById("sellAmount");
	var cnyPrice = document.getElementById("sellCnyPrice");
	var turnoverin = document.getElementById("sellTurnoverin");
	var feeTips = document.getElementById("sellFeeTips");
	var bitTips = document.getElementById("sellBtcTips");
	var feeTipsValue = document.getElementById("sellFeeTipsValue");
	tradeTurnoverValue(type,amount,cnyPrice,turnoverin,feeTips,feeTipsValue,bitTips);
}

function buyPlanSummoneyValue(){
	var type = document.getElementById("buyType");
	var amount = document.getElementById("buyAmount");
	var cnyPrice = document.getElementById("buyCnyPrice");
	var turnoverin = document.getElementById("buyTurnoverin");
	var bitTips = document.getElementById("buyBtcTips");
	var feeTips = document.getElementById("buyFeeTips");
	var feeTipsValue = document.getElementById("buyFeeTipsValue");
	summoneyValue(type,amount,cnyPrice,turnoverin,feeTips,feeTipsValue,bitTips);
}

function sellPlanSummoneyValue(){
	var type = document.getElementById("sellType");
	var amount = document.getElementById("sellAmount");
	var cnyPrice = document.getElementById("sellCnyPrice");
	var turnoverin = document.getElementById("sellTurnoverin");
	var feeTips = document.getElementById("sellFeeTips");
	var bitTips = document.getElementById("sellBtcTips");
	var feeTipsValue = document.getElementById("sellFeeTipsValue");
	summoneyValue(type,amount,cnyPrice,turnoverin,feeTips,feeTipsValue,bitTips);
}

function tradeTurnoverValue(type,amount,cnyPrice,turnoverin,feeTips,feeTipsValue,btcTips){
	var tradeType = type.value;
	var tradeAmount = amount.value;
	var tradeCnyPrice = cnyPrice.value;
	
	var trade_min_amount = document.getElementById("trade_min_amount").value;
	var trade_min_price = document.getElementById("trade_min_price").value;
	
	var trade_price_decimal_precision = document.getElementById("trade_price_decimal_precision").value;
	trade_price_unit = getNumberByDecimalPrecision(trade_price_decimal_precision);
	
	var trade_amount_decimal_precision = document.getElementById("trade_amount_decimal_precision").value;
	trade_amount_unit = getNumberByDecimalPrecision(trade_amount_decimal_precision);
	
	//var reg=/^(-?\d*)\.?\d{1,4}$/;
	var reg=/^(-?\d*)\.?\d{0}$/;
	var symbol = document.getElementById("symbol").value;
    if(tradeAmount!=null && tradeAmount.toString().split(".")!=null && tradeAmount.toString().split(".")[1]!=null && tradeAmount.toString().split(".")[1].length>trade_amount_decimal_precision){
    	if(!reg.test(tradeAmount)){
    		amount.value = tradeAmount.substring(0, tradeAmount.length-1);
            return false;
        }
    }
    if(tradeCnyPrice!=null && tradeCnyPrice.toString().split(".")!=null && tradeCnyPrice.toString().split(".")[1]!=null && tradeCnyPrice.toString().split(".")[1].length>trade_price_decimal_precision){
    	if(!reg.test(tradeCnyPrice)){
    		cnyPrice.value = tradeCnyPrice.substring(0, tradeCnyPrice.length-1);
            return false;
        }
    }
	var turnover = accMul(tradeAmount,tradeCnyPrice);
	
	if(turnover!= null && turnover.toString().split(".")!=null && turnover.toString().split(".")[1] != null && turnover.toString().split(".")[1].length>(trade_price_decimal_precision + trade_amount_decimal_precision)){
		turnover = turnover.toFixed(trade_price_decimal_precision + trade_amount_decimal_precision);		
	}
	turnoverin.value = turnover;
	if(tradeType ==1){
		var tradeTurnover = accMul(tradeAmount,tradeCnyPrice);
		if(document.getElementById("userCnyBalance")!=null && Number(document.getElementById("userCnyBalance").value) < Number(tradeTurnover)){
			alertTipsSpan(btcTips,"您的余额不足，请先充值");
			return;
		}else{
			clearTipsSpan(btcTips);
			feeTips.innerHTML = feeTipsValue.value;
		}
	}else{
		if(document.getElementById("userBtcBalance")!=null && Number(document.getElementById("userBtcBalance").value ) < Number(tradeAmount)){
			if(symbol == 0){
				alertTipsSpan(btcTips,"您的余额不足");
			}else{
				alertTipsSpan(btcTips,"您的余额不足");
			}
			return;
		}else{
			clearTipsSpan(btcTips);
			feeTips.innerHTML = feeTipsValue.value;
		}
	}
}
function summoneyValue(type,amount,cnyPrice,turnoverin,feeTips,feeTipsValue,btcTips){
	var tradeType = type.value;
	var tradeTurnover = turnoverin.value;
	var tradeCnyPrice = cnyPrice.value;
	var tradeAmount = amount.value;
	var symbol = document.getElementById("symbol").value;
	tradeAmount = tradeTurnover/tradeCnyPrice;
	if(tradeAmount!= null && tradeAmount.toString().split(".")!=null &&tradeAmount.toString().split(".")[1] != null && tradeAmount.toString().split(".")[1].length>4){
		tradeAmount = tradeAmount.toFixed(4);		
	}
	amount.value = tradeAmount;
	var reg=/^(-?\d*)\.?\d{1,4}$/;
    if(tradeTurnover!=null && tradeTurnover.toString().split(".")!=null && tradeTurnover.toString().split(".")[1]!=null && tradeTurnover.toString().split(".")[1].length>4){
    	if(!reg.test(tradeTurnover)){
    		turnoverin.value = tradeTurnover.substring(0, tradeTurnover.length-1);
            return false;
        }
    }
	if(tradeType ==1){
		if(document.getElementById("userCnyBalance")!=null && Number(document.getElementById("userCnyBalance").value) < Number(tradeTurnover)){
			alertTipsSpan(btcTips,"您的余额不足，请先充值");
			return;
		}else{
			clearTipsSpan(btcTips);
			feeTips.innerHTML = feeTipsValue.value;
		}
	}else{
		if(document.getElementById("userBtcBalance")!=null && Number(document.getElementById("userBtcBalance").value ) < Number(tradeAmount)){
			if(symbol == 0){
				alertTipsSpan(btcTips,"您的余额不足");
			}else{
				alertTipsSpan(btcTips,"您的余额不足");
			}
			return;
		}else{
			clearTipsSpan(btcTips);
			feeTips.innerHTML = feeTipsValue.value;
		}
	}
}
function buyPlanBtc(){
	var buyAmount =document.getElementById("buyAmount").value;
	var buyCnyPrice =document.getElementById("buyCnyPrice").value;
	var buyPwd = trim(document.getElementById("buyPwd").value);
	var buyType = document.getElementById("buyType").value;
	var btcTips = document.getElementById("buyBtcTips");
	planBtcSubmitForm(buyAmount,buyCnyPrice,buyPwd,buyType,btcTips);
}
function sellPlanBtc(){
	var sellAmount =document.getElementById("sellAmount").value;
	var sellCnyPrice =document.getElementById("sellCnyPrice").value;
	var sellPwd = trim(document.getElementById("sellPwd").value);
	var sellType = document.getElementById("sellType").value;
	var btcTips = document.getElementById("sellBtcTips");
	planBtcSubmitForm(sellAmount,sellCnyPrice,sellPwd,sellType,btcTips);
}
var check = 1;
function planBtcSubmitForm(tradeAmount,tradeCnyPrice,tradePwd,tradeType,btcTips){
	if(check == 2){
		return;
	}
	var symbol = document.getElementById("symbol").value;
	var isopen = document.getElementById("isopen").value;
	
	var trade_min_amount = document.getElementById("trade_min_amount").value;
	var trade_min_price = document.getElementById("trade_min_price").value;
	
	var trade_price_decimal_precision = document.getElementById("trade_price_decimal_precision").value;
	trade_price_unit = getNumberByDecimalPrecision(trade_price_decimal_precision);
	
	var trade_amount_decimal_precision = document.getElementById("trade_amount_decimal_precision").value;
	trade_amount_unit = getNumberByDecimalPrecision(trade_amount_decimal_precision);
	
	/*
	if(tradeType ==1){
		var tradeTurnover = tradeAmount*tradeCnyPrice;
		if(document.getElementById("userCnyBalance")!=null &&  Number(document.getElementById("userCnyBalance").value) <  Number(tradeTurnover)){
			alertTipsSpan(btcTips,"您的余额不足，请先充值");
			return;
		}else{
			clearTipsSpan(btcTips);
		}
	}else{
		if(document.getElementById("userBtcBalance")!=null &&  Number(document.getElementById("userBtcBalance").value) <  Number(tradeAmount)){
			if(symbol == 0){
				alertTipsSpan(btcTips,"您的BTC余额不足");
			}else{
				alertTipsSpan(btcTips,"您的LTC余额不足");
			}
			return;
		}else{
			clearTipsSpan(btcTips);
		}
	}
	*/
	 var reg = new RegExp("^[0-9]+\.{0,1}[0-9]{0,8}$");
	 if(!reg.test(tradeAmount) ){
		 alertTipsSpan(btcTips,"请输入交易数量");
		return;
	 }else{
		clearTipsSpan(btcTips);
	}
	 
	
	 if(!reg.test(tradeCnyPrice) ){
		 alertTipsSpan(btcTips,"请输入价格");
		return;
	 }else{
			clearTipsSpan(btcTips);
	}
	if(tradePwd == "" && isopen != 1){
		alertTipsSpan(btcTips,"请输入交易密码");
		return;
	}else{
		btcTips.style.display="";
		btcTips.innerHTML="&nbsp;";
	}
	
	if (tradeCnyPrice-trade_min_price<0) {
		alertTipsSpan(btcTips,"最低交易价格是" + trade_min_price +"元");
		return;
	}
	if (tradeAmount-trade_min_amount<0) {
		alertTipsSpan(btcTips,"最低交易数量是" + trade_min_amount + "个");
		return;
	}
	
    if (isExceedPrecision(tradeCnyPrice,trade_price_decimal_precision)) {
    	alertTipsSpan(btcTips,"最小交易价格单位为" + trade_price_unit + "元");
    	return;
    }
    if (isExceedPrecision(tradeAmount,trade_amount_decimal_precision)) {
    	alertTipsSpan(btcTips,"最小交易数量单位为" + trade_amount_unit + "个");
    	return;
    }
    
    
	var url = "/api/plantrade/newPlan?random="+Math.round(Math.random()*100);
	var param={quantity:tradeAmount,price:tradeCnyPrice,password:tradePwd,tradeType:tradeType,symbol:symbol};
	check = 2;
	jQuery.post(url,param,function(result){
		if(result.ret != 0){
			check = 1;
		}
		if(result.ret == 0) {
			window.location.href="/plan.jsp?symbol="+symbol+"&successCode="+result.ret;
		}
		
		if(result.ret == 603){
			alertTipsSpan(btcTips,"账户出现安全隐患已被冻结，请尽快联系客服。");
		}
		if(result.ret == 602){
			alertTipsSpan(btcTips,"交易密码错误！");
		}
		if(result.ret == 605){
			alertTipsSpan(btcTips,"交易密码不正确！您还有"+result.errorNum+"次机会");
		}
		if(result.ret == 604){
			alertTipsSpan(btcTips,"您没有设置交易密码，请设置交易密码。");
		}
		if(result.ret == 704 ){
			 alertTipsSpan(btcTips,"余额不足！");
		}
		if(result.ret == 707){
			 alertTipsSpan(btcTips,"系统暂时禁用交易功能,请耐心等待。");
		}
		/**
		var result = eval('(' + data + ')');
		if(result!=null){
			if(result.resultCode != 0){
				check = 1;
			}
			 if(result.resultCode == -5){
				 if(result.errorNum == 0){
					 alertTipsSpan(btcTips,"交易密码错误五次，请2小时后再试！");
				 }else{
					 alertTipsSpan(btcTips,"交易密码不正确！您还有"+result.errorNum+"次机会");
				 }
				 if(tradeType == 1){
					 if(document.getElementById("buyPwd") != null){
						 document.getElementById("buyPwd").value = "";
					 }
				 }else{
					 if(document.getElementById("sellPwd") != null){
						 document.getElementById("sellPwd").value = "";
					 }
				 }
			 }else if(result.resultCode == -2){
				 alertTipsSpan(btcTips,"人民币余额不足！");
			 }else if(result.resultCode == -3){
				 if(symbol == 0){
					 alertTipsSpan(btcTips,"最小购买数量为：0.01BTC！");
				 }else{
					 alertTipsSpan(btcTips,"最小购买数量为：0.1LTC！");
				 }
			 }else if(result.resultCode == -4){
				 alertTipsSpan(btcTips,"出价不能为0！");
			 }else if(result.resultCode == -1){
				 alertTipsSpan(btcTips,"您没有设置交易密码，请设置交易密码。");
			 }else if(result.resultCode == -6){
				 if(symbol == 0){
					 alertTipsSpan(btcTips,"BTC余额不足！");
				 }else{
					 alertTipsSpan(btcTips,"LTC余额不足！");
				 }
			 }else if(result.resultCode == -7){
				 if(symbol == 0){
					 alertTipsSpan(btcTips,"最小卖出数量为：0.01BTC！");
				 }else{
					 alertTipsSpan(btcTips,"最小卖出数量为：0.1LTC！");
				 }
			 }else if(result.resultCode == -8){
				 alertTipsSpan(btcTips,"出价不能为0！");
			 }else if(result.resultCode == -10){
				 if(symbol == 0){
					 alertTipsSpan(btcTips,"计划委托买入价格小于当前价格，您可以直接<a href='btc.do?tradeType=0'> 买入。</a>");
				 }else{
					 alertTipsSpan(btcTips,"计划委托买入价格小于当前价格，您可以直接<a href='ltc.do?tradeType=0'> 买入。</a>");
				 }
			 }else if(result.resultCode == -11){
				 if(symbol == 0){
					 alertTipsSpan(btcTips,"计划委托卖出价格大于当前价格，您可以直接<a href='btc.do?tradeType=1'> 卖出。</a>");
				 }else{
					 alertTipsSpan(btcTips,"计划委托卖出价格大于当前价格，您可以直接<a href='ltc.do?tradeType=1'> 卖出。</a>");
				 }
			 }else if(result.resultCode == -13){
				 alertTipsSpan(btcTips,"账户出现安全隐患已被冻结，请尽快联系客服。");
			 }else if(result.resultCode == -14){
				 alertTipsSpan(btcTips,"交易密码免输超时，请刷新页面输入交易密码后重新激活。");
			 }else if(result.resultCode == -15){
				 alertTipsSpan(btcTips,"请输入交易密码");
			 }else if(result.resultCode >0){
				 window.location.href="/plan.do?symbol="+symbol+"&successCode="+result.resultCode;
			 }
		}
		*/
	});	
}

function clearTipsSpan(btcTips){
	btcTips.style.display="";
	btcTips.innerHTML="";
}

function alertTipsSpan(btcTips,tips){
	btcTips.style.display="";
	btcTips.innerHTML=tips;
}

function cancelPlanEntrust(entrustId){
	var url = "/api/plantrade/cancelPlan?random="+Math.round(Math.random()*100);
	var currentPage = document.getElementById("currentPage").value;
	var param={id:entrustId};
	jQuery.post(url,param,function(data){
		if(data.ret == 0){
			document.getElementById("entrustStatus"+entrustId).innerHTML="已撤销";
			window.location.href = "/plan.jsp?currentPage="+currentPage+"&symbol="+symbol;
		}
	});
}