<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>幸运大抽奖</title>
	<jsp:include page="common_source_head.jsp" />
</head>
<body class="drawer drawer-right" style="background-image: url('assets/images/back.jpg');background-repeat: no-repeat;">
<jsp:include page="top.jsp"/>
<div class="content" style="width:80%;margin:10.2rem auto;padding: 4rem 2rem !important;background: rgba(251,143,15,0.9);border-left: 1rem solid #e42828;border-right: 1rem solid #e42828;box-shadow: 0 1px 20px rgba(0,0,0,.5);-moz-user-select: none;">
<h4 style="color:#fff;text-align: center">您还有<span id="lotto_left"></span>次抽奖机会</h1>
<p style="text-align: center;margin: 1rem 0rem 1rem 0rem"><button class="btn btn-danger btn-lg" onclick="doLotto()" id="lottoBtn">立即抽奖</button></p>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
$('document').ready(function(){
	loadLottoData();
});
function loadLottoData(){
	var lottoUrl="/lotto/getLottoInfo?random="+Math.round(Math.random()*100);
	$.get(lottoUrl,function(res){
		if(res){
			if(res.ret==0){
				if(res.data<=0){
					$("#lottoBtn").html("无法抽奖");
					$("#lottoBtn").attr("disabled",true);
					swal({
                      title: "操作失败",  
                      text: "对不起，您现在还没有抽奖机会",  
                      type: "error",  
                      showCancelButton: false,  
                      confirmButtonColor: "#A7D5EA",  
                      confirmButtonText: "确认" },
                      function(){  
                           /* window.location.href="user_index.jsp"; */
                      });
				}
				$("#lotto_left").html(res.data);
			}
		}
	});
}
function doLotto(){
	$("#lottoBtn").html("抽奖中");
	$("#lottoBtn").attr("disabled",true);
	
	var lottoUrl="/lotto/doLottoInfo?random="+Math.round(Math.random()*100);
	$.get(lottoUrl,function(res){
		if(res){
			if(res.ret==0){
				var coin=res.data["coin"];
				var isWin=res.data["win"];
				var lotteryTime=res.data["lotteryTime"];
				var text="谢谢参与，您没有中奖，剩余次数："+lotteryTime;
				if(isWin){
					text="恭喜您，中得金币"+coin+"，剩余次数："+lotteryTime;
				}
				var href="";
				if(lotteryTime!=0){
					$("#lottoBtn").attr("disabled",false);
					$("#lottoBtn").html("继续抽奖");
				}else{
					$("#lottoBtn").html("抽奖结束");
				}
				swal({
                 title: "抽奖结果",  
                 text: text,  
                 type: "info",  
                 showCancelButton: false,  
                 confirmButtonColor: "#A7D5EA",  
                 confirmButtonText: "确认" },
                 function(){  
                      /* window.location.href=href; */
                      $("#lotto_left").html(lotteryTime);
                 });
			}
		}
	});
}
</script>
<script type="text/javascript">
document.getElementById("head_title").innerHTML="抽奖";
$("#top_back_button").html("<a class=\"react\" href=\"user_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
$("#foot_space").hide();
$(".copyright").hide();
</script>
<style>
#lotto_left{font-size: 1.8rem;font-weight: 800;color: #fff}
</style>
</body>
</html>