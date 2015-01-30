<%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 <%
 User user = UserUtil.getCurrentUser(request);
 BindCardService cardServ=new BindCardServiceImpl();
 List<User2BindCard> cards=cardServ.getUser2Cards(user.getId());
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
<div class="alert alert-info" role="alert">请设置一张银行卡作为默认收款卡，如果没有设置或者没有银行卡，用户结账的款项会直接转化为金币到您的平台账户中</div>
<%if(cards.size()!=0){ 
for(User2BindCard card:cards){
%>
<div class="tableList downborder card_list_div <%=card.getIsdefault()==card.DEFAULT_TRUE?"active":"" %>"  id="card_list_<%=card.getBid() %>">
<a href="javascript:void(0);" onclick="showChosenWindow(<%=card.getBid() %>)" class="card_list" style="width:100% !important;"><div class="detail" style="padding-left: 1rem;width:100% !important;"><i class="iconfont">&#xe610;</i>&nbsp;&nbsp;<%=card.getBank_o()+"&nbsp;&nbsp;&nbsp;"+FrontUtil.hiddenNum(card.getBank_account_o()) %></div></a><%=card.getIsdefault()==card.DEFAULT_TRUE?"<div id=\"default_card_tag\">收款卡</div>":"" %>
</div>
<%}}else{%>
<div class="tableList downborder card_list_div">
	<a href="#" class="card_list"><div class="detail" style="padding-left: 1rem"><i class="iconfont">&#xe610;</i>&nbsp;&nbsp;没有银行卡，请添加</div><div class="status"></div></a>
</div>
<%} %>
<div class="tableList downborder " style="background-color: #F0EFED">
<a href="input_card_num.jsp" style="color:#666"><div class="detail" style="padding-left: 1rem"><i class="iconfont">&#xe64c;</i>&nbsp;&nbsp;添加银行卡</div></a>
</div>
</div>

<div class="chosen_window" >
<a id="closeButton" href=""><i class="iconfont">&#xe659;</i></a>
<div class="title"><h2>请选择操作</h2></div>
<div class="selectArea">
<div class="col-xs-6"><button class="btn btn-warning" onclick="redirectUpdate()">修改信息</button></div>
<div class="col-xs-6"><button class="btn btn-success" onclick="setDefault()">设为收款卡</button></div>
</div>
</div>

 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
$("#closeButton").click(function(){
	$(".chosen_window").hide();
});

$("#head_title").html("我的银行卡");
$("#top_back_button").html("<a class=\"react\" href=\"shop_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
$("#top_qr_button").hide();
$("#top_search_button").hide();

var select_card_id=0;
function showChosenWindow(id){
	$(".chosen_window").show();
	select_card_id=id;
}
function redirectUpdate(){
	if(select_card_id==0){return}
	window.location.href="update_card_info_full.jsp?id="+select_card_id;
	$(".chosen_window").hide();
}
function setDefault(){
	if(select_card_id==0){return}
	var url="/api/bind/setDefault?random="+Math.round(Math.random()*100);
	var params={id:select_card_id};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				$(".chosen_window").hide();
				window.location.href=window.location.href;
			}
		}
	});
}


</script>
<style>
#closeButton{
position: absolute;
top:10px;
right:10px;
z-index:3000;
}
#closeButton .iconfont{
color:#fff;
font-size: 25px;
}
#default_card_tag{
position: absolute;
right:5px;
top:10px;
border:1px solid #fff;
padding:5px;
border-radius:4px;
background-color:#fff;
font-size:12px;
color:#488443;
}
.card_list{color:#fff;float:left;}
.card_list_div.active{background-color:#488443;}
.card_list .status{color:ccc}
.card_list_div{background-color: #5DB755;border-radius:4px;margin:0px 1px;}
.card_list_div:hover{background-color: #70d268;}
.chosen_window{
display:none;
height:300px;
width:80%;
background: rgba(0,0,0,0.9);
border-radius:2px;
 box-shadow: 0 1px 20px rgba(0,0,0,.5);-moz-user-select: none;
 position:absolute;
 top:5.5rem;
padding:1rem 0rem 0rem 0rem;
left:10%;
z-index:2000;
text-align: center;
}
.title{height:173px;margin:auto 0;padding-top:60px;color:#fff"}
.title h2{color:#fff}
.selectArea{width:80%;margin:0 auto}
.selectArea .col-xs-6{padding:0px;}
</style>
<jsp:include page="updateProfileTimes.jsp"/>
</body>
</html>