/**
 * 撤销委托
 * @param entrustId
 */
function cancelEntrust(entrustId,type){
	if(!confirm('确定撤销委托么？')){
		return;
	}
	var symbol = document.getElementById("symbol").value;
	var url = "/api/trade/cancelTrade?random="+Math.round(Math.random()*100);
	var param={id:entrustId,symbol:symbol};
//	if(document.getElementById("tradeType") != null){
//		type = document.getElementById("tradeType").value;
//	}
	jQuery.post(url,param,function(result){
		if(result && result.ret == 0){
			document.getElementById("entrustStatus"+entrustId).innerHTML="已撤销";
			if(type == 3){
				var currentPage = document.getElementById("currentPage").value;
				var status =  document.getElementById("selectedStatus").value;
				window.location.href = "/entrust.jsp?status="+status+"&currentPage="+currentPage;
			}else if(symbol == 0){
				window.location.href = "/btc.jsp?tradeType="+type;
			}else{
				window.location.href = "/ltc.jsp?tradeType="+type;
			}
		}
	});
}

function tradeTurnoverValue(){
	var tradeType = document.getElementById("tradeType").value;
	var symbol = document.getElementById("symbol").value;
	var tradeAmount =document.getElementById("tradeAmount").value;
	var tradeCnyPrice =document.getElementById("tradeCnyPrice").value;
	
	var trade_min_amount = document.getElementById("trade_min_amount").value;
	var trade_min_price = document.getElementById("trade_min_price").value;
	
	var trade_price_decimal_precision = document.getElementById("trade_price_decimal_precision").value;
	trade_price_unit = getNumberByDecimalPrecision(trade_price_decimal_precision);
	
	var trade_amount_decimal_precision = document.getElementById("trade_amount_decimal_precision").value;
	trade_amount_unit = getNumberByDecimalPrecision(trade_amount_decimal_precision);
	
	
	//var reg=/^(-?\d*)\.?\d{1,2}$/;
	var reg=/^(-?\d*)\.?\d{0}$/;
    if(tradeAmount!=null && tradeAmount.toString().split(".")!=null && tradeAmount.toString().split(".")[1]!=null && tradeAmount.toString().split(".")[1].length>trade_amount_decimal_precision){
    	if(!reg.test(tradeAmount)){
        	document.getElementById("tradeAmount").value = tradeAmount.substring(0, tradeAmount.length-1);
            return false;
        }
    }
    if(tradeCnyPrice!=null && tradeCnyPrice.toString().split(".")!=null && tradeCnyPrice.toString().split(".")[1]!=null && tradeCnyPrice.toString().split(".")[1].length>trade_price_decimal_precision){
    	if(!reg.test(tradeCnyPrice)){
        	document.getElementById("tradeCnyPrice").value = tradeCnyPrice.substring(0, tradeCnyPrice.length-1);
            return false;
        }
    }
	var turnover = accMul(tradeAmount,tradeCnyPrice);
	if(turnover!= null && turnover.toString().split(".")!=null && turnover.toString().split(".")[1] != null && turnover.toString().split(".")[1].length>(trade_price_decimal_precision + trade_amount_decimal_precision)){
		turnover=turnover.toFixed(trade_price_decimal_precision + trade_amount_decimal_precision);		
	}
	document.getElementById("tradeTurnover").value = turnover;
	if(tradeType ==0){
		var tradeTurnover = accMul(tradeAmount,tradeCnyPrice);
		if(document.getElementById("userBalance")!=null && Number(document.getElementById("userBalance").value) < Number(tradeTurnover)){
			alertTipsSpan("您的余额不足，请先充值");
			return;
		}else{
			clearTipsSpan();
//			document.getElementById("btcFeeTips").innerHTML=document.getElementById("feeTipsValue").value;
		}
	}else{
		if(document.getElementById("userBalance")!=null && Number(document.getElementById("userBalance").value ) < Number(tradeAmount)){
			alertTipsSpan("您的余额不足");
			return;
		}else{
			clearTipsSpan();
//			document.getElementById("btcFeeTips").innerHTML=document.getElementById("feeTipsValue").value;
		}
	}
}
var submitRengou = false;
function submitRengouForm(){
	if(submitRengou){
		return;
	}
	var price = document.getElementById("price").value;
	var amount = document.getElementById("amount").value;
	var tradePwd = document.getElementById("tradePwd").value;
	if (!tradePwd) {
		alertTipsSpan("请输入交易密码");
		return;
	}
	submitRengou = true;
	var url = "/api/subscribe/doSubscribe";
	var param={amount:amount,price:price,tradePwd:tradePwd};
	jQuery.post(url,param,function(result){
		if(result.ret != 0) {
			submitRengou = false;
		}
		if(result.ret == 0 ){
			window.location.href = window.location.href;
		} else if(result.ret == -1 ){
			alert("未登录或登录超时,请登录后重新操作！");
			window.location.href = window.location.href;
		} else if(result.ret == 602 ){
			alertTipsSpan("交易密码错误！");
			document.getElementById("tradePwd").value = "";
		} else if(result.ret == 704 ){
			tradeBtcTips.innerHTML="余额不足！";
		} else if(result.ret == 730){
			alertTipsSpan("认购功能未开启！");
		} else if(result.ret == 731){
			alertTipsSpan("你的认购额度已满！");
		} else if(result.ret == 732){
			alertTipsSpan("认购结束！");
		} else {
			alertTipsSpan("服务器异常，请与管理员联系！");
		}
	});
}
var check = 1;
function submitTradeBtcForm(){
	if(check == 2){
		return;
	}
	var tradeAmount =document.getElementById("tradeAmount").value;
	var tradeCnyPrice =document.getElementById("tradeCnyPrice").value;
	var tradePwd = trim(document.getElementById("tradePwd").value);
	var tradeType = document.getElementById("tradeType").value;
	var symbol = document.getElementById("symbol").value;
	var isopen = document.getElementById("isopen").value;
	
	var r = /^\d+$/;
	
	var trade_min_amount = document.getElementById("trade_min_amount").value;
	var trade_min_price = document.getElementById("trade_min_price").value;
	
	var trade_price_decimal_precision = document.getElementById("trade_price_decimal_precision").value;
	trade_price_unit = getNumberByDecimalPrecision(trade_price_decimal_precision);
	
	var trade_amount_decimal_precision = document.getElementById("trade_amount_decimal_precision").value;
	trade_amount_unit = getNumberByDecimalPrecision(trade_amount_decimal_precision);
	
	if (tradeCnyPrice-trade_min_price<0) {
		alertTipsSpan("最低交易价格是" + trade_min_price +"元");
		return;
	}
	if (tradeAmount-trade_min_amount<0) {
		alertTipsSpan("最低交易数量是" + trade_min_amount + "个");
		return;
	}
	
    if (isExceedPrecision(tradeCnyPrice,trade_price_decimal_precision)) {
    	alertTipsSpan("最小交易价格单位为" + trade_price_unit + "元");
    	return;
    }
    if (isExceedPrecision(tradeAmount,trade_amount_decimal_precision)) {
    	alertTipsSpan("最小交易数量单位为" + trade_amount_unit + "个");
    	return;
    }
    
	if(tradeType ==0){
		var tradeTurnover = tradeAmount*tradeCnyPrice;
		if(document.getElementById("userBalance")!=null &&  Number(document.getElementById("userBalance").value) <  Number(tradeTurnover)){
			alertTipsSpan("您的余额不足，请先充值");
			return;
		}else{
			clearTipsSpan();
		}
	}else{
		if(document.getElementById("userBalance")!=null &&  Number(document.getElementById("userBalance").value) <  Number(tradeAmount)){
			if(symbol == 0){
				alertTipsSpan("您的BTC余额不足");
			}else{
				alertTipsSpan("您的LTC余额不足");
			}
			return;
		}else{
			clearTipsSpan();
		}
	}
	
	 var reg = new RegExp("^[0-9]+\.{0,1}[0-9]{0,8}$");
	 if(!reg.test(tradeAmount) ){
		 alertTipsSpan("请输入交易数量");
		return;
	 }else{
			clearTipsSpan();
	}
	if(tradeAmount < 0.01){
		if(symbol==1) alertTipsSpan("最小交易数量为：0.1LTC！");
		 else alertTipsSpan("最小交易数量为：0.01BTC！");
		return;
	}else{
		clearTipsSpan();
	}
	 if(!reg.test(tradeCnyPrice) ){
		 alertTipsSpan("请输入价格");
		return;
	 }else{
			clearTipsSpan();
	}	
	if(tradePwd == "" && isopen != 1){
		alertTipsSpan("请输入交易密码");
		return;
	}else{
		document.getElementById("tradeBtcTips").style.display="";
		document.getElementById("tradeBtcTips").innerHTML="&nbsp;";
	}
	var url = "";
	if(tradeType ==0){
		url = "/api/trade/buyBtc?random="+Math.round(Math.random()*100);
	}else{
		url = "/api/trade/sellBtc?random="+Math.round(Math.random()*100);
	}
	var param={amount:tradeAmount,price:tradeCnyPrice,tradePwd:tradePwd};
	check = 2;
	jQuery.post(url,param,function(result){
		if(result.ret != 0) {
			check = 1;
		}
		if(result.ret == 0) {
			if(symbol ==0){	
				window.location.href="/btc.jsp?tradeType="+tradeType+"&success";
			}else{
				window.location.href="/ltc.jsp?tradeType="+tradeType+"&success";
			}
		}
		
		 if(result.ret == 602 ){
			alertTipsSpan("交易密码错误！");
			 if(document.getElementById("tradePwd") != null){
				 document.getElementById("tradePwd").value = "";
			 }
		}

		if(result.ret == 704 ){
			 alertTipsSpan("余额不足！");
		}
		if(result.ret == 604){
			 alertTipsSpan("交易密码未设置,请到安全中心设置交易密码！");
		}
		if(result.ret == 603){
			 alertTipsSpan("账户出现安全隐患已被冻结，请尽快联系客服。");
		}
		if(result.ret == 707){
			 alertTipsSpan("系统暂时禁用交易功能,请耐心等待。");
		}
//		var result = eval('(' + data + ')');
//		if(result!=null){
//			if(result.resultCode != 0){
//				check = 1;
//			}
//			if(result.resultCode == -1){
//				 if(tradeType ==0){
//					 if(symbol==1) alertTipsSpan("最小购买数量为：0.1LTC！");
//					 else alertTipsSpan("最小购买数量为：0.01BTC！");
//				 }else{ 
//					 if(symbol==1) alertTipsSpan("最小卖出数量为：0.1LTC！");
//					 else alertTipsSpan("最小卖出数量为：0.01BTC！");
//				 }
//			 }else if(result.resultCode == -2){
//				 if(result.errorNum == 0){
//					 alertTipsSpan("交易密码错误五次，请2小时后再试！");
//				 }else{
//					 alertTipsSpan("交易密码不正确！您还有"+result.errorNum+"次机会");
//				 }
//				 if(document.getElementById("tradePwd") != null){
//					 document.getElementById("tradePwd").value = "";
//				 }
//			 }else if(result.resultCode == -3){
//				 alertTipsSpan("出价不能为0！");
//			 }else if(result.resultCode == -4){
//				 alertTipsSpan("余额不足！");
//			 }else if(result.resultCode == -5){
//				 alertTipsSpan("您未设置交易密码，请设置交易密码。");
//			 }else if(result.resultCode == -6){
//				 okcoinAlert("您输入的价格与最新成交价相差太大，请检查是否输错",null,null,"");
//			 }else if(result.resultCode == -7){
//				 alertTipsSpan("交易密码免输超时，请刷新页面输入交易密码后重新激活。");
//			 }else if(result.resultCode == -8){
//				 alertTipsSpan("请输入交易密码");
//			 }else if(result.resultCode == 0){
//				 if(symbol ==0){
//					 window.location.href="/btc.do?tradeType="+tradeType+"&success";
//				 }else{
//					 window.location.href="/ltc.do?tradeType="+tradeType+"&success";
//				 }
//			 }else if(result.resultCode == 2){
//				 alertTipsSpan("账户出现安全隐患已被冻结，请尽快联系客服。");
//			 }
//		}
	});	
}

function clearTipsSpan(){
	document.getElementById("tradeBtcTips").style.display="";
	document.getElementById("tradeBtcTips").innerHTML="";
}

function alertTipsSpan(tips){
	document.getElementById("tradeBtcTips").style.display="";
	document.getElementById("tradeBtcTips").innerHTML=tips;
}

function summoneyValue(){
	var tradeType = document.getElementById("tradeType").value;
	var symbol = document.getElementById("symbol").value;
	var tradeTurnover = document.getElementById("tradeTurnover").value;
	var tradeCnyPrice = document.getElementById("tradeCnyPrice").value;
	var tradeAmount =document.getElementById("tradeAmount").value;
	tradeAmount = tradeTurnover/tradeCnyPrice;
	if(tradeAmount!= null && tradeAmount.toString().split(".")!=null &&tradeAmount.toString().split(".")[1] != null && tradeAmount.toString().split(".")[1].length>4){
		tradeAmount=tradeAmount.toFixed(5);		
		tradeAmount = tradeAmount.substring(0, tradeAmount.length-1);
	}
	document.getElementById("tradeAmount").value=tradeAmount;
	var reg=/^(-?\d*)\.?\d{1,4}$/;
    if(tradeTurnover!=null && tradeTurnover.toString().split(".")!=null && tradeTurnover.toString().split(".")[1]!=null && tradeTurnover.toString().split(".")[1].length>4){
    	if(!reg.test(tradeTurnover)){
        	document.getElementById("tradeTurnover").value = tradeTurnover.substring(0, tradeTurnover.length-1);
            return false;
        }
    }
	if(tradeType ==0){
		if(document.getElementById("userBalance")!=null && Number(document.getElementById("userBalance").value) < Number(tradeTurnover)){
			alertTipsSpan("您的余额不足，请先充值");
			return;
		}else{
			clearTipsSpan();
//			document.getElementById("btcFeeTips").innerHTML=document.getElementById("feeTipsValue").value;
		}
	}else{
		if(document.getElementById("userBalance")!=null && Number(document.getElementById("userBalance").value ) < Number(tradeAmount)){
			if(symbol == 0){
				alertTipsSpan("您的BTC余额不足");
			}else{
				alertTipsSpan("您的LTC余额不足");
			}
			return;
		}else{
			clearTipsSpan();
//			document.getElementById("btcFeeTips").innerHTML=document.getElementById("feeTipsValue").value;
		}
	}
}

function getEntrust(){
	var status =  document.getElementById("selectedStatus").value;
	window.location.href = "/entrust.jsp?status="+status;
}
