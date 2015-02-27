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
	CashService cashSrv = new CashServiceImpl();
	Page p =  ServletUtil.getPage(request);
	PageReply<Cash2User> cashs = cashSrv.getWithdraw2UserPage(ServletUtil.getSearchMap(request), p);
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
				<li class="active">人民币提现列表</li>
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
									<th class="center">#</th>
									<th class="center">时间</th>
									<th class="center">用户名</th>
									<th class="center">开户名</th>
									<th class="center">银行</th>
									<th class="center">卡号</th>
									<th class="center">行号</th>
									<th class="center">提现金额</th>
									<th class="center">扣除手续费金额</th>
									<th class="center">手机</th>
									<th class="center">状态</th>
									<th class="center">操作</th>
								</tr>
							</thead>
							<tbody>
								<%if(cashs.getPagedatas() == null || cashs.getPagedatas().length == 0) { %>
								<tr>
									<td colspan="100">
										<div class="alert alert-block alert-info">
											<strong class="green">提示：没有数据。</strong>
											
										</div>
									</td>
								</tr>
								<%} %>
								<%
									for (int i = 0; i < cashs.getPagedatas().length; i++) {
										Cash2User c = cashs.getPagedatas()[i];
								%>
								<tr>
									<td><%=i+1 %></td>
									<!--<td><%=c.getId() %> </td>-->
									<td><%=c.getCtimeString() %> </td>
									<td><%=c.getEmail() %> </td>
									<td><%=c.getName() %></td>
									<td><%=c.getBank() %></td>
									<td><%="'" + com.km.common.utils.StringUtil.clearAllWhiteSpace(c.getCard()) %></td>
									<td><%="'" + com.km.common.utils.StringUtil.clearAllWhiteSpace(c.getBank_number()) %></td>
									<td><%=FrontUtil.formatDouble(c.getAmount()) %></td>
									<td>
									<%=FrontUtil.formatDouble(c.getAmount()) %>
									</td>
									<td><%="'"+StringUtils.defaultIfEmpty(c.getMobile(),"") %></td>
									<td><%=FrontUtil.getCashStatusString(c) %></td>
									
									<td>
										<%if(c.getStatus() == 0) { %>
											<a href="javascript:confirmWithdraw(<%=c.getId()%>)">[确认付款]</a>
											<a href="javascript:cancelWithdraw(<%=c.getId()%>)">[拒绝付款]</a>
										<%} %>
										<a href="user.jsp?id=<%=c.getUser_id() %>">[用户详情]</a>											
									</td>
								</tr>
								<%}%>
							</tbody>
						</table>
						<jsp:include page="pagination.jsp">
							<jsp:param value="<%=p.getPagenum() %>" name="pagenum" />
							<jsp:param value="<%=p.getPagesize() %>" name="pagesize" />
							<jsp:param value="<%=cashs.getTotalpage() %>" name="totalPage" />
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