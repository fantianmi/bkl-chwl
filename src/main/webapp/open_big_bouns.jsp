<%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%
if(request.getParameter("id")==null||request.getParameter("type")==null){
	response.sendRedirect("user_bouns_list.jsp");
	return;
}
int bouns_id=Integer.parseInt(request.getParameter("id"));
int type=Integer.parseInt(request.getParameter("type"));
%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<jsp:include page="common_source_head.jsp"/>
</head>
<body class="drawer drawer-right">
<jsp:include page="top.jsp"/>
<div class="content nopadding" style="margin-top:5.5rem " id="content1">
	<div class="container nomargin" style="padding: .5rem !important;">
    <input type="hidden"name="bouns_id"  id="bouns_id" value="<%=bouns_id%>">
    <input type="hidden"name="bouns_type"  id="bouns_type" value="<%=type%>">
  <div class="form-group">
    <label for="bindMobile"><i class="iconfont">&#xe607;</i>&nbsp;&nbsp;登录密码</label>
    <input type="password" class="form-control" name="password" id="password" placeholder="输入登录密码" >
  </div>
  <button class="btn btn-danger btn-block" onclick="open_bouns()">确认打开</button><br>
	</div>
</div>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="幸福钱袋";
$("#top_qr_button").hide();
$("#top_search_button").hide();

function open_bouns(){
	var password=$("#password").val();
	if(password.length<6){
		swal("错误", "请输入正确的密码", "error");
		return;
	}
	var id=$("#bouns_id").val();
	var type=$("#bouns_type").val();
	
	var openbunsURL="/bouns/openBigBouns?random="+Math.round(Math.random()*100);
	var params={id:id,type:type,password:password};
	$.post(openbunsURL,params,function(res){
		if(res){
			if(res.ret==0){
				swal({
                  title: "操作成功",  
                  text: res.data,  
                  type: "success",  
                  showCancelButton: false,  
                  confirmButtonColor: "#A7D5EA",  
                  confirmButtonText: "确认" },
                  function(){  
                	  window.location.href='user_bouns_list.jsp';
                  });
			}else{
				swal("错误", "请输入正确的密码", "error");
			}
		}
	});
}

</script>
</body>
</html>