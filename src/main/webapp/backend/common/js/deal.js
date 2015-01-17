function confirmRecharge(id) {
	if(!confirm("是否确认已经收取这笔款项?")) return;
	$.ajax({
		url : '/admin_api/confirmRecharge',
		data : {
			id : id
		}
	}).done(function(result){
		if(result.ret == 0) {
			window.location.href = window.location.href;
		} else if(result.ret == -1) {
			alert("登录超时");
			window.location.href = "/backend/login.jsp";
		} else if(result.ret == 701) {
			alert("找不到该充值记录!");
		} else if(result.ret == 702) {
			alert("已经确认,请勿重复操作!");
		} else if(result.ret == 703) {
			alert("充值用户不正常");					
		} else {
			alert("服务器异常,请与管理员联系!")
		}
	}).error(function(){
		alert("服务器异常,请与管理员联系!")
	});
}
function confirmBtcIn(id) {
	if(!confirm("是否确认已经收取这笔款项?")) return;
	$.ajax({
		url : '/admin_api/confirmBtcIn',
		data : {
			id : id
		}
	}).done(function(result){
		if(result.ret == 0) {
			window.location.href = window.location.href;
		} else if(result.ret == -1) {
			alert("登录超时");
			window.location.href = "/backend/login.jsp";
		} else if(result.ret == 701) {
			alert("找不到该充值记录!");			
		} else if(result.ret == 702) {
			alert("已经确认,请勿重复操作!");			
		} else if(result.ret == 703) {
			alert("充值用户不正常");			
		} else if(result.ret == 704) {
			alert("余额不足");
		} else {
			alert("服务器异常,请与管理员联系!")
		}
	}).error(function(){
		alert("服务器异常,请与管理员联系!")
	});
}
function confirmWithdraw(id) {
	if(!confirm("是否确认已经支付这笔款项?")) return;
	$.ajax({
		url : '/admin_api/confirmWithdraw',
		data : {
			id : id
		}
	}).done(function(result){
		if(result.ret == 0) {
			window.location.href = window.location.href;
		} else if(result.ret == -1) {
			alert("登录超时");
			window.location.href = "/backend/login.jsp";
		} else if(result.ret == 701) {
			alert("找不到该提现记录!");			
		} else if(result.ret == 702) {
			alert("已经确认,请勿重复操作!");	
		} else if(result.ret == 706) {
			alert("提现申请已经取消,非法操作!");	
		} else if(result.ret == 703) {
			alert("提现用户不正常");					
		} else {
			alert("服务器异常,请与管理员联系!")
		}
	}).error(function(){
		alert("服务器异常,请与管理员联系!")
	});
}
function cancelWithdraw(id) {
	if(!confirm("是否取消支付这笔款项?")) return;
	$.ajax({
		url : '/admin_api/cancelWithdraw',
		data : {
			id : id
		}
	}).done(function(result){
		if(result.ret == 0) {
			window.location.href = window.location.href;
		} else if(result.ret == -1) {
			alert("登录超时");
			window.location.href = "/backend/login.jsp";
		} else if(result.ret == 701) {
			alert("找不到该提现记录!");			
		} else if(result.ret == 702) {
			alert("提现申请已经确认,非法操作!");	
		} else if(result.ret == 706) {
			alert("已经取消,请勿重复操作!");	
		} else if(result.ret == 703) {
			alert("提现用户不正常");	
		} else {
			alert("服务器异常,请与管理员联系!")
		}
	}).error(function(){
		alert("服务器异常,请与管理员联系!")
	});
}
function confirmBtcOut(id) {
	if(!confirm("是否确认已经支付这笔款项?")) return;
	$.ajax({
		url : '/admin_api/confirmBtcOut',
		data : {
			id : id
		}
	}).done(function(result){
		if(result.ret == 0) {
			window.location.href = window.location.href;
		} else if(result.ret == -1) {
			alert("登录超时");
			window.location.href = "/backend/login.jsp";
		} else if(result.ret == 701) {
			alert("找不到该提现记录!");			
		} else if(result.ret == 702) {
			alert("已经确认,请勿重复操作!");		
		} else if(result.ret == 703) {
			alert("提现用户不正常");					
		} else if(result.ret == 704) {
			alert("余额不足");
		} else {
			alert("服务器异常,请与管理员联系!")
		}
	}).error(function(){
		alert("服务器异常,请与管理员联系!")
	});
}


function cancelBtcWithdraw(id) {
	if(!confirm("是否取消支付这笔款项?")) return;
	$.ajax({
		url : '/admin_api/cancelBtcWithdraw',
		data : {
			id : id
		}
	}).done(function(result){
		if(result.ret == 0) {
			window.location.href = window.location.href;
		} else if(result.ret == -1) {
			alert("登录超时");
			window.location.href = "/backend/login.jsp";
		} else if(result.ret == 701) {
			alert("找不到该提现记录!");			
		} else if(result.ret == 702) {
			alert("提现申请已经确认,非法操作!");	
		} else if(result.ret == 706) {
			alert("已经取消,请勿重复操作!");	
		} else if(result.ret == 703) {
			alert("提现用户不正常");	
		} else {
			alert("服务器异常,请与管理员联系!")
		}
	}).error(function(){
		alert("服务器异常,请与管理员联系!")
	});
}