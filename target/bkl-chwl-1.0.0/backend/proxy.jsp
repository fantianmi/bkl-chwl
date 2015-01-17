<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.km.common.vo.*"%>
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
	ProxyService proxyServ=new ProxyServiceImpl();
	AreaService areaServ=new AreaServiceImpl();

	Page p =  ServletUtil.getPage(request);
	p.setPagesize(500);
	PageReply<Proxy2User> proxys = proxyServ.getProxyList(ServletUtil.getSearchMap(request), p);
	Map<Long,Area> areaMap=areaServ.areaMap(0);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="htmlhead.jsp"></jsp:include>
</head>
<body>
<jsp:include page="topbar.jsp"></jsp:include>
<div class="main-container-inner" >
	<a class="menu-toggler" id="menu-toggler" href="#">
		<span class="menu-text"></span>
	</a>
	<jsp:include page="menu.jsp"></jsp:include>
	<!-- content -->
	<div class="main-content">
		<div class="breadcrumbs" id="breadcrumbs">
			<script type="text/javascript">
				try{ace.settings.check('breadcrumbs' , 'fixed')}catch(e){}
			</script>
			<ul class="breadcrumb">
				<li>
					<i class="icon-home home-icon"></i>
					<a href="index.jsp">Home</a>
				</li>
				<li class="active">
					代理管理
				</li>
			</ul><!-- .breadcrumb -->
			<div class="nav-search" id="nav-search">
				<form class="form-search">
					<span class="input-icon">
						<input type="text" placeholder="搜索..." class="nav-search-input" autocomplete="off" data-keys="mobile,name" value="<%=StringUtils.defaultIfEmpty(request.getParameter("searchText"),"")%>">
						<i class="icon-search nav-search-icon"></i>
					</span>
				</form>
			</div>
		</div>
		<div class="page-content">
			<div class="row">
				<div class="col-xs-12">
					<div class="table-responsive">
					<input type="hidden" id="local"/>
					<input type="hidden" id="local2"/>
						<table class="table table-striped table-bordered table-hover dataTable">
							<thead>
								<tr>
									<th class="center"><label>#</label></th>
									<th class="center">省份</th>
									<th class="center">城市</th>
									<th class="center">代理商手机</th>
									<th class="center">代理商真实姓名</th>
									<th class="center">操作</th>
								</tr>
							</thead>
							<tbody>
								<%if(proxys.getPagedatas() == null || proxys.getPagedatas().length == 0) { %>
								<tr>
									<td colspan="100">
										<div class="alert alert-block alert-info">
											<strong class="green">提示：没有数据。</strong>
										</div>
									</td>
								</tr>
								<%} %>
								<%
									for (int i = 0; i < proxys.getPagedatas().length; i++) {
										Proxy2User proxy = proxys.getPagedatas()[i];
								%>
								<tr>
									<td><%=i+1 %></td>
									<td><%=areaMap.get(proxy.getReid()).getTitle()%></td>
									<td><%=proxy.getTitle()%></td>
									<td><%=StringUtils.defaultIfEmpty(proxy.getMobile(),"未设置代理")%></td>
									<td><%=StringUtils.defaultIfEmpty(proxy.getName(),"未设置代理")%></td>
									<td>
										<a href="javacript:void(0);" onClick="doSetProxy(<%=proxy.getReid()%>,<%=proxy.getId()%>)">[设置代理]</a>
									</td>
								</tr>
								<%}%>
							</tbody>
						</table>
						<jsp:include page="pagination.jsp">
							<jsp:param value="<%=p.getPagenum() %>" name="pagenum" />
							<jsp:param value="<%=p.getPagesize() %>" name="pagesize" />
							<jsp:param value="<%=proxys.getTotalpage() %>" name="totalPage" />
						</jsp:include>
					</div>
					<!-- /.table-responsive -->
				</div>
				<!-- /span -->
			</div>
		</div>
	</div>
</div>
<!-- content -->
<div class="ui-widget-overlay ui-front" id="bg-area" style="display: none"></div>
<div class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable" id="dialog-message" style="position: fixed; height: auto; width: 640px; height:500px;display: none;">
	<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
	<span id="ui-id-1" class="ui-dialog-title">选择代理人</span>
		<div class="dialog-content">
			<table class="table table-striped table-bordered table-hover dataTable">
				<thead>
					<tr>
						<th class="center"><label>#</label></th>
						<th class="center">手机号</th>
						<th class="center">真实姓名</th>
						<th class="center">所属省份</th>
						<th class="center">所属地区</th>
						<th class="center">操作</th>
					</tr>
				</thead>
				<tbody id="userHTML">
				</tbody>
			</table>
			<button class="btn btn-block btn-xs" onclick="showMore()" id="showMoreBtn">显示更多...</button>
		</div>
	</div>
	<div style="width: auto; min-height: 22px; max-height: none; height: 29px;" class="ui-dialog-content ui-widget-content">
	<!-- content -->
		<div class="row">
			<div class="col-xs-12">
			<div class="row-fluid">
			&nbsp;
			</div><!-- PAGE CONTENT ENDS -->
			<!-- /.table-responsive -->
			</div>
			<!-- /span -->
		</div>
		<!-- content -->
	</div>
	<div class="ui-dialog-buttonpane ui-widget-content ui-helper-clearfix">
		<div class="ui-dialog-buttonset">
		<button type="button" class="btn btn-xs ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only btn-danger" onclick="unShowProxy()" ><span class="ui-button-text">关闭</span></button>
		</div>
	</div>
</div>


<jsp:include page="htmlfoot.jsp"></jsp:include>
<script type="text/javascript" src="common/js/user.js"></script>
<link href="assets/style.css" rel="stylesheet" />
<style>

</style>
<script type="text/javascript">
function doSetProxy(local1,local2){
	$("#local").val(local);
	$("#local2").val(local2);
	showProxy();
}
function unShowProxy(){
	$("#bg-area").hide();
	$("#dialog-message").hide();
}
function showProxy(){
	$("#bg-area").show();
	$("#dialog-message").show();
	var windowHeight=$(window).height();
	var windowWidth=$(window).width();
	if(windowWidth<640){
		$("#dialog-message").css({"left":"0px"});
	}else{
		$("#dialog-message").css({"left":(windowWidth-640)/2});
	}
	if(windowHeight<500){
		$("#dialog-message").css({"top":"0px"});
	}else{
		$("#dialog-message").css({"top":(windowHeight-500)/2});
	}
	var pagenum=1;
	var url="/api/user/getUserListHTML?random="+Math.round(Math.random()*100);
	$.get(url,function(res){
		if(res){
			if(res.ret==0){
				$("#userHTML").html(res.data["html"]);
				if(res.data["totalpage"]==pagenum){
					$("#showMoreBtn").html("没有更多内容了..");
					$("#showMoreBtn").attr("disabled","disabled"); 
				}
			}
		}
	});
}
function showMore(){
	pagenum++;
	var newurl=url+"&pagesize=20&pagenum="+pagenum;
	$.get(newurl,function(res){
		if(res){
			if(res.ret==0){
				$("#userHTML").html(res.data["html"]);
				if(res.data["totalpage"]==pagenum){
					$("#showMoreBtn").append("没有更多内容了..");
					$("#showMoreBtn").attr("disabled","disabled"); 
				}
			}
		}
	});
}
function setProxy(uid,local,local2,type){
	var proxyURL="/api/user/setProxy?random="+Math.round(Math.random()*100);
	var params={uid:uid,local:local,local2:local2,type:type};
	$.post(proxyURL,params,function(res){
		if(res){
			if(res.ret==0){
				if(res.data==true){
					alert("添加成功");
				}else{
					alert("添加失败");
				}
			}
		}
	});
}

</script>
</body>
</html>