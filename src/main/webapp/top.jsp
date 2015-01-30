<%@page import="com.bkl.chwl.utils.StringUtil"%>
<%@page import="com.bkl.chwl.constants.Constants"%>
<%@page import="com.km.common.utils.*"%>
<%@page import="com.bkl.chwl.service.*"%>
<%@page import="com.bkl.chwl.service.impl.*"%>
<%@page import="com.bkl.chwl.utils.*"%>
<%@page import="com.bkl.chwl.entity.*"%>
<%@page import="com.bkl.chwl.*"%>   
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
#searchbar{color:#3B4043; font-size: 20px}
.logo-home{margin: 0 10px 0 0}
.topfont{color:#3B4043; font-size: 14px;}
.circle{border-radius:50px;padding: 3px 10px}
</style>
<!-- Fixed navbar -->
<nav class="navbar navbar-default navbar-fixed-top" role="navigation">
  <div class="container" style="margin-bottom: 0px;">
    <div class="navbar-header" style="margin:0;width:100% !important;">
    	<div class="nav-wrap-left" style="float:left !important;;text-align: left !important;" id="top_back_button">
            <a class="react" href="javascript:history.back()" style="font-size: 1.6rem;color:#fff;padding-right: 1rem !important;"><i class="iconfont">&#xf0015;</i>&nbsp;&nbsp;</a>
        </div>
    	<div class="head_title" id="head_title" style="margin-left:.5rem"></div>
    	<div class="head_button" style="border-right:1px solid #ED6A00 " id="top_qr_button"><a href="javascript:void(0);" onclick="scanQR()" class="logo-home btn btn-default noradius" style="border-top-left-radius: 4px !important;;border-bottom-left-radius: 4px !important;;margin-right:0px;"><i class="iconfont" id="searchbar">&#xe6fb;</i></a></div>
    	<div class="head_button" id="top_search_button"><a class="logo-home btn btn-default noradius" href="javascript:searchBarShow();" style="border-top-right-radius: 4px !important;;border-bottom-right-radius: 4px !important;;margin-right:0px;"><i class="iconfont" id="searchbar">&#x3440;</i></a></div>
    	<div class="nav-wrap-left" id="top_logout_button" style="float:right !important;;text-align: right !important;">
            <a class="react"  href="javascript:void(0);" onclick="loginout()" style="font-size: 1.6rem;color:#fff;padding-right: 1rem !important;">退出</a>
        </div>
    </div>
  </div>
</nav>
    
