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
	
	Map<Long,Area> areaMap=areaServ.areaMap();
	List<Area> provinces=areaServ.getList(0);
	Page p =  ServletUtil.getPage(request);
	PageReply<Proxy2User> proxys = proxyServ.getProxyList(Proxy.PROXYTYPE_AREA, ServletUtil.getSearchMap(request),p);
	
	UserService userServ=new UserServiceImpl();
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
						<input type="text" placeholder="搜索..." class="nav-search-input" autocomplete="off" data-keys="title,id,reid,mobile,name" value="<%=StringUtils.defaultIfEmpty(request.getParameter("searchText"),"")%>">
						<i class="icon-search nav-search-icon"></i>
					</span>
				</form>
			</div>
		</div>
		<div class="page-content">
				<div class="row">
				<div class="col-xs-12">
				<div class="widget-box">
				<div class="widget-header">
					<h4>添加/修改区域代理</h4>
				</div>
				<div class="widget-body">
					<div class="widget-main">
					<!-- select body -->
					<div class="row">
					<div class="col-md-5">
						<select class="width-30" id="province" data-placeholder="Choose a Country..." onchange="changeArea(this,this.value)" onclick="changeArea(this,this.value)">
							<option value="0">选择省份</option>
							<%for(Area province:provinces){ %>
							<option value="<%=province.getId()%>"><%=province.getTitle() %></option>
							<%} %>
						</select>
						<select class="width-30" id="city" data-placeholder="Choose a Country..." onchange="changeArea(this,this.value)" onclick="changeArea(this,this.value)">
						<option value="0">选择城市</option>
						</select>
						<select class="width-30" id="area" data-placeholder="Choose a Country...">
						<option value="0">选择区域</option>
						</select>
					</div>
					<div class="col-md-2">
						<input type="text" id="parent" placeholder="推荐人id" onpaste="value=value.replace(/[^\0-9\.]/g,'')" class="form-control input-mask-product" >
					</div>
					<div class="col-md-3">
					<div class="input-group">
						<input class="form-control input-mask-product" placeholder="代理人id"  class="block" type="text" id="uid" onpaste="value=value.replace(/[^\0-9\.]/g,'')"  >
						<span class="input-group-addon">
							<a href="javascript:void(0);" onClick="doSetProxy()">选择代理人</a>
						</span>
					</div>
					</div>
					<div class="col-md-2">
					<button onclick="setProxySubmit()" class="btn btn-success btn-block btn-sm">确认提交</button>
					</div>
					</div>
					<!-- select body -->
					</div>
				</div>
				<!-- add proxy -->
				<!-- add proxy -->
				</div>
				</div>
				<div class="col-xs-12">
					<div class="table-responsive">
					<input type="hidden" id="local"/>
					<input type="hidden" id="local2"/>
						<table class="table table-striped table-bordered table-hover dataTable">
							<thead>
								<tr>
									<th class="center"><label>#</label></th>
									<th class="center">区域</th>
									<th class="center">推荐人id</th>
									<th class="center">代理商id</th>
									<th class="center">代理商手机</th>
									<th class="center">代理商真实姓名</th>
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
									<td><%=areaMap.get(areaMap.get(proxy.getReid()).getReid()).getTitle()+"-"+areaMap.get(proxy.getReid()).getTitle()+"-"+proxy.getTitle()%></td>
									<td><%=proxy.getParent()%></td>
									<td><%=proxy.getUid()%></td>
									<td><%=StringUtils.defaultIfEmpty(proxy.getMobile(),"未设置")%></td>
									<td><%=StringUtils.defaultIfEmpty(proxy.getName(),"未设置")%></td>
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
<div class="ui-dialog ui-widget ui-widget-content ui-corner-all ui-front ui-dialog-buttons ui-draggable ui-resizable" id="dialog-message" style="position: fixed; height: auto; width: 640px; height:555px;display: none;">
	<div class="ui-dialog-titlebar ui-widget-header ui-corner-all ui-helper-clearfix">
	<span id="ui-id-1" class="ui-dialog-title">选择代理人</span>
<!-- 		<div class="input-group">
		<input type="text" class="form-control" id="searchUser" placeholder="搜索...用户id，用户名，用户姓名，手机号">
		<span class="input-group-addon">
        <button class="btn btn-danger" onclick="setSearchText();">过滤</button>
      	</span>
      	</div> -->
      	<div class="row">
      	<div class="col-xs-12">
      	<div class="input-group">
			<input class="form-control input-mask-product" type="text" id="searchUser" placeholder="输入用户id，用户名，手机号，真实姓名...">
			<span class="input-group-addon">
				<button class="btn btn-danger btn-xs" onclick="setSearchText();">筛选</button>
			</span>
		</div>
		</div>
	    </div><!-- /input-group -->
		<div class="dialog-content">
			<table class="table table-striped table-bordered table-hover dataTable">
				<thead>
					<tr>
						<th class="center">uid</th>
						<th class="center">手机号</th>
						<th class="center">真实姓名</th>
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
var searchText="";
var pagenum=1;
var url="/api/user/getUserListHTML?random="+Math.round(Math.random()*100);
function setSearchText(){
	pagenum=1;
	searchText=$("#searchUser").val();
	showProxy(searchText);
}
function doSetProxy(){
	searchText=$("#searchUser").val();
	showProxy(searchText);
}
function doSetProxy(local1,local2){
	$("#local").val(local1);
	$("#local2").val(local2);
	showProxy();
}
function unShowProxy(){
	$("#bg-area").hide();
	$("#dialog-message").hide();
}

function showProxy(searchText){
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
	var newurl=url;
	if(searchText!=null&&searchText!=""){
		newurl+="&searchKey=id,name,mobile&searchText="+searchText;
	}
	$.get(newurl,function(res){
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
	searchText=$("#searchUser").val();
	pagenum++;
	var newurl=url+"&pagesize=20&pagenum="+pagenum;
	if(searchText!=null&&searchText!=""){
		newurl+="&searchKey=id,name,mobile&searchText="+serachVar;
	}
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
function setProxy(uid){
	$("#uid").val(uid);
	unShowProxy();
}
function setProxySubmit(){
	var uid=$("#uid").val();
	var province=$("#province").val();
	var city=$("#city").val();
	var area=$("#area").val();
	var parent=$("#parent").val();
	if(area==0||province==0||city==0){
		alert("请确认选择城市区域");
		return;
	}
	if(parent==null||parent==""){
		alert("请填写推荐人");
		return;
	}
	if(uid==null||uid==""){
		alert("请填写代理人");
		return;
	}
	var proxyURL="/api/user/setProxy?random="+Math.round(Math.random()*100);
	var params={uid:uid,city:city,area:area,type:1,parent:parent};
	$.post(proxyURL,params,function(res){
		if(res){
			if(res.ret==0){
				if(res.data==true){
					alert("添加成功");
					window.location.href=window.location.href;
				}else{
					alert("添加失败");
				}
			}
		}
	});
}
</script>
<!--[if lte IE 8]>
  <script src="assets/js/excanvas.min.js"></script>
<![endif]-->
<link href="assets/css/chosen.css"	 rel="stylesheet" type="text/css">
<script src="assets/js/jquery-ui-1.10.3.custom.min.js"></script>
<script src="assets/js/jquery.ui.touch-punch.min.js"></script>
<script src="assets/js/chosen.jquery.min.js"></script>
<script src="assets/js/fuelux/fuelux.spinner.min.js"></script>
<script src="assets/js/date-time/bootstrap-datepicker.min.js"></script>
<script src="assets/js/date-time/bootstrap-timepicker.min.js"></script>
<script src="assets/js/date-time/moment.min.js"></script>
<script src="assets/js/date-time/daterangepicker.min.js"></script>
<script src="assets/js/bootstrap-colorpicker.min.js"></script>
<script src="assets/js/jquery.knob.min.js"></script>
<script src="assets/js/jquery.autosize.min.js"></script>
<script src="assets/js/jquery.inputlimiter.1.3.1.min.js"></script>
<script src="assets/js/jquery.maskedinput.min.js"></script>
<script src="assets/js/bootstrap-tag.min.js"></script>
<!-- ace scripts -->
<script src="assets/js/ace-elements.min.js"></script>
<script src="assets/js/ace.min.js"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript">
jQuery(function($) {
	$(".chosen-select").chosen(); 
	$( "#eq > span" ).css({width:'90%', 'float':'left', margin:'15px'}).each(function() {
		// read initial values from markup and remove that
		var value = parseInt( $( this ).text(), 10 );
		$( this ).empty().slider({
			value: value,
			range: "min",
			animate: true
			
		});
	});
});
</script>
</body>
</html>