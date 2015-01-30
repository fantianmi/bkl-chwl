package com.bkl.chwl.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.apache.http.client.ClientProtocolException;

import com.bkl.chwl.entity.Tradeorder;
import com.bkl.chwl.entity.Tradeorder2Shop;
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
	public PageReply<Tradeorder> getListShoperPage(long seller,int status,Page page);
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
}
