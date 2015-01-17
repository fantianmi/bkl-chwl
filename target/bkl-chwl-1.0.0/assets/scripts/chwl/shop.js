function addShopSubmit(){
	var id=$("#id").val();
	var image=$("#image").val();
	var detail=$("#detail").val();
	var title=$("#title").val();
	var shop_map=$("#shop_map").val();
	var shop_loc=$("#shop_loc").val();
	var shop_tel=$("#shop_tel").val();
	var local=$("#local").val();
	var local2=$("#local2").val();
	var local3=$("#local3").val();
	var shop_type=$("#shop_type").val();
	var shop_type2=$("#shop_type2").val();
	var uid=$("#uid").val();
	var price=$("#price").val();
	var oprice=$("#oprice").val();
	var coinRate=$("#coinRate").val();
	if(uid==0||uid==""||uid==null){
		swal("非法操作", "请确认是否登录", "error");
		window.location.href="login.jsp";
	}
	if(!checkNotNull(image)||!checkNotNull(detail)||!checkNotNull(title)||!checkNotNull(detail)||!checkNotNull(shop_map)||!checkNotNull(shop_loc)||!checkNotNull(shop_tel)||local==0||!checkNotNull(oprice)||!checkNotNull(price)||!checkNotNull(coinRate)){
		swal("错误", "请确认表单是否填写完全", "error");
		return;
	}
	if(detail.length>400){
		swal("错误", "详情超过了200字，请修改", "error");
		return;
	}
	var url="/shop/addShop?random="+Math.round(Math.random()*100);
	var params={id:id,uid:uid,image:image,detail:detail,title:title,shop_map:shop_map,shop_loc:shop_loc,shop_tel:shop_tel,local:local,local2:local2,local3:local3,shop_type:shop_type,shop_type2:shop_type2,price:price,oprice:oprice,coinRate:coinRate};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				swal({
					title: "成功",   
                    text: "添加完毕，查看详情",   
                    type: "success",   
                    showCancelButton: false,   
                    confirmButtonColor: "#A7D5EA",   
                    confirmButtonText: "确认" }, 
                    function(){   
                    	window.location.href="shop_info.jsp";
                    });
			}else if(res.ret==619){
				swal("错误", "您还没有通过审核，请耐心等待", "error");
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