<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>  
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />  
<title>copyToClipBoard</title>
<!--js api-->
</head>  
<body>  
<script type="text/javascript">  
function copyToClipBoard(){  
       var clipBoardContent="";  
       //如果你想获取当前页面的URL  
       clipBoardContent="18688164055";
       if(window.clipboardData){  
              window.clipboardData.clearData();  
              window.clipboardData.setData("Text", clipBoardContent);  
       }else if(navigator.userAgent.indexOf("Opera") != -1){  
              window.location = clipBoardContent;  
       }else if (window.netscape){  
              try{  
                     netscape.security.PrivilegeManager.enablePrivilege("UniversalXPConnect");  
              }catch (e){  
                     alert("您的当前浏览器设置已关闭此功能！请按以下步骤开启此功能！\n新开一个浏览器，在浏览器地址栏输入'about:config'并回车。\n然后找到'signed.applets.codebase_principal_support'项，双击后设置为'true'。\n声明：本功能不会危极您计算机或数据的安全！");  
              }  
              var clip = Components.classes['@mozilla.org/widget/clipboard;1'].createInstance(Components.interfaces.nsIClipboard);  
              if (!clip) return;  
              var trans = Components.classes['@mozilla.org/widget/transferable;1'].createInstance(Components.interfaces.nsITransferable);  
              if (!trans) return;  
              trans.addDataFlavor('text/unicode');  
              var str = new Object();  
              var len = new Object();  
              var str = Components.classes["@mozilla.org/supports-string;1"].createInstance(Components.interfaces.nsISupportsString);  
              var copytext = clipBoardContent;  
              str.data = copytext;  
              trans.setTransferData("text/unicode",str,copytext.length*2);  
              var clipid = Components.interfaces.nsIClipboard;  
              if (!clip) return false;  
              clip.setData(trans,null,clipid.kGlobalClipboard);  
       }  
       alert("地址已成功复制！请粘贴(ctrl+v)分享给好友\n");  
       return true;  
}  
</script>  
<input type="button" onClick="copyToClipBoard()" value="复制文章链接" />  
</body>  
</html>  
