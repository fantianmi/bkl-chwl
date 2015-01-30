/*添加科目*/
function addArea(){
	var reid=document.getElementById("reid").value;
	var title=document.getElementById("title").value;
	if(reid==""||reid==null||title==""||title==null){
		alert("请确认表单是否填写完整");
		return false;
	}
	var url="/area/addArea?random="+Math.round(Math.random()*100);
	var params={reid:reid, title:title};
	jQuery.post(url,params,function(data){
		if(data) {
			if(data.ret == 0) {
				var menulist = new Array(); 
				menulist=data.data;
				var menuName=menulist["title"];
				var menuId=menulist["id"];
				var menuReid=menulist["reid"];
				if($("#folderContent"+reid+"").hasClass("nodata")){
					$("#folderContent"+reid+"").removeClass("nodata");
					$("#folderContent"+reid+"").empty();
				}
				$("#folderContent"+reid+"").append("<div class='tree-folder' style='display:block'  id='folder"+menuId+"'><div class='tree-folder-header'><i class='icon-plus' onclick='loadChildData("+menuId+")' id='iconCheck"+menuId+"'></i><div class='tree-folder-name'>"+menuName+"</div>&nbsp;&nbsp;[<a href='javascript:showOperationPanel("+menuId+");'>增加下级</a>]&nbsp;&nbsp;[<a href='javascript:deleteArea(this,"+menuId+");'>删除</a>]</div>");
				alert("添加成功！");
			}
		}
	});
}
function addType(){
	var reid=document.getElementById("reid").value;
	var title=document.getElementById("title").value;
	if(reid==""||reid==null||title==""||title==null){
		alert("请确认表单是否填写完整");
		return false;
	}
	var url="/type/addType?random="+Math.round(Math.random()*100);
	var params={reid:reid, name:title};
	jQuery.post(url,params,function(data){
		if(data) {
			if(data.ret == 0) {
				var menulist = new Array(); 
				menulist=data.data;
				var menuName=menulist["name"];
				var menuId=menulist["id"];
				var menuReid=menulist["reid"];
				if($("#folderContent"+reid+"").hasClass("nodata")){
					$("#folderContent"+reid+"").removeClass("nodata");
					$("#folderContent"+reid+"").empty();
				}
				$("#folderContent"+reid+"").append("<div class='tree-folder' style='display:block'  id='folder"+menuId+"'><div class='tree-folder-header'><i class='icon-plus' onclick='loadChildData("+menuId+")' id='iconCheck"+menuId+"'></i><div class='tree-folder-name'>"+menuName+"</div>&nbsp;&nbsp;[<a href='javascript:showOperationPanel("+menuId+");'>增加下级</a>]&nbsp;&nbsp;[<a href='javascript:deleteType(this,"+menuId+");'>删除</a>]</div>");
				alert("添加成功！");
			}
		}
	});
}

/*删除栏目*/
function deleteArea(self,id){
	if(confirm("确认删除栏目"+id+"？")){
		var url="/area/deleteArea?random="+Math.round(Math.random()*100);
		var params={id:id};
		jQuery.post(url,params,function(data){
			if(data) {
				if(data.ret == 0) {
					alert("删除成功！");
					$("#folder"+id).remove();
				}
			}
		});
	}
}
function deleteType(self,id){
	if(confirm("确认删除栏目"+id+"？")){
		var url="/type/deleteType?random="+Math.round(Math.random()*100);
		var params={id:id};
		jQuery.post(url,params,function(data){
			if(data) {
				if(data.ret == 0) {
					alert("删除成功！");
					$("#folder"+id).remove();
				}
			}
		});
	}
}
/*修改栏目*/
function modifyArcType(id){
	var reid=document.getElementById("reid").value;
	var sortrank=document.getElementById("sortrank").value;
	var defaultname=document.getElementById("defaultname").value;
	var description=document.getElementById("description").value;
	var keywords=document.getElementById("keywords").value;
	if(reid==null||sortrank==null||defaultname==null||description==null||keywords==null||
			reid==""||sortrank==""||defaultname==""||description==""||keywords==""){
		alert("请确认表单是否填写完整");
		return false;
	}
	var issend=0;
	var corrank=0;
	var siteurl="siteurl";
	var sitepath="sitepath";
	var channel=0;
	var url="/arctype/modifyArcType?random="+Math.round(Math.random()*100);
	var params={id:id, reid:reid, sortrank:sortrank, defaultname:defaultname, description:description, keywords:keywords, issend:issend, corrank:corrank, siteurl:siteurl, sitepath:sitepath, channel:channel};
	jQuery.post(url,params,function(data){
		if(data) {
			if(data.ret == 0) {
				var menulist = new Array(); 
				menulist=data.data;
				var menuName=menulist["defaultname"];
				var menuId=menulist["id"];
				var menuReid=menulist["reid"];
				$("#folder"+menuId+"").empty();
				$("#folder"+menuId+"").append("<div class='tree-folder-header'><i class='icon-plus' onclick='loadChildData("+menuId+")' id='iconCheck"+menuId+"'></i><div class='tree-folder-name'>"+menuName+"</div>&nbsp;&nbsp;[<a href='javascript:showOperationPanel("+menuId+");'>增加下级目录</a>]&nbsp;&nbsp;[<a href='javascript:deleteArcType("+menuId+");'>删除</a>]</div>");
				alert("修改成功！");
			}
		}
	});
}
/* **********************其他机构管理***************************** */
/*其他机构添加*/
function addOtherType(){
	var sortrank=document.getElementById("sortrank").value;
	var defaultname=document.getElementById("defaultname").value;
	var brochure=document.getElementById("brochure").value;
	var agencieson=document.getElementById("agencieson").value;
	var keywords=document.getElementById("keywords").value;
	
	if(sortrank==null||defaultname==null||brochure==null||agencieson==null||keywords==null||
			sortrank==""||defaultname==""||brochure==""||agencieson==""||keywords==""){
		alert("请确认表单是否填写完整");
		return false;
	}
	params={sortrank:sortrank, defaultname:defaultname, brochure:brochure, agencieson:agencieson, keywords:keywords};
	url="/otherpart/addOtherPartMenu?random="+Math.round(Math.random()*100);
	jQuery.post(url,params,function(result){
		if(result){
			if(result.ret==0){
				var data=new Array();
				data=result.data;
				var resId=data["id"];
				var resSortrank=data["sortrank"];
				var resSortrankText=null;
				if(resSortrank==0) resSortrankText="不置顶";
				else if(resSortrank==1) resSortrankText="置顶";
				var resDefaultname=data["defaultname"];
				var resBrochure=data["brochure"];
				var resAgencieson=data["agencieson"];
				var resKeywords=data["keywords"];
				$("#otherPartTable").append("<tr id='tableTr"+resId+"'><td><i class='icon-edit'></i></td><td><input type='text' id='defaultname"+resId+"' class='col-xs-12 col-sm-12' value='"+resDefaultname+"'/></td><td><input type='text' id='brochure"+resId+"' class='col-xs-12 col-sm-12' value='"+resBrochure+"'/></td><td><input type='text' id='agencieson"+resId+"' class='col-xs-12 col-sm-12' value='"+resAgencieson+"'/></td><td><input type='text' id='keywords"+resId+"' class='col-xs-12 col-sm-12' value='"+resKeywords+"'/></td><td><select name='sortrank"+resId+"' id='sortrank"+resId+"'><option value='"+resSortrank+"'>"+resSortrankText+"</option><option value='0'>不置顶</option><option value='1'>置顶</option></select></td><td><a href='  javascript:modifyOtherPart("+resId+");' class='btn btn-sm btn-primary'>修改</a> <a href='javascript:deleteOtherPart("+resId+");' class='btn btn-sm btn-danger'>删除</a></td></tr>");
			}
		}
	});
}
/*其他机构修改*/
function modifyOtherPart(id){
	var defaultname=document.getElementById("defaultname"+id+"").value;
	var brochure=document.getElementById("brochure"+id+"").value;
	var agencieson=document.getElementById("agencieson"+id+"").value;
	var keywords=document.getElementById("keywords"+id+"").value;
	var sortrank=document.getElementById("sortrank"+id+"").value;
	
	if(sortrank==null||defaultname==null||brochure==null||agencieson==null||
			sortrank==""||defaultname==""||brochure==""||agencieson==""){
		alert("请确认表单是否填写完整");
		return false;
	}
	params={id:id, sortrank:sortrank, defaultname:defaultname, brochure:brochure, agencieson:agencieson, keywords:keywords};
	url="/otherpart/modifyOtherPartMenu?random="+Math.round(Math.random()*100);
	jQuery.post(url,params,function(result){
		if(result){
			if(result.ret==0){
				alert("修改成功");
				var data=new Array();
				data=result.data;
				var resId=data["id"];
				var resSortrank=data["sortrank"];
				var resSortrankText=null;
				if(resSortrank==0) resSortrankText="不置顶";
				else if(resSortrank==1) resSortrankText="置顶";
				var resDefaultname=data["defaultname"];
				var resBrochure=data["brochure"];
				var resAgencieson=data["agencieson"];
				var resKeywords=data["keywords"];
				$("#tableTr"+resId+"").empty();
				$("#tableTr"+resId+"").append("<td><i class='icon-edit'></i></td><td><input type='text' id='defaultname"+resId+"' class='col-xs-12 col-sm-12' value='"+resDefaultname+"'/></td><td><input type='text' id='brochure"+resId+"' class='col-xs-12 col-sm-12' value='"+resBrochure+"'/></td><td><input type='text' id='agencieson"+resId+"' class='col-xs-12 col-sm-12' value='"+resAgencieson+"'/></td><td><input type='text' id='keywords"+resId+"' class='col-xs-12 col-sm-12' value='"+resKeywords+"'/></td><td><select name='sortrank"+resId+"' id='sortrank"+resId+"'><option value='"+resSortrank+"'>"+resSortrankText+"</option><option value='0'>不置顶</option><option value='1'>置顶</option></select></td><td><a href='  javascript:modifyOtherPart("+resId+");' class='btn btn-sm btn-primary'>修改</a> <a href='javascript:deleteOtherPart("+resId+");' class='btn btn-sm btn-danger'>删除</a></td>");
			}
		}
	});
}
/*其他机构删除*/
function deleteOtherPart(id){
	if(!confirm("确认删除？")){
		return false;
	}
	url="/otherpart/deleteOtherPartMenu?random="+Math.round(Math.random()*100);
	params={id:id};
	jQuery.post(url, params, function(result){
		if(result){
			if(result.ret==0){
				alert("删除成功");
				$("#tableTr"+id+"").remove();
			}
		}
	});
}
/*视频添加中选择相应的媒体文件到资料中*/
var global_id=0;
function addToMidForm(id,type){
	$("#toolsbar"+global_id+"").css("left","-30px");
	$("#toolsbar"+global_id+"").css("width","24px");
	$("#checked"+global_id+"").remove();
	document.getElementById("mid").value=id;
	$("#toolsbar"+id+"").css("left","0px");
	if(type==1){
		$("#toolsbar"+id+"").css("width","300px");
		$("#toolsbarhref"+id+"").append("<p id='checked"+id+"'>已选择<br>点击ok按钮确认</p>");
	}else{
		$("#toolsbar"+id+"").css("width","147px");
		$("#toolsbarhref"+id+"").append("<p id='checked"+id+"'>已选择</p>");
	}
	
	global_id=id;
}
/*unix_timeStamp to data*/
function timeConverter(UNIX_timestamp){
  var a = new Date(UNIX_timestamp*1000);
  var months = ['1','2','3','4','5','6','7','8','9','10','11','12'];
  var year = a.getFullYear();
  var month = months[a.getMonth()];
  var date = a.getDate();
  var hour = a.getHours();
  var min = a.getMinutes();
  var sec = a.getSeconds();
  var time = date + ',' + month + ' ' + year + ' ' + hour + ':' + min + ':' + sec ;
  return time;
}
/*添加媒体资料 --讲义，视频，其他机构通用*/
function submitAddVideo(){
	var mtid=document.getElementById("mtid").value;
	var typeid=document.getElementById("typeid").value;
	var sortrank=document.getElementById("sortrank").value;
	var shorttitle=document.getElementById("shorttitle").value;
	var source=document.getElementById("source").value;
	var keywords=document.getElementById("keywords").value;
	var likeid=document.getElementById("likeid");
	var likeidText="";
	for(var i=0;i<likeid.options.length;i++){
		if(likeid.options[i].selected){
			likeidText=likeid.options[i].value+" "+likeidText;
		}
	}
	var mid=document.getElementById("mid").value;
	var free=document.getElementById("free").value;
	var price=document.getElementById("price").value;
	var description=document.getElementById("description").value;
	var channel=document.getElementById("channel").value;
	if(typeid==null||sortrank==null||shorttitle==null||source==null||keywords==null||mid==null||free==null||description==null||channel==null||
			typeid==""||sortrank==""||shorttitle==""||source==""||keywords==""||mid==""||free==""||description==""||channel==""){
		alert("请确认表单填写完整");
		return false;
	}
	if(price==null||price==""){
		price=0;
	}
    var url="/materials/addMaterials?random="+Math.round(Math.random()*100);
    if(mtid==0){
    	var params={typeid:typeid, sortrank:sortrank, shorttitle:shorttitle, source:source, keywords:keywords, likeid:likeidText, mid:mid, free:free, price:price, description:description, channel:channel};
    }else{
    	var params={id:mtid, typeid:typeid, sortrank:sortrank, shorttitle:shorttitle, source:source, keywords:keywords, likeid:likeidText, mid:mid, free:free, price:price, description:description, channel:channel};
    }
	jQuery.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				if(mtid==0){
					alert("添加成功");
					window.location.reload();
				}else{
					alert("修改成功");
					window.location.reload();
				}
			}
		}
	});
}
/*删除媒体资料 --讲义，视频，其他机构通用*/
function deleteVideo(id){
	if(!confirm("确认删除?")){
		return false;
	}
	var url="/materials/deleteMaterials?random=	"+Math.round(Math.random()*100);
	var param={id:id};
	jQuery.post(url,param,function(res){
		if(res){
			if(res.ret==0){
				$("#tableTr"+id+"").remove();
				alert("删除成功");
			}
		}
	});
}
/*删除媒体文件*/
function deleteMedia(id){
	if(!confirm("确认删除？")){
		return false;
	}
	var url="/media/deleteMedia?random="+Math.round(Math.random()*100);
	var param={mid:id};
	jQuery.post(url,param,function(res){
		if(res){
			if(res.ret==0){
				$("#mediaLi"+id+"").remove();
				alert("删除成功");
			}
		}
	});
}
/*添加或者修改广告*/
function operBanner(){
	var bid=document.getElementById("bid").value;
	var shorttitle = document.getElementById("shorttitle").value;
	var linkurl = document.getElementById("linkurl").value;
	var images=document.getElementById("images").value;
	var sortrank=document.getElementById("sortrank").value;
	var bannertype=document.getElementById("bannerType").value;
	if(bid==null||shorttitle==null||linkurl==null||images==null||sortrank==null||bannertype==null||
			bid==""||shorttitle==""||linkurl==""||images==""||sortrank==""||bannertype==""){
		alert("请确认表单填写是否完整");
		return false;
	}
	if(bid!=0){
		param={id:bid, shorttitle:shorttitle, linkurl:linkurl, images:images, sortrank:sortrank, bannertype:bannertype};
	}else{
		param={shorttitle:shorttitle, linkurl:linkurl, images:images, sortrank:sortrank, bannertype:bannertype};
	}
	url="/banner/addBanner?random="+Math.round(Math.random()*100);
	jQuery.post(url,param,function(res){
		if(res){
			if(res.ret==0){
				if(bid==0){
					if(confirm("添加成功，继续添加？")){
						document.getElementById("shorttitle").value="";
						document.getElementById("linkurl").value="";
						document.getElementById("images").value="";
						document.getElementById("sortrank").value="";
						document.getElementById("bannerType").value="";
					}else{
						window.location.href="/backend/adver.jsp";
					}
				}else{
					alert("修改成功");
				}
			}
		}
	});
}
/*删除广告*/
function deleteBanner(id){
	if(confirm("确认删除？")==false){
		return false;
	}
	var param={id:id};
	var url="/banner/deleteBanner?random="+Math.round(Math.random()*100);
	jQuery.post(url,param,function(res){
		if(res){
			if(res.ret==0){
				alert("删除成功");
				$("#bansli"+id+"").remove();
			}
		}
	});
}

function addToShowArea(id){
	var sortrank=1;
	var param={id:id, sortrank:sortrank};
	url="/banner/addBanner?random="+Math.round(Math.random()*100);
	jQuery.post(url,param,function(res){
		if(res){
			if(res.ret==0){
				alert("显示成功");
				window.location.reload();
			}
		}
	});
}

function deleteFromShowArea(id){
	var sortrank=0;
	var param={id:id, sortrank:sortrank};
	url="/banner/addBanner?random="+Math.round(Math.random()*100);
	jQuery.post(url,param,function(res){
		if(res){
			if(res.ret==0){
				alert("已撤下成功");
				window.location.reload();
			}
		}
	});
}
/* **********************版本管理***************************** */
/*版本添加*/
function addVersion(){
	var version=document.getElementById("version").value;
	var name=document.getElementById("name").value;
	var downloadurl=document.getElementById("downloadurl").value;
	var apktype=document.getElementById("apktype").value;
	
	if(version==null||name==null||downloadurl==null||apktype==null||
			version==""||name==""||downloadurl==""||apktype==""){
		alert("请确认表单是否填写完整");
		return false;
	}
	params={version:version, name:name, downloadurl:downloadurl, apktype:apktype};
	url="/version/addVersion?random="+Math.round(Math.random()*100);
	jQuery.post(url,params,function(result){
		if(result){
			if(result.ret==0){
				var data=new Array();
				data=result.data;
				var resId=data["id"];
				var resApktype=data["apktype"];
				var resApktypeText=null;
				if(resApktype==0) resApktypeText="android";
				else if(resApktype==1) resApktypeText="ios";
				var resName=data["name"];
				var resDownloadurl=data["downloadurl"];
				var resVersion=data["version"];
				$("#versionTable").append("<tr id='tableTr"+resId+"'><td><i class='icon-edit'></i></td><td><input type='text' id='version"+resId+"' class='col-xs-12 col-sm-12' value='"+resVersion+"'/></td><td><input type='text' id='name"+resId+"' class='col-xs-12 col-sm-12' value='"+resName+"'/></td><td><input type='text' id='downloadurl"+resId+"' class='col-xs-12 col-sm-12' value='"+resDownloadurl+"'/></td><td><select name='apktype"+resId+"' id='apktype"+resId+"'><option value='"+resApktype+"'>"+resApktypeText+"</option><option value='0'>android</option><option value='1'>ios</option></select></td><td><a href='  javascript:modifyVersion("+resId+");' class='btn btn-sm btn-primary'>修改</a> <a href='javascript:deleteVersion("+resId+");' class='btn btn-sm btn-danger'>删除</a></td></tr>");
			}
		}
	});
}
/*版本修改*/
function modifyVersion(id){
	var version=document.getElementById("version"+id+"").value;
	var name=document.getElementById("name"+id+"").value;
	var downloadurl=document.getElementById("downloadurl"+id+"").value;
	var apktype=document.getElementById("apktype"+id+"").value;
	
	if(version==null||name==null||downloadurl==null||apktype==null||
			version==""||name==""||downloadurl==""||apktype==""){
		alert("请确认表单是否填写完整");
		return false;
	}
	params={id:id, version:version, name:name, downloadurl:downloadurl, apktype:apktype};
	url="/version/addVersion?random="+Math.round(Math.random()*100);
	jQuery.post(url,params,function(result){
		if(result){
			if(result.ret==0){
				alert("修改成功");
				var data=new Array();
				data=result.data;
				var resId=data["id"];
				var resApktype=data["apktype"];
				var resApktypeText=null;
				if(resApktype==0) resApktypeText="android";
				else if(resApktype==1) resApktypeText="ios";
				var resName=data["name"];
				var resDownloadurl=data["downloadurl"];
				var resVersion=data["version"];
				$("#tableTr"+resId+"").empty();
				$("#tableTr"+resId+"").append("<td><i class='icon-edit'></i></td><td><input type='text' id='version"+resId+"' class='col-xs-12 col-sm-12' value='"+resVersion+"'/></td><td><input type='text' id='name"+resId+"' class='col-xs-12 col-sm-12' value='"+resName+"'/></td><td><input type='text' id='downloadurl"+resId+"' class='col-xs-12 col-sm-12' value='"+resDownloadurl+"'/></td><td><select name='apktype"+resId+"' id='apktype"+resId+"'><option value='"+resApktype+"'>"+resApktypeText+"</option><option value='0'>android</option><option value='1'>ios</option></select></td><td><a href='  javascript:modifyVersion("+resId+");' class='btn btn-sm btn-primary'>修改</a> <a href='javascript:deleteVersion("+resId+");' class='btn btn-sm btn-danger'>删除</a></td>");
			}
		}
	});
}
/*版本删除*/
function deleteVersion(id){
	if(!confirm("确认删除？")){
		return false;
	}
	url="/version/deleteVersion?random="+Math.round(Math.random()*100);
	params={id:id};
	jQuery.post(url, params, function(result){
		if(result){
			if(result.ret==0){
				alert("删除成功");
				$("#tableTr"+id).remove();
			}
		}
	});
}

function deleteUser(uid){
	if(!confirm("确认删除？")){
		return false;
	}
	url="/api/user/deleteUser?random="+Math.round(Math.random()*100);
	params={uid:uid};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				alert("删除成功");
				$("#row_"+uid).remove();
			}else{
				alert("数据错误，请联系管理员");
			}
		}
	});
}

function changeArea(self,reid){
	var url="/area/getAreaHTMLOption?reid="+reid+"&random="+Math.round(Math.random()*100);
	jQuery.get(url,function(res){
		if(res){
			if(res.ret==0){
				$(self).next().html(res.data);
			}
		}
	});
}


