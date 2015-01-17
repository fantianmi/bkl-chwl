<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div class="J_search_container search_container" style="top: 0; height: 2855px;z-index:9999">
    <form class="J_form" method="get" action="/shoplist/9/search" onsubmit="var keyword=document.getElementsByClassName('J_search_input')[0].value; _hip.push(['mv', {module:'2_search_item',action:'click',keyword:keyword}]);">
            <div class="head_cnt">
                <div class="head_cnt_input">
                    <input type="text" name="keyword" class="search J_search_input" placeholder="搜店铺、找优惠" autocomplete="off">
                    <input type="submit">
                </div>
                <a class="cancel J_cancel" onclick="_hip.push(['mv', {module:'index_keyword_cancel',action:'click'}]);" href="javascript:;">取消</a>
            </div>
        <div class="J_key_list key_list Fix" style="display: none;">
            
        </div>
        <div class="J_history_list key_list Fix"></div>
        <a class="J_history_clear link-btn" href="javascript:;">清除历史记录</a>
        <ul class="J_suggest_list suggest_list">
        </ul>
    </form>
</div>

<style>
.search_container {
position: absolute;
top: 0;
width: 100%;
height: 100%;
background-color: #fff;
z-index: 999;
}
* {
margin: 0;
padding: 0;
outline: 0;
}
.search_container .head_cnt {
padding: 0 75px 0 15px;
}
.search_container .head_cnt {
padding: 0 65px 0 5px;
text-align: left;
height: 45px;
line-height: 45px;
background-color: #F0F0F0;
text-align: center;
color: #F63;
position: relative;
z-index: 300;
display: box;
display: -webkit-box;
display: -ms-flexbox;
-webkit-box-align: center;
-ms-box-align: center;
box-align: center;
}
.search_container .head_cnt .head_cnt_input {
position: relative;
}
.search_container .head_cnt .head_cnt_input {
-webkit-box-flex: 1;
box-flex: 1;
-ms-box-flex: 1;
-ms-flex: 1;
position: relative;
}
/*input*/
.search_container input[type=text] {
border: none;
border-radius: 15px;
-webkit-border-radius: 15px;
font-size: 14px;
line-height:normal !important;
}
.search_container input[type=text] {
width: 100%;
height: 30px;
padding-left: 10px;
border: none;
border-radius: 15px;
-webkit-border-radius: 15px;
display: box;
display: -webkit-box;
display: -ms-flexbox;
-webkit-box-align: center;
-ms-box-align: center;
box-align: center;
}
.search_container input[type=submit] {
height: 28px;
width: 28px;
background: url(//i1.dpfile.com/mod/mobile-common-search/0.3.0/css/img/search.png) no-repeat 5px center;
background-size: 14px auto;
border: none;
text-indent: -999em;
position: absolute;
right: 0;
top: 50%;
margin-top: -15px;
}
.search_container .cancel {
color: #3B4043;
position: absolute;
right: 20px;
top: 0;
font-size: 14px;
}
.search_container .cancel:hover{
text-decoration:none;
color: #3B4043;
position: absolute;
right: 20px;
top: 0;
font-size: 14px;
}
</style>