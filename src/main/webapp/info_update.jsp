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
User u=UserUtil.getCurrentUser(request);
String type=request.getParameter("t");
if(type==null||!type.equals("nickname")){
	response.sendRedirect("user_detail.jsp");
	return;
}
String inputName="";
String inputValue="";
String inputType="";
String action="";
if(type.equals("nickname")){
	inputName="nick_name";
	inputValue=u.getNick_name()==""||u.getNick_name()==null?"":u.getNick_name();
	inputType="昵称修改";
	action="/api/user/modifyNickname";
}
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
    <input type="hidden"name="uid"  id="uid" value="<%=u.getId()%>">
  <div class="form-group">
    <label for="exampleInputPassword1"><i class="iconfont">&#xe64c;</i>&nbsp;&nbsp;<%=inputType%></label>
    <input type="text" class="form-control" name="<%=inputName%>" id="inputvalue" placeholder="<%=inputType%>" value="<%=inputValue%>">
  </div>
  <button class="btn btn-danger btn-block" onclick="formSubmit()">确认修改</button><br>
	</div>
</div>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="<%=inputType%>";
function formSubmit(){
	var inputvalue=$("#inputvalue").val();
	if(inputvalue==null||inputvalue==""){
		swal("错误", "请确认表单是否填写完全", "error");
		return;
	}
	var uid=$("#uid").val();
	var url="<%=action%>";
	var params={uid:uid,<%=inputName%>:inputvalue};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				swal({
                    title: "操作成功",  
                    text: "<%=inputType%>成功",  
                    type: "success",  
                    showCancelButton: false,  
                    confirmButtonColor: "#A7D5EA",  
                    confirmButtonText: "确认" },
                    function(){  
                         window.location.href="user_detail.jsp";
                    });
			}else{
				swal("错误", "请重新提交", "error");
				return;
			}
		}else{
			swal("错误", "远程连接失败", "error");
			return;
		}
	});
}

</script>
</body>
</html>