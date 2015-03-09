package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;
/**
 * 银行卡绑定
 * @author mao
 *
 */
@TableAonn(tableName="userbindcard")
public class UserBindCard {
	private long id;
	//银行
	private String bank_o;
	//银行卡号
	private String bank_account_o;
	//开户行
	private String bank_deposit_o;
	//开户行行号（民生银行清算系统需要）
	private String bank_number_o;
	//银行预留手机
	private String phone_o;
	//默认卡
	private int isdefault;
	//用户id
	private long uid;
	//对公/对私 绑卡类型
	private int bindtype;
	
	public static final int BINDTYPE_PUBLIC=2;
	public static final int BINDTYPE_PRIVATE=1;
	public static final int DEFAULT_TRUE=1;
	public static final int DEFAULT_FALSE=0;
	
	
	public int getBindtype() {
		return bindtype;
	}
	public void setBindtype(int bindtype) {
		this.bindtype = bindtype;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	
	public String getBank_o() {
		return bank_o;
	}
	public void setBank_o(String bank_o) {
		this.bank_o = bank_o;
	}
	public String getBank_account_o() {
		return bank_account_o;
	}
	public void setBank_account_o(String bank_account_o) {
		this.bank_account_o = bank_account_o;
	}
	public String getBank_deposit_o() {
		return bank_deposit_o;
	}
	public void setBank_deposit_o(String bank_deposit_o) {
		this.bank_deposit_o = bank_deposit_o;
	}
	public String getPhone_o() {
		return phone_o;
	}
	public void setPhone_o(String phone_o) {
		this.phone_o = phone_o;
	}
	public long getUid() {
		return uid;
	}
	public void setUid(long uid) {
		this.uid = uid;
	}
	public int getIsdefault() {
		return isdefault;
	}
	public void setIsdefault(int isdefault) {
		this.isdefault = isdefault;
	}
	public String getBank_number_o() {
		return bank_number_o;
	}
	public void setBank_number_o(String bank_number_o) {
		this.bank_number_o = bank_number_o;
	}
	
}
