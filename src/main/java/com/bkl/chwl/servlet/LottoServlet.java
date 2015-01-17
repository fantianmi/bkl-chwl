package com.bkl.chwl.servlet;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.baiyi.domain.LotteryEntity;
import com.baiyi.domain.UserInfoEntity;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.utils.ApiCommon;
import com.bkl.chwl.utils.UserUtil;
import com.km.common.servlet.CommonServlet;
import com.km.common.utils.ServletUtil;



public class LottoServlet extends CommonServlet {
	
	public void getLottoInfo(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User u=UserUtil.getCurrentUser(request);
		UserInfoEntity userInfo=ApiCommon.getUserInfo(u.getId());
		int lottoTime=userInfo.getLotteryTime();
		ServletUtil.writeOkCommonReply(lottoTime, response);
	}
	
	public void doLottoInfo(HttpServletRequest request,HttpServletResponse response) throws Exception{
		User u=UserUtil.getCurrentUser(request);
		System.out.println(u.getId());
		LotteryEntity lotto=ApiCommon.doLotto(u.getId());
		ServletUtil.writeOkCommonReply(lotto, response);
	}
	
}
