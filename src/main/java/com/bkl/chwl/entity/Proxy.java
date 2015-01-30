package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;

/**
 * 代理表
 * @author mao
 *
 */
@TableAonn(tableName="proxy")
public class Proxy {
	private long id;
	private long uid;
	private long aid;
	private long ctime;
	private long parent;
	//代理类型 1-城市代理 2-区域代理
	private int proxytype;
	public static int PROXYTYPE_CITY=0;
	public static int PROXYTYPE_AREA=1;
	
	public long getParent() {
		return parent;
	}
	public void setParent(long parent) {
		this.parent = parent;
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
	public long getAid() {
		return aid;
	}
	public void setAid(long aid) {
		this.aid = aid;
	}
	public long getCtime() {
		return ctime;
	}
	public void setCtime(long ctime) {
		this.ctime = ctime;
	}
	public int getProxytype() {
		return proxytype;
	}
	public void setProxytype(int proxytype) {
		this.proxytype = proxytype;
	}
	
}
