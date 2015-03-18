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
	ErrorOrderService errorOrderServ = new ErrorOrderServiceImpl();
	Page p =  ServletUtil.getPage(request);
	PageReply<ErrorOrder> orders = errorOrderServ.getErrorOrderPage(ServletUtil.getSearchMap(request), p);
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
				<li class="active">错误订单列表</li>
			</ul><!-- .breadcrumb -->
			<div class="nav-search" id="nav-search">
				<form class="form-search">
					<span class="input-icon">
						<input type="text" placeholder="搜索...orderid,uid,银行卡号,提现账户..." class="nav-search-input" autocomplete="off" data-keys="id,orderid,uid,bankaccount,name" value="<%=StringUtils.defaultIfEmpty(request.getParameter("searchText"),"")%>">
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
									<th class="center">id</th>
									<th class="center">orderid</th>
									<th class="center">uid</th>
									<th class="center">订单类别</th>
									<th class="center">名称</th>
									<th class="center">卡号</th>
									<th class="center">银行</th>
									<th class="center">行号</th>
									<th class="center">手机</th>
									<th class="center">金额</th>
									<th class="center">订单时间</th>
									<th class="center">状态</th>
									<th class="center">操作</th>
								</tr>
							</thead>
							<tbody>
								<%if(orders.getPagedatas() == null || orders.getPagedatas().length == 0) { %>
								<tr>
									<td colspan="100">
										<div class="alert alert-block alert-info">
											<strong class="green">提示：没有数据。</strong>
											
										</div>
									</td>
								</tr>
								<%} %>
								<%
									for (int i = 0; i < orders.getPagedatas().length; i++) {
										ErrorOrder errorOrder = orders.getPagedatas()[i];
								%>
								<tr>
									<td><%=errorOrder.getId()%></td>
									<!--<td><%=errorOrder.getOrderid()%> </td>-->
									<td><%=errorOrder.getUid()%> </td>
									<td><%=errorOrder.getOrdertypeString() %></td>
									<td><%=errorOrder.getName()%> </td>
									<td><%=errorOrder.getBankaccount()%></td>
									<td><%=errorOrder.getBankdeposit()%></td>
									<td><%=errorOrder.getBanknumber()%></td>
									<td><%=errorOrder.getPhone() %></td>
									<td>
									<%=FrontUtil.formatDouble(errorOrder.getCoin() ) %>
									</td>
									<td><%=errorOrder.getCtimeString()%></td>
									<td><%=errorOrder.getStatusString()%></td>
									<td>
										<%if(errorOrder.getStatus() == 0) { %>
											<a href="javascript:confirmErrorOrder(<%=errorOrder.getId()%>)">[处理]</a>
										<%} %>
										[已处理]									
									</td>
								</tr>
								<%}%>
							</tbody>
						</table>
						<jsp:include page="pagination.jsp">
							<jsp:param value="<%=p.getPagenum() %>" name="pagenum" />
							<jsp:param value="<%=p.getPagesize() %>" name="pagesize" />
							<jsp:param value="<%=orders.getTotalpage() %>" name="totalPage" />
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