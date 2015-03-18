package com.bkl.chwl.service.impl;

import java.util.Map;

import com.bkl.chwl.entity.ErrorOrder;
import com.bkl.chwl.service.ErrorOrderService;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.DbUtil;
import com.km.common.vo.Condition;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;

public class ErrorOrderServiceImpl implements ErrorOrderService {
	GeneralDao<ErrorOrder> errorOrderDao=DaoFactory.createGeneralDao(ErrorOrder.class);
	public long saveErrorOrder(ErrorOrder e) {
		return errorOrderDao.save(e);
	}

	public ErrorOrder getErrorOrder(long id) {
		return errorOrderDao.find(id);
	}

	public long confirmErrorOrder(ErrorOrder e) {
		e.setStatus(e.STATUS_CONFIREM);
		return errorOrderDao.save(e);
	}

	public PageReply<ErrorOrder> getErrorOrderPage(Map searchMap, Page page) {
		return errorOrderDao.getPage(page, searchMap);
	}

	public ErrorOrder getErrorOrderByOrderId(String orderid) {
		Condition orderIdCon=DbUtil.generalEqualWhere("orderid", orderid);
		return errorOrderDao.find(new Condition[]{orderIdCon},new String[]{});
	}

}
