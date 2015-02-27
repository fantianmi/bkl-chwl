package com.bkl.chwl.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class KaptchaCheck {
	public static boolean check(HttpServletRequest request){
		HttpSession session = request.getSession();
		String c = (String)session.getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);
		String parm = (String) request.getParameter("kaptchafield");
		if (c != null && parm != null) {
			if (c.equals(parm)) {
				return true;
			} else {
				return false;
			}
		}
		return false;
	}

}
