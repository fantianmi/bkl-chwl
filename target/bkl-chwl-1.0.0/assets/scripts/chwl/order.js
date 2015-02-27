function orderSubmit(){
	var seller=$("#seller").val();
	var payway=$("#payway").val();
	var price=$("#price").val();
	var coin=$("#coin").val();
	var type=$("#type").val();
	var coinRate=$("#coinRate").val();
	var bank_account_o=$("#bank_account_o").val();
	if(bank_account_o==0){
		swal("错误", "请选择支付银行卡", "error");
		return;
	}
	if(!checkNotNull&&!checkNotNull(payway)&&!checkNotNull(price)){
		swal("错误", "请确认表单是否填写完全", "error");
		return;
	}
	if(payway==2&&price>coin){
		alert("您的余额不足，您还需要支付"+(price-coin)+"元");
	}
	var url="/order/addOrder?random="+Math.round(Math.random()*100);
	var param={seller:seller,payway:payway,price:price,type:type,coinRate:coinRate};
	$.post(url,param,function(res){
		if(res){
			if(res.ret==0){
				swal({
                    title: "支付成功",  
                    text: "余额支付成功，查看订单",  
                    type: "success",  
                    showCancelButton: false,  
                    confirmButtonColor: "#A7D5EA",  
                    confirmButtonText: "确认" },
                    function(){  
                         window.location.href="/user_order.jsp";
                    });
			}else if(res.ret==618){
				swal("错误", "远程服务器连接不上", "error");
				
			}else if(res.ret==714){
				var orderId=res.data["orderId"];
				var redirectURI="payprocess.jsp?orderId="+orderId+"&bank_account_o="+bank_account_o;
				window.location.href=redirectURI;
			}else if(res.ret==715){
				swal({
                    title: "错误",  
                    text: "不能自己购买自己的商铺",  
                    type: "error",  
                    showCancelButton: false,  
                    confirmButtonColor: "#A7D5EA",  
                    confirmButtonText: "确认" },
                    function(){
                        window.location.href="/shop_list.jsp";
                    });
			}
		}
	});
}
function checkNotNull(param){
	if(param==""||param==null||param=="@"){
		return false;
	}
	return true;
}