package com.bkl.chwl.service.impl;

import java.util.Arrays;
import java.util.Map;

import org.junit.Test;

import com.bkl.chwl.MainConfig;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.entity.User2Shop;
import com.bkl.chwl.service.UserService;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.DbUtil;
import com.km.common.utils.MD5Util;
import com.km.common.vo.Condition;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;
import com.km.common.vo.RetCode;

public class UserServiceImpl implements UserService {
	GeneralDao<User> dao = DaoFactory.createGeneralDao(User.class);
	public UserServiceImpl() {
		
	}

	@Override
	public Long save(User user) {
		return dao.save(user);
	}
	
	@Override
	public Long createUser(User user) {
		user.saveMD5Password(user.getPassword());
		if (!this.existMobile(user.getMobile())) {
			System.out.println(user.getId());
			System.out.println(user.getMobile());
			System.out.println(user.getPassword());
			Long id = save(user);
			return id;
		}
		return 0L;
	}
	
	@Override
	public User get(long id) {
		return dao.find("id", id);
	}
	
	@Override
	public User find(String email) {
		return dao.find("email", email);
	}

	public User findByMobile(String mobile){
		Condition mobileCon = DbUtil.generalEqualWhere("mobile", mobile);
		return dao.find(new Condition[]{mobileCon}, null);
	}
	
	public User findByLicence(String licenceNumber){
		Condition licenceNumberCon = DbUtil.generalEqualWhere("licenceNumber", licenceNumber);
		return dao.find(new Condition[]{licenceNumberCon}, null);
	}
	
	public User findByMobile2(String mobile2){
		Condition mobile2Con = DbUtil.generalEqualWhere("mobile2", mobile2);
		Condition roleCon = DbUtil.generalEqualWhere("role", User.ROLE_SHOPER);
		return dao.find(new Condition[]{roleCon,mobile2Con}, null);
	}
	
	
	@Override
	public User findByBtcAddr(String btcAddr) {
		return dao.find("btc_in_addr", btcAddr);
	}

	@Override
	public User findByLtcAddr(String btcAddr) {
		return dao.find("ltc_in_addr", btcAddr);
	}
	@Override
	public RetCode login(String email, String password) {
		User user = find(email);
		if (user == null) {
			return RetCode.USERNAME_OR_PASSWORD_ERROR;
		}
		if (user.getEmail_validated() == 0 && !MainConfig.isCnVersion()) {
			return RetCode.USER_NOT_ACTIVE;
		}
		if (user.getPassword().equals(MD5Util.md5(password))) {
			return RetCode.OK;
		} 
		return RetCode.USERNAME_OR_PASSWORD_ERROR;
	}

	@Override
	public boolean exist(String username) {
		User user = find(username);
		return user != null;
	}
	
	public boolean existMobile(String mobile){
		User user = this.findByMobile(mobile);
		return user!=null;
	}
	
	public boolean existLicence(String licenceNumber) {
		User user=this.findByLicence(licenceNumber);
		return user!=null;
	}
	
	public boolean existMobile2(String mobile) {
		User user=this.findByMobile2(mobile);
		return user!=null;
	}
	
	
	@Override
	public PageReply<User> findUser(Map searchMap, Page page) {
		GeneralDao<User> dao = DaoFactory.createGeneralDao(User.class);
		PageReply<User> users = dao.getPage(page, searchMap);
		return users;
	}
	
	public PageReply<User> findUser(int role,Map searchMap, Page page) {
		GeneralDao<User> dao = DaoFactory.createGeneralDao(User.class);
		Condition[] conditions={};
		if(role!=0){
			Condition typeCon=DbUtil.generalEqualWhere("role", role);
			conditions=Arrays.copyOf(conditions, conditions.length+1);
			conditions[conditions.length-1]=typeCon;
		}
		PageReply<User> users = dao.getPage(page,conditions, new String[]{}, searchMap);
		return users;
	}
	
	public PageReply<User2Shop> findUser2Shop(int role,Map searchMap, Page page){
		String sql="select u.*,s.id as shop_id,s.title as shop_title from user u left join shop s on u.id=s.uid where role="+role;
		GeneralDao<User2Shop> dao = DaoFactory.createGeneralDao(User2Shop.class);
		PageReply<User2Shop> users = dao.getPage(sql, page, searchMap);
		return users;
	}
	

	public User findPin(String pin) {
		Condition pinCon=DbUtil.generalEqualWhere("pin", pin);
		GeneralDao<User> userDao = DaoFactory.createGeneralDao(User.class);
		return userDao.find(new Condition[]{pinCon}, null);
	}

	@Override
	public long modifyUser(User user, long id) {
		GeneralDao<User> userDao = DaoFactory.createGeneralDao(User.class);
		return userDao.update(user, id);
	}

	@Override
	public long maxUserID() {
		String sql="select max(id) from user";
		long maxid=1001;
		
		if(dao.queryLong(sql, null)!=null){
			maxid=dao.queryLong(sql, null);
		}
		return maxid;
	}
	@Test
	public void maxUserIDTEST(){
		System.out.println(maxUserID());
	}

	@Override
	public int countUser(int role) {
		String sql="select count(*) from user where 1=1";
		if(role!=0){
			sql+=" and role="+role;
		}
		return dao.queryIngeger(sql,null);
	}

	@Override
	public User findByIdentity_no(String identity_no) {
		Condition identity_noCon = DbUtil.generalEqualWhere("identity_no", identity_no);
		Condition roleCon = DbUtil.generalEqualWhere("role", User.ROLE_NORMAL);
		return dao.find(new Condition[]{identity_noCon,roleCon}, null);
	}

	@Override
	public boolean exisetIdentity_no(String identity_no) {
		User user = findByIdentity_no(identity_no);
		return user != null;
	}


	
	


}
