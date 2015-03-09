package com.bkl.chwl.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.http.client.ClientProtocolException;

import com.bkl.chwl.entity.Tradeorder;
import com.bkl.chwl.entity.Tradeorder2Shop;
import com.bkl.chwl.vo.Report;
import com.km.common.vo.Page;
import com.km.common.vo.PageReply;

public interface OrderService {
	public long save(Tradeorder order);
	public long update(Tradeorder order,long id);
	//need update
	public List<Tradeorder> getList(long uid);
	public Map<String,Tradeorder> getMapBySeller(long seller);
	public List<Tradeorder> getListBySeller(long seller);
	public PageReply<Tradeorder> getListPage(long uid,int status,Page page);
	public PageReply<Tradeorder> getListShoperPage(long seller,int status,Page page,int staticsType);
	public PageReply<Tradeorder2Shop> getTradeorder2ShopListPage(long uid,int status,Page page);
	public Tradeorder2Shop getTradeorder2Shop(long id);
	public Tradeorder2Shop getTradeorder2ShopOrderId(String orderId);
	public Tradeorder get(long id);
	public long delete(long id);
	public Tradeorder getByOrderId(String orderId);
	public double getSUM(long uid);
	/**
	 * 处理订单
	 * @param orderId 订单id
	 * @return
	 * @throws IOException 
	 * @throws ClientProtocolException 
	 * @throws NumberFormatException 
	 */
	public boolean settleOrder(String orderId) throws NumberFormatException, ClientProtocolException, IOException;
	/**
	 * 按天统计商家结算详情，用于报表显示
	 * @return
	 */
	public List<Report> getOrderStatisticGroupByDay(String start,String end,int uid);
	/**
	 * 按指定日期查询结账详情
	 * @param time
	 * @return
	 */
	public List<Tradeorder> getOrdersByDay(String time,int uid);
	
}
