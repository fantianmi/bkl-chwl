package com.bkl.chwl.servlet;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bkl.chwl.entity.Version;
import com.bkl.chwl.service.VersionService;
import com.bkl.chwl.service.impl.VersionServiceImpl;
import com.km.common.servlet.CommonServlet;
import com.km.common.utils.ServletUtil; 
/**
 * version oper
 * @author fanti_000
 *
 */
public class VersionServlet extends CommonServlet {
	
	private static final long serialVersionUID = 1L;
	//add version
	public void addVersion(HttpServletRequest request,HttpServletResponse response) throws Exception{
		VersionService versionServ = new VersionServiceImpl();
		Version v=ServletUtil.readObjectServletQuery(request, Version.class);
		long id=versionServ.saveVersion(v);
		v.setId(id);
		ServletUtil.writeOkCommonReply(v, response);
	}
	//delete version
	public void deleteVersion(HttpServletRequest request, HttpServletResponse response) throws Exception{
		VersionService versionServ = new VersionServiceImpl();
		int id=Integer.parseInt(request.getParameter("id"));
		versionServ.deleteVersion(id);
		ServletUtil.writeOkCommonReply(null, response);
	}
}
