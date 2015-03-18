package com.bkl.chwl.service;

import java.util.Map;

import com.bkl.chwl.entity.ErrorOrder;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;

public interface ErrorOrderService {
	public long saveErrorOrder(ErrorOrder e);
	public ErrorOrder getErrorOrder(long id);
	public long confirmErrorOrder(ErrorOrder e);
	public PageReply<ErrorOrder> getErrorOrderPage(Map searchMap, Page page);
	public ErrorOrder getErrorOrderByOrderId(String orderid);
}
