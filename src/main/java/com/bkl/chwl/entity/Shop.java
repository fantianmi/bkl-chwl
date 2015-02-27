package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;

@TableAonn(tableName="shop")
public class Shop {
	private long id;
	private String title;
	private String detail;
	private String shop_map;
	private int shop_collect;
	private int shop_like;
	private String shop_loc;
	private String shop_tel;
	private int local;
	private int local2;
	private int local3;
	private long uid;
	private long ctime;
	public static final int SORT_DEFAULT=0;
	public static final int SORT_TIME=1;
	public static final int SORT_HOT=2;
	public static final int SORT_SELLNUM=3;
	public static final int SORT_PRICE=4;
	public static final int SORT_DISCOUNT=5;
	private int shop_sellnum;
	private int shop_type;
	private int shop_type2;
	private int qrCode;
	private String image;
	private double price;
	private double oprice;
	private double coinRate;
	//商户资料填写情况 默认为0，填写完成为1
	private int regstatus;
	//商户是否允许展示审核
	private int vertifystatus;
	//商户自己隐藏店铺
	private int shopstatus;
	
	public static int REGSTATUS_TRUE=1;
	public static int REGSTATUS_FALSE=0;
	public static int VERTIFYSTATUS_TRUE=1;
	public static int VERTIFYSTATUS_FALSE=0;
	public static int SHOPSTATUS_SHOW=1;
	public static int SHOPSTATUS_HIDE=0;
	
	public int getShopstatus() {
		return shopstatus;
	}
	public String getShopstatusString() {
		if(shopstatus==this.SHOPSTATUS_HIDE){
			return "隐藏";
		}else if(shopstatus==this.SHOPSTATUS_SHOW){
			return "显示中";
		}
		return "未设置";
	}
	public void setShopstatus(int shopstatus) {
		this.shopstatus = shopstatus;
	}
	public int getVertifystatus() {
		return vertifystatus;
	}
	public void setVertifystatus(int vertifystatus) {
		this.vertifystatus = vertifystatus;
	}
	public int getRegstatus() {
		return regstatus;
	}
	public void setRegstatus(int regstatus) {
		this.regstatus = regstatus;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public double getOprice() {
		return oprice;
	}
	public void setOprice(double oprice) {
		this.oprice = oprice;
	}
	public double getCoinRate() {
		return coinRate;
	}
	public void setCoinRate(double coinRate) {
		this.coinRate = coinRate;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getShop_sellnum() {
		return shop_sellnum;
	}
	public void setShop_sellnum(int shop_sellnum) {
		this.shop_sellnum = shop_sellnum;
	}
	public int getShop_type() {
		return shop_type;
	}
	public void setShop_type(int shop_type) {
		this.shop_type = shop_type;
	}
	public int getShop_type2() {
		return shop_type2;
	}
	public void setShop_type2(int shop_type2) {
		this.shop_type2 = shop_type2;
	}
	public int getQrCode() {
		return qrCode;
	}
	public void setQrCode(int qrCode) {
		this.qrCode = qrCode;
	}
	public int getShop_collect() {
		return shop_collect;
	}
	public void setShop_collect(int shop_collect) {
		this.shop_collect = shop_collect;
	}
	public int getShop_like() {
		return shop_like;
	}
	public void setShop_like(int shop_like) {
		this.shop_like = shop_like;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getShop_map() {
		return shop_map;
	}
	public void setShop_map(String shop_map) {
		this.shop_map = shop_map;
	}
	public String getShop_loc() {
		return shop_loc;
	}
	public void setShop_loc(String shop_loc) {
		this.shop_loc = shop_loc;
	}
	public String getShop_tel() {
		return shop_tel;
	}
	public void setShop_tel(String shop_tel) {
		this.shop_tel = shop_tel;
	}
	public int getLocal() {
		return local;
	}
	public void setLocal(int local) {
		this.local = local;
	}
	public int getLocal2() {
		return local2;
	}
	public void setLocal2(int local2) {
		this.local2 = local2;
	}
	public int getLocal3() {
		return local3;
	}
	public void setLocal3(int local3) {
		this.local3 = local3;
	}
	public long getUid() {
		return uid;
	}
	public void setUid(long uid) {
		this.uid = uid;
	}
	public long getCtime() {
		return ctime;
	}
	public void setCtime(long ctime) {
		this.ctime = ctime;
	}
}
