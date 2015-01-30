<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String page_url = request.getServletPath();%>
<%
boolean home=false;
boolean area=false;
boolean type=false;
boolean version=false;
boolean shops=false;
boolean users=false;
boolean proxy_city=false;
boolean proxy_area=false;
boolean rmb_withdraw=false;
if (page_url.indexOf("/index.jsp") != -1) {
	home = true;
} else if (page_url.indexOf("/area.jsp") != -1){
	area = true;
} else if (page_url.indexOf("/type.jsp") != -1){
	type = true;
} else if(page_url.indexOf("/version.jsp")!=-1){
	version=true;
}else if(page_url.indexOf("/shops.jsp")!=-1){
	shops=true;
}else if(page_url.indexOf("/users.jsp")!=-1){
	users=true;
}else if(page_url.indexOf("/proxy_area.jsp")!=-1){
	proxy_area=true;
}else if(page_url.indexOf("/proxy_city.jsp")!=-1){
	proxy_city=true;
}else if(page_url.indexOf("/rmb_withdraw.jsp")!=-1){
	rmb_withdraw=true;
}
%>
<div class="sidebar" id="sidebar">
	<script type="text/javascript">
		try{ace.settings.check('sidebar' , 'fixed')}catch(e){}
	</script>
	<ul class="nav nav-list">
		<li class="<%=home?"active":""%>"><a href="index.jsp"><i class=" icon-home"></i><span class="menu-text"> 欢迎页 </span></a></li>
		<li class="<%=area?"active":""%>"><a href="area.jsp"><i class="icon-filter"></i><span class="menu-text">区域管理</span></a></li>
		<li class="<%=type?"active":""%>"><a href="type.jsp"><i class="icon-filter"></i><span class="menu-text">类别管理</span></a></li>
		<li class="<%=users?"active":""%>"><a href="users.jsp"><i class="icon-group"></i><span class="menu-text">用户管理</span></a></li>
		<li class="<%=shops?"active":""%>"><a href="shops.jsp"><i class="icon-bar-chart"></i><span class="menu-text">商铺管理</span></a></li>
		<li>
		<a href="#" class="dropdown-toggle <%=proxy_area||proxy_city?"active":""%>">
			<i class=" icon-globe"></i>
			<span class="menu-text">代理设置 </span>
			<b class="arrow icon-angle-down"></b>
		</a>
			<ul class="submenu">
				<li>
					<a href="proxy_city.jsp">
						<i class="icon-cloud-upload"></i>
						城市代理
					</a>
				</li>
	
				<li>
					<a href="proxy_area.jsp">
						<i class="icon-cloud-upload"></i>
						区域代理
					</a>
				</li>
			</ul>
		</li>
		<li class="<%=rmb_withdraw?"active":""%>"><a href="rmb_withdraw.jsp"><i class="icon-barcode"></i><span class="menu-text">提现订单</span></a></li>
		<!-- <li class="<%=version?"active":""%>"><a href="version.jsp"><i class="icon-cloud-download"></i><span class="menu-text"> 版本管理 </span></a></li> -->
	</ul>
	<div class="sidebar-collapse" id="sidebar-collapse">
		<i class="icon-double-angle-left" data-icon1="icon-double-angle-left" data-icon2="icon-double-angle-right"></i>
	</div>
	<script type="text/javascript">
		try{ace.settings.check('sidebar' , 'collapsed')}catch(e){}
	</script>
</div>
