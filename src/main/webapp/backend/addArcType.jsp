<%@page import="com.bkl.chwl.MainConfig"%>
<%@ page language="java" contentType="text/html; charset=utf8" pageEncoding="utf8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf8">
<title>add arctype</title>
</head>
<body>
<jsp:include page="commonjs.jsp"></jsp:include>
<input type="text" name="reid" id="reid" value="0"/>
<input type="text" name="sortrank" id="sortrank" value="0"/>
<input type="text" name="defaultname" id="defaultname" value="defaultname"/>
<input type="text" name="issend" id="issend" value="0"/>
<input type="text" name="corank" id="corank" value="0"/>
<input type="text" name="description" id="description" value="description"/>
<input type="text" name="keywords" id="keywords" value="keywords"/>
<input type="text" name="siteurl" id="siteurl" value="siteurl"/>
<input type="text" name="sitepath" id="sitepath" value="sitepath"/>
<input type="text" name="channel" id="channel" value="0"/>
<a href="javascript:addArcType();">add artType</a>
</body>
</html>