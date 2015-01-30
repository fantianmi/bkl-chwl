package com.bkl.chwl.utils;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bkl.chwl.entity.User;
import com.bkl.chwl.service.UserService;
import com.bkl.chwl.service.impl.UserServiceImpl;
import com.km.common.utils.CookieUtil;

public class UserUtil {
	public static User getCurrentUser(HttpServletRequest request) throws UnsupportedEncodingException {
		UserService userServ = new UserServiceImpl();
//		String username = (String)request.getSession(true).getAttribute("username");
		String username =CookieUtil.getCookie("username", request);
		if(username==null){
			return null;
		}
		if(!username.contains("*")){
			return null;
		}
		String usernameSplit[]=username.split("\\*");
		User user = null;
		if (usernameSplit[0] != null) {
			user = userServ.findByMobile(usernameSplit[0]);
		}
		return user;
	}
	
	public static boolean islogin(HttpServletRequest request) throws UnsupportedEncodingException {
//		String username = (String)request.getSession(true).getAttribute("username");
		String username =CookieUtil.getCookie("username", request);
		if (username != null) {
			return true;
		}
		return false;
	}
	
	public static boolean checkSecretPassword(HttpServletRequest request) throws UnsupportedEncodingException {
		String tradePwd = request.getParameter("tradePwd");
		User user = UserUtil.getCurrentUser(request);
		if (!user.checkSecretPassword(tradePwd)) {
			return false;
		} else {
			return true;
		}
	}
	
	public static boolean isExistSecretPassword(HttpServletRequest request) throws UnsupportedEncodingException {
		User user = UserUtil.getCurrentUser(request);
		if (user.getSecret() == null || "".equals(user.getSecret().trim())) {
			return false;
		} else {
			return true;
		}
	}
}
