function activeUser(id) {
	if(!confirm("是否激活当前用户?")) return;
	$.ajax({
		url : '/admin_api/activeUser',
		data : {
			id : id
		}
	}).done(function(result){
		if(result.ret == 0) {
			window.location.href = window.location.href;
		} else if(result.ret == -1) {
			alert("登录超时");
			window.location.href = "/backend/login.jsp";
		} else {
			alert("服务器异常,请与管理员联系!")
		}
	}).error(function(){
		alert("服务器异常,请与管理员联系!")
	});
}
function enableUser(id, frozen) {
	if(!confirm(frozen == 0 ? "是否启当前用户?" : "是否禁用当前用户?")) return;
	$.ajax({
		url : '/admin_api/frozen',
		data : {
			id : id,
			frozen: frozen
		}
	}).done(function(result){
		if(result.ret == 0) {
			window.location.href = window.location.href;
		} else if(result.ret == -1) {
			alert("登录超时");
			window.location.href = "/backend/login.jsp";
		} else {
			alert("服务器异常,请与管理员联系!")
		}
	}).error(function(){
		alert("服务器异常,请与管理员联系!")
	});
}
function vertifyUser(id){
	var url="/admin_api/vertify?random="+Math.round(Math.random()*100);
	var params={id:id};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				window.location.href = window.location.href;
			}
		}
	});
}
function unVertifyUser(id){
	var url="/admin_api/unvertify?random="+Math.round(Math.random()*100);
	var params={id:id};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				window.location.href = window.location.href;
			}
		}
	});
}
function confirmRealName(id, status) {
	if(!confirm(status == 1 ? "是否确认当前用户实名认证?" : "是否否决当前用户实名认证?")) return;
	$.ajax({
		url : '/admin_api/confirmRealName',
		data : {
			id : id,
			status: status
		}
	}).done(function(result){
		if(result.ret == 0) {
			window.location.href = window.location.href;
		} else if(result.ret == -1) {
			alert("登录超时");
			window.location.href = "/backend/login.jsp";
		} else {
			alert("服务器异常,请与管理员联系!")
		}
	}).error(function(){
		alert("服务器异常,请与管理员联系!")
	});
}

function modifyUserMoney(id) {
	if(!confirm("是否确认要修改当前用户的资金?")) return;
	var rmb = document.getElementById("rmb").value;
	var rmb_frozen = document.getElementById("rmb_frozen").value;
	var btc = document.getElementById("btc").value;
	var btc_frozen = document.getElementById("btc_frozen").value;
	
	var btc_extra = -1;
	if (document.getElementById("btc_extra")) {
		
		btc_extra = document.getElementById("btc_extra").value;
	}
	var btc_extra_frozen = -1;
	if (document.getElementById("btc_extra_frozen")) {
		btc_extra_frozen = document.getElementById("btc_extra_frozen").value;
	}
	$.ajax({
		url : '/admin_api/modifyUserMoney',
		data : {
			id : id,
			rmb: rmb,
			rmb_frozen: rmb_frozen,
			btc: btc,
			btc_frozen: btc_frozen,
			btc_extra: btc_extra,
			btc_extra_frozen: btc_extra_frozen
		}
	}).done(function(result){
		if(result.ret == 0) {
			alert("修改成功");
			window.location.href = window.location.href;
		} else if(result.ret == -1) {
			alert("登录超时");
			window.location.href = "/backend/login.jsp";
		} else {
			alert("服务器异常,请与管理员联系!")
		}
	}).error(function(){
		alert("服务器异常,请与管理员联系!")
	});
}


function addExtraRmb() {
	if(!confirm("是否确认要发布分红?")) return;
	var rmb = document.getElementById("rmb").value;
	
	$.ajax({
		url : '/admin_api/addExtraRmb',
		data : {
			rmb: rmb
		}
	}).done(function(result){
		if(result.ret == 0) {
			alert("分红发布成功");
			window.location.href = window.location.href;
		} else if(result.ret == -1) {
			alert("登录超时");
			window.location.href = "/backend/login.jsp";
		} else {
			alert("服务器异常,请与管理员联系!")
		}
	}).error(function(){
		alert("服务器异常,请与管理员联系!")
	});
}