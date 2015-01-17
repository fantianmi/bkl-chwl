package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;

@TableAonn(tableName="shopcollect")
public class ShopCollect {
	private long id;
	private long uid;
	private long sid;
	public ShopCollect(){
		
	}
	public ShopCollect(long uid,long sid){
		this.uid=uid;
		this.sid=sid;
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
	public long getSid() {
		return sid;
	}
	public void setSid(long sid) {
		this.sid = sid;
	}
	
}
