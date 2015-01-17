function showOperationPanel(reid){
	document.getElementById("operationPanelName").innerHTML="添加栏目";
	$("#operationPanel").removeClass("hidePanel");
	$("#sortrank").val(0);
	document.getElementById("reid").value=reid;
	document.getElementById("defaultname").value="";
	document.getElementById("description").value="";
	document.getElementById("keywords").value="";
}
function showOperationPanelToModify(id,reid,sortrank,defaultname,description,keywords){
	document.getElementById("operationPanelName").innerHTML="修改栏目属性";
	$("#operationPanel").removeClass("hidePanel");
	document.getElementById("reid").value=reid;
	if(reid==0){
		$("#sortrank").val(0);
	}else{
		$("#sortrank").val(1);
	}
	$("submitButton").removeAttr("onclick");
	document.getElementById("defaultname").value=defaultname;
	document.getElementById("description").value=description;
	document.getElementById("keywords").value=keywords;
}
function checkIsOpen(reid){
	var isOpen=true;
	if($("#iconCheck"+reid+"").hasClass("icon-plus")){
		isOpen=false;
	}
	return isOpen;
}
function loadChildData(reid){
	var isTail=false;
	if($("#folder"+reid+"").hasClass("child")){
		isTail=true;
	}
	if(checkIsOpen(reid)){
		$("#folderContent"+reid+"").empty();
		$("#iconCheck"+reid+"").removeClass("icon-minus");
		$("#iconCheck"+reid+"").addClass("icon-plus");
		return;
	}
	$("#iconCheck"+reid+"").removeClass("icon-plus");
	$("#iconCheck"+reid+"").addClass("icon-minus");
	var url = "/arctype/getArcType?reid="+reid+"&channel=0&random="+Math.round(Math.random()*100);
	jQuery.get(url,function(result){
		var menulist = new Array(); 
		menulist=result.data;
		$("#folder"+reid+"").append("<div class='tree-folder-content' style='display:block' id='folderContent"+reid+"'>");
		if(menulist.length!=0){
			for(var i=0;i<menulist.length;i++){
				var menuName=menulist[i]["defaultname"];
				var menuId=menulist[i]["id"];
				var menuReid=menulist[i]["reid"];
				if(isTail){
					$("#folderContent"+reid+"").append("<div class='tree-folder child' style='display:block'  id='folder"+menuId+"'><div class='tree-folder-header'><div class='tree-folder-name'>"+menuName+"</div>[<a href='addVideo.jsp?typeid="+menuId+"' target='_blank'>添加视频资料</a>]</div>");
				}else{
					$("#folderContent"+reid+"").append("<div class='tree-folder child' style='display:block'  id='folder"+menuId+"'><div class='tree-folder-header'><i class='icon-plus' onclick='loadChildData("+menuId+")' id='iconCheck"+menuId+"'></i><div class='tree-folder-name'>"+menuName+"</div></div>");
				}
			}
		}else{
			$("#folderContent"+reid+"").append("<div class='tree-item' style='display: block;'><i class='icon-remove'></i><div class='tree-item-name'>没有数据</div></div>");
			$("#folderContent"+reid+"").addClass("nodata");
		}
	});
}