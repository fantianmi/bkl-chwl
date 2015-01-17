package com.bkl.chwl.servlet;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.baiyi.data.model.BigBouns;
import com.baiyi.data.model.MiddleBouns;
import com.baiyi.data.model.SmallBouns;
import com.baiyi.domain.BounsEntity;
import com.baiyi.domain.UserInfoEntity;
import com.baiyi.domain.UserListEntity;
import com.bkl.chwl.entity.Bouns;
import com.bkl.chwl.entity.Tradeorder;
import com.bkl.chwl.entity.Tradeorder2Shop;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.service.OrderService;
import com.bkl.chwl.service.impl.OrderServiceImpl;
import com.bkl.chwl.utils.ApiCommon;
import com.bkl.chwl.utils.UserUtil;
import com.km.common.servlet.CommonServlet;
import com.km.common.utils.ServletUtil;
import com.km.common.utils.TimeUtil;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;
import com.km.common.vo.RetCode;

public class BounsServlet extends CommonServlet {
	public void getBounsListHTML(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User u=UserUtil.getCurrentUser(request);
		UserInfoEntity uie=ApiCommon.getUserInfo(u.getId());
		
		List<MiddleBouns> mbouns=uie.getMiddelBouns();
		List<SmallBouns> sbouns=uie.getSmallBouns();
		List<BigBouns> bbouns=uie.getBigBouns();
		Map bounsMap=new HashMap();
		
		String mbounHTML="";
		String sbounHTML="";
		String bbounHTML="";
		for(MiddleBouns mboun:mbouns){
			mbounHTML+="<div class='container no-bottom list_style_bouns'><div class='recent-post'><div class='dealcard-img-bouns'><i class='iconfont bouns '>&#xe6ec;</i></div><div class='dealcard-block-right-bouns'><div class='title'><strong></strong></div><div class='detail'><strong>"+mboun.getCoin()+"</strong>"+Bouns.convertStatusHTML(mboun.getStatus(), mboun.getId(), 2)+"<br>预计可提取时间："+TimeUtil.fromUnixTime(mboun.getBaseDate())+"<br></div></div></div></div><br><div class='decoration'></div>";
		}
		for(SmallBouns sboun:sbouns){
			sbounHTML+="<div class='container no-bottom list_style_bouns'><div class='recent-post'><div class='dealcard-img-bouns'><i class='iconfont bouns '>&#xe6ec;</i></div><div class='dealcard-block-right-bouns'><div class='title'><strong></strong></div><div class='detail'><strong>"+sboun.getCoin()+"</strong>"+Bouns.convertStatusHTML(sboun.getStatus(), sboun.getId(), 1)+"<br>预计可提取时间："+TimeUtil.fromUnixTime(sboun.getBaseDate())+"<br></div></div></div></div><br><div class='decoration'></div>";
		}
		for(BigBouns bboun:bbouns){
			bbounHTML+="<div class='container no-bottom list_style_bouns'><div class='recent-post'><div class='dealcard-img-bouns'><i class='iconfont bouns '>&#xe6ec;</i></div><div class='dealcard-block-right-bouns'><div class='title'><strong></strong></div><div class='detail'><strong>"+bboun.getCoin()+"</strong>"+Bouns.convertStatusHTML(bboun.getStatus(), bboun.getId(),3)+"<br>预计可提取时间："+TimeUtil.fromUnixTime(bboun.getBaseDate())+"<br></div></div></div></div><br><div class='decoration'></div>";
		}
		
		bounsMap.put("mbounHTML", mbounHTML);
		bounsMap.put("sbounHTML", sbounHTML);
		bounsMap.put("bbounHTML", bbounHTML);
		ServletUtil.writeOkCommonReply(bounsMap, response);
	}
	public void openBouns(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int type=Integer.parseInt(request.getParameter("type"));
		int id=Integer.parseInt(request.getParameter("id"));
		BounsEntity be=ApiCommon.openBouns(type, id);
		int bb=0;
		int mb=0;
		if(null==be.getBigBouns()) bb=0;
		if(null==be.getMiddleBouns()) mb=0;
		String res="本次开钱袋获得金币"+be.getCoin()+"，获得幸福钱袋"+bb+"个，获得的健康钱袋"+mb+"个";
		ServletUtil.writeOkCommonReply(res, response);
	}
	
}
