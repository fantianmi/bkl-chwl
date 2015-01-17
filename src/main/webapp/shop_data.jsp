 <%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
ShopService shopServ=new ShopServiceImpl();
User user = UserUtil.getCurrentUser(request);
if(user.getLicenceFileURL()==null||user.getLicenceFileURL()==""||user.getLocal()==0||user.getLocal2()==0||user.getLicenceNumber()==null||user.getLicenceNumber()==""){
	response.sendRedirect("shop_data_add.jsp");
	return;
}
AreaService areaServ = new AreaServiceImpl();
Map<Long,Area> areamap=areaServ.areaMap();
Area local=areamap.get(Long.valueOf(user.getLocal()));
Area local2=areamap.get(Long.valueOf(user.getLocal2()));
%>
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
</div>
<div class="container nomargin" style="margin: 0rem !important;">
<div class="tableList downborder">
<div class="detail">客服电话：<span>400-1568-848</span></div>
</div>
<div class="tableList downborder" >
<div class="detail" ><%=user.getLicenceNumber() %></div><div class="status">执照编号</div>
</div>
<div class="tableList downborder" style="height:10em;">
<div class="detail" style="width:12em;height:10rem;overflow: hidden;"><img src="<%=user.getLicenceFileURL()%>" style="width:100%;box-shadow: 0 1px 10px rgba(0,0,0,.5);-moz-user-select: none;"></div><div class="status">营业执照</div>
</div>
<div class="tableList downborder">
<div class="detail"><%=local!=null?local.getTitle():"未知"%>-<%=local2!=null?local2.getTitle():"未知"%></div><div class="status">地址</div>
</div>
<a href="shop_data_add.jsp" class="btn btn-danger btn-block">修改审核资料</a>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="审核资料管理";
$("#top_back_button").html("<a class=\"react\" href=\"shop_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>返回</a>");
$("#top_qr_button").hide();
$("#top_search_button").hide();
</script>
</body>
</html>