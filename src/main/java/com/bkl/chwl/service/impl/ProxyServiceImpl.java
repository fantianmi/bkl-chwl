package com.bkl.chwl.service.impl;

import java.util.Map;

import com.bkl.chwl.entity.Area;
import com.bkl.chwl.entity.Proxy2User;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.service.ProxyService;
import com.bkl.chwl.utils.ApiCommon;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;

public class ProxyServiceImpl implements ProxyService {
	GeneralDao<Area> areaDao=DaoFactory.createGeneralDao(Area.class);

	@Override
	public PageReply<Proxy2User> getProxyList(Map searchMap, Page page) {
		GeneralDao<Proxy2User> proxy2userDao=DaoFactory.createGeneralDao(Proxy2User.class);
		String sql="Select a.*,u.mobile, u.name from area a left join user u on  a.id=u.proxy2_cid and u.proxy2="+User.PROXY_TRUE+" where a.reid in (Select id from area where reid=0) order by a.reid desc";
		return proxy2userDao.getPage(sql, page, searchMap);
	}
	
	public PageReply<Proxy2User> getProxyListProvince(Map searchMap, Page page) {
		GeneralDao<Proxy2User> proxy2userDao=DaoFactory.createGeneralDao(Proxy2User.class);
		String sql="Select a.*,u.mobile, u.name from area a left join user u on  a.id=u.proxy_cid and u.proxy="+User.PROXY_TRUE+" where a.reid=0 order by a.reid desc";
		return proxy2userDao.getPage(sql, page, searchMap);
	}

	@Override
	public boolean setProxy(long uid, int local, int local2,int type,long ruid) {
		if(type==User.PROXY_TYPE_PROVINCE){
			if(uid==0||local==0) return false;
		}else if(type==User.PROXY_TYPE_CITY){
			if(uid==0||local==0||local2==0) return false;
		}
		
		GeneralDao<User> userDao=DaoFactory.createGeneralDao(User.class);
		User u=userDao.find(uid);
		if(type==u.PROXY_TYPE_PROVINCE){
			u.setProxy_cid(local);
			u.setProxy(u.PROXY_TRUE);
			userDao.save(u);
			return ApiCommon.setProxy(uid, local, local2,type,ruid);
		}else if(type==u.PROXY_TYPE_CITY){
			u.setProxy2_cid(local2);
			u.setProxy2(u.PROXY_TRUE);
			userDao.save(u);
			return ApiCommon.setProxy(uid, local, local2,type,ruid);
		}
		return false;
	}
}
