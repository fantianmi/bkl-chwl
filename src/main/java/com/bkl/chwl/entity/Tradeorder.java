package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;
import com.km.common.utils.TimeUtil;

@TableAonn(tableName="tradeorder")
public class Tradeorder {
	private long id;
	//到银行支付的订单号
	private String orderId;
	//支付用户id
	private long uid;
	//卖家id
	private long seller;
	//订单状态
	private int status;
	public static final int STATUS_WAIT=0;
	public static final int STATUS_SUCCESS=1;
	public static final int STATUS_FAIL=2;
	public static final int STATUS_ALL=3;
	
	//统计类型
	public static final int STATICS_ALL=0;
	//24小时收益
	public static final int STATICS_DAY=1;
	//1个月收益
	public static final int STATICS_MONTH=2;
	//3个月收益
	public static final int STATICS_3MONTH=3;
	//订单总价
	private double price;
	//银联还需要支付
	private double bankprice;
	//商家结算金额
	private double sellercoin;
	//是否需要返利
	private int type;
	//返利金币数
	private double coin;
	//创建订单时间
	private long ctime;
	//结算订单时间
	private long stime;
	public static final int PAYWAY_YUE=2;
	public static final int PAYWAY_YINLIAN=1;
	
	public static final int TYPE_NOPAYBACK=2;
	public static final int TYPE_PAYBACK=1;
	
	public double getSellercoin() {
		return sellercoin;
	}
	public void setSellercoin(double sellercoin) {
		this.sellercoin = sellercoin;
	}
	public String getOrderId() {
		return orderId;
	}
	public void setOrderId(String orderId) {
		this.orderId = orderId;
	}
	public double getBankprice() {
		return bankprice;
	}
	public void setBankprice(double bankprice) {
		this.bankprice = bankprice;
	}
	public long getCtime() {
		return ctime;
	}
	public String getCtimeString(){
		return TimeUtil.fromUnixTime(ctime);
	}
	public String getCtimeStringDate(){
		return TimeUtil.fromUnixTimeToDate(ctime);
	}
	public void setCtime(long ctime) {
		this.ctime = ctime;
	}
	public long getStime() {
		return stime;
	}
	public String getStimeString(){
		return TimeUtil.fromUnixTime(stime);
	}
	public String getStimeStringDate(){
		return TimeUtil.fromUnixTimeToDate(stime);
	}
	public void setStime(long stime) {
		this.stime = stime;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getUid() {
		return uid;
	}
	public void setUid(long uid) {
		this.uid = uid;
	}
	public long getSeller() {
		return seller;
	}
	public void setSeller(long seller) {
		this.seller = seller;
	}
	public int getStatus() {
		return status;
	}
	public String getStatusString(){
		if(status==this.STATUS_FAIL) return "<span class=\"label label-danger\">失败</span>";
		if(status==this.STATUS_SUCCESS) return "<span class=\"label label-info\">成功</span>";
		if(status==this.STATUS_WAIT) return "<span class=\"label label-danger\">待付</span>";
		return "未知";
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getType() {
		return type;
	}
	public String getTypeString(){
		if(type==this.TYPE_NOPAYBACK) return "无返利订单";
		return "普通订单";
	}
	public void setType(int type) {
		this.type = type;
	}
	public double getCoin() {
		return coin;
	}
	public void setCoin(double coin) {
		this.coin = coin;
	}
	
	
}
