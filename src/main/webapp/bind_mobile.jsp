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
   <div class="alert alert-info" role="alert">
 <span style="font-size:1.4rem">当前手机号</span><span class="label label-danger"   style="font-size:1.6rem"><%=u.getMobile2()!=null&&u.getMobile2()!=""?u.getMobile2():"未绑定手机"%></span><br><br>
 手机号码用于找回密码使用
</div>
  <div class="form-group">
    <label for="bindMobile"><i class="iconfont">&#xe705;</i>&nbsp;&nbsp;绑定新的手机号</label>
    <input type="text" class="form-control" name="bindMobile" id="bindMobile" placeholder="输入绑定的手机号" >
  </div>
  <button class="btn btn-danger btn-block" onclick="formSubmit()">确认修改</button><br>
	</div>
</div>
<jsp:include page="foot.jsp"/>
<jsp:include page="common_source_foot.jsp"/>
<jsp:include page="list_nav.jsp"></jsp:include>
<!-- page special -->
<script type="text/javascript">
document.getElementById("head_title").innerHTML="绑定手机号";
$("#top_qr_button").hide();
$("#top_search_button").hide();
function formSubmit(){
	var bindMobile=$("#bindMobile").val();
	if(!checkMobile(bindMobile)){
		swal("错误", "手机号格式不正确", "error");
		return;
	}
	var url="/api/user/modifyMobile2?random="+Math.round(Math.random()*100);
	var params={bindMobile:bindMobile};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				swal({
                    title: "操作成功",  
                    text: "修改成功",  
                    type: "success",  
                    showCancelButton: false,  
                    confirmButtonColor: "#A7D5EA",  
                    confirmButtonText: "确认" },
                    function(){  
                         window.location.href=window.location.href;
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