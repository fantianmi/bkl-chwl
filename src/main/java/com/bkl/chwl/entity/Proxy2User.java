package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;
import com.km.common.utils.TimeUtil;

@TableAonn(tableName="area")
public class Proxy2User extends Area{
	private String mobile;
	private long uid;
	private long parent;
	private String name;
	private long ctime;
	public String getMobile() {
		return mobile;
	}
	
	public long getParent() {
		return parent;
	}

	public void setParent(long parent) {
		this.parent = parent;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public long getUid() {
		return uid;
	}
	public void setUid(long uid) {
		this.uid = uid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
