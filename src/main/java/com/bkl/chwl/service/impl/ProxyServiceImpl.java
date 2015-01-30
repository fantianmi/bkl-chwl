package com.bkl.chwl.service.impl;

import java.util.Map;

import com.bkl.chwl.entity.Area;
import com.bkl.chwl.entity.Proxy;
import com.bkl.chwl.entity.Proxy2User;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.service.ProxyService;
import com.bkl.chwl.utils.ApiCommon;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.DbUtil;
import com.km.common.vo.Condition;
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
	public boolean setProxy(long uid, int city, int area,int type,long ruid) {
		if(type==Proxy.PROXYTYPE_CITY){
			if(uid==0||city==0) return false;
		}else if(type==Proxy.PROXYTYPE_AREA){
			if(uid==0||city==0||area==0) return false;
		}
		return ApiCommon.setProxy(uid, city, area,type,ruid);
	}

	@Override
	public PageReply<Proxy2User> getProxyList(int proxytype,Map searchMap,Page page) {
		GeneralDao<Proxy2User> proxy2userDao=DaoFactory.createGeneralDao(Proxy2User.class);
		String sql="select a.id,a.title,a.reid,u.id as uid,u.mobile,u.name,p.ctime as ctime,p.parent from proxy p left join area a on p.aid=a.id left join user u on p.uid=u.id where p.proxytype="+proxytype;
		return proxy2userDao.getPage(sql, page, searchMap);
	}

	@Override
	public boolean HaveProxy(long aid) {
		GeneralDao<Proxy> proxyDao=DaoFactory.createGeneralDao(Proxy.class);
		Condition aidCon=DbUtil.generalEqualWhere("aid", aid);
		return proxyDao.find(new Condition[]{aidCon}, new String[]{})!=null;
	}
	
	public Proxy getProxy(long aid) {
		GeneralDao<Proxy> proxyDao=DaoFactory.createGeneralDao(Proxy.class);
		Condition aidCon=DbUtil.generalEqualWhere("aid", aid);
		return proxyDao.find(new Condition[]{aidCon}, new String[]{});
	}

	@Override
	public long saveProxy(Proxy proxy) {
		GeneralDao<Proxy> proxyDao=DaoFactory.createGeneralDao(Proxy.class);
		return proxyDao.save(proxy);
	}
}
