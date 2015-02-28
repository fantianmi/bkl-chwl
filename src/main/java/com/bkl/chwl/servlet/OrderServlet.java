package com.bkl.chwl.servlet;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.bkl.chwl.entity.Tradeorder;
import com.bkl.chwl.entity.Tradeorder2Shop;
import com.bkl.chwl.entity.User;
import com.bkl.chwl.service.OrderService;
import com.bkl.chwl.service.ShopService;
import com.bkl.chwl.service.UserService;
import com.bkl.chwl.service.impl.OrderServiceImpl;
import com.bkl.chwl.service.impl.ShopServiceImpl;
import com.bkl.chwl.service.impl.UserServiceImpl;
import com.bkl.chwl.utils.ApiCommon;
import com.bkl.chwl.utils.FrontUtil;
import com.bkl.chwl.utils.StringUtil;
import com.bkl.chwl.utils.UserUtil;
import com.km.common.dao.DaoFactory;
import com.km.common.dao.GeneralDao;
import com.km.common.servlet.CommonServlet;
import com.km.common.utils.DbUtil;
import com.km.common.utils.ServletUtil;
import com.km.common.utils.TimeUtil;
import com.km.common.vo.Condition;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;
import com.km.common.vo.RetCode;

public class OrderServlet extends CommonServlet {
	public void addOrder(HttpServletRequest request,HttpServletResponse response) throws Exception{
		OrderService orderServ = new OrderServiceImpl();
		Tradeorder order=ServletUtil.readObjectServletQuery(request, Tradeorder.class);
		User user=UserUtil.getCurrentUser(request);
		if(user.getId()==order.getSeller()){
			ServletUtil.writeCommonReply(null, RetCode.SELF_TRADE_ERROR, response);
			return;
		}
		order.setBankprice(order.getPrice());
		order.setOrderId(TimeUtil.getNowDateTime4NotSplit());
		double coinRate=Double.valueOf(request.getParameter("coinRate"));
		//计算让利金币数
		double paybackCoin=order.getPrice()*coinRate;
		order.setCoin(paybackCoin);
		int payway=Integer.valueOf(request.getParameter("payway"));
		order.setUid(user.getId());
		double userCoin=ApiCommon.getUserCoin(user.getId());
		//如果是余额支付则先用余额支付，在提交订单到银联支付
		/*if(payway==order.PAYWAY_YUE){
			if(userCoin>=order.getPrice()){
				if(!ApiCommon.translate(user.getId(), order.getSeller(), (int)order.getPrice())){
					ServletUtil.writeCommonReply(null, RetCode.ROMOTE_ERROR, response);
					return;
				}
				//订单完结
				order.setBankprice(0);
				order.setStatus(order.STATUS_SUCCESS);
				order.setCtime(TimeUtil.getUnixTime());
				order.setStime(TimeUtil.getUnixTime());
				ApiCommon.createOrder(user.getId(), order.getSeller(), (int)paybackCoin, order.getOrderId(), order.getType());
				orderServ.save(order);
				ServletUtil.writeOkCommonReply(order, response);
				return;
			}else if(userCoin<order.getPrice()&&userCoin!=0){
				if(!ApiCommon.translate(user.getId(), order.getSeller(), (int)userCoin)){
					ServletUtil.writeCommonReply(null, RetCode.ROMOTE_ERROR, response);
					return;
				}
				order.setBankprice(order.getPrice()-userCoin);
			}
		}*/
		order.setCtime(TimeUtil.getUnixTime());
		order.setStatus(order.STATUS_WAIT); 
		order.setType(order.TYPE_PAYBACK);
		orderServ.save(order);
		ServletUtil.writeCommonReply(order, RetCode.NEED_REDIRECT_BANK, response);
		return;
	}
	public void settleOrder(HttpServletRequest request,HttpServletResponse response) throws Exception{
		String orderId=request.getParameter("orderId");
		OrderService orderServ = new OrderServiceImpl();
		//找到订单，改变订单状态
		Tradeorder o = orderServ.getByOrderId(orderId);
		if(o.getStatus()==o.STATUS_WAIT){
			o.setStatus(o.STATUS_SUCCESS);
			o.setStime(TimeUtil.getUnixTime());
			orderServ.save(o);
			//调用webapi创建订单
			ApiCommon.createOrder(o.getUid(), o.getSeller(), o.getCoin(), orderId, o.getType());
			ShopService shopServ=new ShopServiceImpl();
			shopServ.addSellNun(o.getSeller());
		}
		UserService userServ=new UserServiceImpl();
		
		User u=userServ.get(o.getUid());
		int res=0;
		/*if(u!=null){
			res=SendMsgInWeixin.sendOrderMessage(u, o,);
		}*/
		ServletUtil.writeOkCommonReply(res, response);
	}
	
	public void getOrderListHTML(HttpServletRequest request,HttpServletResponse response) throws Exception{
		int status=Tradeorder.STATUS_SUCCESS;
		if(request.getParameter("status")!=null){
			status=Integer.parseInt(request.getParameter("status"));
		}
		User u = UserUtil.getCurrentUser(request);
		OrderService orderServ=new OrderServiceImpl();
		Page page=ServletUtil.getPage(request);
		PageReply<Tradeorder2Shop> orders=orderServ.getTradeorder2ShopListPage(u.getId(),status,page);
		
		if(request.getParameter("pagenum")!=null){
			if(Integer.parseInt(request.getParameter("pagenum"))>orders.getTotalpage()){
				ServletUtil.writeOkCommonReply("", response);
				return;
			}
		}
		String result="";
		if(orders.getPagedatas() == null || orders.getPagedatas().length == 0) { 
			result="no data";
		}else{
			for (int i = 0; i < orders.getPagedatas().length; i++) {
				Tradeorder2Shop s = orders.getPagedatas()[i];
				result+="<a href=\"user_order_detail.jsp?orderId="+s.getOrderId()+"\"><div class='tableList downborder'><div class='list_left'>"+s.getCtimeStringDate()+"</div><div class='list_middle'>"+StringUtil.subString(s.getShop_title(), 10)+"</div><div class='list_right'>"+FrontUtil.formatRmbDouble(s.getPrice())+"元"+s.getStatusString()+"</div></div></a>";
			}
		}
		Map map=new HashMap();
		map.put("result", result);
		map.put("hasmore", true);
		if(orders.getTotalpage()==orders.getPagenum()){
			map.put("hasmore", false);
		}
		ServletUtil.writeOkCommonReply(map, response);
	}
	
	public void caculateSellecoin(HttpServletRequest request,HttpServletResponse response) throws Exception{
		GeneralDao<Tradeorder> orderDao=DaoFactory.createGeneralDao(Tradeorder.class);
		Condition statusCon=DbUtil.generalEqualWhere("status", 1);
		List<Tradeorder> orders=orderDao.findList(new Condition[]{statusCon}, new String[]{});
		for(Tradeorder order:orders){
			order.setSellercoin(order.getPrice()-order.getCoin()-order.getPrice()*0.006);
			orderDao.save(order);
		}
		ServletUtil.writeOkCommonReply(null, response);
	}
	
}
