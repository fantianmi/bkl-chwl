package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;

@TableAonn(tableName="user")
public class User2Shop extends User{
	private long shop_id;
	private String shop_title;
	public long getShop_id() {
		return shop_id;
	}
	public void setShop_id(long shop_id) {
		this.shop_id = shop_id;
	}
	public String getShop_title() {
		return shop_title;
	}
	public void setShop_title(String shop_title) {
		this.shop_title = shop_title;
	}
	
	
}
