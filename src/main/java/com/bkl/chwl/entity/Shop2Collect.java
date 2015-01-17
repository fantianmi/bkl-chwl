package com.bkl.chwl.entity;

import com.km.common.dao.TableAonn;

@TableAonn(tableName="shop")
public class Shop2Collect extends Shop{
	private long collect_id;
	private long collect_uid;
	private long collect_sid;
	public long getCollect_id() {
		return collect_id;
	}
	public void setCollect_id(long collect_id) {
		this.collect_id = collect_id;
	}
	public long getCollect_uid() {
		return collect_uid;
	}
	public void setCollect_uid(long collect_uid) {
		this.collect_uid = collect_uid;
	}
	public long getCollect_sid() {
		return collect_sid;
	}
	public void setCollect_sid(long collect_sid) {
		this.collect_sid = collect_sid;
	}
	
	
}
