<%@page import="org.omg.CORBA.MARSHAL"%>
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
	UserService userSrv = new UserServiceImpl();
	Page p =  ServletUtil.getPage(request);
	PageReply<User> users = userSrv.findUser(1,ServletUtil.getSearchMap(request), p);
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
				<li>
					<i class="icon-home home-icon"></i>
					<a href="#">首页</a>
				</li>
				<li class="active"></li>
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
						<table class="table table-striped table-bordered table-hover dataTable">
							<thead>
								<tr>
									<th class="center"><label>#</label></th>
									<th class="center">姓名</th>
									<th class="center">手机</th>
									<th class="center">操作</th>
								</tr>
							</thead>
							<tbody>
								<%if(users.getPagedatas() == null || users.getPagedatas().length == 0) { %>
								<tr>
									<td colspan="100">
										<div class="alert alert-block alert-info">
											<strong class="green">提示：没有数据。</strong>
										</div>
									</td>
								</tr>
								<%} %>
								<%
									for (int i = 0; i < users.getPagedatas().length; i++) {
										User u = users.getPagedatas()[i];
								%>
								<tr>
									<td><%=u.getId()%></td>
									<td>
										<% if (StringUtils.isEmpty(u.getName())) { %> 
											- 
										<% } else { %> 
											<%=u.getName()%>
											<% if (!StringUtils.isEmpty(u.getNick_name())) {%> 
												(<%=u.getNick_name()%>)
											<%}%> 
										<%}%>
									</td>
									<td><%=u.getMobile()%></td>
									<td>
										<a href="user.jsp?id=<%=u.getId()%>">[详情]</a>
										<%if(u.getFrozen() == 1) { %>	
											<a href="javascript:enableUser(<%=u.getId()%>, 0)">[启用]</a>
										<%} else { %>
											<a href="javascript:enableUser(<%=u.getId()%>, 1)">[禁用]</a>
										<%}%>
									</td>
								</tr>
								<%}%>
							</tbody>
						</table>
						<jsp:include page="pagination.jsp">
							<jsp:param value="<%=p.getPagenum() %>" name="pagenum" />
							<jsp:param value="<%=p.getPagesize() %>" name="pagesize" />
							<jsp:param value="<%=users.getTotalpage() %>" name="totalPage" />
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
<jsp:include page="htmlfoot.jsp"></jsp:include>
<script type="text/javascript" src="common/js/user.js"></script>
</body>
</html>