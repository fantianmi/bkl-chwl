package com.bkl.chwl.servlet.login;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bkl.chwl.entity.User;
import com.bkl.chwl.service.UserService;
import com.bkl.chwl.service.impl.UserServiceImpl;
import com.bkl.chwl.utils.RequestUtil;
import com.km.common.servlet.CommonServlet;
import com.km.common.utils.RandomCode;
import com.km.common.utils.ServletUtil;
import com.km.common.utils.TimeUtil;

public class OauthServlet extends CommonServlet {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void login(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		UserService userServ = new UserServiceImpl();
		String openid= request.getParameter("openid");
		User user=userServ.findPin(openid);
		//如果没有则创建新用户
		if(user==null){
			User createUser=new User();
			String headIcon=request.getParameter("headicon");
			String nickName=request.getParameter("nickname");
			createUser.setHeadIcon(headIcon);
			createUser.setNick_name(nickName);
			createUser.setPin(openid);
			createUser.setCtime(TimeUtil.getUnixTime());
			createUser.setReg_ip(RequestUtil.getRemoteAddress(request));
			//注册即激活
			createUser.setEmail_validated(1);
			Long id=userServ.createUser(createUser);
			createUser.setId(id);
			ServletUtil.writeOkCommonReply(createUser,response);		
			return;
		}else{
			ServletUtil.writeOkCommonReply(user, response);
			return;
		}
		
	}
}
