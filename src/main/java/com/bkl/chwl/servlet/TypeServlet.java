package com.bkl.chwl.servlet;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bkl.chwl.entity.Area;
import com.bkl.chwl.entity.Type;
import com.bkl.chwl.service.AreaService;
import com.bkl.chwl.service.TypeService;
import com.bkl.chwl.service.impl.AreaServiceImpl;
import com.bkl.chwl.service.impl.TypeServiceImpl;
import com.km.common.servlet.CommonServlet;
import com.km.common.utils.ServletUtil;

public class TypeServlet extends CommonServlet {
	public void getTypeHTMLOption(HttpServletRequest request,HttpServletResponse response) throws Exception{
		long reid=Integer.parseInt(request.getParameter("reid"));
		TypeService typeServ=new TypeServiceImpl();
		List<Type> types=typeServ.getList(reid);
		
		String res="";
		for(Type t:types){
			res+="<option value='"+t.getId()+"'>"+t.getName()+"</option>";
		}
		ServletUtil.writeOkCommonReply(res, response);
	}
	public void getType(HttpServletRequest request,HttpServletResponse response) throws Exception{
		long reid=Integer.parseInt(request.getParameter("reid"));
		TypeService typeServ=new TypeServiceImpl();
		ServletUtil.writeOkCommonReply(typeServ.getList(reid), response);
	}
	public void addType(HttpServletRequest request,HttpServletResponse response) throws Exception{
		Type type=ServletUtil.readObjectServletQuery(request,Type.class);
		TypeService typeServ=new TypeServiceImpl();
		long id=typeServ.save(type);
		type.setId(id);
		ServletUtil.writeOkCommonReply(type, response);
	}
	public void deleteType(HttpServletRequest request,HttpServletResponse response) throws Exception{
		Type type=ServletUtil.readObjectServletQuery(request,Type.class);
		TypeService areaServ=new TypeServiceImpl();
		long id=type.getId();
		areaServ.delete(id);
		ServletUtil.writeOkCommonReply(type, response);
	}
}
