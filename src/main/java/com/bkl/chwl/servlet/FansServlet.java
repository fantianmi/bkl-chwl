package com.bkl.chwl.servlet;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bkl.chwl.entity.User;
import com.bkl.chwl.service.RecommendService;
import com.bkl.chwl.service.impl.RecommendServiceImpl;
import com.bkl.chwl.utils.ApiCommon;
import com.bkl.chwl.utils.FrontUtil;
import com.bkl.chwl.utils.UserUtil;
import com.bkl.chwl.vo.Fans;
import com.bkl.chwl.vo.UserListEntity;
import com.km.common.servlet.CommonServlet;
import com.km.common.utils.ServletUtil;

public class FansServlet extends CommonServlet {
	public void getFansListHTML(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User u=UserUtil.getCurrentUser(request);
		int type=u.ROLE_NORMAL;
		if(request.getParameter("type")!=null){
			type=Integer.parseInt(request.getParameter("type"));//1普通用户 2商家
		}
		int pagenum=1;
		int pagesize=20;
		if(request.getParameter("pagenum")!=null){
			pagenum=Integer.parseInt(request.getParameter("pagenum"));
		}
		RecommendService recommendServ=new RecommendServiceImpl();
		
		UserListEntity ule=ApiCommon.getRecommendUserList(u.getId(), pagenum, type, pagesize);
		UserListEntity ule2=ApiCommon.getRecommendUserList(u.getId(), 1, 1, 100);
		List<com.baiyi.data.model.User2> users=ule.getList();
		Map<Integer,Fans> sellerMap=recommendServ.getShopFansProfileMap(users);
		String result="";
		double profileTotal=0;
		for(int i=0;i<users.size();i++){
			com.baiyi.data.model.User2 user=users.get(i);
			Fans fans=sellerMap.get(user.getUid());
			double profile=0;
			if(fans!=null){
				profile=fans.getProfile();
			}
			profileTotal+=profile;
			result+="<div class='container no-bottom list_style_user'><div class='recent-post'><div class='dealcard-img-user'><img src='assets/images/ui/avatar.png' alt='img' class='img-circle'></div><div class='dealcard-block-right-user'><div class='detail'><strong>"+user.getUsername()+"</strong><br>结账额："+FrontUtil.formatRmbDouble(profile)+"</div></div></div></div>";
		}
		Fans fans=new Fans();
		fans.setResHTML(result);
		fans.setTotal(ule.getTotal());
		fans.setOtherTotal(ule2.getTotal());
		fans.setTotalProfile(FrontUtil.formatRmbDouble(profileTotal));
		ServletUtil.writeOkCommonReply(fans, response);
	}
	public void getFansNum(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User u=UserUtil.getCurrentUser(request);
		int type=u.ROLE_NORMAL;
		if(request.getParameter("type")!=null){
			type=Integer.parseInt(request.getParameter("type"));//1普通用户 2商家
		}
		int pagenum=1;
		int pagesize=20;
		UserListEntity ule=ApiCommon.getRecommendUserList(u.getId(), pagenum, type, pagesize);
		Fans fans=new Fans();
		fans.setTotal(ule.getTotal());
		ServletUtil.writeOkCommonReply(fans, response);
	}
	
	public void getSellerFansNum(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User u=UserUtil.getCurrentUser(request);
		int type=u.ROLE_NORMAL;
		if(request.getParameter("type")!=null){
			type=Integer.parseInt(request.getParameter("type"));//1普通用户 2商家
		}
		int pagenum=1;
		int pagesize=20;
		UserListEntity ule=ApiCommon.getSellerRecommendUserList(u.getId(), pagenum, pagesize);
		Fans fans=new Fans();
		fans.setTotal(ule.getTotal());
		ServletUtil.writeOkCommonReply(fans, response);
	}
}
