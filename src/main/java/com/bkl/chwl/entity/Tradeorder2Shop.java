package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;
import com.km.common.utils.TimeUtil;

@TableAonn(tableName="tradeorder")
public class Tradeorder2Shop extends Tradeorder{
	private long shop_id;
	private String shop_title;
	private String shop_detail;
	private double shop_oprice;
	private double shop_price;
	private String shop_image;
	private String username;
	
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
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
	public String getShop_detail() {
		return shop_detail;
	}
	public void setShop_detail(String shop_detail) {
		this.shop_detail = shop_detail;
	}
	public double getShop_oprice() {
		return shop_oprice;
	}
	public void setShop_oprice(double shop_oprice) {
		this.shop_oprice = shop_oprice;
	}
	public double getShop_price() {
		return shop_price;
	}
	public void setShop_price(double shop_price) {
		this.shop_price = shop_price;
	}
	public String getShop_image() {
		return shop_image;
	}
	public void setShop_image(String shop_image) {
		this.shop_image = shop_image;
	}
}
