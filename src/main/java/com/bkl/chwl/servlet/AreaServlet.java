package com.bkl.chwl.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bkl.chwl.entity.Area;
import com.bkl.chwl.service.AreaService;
import com.bkl.chwl.service.impl.AreaServiceImpl;
import com.bkl.chwl.utils.StringUtil;
import com.km.common.servlet.CommonServlet;
import com.km.common.utils.ServletUtil;
import com.km.common.utils.TimeUtil;

public class AreaServlet extends CommonServlet {
	public void addArea(HttpServletRequest request,HttpServletResponse response) throws Exception{
		Area area=ServletUtil.readObjectServletQuery(request,Area.class);
		AreaService areaServ=new AreaServiceImpl();
		long id=areaServ.save(area);
		area.setId(id);
		ServletUtil.writeOkCommonReply(area, response);
	}
	public void deleteArea(HttpServletRequest request,HttpServletResponse response) throws Exception{
		Area area=ServletUtil.readObjectServletQuery(request,Area.class);
		AreaService areaServ=new AreaServiceImpl();
		long id=area.getId();
		areaServ.delete(id);
		ServletUtil.writeOkCommonReply(area, response);
	}
	public void getArea(HttpServletRequest request,HttpServletResponse response) throws Exception{
		long reid=Integer.parseInt(request.getParameter("reid"));
		AreaService areaServ=new AreaServiceImpl();
		ServletUtil.writeOkCommonReply(areaServ.getList(reid), response);
	}
	public void getAreaHTMLInSelectCityPage(HttpServletRequest request,HttpServletResponse response) throws Exception{
		long reid=Integer.parseInt(request.getParameter("reid"));
		AreaService areaServ=new AreaServiceImpl();
		List<Area> areas=areaServ.getList(reid);
		String res="";
		if(areas.size()!=0){
		for(Area a:areas){
			res+="<a href=\"shop_list.jsp?local2="+a.getId()+"&cityName="+StringUtil.subString(a.getTitle(), 4)+"\"><li>"+StringUtil.subString(a.getTitle(), 4)+"</li></a>";
		}
		}else{
			res+="<div class=\"alert alert-info\" role=\"alert\" style=\"text-align: center\">该城市暂无数据，请选择其他城市</div>";
		}
		ServletUtil.writeOkCommonReply(res, response);
	}
	
	public void getAreaHTMLOption(HttpServletRequest request,HttpServletResponse response) throws Exception{
		long reid=Integer.parseInt(request.getParameter("reid"));
		AreaService areaServ=new AreaServiceImpl();
		List<Area> areas=areaServ.getList(reid);
		
		String res="";
		for(Area a:areas){
			res+="<option value='"+a.getId()+"'>"+a.getTitle()+"</option>";
		}
		
		ServletUtil.writeOkCommonReply(res, response);
	}
}
