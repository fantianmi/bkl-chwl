<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
		</div>
		<div class="page-content">
			<div class="page-header">
				<h1>控制台<small><i class="icon-double-angle-right"></i>查看</small></h1>
			</div>
			<!-- /.page-header -->
			<div class="row">
				<div class="col-xs-12">
				</div>
		    </div>
		</div>
	</div>
</div>
<!-- content -->
<jsp:include page="htmlfoot.jsp"></jsp:include>
</body>
</html>