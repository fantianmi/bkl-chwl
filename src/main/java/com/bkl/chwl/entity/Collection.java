package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;

@TableAonn(tableName="collection")
public class Collection {
	private long id;
	private long sid;
	private long uid;
	private long ctime;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getSid() {
		return sid;
	}
	public void setSid(long sid) {
		this.sid = sid;
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
