package com.bkl.chwl.service.impl;

import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.http.client.ClientProtocolException;

import com.baiyi.util.WebApi;
import com.bkl.chwl.MainConfig;
import com.bkl.chwl.entity.Tradeorder;
import com.bkl.chwl.entity.Tradeorder2Shop;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.entity.User2BindCard;
import com.bkl.chwl.service.BindCardService;
import com.bkl.chwl.service.OrderService;
import com.bkl.chwl.service.ShopService;
import com.bkl.chwl.service.UserService;
import com.bkl.chwl.servlet.OpenServlet;
import com.bkl.chwl.utils.ApiCommon;
import com.bkl.chwl.utils.RequestUtil;
import com.bkl.chwl.utils.SendMsgInWeixin;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.utils.DbUtil;
import com.km.common.utils.TimeUtil;
import com.km.common.vo.Condition;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;

public class OrderServiceImpl implements OrderService {
	
	private Log log = LogFactory.getLog(OrderServiceImpl.class);
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
	public double getSUM(long uid) {
		String sql="select sum(price) from tradeorder where uid=? and status=1";
		return orderDao.queryDouble(sql, new Long[]{uid});
	}

	@Override
	public boolean settleOrder(String orderId) throws NumberFormatException, ClientProtocolException, IOException {
		OrderService orderServ = new OrderServiceImpl();
		//找到订单，改变订单状态
		Tradeorder o = orderServ.getByOrderId(orderId);
		if(o.getStatus()==o.STATUS_WAIT){
			o.setStatus(o.STATUS_SUCCESS);
			o.setStime(TimeUtil.getUnixTime());
			orderServ.save(o);
			//调用webapi创建订单
			//消费者清分
			ApiCommon.createOrder(o.getUid(), o.getSeller(), o.getCoin(), orderId, 1);
			ShopService shopServ=new ShopServiceImpl();
			shopServ.addSellNun(o.getSeller());
			//商家清算
			double sellerCoin=o.getPrice()-o.getCoin()-o.getPrice()*0.006;
			if(MainConfig.getNeedpayOrder()==1)//需要直接到商家账户
			{
				BindCardService bindcardServ=new BindCardServiceImpl();
				User2BindCard bindCard=bindcardServ.getDefult(o.getSeller());
				if(bindCard==null)//如果为空则调用order
				{
					ApiCommon.createOrder(o.getSeller(), o.getSeller(), sellerCoin, orderId, 2);
				}//不为空调用payorder
				else{
					WebApi.payOrder((int)o.getSeller(), Integer.parseInt(orderId), 1, (float)sellerCoin, bindCard.getBank_account_o(), bindCard.getName(), bindCard.getBank_deposit_o(), bindCard.getBank_number(), bindCard.getPhone_o(), "dxw_account");
				}
			}//不需要到商家账户
			else{
				ApiCommon.createOrder(o.getSeller(), o.getSeller(), sellerCoin, orderId, 2);
			}
		}
		UserService userServ=new UserServiceImpl();
		//发送订单号给商家和用户
		User u=userServ.get(o.getUid());
		User seller=userServ.get(o.getSeller());
		int res=0;
		int res2=0;
		if(u!=null){
			res=SendMsgInWeixin.sendOrderMessage(u, o,SendMsgInWeixin.SEND_TYPE_BUYER);
			res2=SendMsgInWeixin.sendOrderMessage(seller,o,SendMsgInWeixin.SEND_TYPE_SELLER);
		}
		log.info("支付成功，发送微信消息，买家openid："+u.getOpenid()+"卖家openid:"+seller.getOpenid());
		log.info("发送结果:"+res+"----"+res2);
		return true;
	}

	@Override
	public Map<String, Tradeorder> getMapBySeller(long seller) {
		Condition sellerCon=DbUtil.generalEqualWhere("seller", seller);
		List<Tradeorder> orders=orderDao.findList(new Condition[]{sellerCon}, new String[]{});
		Map<String,Tradeorder> map=new HashMap<String, Tradeorder>();
		for(Tradeorder oder:orders){
			map.put( oder.getOrderId(), oder);
		}
		return map;
	}

	@Override
	public List<Tradeorder> getListBySeller(long seller) {
		Condition sellerCon=DbUtil.generalEqualWhere("seller", seller);
		Condition statusCon=DbUtil.generalEqualWhere("status", Tradeorder.STATUS_SUCCESS);
		List<Tradeorder> orders=orderDao.findList(new Condition[]{sellerCon,statusCon}, new String[]{});
		return orders;
	}

	@Override
	public PageReply<Tradeorder> getListShoperPage(long seller, int status,
			Page page) {
		Condition uidCon=DbUtil.generalEqualWhere("seller", seller);
		Condition[] conditions={uidCon};
		if(status!=Tradeorder.STATUS_ALL){
			Condition statusCon=DbUtil.generalEqualWhere("status", status);
			conditions=Arrays.copyOf(conditions, conditions.length+1);
			conditions[conditions.length-1]=statusCon;
		}
		return orderDao.getPage(page, conditions, new String[]{});
	}

}
