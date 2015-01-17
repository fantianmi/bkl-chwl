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
	AreaService areaServ = new AreaServiceImpl();
 	long reid=0;
 	if(request.getParameter("reid")!=null){
 		reid=Integer.parseInt(request.getParameter("reid"));
 	}
	List<Area> areas = areaServ.getList(reid);
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
				try {
					ace.settings.check('breadcrumbs', 'fixed')
				} catch (e) {
				}
			</script>

			<ul class="breadcrumb">
				<li><i class="icon-home home-icon"></i> <a href="index.jsp">Home</a>
				</li>
				<li class="active">地区管理</li>
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
		<div class="page-content">
			<div class="row">
				<div class="col-sm-6">
					<div class="widget-box">
						<div class="widget-header header-color-blue2">
								<a href="javascript:showOperationPanel(0);" id="id-btn-dialog2" class="btn btn-info"><i class="icon-plus"></i>增加省份</a>
						</div>
						<div class="widget-body">
							
							<div class="widget-main padding-8">
							<%if(areas.size()==0) { %>
							<div class="alert alert-block alert-info">
								<strong class="green">提示：没有数据。</strong>
							</div>
							<%} %>
								<div id="folderContent0" class="tree">
								<!-- tree content -->
								<%
									for (int i = 0; i < areas.size(); i++) {
										Area a = areas.get(i);
								%>
								<div class="tree-folder" style="display: block;" id="folder<%=a.getId()%>">
									<div class="tree-folder-header">
									<i class="icon-plus" onclick="loadChildData(<%=a.getId()%>)" id="iconCheck<%=a.getId()%>"></i><div class="tree-folder-name"><%=a.getTitle()%></div>&nbsp;&nbsp;[<a href="javascript:showOperationPanel(<%=a.getId()%>);">增加地级市</a>]&nbsp;&nbsp;[<a href="javascript:deleteArea(this,<%=a.getId()%>);">删除</a>]
									</div>			
								</div>
								<%}%>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- colspan -->
				<div class="col-sm-6 hidePanel"  id="operationPanel">
					<div class="widget-box">
						<div class="widget-header header-color-green2">
								<h5 id="operationPanelName"></h5>
						</div>
						<div class="widget-body">
							<div class="widget-main padding-8">
								<div class="form-horizontal">
										<div class="form-group">
											<label class="col-sm-3 control-label no-padding-right" for="form-field-1">父栏目id</label>
											<div class="col-sm-9">
												<input type="text" id="reid" name="reid" placeholder="reid" class="col-xs-10 col-sm-5" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label no-padding-right" for="form-field-1">名称</label>
											<div class="col-sm-9">
												<input type="text" id="title" placeholder="名称" class="col-xs-10 col-sm-5" />
											</div>
										</div>
										<div class="form-group">
											<label class="col-sm-3 control-label no-padding-right" for="form-field-1"></label>
											<div class="col-sm-9">
												<button class="btn btn-success" onclick="addArea()" id="submitButton">提交</button>
											</div>
										</div>
									</div>
								</div>
								<!-- form content -->
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div><!-- content end -->
</div>
<!-- content -->
<jsp:include page="htmlfoot.jsp"></jsp:include>
<script type="text/javascript" src="common/js/treeView.js"></script>
</body>
</html>