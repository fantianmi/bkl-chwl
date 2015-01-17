<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="navbar navbar-default" id="navbar">
	<script type="text/javascript">
		try{ace.settings.check('navbar' , 'fixed')}catch(e){}
	</script>
	<div class="navbar-container" id="navbar-container">
		<div class="navbar-header pull-left">
			<a href="#" class="navbar-brand">
				<small>
					<i class="icon-leaf"></i>
					大小王科技
				</small>
			</a><!-- /.brand -->
		</div><!-- /.navbar-header -->

		<div class="navbar-header pull-right" role="navigation">
			<ul class="nav ace-nav">
				<li class="light-blue"><a data-toggle="dropdown" href="#"
					class="dropdown-toggle"> <span
						class="user-info"> <small>欢迎光临,</small> 管理员
					</span> <i class="icon-caret-down"></i>
				</a>
					<ul
						class="user-menu pull-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
						<li class="divider"></li>
						<li><a href="#" onclick="logout()"> <i class="icon-off"></i> 退出
						</a></li>
					</ul></li>
			</ul><!-- /.ace-nav -->
		</div><!-- /.navbar-header -->
	</div><!-- /.container -->
</div>