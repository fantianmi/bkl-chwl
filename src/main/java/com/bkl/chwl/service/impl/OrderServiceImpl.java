package com.bkl.chwl.service.impl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.bkl.chwl.entity.Tradeorder;
import com.bkl.chwl.entity.Tradeorder2Shop;
import com.bkl.chwl.service.OrderService;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.DbUtil;
import com.km.common.vo.Condition;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;

public class OrderServiceImpl implements OrderService {
	GeneralDao<Tradeorder> orderDao=DaoFactory.createGeneralDao(Tradeorder.class);
	public long save(Tradeorder area) {
		return orderDao.save(area);
	}

	public long update(Tradeorder area, long id) {
		return orderDao.update(area,id);
	}

	public List<Tradeorder> getList(long uid) {
		Condition uidCon=DbUtil.generalEqualWhere("uid", uid);
		return orderDao.findList(new Condition[]{uidCon}, new String[]{"title desc"});
	}

	public Tradeorder get(long id) {
		return orderDao.find(id);
	}

	public long delete(long id) {
		return orderDao.delete(id);
	}

	public PageReply<Tradeorder> getListPage(long uid,int status,Page page) {
		Condition uidCon=DbUtil.generalEqualWhere("uid", uid);
		Condition[] conditions={uidCon};
		if(status!=Tradeorder.STATUS_ALL){
			Condition statusCon=DbUtil.generalEqualWhere("status", status);
			conditions=Arrays.copyOf(conditions, conditions.length+1);
			conditions[conditions.length-1]=statusCon;
		}
		return orderDao.getPage(page, conditions, new String[]{});
	}

	public Tradeorder getByOrderId(String orderId) {
		Condition orderIdCon=DbUtil.generalEqualWhere("orderId", orderId);
		return orderDao.find(new Condition[]{orderIdCon}, new String[]{});
	}

	@Override
	public PageReply<Tradeorder2Shop> getTradeorder2ShopListPage(long uid,
			int status, Page page) {
		GeneralDao<Tradeorder2Shop> order2shopDao=DaoFactory.createGeneralDao(Tradeorder2Shop.class);
		String sql="select t.*,s.id as shop_id,s.title as shop_title,s.detail as shop_detail,s.oprice as shop_oprice,s.price as shop_price,s.image as shop_image from tradeorder t left join shop s on t.seller=s.uid where t.uid="+uid;
		if(status!=Tradeorder.STATUS_ALL){
			sql+=" and t.status="+status;
		}
		sql+=" order by t.id desc";
		return order2shopDao.getPage(page, sql);
	}

	@Override
	public Tradeorder2Shop getTradeorder2Shop(long id) {
		GeneralDao<Tradeorder2Shop> order2shopDao=DaoFactory.createGeneralDao(Tradeorder2Shop.class);
		String sql="select t.*,s.id as shop_id,s.title as shop_title,s.detail as shop_detail,s.oprice as shop_oprice,s.price as shop_price,s.image as shop_image from tradeorder t left join shop s on t.seller=s.uid where t.id="+id;
		return order2shopDao.findSql(sql, null);
	}
	public Tradeorder2Shop getTradeorder2ShopOrderId(String orderId) {
		GeneralDao<Tradeorder2Shop> order2shopDao=DaoFactory.createGeneralDao(Tradeorder2Shop.class);
		String sql="select t.*,s.id as shop_id,s.title as shop_title,s.detail as shop_detail,s.oprice as shop_oprice,s.price as shop_price,s.image as shop_image from tradeorder t left join shop s on t.seller=s.uid where t.orderId='"+orderId+"'";
		return order2shopDao.findSql(sql, null);
	}

	@Override
	public Map<String, Tradeorder> getListBySeller(long seller) {
		Condition sellerCon=DbUtil.generalEqualWhere("seller", seller);
		List<Tradeorder> orders=orderDao.findList(new Condition[]{sellerCon}, new String[]{});
		Map<String,Tradeorder> map=new HashMap<String, Tradeorder>();
		for(Tradeorder oder:orders){
			map.put( oder.getOrderId(), oder);
		}
		return map;
	}

	@Override
	public double getSUM(long uid) {
		String sql="select sum(price) from tradeorder where uid=? and status=1";
		return orderDao.queryDouble(sql, new Long[]{uid});
	}

}
