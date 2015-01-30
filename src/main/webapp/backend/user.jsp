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
	long id = Long.parseLong(StringUtils.defaultIfEmpty(request.getParameter("id"), "0"));
	UserService userSrv = new UserServiceImpl();
	User user = userSrv.get(id);
	String ossBaseurl=MainConfig.getOssBaseurl();	
	String statusString = request.getParameter("recordType");
	int status = 0;
	if (statusString != null) {
		status = Integer.parseInt(statusString);
	}
	boolean isShop=false;
	boolean createShop=false;
	
	
	int local1=0;
	int local2=0;
	int local3=0;
	int type1=0;
	int type2=0;
	
	if(user.getRole()==user.ROLE_SHOPER) isShop=true;
	
	Shop shop=new Shop();
	Map<Long,Area> areaMap=new HashMap<Long,Area>();
	Map<Long,Type> typeMap=new HashMap<Long,Type>();
	
	if(isShop){
		ShopService shopServ=new ShopServiceImpl();
		shop=shopServ.getByUid(user.getId());
		if(shop!=null){
			createShop=true;
			local1=shop.getLocal()!=0?shop.getLocal():0;
			local2=shop.getLocal2()!=0?shop.getLocal():0;
			local3=shop.getLocal3()!=0?shop.getLocal():0;
			type1=shop.getShop_type()!=0?shop.getShop_type():0;
			type2=shop.getShop_type2()!=0?shop.getShop_type2():0;
		}
		TypeService typeServ=new TypeServiceImpl();
		AreaService areaServ=new AreaServiceImpl();
		areaMap=areaServ.areaMap();
		typeMap=typeServ.typeMap();
	}
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
								<a href="index.jsp">Home</a>
							</li>
							<li>
								<a href="users.jsp">用户列表</a>
							</li>
							<li class="active">用户详情</li>
						</ul><!-- .breadcrumb -->
					</div>
					<div class="page-content">
						<div class="widget-box transparent">
							<div class="widget-header widget-header-small">
								<h4 class="blue smaller">
									<i class="icon-rss orange"></i>
									基本信息
								</h4>
							</div>
						</div>
			
						<div class="profile-user-info profile-user-info-striped">
							<div class="profile-info-row">
								<div class="profile-info-name">手机 </div>
								<div class="profile-info-value">
									<span><%=StringUtils.defaultIfEmpty(user.getMobile(),"-") %></span>
								</div>
							</div>
							<div class="profile-info-row">
								<div class="profile-info-name">注册时间 </div>
								<div class="profile-info-value">
									<span><%=user.getCtimeString() %></span>
								</div>
							</div>
							<div class="profile-info-row">
								<div class="profile-info-name">人民提现信息 </div>
								<div class="profile-info-value">
									<label class="label label-info"><%=StringUtils.defaultIfEmpty(user.getBank(),"-") %></label>
									<span><%=StringUtils.defaultIfEmpty(user.getBank_account(),"-") %></span>
								</div>
							</div>
						</div>
						
						<div class="widget-box transparent">
							<div class="widget-header widget-header-small">
								<h4 class="blue smaller">
									<i class="icon-rss orange"></i>
									帐户资产信息
								</h4>
							</div>
						</div>
						<div class="profile-user-info profile-user-info-striped">
							<div class="profile-info-row">
								<div class="profile-info-name">金币</div>
								<div class="profile-info-value">
									<input name="rmb" id="rmb" value="<%=ApiCommon.getUserCoin(id)%>" readonly="readonly">
								</div>
							</div>	
						</div>
						
						<!-- 实名认证信息  -->
						<div class="widget-box transparent">
							<div class="widget-header widget-header-small">
								<h4 class="blue smaller">
									<i class="icon-rss orange"></i>
									实名认证信息
								</h4>
							</div>
						</div>
						<div class="profile-user-info profile-user-info-striped">
							<div class="profile-info-row">
								<div class="profile-info-name">姓名 </div>
								<div class="profile-info-value">
									<span><%=StringUtils.defaultIfEmpty(user.getName(),"-") %></span>
								</div>
							</div>
						</div>
						
						<p/>
						<%if(isShop){ %>
						<div class="widget-box transparent">
							<div class="widget-header widget-header-small">
								<h4 class="blue smaller">
									<i class="icon-rss orange"></i>
									店铺相关信息
								</h4>
							</div>
						</div>
						<div class="profile-user-info profile-user-info-striped">
							<div class="profile-info-row">
								<div class="profile-info-name">营业执照 </div>
								<div class="profile-info-value">
									<span>
									<a  id="single_image" class="grouped_elements"  href="../<%=StringUtils.defaultIfEmpty(user.getLicenceFileURL(),"-")%>">
										<img src="../<%=StringUtils.defaultIfEmpty(user.getLicenceFileURL(),"-")%>" width=220px>
									</a>
									</span>
								</div>
							</div>
						</div>
						<div class="profile-user-info profile-user-info-striped">
							<div class="profile-info-row">
								<div class="profile-info-name">营业执照编号 </div>
								<div class="profile-info-value">
									<span>
										<%=ossBaseurl+StringUtils.defaultIfEmpty(user.getLicenceNumber(),"-")%>
									</span>
								</div>
							</div>
						</div>
						<%if(createShop){ %>
						<div class="profile-user-info profile-user-info-striped">
							<div class="profile-info-row">
								<div class="profile-info-name">店铺名 </div>
								<div class="profile-info-value">
									<span><%=StringUtils.defaultIfEmpty(shop.getTitle(),"-") %></span>
								</div>
							</div>
						</div>
						<%if(shop.getShop_type()!=0){ 
							
						
						%>
						<div class="profile-user-info profile-user-info-striped">
							<div class="profile-info-row">
								<div class="profile-info-name">类别 </div>
								<div class="profile-info-value">
									<span>
									<span><%=typeMap.get(type1)!=null?typeMap.get(type1).getName():"-"%></span>&nbsp;&nbsp;<span><%=typeMap.get(type2)!=null?typeMap.get(type2).getName():"-"%></span>
									</span>
								</div>
							</div>
						</div>
						<%} %>
						<div class="profile-user-info profile-user-info-striped">
							<div class="profile-info-row">
								<div class="profile-info-name">地区 </div>
								<div class="profile-info-value">
									<span>
									<span><%=areaMap.get(Long.valueOf(local1))!=null?areaMap.get(Long.valueOf(local1)).getTitle():"-"%></span>&nbsp;&nbsp;<span><%=areaMap.get(Long.valueOf(local2))!=null?areaMap.get(Long.valueOf(local2)).getTitle():"-" %></span>&nbsp;&nbsp;
									<span><%=areaMap.get(Long.valueOf(local3))!=null?areaMap.get(Long.valueOf(local3)).getTitle():"-"%></span>
									</span>
								</div>
							</div>
						</div>
						<%
						if(shop.getImage()!=null&&!shop.getImage().equals("")){
						String image[]=shop.getImage().split("@"); %>
						<div class="profile-user-info profile-user-info-striped">
							<div class="profile-info-row">
								<div class="profile-info-name">店铺概览 </div>
								<div class="profile-info-value">
									<span>
									<a  id="single_image" class="grouped_elements"  href="../<%=image[0]%>">
										<img src="../<%=ossBaseurl+image[0]%>" width=220px>
									</a>
									</span>
								</div>
							</div>
						</div>
						<%}} %>
						<%} %>
						<p />
						<div class="col-xs-12">
							<div class="btn-toolbar">
								<%if(user.getFrozen() == 0) { %>	
									<button class="btn btn-warning" onclick="enableUser(<%=user.getId()%>, 1)">禁用</button>
								<%} else { %>
									<button class="btn btn-success" onclick="enableUser(<%=user.getId()%>, 0)">启用</button>
								<%} %>
								<%if(user.getVertify()==user.VERTIFY_FALSE){ %>
									<button class="btn btn-success" onclick="vertifyUser(<%=user.getId()%>)">通过审核</button>
							    <%}else{ %>
							    	<button class="btn btn-success" onclick="unVertifyUser(<%=user.getId()%>)">取消店铺资格</button>
							    <%} %>
							</div>
							<p />
				</div>
				</div>
			</div>
</div>
<!-- content -->
<jsp:include page="htmlfoot.jsp"></jsp:include>
<script type="text/javascript" src="common/js/user.js"></script>
<!-- page special -->
<!-- page special -->
</body>
</html>