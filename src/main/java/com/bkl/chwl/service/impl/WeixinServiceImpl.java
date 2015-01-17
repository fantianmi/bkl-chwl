package com.bkl.chwl.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Test;

import com.bkl.chwl.entity.Area;
import com.bkl.chwl.entity.Weixin;
import com.bkl.chwl.service.WeixinService;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.DbUtil;
import com.km.common.vo.Condition;

public class WeixinServiceImpl implements WeixinService {
	GeneralDao<Weixin> weixinDao=DaoFactory.createGeneralDao(Weixin.class);
	public long saveWeixin(Weixin weixin) {
		return weixinDao.save(weixin);
	}
	public Weixin getWeixin() {
		String sql="select * from weixin order by id desc limit 1";
		return weixinDao.findSql(sql, null);
	}
}
