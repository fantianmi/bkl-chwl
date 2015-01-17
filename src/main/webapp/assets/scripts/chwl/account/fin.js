function submitFinForm(){
	var type = document.getElementById("finType").value;
	var random = document.getElementById("random").value;
	var minAmout = document.getElementById("mini_recharge_amount").value;
	var cash_amount_decimal_precision = document.getElementById("cash_amount_decimal_precision").value;
	cash_amount_unit = getNumberByDecimalPrecision(cash_amount_decimal_precision);
	var money = 0;    
   	var finMoneyRadio=document.getElementsByName("finMoney");
    if(finMoneyRadio!=null){
        var i;
        for(i=0;i<finMoneyRadio.length;i++){
            if(finMoneyRadio[i].checked){
            	money =  finMoneyRadio[i].value;
            	if(document.getElementById("number6").checked){
            		money = document.getElementById("diyMoney").value;
            	}
            }
        }
    }
    /*
    if(money.toString().indexOf(".")!=-1){
    	money = money.toString().split(".")[0];
    	money = money+(random.substring(1));
    }else{
    	money = money+(random.substring(1));
    }*/
    if(money<minAmout || isNaN(money)){
    	okcoinAlert("最小充值金额为" + minAmout + "元","",null);
    	return;
    }
    if (isExceedPrecision(money,cash_amount_decimal_precision)) {
    	okcoinAlert("最小充值单位为" + cash_amount_unit + "元","",null);
    	return;
    }
    var bankID = -1;
    var typeParam="";
    if(type == 1){//支付宝网银
    	var bankRadio=document.getElementsByName("bankID");
	    if(bankRadio!=null){
	        var i;
	        for(i=0;i<bankRadio.length;i++){
	            if(bankRadio[i].checked){
	            	bankID =  bankRadio[i].value;
	            }
	        }
	    }
	    if(bankID == -1){
	    	okcoinAlert("请选择银行","",null);
	    	return;
	    }
	    typeParam = "&frp="+bankID;
    }else if(type == 2 || type == 3 || type == 4 || type==6){//支付宝手动
    	var url = "/api/cash/saveRecharge?random="+Math.round(Math.random()*100);
    	var param={amount:money,type:type};
    	jQuery.post(url,param,function(data){
    		/*
    		if(data&& data.ret ==0) {
    			window.location.reload();
    		}
    		*/
    		// var result = eval('(' + data + ')');
    		if(data && data.ret == 0){
    			if(type == 2){
    				document.getElementById("tips1").innerHTML="1. 登录您的财付通，进入'转账'。";
    				document.getElementById("tips2").innerHTML="2. 按照下表填写“我要付款”表单：";
    				document.getElementById("tips3").innerHTML="3. 输入“校验码”并点击“下一步”付款。";
    				document.getElementById("tips2title").innerHTML="财付通";
    				document.getElementById("tips2ul").style.display="";
    				document.getElementById("tipsTenpay").style.display="";
    		    	document.getElementById("tipsAlipay").style.display="none";
    		    	document.getElementById("tips2bank").style.display="none";
    		    	document.getElementById("tips6ul").style.display="none";
    			}else if(type == 3){
    				document.getElementById("tips1").innerHTML="1. 登录您的支付宝，进入'我要付款'。";
    				document.getElementById("tips2").innerHTML="2. 按照下表填写“我要付款”表单：";
    				document.getElementById("tips3").innerHTML="3. 输入“校验码”并点击“下一步”付款。";
    				document.getElementById("tips2title").innerHTML="支付宝";
    				document.getElementById("alipayhandDiv").style.display="";
    				document.getElementById("tips2ul").style.display="";
    				document.getElementById("tips2bank").style.display="none";
    				document.getElementById("moneyDiv").style.display="none";
    				document.getElementById("specificStepBackground").className = "specificStepBackground2";
    				
    		    	document.getElementById("alipayManualMoney").innerHTML = money;
    		    	document.getElementById("subMoney").innerHTML = money;
    		    	document.getElementById("alipayManualInfo").innerHTML = data.data;
    		    	document.getElementById("desc").innerHTML = data.data;
    		    	
    		    	refTenbody();
    			}else  if(type == 4){
    				document.getElementById("tips1").innerHTML="1. 登录您的银行网银，选择转账汇款，或者去银行柜台，要求转账汇款。";
    				document.getElementById("tips2").innerHTML="2. 按照下表填写银行汇款信息表单：";
    				document.getElementById("tips3").innerHTML="3. 然后根据要求和提示完成汇款。";
    				document.getElementById("alipayhandDiv").style.display="";
    				document.getElementById("tips2ul").style.display="none";
    				document.getElementById("tips2bank").style.display="";
    				document.getElementById("moneyDiv").style.display="none";
    				
    				document.getElementById("specificStepBackground").className = "specificStepBackground2";
    				
    		    	document.getElementById("bankMoney").innerHTML = money;
    		    	document.getElementById("subMoney").innerHTML = money;
    		    	document.getElementById("bankInfo").innerHTML = data.data;
    		    	document.getElementById("desc").innerHTML = data.data;
    		    	
    		    	refTenbody();
    		    	
    			}else if(type == 6){
    				document.getElementById("tips1").innerHTML="1. <a target='_blank' href=' http://item.taobao.com/item.htm?spm=a230r.1.14.19.rESicv&id=26790916474&initiative_new=1'>访问OKCoin官方淘宝店。</a>";
    				document.getElementById("tips2").innerHTML="2. 拍下相应金额的宝贝，比如充值"+money+"元，请拍"+money+"件一元宝贝,按照下表填写表单：";
    				document.getElementById("tips3").innerHTML="3. 提交完订单以后，请联系网站客服进行发货。";
    				document.getElementById("payResultTips").innerHTML="确认收货后";
    				document.getElementById("tips2ul").style.display="none";
    				document.getElementById("tips2bank").style.display="none";
    				document.getElementById("tipsTenpay").style.display="none";
    		    	document.getElementById("tipsAlipay").style.display="none";
    		    	document.getElementById("tips6ul").style.display="";
    		    	document.getElementById("taobaoTips4").style.display="";
    			}
//	    			if(type != 6){
//	    				document.getElementById("payResultTips").innerHTML="付款完成后";
//	    				document.getElementById("taobaoTips4").style.display="none";
//	    			}
//	    			if(type==2 || type == 3){
//	    				document.getElementById("alipayManualMoney").innerHTML=result.money+"元";
//		    			document.getElementById("alipayManualInfo").innerHTML=result.tradeId+","+result.userId;
//	    			}else if(type == 6){
//	    				document.getElementById("taobaoMoney").innerHTML=result.money+"件";
//		    			document.getElementById("taobaoInfo").innerHTML=result.tradeId+","+result.userId;
//	    			}else{
//	    				document.getElementById("bankMoney").innerHTML=result.money+"元";
//		    			document.getElementById("bankInfo").innerHTML=result.tradeId+","+result.userId;
//	    			}
    			
    		} else if (data.ret == 711) {
    			okcoinAlert("最小充值金额为" + minAmout + "元","",null);
    			return;
    		} else if (data.ret == 708) {
    			okcoinAlert("现金充值的最小单位是" + cash_amount_unit + "元","",null);
    			return;
    		}
    	});
    	
    	return;
    }
    if (type == 0) {
	    document.getElementById("finTipsDiv").style.display="";
		dialogBoxShadow();
		
		var finButton = document.getElementById("finButton");
		finButton.target="_blank" ;
		
		var pay_url = "/api/cash/pay?amount=" + money + typeParam;
		
		pay_url += "&type=" + type;
		finButton.href = pay_url;  
    } 
    if (type == 5) {
	   
		
		var pay_url = "/api/cash/pay4huichao?amount=" + money + typeParam;
		pay_url += "&type=" + type;
		var finButton = document.getElementById("finButton");
		finButton.href = pay_url;  
    } 
    
}

function confirmRecharge() {
	jQuery.ajax({
		url:'/payquery/getXmlData.jsp', 
		type: 'GET',
		success: function(result){
			console.log(result);
			window.location.href = "/rechargeCny.jsp?type=0";
		},
		error: function(){
			
		}
	})

}
function closeFinTipsDiv(){
	dialogBoxHidden();
	document.getElementById("finTipsDiv").style.display="none";
}

function showDiyMoney(type){
	if(type ==6){
		document.getElementById("diyMoney").style.display="";
	}else{
		document.getElementById("diyMoney").style.display="none";
	}
}
function clearDiyMoney(){
	var diyMoney = document.getElementById("diyMoney").value;
	if("请输入金额" == diyMoney){
		document.getElementById("diyMoney").value = "";
	}
}

function changebank(id){
	jQuery("#banks").find("label").each(function() {
		jQuery(this).removeClass(" current");
	});
		jQuery("#label_" + id).addClass(" current");
}
var bankId = document.getElementsByName("bankID");
for(var i = 0;i < bankId.length;i++){
	bankId[i].onclick=function(){
	changebank(this.id);
	};
}

function moreBanks(){
	
	document.getElementById("li_Bank12").style.display="";
	//document.getElementById("li_Bank13").style.display="";
	document.getElementById("li_Bank14").style.display="";
	document.getElementById("li_Bank15").style.display="";
	document.getElementById("li_Bank16").style.display="";
	//document.getElementById("li_Bank17").style.display="";
	//document.getElementById("li_Bank18").style.display="";
	document.getElementById("li_Bank19").style.display="";
	//document.getElementById("li_Bank20").style.display="";
	document.getElementById("moreBanks").style.display="none";
}
/**
 * 支付宝人工操作 返回修改金额
 */
function backModifyMoney(){
	document.getElementById("alipayhandDiv").style.display="none";
	document.getElementById("finButton").style.display="";
	document.getElementById("moneyDiv").style.display="";
	document.getElementById("specificStepBackground").className = "specificStepBackground1";
}

function submitPaymentInformation(){
	if(confirm("您确定已经登录网银给我们汇款了么？")){
		document.getElementById("alipayhandDiv").style.display="none";
		document.getElementById("blankRemittance").style.display="";
		document.getElementById("specificStepBackground").className = "specificStepBackground3";
	}
}

function submitTransferAccounts(){
	
	var bank = document.getElementById("fromBank").value;
	var account = document.getElementById("fromAccount").value;
	var payee = document.getElementById("fromPayee").value;
	/*
	var phone = document.getElementById("fromPhone").value;
	var obj =document.getElementsByName("fromType");
	var type = "";
	for(var i=0;i<obj.length;i++){
	    if(obj.item(i).checked){
	    	type=obj.item(i).getAttribute("value");  
	        break;
	     }else{
	    	 continue;
	  }
	}
	*/
	var desc = document.getElementById("desc").innerHTML;
	if(bank == "" || account == "" || payee == "" /* || phone== "" || type == "" */ || desc ==""){
		okcoinAlert("请填写完整信息！","",null);
    	return;
	}
	var url = "/api/cash/updateRecharge?random="+Math.round(Math.random()*100);
	//var param={bank:bank,account:account,payee:payee,phone:phone,type:type,desc:desc};
	var param={bank:bank,card:account,name:payee,/*phone:phone,type:type,*/id:desc};
	jQuery.post(url,param,function(data){
		if(data){
			if(data.ret == -2){
				okcoinAlert("请填写完整信息！","",null);
			}else if(data.ret == 0){
				document.getElementById("blankRemittance").style.display = "none";
				document.getElementById("TransferAccountsComplete").style.display = "block";
				document.getElementById("riskArea4").style.display = "";
				refTenbody();
				document.getElementById("specificStepBackground").className = "specificStepBackground4";
			}else if(data.ret == -3){
				okcoinAlert("这个备注已经被使用！","",null);
			}else if (data.ret == 801) {
				okcoinAlert("服务器繁忙，请稍后重试");
			}
		}
	});
}

function updateFinTransactionReceive(fid,money){
	document.getElementById("subMoney").innerHTML = money;
	document.getElementById("desc").innerHTML = fid;
	document.getElementById("finButton").style.display="none";
	document.getElementById("moneyDiv").style.display="none";
	document.getElementById("alipayhandDiv").style.display="none";
	document.getElementById("blankRemittance").style.display="";
	document.getElementById("TransferAccountsComplete").style.display="none";
	document.getElementById("specificStepBackground").className = "specificStepBackground3";
}

function refTenbody(){
	window["renderPageData"] = function(page) {
		jQuery.ajax({
			url: "/api/cash/getRechargePage?random="+Math.round(Math.random()*100),
			data: {pagenum: page, pagesize: 10},
			success: function(data){
				var tpl = document.getElementById("recharge_tpl").text;
				var html = jQuery.template(tpl).render(data);
				jQuery("#Tenbody").html(html);
				renderPager("page", page, 10, data.data.totalcount);
			}
		});
	};
	renderPageData(1);
}
refTenbody();