package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;
/**
 * 银行行号信息表
 * @author chaozheng
 *
 */
@TableAonn(tableName = "bankinfo")
public class BankInfo {
	/***
	 * 主键.目前也用作订单号.
	 */
	private int id;
	
	private String bankName;
	private String bankNumber;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getBankName() {
		return bankName;
	}
	public void setBankName(String bankName) {
		this.bankName = bankName;
	}
	public String getBankNumber() {
		return bankNumber;
	}
	public void setBankNumber(String bankNumber) {
		this.bankNumber = bankNumber;
	}
	
	
}