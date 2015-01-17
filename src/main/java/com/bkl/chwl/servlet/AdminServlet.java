package com.bkl.chwl.servlet;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bkl.chwl.entity.AdminUser;
import com.bkl.chwl.entity.Cash;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.service.CashService;
import com.bkl.chwl.service.UserService;
import com.bkl.chwl.service.impl.CashServiceImpl;
import com.bkl.chwl.service.impl.UserServiceImpl;
import com.bkl.chwl.utils.AdminUserUtil;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.servlet.CommonServlet;
import com.km.common.utils.ServletUtil;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;
import com.km.common.vo.RetCode;

public class AdminServlet extends CommonServlet {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 激活用户
	 * TODO 重复激活
	 */
	public void activeUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		long userId = Long.parseLong(request.getParameter("id"));
		GeneralDao<User> userDao = DaoFactory.createGeneralDao(User.class);
		User user = userDao.find(userId);
		if (user != null) {
			user.setEmail_validated(1);
			userDao.update(user);
		}
		ServletUtil.writeOkCommonReply("", response);
	}
	/**
	 * 禁用/启用用户
	 * TODO 重复禁用/启用
	 */
	public void frozen(HttpServletRequest request, HttpServletResponse response) throws Exception {
		long userId = Long.parseLong(request.getParameter("id"));
		int frozen = Integer.parseInt(request.getParameter("frozen"));
		GeneralDao<User> userDao = DaoFactory.createGeneralDao(User.class);
		User user = userDao.find(userId);
		if (user != null && frozen != user.getFrozen()) {
			user.setFrozen(frozen);
			userDao.update(user);
		}
		ServletUtil.writeOkCommonReply("", response);
	}
	
	/**
	 * 商家通过审核
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void vertify(HttpServletRequest request, HttpServletResponse response) throws Exception {
		long userId = Long.parseLong(request.getParameter("id"));
		GeneralDao<User> userDao = DaoFactory.createGeneralDao(User.class);
		User user = userDao.find(userId);
		if (user != null) {
			user.setVertify(user.VERTIFY_TRUE);
			userDao.update(user);
		}
		ServletUtil.writeOkCommonReply("", response);
	}
	
	/**
	 * 确认/否定实名验证
	 * status=1表示确认;status=2表示否定
	 */
	public void confirmRealName(HttpServletRequest request, HttpServletResponse response) throws Exception {
		long userId = Long.parseLong(request.getParameter("id"));
		int status = Integer.parseInt(request.getParameter("status"));
		GeneralDao<User> userDao = DaoFactory.createGeneralDao(User.class);
		User user = userDao.find(userId);
		if (user != null && user.getRealname_validated() == 0) {
			user.setRealname_validated(status);
			userDao.update(user);
		}
		ServletUtil.writeOkCommonReply("", response);
	}
		
	
	/***
	 * 查询用户
	 */
	public void getUserDetail(HttpServletRequest request, HttpServletResponse response) throws Exception {
		long id = 0;
		try {
			id = Long.parseLong(request.getParameter("id"));
		} catch (NumberFormatException e) {
			e.fillInStackTrace();
		}
		GeneralDao<User> userDao = DaoFactory.createGeneralDao(User.class);
		User user = null;
		if (id > 0) {
			user = userDao.find(id);
		}
		ServletUtil.writeOkCommonReply(user, response);
	}	
	
	/***
	 * 确定人民币提现
	 */
	public void confirmWithdraw(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Cash cash = ServletUtil.readObjectServletQuery(request,Cash.class);
		CashService cashServ = new CashServiceImpl();
		AdminUser adminUser = AdminUserUtil.getCurrentUser(request);
		System.out.println(cash.getId());
		System.out.println(adminUser.getId());
		RetCode ret = cashServ.doWithdraw(cash.getId(), adminUser.getId());
		ServletUtil.writeCommonReply(null,ret, response);
	}
	
	/***
	 * 取消人民币提现
	 */
	public void cancelWithdraw(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		Cash cash = ServletUtil.readObjectServletQuery(request,Cash.class);
		CashService cashServ = new CashServiceImpl();
		AdminUser adminUser = AdminUserUtil.getCurrentUser(request);
		RetCode ret = cashServ.doCancelWithdraw(cash.getId(), adminUser.getId());
		ServletUtil.writeCommonReply(null,ret, response);
	}
	
	/***
	 * 分页查询用户
	 */
	public void getUserList(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map searchMap = ServletUtil.getSearchMap(request);
		UserService userSrv = new UserServiceImpl();
		Page page = ServletUtil.getPage(request);
		PageReply<User> users = userSrv.findUser(searchMap, page);
		ServletUtil.writeOkCommonReply(users, response);
	}	
}
