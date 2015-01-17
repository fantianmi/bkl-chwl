<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- basic scripts -->
<!--[if !IE]> -->
<script src="http://ajax.useso.com/ajax/libs/jquery/2.0.3/jquery.min.js"></script>
<!-- <![endif]-->
<!--[if IE]>
<script src="http://ajax.useso.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
<![endif]-->
<!--[if !IE]> -->
<script type="text/javascript">
	window.jQuery || document.write("<script src='assets/js/jquery-2.0.3.min.js'>"+"<"+"/script>");
</script>
<!-- <![endif]-->
<!--[if IE]>
<script type="text/javascript">
 window.jQuery || document.write("<script src='assets/js/jquery-1.10.2.min.js'>"+"<"+"/script>");
</script>
<![endif]-->
<script type="text/javascript">
	if("ontouchend" in document) document.write("<script src='assets/js/jquery.mobile.custom.min.js'>"+"<"+"/script>");
</script>
<script src="assets/js/bootstrap.min.js"></script>
<script src="assets/js/typeahead-bs2.min.js"></script>
<!-- page specific plugin scripts -->
<script src="assets/js/dropzone.min.js"></script>
<!-- ace scripts -->
<script src="assets/js/ace-elements.min.js"></script>
<script src="assets/js/ace.min.js"></script>
<!-- inline scripts related to this page -->
<script type="text/javascript">
	function __getQueryVariable(variable) {
		var query = window.location.search.substring(1);
		var vars = query.split("&");
		for (var i = 0; i < vars.length; i++) {
			var pair = vars[i].split("=");
			if (pair[0] == variable) {
				return pair[1];
			}
		}
	}
	function __updateSearch(key, value, url) {
		if (!url)
			url = window.location.href;
		var re = new RegExp("([?&])" + key + "=.*?(&|#|$)(.*)", "gi");

		if (re.test(url)) {
			if (typeof value !== 'undefined' && value !== null)
				return url.replace(re, '$1' + key + "=" + value + '$2$3');
			else {
				var hash = url.split('#');
				url = hash[0].replace(re, '$1$3').replace(/(&|\?)$/, '');
				if (typeof hash[1] !== 'undefined' && hash[1] !== null)
					url += '#' + hash[1];
				return url;
			}
		} else {
			if (typeof value !== 'undefined' && value !== null) {
				var separator = url.indexOf('?') !== -1 ? '&' : '?', hash = url
						.split('#');
				url = hash[0] + separator + key + '=' + value;
				if (typeof hash[1] !== 'undefined' && hash[1] !== null)
					url += '#' + hash[1];
				return url;
			} else
				return url;
		}
	}
	window.onload = function() {
		$(".nav-search-input").off("keydown").on("keydown", function(e){
			 var key = e.which;
             if (key == 13) {
                e.preventDefault();
				var keys = $(this).data("keys");
				var url = __updateSearch("searchKey", keys);
				url = __updateSearch("searchText", $(this).val(), url);
				window.location.href = url;
				//return false;
			}
		})

		var currentPage = window.location.pathname.substring(window.location.pathname.lastIndexOf("/") + 1);
		var currentA = $(".nav-list a[href='" + currentPage + "']");
		if(currentA && currentA.length == 1) {
			currentA.parent().addClass("active");
		}
		var currentAUl = currentA.closest("ul");
		if(!currentAUl.hasClass("nav-list")) {
			currentAUl.css("display", "block");
			currentAUl.parent().addClass("open");
		} 
	}
	var logout = function() {
		$.ajax({
			url : "/open/logout",
		}).done(function(result) {
			if (result && result.ret == 0) {
				window.location = "/backend/login.jsp";
			} else {
				alert("服务器异常,请与管理员联系!")
			}
		});
	};
</script>
<script type="text/javascript" src="common/js/index.js"></script>
<!-- fancy box -->
<script type="text/javascript">
$(document).ready(function() {
	/* This is basic - uses default settings */
	$("a#single_image").fancybox();
	/* Using custom settings */
	$("a#inline").fancybox({
		'hideOnContentClick': true
	});

	/* Apply fancybox to multiple items */
	
	$("a.group").fancybox({
		'transitionIn'	:	'elastic',
		'transitionOut'	:	'elastic',
		'speedIn'		:	600, 
		'speedOut'		:	200, 
		'overlayShow'	:	false
	});
});
</script>
<script type="text/javascript" src="assets/fancybox/jquery.fancybox.pack.js"></script>
<script type="text/javascript" src="common/js/deal.js"></script>
