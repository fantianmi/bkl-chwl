package com.bkl.chwl.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import com.baiyi.data.model.User2;
import com.bkl.chwl.service.RecommendService;
import com.bkl.chwl.vo.Fans;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;


public class RecommendServiceImpl implements RecommendService {

	@Override
	public Map<Integer, Fans> getShopFansProfileMap(List<User2> users) {
		GeneralDao<Fans> fansDao=DaoFactory.createGeneralDao(Fans.class);
		String uidRange="";
		if(users.size()==0){
			return null;
		}
		for(User2 u:users){
			uidRange+=u.getUid()+",";
		}
		Map<Integer, Fans> map=new HashMap<Integer, Fans>();
		String sql="select sum(price) as profile,seller as uid from tradeorder where status=1 and seller in ("+uidRange+"0) group by seller";
		List<Fans> fans=fansDao.findList(sql, null);
		for(Fans fan:fans){
			map.put((int) fan.getUid(), fan);
		}
		return map;
	}
	

}
