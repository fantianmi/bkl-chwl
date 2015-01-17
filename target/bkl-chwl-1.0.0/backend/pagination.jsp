<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% 
    	int pagenum = Integer.parseInt(StringUtils.defaultIfEmpty(request.getParameter("pagenum"),"1"));
    	int pagesize = Integer.parseInt(StringUtils.defaultIfEmpty(request.getParameter("pagesize"),"20"));
    	int totalPage = Integer.parseInt(StringUtils.defaultIfEmpty(request.getParameter("totalPage"),"1"));
    %>
<div class="dataTables_paginate paging_bootstrap" style="margin-top:10px;">
	<ul class="pagination">
		<%if(pagenum > 1)  {%>
			<li><a href="#" onclick="__setPage(1);">首页</a></li>
			<li><a href="#" onclick="__setPage(<%=pagenum - 1 %>);">上页</a></li>
		<%} %>
		
		<!-- 前三页 -->
		<%
				for(int i=pagenum - 3;i<pagenum;i++){
		%>
		<%if(i >= 1) { %>
		<li><a href="#" onclick="__setPage(<%=i%>);"><%=i %></a></li>
		<%} %>
		<%} %>
		
		<!-- 当前页 -->
		<%if(totalPage > 1) { %>
			<li class="active"><a href=""><%=pagenum %></a></li>
		<%} %>
		
		<!-- 后三页 -->
		<%
				for(int i = pagenum + 1;i<pagenum + 3;i++){
			%>
		<%if(i <= totalPage) { %>
		<li><a href="#" onclick="__setPage(<%=i%>);"><%=i %></a></li>
		<%} %>
		<%} %>

		<%if(pagenum < totalPage)  {%>
			<li><a href="#" onclick="__setPage(<%=pagenum + 1%>);">下页</a></li>
			<li><a href="#" onclick="__setPage(<%=totalPage%>);">末页</a></li>
		<%} %>
	</ul>
</div>

<script type="text/javascript">
function __setPage(page) {
	window.location.href = __updateSearch("pagenum", page);
}
</script>