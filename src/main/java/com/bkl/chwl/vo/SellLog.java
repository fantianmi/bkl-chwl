package com.bkl.chwl.vo;

import java.math.BigDecimal;

public class SellLog {
	private BigDecimal coin;
	private BigDecimal rcoin;
	private int orderTime;
	private int buyerId;
	private String buyerName;
	private int uid;
	private String id;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public BigDecimal getCoin() {
		return this.coin;
	}

	public void setCoin(BigDecimal coin) {
		this.coin = coin;
	}

	public BigDecimal getRcoin() {
		return this.rcoin;
	}

	public void setRcoin(BigDecimal rcoin) {
		this.rcoin = rcoin;
	}

	public int getOrderTime() {
		return this.orderTime;
	}

	public void setOrderTime(int orderTime) {
		this.orderTime = orderTime;
	}

	public int getBuyerId() {
		return this.buyerId;
	}

	public void setBuyerId(int buyerId) {
		this.buyerId = buyerId;
	}

	public String getBuyerName() {
		return this.buyerName;
	}

	public void setBuyerName(String buyerName) {
		this.buyerName = buyerName;
	}

	public int getUid() {
		return this.uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}
}