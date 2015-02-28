function ltrim(s){
    return s.replace( /^\s*/, "");
}

function rtrim(s){
    return s.replace( /\s*$/, "");
}

function trim(s){
    return rtrim(ltrim(s));
}

function checkUserName(username){
	filter=/^[a-zA-Z0-9\u0391-\uFFE5]{2,20}/;
	if(!filter.test(trim(username))){
		return false;
	}else{
		return true;
	}
}

function checkPassWord(username){
	filter=/^[a-zA-Z0-9\u0391-\uFFE5]{2,20}/;
	if(!filter.test(trim(username))){
		return false;
	}else{
		return true;
	}
}
function checkDate(dateStr){
	filter=/^\d{4}-((0[1-9]{1})|(1[0-2]{1}))-((0[1-9]{1})|([1-2]{1}[0-9]{1})|(3[0-1]{1}))$/;
	if(!filter.test(trim(dateStr))){
		return false;
	}else{
		return true;
	}
	
}
function checkNumber(num){
	filter=/^-?([1-9][0-9]*|0)(\.[0-9]+)?$/;
	if(!filter.test(trim(num))){
		return false;
	}else{
		return true;
	}
}
function checkNumberInt(num){
	filter=/^-?([1-9][0-9]*|0)$/;
	if(!filter.test(trim(num))){
		return false;
	}else{
		return true;
	}
}
function checkPositiveNumber(num){
	filter=/^([1-9][0-9]*|0)$/;
	if(!filter.test(trim(num))){
		return false;
	}else{
		return true;
	}
}
function checkNumber2(num){
	filter=/^-?([1-9][0-9]*|0)?(\.[0-9]{1,2})?$/;
	if(!filter.test(trim(num))){
		return false;
	}else{
		return true;
	}
}
function checkEmail(email){
	filter=/^([a-zA-Z0-9_\-\.\+]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
	if(!filter.test(trim(email))){
		return false;
	}else{
		return true;
	}
}
function checkMobile(mobile){
	filter=/^0?(13[0-9]|15[012356789]|17[678]|18[0-9]|14[57])[0-9]{8}$/;
	//filter=/^1[3|4|5|8][0-9]\d{8}$/;
	if(!filter.test(trim(mobile))){
		return false;
	}else{
		return true;
	}
}

function getLength(str)//
{
   count = 0;
   for (var i = 0; i < str.length; i++) 
   {
      if (((str.charCodeAt(i) >= 0x3400) && (str.charCodeAt(i) < 0x9FFF)) || (str.charCodeAt(i) >= 0xF900))
      {
         count+=2;
      }else{
      	 count++;
      }
   }
   return count;
}

function getLeft(str,len){
	i=0;
	for(var i=0;i<len;i++){
		 if (((str.charCodeAt(i) >= 0x3400) && (str.charCodeAt(i) < 0x9FFF)) || (str.charCodeAt(i) >= 0xF900))
      {
         len--;
      }
	  
	}
	str=str.substr(0,i);
	str+="..";
	return str;
}

function left(str,len){
	
	if(getLength(str)>len){
		str=getLeft(str,len-2);
	}
	return str;
}
function checkNumberAndString(str){
	filter=/^[a-zA-Z0-9]{10,50}$/;
	if(!filter.test(trim(str))){
		return false;
	}else{
		return true;
	}
}
function getCurrentDate(c){
	 d = new Date();
	 s="";
	 year=d.getFullYear();    
     month=1+d.getMonth();   
     date=d.getDate();       
     if(month<10){
     	month="0"+month;
     }
     if(date<10){
     	date="0"+date;
     }
     s=year+c+month+c+date;
	 return s;
}
function getCurrentTime(c){
		  var d, s = "";
  		  d = new Date();
 		  s += d.getHours() + c;
 		  s += d.getMinutes() + c;
 		  s += d.getSeconds() + c;
  		  s += d.getMilliseconds();
  		  return s;
}
function getAbsoluteHeight(ob){
	return ob.offsetHeight;
}
function getAbsoluteTop(ob){
	var s_el=0;
	el=ob;
	while(el){
		s_el=s_el+el.offsetTop ;
		el=el.offsetParent;
	}; 
	return s_el;
}
function getAbsoluteLeft(ob){
	var s_el=0;el=ob;
	while(el){
		s_el=s_el+el.offsetLeft;
		el=el.offsetParent;
	};
	return s_el;
}





	function hasClass(ele,cls) {
	  return ele.className.match(new RegExp('(\\s|^)'+cls+'(\\s|$)'));
	}
	 
	function addClass(ele,cls) {
	  if (!this.hasClass(ele,cls)) ele.className += " "+cls;
	}
	 
	function removeClass(ele,cls) {
	  if (hasClass(ele,cls)) {
	          var reg = new RegExp('(\\s|^)'+cls+'(\\s|$)');
	    ele.className=ele.className.replace(reg,' ');
	  }
	}


function stopBubble(e) { // 阻止冒泡
    if ( e && e.stopPropagation )
     e.stopPropagation();
    else
     window.event.cancelBubble = true;
}
function stopDefault( e ) {
    if ( e && e.preventDefault )
     e.preventDefault();
    else
     window.event.returnValue = false;
    return false;
}

function getStyle(o,n){
	return o.currentStyle?o.currentStyle[n]:(document.defaultView.getComputedStyle(o,"").getPropertyValue(n));
}

function getPosLeft(o) { 
	var l = o.offsetLeft;
 return l = (o = o.offsetParent)?(l+o.offsetLeft+(!parseInt(getStyle(o,"borderLeftWidth"))?0:parseInt(getStyle(o,"borderLeftWidth")))):l;
}

function getPosTop(o) { 
var t = o.offsetTop; 
return t = (o = o.offsetParent)?(t+o.offsetTop+(!parseInt(getStyle(o,"borderTopWidth"))?0:parseInt(getStyle(o,"borderTopWidth")))):t;
}
function   getXYWH(o){
var   nLt=0;
var   nTp=0;
  var   offsetParent   =   o;
  while   (offsetParent!=null   &&   offsetParent!=document.body)   {
  nLt+=offsetParent.offsetLeft;
  nTp+=offsetParent.offsetTop;
  offsetParent=offsetParent.offsetParent;
  }
  this.showL=nLt;
  this.showT=nTp;
  this.showW=this.offsetWidth;
  this.showH=this.offsetHeight;
}

function addLoadEvent(func) {
  var oldonload = window.onload;
  if (typeof window.onload != 'function') {
    window.onload = func;
  } else {
    window.onload = function() {
      oldonload();
      func();
    };
  }
}

function addEV(C,B,A){
 if(window.attachEvent){
  C.attachEvent("on"+B,A);
  }else{
   if(window.addEventListener){
    C.addEventListener(B,A,false);
    }
  }
}
function removeEV(C,B,A){
 if(window.attachEvent){
  C.detachEvent("on"+B,A);
  }else{
   if(window.addEventListener){
    C.removeEventListener(B,A,false);
    }
  }
}


// dynamic include another js file
function include_js(path,reload)
{
	var scripts = document.getElementsByTagName("script");
	if (reload==null || !reload)
	for (var i=0;i<scripts.length;i++){
		if (scripts[i].src && scripts[i].src.toLowerCase() == path.toLowerCase() ) 
			return;
	}
	var sobj = document.createElement('script');
	sobj.type = "text/javascript";
	sobj.src = path;
	var headobj = document.getElementsByTagName('head')[0];
	headobj.appendChild(sobj);
}

// ----------动态加载-------------//
function LoadJS(fileUrl,type)
{ 
    var oHead = document.getElementsByTagName('HEAD').item(0); 
    var oScript= document.createElement("script"); 
    oScript.type = "text/javascript"; 
	if(!!type){
	oScript.charset="gb2312";
	}
    oScript.src=fileUrl ; 
    oHead.appendChild(oScript); 
} 

function MM_swapImgRestore() { // v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { // v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
	 var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
	 if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { // v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
	 d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { // v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
	if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}


function boxFloat(obj,elem){
	var nmove,mmove,
		d = document,
		o = d.getElementById(obj),
		s = d.getElementById(elem);
	if(!o){ return false;}
	if(!s){ return false;}
	
	s.onmouseover=function(){
		clearTimeout(nmove);
		s.style.display="block";
		s.style.cursor="pointer";
	};
	o.onmouseover=function(){
		clearTimeout(nmove);
		mmove=setTimeout(function(){
			
			s.style.display="block";
			if(obj.indexOf("ordersStatus_") != -1){
				var id = obj.substring(obj.indexOf("_")+1,obj.length);
				 jQuery("#detailOrdersStatus_"+id).load("/orders/status.do?id="+id,function (data){
				});
			}
			if(obj=="orderStatusIndex"){
				var id = document.getElementById("orderStatusId").value;
				indexOrdersStatus(id);
			}
			
		},100);
		
	};
	o.onmouseout=function(){
		clearTimeout(mmove);
		nmove=setTimeout(function(){s.style.display="none";},500);
	};
	s.onmouseout=function(){
		nmove=setTimeout(function(){s.style.display="none";},500);
	};
	s.onmousedown=function(e){
		stopBubble(e);
	};
}
boxFloat("accountlinkBlock","accountpop");
boxFloat("personalNetAssetsExplain","personalNetAssetsExplainBlock");
boxFloat("personalNetAssetsBorrowed","personalNetAssetsBorrowedBlock");
boxFloat("personalNetAssetsCanBorrowed","personalNetAssetsCanBorrowedBlock");
boxFloat("buyInsuranceDiv","buyInsuranceExplainBlock");


function totalAssetsBox(obj,elem,updown){
	var nmove,mmove,
	d = document,
	o = d.getElementById(obj),
	s = d.getElementById(elem);
	u = d.getElementById(updown);
	if(!o){ return false;}
	if(!s){ return false;}
	if(!u){ return false;}
	
	s.onmouseover=function(){
		clearTimeout(nmove);
		s.style.display="block";
		s.style.cursor="pointer";
		u.className = "controlUp";
	};
	
	o.onmouseover=function(){
		clearTimeout(nmove);
		mmove=setTimeout(function(){
			s.style.display="block";
			u.className = "controlUp";
		},100);
	}
	
	o.onmouseout=function(){
		clearTimeout(mmove);
		nmove=setTimeout(function(){s.style.display="none";u.className = "controlDown";},500);
	};
	s.onmouseout=function(){
		nmove=setTimeout(function(){s.style.display="none";u.className = "controlDown";},500);
	};
	s.onmousedown=function(e){
		stopBubble(e);
	};
}
totalAssetsBox("totalAssets","totalAssetsTable","controlUpDown");


function ShowMemo(obj,id)
{
	$("Memo"+id).style.display = "";
}

function HideMemo(id)
{
	$("Memo"+id).style.display = "none";
}

function dialogBoxHidden(){
	var d=document,
  o=d.getElementById("dialogBoxShadow");
 if(!o) return false;
	d.body.removeChild(o);	
}

function dialogBoxShadow(f){ 
	dialogBoxShadowMove(f,true);
}

function dialogBoxShadowMove(f,canmove){
	 var d = document,
	  divs=d.createElement("div"),
	  doc = d[d.compatMode == "CSS1Compat"?'documentElement':'body'],
	  h = f?doc.clientHeight:Math.max(doc.clientHeight,doc.scrollHeight);
	 divs.setAttribute("id","dialogBoxShadow");
	 d.body.appendChild(divs);
	 var o = d.getElementById('dialogBoxShadow');
	 o.style.cssText +="	;position:absolute;top:0;left:0;z-index:100;background:#000;opacity:0.4;filter:Alpha(opacity=20);width:100%;height:"+h+"px";
	 if(canmove) addMoveEvent("dialog_title","dialog_content");
}

function addMoveEvent(titleobj,contentobj){
	 var titleobj = document.getElementById(titleobj);
	 var contentobj=document.getElementById(contentobj);
	 if(titleobj!=null&&contentobj!=null){
		var bDrag = false;
		var disX = disY = 0;
		titleobj.onmousedown = function (event)
		{		
			var event = event || window.event;
			bDrag = true;
			disX = event.clientX - contentobj.offsetLeft;
			disY = event.clientY - contentobj.offsetTop;	
			this.setCapture && this.setCapture();	
			return false;
		};
		document.onmousemove = function (event)
		{
			if (!bDrag) return;
			var event = event || window.event;
			var iL = event.clientX - disX;
			var iT = event.clientY - disY;
			var maxL = document.documentElement.clientWidth - contentobj.offsetWidth;
			var maxT = document.documentElement.clientHeight - contentobj.offsetHeight;		
			iL = iL < 0 ? 0 : iL;
			iL = iL > maxL ? maxL : iL; 		
			iT = iT < 0 ? 0 : iT;
			iT = iT > maxT ? maxT : iT;
			
			contentobj.style.marginTop = contentobj.style.marginLeft = 0;
			contentobj.style.left = iL + "px";
			contentobj.style.top = iT + "px";		
			return false;
		};
		document.onmouseup = window.onblur = titleobj.onlosecapture = function ()
		{
			bDrag = false;				
			titleobj.releaseCapture && titleobj.releaseCapture();
		};
	 }

}

// -----------------弹出层定位--------------------//
function skillsPosition(obj,x){
var o=$(obj),h,oh,w,oc;
if(!o) return false;
o.style.display="block";
h=parseInt(getStyle(o,"height"));
w=parseInt(getStyle(o,"width"));
oh=";display:block;top:50%;margin-top:"+(-h/2)+"px";
o.style.cssText=!x?oh:(oh+";left:50%;margin-left:"+(-w/2)+"px");
}


/* 弹出层绝对居中定位 */
function setObjCenter(id){
	var d=document;
	var obj = d.getElementById(id);
	var data={
		ow:obj.clientWidth,
		oh:obj.clientHeight,
		vw:(function(){
		if (d.compatMode == "BackCompat"){
			return d.body.clientWidth;
		} else {
			return d.documentElement.clientWidth;
		}				
		})(),
		vh:(function(){
		if (d.compatMode == "BackCompat"){
			return d.body.clientHeight;
		} else {
			return d.documentElement.clientHeight;
		}			
		})(),
		st:(d.body.scrollTop||d.documentElement.scrollTop)
	};
	// obj.style.display="block";
	obj.style.left=(data.vw-data.ow)/2+"px";
	obj.style.margin=0;			
	if(!!window.XMLHttpRequest){
		obj.style.position="fixed";
		obj.style.top=(data.vh-data.oh)/2+"px";
	}else{
		obj.style.position="absolute";
		obj.style.top=(data.vh-data.oh)/2+data.st+"px";		
		if(obj.style.backgroundAttachment)
			obj.style.backgroundAttachment="absolute !important";		
		window.onscroll=function(){obj.style.top=(d.body.scrollTop||d.documentElement.scrollTop)+(data.vh-data.oh)/2+'px';};
	}						
}
// id 0:登录层 1:注册层
function showlogin(id){
	document.getElementById("okcoinPop").style.display="block";
	var r = document.getElementById("recommended_user_id").value;
	jQuery("#okcoinPop").load("/login.jsp?type="+id + "&r=" + r,function (data){
		dialogBoxShadow();
		showDialog(id);
	});
}
function closelogin(){
	dialogBoxHidden();
	document.getElementById("okcoinPop").style.display="none";
	document.getElementById("okcoinPop").innerHTML="";
}

/* gobacktop */

if(document.body !=null && document.body.scrollHeight>1200){
	goBackTop("goBackTop");
}
function goBackTop(id){
var oBtn=document.getElementById(id);
if(oBtn==null){
   return;
}

addEV(window,"scroll",function(){
	var sT=document.documentElement.scrollTop||document.body.scrollTop;
	var sH=document.documentElement.clientHeight;
	if(sT>180){
		oBtn.style.display="block";
		if(-1!=window.navigator.userAgent.indexOf('MSIE 6.0') && -1==window.navigator.userAgent.indexOf('MSIE 7.0') && -1==window.navigator.userAgent.indexOf('MSIE 8.0'))// for
																																											// ie6
	{
		oBtn.style.bottom="auto";
		oBtn.style.top=sT+sH-oBtn.offsetHeight+"px";
	}
	}
	else{
		oBtn.style.display="none";
	}
	
});
}

function okcoinAlert(str,pro,callback,btnTitle) {
	/*
	 * @str 传入提示内容 @pro 可选，取消按钮 返回值，确定为true，取消和关闭都为false
	 */
		if(btnTitle == "" || btnTitle == "undefined" || btnTitle==null){
			btnTitle = "确定";
		}
		var d = document, obj , tempStr = [] , dEle = d.documentElement , ieSix = (!window.XMLHttpRequest);
		var callback=callback||{okBack:function(){return true;},noBack:function(){return false;}};
		function gid(id){return d.getElementById(id);}
		if(!!gid("okcoinAlert")){		
			d.body.removeChild(gid("okcoinAlert"));
		}
		obj = d.createElement("div");	
		obj.className="okcoinPop";
		obj.id="okcoinAlert";	
		
		

		// tempStr.push('<iframe id="alertIframe" scrolling="no"
		// style="border:0;height:100%;_height:255px;width:100%;left:0;top:0;z-index:-1;position:absolute;"></iframe>');
		tempStr.push('<div class="small_content" id="alertBody">');
		tempStr.push('<div class="orderFloorTitle"><span style="float:left;">&nbsp;&nbsp;提示</span><span style="float:right;"><a id="alertClose" href="javascript:void(0);" class="dialog_closed" title="关闭"></a></span></div>');
		tempStr.push('<div class="smallFloor">'+str+'</div>');
		tempStr.push('<div class="orderFloor-button center"><input class="button button-orange" type="button" id="alertOk" value="'+btnTitle+'" title="'+btnTitle+'"/>');
		if(!!!pro){
			tempStr.push('</div>');
			}else{
			tempStr.push('&nbsp;&nbsp;<input id="alertNo" class="button button-false" type="button" value="取消" title="取消"/></div>');
		}
				
		tempStr.push('</div>');
		obj.innerHTML=tempStr.join("");
		d.body.appendChild(obj);
		dialogBoxShadow();
		var os = obj.style;
		os.display="block";
		var temptop = d.body.scrollTop+d.documentElement.scrollTop;
		os.left=(dEle.clientWidth-obj.clientWidth)/2+dEle.scrollLeft+"px"; 	
		os.top=(dEle.clientHeight-obj.clientHeight)/2+dEle.scrollTop+d.body.scrollTop+"px";	
		if(ieSix){os.top=(dEle.clientHeight-obj.clientHeight)/2+temptop+"px";}
		os.position ="absolute";
		os.zIndex="100000";
		function fixed(){
			os.top=(dEle.clientHeight-obj.clientHeight)/2+dEle.scrollTop+d.body.scrollTop+"px";			
		}		
		if(ieSix){
// gid("alertIframe").style.height=gid("alertBody").offsetHeight+"px";
// gid("alertIframe").style.width=gid("alertBody").offsetWidth+"px";
// gid("alertIframe").style.top = gid("alertBody").style.top+"px";
// gid("alertIframe").style.left = gid("alertBody").style.left+"px";
			
			addEV(window,"scroll",fixed);
		}else{
			addEV(window,"scroll",fixed);
		}
		function hideObj(){
			d.body.removeChild(obj);
			dialogBoxHidden();
			os.display="none";
			if(ieSix){
				window.detachEvent("onscroll",fixed);
			}
		}		
		gid("alertClose").onclick=function(){
			hideObj();
			if(!!callback.noBack){
				callback.noBack();
			}
			return false;
		};
		gid("alertOk").onclick=function(){
			hideObj();
			if(!!callback.okBack){
				callback.okBack();
			}
			return true;
		};
		if(!!pro){
			gid("alertNo").onclick=function(){
				hideObj();
			if(!!callback.noBack){
				callback.noBack();
			}
				return false;
			};
		}
		return true;
	}



// ----------------uuid file ------------------------//
/*
 * http://www.af-design.com/services/javascript/uuid/
 * 
 * uuid.js - Version 0.3 JavaScript Class to create a UUID like identifier
 * 
 * Copyright (C) 2006-2008, Erik Giberti (AF-Design), All rights reserved.
 * 
 * This program is free software; you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the Free Software
 * Foundation; either version 2 of the License, or (at your option) any later
 * version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
 * FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
 * details.
 * 
 * You should have received a copy of the GNU General Public License along with
 * this program; if not, write to the Free Software Foundation, Inc., 59 Temple
 * Place, Suite 330, Boston, MA 02111-1307 USA
 * 
 * The latest version of this file can be downloaded from
 * http://www.af-design.com/resources/javascript_uuid.php
 * 
 * HISTORY: 6/5/06 - Initial Release 5/22/08 - Updated code to run faster,
 * removed randrange(min,max) in favor of a simpler rand(max) function. Reduced
 * overhead by using getTime() method of date class (suggestion by James Hall).
 * 9/5/08 - Fixed a bug with rand(max) and additional efficiencies pointed out
 * by Robert Kieffer http://broofa.com/
 * 
 * KNOWN ISSUES: - Still no way to get MAC address in JavaScript - Research into
 * other versions of UUID show promising possibilities (more research needed) -
 * Documentation needs improvement
 * 
 */

// On creation of a UUID object, set it's initial value
function UUID(){
	this.id = this.createUUID();
}

// When asked what this Object is, lie and return it's value
UUID.prototype.valueOf = function(){ return this.id; };
UUID.prototype.toString = function(){ return this.id; };

//
// INSTANCE SPECIFIC METHODS
//

UUID.prototype.createUUID = function(){
	//
	// Loose interpretation of the specification DCE 1.1: Remote Procedure Call
	// described at
	// http://www.opengroup.org/onlinepubs/009629399/apdxa.htm#tagtcjh_37
	// since JavaScript doesn't allow access to internal systems, the last 48
	// bits
	// of the node section is made up using a series of random numbers (6 octets
	// long).
	//  
	var dg = new Date(1582, 10, 15, 0, 0, 0, 0);
	var dc = new Date();
	var t = dc.getTime() - dg.getTime();
	var h = '';
	var tl = UUID.getIntegerBits(t,0,31);
	var tm = UUID.getIntegerBits(t,32,47);
	var thv = UUID.getIntegerBits(t,48,59) + '1'; // version 1, security
													// version is 2
	var csar = UUID.getIntegerBits(UUID.rand(4095),0,7);
	var csl = UUID.getIntegerBits(UUID.rand(4095),0,7);

	// since detection of anything about the machine/browser is far to buggy,
	// include some more random numbers here
	// if NIC or an IP can be obtained reliably, that should be put in
	// here instead.
	var n = UUID.getIntegerBits(UUID.rand(8191),0,7) + 
			UUID.getIntegerBits(UUID.rand(8191),8,15) + 
			UUID.getIntegerBits(UUID.rand(8191),0,7) + 
			UUID.getIntegerBits(UUID.rand(8191),8,15) + 
			UUID.getIntegerBits(UUID.rand(8191),0,15); // this last number is
														// two octets long
	return tl + h + tm + h + thv + h + csar + csl + h + n; 
};


//
// GENERAL METHODS (Not instance specific)
//


// Pull out only certain bits from a very large integer, used to get the time
// code information for the first part of a UUID. Will return zero's if there
// aren't enough bits to shift where it needs to.
UUID.getIntegerBits = function(val,start,end){
	var base16 = UUID.returnBase(val,16);
	var quadArray = new Array();
	var quadString = '';
	var i = 0;
	for(i=0;i<base16.length;i++){
		quadArray.push(base16.substring(i,i+1));	
	}
	for(i=Math.floor(start/4);i<=Math.floor(end/4);i++){
		if(!quadArray[i] || quadArray[i] == '') quadString += '0';
		else quadString += quadArray[i];
	}
	return quadString;
};

// Replaced from the original function to leverage the built in methods in
// JavaScript. Thanks to Robert Kieffer for pointing this one out
UUID.returnBase = function(number, base){
	return (number).toString(base).toUpperCase();
};

// pick a random number within a range of numbers
// int b rand(int a); where 0 <= b <= a
UUID.rand = function(max){
	return Math.floor(Math.random() * (max + 1));
};

// end of UUID class file

// ----------------uuid file end-----------------------//

// -----------------cookies file -----------------------//
function CookieClass()
{
	this.expires = 60*24*7 ; // 有效时间,以分钟为单位
	this.path = ""; // 设置访问路径
	this.domain = ""; // 设置访问主机
	this.secure = false; // 设置安全性

	this.setCookie = function(name,value)
	{ 
	   var str = name+"="+escape(value); 
	   if (this.expires>0)
	   { 
	    // 如果设置了过期时间
	    var date=new Date(); 
	    var ms=this.expires * 60 * 1000; // 每分钟有60秒，每秒1000毫秒
	    date.setTime(date.getTime()+ms); 
	    str+="; expires="+date.toGMTString(); 
	   } 
	   str+="; path=/";
	   // if(this.path!="")str+="; path=/";//+this.path; //设置访问路径
	   if(this.domain!="")str+="; domain="+this.domain; // 设置访问主机
	   if(this.secure!="")str+="; true"; // 设置安全性
	   document.cookie=str; 
	};

	this.getCookie=function(name)
	{ 
	   var cookieArray=document.cookie.split("; "); // 得到分割的cookie名值对
	   // var cookie=new Object();
	   for(var i=0;i<cookieArray.length;i++)
	   { 
	    var arr=cookieArray[i].split("="); // 将名和值分开
	    if(arr[0]==name)return unescape(arr[1]); // 如果是指定的cookie，则返回它的值
	   } 
	   return ""; 
	};

	this.deleteCookie=function(name)
	{ 
	   var date=new Date(); 
	   var ms= 1 * 1000; 
	   date.setTime(date.getTime() - ms); 
	   var str = name+"=no; expires=" + date.toGMTString(); // 将过期时间设置为过去来删除一个cookie
	   document.cookie=str; 
	};

	this.showCookie=function()
	{ 
	   alert(unescape(document.cookie)); 
	};
}

// 使用例子
// var cook = new CookieClass();
// cook.expires =1;//一分钟有效
// cook.setCookie("01","5556666666666555");//写
// alert(cook.getCookie("01"));//读
// cook.showCookie();

// -----------------cookies file end-----------------------//




/*
 * //imgLoad("imgLoad"); //imgLoad("windowImg","li",1); 参数1为图片所在模块
 * 参数2为图片所在循环元素；不写默认为“li” 参数3为window滚动触发事件，这个参数存在时必须填写参数2；不写默认为模块滚动触发事件 //鼠标滚轮事件
 */

  // ----------图片延时加载-------------//
function imgLoad(o,tags,f){
 var d=document,
 doc = d[d.compatMode == "CSS1Compat"?'documentElement':'body'],
 o=d.getElementById(o),
 tags=tags?tags:"li";
 if(!o){return false;}
  var j,s=o.getElementsByTagName("img"),
  e=o.getElementsByTagName(tags),
  topnum = (navigator.userAgent.indexOf("WebKit")==-1)?d.documentElement:d.body,
  autoLength = o.getElementsByTagName(tags)[0].getElementsByTagName("img").length,
  autoMarL = (!-[1,])?(parseInt(getStyle(e[0],"marginLeft"))):(parseInt(getStyle(e[0],"margin-left"))),
  autoMarR = (!-[1,])?(parseInt(getStyle(e[0],"marginRight"))):(parseInt(getStyle(e[0],"margin-right"))),
  autoMarT = (!-[1,])?(parseInt(getStyle(e[0],"marginTop"))):(parseInt(getStyle(e[0],"margin-top"))),
  autoMarB = (!-[1,])?(parseInt(getStyle(e[0],"marginBottom"))):(parseInt(getStyle(e[0],"margin-bottom"))),
  autoHeight = e[0].offsetHeight + autoMarT + autoMarB,
  autoWidth = e[0].offsetWidth + autoMarL + autoMarR,
  maxHeight = o.offsetHeight -16,
  maxWidth = o.offsetWidth - 16;
 var autoLoad = function(){
  var maxWindow = doc.clientHeight,
  sObj=new getXYWH(o);
  j = f?Math.ceil((maxWindow - sObj.showT)/autoHeight)*Math.ceil(maxWidth/autoWidth)*autoLength:Math.ceil(maxHeight/autoHeight)*Math.ceil(maxWidth/autoWidth)*autoLength;
  j = (j < 0) ? 0 : j;
  j = (j < s.length) ? j : s.length;
  /* 默认显示图片 */
  for(var i=0;i<j;i++){
  s[i].src = s[i].getAttribute("docsrc");
  }
 };
 /* 滚动显示 */
 var scrollLoad = function(){
  var activeHeight = f?topnum.scrollTop:o.scrollTop,
  activeWidth = f?topnum.scrollLeft:o.scrollLeft,
  m= (Math.ceil(activeHeight/autoHeight)*Math.ceil(maxWidth/autoWidth) + Math.ceil(activeWidth/autoWidth)*Math.ceil(maxHeight/autoHeight))*autoLength,
  n=((m+j)>e.length)?e.length:(m+j);
  for(var i = j;i<n;i++){
   s[i].src = s[i].getAttribute("docsrc");
   if(s[(e.length-1)].src!==""){
    break;
   }
  }
 };
 (f?window:o).onscroll = function(){
  scrollLoad();
 };
 /* 重新计算 */
 window.onresize = function(){
  autoLoad();
  scrollLoad();
 };
 autoLoad();
}

var availableTagsDef = ["@qq.com","@163.com","@126.com","@sina.com","@gmail.com","@foxmail.com","@sohu.com","@vip.qq.com","@hotmail.com","@163.net","@sina.com.cn","@139.com","@189.cn"];
var availableTags = ["@qq.com","@163.com","@126.com","@sina.com","@gmail.com","@foxmail.com","@sohu.com","@vip.qq.com","@hotmail.com","@163.net","@sina.com.cn","@139.com","@189.cn"];
function emailOnkeyUp(obj){
	for ( var i = 0; i < availableTags.length; i++) {
		var reg = new RegExp(/^[a-zA-Z0-9_]{1,}$/);
		if(reg.test(obj.value)){
			availableTags[i] = obj.value+availableTagsDef[i];
		}
	}
}

function showDialog(id){
	if(id == 0){
		document.getElementById("loginDialog").style.display="block";
		document.getElementById("regDialog").style.display="none";
		document.getElementById("regLi").className="";
		document.getElementById("loginLi").className="cur";
		document.getElementById("loginUserName").focus();
		callbackEnter(loginSubmit);
		jQuery("#loginUserName").autocomplete({
			source: availableTags,
			autoFocus:false,
			matchContains:true,
			minLength:1
		});
	}else {
		document.getElementById("regDialog").style.display="block";
		document.getElementById("loginDialog").style.display="none";
		document.getElementById("regLi").className="cur";
		document.getElementById("loginLi").className="";
		callbackEnter(regSubmit);
		jQuery("#regUserName").autocomplete({
			source: availableTags,
			autoFocus:false,
			matchContains:false,
			minLength:1
		});
	}
}
function loginout(){
	var url = "/open/logout?random="+Math.round(Math.random()*100);
	jQuery.get(url,function(res){
		if(res){
			window.location.href="index.jsp";
		}
	});
}
function loginSubmit(){
	if(checkLoginUserName() && checkLoginPassword()){
		var url = "/open/login?random="+Math.round(Math.random()*100);
		var uName = document.getElementById("loginUserName").value;
		var pWord = document.getElementById("loginPassword").value;
		var longLogin = 0;
// if(document.getElementById("longLogin")!=null &&
// document.getElementById("longLogin").checked){
// longLogin = 1;
// }
// var param={email:uName,password:pWord,longLogin:longLogin};
		var param={mobile:uName,password:pWord};
		jQuery.post(url,param,function(data){
			if(data) {
				if(data.ret == 0) {
					if(document.getElementById("forwardUrl")!=null && document.getElementById("forwardUrl").value != ""){
						var forward = document.getElementById("forwardUrl").value;
						forward = decodeURI(forward);
						window.location.href=forward;
					} else {
						// if(data.data) {
						window.location.href="/index.jsp";
// } else {
// window.location.href="/userinfo.jsp";
// }
					}
				} else if(data.ret == 601) {
					document.getElementById("loginTips").style.display="block";
					document.getElementById("loginTips").innerHTML="";
					document.getElementById("loginTips").innerHTML="用户名或密码错误!";
				} else if(data.ret == 603) {
					document.getElementById("loginTips").style.display="block";
					document.getElementById("loginTips").innerHTML="";
					document.getElementById("loginTips").innerHTML="用户已经冻结,请与管理员联系!";
				} else if(data.ret == 608) {
					document.getElementById("loginTips").style.display="block";
					document.getElementById("loginTips").innerHTML="";
					document.getElementById("loginTips").innerHTML="用户未激活,请登录邮箱进行激活!";
				}
			} else {
				
			}
			/**
			 * var result = eval('(' + data + ')'); if(result!=null){
			 * if(result.resultCode == 0){
			 * if(document.getElementById("forwardUrl")!=null &&
			 * document.getElementById("forwardUrl").value != ""){ var forward =
			 * document.getElementById("forwardUrl").value; forward =
			 * decodeURI(forward); window.location.href=forward; }else{ var
			 * whref = document.location.href; if(whref.indexOf("#") != -1){
			 * whref = whref.substring(0,whref.indexOf("#")); } if(whref.length <
			 * 30){ whref =
			 * document.getElementById("coinMainUrl").value+"/btc.jsp"; }
			 * window.location.href=whref; } }else if(result.resultCode == -1){
			 * document.getElementById("loginTips").style.display="block";
			 * document.getElementById("loginTips").innerHTML="";
			 * document.getElementById("loginTips").innerHTML="用户名或密码错误"; }else
			 * if(result.resultCode == -2){
			 * document.getElementById("loginTips").style.display="block";
			 * document.getElementById("loginTips").innerHTML="";
			 * document.getElementById("loginTips").innerHTML="此ip登录频繁，请2小时后再试";
			 * }else if(result.resultCode == -3){
			 * document.getElementById("loginTips").style.display="block";
			 * document.getElementById("loginTips").innerHTML="";
			 * if(result.errorNum == 0){
			 * document.getElementById("loginTips").innerHTML="此ip登录频繁，请2小时后再试";
			 * }else{
			 * document.getElementById("loginTips").innerHTML="用户名或密码错误，您还有"+result.errorNum+"次机会"; }
			 * document.getElementById("loginPassword").value=""; }else
			 * if(result.resultCode == -4){
			 * document.getElementById("loginTips").style.display="block";
			 * document.getElementById("loginTips").innerHTML="";
			 * document.getElementById("loginTips").innerHTML="您的浏览器还未开启COOKIE,请设置启用COOKIE功能";
			 * }else if(result.resultCode == 1){ window.location.href =
			 * document.getElementById("coinMainUrl").value; }else
			 * if(result.resultCode == 2){
			 * document.getElementById("loginTips").style.display="block";
			 * document.getElementById("loginTips").innerHTML="";
			 * document.getElementById("loginTips").innerHTML="账户出现安全隐患被冻结，请尽快联系客服。"; } }
			 */
		});	
	}
}
/**
 * 是否登录完成后跳转页面
 */
function isForward(){
	if(document.getElementById("forwardUrl")!=null){
		var forward = document.getElementById("forwardUrl").value;
		if(forward != ""){
			showlogin(0);
		}
	}
	
}
function loginNameOnblur(){
	var uName = document.getElementById("loginUserName").value;
	if(! checkEmail(uName)){
		document.getElementById("loginTips").style.display="block";
		document.getElementById("loginTips").innerHTML="";
		document.getElementById("loginTips").innerHTML="邮箱格式不正确";
		if(document.getElementById('loginUserName') != null){
			document.getElementById('loginUserName').className='load-1';
		}
	}else{
		document.getElementById("loginTips").innerHTML="&nbsp;";
	}
}
function checkLoginUserName(){
	var uName = document.getElementById("loginUserName").value;
	if(uName == ""){
		document.getElementById("loginTips").style.display="";
		document.getElementById("loginTips").innerHTML="";
		document.getElementById("loginTips").innerHTML="用户名不能为空";
		return false;
	}
	/*
	 * else if(! checkMobile(uName)){
	 * document.getElementById("loginTips").style.display="";
	 * document.getElementById("loginTips").innerHTML="号码格式不正确"; return false; }
	 */
	document.getElementById("loginTips").innerHTML="";
	return true;
}

function checkLoginPassword(){
	var password = document.getElementById("loginPassword").value;
	if(password == ""){
		document.getElementById("loginTips").style.display="block";
		document.getElementById("loginTips").innerHTML="";
		document.getElementById("loginTips").innerHTML="密码不能为空";
		return false;
	}else if(password.length <6){
		document.getElementById("loginTips").style.display="block";
		document.getElementById("loginTips").innerHTML="";
		document.getElementById("loginTips").innerHTML="密码长度不能小于6！";
		return false;
	}
	document.getElementById("loginTips").innerHTML="";
	return true;
}
function termsService(){
	if(!document.getElementById("agree").checked){
		document.getElementById("regBtn").disabled=true;
		document.getElementById("regBtn").className="falsebutton buttonfalse";
	}else{
		document.getElementById("regBtn").disabled=false;
		document.getElementById("regBtn").className="button-dialog";
	}
}
function useRegType(id){
	var str = "" ;
	var tips = "";
	var tipsInfo = "";
	if(id == 0){
		str = "<span class='orange'>*</span>手机号:";
		tips = "没有手机号？<a href='javascript:useRegType(1);'  >用邮箱注册</a>";
		tipsInfo = "请输入11位数字";
	}else{
		str = "<span class='orange'>*</span>电子邮箱:";
		tips = "没有电子邮箱？<a href='javascript:useRegType(0);'  >用手机注册</a>";
		tipsInfo = "请输入你的常用邮箱";
	}
	
	document.getElementById("regUserNameSpan").innerHTML="";
	document.getElementById("regUserNameSpan").innerHTML=str;
	document.getElementById("regUserNameTips").innerHTML="";
	document.getElementById("regUserNameTips").innerHTML=tips;
	document.getElementById("regType").value=id;
	document.getElementById("regUserName").value="";
	document.getElementById("regUserName").focus();
	document.getElementById("regNameResult").innerHTML=tipsInfo;
	document.getElementById("regNameResult").className="";
}
// 验证注册名
function checkRegUserName(){
	var regType = document.getElementById("regType").value;
	var regUserName = trim(document.getElementById("regUserName").value);
	var desc='';
	if(regType == 0){
		// 验证手机号
		if(regUserName.indexOf(" ")>-1){
			desc='手机号包含空格!';
		}else {
			if(regUserName==''){
					desc='请您输入手机号!'; 	
				}
			else if(!checkMobile(regUserName)){ 
					desc='手机号格式不正确';	
			}
		}
	}else{
		// 验证邮箱
		if(regUserName.indexOf(" ")>-1){
			desc='邮箱不能包含空格!';
		}else {
			if(regUserName==''){	desc='请您输入邮箱!'; 	}
			else if(!checkEmail(regUserName)){ desc='邮箱格式不正确,请重新输入';	}
			else if (new RegExp("[,]","g").test(regUserName)){ desc='含有非法字符'; }
			else if(regUserName.length>100){	desc='邮箱长度应小于100个字符';	}
			var regokcoin = /^([a-zA-Z0-9_-])+@okcoin+(.[a-zA-Z0-9_-])+/; 
			if(regokcoin.test(regUserName.toLowerCase())){ desc='请输入真实邮箱';	}
		}
	}
	if(desc!=""){
		document.getElementById("regNameResult").className="error orange";
		document.getElementById("regNameResult").innerHTML="";
		document.getElementById("regNameResult").innerHTML=desc;
		return ;
	}else{
		document.getElementById("regNameResult").className="success";
		document.getElementById("regNameResult").innerHTML="";
	}
	var url = "/open/chcekregname?email=" + encodeURI(regUserName) +"&type="+regType+"&random="+Math.round(Math.random()*100);
	jQuery.get(url,null,function(data){
		if(data.ret != 0){
			if(regType == 0){
				desc = "您的手机号已存在，如果这是您自己的手机号，请<a target='_blank' href='http://wpa.qq.com/msgrd?v=3&uin=888888888&site=qq&menu=yes' title='联系QQ:888888888'>联系客服</a>";
			}else{
				desc = "邮箱已存在";
			}
			document.getElementById("regNameResult").className="error orange";
			document.getElementById("regNameResult").innerHTML="";
			document.getElementById("regNameResult").innerHTML=desc;
			return ;
		}
		else{
		}
	});
}
function checkPassword(){
	var pwd = trim(document.getElementById("regPassword").value);
	var desc='';
	var c = new RegExp();   
	c = /^[A-Za-z0-9_-]+$/;  
	if(pwd == ""){
		desc="请输入密码！";
	}else if(pwd.length <6){
		desc="密码长度不能小于6！";
	}else if(pwd.length>16){
		desc="密码长度不能大于16！";
	}
	if(desc!=""){
		$("#regPassword_error").html(desc);
		$("#regPassword").focus();
		return false;
	}else{
		$("#regPassword_error").html("");
	}
	return true;
}
	function checkRePassword(){
		var pwd = trim(document.getElementById("regPassword").value);
		var rePwd = trim(document.getElementById("regRePassword").value);
		var desc='';
		if(rePwd == ""){
			desc="再输入一遍新密码！";
		}else if(rePwd.length <6){
			desc="密码长度不能小于6！";
		}else if(pwd.length>16){
			desc="密码长度不能大于16！";
		}else if(pwd != rePwd){
			desc="输入的密码不一致！";
		}
		if(desc!=""){
			$("#regRePassword_error").html(desc);
			$("#regRePassword").focus();
			return false;
		}else{
			$("#regRePassword_error").html("");
		}
		return true;
	}
	function checkRegUserNameNoJquery(){
		var regType = document.getElementById("regType").value;
		var regUserName = trim(document.getElementById("regUserName").value);
		var desc='';
		if(regType == 0){
			// 验证手机号
			if(regUserName.indexOf(" ")>-1){
				swal("错误", "手机号包含空格!", "error");
				return;
			}else {
				if(regUserName==''){
					swal("错误", "请您输入手机号!", "error");
					return;
					}
				else if(!checkMobile(regUserName)){ 
						swal("错误", "手机号格式不正确", "error");
						return;
				}
			}
		}else{
			// 验证邮箱
			if(regUserName.indexOf(" ")>-1){
				swal("错误", "邮箱不能包含空格!", "error");
				return;
			}else {
				if(regUserName==''){swal("错误", "请您输入邮箱!", "error");
				return;}
				else if(!checkEmail(regUserName)){swal("错误", "邮箱格式不正确,请重新输入", "error");
				return;}
				else if (new RegExp("[,]","g").test(regUserName)){swal("错误", "含有非法字符", "error");
				return;}
				else if(regUserName.length>100){swal("错误", "邮箱长度应小于100个字符", "error");
				return;}
			}
		}
		if(desc!=""){
			document.getElementById("regNameResult").style.display="";
			document.getElementById("regNameResult").className="bg-danger";
			document.getElementById("regNameResult").innerHTML=desc;
			return false;
		}else{
			document.getElementById("regNameResult").style.display="none";
			return true;
		}
	}
// var wait=60;
// function time(o) {
// if (wait == 0) {
// o.removeAttribute("disabled");
// o.innerHTML="发送验证码";
// wait = 60;
// } else {
// o.setAttribute("disabled", true);
// o.innerHTML=wait+"秒后重新发送";
// wait--;
// setTimeout(function() {
// time(o)
// },
// 1000)
// }
// }
// function sendVCode(self){
// var regUserName = trim(document.getElementById("regUserName").value);
// $("#sendValidate").html("成功发送");
// if(checkRegUserNameNoJquery()){
// var urlName = "/open/chcekregname?mobile=" + encodeURI(regUserName)
// +"&type="+regType+"&random="+Math.round(Math.random()*100);
// jQuery.get(urlName,null,function(data){
// if(data.ret == 606){
// if(regType == 0){
// desc = "您的手机号已存在，如果这是您自己的手机号，请<a target='_blank'
// href='http://wpa.qq.com/msgrd?v=3&uin=888888888&site=qq&menu=yes'
// title='联系QQ:888888888'>联系客服</a>";
// }else{
// desc = "邮箱已存在";
// }
// document.getElementById("regNameResult").style.display="";
// document.getElementById("regNameResult").className="bg-danger";
// document.getElementById("regNameResult").innerHTML="";
// document.getElementById("regNameResult").innerHTML=desc;
// return ;
// }
// });
// }
// }
//	
// //***************************************************************************************************************//
//	
// var count = 0;
// document.getElementById("btn").onclick=function(){
// if(count<3){
// sendmsg();
// count++;
// time(this);
// }else{
// this.setAttribute("disabled", true);
// this.value="对不起，您发送太频繁";
// }
// }
// var msg = null;
// function sendmsg() {
// if (window.XMLHttpRequest) {
// msg = new XMLHttpRequest();
// } else if (window.ActiveXObject) {
// msg = new ActiveXObject("Microsoft.XMLHTTP");
// }
// if (msg != null) {
// var tel = document.getElementById('uphone').value;
// if(tel==''||tel==null){alert('请输入手机号码');return false;}
// var url = 'msg.htm?send2&tel='+tel+'&n=' + Math.random();
// msg.onreadystatechange = showmsg;
// msg.open("GET", url, true);
// msg.send(null);
// }
// }
	// ***************************************************************************************************************//
	function checkUserNameExist(){
		var regType = document.getElementById("regType").value;
		var regUserName = trim(document.getElementById("regUserName").value);
		var roleType=$("#roleType").val();
		if(roleType==2){
			var regUname=/^(([a-z]+[0-9]+)|([0-9]+[a-z]+))[a-z0-9]*$/i;
			if(!regUname.test(regUserName)){
				$("#regUserName_error").html("商家用户名必须为数字和字母的组合");
				$("#regUserName").focus();
			   return;
			}else{
				$("#regUserName_error").html("");
			}
		}
		var urlName = "/open/chcekregname?mobile=" + encodeURI(regUserName) +"&type="+regType+"&random="+Math.round(Math.random()*100);
		jQuery.get(urlName,null,function(data){
			if(data.ret == 606){
				if(regType == 0){
					var desc="";
					if(roleType==1){
						desc="您输入的账号已注册";
					}else{
						desc="该商户名存在，请重新输入";
					}
					$("#regUserName_error").html(desc);
					$("#regUserName").focus();
					return;
				}else{
					$("#regUserName_error").html("邮箱已存在");
					$("#regUserName").focus();
					return;
				}
				return ;
			}else{
				return;
			}
		});
	}
	
	var mobile2Exist=false;
	function checkMobile2Exist(){
		var mobile2 = trim(document.getElementById("mobile2").value);
		var urlName = "/open/chcekmobile2?mobile2=" + encodeURI(mobile2) +"&random="+Math.round(Math.random()*100);
		jQuery.get(urlName,null,function(data){
			if(data.ret == 606){
				var desc="该手机号已使用";
				swal("错误", desc, "error");
				$("#mobile2").val("");
				 $("#mobile2").focus();
				 mobile2Exist=true;
			}else{
				mobile2Exist=false;
			}
		});
	}
	var LicenceNumberExist=false;
	function chcekLicenceNumber(){
		document.getElementById("oid").value=document.getElementById("oid").value.replace(/\D/g,'');
		var oid = trim(document.getElementById("oid").value);
		if(oid.length<12){
			desc="请输入正确的营业执照注册号";
			$("#oid_error").html(desc);
			$("#oid").focus();
			LicenceNumberExist=true;
			return;
		}
		var urlName = "/open/chcekLicenceNumber?licenceNumber=" + encodeURI(oid) +"&random="+Math.round(Math.random()*100);
		jQuery.get(urlName,null,function(data){
			if(data.ret == 606){
				var desc="";
				desc="该营业执照已存在，请重新输入";
				$("#oid_error").html(desc);
				$("#oid").focus();
				LicenceNumberExist=true;
			}else{
				$("#oid_error").html("");
				LicenceNumberExist=false;
			}
		});
	}
	function checkIdentity_noExist(){
		$("#msg0").html();
		$(".form-control").removeClass("error_form");
		var identity_no=$("#identity_no").val();
		if(identity_no.length<15){
			desc="请输入正确的身份证号";
			$("#msg0").html(desc);
			$("#identity_no").addClass("error_form");
			$("#identity_no").focus();
			$("#bindCardBtn").attr("disabled","disabled");
			return;
		}
		var urlName = "/open/chcekIdentity_no?identity_no=" + encodeURI(identity_no) +"&random="+Math.round(Math.random()*100);
		jQuery.get(urlName,null,function(data){
			if(data.ret == 606){
				var desc="";
				desc="该身份证已存在";
				$("#msg0").html(desc);
				$("#identity_no").addClass("error_form");
				$("#identity_no").focus();
				$("#bindCardBtn").attr("disabled","disabled");
			}else{
				$("#msg0").html("");
				$("#bindCardBtn").attr("disabled",false);
			}
		});
	}
	/**
	 * 用户注册
	 */
	function regSubmit(){
		$("#userSubmitBtn").attr("disabled",true);
		//检测验证码是否输入
		var kaptchafield=$("#kaptchafield").val();
		if(kaptchafield==""||kaptchafield==null||kaptchafield.length<4){
			$("#kaptchafield_error").html("请输入正确的验证码");
			$("#userSubmitBtn").attr("disabled",false);
			return;
		}else{
			$("#kaptchafield_error").html("");
		}
		// 普通用户注册
		var roleType=$("#roleType").val();
		if(!$(".icheckbox_square").hasClass("checked")){
			swal("错误", "请同意注册协议", "error");
			$("#userSubmitBtn").attr("disabled",false);
			return;
		}
		var regUserName = trim(document.getElementById("regUserName").value);
		if(regUserName==""||regUserName==null){
			$("#regUserName_error").html("注册名不能为空");
			$("#regUserName").focus();
			$("#userSubmitBtn").attr("disabled",false);
			return;
		}
		if(checkPassword() && checkRePassword() ){
			var index = regUserName.lastIndexOf(".", 0);
			var end = regUserName.substring(index, regUserName.length);
			if(end.length == 2 && "cn" != end){
				if(!confirm(regUserName+"  这个邮箱名字可能不正确，您确定么？")){
					$("#userSubmitBtn").attr("disabled",false);
					return;
				}
			}
			var regType = document.getElementById("regType").value;
			var r=0;
			if(document.getElementById("recommended_user_id")){
				r = document.getElementById("recommended_user_id").value;
			}
			var pwd = trim(document.getElementById("regPassword").value);
			// 检查用户名
			var urlName = "/open/chcekregname?mobile=" + encodeURI(regUserName) +"&type="+regType+"&random="+Math.round(Math.random()*100);
			jQuery.get(urlName,null,function(data){
				if(data.ret == 606){
					if(regType == 0){
						var desc="";
						if(roleType==1){
							desc="您输入的账号已注册";
						}else{
							desc="该商户名存在，请重新输入";
						}
						$("#regUserName_error").html(desc);
						$("#regUserName").focus();
						$("#userSubmitBtn").attr("disabled",false);
						return;
					}else{
						$("#regUserName_error").html("邮箱已存在");
						$("#regUserName").focus();
						$("#userSubmitBtn").attr("disabled",false);
						return;
					}
					return ;
				}
				else{
					// 如果roleType==2则需要校验商家字段：local local2 licenceFileName
					// licenceFileURL (not null)
					var url = "/open/reg?random="+Math.round(Math.random()*100);
					 var param={mobile:regUserName,password:pwd,regType:regType,r:r,role:roleType,local:0,local2:0,local3:0,kaptchafield:kaptchafield};
					jQuery.post(url,param,function(data2){
						if(data2.ret != 0){
							var desc = "";
							// 注册失败
							if(data2.ret == 606){
								if(regType == 0){
									var desc="";
									if(roleType==1){
										desc="您输入的账号已注册";
									}else{
										desc="该商户名存在，请重新输入";
									}
									$("#regUserName_error").html(desc);
									$("#regUserName").focus();
									$("#userSubmitBtn").attr("disabled",false);
									return;
								}else{
									$("#regUserName_error").html("邮箱已存在");
									$("#regUserName").focus();
									$("#userSubmitBtn").attr("disabled",false);
									return;
								}
							}else if(data2.ret == 612){
								$("#regUserName_error").html("请填写真实邮箱");
								$("#regUserName").focus();
								$("#userSubmitBtn").attr("disabled",false);
								return;
							}else if(data2.ret == 618){
								$("#regUserName_error").html("远程服务器请求失败");
								$("#regUserName").focus();
								$("#userSubmitBtn").attr("disabled",false);
								return;
							}else if(data2.ret==620){
								$("#kaptchafield_error").html("验证码输入错误");
								$("#kaptchafield").focus();
								$("#userSubmitBtn").attr("disabled",false);
								return;
							}
						}
						else{
							window.location.href="http://mp.weixin.qq.com/s?__biz=MzA4OTE5ODg3MA==&mid=203064888&idx=1&sn=e09232e6bbf4757126add166313352ee#rd";
						}
					});	
				}
			});
		}else{
			$("#shoperSubmitBtn").attr("disabled",false);
			return;
		}
	}
	/**
	 * 商户注册
	 */
	function shoperRegSubmit(){
		$("#shoperSubmitBtn").attr("disabled",true);
		//检测验证码是否输入
		var kaptchafield=$("#kaptchafield").val();
		if(kaptchafield==""||kaptchafield==null||kaptchafield.length<4){
			$("#kaptchafield_error").html("请输入正确的验证码");
			$("#shoperSubmitBtn").attr("disabled",false);
			return;
		}else{
			$("#kaptchafield_error").html("");
		}
		chcekLicenceNumber();
		$(".form-control").removeClass("error_form");
		var roleType=$("#roleType").val();
		var mobile2=$("#mobile2").val();
		if(!checkMobile(mobile2)){
			$("#mobile2_error").html("请输入正确的手机号");
			$("#mobile2").focus();
			$("#shoperSubmitBtn").attr("disabled",false);
			return;
		}else{
			$("#mobile2_error").html("");
		}
		if(LicenceNumberExist){
			$("#oid_error").html("营业执照错误");
			$("#oid").focus();
			$("#shoperSubmitBtn").attr("disabled",false);
			return
		}else{
			$("#oid_error").html("");
		}
		if(!$(".icheckbox_square").hasClass("checked")){
			swal("错误", "请同意注册协议", "error");
			$("#shoperSubmitBtn").attr("disabled",false);
			return;
		}
		var regUserName = trim(document.getElementById("regUserName").value);
		var regUname=/^(([a-z]+[0-9]+)|([0-9]+[a-z]+))[a-z0-9]*$/i;
		if(!regUname.test(regUserName)){
		   $("#regUserName_error").html("商家用户名必须为数字和字母的组合");
		   $("#regUserName").focus();
		   $("#shoperSubmitBtn").attr("disabled",false);
		   return;
		}else{
			$("#regUserName_error").html("");
		}
		if(regUserName==""||regUserName==null){
			$("#regUserName_error").html("请填写正确的用户名");
			$("#regUserName").focus();
			$("#shoperSubmitBtn").attr("disabled",false);
			return;
		}else{
			$("#regUserName_error").html("");
		}
		var licenceRegName=$("#licenceRegName").val();
		if(!checkNotNull(licenceRegName)){
			$("#licenceRegName_error").html("请填写正确的营业执照注册名");
			$("#licenceRegName").focus();
			$("#shoperSubmitBtn").attr("disabled",false);
			return;
		}else{
			$("#licenceRegName_error").html("");
		}
		var manager=$("#manager").val();
		if(!checkNotNull(manager)){
			$("#manager_error").html("请填写正确的负责人");
			$("#manager").focus();
			$("#shoperSubmitBtn").attr("disabled",false);
			return;
		}
		if(checkPassword() && checkRePassword() ){
			var regUserName = trim(document.getElementById("regUserName").value);
			var regType = document.getElementById("regType").value;
			var r=0;
			if(document.getElementById("recommended_user_id")){
				r = document.getElementById("recommended_user_id").value;
			}
			var pwd = trim(document.getElementById("regPassword").value);
			// 检查用户名
			var urlName = "/open/chcekregname?mobile=" + encodeURI(regUserName) +"&type="+regType+"&random="+Math.round(Math.random()*100);
			jQuery.get(urlName,null,function(data){
				if(data.ret == 606){
					if(regType == 0){
						$("#regUserName_error").html("用户名已存在，请重新输入");
						$("#regUserName").focus();
						$("#shoperSubmitBtn").attr("disabled",false);
						return;
					}else{
						$("#regUserName_error").html("邮箱已存在");
						$("#regUserName").focus();
						$("#shoperSubmitBtn").attr("disabled",false);
						return;
					}
					return ;
				}
				else{
					var oid = trim(document.getElementById("oid").value);
					// 如果roleType==2则需要校验商家字段：local local2 licenceFileName
					// licenceFileURL (not null)
					var local=0;
					var local2=0;
					var local3=0;
					var licenceFileName="";
					var licenceFileURL="";
					var licenceNumber="";
					var shopName="";
					
					local=$("#local").val();
				    local2=$("#local2").val();
				    local3=$("#local3").val();
			   	    licenceFileName=$("#licenceFileName").val();
					licenceFileURL=$("#licenceFileURL").val();
				    licenceNumber=$("#oid").val();
					shopName=$("#shopName").val();
					 if(local==0||local2==0||local3==0){
						 desc="请确认选择所在地区";
						 $("#local_error").html(desc);
				    	$("#local").addClass("error_form");
				    	$("#local2").addClass("error_form");
				    	$("#local3").addClass("error_form");
				    	$("#shoperSubmitBtn").attr("disabled",false);
				        return ;
					 }else{
						 $("#local_error").html("");
					 }
				    if(!checkNotNull(shopName)){
				    	desc="请输入商铺名";
				    	$("#shopName_error").html(desc);
				    	$("#shopName").focus();
				    	$("#shoperSubmitBtn").attr("disabled",false);
				    	return;
				    }else{
				    	$("#shopName_error").html("");
				    }
				    if(!checkNotNull(licenceNumber)){
				    	desc="请输入营业执照注册号";
				    	$("#oid_error").html(desc);
				    	$("#oid").focus();
				    	$("#shoperSubmitBtn").attr("disabled",false);
				    	return;
				    }else{
				    	$("#oid_error").html("");
				    }
					var url = "/open/reg?random="+Math.round(Math.random()*100);
					var param={mobile:regUserName,password:pwd,regType:regType,r:r,role:roleType,local:local,local2:local2,local3:local3,licenceFileName:licenceFileName,licenceFileURL:licenceFileURL,licenceNumber:licenceNumber,shopName:shopName,mobile2:mobile2,licenceRegName:licenceRegName,manager:manager,name:manager,kaptchafield:kaptchafield};
					jQuery.post(url,param,function(data2){
						if(data2.ret != 0){
							var desc = "";
							// 注册失败
							if(data2.ret == 606){
								if(regType == 0){
									$("#regUserName_error").html("您输入的账号已注册");
									$("#regUserName").focus();
									$("#shoperSubmitBtn").attr("disabled",false);
									return;
								}else{
									$("#regUserName_error").html( "邮箱已存在");
									$("#regUserName").focus();
									$("#shoperSubmitBtn").attr("disabled",false);
									return;
								}
							}else if(data2.ret == 612){
								$("#regUserName_error").html( "请填写真实邮箱");
								$("#regUserName").focus();
								$("#shoperSubmitBtn").attr("disabled",false);
								return;
							}else if(data2.ret == 618){
								$("#regUserName_error").html( "远程服务器请求失败");
								$("#regUserName").focus();
								$("#shoperSubmitBtn").attr("disabled",false);
								return;
							}else if(data2.ret==614){
								desc="商家注册手机号已存在";
								$("#mobile2_error").html(desc);
								$("#mobile2").focus();
								$("#shoperSubmitBtn").attr("disabled",false);
								return;
							}else if(data2.ret==620){
								$("#kaptchafield_error").html("验证码输入错误");
								$("#kaptchafield").focus();
								$("#shoperSubmitBtn").attr("disabled",false);
								return;
							}
						}else{
							swal({
		                         title: "注册成功",  
		                         text: "请关注我们的公众号【点头财神】",  
		                         type: "success",  
		                         showCancelButton: false,  
		                         confirmButtonColor: "#A7D5EA",  
		                         confirmButtonText: "确认" },
		                         function(){  
		                        	 window.location.href="http://mp.weixin.qq.com/s?__biz=MzA4OTE5ODg3MA==&mid=203064888&idx=1&sn=e09232e6bbf4757126add166313352ee#rd";
	                         });
						}
					});	
				}
			});
		}else{
			$("#shoperSubmitBtn").attr("disabled",false);
			return;
		}
	}
	function cart_add_animate(b){
		b=$(b);
		if(typeof b!="undefined"){
			var a=jQuery(window).height()-(jQuery(b).offset().top-jQuery(window).scrollTop())-100;
			if(a<200){a=200;}
			// alert(jQuery(b).offset().left);
			// alert(a);
			jQuery("#cart-add-effect").css({left:jQuery(b).offset().left,bottom:a});
			jQuery("#cart-add-effect").show().animate(
					{bottom:"10px",opacity:0},
					800,
					function(){
						jQuery("#cart-add-effect").css({bottom:"200px",opacity:1,display:"none"});
					}
				);
			
		}
	}
	
/** *******微博登录********************* */
	function openss(url){
		if(url==null || url==''){
			url=window.location.href;
		}
		var host = window.location.host;
	    window.open('https://api.weibo.com/oauth2/authorize?client_id=123456&redirect_uri=http://' + host + '/woauth&response_type=code','new','height='+450+',,innerHeight='+450+',width='+550+',innerWidth='+550+',top='+200+',left='+200+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
	}
/** *******QQ登录****************************** */	
	function openqq(url){
		if(url==null||url==""){
			url=window.location.href;
		}
		var host = window.location.host;
		window.open('https://open.t.qq.com/cgi-bin/oauth2/authorize?client_id=123456&response_type=code&redirect_uri=http%3A%2F%2F' + host + '%2Fqoauth','new','height='+550+',,innerHeight='+550+',width='+600+',innerWidth='+600+',top='+200+',left='+200+',toolbar=no,menubar=no,scrollbars=auto,resizeable=no,location=no,status=no');
	}
	
	/**
	 * 刷新最新行情数据
	 */
	function handleTicker(){
		/*
		 * var url = "/ticker.jsp?random="+Math.round(Math.random()*100);
		 * jQuery.post(url,null,function(data){ if(data != null){ var ticker =
		 * eval('(' + data + ')'); if(ticker!=null){ var btcLast =
		 * ticker.btcLast; var ltcLast = ticker.ltcLast; var btcVol =
		 * ticker.btcVolume; var ltcVol = ticker.ltcVolume;
		 * document.getElementById("bannerBtcLast").innerHTML=btcLast;
		 * document.getElementById("bannerLtcLast").innerHTML=ltcLast;
		 * document.getElementById("bannerBtcVol").innerHTML=btcVol;
		 * document.getElementById("bannerLtcVol").innerHTML=ltcVol; //更新首页大图成交量
		 * if(document.getElementById("indexVol")!=null){
		 * document.getElementById("indexVol").innerHTML=btcVol; }
		 * if(document.getElementById("indexLtcVol")!=null){
		 * document.getElementById("indexLtcVol").innerHTML=ltcVol; }
		 * //更新行情页最新价格 if(document.getElementById("marketLast")!=null){ var last =
		 * ticker.last+""; document.getElementById("marketLast").innerHTML=last;
		 * document.getElementById("marketBuy").innerHTML=ticker.buy;
		 * document.getElementById("marketSell").innerHTML=ticker.sell;
		 * document.getElementById("marketHigh").innerHTML=ticker.high;
		 * document.getElementById("marketLow").innerHTML=ticker.low;
		 * document.getElementById("marketVol").innerHTML=ticker.vol; //取整数和小数
		 * var firstPrice = last; var secondPrice = ".00"; var lastPrice =
		 * last.split("."); if(lastPrice!=null && lastPrice.length==2){
		 * firstPrice = lastPrice[0]; secondPrice = "."+lastPrice[1]; }
		 * document.getElementById("marketLastInteger").innerHTML="最新价格：<font
		 * class='red'>￥"+firstPrice+"</font>";
		 * document.getElementById("marketLastPoint").innerHTML=secondPrice; } } }
		 * });
		 */
	}
	/**
	 * 刷新买一卖五
	 */
	function handleEntrust(){
		var symbol = document.getElementById("symbol").value;
		var tradetype = document.getElementById("tradetype").value;
		var url = "/handleEntrust.do?symbol="+symbol+"&tradetype="+tradetype+"&random="+Math.round(Math.random()*100);
		jQuery("#coinBoxbuybtc").load(url,function (data){
			
		});
	}
	/**
	 * 发送验证码
	 * 
	 * @param type
	 */
	var secs = 121;
	function sendMsgCode(type){
		var symbol = 0;
		if(document.getElementById("symbol")!=null){
			symbol = document.getElementById("symbol").value;
		}
		if(document.getElementById("isEmptyPhone") !=null && document.getElementById("isEmptyPhone").value==1){
			showValidatePhone(1);
			if(type == 2){
				document.getElementById("withdrawBtcAddrDiv").style.display="none";
			}
			return;
		}
		var url = "/account/sendMsgCode.do?random="+Math.round(Math.random()*100);
		var withdrawAmount = 0;
		if(type == 1 && document.getElementById("withdrawAmount")!=null){
			withdrawAmount = document.getElementById("withdrawAmount").value;
			 var reg = new RegExp("^[0-9]+\.{0,1}[0-9]{0,8}$");
			 if(!reg.test(withdrawAmount) ){
			    alertTipsSpan("请输入提现金额");
				return;
			  }
			 var taskBalance = parseFloat(document.getElementById("taskBalance").value);
			 if(withdrawAmount < 0.01 && taskBalance == 0){
				alertTipsSpan("最小提现金额为：0.01"+(symbol==1?"LTC":"BTC"));
				return;
			}
		}
		if(type == 3 && document.getElementById("withdrawBalance")!=null){
			withdrawAmount = document.getElementById("withdrawBalance").value;
			var reg = new RegExp("^[0-9]+\.{0,1}[0-9]{0,8}$");
			if(!reg.test(withdrawAmount) ){
			    alertTipsSpan("请输入提现金额");
				return;
			}
			if(withdrawAmount < 10){
				alertTipsSpan(" 最小提现金额为：￥10");
				return;
			}
		}
		var withdrawBtcAddr = "";
		if(type == 2 && document.getElementById("withdrawBtcAddr")!=null){
			withdrawBtcAddr = document.getElementById("withdrawBtcAddr").value;
		}
		var param={type:type,withdrawAmount:withdrawAmount,withdrawBtcAddr:withdrawBtcAddr,symbol:symbol};
		jQuery.post(url,param,function(data){
			if(data == 0){
				if(type == 2){
					 document.getElementById("msgCodeAddrBtn").disabled = true;
					  for(var num=1;num<=secs;num++) {
						  window.setTimeout("updateNumberAddr(" + num + ")", num * 1000);
					   }
				}else if(type == 5){
					 document.getElementById("msgCodeAuthBtn").disabled = true;
					  for(var num=1;num<=secs;num++) {
						  window.setTimeout("updateNumberAuth(" + num + ")", num * 1000);
					   }
				}else if(type == 9){
					document.getElementById("msgCodeBtn2").disabled = true;
					  for(var num=1;num<=secs;num++) {
						  window.setTimeout("updateNumberBindAuth(" + num + ")", num * 1000);
					   }
				}else if(type == 10|| type == 8){
					document.getElementById("changeMsgCodeBtn").disabled = true;
					  for(var num=1;num<=secs;num++) {
						  window.setTimeout("changeMsgCode(" + num + ")", num * 1000);
					   }
				}else if(type == 14){
					document.getElementById("configureMsgCodeBtn").disabled = true;
					  for(var num=1;num<=secs;num++) {
						  window.setTimeout("configureMsgCode(" + num + ")", num * 1000);
					   }
				}else{
					 document.getElementById("msgCodeBtn").disabled = true;
					 for(var num=1;num<=secs;num++) {
						  window.setTimeout("updateNumber(" + num + ")", num * 1000);
					  }
				}
			}else if(data == -3){
				alertTipsSpan("您的余额不足！");
			}else if(data == -4){
				document.getElementById("withdrawBtcAddrTips").style.display="";
				document.getElementById("withdrawBtcAddrTips").innerHTML="请设置提现地址";
			}else if(data == -5){
				alertTipsSpan("您的余额不足！");
			}else if(data == -6){
				alertTipsSpan("最小提现金额为：0.01"+(symbol==1?"LTC":"BTC"));
			}else if(data == -7){
				alertTipsSpan("您的提现金额已超过今日提现限额，请重新输入");
			}else if(data == -8){
				alertTipsSpan("您的余额不足！");
			}else if(data == -9){
				alertTipsSpan("最小提现金额为：100元");
			}else if(data == -10){
				alertTipsSpan("您的提现金额已超过今日提现限额，请重新输入");
			}
		});
	}
	function updateNumber(num) {
		if (num == secs) {
			document.getElementById("msgCodeBtn").value="发送验证码";
			document.getElementById("msgCodeBtn").disabled = false;
			if(document.getElementById("validatePhoneNumber")!=null){
				document.getElementById("validatePhoneNumber").disabled = false;
			}
		} else {
			var printnr = secs - num;
			document.getElementById("msgCodeBtn").value= printnr +"秒后可重发";
		}
	}
	function updateNumberBindAuth(num) {
		if (num == secs) {
			document.getElementById("msgCodeBtn2").value="发送验证码";
			document.getElementById("msgCodeBtn2").disabled = false;
		} else {
			var printnr = secs - num;
			document.getElementById("msgCodeBtn2").value= printnr +"秒后可重发";
		}
	}
	function changeMsgCode(num) {
		if (num == secs) {
			document.getElementById("changeMsgCodeBtn").value="发送验证码";
			document.getElementById("changeMsgCodeBtn").disabled = false;
		} else {
			var printnr = secs - num;
			document.getElementById("changeMsgCodeBtn").value= printnr +"秒后可重发";
		}
	}
	function configureMsgCode(num) {
		if (num == secs) {
			document.getElementById("configureMsgCodeBtn").value="发送验证码";
			document.getElementById("configureMsgCodeBtn").disabled = false;
		} else {
			var printnr = secs - num;
			document.getElementById("configureMsgCodeBtn").value= printnr +"秒后可重发";
		}
	}
	
	function updateNumberAddr(num) {
		if (num == secs) {
			document.getElementById("msgCodeAddrBtn").value="发送验证码";
			document.getElementById("msgCodeAddrBtn").disabled = false;
		} else {
			var printnr = secs - num;
			document.getElementById("msgCodeAddrBtn").value= printnr +"秒后可重发";
		}
	}
	function updateNumberAuth(num) {
		if (num == secs) {
			document.getElementById("msgCodeAuthBtn").value="发送验证码";
			document.getElementById("msgCodeAuthBtn").disabled = false;
		} else {
			var printnr = secs - num;
			document.getElementById("msgCodeAuthBtn").value= printnr +"秒后可重发";
		}
	}
/**
 * 微信提示层
 */
function showWeixinPop(){
	dialogBoxShadow();
	document.getElementById("weixinPop").style.display="";
}
function closeWeixinPop(){
	dialogBoxHidden();
	document.getElementById("weixinPop").style.display="none";
}
function bindAuth(){
	var callback={okBack:function(){window.location.href= document.getElementById("coinMainUrl").value+"/security.jsp";},noBack:function(){return false;}};
	okcoinAlert("为了您的账户安全，请绑定手机或设置谷歌身份验证器！如果您不绑定，您丢失密码后可能会对您的财产造成不必要的损失，本站概不负责。",null,callback,"前往安全中心");
	if(document.getElementById('riskAreaDiv') != null){
		document.getElementById('riskAreaDiv').style.display = "block";
	}
}
function showPhoneNotOpen(){
	if(document.getElementById("phoneNotOpenDiv") != null){
		document.getElementById("phoneNotOpenDiv").style.display = "block";
	}
}

function callbackEnter(callfun){
	document.onkeydown=function(event){// 回车
    	var e = event || window.event || arguments.callee.caller.arguments[0];
        if(e && e.keyCode==13){  
        	return callfun();
        }
   }; 
}
/**
 * new
 */
function handleChart(){
	if(-1!=window.navigator.userAgent.indexOf('MSIE 6.0') || -1!=window.navigator.userAgent.indexOf('MSIE 7.0') ||-1!=window.navigator.userAgent.indexOf('MSIE 8.0')) {
		if(document.getElementById("handleChart").style.display=="none"){
			document.getElementById("handleChart").style.marginTop="0px";
			document.getElementById("handleChart").style.display="";
			showKLine(0,3);
		}else{
			document.getElementById("handleChart").style.display="none";
			document.getElementById("handleChart").style.marginTop="-400px";
		}
	}else{
		document.getElementById("handleChart").style.display="";
		if(document.getElementById("handleChart").style.opacity==0){
			jQuery("#handleChart").stop(true).animate({'margin-top':'0px','opacity':'1'},300,function(){
				if(document.getElementById("klineLoading")!=null){
					showKLine(0,3);
				}
			});
		}else{
			jQuery("#handleChart").stop(true).animate({'margin-top':'-400px','opacity':'0'},300);
		}
	}
}
function showKLineType(type){
	if(type==1){// 5分钟
		document.getElementById("minuteTitle").className ="cur";
		document.getElementById("dayTitle").className ="";
		document.getElementById("weekTitle").className ="";
	}else if(type==3){// 日
		document.getElementById("minuteTitle").className ="";
		document.getElementById("dayTitle").className ="cur";
		document.getElementById("weekTitle").className ="";
	}else if(type==4){// 周
		document.getElementById("minuteTitle").className ="";
		document.getElementById("dayTitle").className ="";
		document.getElementById("weekTitle").className ="cur";
	}
	
	var marketFrom = document.getElementById("marketFromChart").value;
	showKLine(marketFrom,type);
}
function indexLoginOnblur(){
	var uName = document.getElementById("indexLoginName").value;
	if(! checkEmail(uName)){
		document.getElementById("indexLoginTips").style.display="block";
		document.getElementById("indexLoginTips").innerHTML="";
		document.getElementById("indexLoginTips").innerHTML="邮箱格式不正确";
	}else{
		document.getElementById("indexLoginTips").style.display="none";
		document.getElementById("indexLoginTips").innerHTML="&nbsp;";
	}
}
function indexLoginNameOnblur(){
	var uName = document.getElementById("indexLoginName").value;
	if(uName=="请输入邮箱地址"){
		document.getElementById("indexLoginName").value="";
	}
}
function loginIndexSubmit(){
	
	var url = "/open/login?random="+Math.round(Math.random()*100);
	var uName = document.getElementById("indexLoginName").value;
	var pWord = document.getElementById("indexLoginPwd").value;
	if(! checkEmail(uName)){
		document.getElementById("indexLoginTips").style.display="block";
		document.getElementById("indexLoginTips").innerHTML="";
		document.getElementById("indexLoginTips").innerHTML="邮箱格式不正确";
		return
	}
	if(pWord == ""){
		document.getElementById("indexLoginTips").style.display="block";
		document.getElementById("indexLoginTips").innerHTML="";
		document.getElementById("indexLoginTips").innerHTML="密码不能为空";
		return ;
	}else if(pWord.length <6){
		document.getElementById("indexLoginTips").style.display="block";
		document.getElementById("indexLoginTips").innerHTML="";
		document.getElementById("indexLoginTips").innerHTML="密码长度不能小于6！";
		return ;
	}
	var param={email:uName,password:pWord};
	jQuery.post(url,param,function(data){
		if(data && data.ret==0) {
			if(data.data) {
				window.location.href="/btc.jsp";
			} else {
				window.location.href="/userinfo.jsp";
			}
		}
		if(data && data.ret==601){
			document.getElementById("indexLoginTips").style.display="block";
			document.getElementById("indexLoginTips").innerHTML="";
			document.getElementById("indexLoginTips").innerHTML="用户名或密码错误!";
		}
		if(data && data.ret==603){
			document.getElementById("indexLoginTips").style.display="block";
			document.getElementById("indexLoginTips").innerHTML="";
			document.getElementById("indexLoginTips").innerHTML="用户已冻结,请与管理员联系!";
		}
		if(data && data.ret==608){
			document.getElementById("indexLoginTips").style.display="block";
			document.getElementById("indexLoginTips").innerHTML="";
			document.getElementById("indexLoginTips").innerHTML="用户未激活,请登录邮箱进行激活!";
		}
		/**
		 * var result = eval('(' + data + ')'); if(result!=null){
		 * if(result.resultCode == 0){
		 * if(document.getElementById("forwardUrl")!=null &&
		 * document.getElementById("forwardUrl").value != ""){ var forward =
		 * document.getElementById("forwardUrl").value; forward =
		 * decodeURI(forward); window.location.href=forward; }else{ var whref =
		 * document.location.href; if(whref.indexOf("#") != -1){ whref =
		 * whref.substring(0,whref.indexOf("#")); } if(whref.length < 30){ whref =
		 * document.getElementById("coinMainUrl").value+"/btc.jsp"; }
		 * window.location.href=whref; } }else if(result.resultCode == -1){
		 * document.getElementById("indexLoginTips").style.display="block";
		 * document.getElementById("indexLoginTips").innerHTML="";
		 * document.getElementById("indexLoginTips").innerHTML="用户名或密码错误"; }else
		 * if(result.resultCode == -2){
		 * document.getElementById("indexLoginTips").style.display="block";
		 * document.getElementById("indexLoginTips").innerHTML="";
		 * document.getElementById("indexLoginTips").innerHTML="此ip登录频繁，请2小时后再试";
		 * }else if(result.resultCode == -3){
		 * document.getElementById("indexLoginTips").style.display="block";
		 * document.getElementById("indexLoginTips").innerHTML="";
		 * if(result.errorNum == 0){
		 * document.getElementById("indexLoginTips").innerHTML="此ip登录频繁，请2小时后再试";
		 * }else{
		 * document.getElementById("indexLoginTips").innerHTML="用户名或密码错误，您还有"+result.errorNum+"次机会"; }
		 * document.getElementById("indexLoginPwd").value=""; }else
		 * if(result.resultCode == -4){
		 * document.getElementById("indexLoginTips").style.display="block";
		 * document.getElementById("indexLoginTips").innerHTML="";
		 * document.getElementById("indexLoginTips").innerHTML="请设置启用COOKIE功能";
		 * }else if(result.resultCode == 1){ window.location.href =
		 * document.getElementById("coinMainUrl").value; }else
		 * if(result.resultCode == 2){
		 * document.getElementById("indexLoginTips").style.display="block";
		 * document.getElementById("indexLoginTips").innerHTML="";
		 * document.getElementById("indexLoginTips").innerHTML="账户出现安全隐患被冻结，请尽快联系客服。"; } }
		 */
	});	
}
function indexDepthDiv(type){
	var url = "/indexDepth.do?symbol="+type+"&random="+Math.round(Math.random()*100);
	jQuery("#depthDiv").load(url,function (data){
	});
}
function trimValue(obj){
	var value = obj.value;
	value = value.replace(new RegExp("　","gm"),'');
	value = value.replace(/^\s+|\s+$/g,"");
	obj.value = value;
}

function submitTotpCode(){
	var totpCode = document.getElementById("totpCode").value;
	var regu = /^[0-9]{6}$/;
    var re = new RegExp(regu);
    if (!re.test(totpCode)) {
    	document.getElementById("errorSpan").style.display = "block";
    	document.getElementById("errorSpan").innerHTML = "请正确输入谷歌验证码。";
    	return ;
    }
	var url = "/login/submitTotpCode.do?random="+Math.round(Math.random()*100);
	var param={totpCode:totpCode};
	jQuery.post(url,param,function(data){
			var result = eval('(' + data + ')');
			if(result!=null){
				if(result.resultCode == 0){
					var whref = document.location.href;
					if(whref.indexOf("#") != -1){
						whref = whref.substring(0,whref.indexOf("#"));
					}
					if(whref.length < 30){
						whref = document.getElementById("coinMainUrl").value+"/btc.jsp";
					}
					window.location.href=whref;
				}else if(result.resultCode == -1){
					document.getElementById("errorSpan").style.display = "block";
					document.getElementById("errorSpan").innerHTML = "请正确输入谷歌验证码。";
				}else if(result.resultCode == -2){
					document.getElementById("errorSpan").style.display = "block";
					if(result.errorNum == 0){
						document.getElementById("errorSpan").innerHTML="登录验证错误多次，请2小时后再试";
					}else{
						document.getElementById("errorSpan").innerHTML="登录验证错误，您还有"+result.errorNum+"次机会";
					}
				}
			}
	});
}

function checkNotNull(param){
	if(param==""||param==null){
		return false;
	}
	return true;
}
function controlDisplayQQGroup(){
	document.getElementById('QQRest').style.display="";
	document.getElementById('controlDisplayQQGroup').style.display="none";
	document.getElementById('controlHiddenQQGroup').style.display="";
}

function controlHiddenQQGroup(){
	document.getElementById('QQRest').style.display="none";
	document.getElementById('controlDisplayQQGroup').style.display="";
	document.getElementById('controlHiddenQQGroup').style.display="none";
}

function showBackLeft(){
	var okhelp = new CookieClass();
	if(okhelp.getCookie("okhelp") == "" || okhelp.getCookie("okhelp") == 0){
	okhelp.setCookie("okhelp", 1);
	}
	document.getElementById('backtop2').style.display="block";
	document.getElementById('okRight').style.display="block";
	document.getElementById('okLeft').style.display="none";
}

function showBackRight(){
	var okhelp = new CookieClass();
	if(okhelp.getCookie("okhelp") == "" || okhelp.getCookie("okhelp") == 1){
	okhelp.setCookie("okhelp", 0);
	}
	document.getElementById('backtop2').style.display="none";
	document.getElementById('okRight').style.display="none";
	document.getElementById('okLeft').style.display="block";
}
// 顶部k线 根据k线版本切换时使用
function changeSymbol(type){
	if(type=="1"){
		document.getElementById("okcoinTitle").className ="cur";
		document.getElementById("bitstampTitle").className ="";
		document.getElementById("okcoinLtcTitle").className ="";
		if(document.getElementById("bannerLineOld").style.display!="none"){
			document.getElementById("bannerLineOld").style.display="none";
			document.getElementById("oldLineTime").style.display="none";
			document.getElementById("bannerLineNew").style.display="";
			document.getElementById("klineFullScreen").src="/kline/start.do?symbol=okcoinbtccny";
		}else{
			document.getElementById("bannerLineNew").style.display="";
			document.getElementById("oldLineTime").style.display="none";
			document.getElementById("klineFullScreen").src="/kline/start.do?symbol=okcoinbtccny";
		}
	}else if(type=="2"){
		document.getElementById("okcoinTitle").className ="";
		document.getElementById("bitstampTitle").className ="";
		document.getElementById("okcoinLtcTitle").className ="cur";
		if(document.getElementById("bannerLineOld").style.display!="none"){
			document.getElementById("bannerLineOld").style.display="none";
			document.getElementById("oldLineTime").style.display="none";
			document.getElementById("bannerLineNew").style.display="";
			document.getElementById("klineFullScreen").src="/kline/start.do?symbol=okcoinltccny";
		}else{
			document.getElementById("bannerLineNew").style.display="";
			document.getElementById("oldLineTime").style.display="none";
			document.getElementById("klineFullScreen").src="/kline/start.do?symbol=okcoinltccny";
		}
	}else if(type=="3"){
		if(document.getElementById("bannerLineNew").style.display!="none"){
			document.getElementById("bannerLineNew").style.display="none";
			document.getElementById("bannerLineOld").style.display="";
			document.getElementById("oldLineTime").style.display="";
			showKLine(1,3);
		}else{
			document.getElementById("bannerLineOld").style.display="";
			document.getElementById("oldLineTime").style.display="";
			showKLine(1,3);
		}
	}else if(type=="4"){
		if(document.getElementById("bannerLineNew").style.display!="none"){
			document.getElementById("bannerLineNew").style.display="none";
			document.getElementById("oldLineTime").style.display="";
			document.getElementById("bannerLineOld").style.display="";
			showKLine(4,3);
		}else{
			document.getElementById("bannerLineOld").style.display="";
			document.getElementById("oldLineTime").style.display="";
			showKLine(4,3);
		}
	}
}
function subPoint(value){
	var reg=/^(-?\d*)\.?\d{1,4}$/;
	if(value!=null && value.toString().split(".")!=null && value.toString().split(".")[1]!=null && value.toString().split(".")[1].length>4){
		if(!reg.test(value)){
			var end =  value.toString().split(".")[1];
			if(end.length>4){
				end = end.substring(0, 4);
			}
			value = value.toString().split(".")[0]+"."+end;
		}
	}
	return value;
}
function subPoint2(value){
	var reg=/^(-?\d*)\.?\d{1,2}$/;
	if(value!=null && value.toString().split(".")!=null && value.toString().split(".")[1]!=null && value.toString().split(".")[1].length>2){
		if(!reg.test(value)){
			var end =  value.toString().split(".")[1];
			if(end.length>2){
				end = end.substring(0, 2);
			}
			value = value.toString().split(".")[0]+"."+end;
		}
	}
	return value;
}
function changeCallMessage(id,titleId){
	if(id!=null&&id.length>0){
		var oldId = id+"Sign";
		var display = Number(document.getElementById(oldId).value);
		if(display==0){
			document.getElementById(id).value="发送语音验证";
			document.getElementById(titleId).innerHTML="切换短信验证码";
			document.getElementById(oldId).value="1";
		}else{
			document.getElementById(id).value="发送验证码";
			document.getElementById(titleId).innerHTML="切换语音验证码";
			document.getElementById(oldId).value="0";
		}
		
	}
}
function changeBtn(id,isInter){
	if(isInter==0){
		document.getElementById(id+"Title").style.display="";
		var msgType = document.getElementById(id+"Sign").value;
		if(msgType==0){
			document.getElementById(id).value="发送验证码";
		}else{
			document.getElementById(id).value="发送语音验证";
		}
	}else{
		document.getElementById(id).value="发送验证码";
	}
}
function hiddenTitle(id){
	document.getElementById(id+"Title").style.display="none";
}
// 过滤输入的数字
function checkNumberByName(name){
	var number = document.getElementById(name).value.split('.');
	if(number.length > 1){
		return number[0].replace(/\D/g, '') + '.' + number[1].replace(/\D/g, '').slice(0, 4);
	}else{
		return number[0].replace(/\D/g,'');
	}
}
function checkNumberByObj(obj,lenth){
	var number = obj.value.split('.');
	if(number.length > 1){
		return number[0].replace(/\D/g, '') + '.' + number[1].replace(/\D/g, '').slice(0, lenth);
	}else{
		return number[0].replace(/\D/g,'');
	}
}
// 获得光标位置
function getPositionForInput(ctrl){ 
	var CaretPos = 0; 
	if (document.selection) { // IE Support
	ctrl.focus(); 
	var Sel = document.selection.createRange(); 
	Sel.moveStart('character', -ctrl.value.length); 
	CaretPos = Sel.text.length; 
	}else if(ctrl.selectionStart || ctrl.selectionStart == '0'){// Firefox
																// support
	CaretPos = ctrl.selectionStart; 
	} 
	return (CaretPos); 
} 
// 设置光标位置
function setCursorPosition(ctrl, pos){ 
	if(ctrl.setSelectionRange){ 
	ctrl.focus(); 
	ctrl.setSelectionRange(pos,pos); 
	} 
	else if (ctrl.createTextRange) { 
	var range = ctrl.createTextRange(); 
	range.collapse(true); 
	range.moveEnd('character', pos); 
	range.moveStart('character', pos); 
	range.select(); 
	} 
} 
// 加法
function accAdd(arg1,arg2){
    var r1,r2,m;
    try{r1=arg1.toString().split(".")[1].length;}catch(e){r1=0;}
    try{r2=arg2.toString().split(".")[1].length;}catch(e){r2=0;}
    m=Math.pow(10,Math.max(r1,r2));
    return (arg1*m+arg2*m)/m;
}
// 乘法
function accMul(arg1,arg2) { 
	var m=0,s1=arg1.toString(),s2=arg2.toString(); 
	try{m+=s1.split(".")[1].length;}catch(e){} 
	try{m+=s2.split(".")[1].length;}catch(e){} 
	return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m);
}
// 除法
function accDiv(arg1,arg2){  
    var t1=0,t2=0,r1,r2;  
    try{t1=arg1.toString().split(".")[1].length;}catch(e){}  
    try{t2=arg2.toString().split(".")[1].length;}catch(e){}  
    with(Math){  
        r1=Number(arg1.toString().replace(".",""));  
        r2=Number(arg2.toString().replace(".",""));  
        return (r1/r2)*pow(10,t2-t1);  
    }  
}  

function getNumberByDecimalPrecision(precision) {
    var value = 1.0;
	if (precision < 0) {
		for (i = 0; i > precision; i--) {
			value = accMul(value , 10.0);
		}
	} 

	if (precision > 0){
		for (i = 0; i < precision; i++) {
			value = accMul(value , 0.1);
		}
	}
	// value = value.setScale(DEFAULT_SCALE,BigDecimal.ROUND_HALF_UP);
	return value;
}

function isMultiple(number, unit) {
	float_multi = accDiv(number, unit);
	int_multi = Math.floor(float_multi);
	return int_multi == float_multi;
}

function isExceedPrecision(number, precision) {
	unit = getNumberByDecimalPrecision(precision);
	return !isMultiple(number, unit);
}


// 兼容ctrlA组合键和tab键
function ctrlAorTab(event){
	if(event !=null && (event.keyCode==9 || event.keyCode==17)){
		return true;
	}
	if(event !=null && event.ctrlKey && event.keyCode==65){
		return true;
	}
}
function isSpider(){
	var result = false;
	var spiderAgentArr = ["Baiduspider","Googlebot", "360Spider","Sosospider", "sogou spider"];
	for(var i=0;i<spiderAgentArr.length;i++){
		if(navigator.userAgent.indexOf(spiderAgentArr[0])>0){
			result = true;
		}
	}
	return result;
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

function changeType(self,reid){
	var url="/type/getTypeHTMLOption?reid="+reid+"&random="+Math.round(Math.random()*100);
	jQuery.get(url,function(res){
		if(res){
			if(res.ret==0){
				$(self).next().html(res.data);
			}
		}
	});
}
function loadArea(){
	var province=$("#local").val();
	var url="/area/getAreaHTMLOption?reid="+province+"&random="+Math.round(Math.random()*100);
	jQuery.get(url,function(res){
		if(res){
			if(res.ret==0){
				document.getElementById("local2").innerHTML=res.data;
			}
		}
	});
}
// 查询用户的财产
function queryUserProfile(){
	var url="/api/user/getProfile?random="+Math.round(Math.random()*100);
	$.get(url,function(res){
		if(res){
			if(res.ret==0){
				if($("#coin_left")){
					$("#coin_left").html(parseFloat(res.data["coin"]).toLocaleString());
				}
				if($("#smallbouns_left")){
					$("#smallbouns_left").html(res.data["smallbouns"]);
				}
				if($("#mediumbouns_left")){
					$("#mediumbouns_left").html(res.data["mediumbouns"]);
				}
				if($("#bigbouns_left")){
					$("#bigbouns_left").html(res.data["bigbouns"]);
				}
			}
		}
	});
}
/**
 * 不包含银行行号提交的方法
 */
function bindCardSubmit(){
	if(!$(".icheckbox_square").hasClass("checked")){
		swal("错误", "请同意用户协议", "error");
		return;
	}
	var bank_account_o=$("#bank_account_o").val();
	var bank_o=$("#bank_o").val();
	if(bank_o=="0"){
		swal("错误", "请选择银行", "error");
		return;
	}
	/*var bank_deposit_o=$("#bank_deposit_o").val();
	if(bank_deposit_o==""||bank_deposit_o==null){
		swal("错误", "请填写开户行", "error");
		return;
	}*/
	var name=$("#name").val();
	var identity_type=$("#identity_type").val();
	if(identity_type==0){
		swal("错误", "请选择有效证件", "error");
		return;
	}
	if($("#needCheckIdentity_o").val()==1){
		checkIdentity_noExist();
	}
	var identity_no=$("#identity_no").val();
	var phone_o=$("#phone_o").val();
	if(!checkMobile(phone_o)){
		swal("错误", "请输入正确的手机号", "error");
		return;
	}
	var url="/api/bind/addCard?random="+Math.round(Math.random()*100);
	var params={bank_account_o:bank_account_o,bank_o:bank_o,name:name,identity_type:identity_type,identity_no:identity_no,phone_o:phone_o,bindType:1};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				swal({
	                title: "操作成功",  
	                text: "添加成功",  
	                type: "success",  
	                showCancelButton: false,  
	                confirmButtonColor: "#A7D5EA",  
	                confirmButtonText: "确认" },
	                function(){  
	                     window.location.href="/user_card_list.jsp";
	                });
				return;
			}else if(res.ret==802){
				swal("错误", "银行信息不存在", "error");
				return;
			}
		}
	});
}
/**
 * 包含开户行行号的银行卡绑定
 */
function bindCardFullSubmit(){
	var bindType=$("#bindType").val();
	
	if(!$(".icheckbox_square").hasClass("checked")){
		swal("错误", "请同意用户协议", "error");
		return;
	}
	var bank_account_o=$("#bank_account_o").val();
	var bank_o=$("#bank_o").val();
	if(bank_o=="0"){
		swal("错误", "请选择银行", "error");
		return;
	}
	/*var bank_deposit_o=$("#bank_deposit_o").val();
	if(bank_deposit_o==""||bank_deposit_o==null){
		swal("错误", "请填写开户行", "error");
		return;
	}*/
	if(bindType==1){
		var name=$("#name").val();
		var identity_type=$("#identity_type").val();
		if(identity_type==0){
			swal("错误", "请选择有效证件", "error");
			return;
		}
		var identity_no=$("#identity_no").val();
		if(identity_no.length<15){
			swal("错误", "请输入有效的身份证号", "error");
			return;
		}
	}else{
		var licenceRegName=$("#licenceRegName").val();
		var licenceNumber=$("#licenceNumber").val();
		if(licenceRegName==""||licenceRegName==null){
			swal("错误", "请输入有效的营业执照名", "error");
			return;
		}
		if(licenceNumber.length<12){
			swal("错误", "请输入有效的营业执照编号", "error");
			return;
		}
	}
	var phone_o=$("#phone_o").val();
	if(!checkMobile(phone_o)){
		swal("错误", "请输入正确的手机号", "error");
		return;
	}
	/*document.getElementById("withdrawAccountAddr_bankNumber").value=document.getElementById("withdrawAccountAddr_bankNumber").value.replace(/\D/g,'');
	
	var bank_number_o=$("#withdrawAccountAddr_bankNumber").val();
	if(bank_number_o==""||bank_number_o==null||bank_number_o.length!=12){
		swal("错误", "请填写正确的开户行行号", "error");
		return;
	}*/
	var url="/api/bind/addCard?random="+Math.round(Math.random()*100);
	if(bindType==1){
		var params={bank_account_o:bank_account_o,bank_o:bank_o,name:name,identity_type:identity_type,identity_no:identity_no,phone_o:phone_o,bindType:bindType};
	}else{
		var params={bank_account_o:bank_account_o,bank_o:bank_o,licenceRegName:licenceRegName,licenceNumber:licenceNumber,phone_o:phone_o,bindType:bindType};
	}
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				swal({
	                title: "操作成功",  
	                text: "添加成功",  
	                type: "success",  
	                showCancelButton: false,  
	                confirmButtonColor: "#A7D5EA",  
	                confirmButtonText: "确认" },
	                function(){  
	                     window.location.href="/shop_card_list.jsp";
	                });
				return;
			}else if(res.ret==802){
				swal("错误", "银行信息不存在", "error");
				return;
			}
		}
	});
}
/**
 * 不带开户行行号的表单修改提交
 */
function bindCardUpdateSubmit(){
	var bid=$("#bid").val();
	var bank_account_o=$("#bank_account_o").val();
	if(trim(bank_account_o).length<16){
		swal("错误", "请确认填入正确的卡号", "error");
		return;
	}
	var bank_o=$("#bank_o").val();
	if(bank_o=="0"){
		swal("错误", "请选择银行", "error");
		return;
	}
	var bank_deposit_o=$("#bank_deposit_o").val();
	if(bank_deposit_o==""||bank_deposit_o==null){
		swal("错误", "请填写开户行", "error");
		return;
	}
	var phone_o=$("#phone_o").val();
	if(!checkMobile(phone_o)){
		swal("错误", "请输入正确的手机号", "error");
		return;
	}
	var url="/api/bind/modifyCard?random="+Math.round(Math.random()*100);
	var params={bank_account_o:bank_account_o,bank_o:bank_o,bank_deposit_o:bank_deposit_o,phone_o:phone_o,bid:bid};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				swal({
					title: "操作成功",  
					text: "添加成功",  
					type: "success",  
					showCancelButton: false,  
					confirmButtonColor: "#A7D5EA",  
					confirmButtonText: "确认" },
					function(){  
						window.location.href="/user_card_list.jsp";
					});
				return;
			}
		}
	});
}
/**
 * 带开户行行号的表单提交(商户提交绑定卡，涉及到民生银行分账，所以需要提交行号)
 */
function bindCardFullUpdateSubmit(){
	var bid=$("#bid").val();
	var bank_account_o=$("#bank_account_o").val();
	if(trim(bank_account_o).length<16){
		swal("错误", "请确认填入正确的卡号", "error");
		return;
	}
	var bank_o=$("#bank_o").val();
	if(bank_o=="0"){
		swal("错误", "请选择银行", "error");
		return;
	}
	var bank_deposit_o=$("#bank_deposit_o").val();
	if(bank_deposit_o==""||bank_deposit_o==null){
		swal("错误", "请填写开户行", "error");
		return;
	}
	var phone_o=$("#phone_o").val();
	if(!checkMobile(phone_o)){
		swal("错误", "请输入正确的手机号", "error");
		return;
	}
	
	document.getElementById("withdrawAccountAddr_bankNumber").value=document.getElementById("withdrawAccountAddr_bankNumber").value.replace(/\D/g,'');
	
	var bank_number_o=$("#withdrawAccountAddr_bankNumber").val();
	if(bank_number_o==""||bank_number_o==null||bank_number_o.length!=12){
		swal("错误", "请填写正确的开户行行号", "error");
		return;
	}
	
	var url="/api/bind/modifyCard?random="+Math.round(Math.random()*100);
	var params={bank_account_o:bank_account_o,bank_o:bank_o,bank_deposit_o:bank_deposit_o,phone_o:phone_o,bid:bid,bank_number_o:bank_number_o};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				swal({
					title: "操作成功",  
					text: "添加成功",  
					type: "success",  
					showCancelButton: false,  
					confirmButtonColor: "#A7D5EA",  
					confirmButtonText: "确认" },
					function(){  
						window.location.href="/shop_card_list.jsp";
					});
				return;
			}
		}
	});
}
function cardDelete(role){
	if(!confirm("真的删除?")){return}
	var uid=$("#uid").val();
	var bid=$("#bid").val();
	var url="/api/bind/removeCard?random="+Math.round(Math.random()*100);
	var params={uid:uid,id:bid};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				swal({
                    title: "操作成功",  
                    text: "已成功删除该银行卡",  
                    type: "success",  
                    showCancelButton: false,  
                    confirmButtonColor: "#A7D5EA",  
                    confirmButtonText: "确认" },
                    function(){  
                    	if(role==1){
                    		window.location.href="user_card_list.jsp";
                    	}else if(role==2){
                    		window.location.href="shop_card_list.jsp";
                    	}
                    });
			}
		}
	});
	
}

function IdentityCodeValid(code) { 
    var city={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江 ",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北 ",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏 ",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外 "};
    var tip = "";
    var pass= true;
    if(!code || !/^\d{6}(18|19|20)?\d{2}(0[1-9]|1[12])(0[1-9]|[12]\d|3[01])\d{3}(\d|X)$/i.test(code)){
        tip = "身份证号格式错误";
        pass = false;
    }
   else if(!city[code.substr(0,2)]){
        tip = "地址编码错误";
        pass = false;
    }
    else{
        // 18位身份证需要验证最后一位校验位
        if(code.length == 18){
            code = code.split('');
            // ∑(ai×Wi)(mod 11)
            // 加权因子
            var factor = [ 7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2 ];
            // 校验位
            var parity = [ 1, 0, 'X', 9, 8, 7, 6, 5, 4, 3, 2 ];
            var sum = 0;
            var ai = 0;
            var wi = 0;
            for (var i = 0; i < 17; i++)
            {
                ai = code[i];
                wi = factor[i];
                sum += ai * wi;
            }
            var last = parity[sum % 11];
            /*if(parity[sum % 11] != code[17]){
                tip = "校验位错误";
                pass =false;
            }*/
        }
    }
    if(!pass) swal("错误", tip, "error");
    return pass;
}
function scanQR(){
	$("#scanQRCode").click()
}

var wait=120;
function time(o) {
	if (wait == 0) {
		o.removeAttribute("disabled");
		o.innerHTML="发送验证码";
		wait = 120;
	} else {
		o.setAttribute("disabled", true);
		o.innerHTML=wait+"秒后重新发送";
		wait--;
		setTimeout(function(){time(o)},1000);
	}
}
/**
 * 
 * @param self
 * @param type
 *            发送类别 1-注册（需先验证手机号是否已注册） 2-找回密码
 */
function sendMsg(self,type){
	var regType=0;
	var roleType=$("#roleType").val();
	if(roleType==1){
		var m=$("#regUserName").val();
	}else{
		var m=$("#mobile2").val();
	}
	if(type==1){
		if(!checkMobile(m)){
			swal("错误", "手机号格式不正确", "error");
			return;
		}
		if(roleType==1){
			var urlName = "/open/chcekregname?mobile=" + encodeURI(m) +"&type="+regType+"&random="+Math.round(Math.random()*100);
			jQuery.get(urlName,null,function(data){
				if(data.ret == 606){
					if(regType == 0){
						desc="您输入的账号已注册";
					}else{
						desc="邮箱已存在";
					}
					swal("错误", desc, "error");
					return ;
				}else{
					sendMsg4ValidateMobile(m);
					time(self);
				}
			});
		}else{
			if(!mobile2Exist){
				sendMsg4ValidateMobile(m);
				time(self);
			}else{
				swal("错误", "手机号已存在", "error");
				return;
			}
		}
	}
	// if type==找回密码
	else if(type==2){
		m=$("#regUserName").val();
		if(m==null||m==""){
			swal("错误", "请输入用户名", "error");
			return;
		}
		time(self);
		sendMsg4ResetPass(m);
	}
}
/**
 * 发送验证码
 */
function sendMsg4ValidateMobile(m){
	var url="/open/sendMsg4ValidateMobile?random="+Math.round(Math.random()*100);
	var params={m:m};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				var desc="发送成功";
				swal("成功", desc, "success");
				return;
			}
			if(res.ret==500){
				var desc="请勿频繁发送，2分钟后再发";
				swal("失败", desc, "error");
				return;
			}
		}
	});
}
function sendMsg4ResetPass(m){
	var url="/open/resetPassword?random="+Math.round(Math.random()*100);
	var params={userName:m};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				var desc="发送成功，请在输入框中输入验证码";
				swal("成功", desc, "success");
				return;
			}
			if(res.ret==609){
				var desc="用户名不存在";
				swal("失败", desc, "error");
				wait = 1;
				return;
			}
			if(res.ret==621){
				var desc="该账户没有绑定手机号";
				swal("失败", desc, "error");
				wait = 1;
				return;
			}
			if(res.ret==500){
				var desc="请勿频繁发送，2分钟后再发";
				swal("失败", desc, "error");
				return;
			}
		}
	});
}
function isPassword(pwd){
	var desc = "";
	if(pwd == ""){
		desc="请输入密码！";
	}else if(pwd.length <6){
		desc="密码长度不能小于6！";
	}else if(pwd.length>16){
		desc="密码长度不能大于16！";
	}
	return desc;
}
var secretInputTime=3;
function submitToInputCardNum(){
	if(secretInputTime==0){
		window.location.href="secretReset.jsp";
	}
	var secret=$("#secret").val();
	if(isPassword(secret)!=""){
		swal("错误", isPassword(secret), "error");
		return;
	}
	var params={secret:secret};
	var url="/api/user/checkSecret?random="+Math.round(Math.random()*100);
	$.post(url,params,function(res){
		if(res){
			if(res.ret==604){
				swal("错误", "请输入交易密码", "error");
			}else if(res.ret==602){
				secretInputTime--;
				if(secretInputTime==0){
					window.location.href="secretReset.jsp";
				}else{
					swal("错误", "交易密码不正确，您还有"+secretInputTime+"次输入机会", "error");
				}
			}else if(res.ret==0){
				$("#secretOK").val("ok");
				var subType=$("#subType").val();
				if(subType=="1"){
					document.getElementById("submitSecretOk").action="input_card_num.jsp";
					$("#submitSecretOk").submit();
				}else if(subType=="2"){
					document.getElementById("submitSecretOk").action="user_withdraw.jsp";
					$("#submitSecretOk").submit();
				}else if(subType=="3"){
					var forward=$("#forward").val();
					document.getElementById("submitSecretOk").action=forward;
					$("#submitSecretOk").submit();
				}
			}
		}
	});
}
function submitToInputCardNumShop(){
	if(secretInputTime==0){
		window.location.href="secretReset.jsp";
	}
	var secret=$("#secret").val();
	if(isPassword(secret)!=""){
		swal("错误", isPassword(secret), "error");
		return;
	}
	var params={secret:secret};
	var url="/api/user/checkSecret?random="+Math.round(Math.random()*100);
	$.post(url,params,function(res){
		if(res){
			if(res.ret==604){
				swal("错误", "请输入交易密码", "error");
			}else if(res.ret==602){
				secretInputTime--;
				if(secretInputTime==0){
					window.location.href="secretReset.jsp";
				}else{
					swal("错误", "交易密码不正确，您还有"+secretInputTime+"次输入机会", "error");
				}
			}else if(res.ret==0){
				$("#secretOK").val("ok");
				var subType=$("#subType").val();
				if(subType=="1"){
					document.getElementById("submitSecretOk").action="input_card_num.jsp";
					$("#submitSecretOk").submit();
				}else if(subType=="2"){
					document.getElementById("submitSecretOk").action="shop_withdraw.jsp";
					$("#submitSecretOk").submit();
				}else if(subType=="3"){
					var forward=$("#forward").val();
					document.getElementById("submitSecretOk").action=forward;
					$("#submitSecretOk").submit();
				}
			}
		}
	});
}

function submitCardNum(){
	var cardnum=$("#bankCardNum").val();
	if(trim(cardnum).length<8){
		swal("错误", "请确认填入正确的卡号", "error");
		return;
	}
	var url="/api/bind/checkCardExist?random="+Math.round(Math.random()*100);
	var params={bankCardNum:cardnum};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==500){
				swal("错误", "请确认填入正确的卡号", "error");
				return;
			}else if(res.ret==615){
				swal("错误", "该银行卡您已经绑定过了，请重新输入", "error");
				return;
			}else if(res.ret==0){
				$("#submitCardNum").submit();
			}
		}
	});
}

function submitCardNumFull(){
	var cardnum=$("#bankCardNum").val();
	if(trim(cardnum).length<8){
		swal("错误", "请确认填入正确的卡号", "error");
		return;
	}
	var url="/api/bind/checkCardExist?random="+Math.round(Math.random()*100);
	var params={bankCardNum:cardnum};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==500){
				swal("错误", "请确认填入正确的卡号", "error");
				return;
			}else if(res.ret==615){
				swal("错误", "该银行卡您已经绑定过了，请重新输入", "error");
				return;
			}else if(res.ret==0){
				$("#submitCardNum").submit();
			}
		}
	});
}

function closeTag(){
	$(".absolutePostion").hide();
}

function shopStatusOper(status){
	if(!confirm("请确认是否继续？")){
		return;
	}
	var url="/shop/ShopStatusOper?random="+Math.round(Math.random()*100);
	var params={operType:status};
	$.post(url,params,function(res){
		if(res){
			if(res.ret==0){
				swal({
                    title: "操作成功",  
                    text: "",  
                    type: "success",  
                    showCancelButton: false,  
                    confirmButtonColor: "#A7D5EA",  
                    confirmButtonText: "确认" },
                    function(){  
                         window.location.href=window.location.href;
                    });
			}
		}
	});
}
