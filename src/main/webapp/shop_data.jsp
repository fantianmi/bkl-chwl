 <%@page import="com.bkl.chwl.constants.Constants"%>
 <%@page import="org.apache.commons.lang.StringUtils"%>
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
if(user.getLocal()==0||user.getLocal2()==0||user.getLicenceNumber()==null||user.getLicenceNumber()==""){
	response.sendRedirect("shop_data_add.jsp");
	return;
}
Shop shop=shopServ.getByUid(user.getId());
AreaService areaServ = new AreaServiceImpl();
Map<Long,Area> areamap=areaServ.areaMap();
Area local=areamap.get(Long.valueOf(user.getLocal()));
Area local2=areamap.get(Long.valueOf(user.getLocal2()));
Area local3=areamap.get(Long.valueOf(user.getLocal3()));
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
<div class="tableList downborder" >
<div class="detail" style="width:100%">编号ID：<span><%=user.getId() %></span></div>
</div>
<div class="tableList downborder" >
<div class="detail" style="width:100%">用户名：<span><%=user.getMobile() %></span></div>
</div>
<div class="tableList downborder" >
<div class="detail" style="width:100%">真实姓名：<span><%=StringUtils.defaultIfEmpty(user.getName() , "-")%></span></div>
</div>
<div class="space"></div>
<div class="tableList downborder" >
<div class="detail" style="width:100%">点商名称：<span><%=shop.getTitle() %></span></div>
</div>
<div class="tableList downborder" >
<div class="detail" style="width:100%">执照编号：<span><%=user.getLicenceNumber() %></span></div>
</div>
<div class="tableList downborder" >
<div class="detail" style="width:100%">企业法人：<span><%=StringUtils.defaultIfEmpty(user.getManager(), "-")%></span></div>
</div>
<div class="tableList downborder" >
<div class="detail" style="width:100%">营业执照注册名：<span><%=user.getLicenceRegName()%></span></div>
</div>
<div class="tableList downborder" >
<div class="detail" style="width:100%">营业执照注册号：<span><%=user.getLicenceNumber()%></span></div>
</div>
<div class="space"></div>
<div class="tableList downborder">
<div class="detail" style="width:100%">地址：<span><%=local!=null?local.getTitle():"未知"%>-<%=local2!=null?local2.getTitle():"未知"%>-<%=local3!=null?local3.getTitle():"未知"%></span></div>
</div>
</div>
 <jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="审核资料";
$("#top_back_button").html("<a class=\"react\" href=\"shop_index.jsp\" style=\"font-size: 1.6rem;color:#fff;padding-right: 1rem !important;\"><i class=\"iconfont\">&#xf0015;</i>&nbsp;&nbsp;</a>");
$("#top_qr_button").hide();
$("#top_search_button").hide();
</script>
</body>
</html>