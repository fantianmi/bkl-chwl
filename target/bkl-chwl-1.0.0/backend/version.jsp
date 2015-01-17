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
	VersionService versionServ = new VersionServiceImpl();
 	Page p=ServletUtil.getPage(request);
	PageReply<Version> versions = versionServ.getVersionList(p, null);
	Version v = new Version();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:include page="htmlhead.jsp"></jsp:include>
</head>
<body>
<jsp:include page="topbar.jsp"></jsp:include>
<div class="main-container-inner">
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
				<li><i class="icon-home home-icon"></i> <a href="index.jsp">Home</a>
				</li>
				<li class="active">版本管理</li>
			</ul>
			<!-- .breadcrumb -->
			<div class="nav-search" id="nav-search">
				<form class="form-search">
					<span class="input-icon">
						<input type="text" placeholder="搜索..." class="nav-search-input" autocomplete="off" data-keys="email,name" value="<%=StringUtils.defaultIfEmpty(request.getParameter("searchText"),"")%>">
						<i class="icon-search nav-search-icon"></i>
					</span>
				</form>
			</div>
		</div>
		<!-- page content -->
		<div class="page-content">
			<div class="row">
				<div class="col-xs-12">
					<br>
					<div class="table-responsive">
						<table class="table table-striped table-bordered table-hover dataTable">
							<thead>
								<tr>
									<th class="center"><label>#</label></th>
									<th class="center">版本号</th>
									<th class="center">名称</th>
									<th class="center">下载地址</th>
									<th class="center">安卓/ios</th>
									<th class="center">操作</th>
								</tr>
							</thead>
							<tbody id="versionTable">
								<%if(versions.getPagedatas().length==0||versions.getPagedatas()==null) { %>
								<tr>
									<td colspan="100">
										<div class="alert alert-block alert-info">
											<strong class="green">提示：没有数据。</strong>
											
										</div>
									</td>
								</tr>
								<%} %>
								<tr>
									<td><i class="icon-bookmark red"></i></td>
									<td><input type="text" id="version" class="col-xs-12 col-sm-12" placeholder="版本号：例如 1.0.0"/></td>
									<td><input type="text" id="name" class="col-xs-12 col-sm-12" placeholder="软件名称 例如 exmine_v1.0.0.apk"/></td>
									<td><input type="text" id="downloadurl" class="col-xs-12 col-sm-12" placeholder="安卓需填入软件下载地址，ios填写appstore链接"'/></td>
									<td><select id="apktype"><option value="0">android</option><option value="1">ios</option></select></td>
									<td><a href="javascript:addVersion();" class="btn btn-sm btn-danger">添加版本</a> </td>
								</tr>
								<%
									for (int i = 0; i < versions.getPagedatas().length; i++) {
										v = versions.getPagedatas()[i];
								%>
								<tr id="tableTr<%=v.getId()%>">
									<td><%=i+1 %></td>
									<td><input type="text" id="version<%=v.getId()%>" value="<%=v.getVersion() %>"  class="col-xs-12 col-sm-12" placeholder="版本号：例如 1.0.0"/></td>
									<td><input type="text" id="name<%=v.getId()%>"  value="<%=v.getName() %>"  class="col-xs-12 col-sm-12" placeholder="软件名称 例如 exmine_v1.0.0.apk"/></td>
									<td><input type="text" id="downloadurl<%=v.getId()%>" value="<%=v.getDownloadurl()%>"  class="col-xs-12 col-sm-12" placeholder="安卓需填入软件下载地址，ios填写appstore链接"'/></td>
									<td><select id="apktype<%=v.getId()%>"><option value="<%=v.getApktype()%>"><%=v.getApktypeString() %></option><option value="0">android</option><option value="1">ios</option></select></td>
									<td><a href="javascript:modifyVersion(<%=v.getId()%>);" class="btn btn-sm btn-primary">修改</a> <a href="javascript:deleteVersion(<%=v.getId()%>);" class="btn btn-sm btn-danger">删除</a></td>
								</tr>
								<%}%>
							</tbody>
						</table>
					</div>
					<!-- /.table-responsive -->
				</div>
				<!-- /span -->
			</div>
		</div>
		<!-- page content end -->
	</div>
</div>
<!-- content -->
<jsp:include page="htmlfoot.jsp"></jsp:include>
</body>
</html>