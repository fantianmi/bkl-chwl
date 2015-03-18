package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;
import com.km.common.utils.TimeUtil;

/**
 * 问题订单列表
 * @author mao
 *
 */
@TableAonn(tableName="errororder")
public class ErrorOrder {
	private long id;
	private String orderid;
	private long uid;
	private int ordertype;
	public static int ORDERTYPE_TRADE=1;
	public static int ORDERTYPE_WITHDRAW=2;
	
	private String name;
	private String bankaccount;
	private String bankdeposit;
	private String phone;
	private String banknumber;
	private double coin;
	private long ctime;
	private int status;
	public static int STATUS_UNCONFIREM=0;
	public static int STATUS_CONFIREM=1;
	
	//constract
	public ErrorOrder(){}
	
	public ErrorOrder(Cash cash,User user,UserBindCard card){
		this.uid=cash.getUser_id();
		this.orderid=cash.getOrderId();
		this.ordertype=ORDERTYPE_WITHDRAW;
		if(card.getBindtype()==card.BINDTYPE_PRIVATE){
			this.name=user.getName();
		}else if(card.getBindtype()==card.BINDTYPE_PUBLIC){
			this.name=user.getLicenceRegName();
		}else{
			this.name="未知";
		}
		this.bankaccount=cash.getCard();
		this.bankdeposit=cash.getBank();
		this.phone=cash.getMobile();
		this.banknumber=cash.getBank_number();
		this.coin=cash.getAmount();
		this.ctime=TimeUtil.getUnixTime();
		this.status=STATUS_UNCONFIREM;
	}
	
	public ErrorOrder convertOrdertype(ErrorOrder e,User2BindCard bindcard){
		if(bindcard.getBindtype()==UserBindCard.BINDTYPE_PRIVATE){
			e.setName(bindcard.getName());
		}else if(bindcard.getBindtype()==UserBindCard.BINDTYPE_PUBLIC){
			e.setName(bindcard.getLicenceRegName());
		}else{
			e.setName("未知");
		}
		return e;
	}
	
	public long getUid() {
		return uid;
	}

	public void setUid(long uid) {
		this.uid = uid;
	}

	public int getStatus() {
		return status;
	}
	public String getStatusString(){
		if(status==STATUS_CONFIREM) return "已处理";
		else return "处理中";
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getOrderid() {
		return orderid;
	}
	public void setOrderid(String orderid) {
		this.orderid = orderid;
	}
	public int getOrdertype() {
		return ordertype;
	}
	public String getOrdertypeString(){
		if(ordertype==ORDERTYPE_TRADE) return "交易订单";
		else if(ordertype==ORDERTYPE_WITHDRAW) return "提现订单";
		else return "未知";
	}
	public void setOrdertype(int ordertype) {
		this.ordertype = ordertype;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBankaccount() {
		return bankaccount;
	}
	public void setBankaccount(String bankaccount) {
		this.bankaccount = bankaccount;
	}
	public String getBankdeposit() {
		return bankdeposit;
	}
	public void setBankdeposit(String bankdeposit) {
		this.bankdeposit = bankdeposit;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getBanknumber() {
		return banknumber;
	}
	public void setBanknumber(String banknumber) {
		this.banknumber = banknumber;
	}
	public double getCoin() {
		return coin;
	}
	public void setCoin(double coin) {
		this.coin = coin;
	}
	public long getCtime() {
		return ctime;
	}
	public String getCtimeString(){
		return TimeUtil.fromUnixTime(ctime);
	}
	public void setCtime(long ctime) {
		this.ctime = ctime;
	}
	
}
