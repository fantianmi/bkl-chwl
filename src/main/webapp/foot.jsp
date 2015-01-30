<%@page import="com.bkl.chwl.utils.StringUtil"%>
<%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.km.common.utils.*"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
 boolean flag=UserUtil.islogin(request);
 %>
 <a id="redirectURI" style="display: none" target="_blank"></a>
<div class="space" id="foot_space"></div>
<div class="footer">
	<%-- <%if(flag){ %><div class="divleft"><a href="javascript:loginout()" class="btn btn-danger hollow">退出登录</a></div><%} %>
	<%if(!flag){ %><div class="divleft"><a href="login.jsp" class="btn btn-danger hollow">登录</a></div><%} %> --%>
    <div class="small-navigation-icons">
    	<!-- <a href="#" class="small-nav-icon facebook-nav"></a>
        <a href="#" class="small-nav-icon go-up up-nav"></a>
        <a href="#" class="small-nav-icon twitter-nav"></a> -->
        <div class="clear"></div>
    </div>
    <p class="copyright">大小王科技@版权所有 4001568848（热线）</p>
</div>
<div class="searchBarArea" style="display: none" id="searchBarArea">
	<nav class="navbar navbar-default navbar-fixed-top navbar-inverse" role="navigation" style="padding:.5rem;border-color: #ED6A00;background-color: #ED6A00">
	  <div class="input-group">
	  <span class="input-group-btn">
        <button class="btn btn-danger" type="button" onclick="searchBarHide()">关闭</button>
      </span>
      <input type="text" class="form-control" id="keywords" placeholder="请输入关键字....">
      <span class="input-group-btn">
        <button class="btn btn-default" type="button" onclick="searchSubmit()">搜一下</button>
      </span>
    </div><!-- /input-group -->
	</nav>
	<!-- res area -->
	<div class="container2" style="margin-top: 4rem;">
      <div class="decoration"></div>
	      <span id="searchShopList">
	      </span>
	       <button type="button" class="btn btn-lg btn-default btn-block" id="searchShowmoreBtn" onclick="searchShowMore()" style="display: none">显示更多...</button>
	       <div class="space_noborder"></div>
	<!-- res area -->
	</div>
</div>
<style>
.container2{width:100%;}
</style>

<script type="text/javascript">
function searchBarShow(){
	if($(".content")!=null){$(".content").hide();}
	if($(".container")!=null){$(".container").hide();}
	if($(".footer")!=null){$(".footer").hide();}
	if($(".drawer-toggle")!=null){$(".drawer-toggle").hide();}
	if($(".drawer-main")!=null){$(".drawer-main").hide();}
	if($("#cate_nav_bar")!=null){$("#cate_nav_bar").hide();}
	if($("#cate_nav_bar_foot")!=null){$("#cate_nav_bar_foot").hide();}
	if($("#searchBarArea")!=null){$("#searchBarArea").show();}
	var windowHeight=$(window).height();
	$("#searchBarArea").height(windowHeight);
}

function searchBarHide(){
	$(".content").show();
	$(".container").show();
	$(".footer").show();
	$(".drawer-toggle").show();
	$(".drawer-main").show();
	$("#cate_nav_bar").show();
	$("#cate_nav_bar_foot").show();
	$("#searchBarArea").hide();
	$("#searchShopList").html("");
	$("#searchShowmoreBtn").hide();
}

var searchPageNow=1;
function searchSubmit(){
	var keywords=$("#keywords").val();
	var url="/shop/getShopPageHTML?random="+Math.round(Math.random()*100);
	var params={searchKey:"id,title,detail",searchText:keywords};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				if(res.data!=""&&res.data!=null){
					$("#searchShopList").html(res.data);
					$("#searchShowmoreBtn").show();
				}else{
					$("#searchShopList").html("<div class=\"tableList downborder\"><div class=\"detail\" style=\"padding-left:1rem\">-_- 没有搜索到，换个词试试~</div></div>");
					$("#searchShowmoreBtn").html("没有更多内容了..");
					$("#searchShowmoreBtn").attr("disabled","disabled"); 
				}
			}
		}else{
			swal("错误", "服务器连接不上，请检查您的网络", "error");
		}
	});
}
function searchShowMore(){
	searchPageNow++;
	var keywords=$("#keywords").val();
	var url="/shop/getShopPageHTML?random="+Math.round(Math.random()*100);
	var newUrl=url+"&pagesize=20&pagenum="+searchPageNow;
	var params={searchKey:"id,title,detail",searchText:keywords};
	$.get(newUrl,function(res){
		if(res){
			if(res.ret==0){
				if(res.data!=null&&res.data!=""){
					$("#searchShopList").append(res.data);
				}else{
					$("#searchShowmoreBtn").html("没有更多内容了..");
					$("#searchShowmoreBtn").attr("disabled","disabled"); 
				}
			}
		}else{
			swal("错误", "服务器连接不上，请检查您的网络", "error");
		}
	});
}

</script>
<!-- wechat -->
<%
String weixinurl=MainConfig.getContextPath()+request.getServletPath().substring(1, request.getServletPath().length());
if(request.getQueryString()!=null&&!request.getQueryString().equals("")&&!request.getQueryString().equals("null")){
	weixinurl=weixinurl+"?"+request.getQueryString();
}
System.out.println(weixinurl);
Weixin weixin=WeixinApi.getWeixin();
String timestamp="";
String nonceStr="";
String signatuure="";
if(weixin!=null){
	Map<String,String> sign=Sign.sign(weixin.getTicket(), weixinurl);
	timestamp=sign.get("timestamp");
	nonceStr=sign.get("nonceStr");
	signatuure=sign.get("signature");
}
User u=UserUtil.getCurrentUser(request);
String recommendURL=MainConfig.getContextPath()+"reg.jsp";
if(u!=null){
	recommendURL+="?r="+u.getId();
}

%>
<button style="display: none" id="scanQRCode"></button>
<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
<script type="text/javascript">
wx.config({
    debug: false,
    appId: '<%=MainConfig.getWechatappid()%>', // 必填，公众号的唯一标识
    timestamp: <%=timestamp%>, // 必填，生成签名的时间戳
    nonceStr: '<%=nonceStr%>', // 必填，生成签名的随机串
    signature: '<%=signatuure%>',// 必填，签名，见附录1
    jsApiList: [
                'checkJsApi',
                'onMenuShareTimeline',
                'onMenuShareQQ',
                'onMenuShareWeibo',
                'onMenuShareAppMessage',
                'scanQRCode',
              ]
	});
	wx.ready(function () {
		document.querySelector('#scanQRCode').onclick = function () {
		    wx.scanQRCode({
		      desc: 'scanQRCode desc',
		      success: function () { 
		      },
		      cancel: function () { 
		          window.location.href="scanQR.jsp";
		      }
		    });
		  };
		var shareData = {
			    title: '点头财神',
			    desc: '一款线下面对面消费结账APP',
			    link: '<%=recommendURL%>',
			    imgUrl: 'http://mmbiz.qpic.cn/mmbiz/icTdbqWNOwNRt8Qia4lv7k3M9J1SKqKCImxJCt7j9rHYicKDI45jRPBxdzdyREWnk0ia0N5TMnMfth7SdxtzMvVgXg/0'
			  };
			wx.onMenuShareQQ(shareData);
			wx.onMenuShareWeibo(shareData);
		    wx.onMenuShareAppMessage(shareData);
		    wx.onMenuShareTimeline(shareData);
	});

	

	wx.error(function (res) {
	});
</script>


